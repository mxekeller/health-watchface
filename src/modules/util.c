#include "util.h"

struct tm* util_get_tm() {
  time_t temp = time(NULL); 
  return localtime(&temp);
}

void locale_init() {
  setlocale(LC_TIME, i18n_get_system_locale());
}
