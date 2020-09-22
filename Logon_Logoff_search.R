# This script explores logon/logoff activity in Avail databases.

### Revision History ###

# 1/17/20 - Changed data for Tim's most recent operators.

# 1/24/20 - New operators from Tim.

# 1/28/20 - New operators for Tim, in three phases:

# 3/19/20 - Tim wants to know last log-in date for all operators.

# 4/6/20 - new operators for Tim. Don't use Transit_Authority

# 4/10/20 - Tim want's to know how many operators, from his universal list,
#           logged into RL b/w 9/1 and 12/31

# 4/24/20 - New opertors from Tim. Cleaned up code a little bit. Commented out old code.
#           (This is because part of old script relied on production copy, which
#           will always be out of date)

# 5/4/20  - New operators from Tim.

# 5/14/20 - Tim want's review of just Brenda Evans 1590 - "Can you see what days she has logged on to the 90?"

# 5/19/20 - Same as above, but for 9069.

# 5/26/20 - Same as above, but for 9762 and 9486

# 5/28/20 - new request from Ops for RL laundry list.

# 6/15/20 - TC wants to know operators who have not logged onto 90 block after February 2020.
#         - UPDATE: TC wants to know, from a list of operators, who did not log on before 2/2020.

# 6/16/20 - TJ wants to see all days logged by 9286.

# 7/10/20 - TJ wants 9694

# 8/10/20 - TJ wants 9233.

# 8/24/20 - TJ wants 8641.

###

library(tidyverse)

