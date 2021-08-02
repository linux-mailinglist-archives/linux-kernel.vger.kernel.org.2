Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7384C3DD086
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 08:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhHBGbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 02:31:04 -0400
Received: from smtpbg604.qq.com ([59.36.128.82]:51875 "EHLO smtpbg604.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhHBGbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 02:31:02 -0400
X-Greylist: delayed 496 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Aug 2021 02:31:01 EDT
X-QQ-mid: bizesmtp41t1627885344tq5561ka
Received: from localhost.localdomain (unknown [113.89.245.207])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 02 Aug 2021 14:22:18 +0800 (CST)
X-QQ-SSF: 01100000002000206000B00A0000000
X-QQ-FEAT: +I1LNsReFTRaBe0n8cyJfpYfsGxVjZPD3N/FdcxwlrxZwKc7m/2gsZPIGovsH
        XjkzYmg6tgcfos6kuz/rLPqQu/zHumGHTOeq+BU/G4OboZbFCvcMQNqoyqZ8Bb7wInD/etJ
        iw7pmwaY/snfXSfqOVtrhOrBeoWQ2XC8bMAEhsQ8/OpL5eO3ZROyKgtIqIoIayYtdwr8+65
        ghx3SMe3z/FTTrunvHG4xUlLGaOiMylfJjtftyBBskVahc2Ver3TEDEyeU8hnjPB3T0P+03
        8tzJCi79USCGw1pjOn7JPWMhc60dgiPhdh6O7zcEwdvjxXQUcXCbzbea980DiYc1oSFHlgg
        n/oPRQehSASnB8yK94=
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
Subject: [PATCH 01/17] rtc: sun6i: Fix time overflow handling
Date:   Mon,  2 Aug 2021 14:21:56 +0800
Message-Id: <20210802062212.73220-2-icenowy@sipeed.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210802062212.73220-1-icenowy@sipeed.com>
References: <20210802062212.73220-1-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:sipeed.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Przywara <andre.przywara@arm.com>

Using "unsigned long" for UNIX timestamps is never a good idea, and
comparing the value of such a variable against U32_MAX does not do
anything useful on 32-bit systems.

Use the proper time64_t type when dealing with timestamps, and avoid
cutting down the time range unnecessarily. This also fixes the flawed
check for the alarm time being too far into the future.

The check for this condition is actually somewhat theoretical, as the
RTC counts till 2033 only anyways, and 2^32 seconds from now is not
before the year 2157 - at which point I hope nobody will be using this
hardware anymore.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/rtc/rtc-sun6i.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index adec1b14a8de..c551ebf0ac00 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -138,7 +138,7 @@ struct sun6i_rtc_dev {
 	const struct sun6i_rtc_clk_data *data;
 	void __iomem *base;
 	int irq;
-	unsigned long alarm;
+	time64_t alarm;
 
 	struct clk_hw hw;
 	struct clk_hw *int_osc;
@@ -510,10 +510,8 @@ static int sun6i_rtc_setalarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 	struct sun6i_rtc_dev *chip = dev_get_drvdata(dev);
 	struct rtc_time *alrm_tm = &wkalrm->time;
 	struct rtc_time tm_now;
-	unsigned long time_now = 0;
-	unsigned long time_set = 0;
-	unsigned long time_gap = 0;
-	int ret = 0;
+	time64_t time_now, time_set;
+	int ret;
 
 	ret = sun6i_rtc_gettime(dev, &tm_now);
 	if (ret < 0) {
@@ -528,9 +526,7 @@ static int sun6i_rtc_setalarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 		return -EINVAL;
 	}
 
-	time_gap = time_set - time_now;
-
-	if (time_gap > U32_MAX) {
+	if ((time_set - time_now) > U32_MAX) {
 		dev_err(dev, "Date too far in the future\n");
 		return -EINVAL;
 	}
@@ -539,7 +535,7 @@ static int sun6i_rtc_setalarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 	writel(0, chip->base + SUN6I_ALRM_COUNTER);
 	usleep_range(100, 300);
 
-	writel(time_gap, chip->base + SUN6I_ALRM_COUNTER);
+	writel(time_set - time_now, chip->base + SUN6I_ALRM_COUNTER);
 	chip->alarm = time_set;
 
 	sun6i_rtc_setaie(wkalrm->enabled, chip);
-- 
2.30.2

