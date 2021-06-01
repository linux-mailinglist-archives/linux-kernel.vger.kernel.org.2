Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5872C396DA9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 09:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhFAHCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 03:02:09 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6105 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhFAHCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 03:02:02 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FvNJb6rQgzYpM5;
        Tue,  1 Jun 2021 14:57:35 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 15:00:15 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 15:00:14 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Lee Jones <lee.jones@linaro.org>,
        patches <patches@opensource.cirrus.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] mfd: wm831x: Use DEFINE_RES_IRQ_NAMED() and DEFINE_RES_IRQ() to simplify code
Date:   Tue, 1 Jun 2021 15:00:09 +0800
Message-ID: <20210601070009.10098-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/mfd/wm831x-core.c | 248 ++++++--------------------------------
 1 file changed, 36 insertions(+), 212 deletions(-)

diff --git a/drivers/mfd/wm831x-core.c b/drivers/mfd/wm831x-core.c
index bcef08f58fb3f30..7a175a3231992fe 100644
--- a/drivers/mfd/wm831x-core.c
+++ b/drivers/mfd/wm831x-core.c
@@ -622,18 +622,8 @@ static const struct resource wm831x_dcdc1_resources[] = {
 		.end   = WM831X_DC1_DVS_CONTROL,
 		.flags = IORESOURCE_REG,
 	},
-	{
-		.name  = "UV",
-		.start = WM831X_IRQ_UV_DC1,
-		.end   = WM831X_IRQ_UV_DC1,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name  = "HC",
-		.start = WM831X_IRQ_HC_DC1,
-		.end   = WM831X_IRQ_HC_DC1,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_UV_DC1, "UV"),
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_HC_DC1, "HC"),
 };
 
 
@@ -643,18 +633,8 @@ static const struct resource wm831x_dcdc2_resources[] = {
 		.end   = WM831X_DC2_DVS_CONTROL,
 		.flags = IORESOURCE_REG,
 	},