# con <- DBI::dbConnect(odbc::odbc(), Driver = "SQL Server", Server = "REPSQLP01VW", 
#                       Database = "TransitAuthority_IndyGo_Reporting", 
#                       Port = 1433)
# 
# # get avl.Logon_History
# 
# Logon_History_raw <- tbl(con, dbplyr::in_schema("avl", "Logon_History")) %>%
#   collect()
# 
# str(Logon_History_raw)
# 
# View(Logon_History_raw ) # hm. this seems to only include data from 9/20 to the replcate update (in present case 4/2)
# 
# # Get vehicle info
# 
# Vehicle_Info_raw <- tbl(con, "Vehicle_Info") %>% collect()
# 
# # get run info (need to connect to blocks)
# 
# 
# 
# # Get employee info
# 
# User_raw <- tbl(con, "User") %>%
#   collect()
# 
# Operators_raw <- tbl(con, "Operator_Info") %>%
#   collect()
# 
# # Tim, right now, just needs the following employees:
# 
# str(User_raw )
# 
# User_Tim <- User_raw %>% 
#   filter(LogonID %in% c(
#     9355, 
#     8462, 
#     8555, 
#     8954, 
#     2759, 
#     8371, 
#     1146, 
#     8547, 
#     8642, 
#     8269, 
#     3334, 
#     8125, 
#     8939, 
#     9272, 
#     2277, 
#     8904, 
#     9104, 
#     8641, 
#     9265, 
#     3395, 
#     9230, 
#     8844, 
#     9079, 
#     9320, 
#     9204, 
#     9266, 
#     4538, 
#     8605, 
#     8701, 
#     9101, 
#     8620, 
#     8634, 
#     5911, 
#     8986, 
#     9385, 
#     9388, 
#     6300, 
#     1975, 
#     6014, 
#     9248, 
#     9274, 
#     8557, 
#     9098, 
#     9306, 
#     8840, 
#     9023, 
#     9483, 
#     9502, 
#     9008, 
#     8275, 
#     8481, 
#     9394, 
#     5154, 
#     9131, 
#     9314, 
#     9400, 
#     9413, 
#     8445, 
#     1021, 
#     8706, 
#     9433, 
#     8859, 
#     9069, 
#     9271, 
#     8589, 
#     9441, 
#     8128, 
#     8941, 
#     9043, 
#     4840, 
#     9454, 
#     8961, 
#     9414, 
#     8944, 
#     9602, 
#     6710, 
#     9012, 
#     8908, 
#     9119, 
#     8623, 
#     9027, 
#     9291, 
#     9509, 
#     9607, 
#     8626, 
#     9011, 
#     9386, 
#     9620, 
#     9671, 
#     9673, 
#     9643, 
#     9667, 
#     8234, 
#     8388, 
#     8794, 
#     9553, 
#     9662, 
#     9276, 
#     9640, 
#     9652, 
#     9659, 
#     9407, 
#     9613, 
#     9642, 
#     9649, 
#     9654, 
#     9003, 
#     9563, 
#     9264, 
#     9329, 
#     9374, 
#     9401, 
#     9638, 
#     9647, 
#     9710, 
#     8185, 
#     9423, 
#     9482, 
#     9493, 
#     9577, 
#     2338, 
#     5139, 
#     6979, 
#     8174, 
#     8191, 
#     8325, 
#     8424, 
#     8688, 
#     8832, 
#     9410, 
#     9558, 
#     9579, 
#     9604, 
#     9609, 
#     8953, 
#     9287, 
#     9294, 
#     9379, 
#     9487, 
#     9532, 
#     9552, 
#     9559, 
#     8399, 
#     8650, 
#     9383, 
#     9105, 
#     9325, 
#     3400, 
#     9228, 
#     9302, 
#     9411, 
#     9431, 
#     9585, 
#     9372, 
#     9568, 
#     9072, 
#     9054, 
#     9582, 
#     1190, 
#     8673, 
#     5148, 
#     9537, 
#     9554, 
#     9477, 
#     9571, 
#     9601, 
#     9362, 
#     9445, 
#     9538, 
#     9542, 
#     9574, 
#     9175, 
#     9435, 
#     9557, 
#     8967, 
#     9174, 
#     9523, 
#     9539, 
#     8719, 
#     9242, 
#     9437, 
#     9528, 
#     9632, 
#     9191, 
#     9295, 
#     9416, 
#     9436, 
#     8903, 
#     9565, 
#     9576, 
#     9026, 
#     9268, 
#     9480, 
#     9600, 
#     9606, 
#     8504, 
#     9382, 
#     9443, 
#     9536, 
#     9596, 
#     9046, 
#     9096, 
#     9284, 
#     9352, 
#     9452, 
#     9520, 
#     9622, 
#     8376, 
#     8968, 
#     9075, 
#     9102, 
#     9346, 
#     9376, 
#     9417, 
#     9432, 
#     9524, 
#     8421, 
#     8482, 
#     9164, 
#     9286, 
#     9326, 
#     9387, 
#     9390, 
#     9409, 
#     9448, 
#     9495, 
#     9500, 
#     9505, 
#     9519, 
#     9533, 
#     9575, 
#     9621, 
#     1590, 
#     8353, 
#     9071, 
#     9226, 
#     9391, 
#     9545, 
#     9555, 
#     9617, 
#     9113, 
#     9194, 
#     9344, 
#     9373, 
#     9438, 
#     9473, 
#     9498, 
#     9526, 
#     9560, 
#     9581, 
#     9584, 
#     9603, 
#     9612, 
#     9653, 
#     9661, 
#     9682, 
#     9685, 
#     9688, 
#     9705, 
#     9708, 
#     8576, 
#     8885, 
#     8947, 
#     9018, 
#     9076, 
#     9124, 
#     9232, 
#     9288, 
#     9446, 
#     9450, 
#     9521, 
#     9541, 
#     9566, 
#     9570, 
#     9573, 
#     9619, 
#     9680, 
#     9695, 
#     9699, 
#     9701, 
#     9702, 
#     9707, 
#     9709, 
#     9711, 
#     8636, 
#     8829, 
#     8926, 
#     9205, 
#     9347, 
#     9484, 
#     9489, 
#     9496, 
#     9534, 
#     9580, 
#     9599, 
#     1022, 
#     2163, 
#     2339, 
#     2392, 
#     2979, 
#     3030, 
#     3920, 
#     4650, 
#     6306, 
#     6978, 
#     7291, 
#     8065, 
#     8121, 
#     8243, 
#     8314, 
#     8472, 
#     8492, 
#     8513, 
#     8766, 
#     8809, 
#     8817, 
#     8839, 
#     8891, 
#     8949, 
#     9000, 
#     9092, 
#     9260, 
#     9261, 
#     9292, 
#     9313, 
#     9324, 
#     9442, 
#     9486, 
#     9499, 
#     9564, 
#     9567, 
#     9016, 
#     224, 
#     8473, 
#     8935, 
#     8981, 
#     8444, 
#     5140, 
#     8590, 
#     8392, 
#     8958, 
#     9190, 
#     1016, 
#     8474, 
#     580, 
#     587, 
#     8758, 
#     593, 
#     8723, 
#     8700, 
#     8336, 
#     798, 
#     803, 
#     821, 
#     8591, 
#     869, 
#     9508, 
#     880, 
#     8500, 
#     8983, 
#     8937, 
#     8091, 
#     9082, 
#     9668, 
#     8665, 
#     9225, 
#     1417, 
#     8860, 
#     8356, 
#     8497, 
#     8523, 
#     1739, 
#     8666, 
#     8815, 
#     1963, 
#     8502, 
#     1981, 
#     8321, 
#     1500, 
#     9165, 
#     8465, 
#     8764, 
#     9301, 
#     2451, 
#     9605, 
#     8667, 
#     2545, 
#     8938, 
#     2581, 
#     9081, 
#     8858, 
#     8639, 
#     9156, 
#     6933, 
#     8681, 
#     9285, 
#     8430, 
#     8141, 
#     9033, 
#     8451, 
#     2877, 
#     9087, 
#     8213, 
#     8739, 
#     8487, 
#     8423, 
#     9732, 
#     8640, 
#     9120, 
#     9666, 
#     9041, 
#     9195, 
#     8727, 
#     8192, 
#     9384, 
#     9492, 
#     8400, 
#     3795, 
#     9233, 
#     3742, 
#     8600, 
#     9163, 
#     8950, 
#     8635, 
#     8651, 
#     8810, 
#     9569, 
#     8105, 
#     9106, 
#     3968, 
#     8875, 
#     4142, 
#     9683, 
#     8627, 
#     8367, 
#     8218, 
#     4405, 
#     8313, 
#     9497, 
#     8517, 
#     4612, 
#     8040, 
#     9412, 
#     9690, 
#     9650, 
#     9631, 
#     9687, 
#     5094, 
#     5109, 
#     8488, 
#     8194, 
#     9692, 
#     8972, 
#     8428, 
#     9670, 
#     6144, 
#     9639, 
#     1035, 
#     9245, 
#     5447, 
#     9665, 
#     9151, 
#     8907, 
#     8456, 
#     5640, 
#     9684, 
#     8277, 
#     9474, 
#     8629, 
#     9304, 
#     5776, 
#     8722, 
#     9645, 
#     8741, 
#     8534, 
#     8577, 
#     9598, 
#     9290, 
#     8630, 
#     5948, 
#     5944, 
#     5963, 
#     8656, 
#     9648, 
#     9111, 
#     6655, 
#     9694, 
#     6160, 
#     8271, 
#     6418, 
#     8263, 
#     9693, 
#     9675, 
#     6538, 
#     8946, 
#     6709, 
#     8389, 
#     6780, 
#     6792, 
#     8117, 
#     8493
#   ))
# 
# # Operators_Tim <- Operators_raw %>%
# #   filter() # come back to this.
# 
# # get logon history for Tim's users.
# 
# Tim_Logon_History <- Logon_History_raw %>%
#   filter(Operator_Record_Id %in% User_Tim$ID) %>%
#   left_join(User_Tim, by = c("Operator_Record_Id" = "ID"))
# 
# View(Tim_Logon_History)
# 
# # so.... it LOOKs like Run is Block, here. lol.
# 
# # Filter for Run starts with 90.
# 
# Tim_Logon_History_90 <-  Tim_Logon_History%>%
#   filter(str_detect(Run_Id, "^90")) 
# 
# View(Tim_Logon_History_90)
# 
# str(Tim_Logon_History_90)
# 
# Tim_Logon_History_90$Date <- as.Date(Tim_Logon_History_90$Logon)
# 
# # now get most recent date for each 
# 
# Tim_Logon_History_90 %>%
#   group_by(LogonID, ReportLabel) %>%
#   arrange(desc(Date)) %>%
#   summarise(Last_Logon = first(Date),
#             Days_Since_Last_Logon = as.Date(Sys.time())- first(Date)) %>%
#   arrange(Days_Since_Last_Logon)
# 
# # get for each operator
# 
# Logon_History_raw %>%
#   left_join(User_Tim, by = c("Operator_Record_Id" = "ID")) %>%
#   mutate(Date = as.Date(Logon)) %>%
#   group_by(LogonID, ReportLabel,Run_Id, Vehicle_Record_Id) %>%
#   arrange(desc(Date)) %>%
#   summarise(Last_Logon = first(Date),
#             Days_Since_Last_Logon = as.Date(Sys.time())- first(Date)) %>%
#   arrange(ReportLabel, Run_Id) %>%
#   left_join(Vehicle_Info_raw, by = c("Vehicle_Record_Id")) %>%
#   View()
# 
# Logon_History_raw %>% # for 90 blocks, with vehicle info
#   filter(str_detect(Run_Id, "^90")) %>%
#   left_join(User_Tim, by = c("Operator_Record_Id" = "ID")) %>%
#   mutate(Date = as.Date(Logon)) %>%
#   group_by(LogonID, ReportLabel,Run_Id, Vehicle_Record_Id) %>%
#   arrange(desc(Date)) %>%
#   summarise(Last_Logon = first(Date),
#             Days_Since_Last_Logon = as.Date(Sys.time())- first(Date)) %>%
#   arrange(ReportLabel, Run_Id) %>%
#   left_join(Vehicle_Info_raw, by = c("Vehicle_Record_Id")) %>%
#   View()
# 
# Logon_History_raw %>% # for 90 blocks,, all users
#   filter(str_detect(Run_Id, "^90")) %>%
#   left_join(User_raw, by = c("Operator_Record_Id" = "ID")) %>%
#   mutate(Date = as.Date(Logon)) %>%
#   group_by(LogonID, ReportLabel) %>%
#   arrange(desc(Date)) %>%
#   summarise(Last_Logon = first(Date),
#             Days_Since_Last_Logon = as.Date(Sys.time())- first(Date)) %>%
#   arrange(ReportLabel) %>%
#   View()

