idf_component_register(
    SRCS "sniffer.c"
    INCLUDE_DIRS "." "interface"
    REQUIRES esp_event esp_wifi nvs_flash
)