-	{
-		.name  = "UV",
-		.start = WM831X_IRQ_UV_DC2,
-		.end   = WM831X_IRQ_UV_DC2,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name  = "HC",
-		.start = WM831X_IRQ_HC_DC2,
-		.end   = WM831X_IRQ_HC_DC2,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_UV_DC2, "UV"),
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_HC_DC2, "HC"),
 };
 
 static const struct resource wm831x_dcdc3_resources[] = {
@@ -663,12 +643,7 @@ static const struct resource wm831x_dcdc3_resources[] = {
 		.end   = WM831X_DC3_SLEEP_CONTROL,
 		.flags = IORESOURCE_REG,
 	},
-	{
-		.name  = "UV",
-		.start = WM831X_IRQ_UV_DC3,
-		.end   = WM831X_IRQ_UV_DC3,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_UV_DC3, "UV"),
 };
 
 static const struct resource wm831x_dcdc4_resources[] = {
@@ -677,12 +652,7 @@ static const struct resource wm831x_dcdc4_resources[] = {
 		.end   = WM831X_DC4_SLEEP_CONTROL,
 		.flags = IORESOURCE_REG,
 	},
-	{
-		.name  = "UV",
-		.start = WM831X_IRQ_UV_DC4,
-		.end   = WM831X_IRQ_UV_DC4,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_UV_DC4, "UV"),
 };
 
 static const struct resource wm8320_dcdc4_buck_resources[] = {
@@ -691,12 +661,7 @@ static const struct resource wm8320_dcdc4_buck_resources[] = {
 		.end   = WM832X_DC4_SLEEP_CONTROL,
 		.flags = IORESOURCE_REG,
 	},
-	{
-		.name  = "UV",
-		.start = WM831X_IRQ_UV_DC4,
-		.end   = WM831X_IRQ_UV_DC4,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_UV_DC4, "UV"),
 };
 
 static const struct resource wm831x_gpio_resources[] = {
@@ -713,11 +678,7 @@ static const struct resource wm831x_isink1_resources[] = {
 		.end   = WM831X_CURRENT_SINK_1,
 		.flags = IORESOURCE_REG,
 	},
-	{
-		.start = WM831X_IRQ_CS1,
-		.end   = WM831X_IRQ_CS1,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ(WM831X_IRQ_CS1),
 };
 
 static const struct resource wm831x_isink2_resources[] = {
@@ -726,11 +687,7 @@ static const struct resource wm831x_isink2_resources[] = {
 		.end   = WM831X_CURRENT_SINK_2,
 		.flags = IORESOURCE_REG,
 	},
-	{
-		.start = WM831X_IRQ_CS2,
-		.end   = WM831X_IRQ_CS2,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ(WM831X_IRQ_CS2),
 };
 
 static const struct resource wm831x_ldo1_resources[] = {
@@ -739,12 +696,7 @@ static const struct resource wm831x_ldo1_resources[] = {
 		.end   = WM831X_LDO1_SLEEP_CONTROL,
 		.flags = IORESOURCE_REG,
 	},
-	{
-		.name  = "UV",
-		.start = WM831X_IRQ_UV_LDO1,
-		.end   = WM831X_IRQ_UV_LDO1,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_UV_LDO1, "UV"),
 };
 
 static const struct resource wm831x_ldo2_resources[] = {
@@ -753,12 +705,7 @@ static const struct resource wm831x_ldo2_resources[] = {
 		.end   = WM831X_LDO2_SLEEP_CONTROL,
 		.flags = IORESOURCE_REG,
 	},
-	{
-		.name  = "UV",
-		.start = WM831X_IRQ_UV_LDO2,
-		.end   = WM831X_IRQ_UV_LDO2,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_UV_LDO2, "UV"),
 };
 
 static const struct resource wm831x_ldo3_resources[] = {
@@ -767,12 +714,7 @@ static const struct resource wm831x_ldo3_resources[] = {
 		.end   = WM831X_LDO3_SLEEP_CONTROL,
 		.flags = IORESOURCE_REG,
 	},
-	{
-		.name  = "UV",
-		.start = WM831X_IRQ_UV_LDO3,
-		.end   = WM831X_IRQ_UV_LDO3,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_UV_LDO3, "UV"),
 };
 
 static const struct resource wm831x_ldo4_resources[] = {
@@ -781,12 +723,7 @@ static const struct resource wm831x_ldo4_resources[] = {
 		.end   = WM831X_LDO4_SLEEP_CONTROL,
 		.flags = IORESOURCE_REG,
 	},
-	{
-		.name  = "UV",
-		.start = WM831X_IRQ_UV_LDO4,
-		.end   = WM831X_IRQ_UV_LDO4,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_UV_LDO4, "UV"),
 };
 
 static const struct resource wm831x_ldo5_resources[] = {
@@ -795,12 +732,7 @@ static const struct resource wm831x_ldo5_resources[] = {
 		.end   = WM831X_LDO5_SLEEP_CONTROL,
 		.flags = IORESOURCE_REG,
 	},
-	{
-		.name  = "UV",
-		.start = WM831X_IRQ_UV_LDO5,
-		.end   = WM831X_IRQ_UV_LDO5,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_UV_LDO5, "UV"),
 };
 
 static const struct resource wm831x_ldo6_resources[] = {
@@ -809,12 +741,7 @@ static const struct resource wm831x_ldo6_resources[] = {
 		.end   = WM831X_LDO6_SLEEP_CONTROL,
 		.flags = IORESOURCE_REG,
 	},
-	{
-		.name  = "UV",
-		.start = WM831X_IRQ_UV_LDO6,
-		.end   = WM831X_IRQ_UV_LDO6,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_UV_LDO6, "UV"),
 };
 
 static const struct resource wm831x_ldo7_resources[] = {
@@ -823,12 +750,7 @@ static const struct resource wm831x_ldo7_resources[] = {
 		.end   = WM831X_LDO7_SLEEP_CONTROL,
 		.flags = IORESOURCE_REG,
 	},
-	{
-		.name  = "UV",
-		.start = WM831X_IRQ_UV_LDO7,
-		.end   = WM831X_IRQ_UV_LDO7,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_UV_LDO7, "UV"),
 };
 
 static const struct resource wm831x_ldo8_resources[] = {
@@ -837,12 +759,7 @@ static const struct resource wm831x_ldo8_resources[] = {
 		.end   = WM831X_LDO8_SLEEP_CONTROL,
 		.flags = IORESOURCE_REG,
 	},
-	{
-		.name  = "UV",
-		.start = WM831X_IRQ_UV_LDO8,
-		.end   = WM831X_IRQ_UV_LDO8,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_UV_LDO8, "UV"),
 };
 
 static const struct resource wm831x_ldo9_resources[] = {
@@ -851,12 +768,7 @@ static const struct resource wm831x_ldo9_resources[] = {
 		.end   = WM831X_LDO9_SLEEP_CONTROL,
 		.flags = IORESOURCE_REG,
 	},
-	{
-		.name  = "UV",
-		.start = WM831X_IRQ_UV_LDO9,
-		.end   = WM831X_IRQ_UV_LDO9,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_UV_LDO9, "UV"),
 };
 
 static const struct resource wm831x_ldo10_resources[] = {
@@ -865,12 +777,7 @@ static const struct resource wm831x_ldo10_resources[] = {
 		.end   = WM831X_LDO10_SLEEP_CONTROL,
 		.flags = IORESOURCE_REG,
 	},
-	{
-		.name  = "UV",
-		.start = WM831X_IRQ_UV_LDO10,
-		.end   = WM831X_IRQ_UV_LDO10,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_UV_LDO10, "UV"),
 };
 
 static const struct resource wm831x_ldo11_resources[] = {
@@ -882,96 +789,27 @@ static const struct resource wm831x_ldo11_resources[] = {
 };
 
 static const struct resource wm831x_on_resources[] = {
-	{
-		.start = WM831X_IRQ_ON,
-		.end   = WM831X_IRQ_ON,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ(WM831X_IRQ_ON),
 };
 
 
 static const struct resource wm831x_power_resources[] = {
-	{
-		.name = "SYSLO",
-		.start = WM831X_IRQ_PPM_SYSLO,
-		.end   = WM831X_IRQ_PPM_SYSLO,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name = "PWR SRC",
-		.start = WM831X_IRQ_PPM_PWR_SRC,
-		.end   = WM831X_IRQ_PPM_PWR_SRC,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name = "USB CURR",
-		.start = WM831X_IRQ_PPM_USB_CURR,
-		.end   = WM831X_IRQ_PPM_USB_CURR,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name = "BATT HOT",
-		.start = WM831X_IRQ_CHG_BATT_HOT,
-		.end   = WM831X_IRQ_CHG_BATT_HOT,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name = "BATT COLD",
-		.start = WM831X_IRQ_CHG_BATT_COLD,
-		.end   = WM831X_IRQ_CHG_BATT_COLD,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name = "BATT FAIL",
-		.start = WM831X_IRQ_CHG_BATT_FAIL,
-		.end   = WM831X_IRQ_CHG_BATT_FAIL,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name = "OV",
-		.start = WM831X_IRQ_CHG_OV,
-		.end   = WM831X_IRQ_CHG_OV,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name = "END",
-		.start = WM831X_IRQ_CHG_END,
-		.end   = WM831X_IRQ_CHG_END,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name = "TO",
-		.start = WM831X_IRQ_CHG_TO,
-		.end   = WM831X_IRQ_CHG_TO,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name = "MODE",
-		.start = WM831X_IRQ_CHG_MODE,
-		.end   = WM831X_IRQ_CHG_MODE,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name = "START",
-		.start = WM831X_IRQ_CHG_START,
-		.end   = WM831X_IRQ_CHG_START,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_PPM_SYSLO, "SYSLO"),
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_PPM_PWR_SRC, "PWR SRC"),
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_PPM_USB_CURR, "USB CURR"),
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_CHG_BATT_HOT, "BATT HOT"),
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_CHG_BATT_COLD, "BATT COLD"),
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_CHG_BATT_FAIL, "BATT FAIL"),
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_CHG_OV, "OV"),
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_CHG_END, "END"),
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_CHG_TO, "TO"),
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_CHG_MODE, "MODE"),
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_CHG_START, "START"),
 };
 
 static const struct resource wm831x_rtc_resources[] = {
-	{
-		.name = "PER",
-		.start = WM831X_IRQ_RTC_PER,
-		.end   = WM831X_IRQ_RTC_PER,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name = "ALM",
-		.start = WM831X_IRQ_RTC_ALM,
-		.end   = WM831X_IRQ_RTC_ALM,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_RTC_PER, "PER"),
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_RTC_ALM, "ALM"),
 };
 
 static const struct resource wm831x_status1_resources[] = {
@@ -991,26 +829,12 @@ static const struct resource wm831x_status2_resources[] = {
 };
 
 static const struct resource wm831x_touch_resources[] = {
-	{
-		.name = "TCHPD",
-		.start = WM831X_IRQ_TCHPD,
-		.end   = WM831X_IRQ_TCHPD,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name = "TCHDATA",
-		.start = WM831X_IRQ_TCHDATA,
-		.end   = WM831X_IRQ_TCHDATA,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_TCHPD, "TCHPD"),
+	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_TCHDATA, "TCHDATA"),
 };
 
 static const struct resource wm831x_wdt_resources[] = {
-	{
-		.start = WM831X_IRQ_WDOG_TO,
-		.end   = WM831X_IRQ_WDOG_TO,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ(WM831X_IRQ_WDOG_TO),
 };
 
 static const struct mfd_cell wm8310_devs[] = {
-- 
2.26.0.106.g9fadedd