# let's also look in the data warehouse.

con2 <- DBI::dbConnect(odbc::odbc(), Driver = "SQL Server", Server = "AVAILDWHP01VW",
                       Database = "DW_IndyGo",
                       Port = 1433)

DimEventType <- tbl(con2, "DimEventType") %>% collect()

DimEventType_search <- DimEventType %>%
  filter(EventTypeKey %in% c(1047, 1100, 1101)) 

DimRoute <- tbl(con2, "DimRoute") %>% collect()

DimUser <- tbl(con2, "DimUser")

# get, review operative dates

# DimDate_Tim <- tbl(con2, "DimDate") %>% 
#   filter(between(CalendarDate, "2019-09-01", "2019-12-31")) %>%
#   collect()
# 
# View(DimDate_Tim)

# now get FACTS

FactEvent_90 <- tbl(con2, "FactEvent") %>%
  filter(EventTypeKey %in% c(1047, 1100, 1101),
         RouteKey %in% c(1239, 1274, 1306)) %>% 
  collect()

# # join operators
# 
# nrow(FactEvent_90)
# 
# str(FactEvent_90)
# 
# # ug....
# 
# FactEvent_90 <- tbl(con2, "FactEvent") %>%
#   filter(RouteKey %in% c(1239, 1274, 1306)) %>% 
#   collect()
# 
# nrow(FactEvent_90)

