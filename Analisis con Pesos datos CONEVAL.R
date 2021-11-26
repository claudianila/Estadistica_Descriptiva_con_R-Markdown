#Código que trabaja con pesos muestrales de los datos
#de Coneval
#Basado en: https://federicovegetti.github.io/teaching/heidelberg_2018/lab/sst_lab_day2.html

#Carga de datos
pobreza <- read.csv("./Data/pobreza_20.csv")


#Tomado de Pobreza_2020_CONEVAL.R 
#de la descarga de datos en R de CONEVAL
#https://www.coneval.org.mx/Medicion/MP/Documents/Programas_calculo_pobreza_MMP_20/R_MMP_2020.zip


# Tabulados básicos 

#############################################
#      RESULTADOS A NIVEL NACIONAL          #
#############################################
# Se instalan los paquetes y librerías a utilizar en el programa
if (!require(pacman)) install.packages("pacman")
library(pacman) ; p_load("data.table", "tidyverse", "gdata", "srvyr", "bit64")

pob_w <- as_survey_design(pobreza, weights=factor, nest=TRUE) %>% srvyr::filter(!is.na(pobreza))

vars  <- colnames(select(pob_w, pobreza, pobreza_m, pobreza_e, vul_car, vul_ing, 
                         no_pobv, carencias, carencias3, ic_rezedu, ic_asalud, 
                         ic_segsoc, ic_cv, ic_sbv, ic_ali_nc, plp_e, plp))

por <- as.data.frame(matrix(unlist(pob_w %>% 
                                     srvyr::select(all_of(vars)) %>%
                                     summarise_all(survey_mean, vartype=NULL)), ncol = 1, byrow=T)*100) %>% round(1)

tot <- as.data.frame(matrix(unlist(pob_w %>% 
                                     srvyr::select(all_of(vars)) %>%
                                     summarise_all(survey_total, vartype=NULL)), ncol =1 , byrow=T) / 1000000)

nac <- bind_cols(por, tot)
rownames(nac) <- c("pobreza", "pobreza_m", "pobreza_e", "vul_car", "vul_ing", "no_pobv", 
                   "carencias", "carencias3", "ic_rezedu", "ic_asalud", "ic_segsoc", 
                   "ic_cv", "ic_sbv", "ic_ali_nc", "plp_e", "plp")

colnames(nac) <- c("Porcentaje", "Millones de personas")
nac


################################################################################
# PORCENTAJE Y NÚMERO DE PERSONAS POR INDICADOR DE POBREZA, ENTIDAD FEDERATIVA #
################################################################################
vars  <- colnames(select(pob_w, pobreza, pobreza_m, pobreza_e, vul_car, vul_ing, no_pobv))

pob_ent_por <- as.data.frame(pob_w %>% group_by(ent) %>% srvyr::select(vars) %>%
                               summarise_all(survey_mean, vartype=NULL))

pob_ent_tot <- as.data.frame(pob_w %>% group_by(ent) %>% srvyr::select(vars) %>%
                               summarise_all(survey_total, vartype=NULL))

pob_ent_por ; pob_ent_tot
pob_ent <- left_join(pob_ent_por, pob_ent_tot, by = "ent")
##########################################################################################
# PORCENTAJE Y NÚMERO DE PERSONAS POR INDICADOR DE CARENCIA SOCIAL, ENTIDAD FEDERATIVA   #
##########################################################################################
vars  <- colnames(select(pob_w, ic_rezedu, ic_asalud, ic_segsoc, ic_cv, ic_sbv,
                         ic_ali_nc,carencias, carencias3, plp_e, plp))

care_ent_por <- as.data.frame(pob_w %>% group_by(ent) %>% srvyr::select(vars) %>%
                                summarise_all(survey_mean, vartype=NULL))

care_ent_tot <- as.data.frame(pob_w %>% group_by(ent) %>% srvyr::select(vars) %>%
                                summarise_all(survey_total, vartype=NULL))
care_ent_por ; care_ent_tot

pob_ent <- left_join(pob_ent, care_ent_por, by = "ent") %>% left_join(care_ent_tot, by = "ent")

fwrite(pob_ent, "Bases/pob_ent.csv", row.names=F)
