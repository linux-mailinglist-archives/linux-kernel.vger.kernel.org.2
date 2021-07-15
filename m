Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E55D3C9E21
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 14:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhGOMCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 08:02:52 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:11425 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbhGOMCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 08:02:49 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GQXsG5gJFzcbNy;
        Thu, 15 Jul 2021 19:56:34 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 19:59:53 +0800
Received: from SWX921481.china.huawei.com (10.126.202.216) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 15 Jul 2021 19:59:48 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
        <andriy.shevchenko@linux.intel.com>, <yury.norov@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC:     <dave.hansen@intel.com>, <linux@rasmusvillemoes.dk>,
        <rafael@kernel.org>, <rdunlap@infradead.org>,
        <agordeev@linux.ibm.com>, <sbrivio@redhat.com>,
        <jianpeng.ma@intel.com>, <valentin.schneider@arm.com>,
        <peterz@infradead.org>, <bristot@redhat.com>,
        <guodong.xu@linaro.org>, <tangchengchang@huawei.com>,
        <prime.zeng@hisilicon.com>, <yangyicong@huawei.com>,
        <tim.c.chen@linux.intel.com>, <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v7 4/4] lib: test_bitmap: add bitmap_print_to_buf test cases
Date:   Thu, 15 Jul 2021 23:58:56 +1200
Message-ID: <20210715115856.11304-5-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20210715115856.11304-1-song.bao.hua@hisilicon.com>
References: <20210715115856.11304-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.202.216]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggemi761-chm.china.huawei.com (10.1.198.147)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The added test items cover both cases where bitmap buf of the printed
result is greater than and less than 4KB.
And it also covers the case where offset for bitmap_print_to_buf is
non-zero which will happen when printed buf is larger than one page
in sysfs bin_attribute.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v7:
 minor cleanup according to Andy's comments

 lib/test_bitmap.c | 150 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 4ea73f5aed41..eb8ebaf12865 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -19,6 +19,7 @@
 KSTM_MODULE_GLOBALS();
 
 static char pbl_buffer[PAGE_SIZE] __initdata;