# ugh..

# OH! route is no good.

# try blocks.

DimBlock <- tbl(con2, "DimBlock") %>%
  collect()

DimBlock_90 <- DimBlock %>%
  filter(str_detect(BlockFareboxID, "^90"))

# now do it

FactEvent_90 <- tbl(con2, "FactEvent") %>%
  filter(EventTypeKey %in% c(1047, 1100, 1101),
         BlockKey %in% !!DimBlock_90$BlockKey) %>% 
  collect()

# FactEvent_90_2019 <- tbl(con2, "FactEvent") %>%
#   filter(EventTypeKey %in% c(1047, 1100, 1101),
#          BlockKey %in% !!DimBlock_90$BlockKey,
#          DateKey %in% !!DimDate_Tim$DateKey) %>% 
#   collect()

nrow(FactEvent_90) # OK! a little better!
# nrow(FactEvent_90_2019)

FactEvent_90 %>%
  left_join(DimEventType, by = "EventTypeKey") %>%
  View()

library(magrittr)

FactEvent_90 %>%
  left_join(DimEventType, by = "EventTypeKey") %$%
  sort(unique(EventLongName)) # looks good.

# join operators..

DimUser <- tbl(con2, "DimUser") %>% collect()
  
FactEvent_90 %>%
  left_join(DimEventType, by = "EventTypeKey") %>%
  left_join(DimUser, by = c("OperatorUserKey" = "UserKey")) %>% # I don't actually know if this is a good join
  View()

FactEvent_90 %>% # for all operators
  left_join(DimEventType, by = "EventTypeKey") %>%
  left_join(DimUser, by = c("OperatorUserKey" = "UserKey")) %>% # I don't actually know if this is a good join
  mutate(Date = as.Date(EventDateTime)) %>%
  group_by(LogonID, UserReportLabel) %>%
  arrange(desc(Date)) %>%
  summarise(Last_Logon = first(Date),
            Days_Since_Last_Logon = as.Date(Sys.time())- first(Date)) %>%
  arrange(UserReportLabel) %>%
  View()

User_Tim <- DimUser %>%
  filter(LogonID %in% c(8275, 
                        6160, 
                        8325, 
                        8421, 
                        8492, 
                        8839, 
                        8641, 
                        8908, 
                        6014, 
                        8399, 
                        8681, 
                        8128, 
                        2392, 
                        6655, 
                        8234, 
                        8589, 
                        8673, 
                        8719, 
                        8766, 
                        8794, 
                        8859, 
                        6306, 
                        8353, 
                        8623, 
                        8829, 
                        8885, 
                        8903, 
                        8926, 
                        8938, 
                        8944, 
                        8968, 
                        8981, 
                        8986, 
                        9018, 
                        9075, 
                        9096, 
                        9076, 
                        9101, 
                        9102, 
                        9175, 
                        9174, 
                        8641, 
                        8906, 
                        2979, 
                        9124, 
                        9071, 
                        9119, 
                        9071, 
                        8947, 
                        9124, 
                        3400, 
                        2979, 
                        5148, 
                        8627, 
                        8105, 
                        7291, 
                        1590, 
                        8421, 
                        8472, 
                        8891, 
                        9000, 
                        9072, 
                        9079, 
                        8815, 
                        9232, 
                        9268, 
                        9284, 
                        9346, 
                        9205, 
                        9228, 
                        9242, 
                        9288, 
                        9299, 
                        9302, 
                        9326, 
                        9320, 
                        9324, 
                        9347, 
                        8908, 
                        9194, 
                        9230, 
                        9286, 
                        9261, 
                        9260, 
                        9373, 
                        9446, 
                        9383, 
                        9414, 
                        9452, 
                        8547, 
                        9394, 
                        9417, 
                        8839, 
                        9027, 
                        8547
  ))

Tim_Operators <- FactEvent_90 %>% # NOTE df change # for Tim's operators-- this is it. (but remove starting zeros)
  left_join(DimEventType, by = "EventTypeKey") %>%
  left_join(DimUser, by = c("OperatorUserKey" = "UserKey")) %>% 
  mutate(Date = as.Date(EventDateTime)) %>%
  filter(LogonID %in% User_Tim$LogonID)%>%
  mutate(LogonID = as.character(LogonID)) %>%
  group_by(LogonID, UserReportLabel) %>%
  arrange(desc(Date)) %>%
  summarise(Last_Logon = first(Date),
            Days_Since_Last_Logon = as.Date(Sys.time())- first(Date)) %>%
  arrange(desc(Days_Since_Last_Logon)) %>%
  formattable::formattable()

nrow(Tim_Operators)
nrow(User_Tim)
View(Tim_Operators)
Tim_Operators

# export

# write.csv(Tim_Operators, "20200424_Last_90_Block_Logon.csv",
#           row.names = FALSE)

