Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39FB3DD06A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 08:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhHBGWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 02:22:52 -0400
Received: from smtpbg126.qq.com ([106.55.201.22]:64533 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229792AbhHBGWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 02:22:51 -0400
X-QQ-mid: bizesmtp41t1627885347tjehln8b
Received: from localhost.localdomain (unknown [113.89.245.207])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 02 Aug 2021 14:22:25 +0800 (CST)
X-QQ-SSF: 01100000002000206000B00A0000000
X-QQ-FEAT: Izkt+D24Lu6ll/1ZEwgG2OWokI/c1EN9+wkh/u7N5VS1Mku0039Ik3TEsdAAa
        myCk1lhO8AwLEn5o6whvve7+nYXYMbl8aBsiCGTe7crHz2upzo7ikXAqSYyH4UQWHljsm2F
        tXNBqh+Rl6neFz9dPdh8jgSJvU/DPkf/LXe+tBkRGtCcjLceV0v+laUw4raqVJaqNDFWUDA
        SAdIKsP0Jw0nRnvqc4CTwBayKfeIGhvDP/YaNJWeKQx0FpC/Oqm92RqBhhoTG8MxaYvZ85j
        De9yHRPWWdgGoN245aPzLIwmyuB1RHk48T4RLlIxE3fpJry++lesvn80KCCliEhAdBUq9rm
        WO1xt4C7/5ILYXPZKU=
X-QQ-GoodBg: 0
From:   Icenowy Zheng <icenowy@sipeed.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/17] rtc: sun6i: Add support for linear day storage
Date:   Mon,  2 Aug 2021 14:21:57 +0800
Message-Id: <20210802062212.73220-3-icenowy@sipeed.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210802062212.73220-1-icenowy@sipeed.com>
References: <20210802062212.73220-1-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:sipeed.com:qybgspam:qybgspam2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Przywara <andre.przywara@arm.com>

Newer versions of the Allwinner RTC, as for instance found in the H616
SoC, no longer store a broken-down day/month/year representation in the
RTC_DAY_REG, but just a linear day number.
The user manual does not give any indication about the expected epoch
time of this day count, but the BSP kernel uses the UNIX epoch, which
allows easy support due to existing conversion functions in the kernel.

Allow tagging a compatible string with a flag, and use that to mark
those new RTCs. Then convert between a UNIX day number (converted into
seconds) and the broken-down day representation using mktime64() and
time64_to_tm() in the set_time/get_time functions.

That enables support for the RTC in those new chips.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/rtc/rtc-sun6i.c | 69 +++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 23 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index c551ebf0ac00..a980d4e7408d 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -110,6 +110,8 @@
 #define SUN6I_YEAR_MIN				1970
 #define SUN6I_YEAR_OFF				(SUN6I_YEAR_MIN - 1900)
 
+#define SECS_PER_DAY				(24 * 3600ULL)
+
 /*
  * There are other differences between models, including:
  *
@@ -133,12 +135,15 @@ struct sun6i_rtc_clk_data {
 	unsigned int has_auto_swt : 1;
 };
 
+#define RTC_LINEAR_DAY	BIT(0)
+
 struct sun6i_rtc_dev {
 	struct rtc_device *rtc;
 	const struct sun6i_rtc_clk_data *data;
 	void __iomem *base;
 	int irq;
 	time64_t alarm;
+	unsigned long flags;
 
 	struct clk_hw hw;
 	struct clk_hw *int_osc;
@@ -467,22 +472,30 @@ static int sun6i_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
 	} while ((date != readl(chip->base + SUN6I_RTC_YMD)) ||
 		 (time != readl(chip->base + SUN6I_RTC_HMS)));
 
+	if (chip->flags & RTC_LINEAR_DAY) {
+		/*
+		 * Newer chips store a linear day number, the manual
+		 * does not mandate any epoch base. The BSP driver uses
+		 * the UNIX epoch, let's just copy that, as it's the
+		 * easiest anyway.
+		 */
+		rtc_time64_to_tm((date & 0xffff) * SECS_PER_DAY, rtc_tm);
+	} else {
+		rtc_tm->tm_mday = SUN6I_DATE_GET_DAY_VALUE(date);
+		rtc_tm->tm_mon  = SUN6I_DATE_GET_MON_VALUE(date) - 1;
+		rtc_tm->tm_year = SUN6I_DATE_GET_YEAR_VALUE(date);
+
+		/*
+		 * switch from (data_year->min)-relative offset to
+		 * a (1900)-relative one
+		 */
+		rtc_tm->tm_year += SUN6I_YEAR_OFF;
+	}
+
 	rtc_tm->tm_sec  = SUN6I_TIME_GET_SEC_VALUE(time);
 	rtc_tm->tm_min  = SUN6I_TIME_GET_MIN_VALUE(time);
 	rtc_tm->tm_hour = SUN6I_TIME_GET_HOUR_VALUE(time);
 