+static char print_buf[PAGE_SIZE * 2] __initdata;
 
 static const unsigned long exp1[] __initconst = {
 	BITMAP_FROM_U64(1),
@@ -156,6 +157,20 @@ static bool __init __check_eq_clump8(const char *srcfile, unsigned int line,
 	return true;
 }
 
+static bool __init
+__check_eq_str(const char *srcfile, unsigned int line,
+		const char *exp_str, const char *str,
+		unsigned int len)
+{
+	bool eq;
+
+	eq = strncmp(exp_str, str, len) == 0;
+	if (!eq)
+		pr_err("[%s:%u] expected %s, got %s\n", srcfile, line, exp_str, str);
+
+	return eq;
+}
+
 #define __expect_eq(suffix, ...)					\
 	({								\
 		int result = 0;						\
@@ -173,6 +188,7 @@ static bool __init __check_eq_clump8(const char *srcfile, unsigned int line,
 #define expect_eq_pbl(...)		__expect_eq(pbl, ##__VA_ARGS__)
 #define expect_eq_u32_array(...)	__expect_eq(u32_array, ##__VA_ARGS__)
 #define expect_eq_clump8(...)		__expect_eq(clump8, ##__VA_ARGS__)
+#define expect_eq_str(...)		__expect_eq(str, ##__VA_ARGS__)
 
 static void __init test_zero_clear(void)
 {
@@ -660,6 +676,139 @@ static void __init test_bitmap_cut(void)
 	}
 }
 
+struct test_bitmap_print {
+	const unsigned long *bitmap;
+	unsigned long nbits;
+	const char *mask;
+	const char *list;
+};
+
+static const unsigned long small_bitmap[] __initconst = {
+	BITMAP_FROM_U64(0x3333333311111111ULL),
+};
+
+static const char small_mask[] __initconst = "33333333,11111111\n";
+static const char small_list[] __initconst = "0,4,8,12,16,20,24,28,32-33,36-37,40-41,44-45,48-49,52-53,56-57,60-61\n";
+
+static const unsigned long large_bitmap[] __initconst = {
+	BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
+	BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
+	BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
+	BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
+	BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
+	BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
+	BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
+	BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
+	BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
+	BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
+	BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
+	BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
+	BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
+	BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
+	BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
+	BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
+	BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
+	BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
+	BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
+	BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
+};
+
+static const char large_mask[] __initconst = "33333333,11111111,33333333,11111111,"
+					"33333333,11111111,33333333,11111111,"
+					"33333333,11111111,33333333,11111111,"
+					"33333333,11111111,33333333,11111111,"
+					"33333333,11111111,33333333,11111111,"
+					"33333333,11111111,33333333,11111111,"
+					"33333333,11111111,33333333,11111111,"
+					"33333333,11111111,33333333,11111111,"
+					"33333333,11111111,33333333,11111111,"
+					"33333333,11111111,33333333,11111111,"
+					"33333333,11111111,33333333,11111111,"
+					"33333333,11111111,33333333,11111111,"
+					"33333333,11111111,33333333,11111111,"
+					"33333333,11111111,33333333,11111111,"
+					"33333333,11111111,33333333,11111111,"
+					"33333333,11111111,33333333,11111111,"
+					"33333333,11111111,33333333,11111111,"
+					"33333333,11111111,33333333,11111111,"
+					"33333333,11111111,33333333,11111111,"
+					"33333333,11111111,33333333,11111111\n";
+
+static const char large_list[] __initconst = /* more than 4KB */
+	"0,4,8,12,16,20,24,28,32-33,36-37,40-41,44-45,48-49,52-53,56-57,60-61,64,68,72,76,80,84,88,92,96-97,100-101,104-1"
+	"05,108-109,112-113,116-117,120-121,124-125,128,132,136,140,144,148,152,156,160-161,164-165,168-169,172-173,176-1"
+	"77,180-181,184-185,188-189,192,196,200,204,208,212,216,220,224-225,228-229,232-233,236-237,240-241,244-245,248-2"
+	"49,252-253,256,260,264,268,272,276,280,284,288-289,292-293,296-297,300-301,304-305,308-309,312-313,316-317,320,3"
+	"24,328,332,336,340,344,348,352-353,356-357,360-361,364-365,368-369,372-373,376-377,380-381,384,388,392,396,400,4"
+	"04,408,412,416-417,420-421,424-425,428-429,432-433,436-437,440-441,444-445,448,452,456,460,464,468,472,476,480-4"
+	"81,484-485,488-489,492-493,496-497,500-501,504-505,508-509,512,516,520,524,528,532,536,540,544-545,548-549,552-5"
+	"53,556-557,560-561,564-565,568-569,572-573,576,580,584,588,592,596,600,604,608-609,612-613,616-617,620-621,624-6"
+	"25,628-629,632-633,636-637,640,644,648,652,656,660,664,668,672-673,676-677,680-681,684-685,688-689,692-693,696-6"
+	"97,700-701,704,708,712,716,720,724,728,732,736-737,740-741,744-745,748-749,752-753,756-757,760-761,764-765,768,7"
+	"72,776,780,784,788,792,796,800-801,804-805,808-809,812-813,816-817,820-821,824-825,828-829,832,836,840,844,848,8"
+	"52,856,860,864-865,868-869,872-873,876-877,880-881,884-885,888-889,892-893,896,900,904,908,912,916,920,924,928-9"
+	"29,932-933,936-937,940-941,944-945,948-949,952-953,956-957,960,964,968,972,976,980,984,988,992-993,996-997,1000-"
+	"1001,1004-1005,1008-1009,1012-1013,1016-1017,1020-1021,1024,1028,1032,1036,1040,1044,1048,1052,1056-1057,1060-10"
+	"61,1064-1065,1068-1069,1072-1073,1076-1077,1080-1081,1084-1085,1088,1092,1096,1100,1104,1108,1112,1116,1120-1121"
+	",1124-1125,1128-1129,1132-1133,1136-1137,1140-1141,1144-1145,1148-1149,1152,1156,1160,1164,1168,1172,1176,1180,1"
+	"184-1185,1188-1189,1192-1193,1196-1197,1200-1201,1204-1205,1208-1209,1212-1213,1216,1220,1224,1228,1232,1236,124"
+	"0,1244,1248-1249,1252-1253,1256-1257,1260-1261,1264-1265,1268-1269,1272-1273,1276-1277,1280,1284,1288,1292,1296,"
+	"1300,1304,1308,1312-1313,1316-1317,1320-1321,1324-1325,1328-1329,1332-1333,1336-1337,1340-1341,1344,1348,1352,13"
+	"56,1360,1364,1368,1372,1376-1377,1380-1381,1384-1385,1388-1389,1392-1393,1396-1397,1400-1401,1404-1405,1408,1412"
+	",1416,1420,1424,1428,1432,1436,1440-1441,1444-1445,1448-1449,1452-1453,1456-1457,1460-1461,1464-1465,1468-1469,1"
+	"472,1476,1480,1484,1488,1492,1496,1500,1504-1505,1508-1509,1512-1513,1516-1517,1520-1521,1524-1525,1528-1529,153"
+	"2-1533,1536,1540,1544,1548,1552,1556,1560,1564,1568-1569,1572-1573,1576-1577,1580-1581,1584-1585,1588-1589,1592-"
+	"1593,1596-1597,1600,1604,1608,1612,1616,1620,1624,1628,1632-1633,1636-1637,1640-1641,1644-1645,1648-1649,1652-16"
+	"53,1656-1657,1660-1661,1664,1668,1672,1676,1680,1684,1688,1692,1696-1697,1700-1701,1704-1705,1708-1709,1712-1713"
+	",1716-1717,1720-1721,1724-1725,1728,1732,1736,1740,1744,1748,1752,1756,1760-1761,1764-1765,1768-1769,1772-1773,1"
+	"776-1777,1780-1781,1784-1785,1788-1789,1792,1796,1800,1804,1808,1812,1816,1820,1824-1825,1828-1829,1832-1833,183"
+	"6-1837,1840-1841,1844-1845,1848-1849,1852-1853,1856,1860,1864,1868,1872,1876,1880,1884,1888-1889,1892-1893,1896-"
+	"1897,1900-1901,1904-1905,1908-1909,1912-1913,1916-1917,1920,1924,1928,1932,1936,1940,1944,1948,1952-1953,1956-19"
+	"57,1960-1961,1964-1965,1968-1969,1972-1973,1976-1977,1980-1981,1984,1988,1992,1996,2000,2004,2008,2012,2016-2017"
+	",2020-2021,2024-2025,2028-2029,2032-2033,2036-2037,2040-2041,2044-2045,2048,2052,2056,2060,2064,2068,2072,2076,2"
+	"080-2081,2084-2085,2088-2089,2092-2093,2096-2097,2100-2101,2104-2105,2108-2109,2112,2116,2120,2124,2128,2132,213"
+	"6,2140,2144-2145,2148-2149,2152-2153,2156-2157,2160-2161,2164-2165,2168-2169,2172-2173,2176,2180,2184,2188,2192,"
+	"2196,2200,2204,2208-2209,2212-2213,2216-2217,2220-2221,2224-2225,2228-2229,2232-2233,2236-2237,2240,2244,2248,22"
+	"52,2256,2260,2264,2268,2272-2273,2276-2277,2280-2281,2284-2285,2288-2289,2292-2293,2296-2297,2300-2301,2304,2308"
+	",2312,2316,2320,2324,2328,2332,2336-2337,2340-2341,2344-2345,2348-2349,2352-2353,2356-2357,2360-2361,2364-2365,2"
+	"368,2372,2376,2380,2384,2388,2392,2396,2400-2401,2404-2405,2408-2409,2412-2413,2416-2417,2420-2421,2424-2425,242"
+	"8-2429,2432,2436,2440,2444,2448,2452,2456,2460,2464-2465,2468-2469,2472-2473,2476-2477,2480-2481,2484-2485,2488-"
+	"2489,2492-2493,2496,2500,2504,2508,2512,2516,2520,2524,2528-2529,2532-2533,2536-2537,2540-2541,2544-2545,2548-25"
+	"49,2552-2553,2556-2557\n";
+
+static const struct test_bitmap_print test_print[] __initconst = {
+	{ small_bitmap, sizeof(small_bitmap) * BITS_PER_BYTE, small_mask, small_list },
+	{ large_bitmap, sizeof(large_bitmap) * BITS_PER_BYTE, large_mask, large_list },
+};
+
+static void __init test_bitmap_print_buf(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(test_print); i++) {
+		const struct test_bitmap_print *t = &test_print[i];
+		int n;
+
+		n = bitmap_print_to_buf(false, print_buf, t->bitmap, t->nbits,
+					0, 2 * PAGE_SIZE);
+		expect_eq_uint(strlen(t->mask) + 1, n);
+		expect_eq_str(t->mask, print_buf, n);
+
+		n = bitmap_print_to_buf(true, print_buf, t->bitmap, t->nbits,
+					0, 2 * PAGE_SIZE);
+		expect_eq_uint(strlen(t->list) + 1, n);
+		expect_eq_str(t->list, print_buf, n);
+
+		/* test bitmap_print_to_buf by non-zero offset */
+		if (strlen(t->list) > PAGE_SIZE) {
+			n = bitmap_print_to_buf(true, print_buf, t->bitmap, t->nbits,
+						PAGE_SIZE, PAGE_SIZE);
+			expect_eq_uint(strlen(t->list) + 1 - PAGE_SIZE, n);
+			expect_eq_str(t->list + PAGE_SIZE, print_buf, n);
+		}
+	}
+}
+
 static void __init selftest(void)
 {
 	test_zero_clear();
@@ -672,6 +821,7 @@ static void __init selftest(void)
 	test_mem_optimisations();
 	test_for_each_set_clump8();
 	test_bitmap_cut();
+	test_bitmap_print_buf();
 }
 
 KSTM_MODULE_LOADERS(test_bitmap);
-- 
2.25.1