# get users NOT in dataset. Tim also needs this.

Zero_log_ons <- User_Tim %>%
  mutate(LogonID = as.character(LogonID)) %>%
  anti_join(Tim_Operators, by = "LogonID") %>%
  select(LogonID, Name = UserReportLabel) %>%
  arrange(Name) %>%
  formattable::formattable()

Zero_log_ons

nrow(Zero_log_ons)

# write.csv(Zero_log_ons, "20200424_No_90_Block_Logon.csv",
#           row.names = FALSE)

# # let's confirm this. search for these folks in raw adherence data.
# 
# Zero_log_ons_raw <- User_Tim %>%
#   anti_join(Tim_Operators, by = "LogonID") %>%
#   left_join(DimUser, by = )
# 
# Zero_log_ons_raw_adherence_history <- tbl(con2, "FactTimepointAdherence") %>%
#   filter(UserKey %in% !!Zero_log_ons_raw$) # update: Tim said he didn't need this

# not all operators are there... check.

# FactEvent_90 %>% # 
#   left_join(DimEventType, by = "EventTypeKey") %>%
#   left_join(DimUser, by = c("OperatorUserKey" = "UserKey")) %>% # I don't actually know if this is a good join
#   mutate(Date = as.Date(EventDateTime)) %>%
#   filter(LogonID %in% c(9242,
#                         9442,
#                         9373,
#                         9391,
#                         9452,
#                         9288,
#                         9261,
#                         9431,
#                         9443,
#                         9484) ) %>%
#   distinct(UserReportLabel) # there was an error in DimUser collection-- since corrected!

### 3/19/20 ###

# Get last logon to 90 block for all operators

All_Operators <- FactEvent_90 %>% # for all operators-- this is it.
  left_join(DimEventType, by = "EventTypeKey") %>%
  left_join(DimUser, by = c("OperatorUserKey" = "UserKey")) %>% 
  filter(IsActive == 1) %>% # new wrinkle
  mutate(Date = as.Date(EventDateTime)) %>%
  group_by(LogonID, UserReportLabel) %>%
  arrange(desc(Date)) %>%
  summarise(Last_Logon = first(Date),
            Days_Since_Last_Logon = as.Date(Sys.time())- first(Date)) %>%
  arrange(desc(Days_Since_Last_Logon)) %>%
  formattable::formattable()

All_Operators

# get users NOT in dataset. Tim also needs this.

Zero_log_ons <- DimUser %>%
  filter(OperatorDesc == "Operator", IsActive == 1) %>%
  anti_join(All_Operators, by = "LogonID") %>%
  select(LogonID, Name = UserReportLabel) %>%
  filter(!LogonID %in% c(1960, 9999, 7777, 1111)) %>%
  arrange(Name) %>%
  formattable::formattable()

Zero_log_ons

### 5/14/20 Update ###

# this is for TJ's operators. Use this section when he has a request.

library(tidyverse)

con2 <- DBI::dbConnect(odbc::odbc(), Driver = "SQL Server", Server = "AVAILDWHP01VW",
                       Database = "DW_IndyGo",
                       Port = 1433)

# set TJ's user:

TJ_User <-8641# 9286 # # and 9486

# get data

DimEventType <- tbl(con2, "DimEventType") %>% collect()

DimEventType_search <- DimEventType %>%
  filter(EventTypeKey %in% c(1047, 1100, 1101)) 

DimRoute <- tbl(con2, "DimRoute") %>% collect()

DimUser_TJ <- tbl(con2, "DimUser") %>% 
  filter(LogonID %in% !!TJ_User) %>%
  collect()

all_users <-  tbl(con2, "DimUser") %>% 
  collect()

DimBlock <- tbl(con2, "DimBlock") %>%
  collect()

DimBlock_90 <- DimBlock %>%
  filter(str_detect(BlockFareboxID, "^90"))

# now do it

FactEvent_90 <- tbl(con2, "FactEvent") %>%
  filter(EventTypeKey %in% c(1047, 1100, 1101),
         BlockKey %in% !!DimBlock_90$BlockKey,
         OperatorUserKey %in% !!DimUser_TJ$UserKey) %>% 
  collect()

# confirm that we have good date range

library(magrittr)

FactEvent_90_all <- tbl(con2, "FactEvent") %>%
  filter(EventTypeKey %in% c(1047, 1100, 1101),
         BlockKey %in% !!DimBlock_90$BlockKey) %>% 
  collect()

FactEvent_90_all %>%
  mutate(Date = as.Date(EventDateTime)) %$%
  range(Date) # looks good to me

# FactEvent_90_all %>% # this is a name search, in case there is mismatch b/w name and ID (rare event)
#   left_join(all_users, by = c("OperatorUserKey" = "UserKey")) %>%
#   filter(LastName == "Davidson") %>%
#   View()
# 
# all_users %>%
#   filter(LastName == "Davidson") %>% # hm. not showing up...
#   View()
# 
# rm(FactEvent_90_all)

# FactEvent_90 <- tbl(con2, "FactEvent") %>% # let's review all events for this user, to confirm we have right keys
#   filter(BlockKey %in% !!DimBlock_90$BlockKey,
#          OperatorUserKey %in% !!DimUser_TJ$UserKey) %>% 
#   collect()