-	rtc_tm->tm_mday = SUN6I_DATE_GET_DAY_VALUE(date);
-	rtc_tm->tm_mon  = SUN6I_DATE_GET_MON_VALUE(date);
-	rtc_tm->tm_year = SUN6I_DATE_GET_YEAR_VALUE(date);
-
-	rtc_tm->tm_mon  -= 1;
-
-	/*
-	 * switch from (data_year->min)-relative offset to
-	 * a (1900)-relative one
-	 */
-	rtc_tm->tm_year += SUN6I_YEAR_OFF;
-
 	return 0;
 }
 
@@ -567,20 +580,25 @@ static int sun6i_rtc_settime(struct device *dev, struct rtc_time *rtc_tm)
 	u32 date = 0;
 	u32 time = 0;
 
-	rtc_tm->tm_year -= SUN6I_YEAR_OFF;
-	rtc_tm->tm_mon += 1;
-
-	date = SUN6I_DATE_SET_DAY_VALUE(rtc_tm->tm_mday) |
-		SUN6I_DATE_SET_MON_VALUE(rtc_tm->tm_mon)  |
-		SUN6I_DATE_SET_YEAR_VALUE(rtc_tm->tm_year);
-
-	if (is_leap_year(rtc_tm->tm_year + SUN6I_YEAR_MIN))
-		date |= SUN6I_LEAP_SET_VALUE(1);
-
 	time = SUN6I_TIME_SET_SEC_VALUE(rtc_tm->tm_sec)  |
 		SUN6I_TIME_SET_MIN_VALUE(rtc_tm->tm_min)  |
 		SUN6I_TIME_SET_HOUR_VALUE(rtc_tm->tm_hour);
 
+	if (chip->flags & RTC_LINEAR_DAY) {
+		/* The division will cut off the H:M:S part of rtc_tm. */
+		date = div_u64(rtc_tm_to_time64(rtc_tm), SECS_PER_DAY);
+	} else {
+		rtc_tm->tm_year -= SUN6I_YEAR_OFF;
+		rtc_tm->tm_mon += 1;
+
+		date = SUN6I_DATE_SET_DAY_VALUE(rtc_tm->tm_mday) |
+			SUN6I_DATE_SET_MON_VALUE(rtc_tm->tm_mon)  |
+			SUN6I_DATE_SET_YEAR_VALUE(rtc_tm->tm_year);
+
+		if (is_leap_year(rtc_tm->tm_year + SUN6I_YEAR_MIN))
+			date |= SUN6I_LEAP_SET_VALUE(1);
+	}
+
 	/* Check whether registers are writable */
 	if (sun6i_rtc_wait(chip, SUN6I_LOSC_CTRL,
 			   SUN6I_LOSC_CTRL_ACC_MASK, 50)) {
@@ -674,6 +692,8 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, chip);
 
+	chip->flags = (unsigned long)of_device_get_match_data(&pdev->dev);
+
 	chip->irq = platform_get_irq(pdev, 0);
 	if (chip->irq < 0)
 		return chip->irq;
@@ -720,7 +740,10 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
 		return PTR_ERR(chip->rtc);
 
 	chip->rtc->ops = &sun6i_rtc_ops;
-	chip->rtc->range_max = 2019686399LL; /* 2033-12-31 23:59:59 */
+	if (chip->flags & RTC_LINEAR_DAY)
+		chip->rtc->range_max = (65536 * SECS_PER_DAY) - 1;
+	else
+		chip->rtc->range_max = 2019686399LL; /* 2033-12-31 23:59:59 */
 
 	ret = devm_rtc_register_device(chip->rtc);
 	if (ret)
-- 
2.30.2