# join operators..

FactEvent_90 %>% # for TJ's user
  left_join(DimEventType, by = "EventTypeKey") %>%
  left_join(DimUser_TJ, by = c("OperatorUserKey" = "UserKey")) %>% # I don't actually know if this is a good join
  left_join(DimBlock_90, by = "BlockKey") %>%
  filter(EventTypeKey == 1047) %>% # log-on's only
  mutate(Date = as.Date(EventDateTime)) %>%
  select(Date, LogonID, UserReportLabel, Block = BlockFareboxID, EventLongName) %>%
  arrange(desc(Date)) %>%
  distinct() %>%
  # pivot_wider(., names_from = EventLongName, values_from = EventLongName) %>%
  View()

FactEvent_90 %>% # for TJ's user
  left_join(DimEventType, by = "EventTypeKey") %>%
  left_join(DimUser_TJ, by = c("OperatorUserKey" = "UserKey")) %>% # I don't actually know if this is a good join
  left_join(DimBlock_90, by = "BlockKey") %>%
  # filter(EventTypeKey == 1047) %>% # log-on's only
  mutate(Date = as.Date(EventDateTime)) %>%
  select(Date, LogonID, UserReportLabel, Block = BlockFareboxID, EventLongName) %>%
  arrange(desc(Date)) %>%
  distinct() %>%
  # pivot_wider(., names_from = EventLongName, values_from = EventLongName) %>%
  View()



TJ_Users <- FactEvent_90 %>% # for TJ's user
  left_join(DimEventType, by = "EventTypeKey") %>%
  left_join(DimUser_TJ, by = c("OperatorUserKey" = "UserKey")) %>% # I don't actually know if this is a good join
  left_join(DimBlock_90, by = "BlockKey") %>%
  filter(EventTypeKey == 1047) %>% # log-on's only
  mutate(Date = as.Date(EventDateTime)) %>%
  select(Date, LogonID, UserReportLabel, Block = BlockFareboxID, EventLongName) %>%
  arrange(desc(Date)) %>%
  distinct() %>%
  formattable::formattable()

nrow(TJ_Users)
View(TJ_Users)
TJ_Users

# let's try this a different way.
# instead, get all logons by tim user, regardless of block.
# this way, I can check to see if the block numbers are working...
# *actually* just looking at DimBlock_90, I see that it works.

# let's get all log on's by TJ's user

FactEvent_TJ <- tbl(con2, "FactEvent") %>%
  filter(EventTypeKey %in% c(1047, 1100, 1101),
         OperatorUserKey %in% !!DimUser_TJ$UserKey) %>% 
  collect()

FactEvent_TJ %>%
  left_join(DimEventType, by = "EventTypeKey") %>%
  left_join(DimBlock, by = "BlockKey") %>%
  group_by(BlockFareboxID, EventLongName) %>%
  summarise(n =n()) %>%
  View()


### 6/15/20 Update ###

# Get zero log-ons since 3/1/20

library(tidyverse)

con2 <- DBI::dbConnect(odbc::odbc(), Driver = "SQL Server", Server = "AVAILDWHP01VW",
                       Database = "DW_IndyGo",
                       Port = 1433)

DimEventType <- tbl(con2, "DimEventType") %>% collect()

DimEventType_search <- DimEventType %>%
  filter(EventTypeKey %in% c(1047, 1100, 1101)) 

DimRoute <- tbl(con2, "DimRoute") %>% collect()

DimUser <- tbl(con2, "DimUser") %>% collect()

# get, review operative dates

DimDate_Tim <- tbl(con2, "DimDate") %>%
  filter(CalendarDateChar == "03/01/2020") %>%
  collect()

# try blocks.

DimBlock <- tbl(con2, "DimBlock") %>%
  collect()

DimBlock_90 <- DimBlock %>%
  filter(str_detect(BlockFareboxID, "^90"))

# now do it

FactEvent_90 <- tbl(con2, "FactEvent") %>%
  filter(EventTypeKey %in% c(1047, 1100, 1101),
         BlockKey %in% !!DimBlock_90$BlockKey,
         DateKey >= !!DimDate_Tim$DateKey) %>% 
  collect()

# now see who has not logged in

All_Operators_since_March_1st <- FactEvent_90 %>% # for all operators-- this is it.
  left_join(DimEventType, by = "EventTypeKey") %>%
  left_join(DimUser, by = c("OperatorUserKey" = "UserKey")) %>% 
  filter(IsActive == 1) %>% # new wrinkle
  mutate(Date = as.Date(EventDateTime)) %>%
  group_by(LogonID, UserReportLabel) %>%
  arrange(desc(Date)) %>%
  summarise(Last_Logon = first(Date),
            Days_Since_Last_Logon = as.Date(Sys.time())- first(Date)) %>%
  arrange(desc(Days_Since_Last_Logon)) %>%
  formattable::formattable()

All_Operators_since_March_1st

# get users NOT in dataset. Tim also needs this.

Zero_log_ons_since_March_1st <- DimUser %>%
  filter(OperatorDesc == "Operator", IsActive == 1) %>%
  anti_join(All_Operators_since_March_1st, by = "LogonID") %>%
  select(LogonID, Name = UserReportLabel) %>%
  filter(!LogonID %in% c(1960, 9999, 7777, 1111)) %>%
  arrange(Name) %>%
  formattable::formattable()

Zero_log_ons_since_March_1st

### Second 6/15/20 Update ###

con2 <- DBI::dbConnect(odbc::odbc(), Driver = "SQL Server", Server = "AVAILDWHP01VW",
                       Database = "DW_IndyGo",
                       Port = 1433)

DimDate_Tim <- tbl(con2, "DimDate") %>%
  filter(CalendarDateChar == "02/01/2020") %>%
  collect()

DimUser <- tbl(con2, "DimUser") %>% collect()

User_Tim <- DimUser %>%
  filter(LogonID %in% c(8472,
                        9164,
                        9574,
                        9016,
                        224,
                        9661,
                        9498,
                        8473,
                        8935,
                        9284,
                        9701,
                        9386,
                        8444,
                        5140,
                        9026,
                        6978,
                        9454,
                        9320,
                        8589,
                        9113,
                        9347,
                        8590,
                        9306,
                        9344,
                        9409,
                        9653,
                        9452,
                        9096,
                        8445,
                        8392,
                        9355,
                        8958,
                        9190,
                        8794,
                        1016,
                        8634,
                        8474,
                        8121,
                        580,
                        9407,
                        9560,
                        587,
                        8758,
                        8947,
                        9072,
                        593,
                        9723,
                        8723,
                        9709,
                        9191,
                        9373,
                        8688,
                        8700,
                        9450,
                        8353,
                        9441,
                        9054,
                        9502,
                        9509,
                        8336,
                        9545,
                        9520,
                        9640,
                        9484,
                        798,
                        9483,
                        9410,
                        803,
                        9495,
                        821,
                        8591,
                        9733,
                        869,
                        9508,
                        8174,
                        880,
                        9521,
                        9092,
                        8500,
                        9542,
                        9260,
                        9046,
                        8983,
                        1022,
                        8937,
                        8091,
                        9082,
                        8641,
                        9707,
                        9565,
                        9668,
                        9609,
                        9682,
                        9607,
                        8665,
                        9276,
                        9071,
                        9647,
                        9079,
                        9225,
                        1146,
                        1190,
                        8243,
                        9667,
                        9764,
                        8904,
                        9716,
                        9702,
                        1417,
                        9023,
                        8576,
                        8462,
                        9558,
                        8860,
                        9443,
                        9622,
                        8356,
                        9433,
                        9374,
                        9101,
                        8497,
                        9261,
                        8903,
                        8269,
                        9557,
                        9638,
                        9098,
                        9680,
                        9242,
                        3030,
                        9577,
                        8523,
                        1021,
                        9671,
                        9423,
                        1739,
                        9382,
                        8666,
                        8815,
                        1590,
                        9662,
                        9606,
                        9102,
                        9446,
                        8620,
                        8636,
                        9526,
                        8701,
                        1963,
                        9748,
                        8502,
                        9579,
                        1975,
                        1981,
                        8321,
                        9486,
                        9175,
                        9131,
                        9226,
                        9719,
                        9436,
                        9567,
                        8949,
                        2163,
                        1500,
                        9612,
                        9165,
                        9695,
                        8185,
                        8465,
                        9519,
                        2338,
                        8829,
                        2339,
                        8764,
                        2392,
                        9385,
                        8817,
                        9104,
                        9376,
                        9194,
                        9301,
                        2451,
                        8981,
                        9523,
                        9352,
                        8939,
                        9685,
                        9605,
                        9069,
                        8667,
                        8504,
                        9264,
                        9533,
                        2545,
                        8938,
                        9604,
                        9575,
                        2581,
                        9536,
                        9081,
                        9228,
                        9613,
                        9603,
                        8858,
                        8639,
                        9156,
                        9600,
                        6933,
                        8681,
                        9534,
                        9659,
                        9285,
                        2759,
                        8430,
                        9448,
                        9292,
                        9417,
                        8141,
                        9493,
                        8234,
                        9437,
                        9431,
                        9554,
                        9033,
                        8451,
                        8388,
                        9027,
                        2877,
                        9075,
                        8844,
                        9087,
                        8213,
                        8739,
                        9584,
                        2979,
                        8421,
                        9286,
                        9265,
                        9230,
                        9724,
                        8481,
                        9643,
                        9119,
                        9000,
                        8961,
                        9324,
                        9570,
                        8706,
                        9585,
                        9642,
                        8423,
                        9732,
                        9699,
                        9496,
                        8640,
                        9120,
                        8967,
                        9266,
                        9287,
                        8859,
                        8891,
                        9666,
                        9041,
                        9195,
                        9003,
                        9705,
                        9372,
                        8650,
                        8191,
                        8727,
                        9621,
                        3395,
                        3400,
                        8192,
                        8623,
                        9384,
                        9442,
                        8968,
                        8941,
                        9492,
                        9346,
                        9524,
                        8986,
                        8399,
                        8400,
                        9232,
                        8555,
                        9500,
                        3795,
                        9233,
                        3742,
                        9288,
                        9362,
                        9499,
                        9538,
                        8626,
                        8600,
                        9487,
                        9649,
                        9163,
                        4650,
                        9563,
                        9445,
                        9582,
                        8950,
                        8482,
                        4840,
                        9325,
                        3920,
                        8513,
                        8651,
                        9388,
                        8810,
                        9569,
                        8105,
                        9105,
                        9106,
                        3968,
                        9411,
                        9581,
                        8875,
                        9652,
                        8635,
                        4142,
                        9294,
                        9683,
                        8627,
                        8367,
                        9480,
                        9390,
                        9596,
                        8218,
                        8325,
                        9731,
                        4405,
                        8809,
                        8313,
                        9497,
                        4538,
                        9274,
                        8926,
                        8517,
                        9726,
                        4612,
                        9383,
                        9571,
                        8040,
                        9412,
                        8128,
                        8275,
                        9690,
                        9650,
                        9730,
                        9631,
                        9708,
                        9174,
                        9295,
                        8547,
                        9718,
                        9687,
                        8487,
                        8371,
                        5094,
                        9313,
                        8492,
                        9326,
                        5109,
                        5139,
                        8424,
                        5148,
                        9762,
                        9314,
                        8832,
                        8488,
                        9401,
                        8194,
                        8953,
                        5154,
                        9692,
                        8972,
                        8428,
                        9438,
                        9670,
                        9505,
                        2277,
                        9076,
                        6144,
                        9552,
                        9566,
                        9568,
                        9272,
                        9688,
                        9532,
                        9043,
                        9391,
                        8642,
                        9413,
                        9639,
                        1035,
                        9245,
                        8719,
                        9559,
                        5447,
                        9620,
                        9665,
                        9435,
                        9151,
                        8907,
                        8456,
                        9644,
                        8885,
                        9721,
                        5640,
                        9632,
                        9684,
                        9720,
                        8277,
                        8557,
                        9474,
                        8629,
                        9011,
                        9268,
                        8314,
                        9204,
                        9304,
                        9012,
                        5776,
                        9124,
                        8722,
                        8376,
                        9645,
                        8741,
                        9432,
                        9537,
                        8534,
                        5911,
                        8577,
                        9564,
                        9598,
                        9290,
                        9555,
                        8673,
                        9205,
                        8630,
                        5948,
                        9664,
                        5944,
                        5963,
                        8656,
                        9599,
                        9654,
                        9648,
                        8065,
                        9477,
                        9601,
                        6014,
                        9414,
                        9111,
                        6655,
                        8954,
                        9400,
                        9008,
                        9694,
                        6160,
                        9291,
                        8908,
                        9729,
                        9619,
                        8839,
                        9248,
                        9541,
                        9473,
                        9387,
                        9769,
                        6300,
                        6306,
                        9553,
                        7291,
                        9602,
                        9711,
                        8271,
                        6418,
                        9767,
                        9416,
                        8125,
                        8263,
                        9693,
                        3334,
                        9675,
                        9673,
                        9489,
                        9617,
                        6538,
                        9573,
                        9018,
                        9539,
                        9394,
                        9576,
                        8766,
                        9580,
                        6709,
                        6710,
                        9329,
                        8946,
                        9710,
                        8389,
                        6780,
                        6792,
                        8605,
                        9765,
                        9528,
                        9302,
                        8117,
                        6979,
                        8944,
                        8493,
                        9271,
                        8840
  ))

FactEvent_90_prior_to_Feb_2020 <- tbl(con2, "FactEvent") %>%
  filter(EventTypeKey %in% c(1047, 1100, 1101),
         BlockKey %in% !!DimBlock_90$BlockKey,
         DateKey < !!DimDate_Tim$DateKey) %>% 
  collect()

# now see who has not logged in

All_Operators_prior_to_Feb_2020 <- FactEvent_90_prior_to_Feb_2020 %>% # for all operators-- this is it.
  left_join(DimEventType, by = "EventTypeKey") %>%
  filter(OperatorUserKey %in% User_Tim$UserKey) %>% # new wrinkle
  left_join(DimUser, by = c("OperatorUserKey" = "UserKey")) %>% 
  filter(IsActive == 1) %>% # new wrinkle
  mutate(Date = as.Date(EventDateTime)) %>%
  group_by(LogonID, UserReportLabel) %>%
  arrange(desc(Date)) %>%
  summarise(Last_Logon = first(Date),
            Days_Since_Last_Logon = as.Date(Sys.time())- first(Date)) %>%
  arrange(UserReportLabel) %>%
  formattable::formattable()

All_Operators_prior_to_Feb_2020

nrow(All_Operators_prior_to_Feb_2020)

dim(User_Tim)

Zero_log_ons_prior_to_Feb_2020 <- User_Tim %>%
  # mutate(LogonID = as.character(LogonID)) %>%
  anti_join(All_Operators_prior_to_Feb_2020, by = "LogonID") %>%
  select(LogonID, Name = UserReportLabel) %>%
  arrange(Name) %>%
  formattable::formattable()

Zero_log_ons_prior_to_Feb_2020

nrow(Zero_log_ons_prior_to_Feb_2020)
