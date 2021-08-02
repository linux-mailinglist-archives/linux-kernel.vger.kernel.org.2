Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AECC3DD097
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 08:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhHBGby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 02:31:54 -0400
Received: from smtpbg128.qq.com ([106.55.201.39]:56548 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232428AbhHBGbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 02:31:47 -0400
X-QQ-mid: bizesmtp41t1627885352t59cfljp
Received: from localhost.localdomain (unknown [113.89.245.207])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 02 Aug 2021 14:22:29 +0800 (CST)
X-QQ-SSF: 01100000002000206000B00A0000000
X-QQ-FEAT: vLPYWrwZbqtrOYimloWC80mCd88KyGqnh5+mRCGmtELPdmXRolfov7pigmWm5
        UcMMc1kruqGDfB8dF3zFwxrv55vXjltWPzJyOn5O4dvjgjCg/ZU5yRypx/T0HRBT3Wq8Hd0
        2pDFFYVFTyo5vecpZsLW5nmFywYduc7P7azcQTDLefsTKkmqgAx/QJdGIHz92E7zSPZxXw4
        QsykHj3HRBD5mgCWRFYU+eC46J7V8b+r/LLHr+4XfaLifWYjbJovMux0XTfB7wRsOy7AlKY
        nprp3HQu36knnVBQ61xr1q2GbLgMdDV5NY84+/MFAk82RhP80QHuy/VzAfqt9ecNEgjAuNp
        qk6s1yjX/WQq2CiKFI=
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
Subject: [PATCH 03/17] rtc: sun6i: Add support for broken-down alarm registers
Date:   Mon,  2 Aug 2021 14:21:58 +0800
Message-Id: <20210802062212.73220-4-icenowy@sipeed.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210802062212.73220-1-icenowy@sipeed.com>
References: <20210802062212.73220-1-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:sipeed.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Przywara <andre.przywara@arm.com>

Newer versions of the Allwinner RTC, for instance as found in the H616
SoC, not only store the current day as a linear number, but also change
the way the alarm is handled: There are now two registers, that
explicitly store the wakeup time, in the same format as the current
time.

Add support for that variant by writing the requested wakeup time
directly into the registers, instead of programming the seconds left, as
the old SoCs required.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/rtc/rtc-sun6i.c | 57 +++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index a980d4e7408d..752bea949050 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -48,7 +48,8 @@
 
 /* Alarm 0 (counter) */
 #define SUN6I_ALRM_COUNTER			0x0020
-#define SUN6I_ALRM_CUR_VAL			0x0024
+/* This holds the remaining alarm seconds on older SoCs (current value) */
+#define SUN6I_ALRM_COUNTER_HMS			0x0024
 #define SUN6I_ALRM_EN				0x0028
 #define SUN6I_ALRM_EN_CNT_EN			BIT(0)
 #define SUN6I_ALRM_IRQ_EN			0x002c
@@ -523,32 +524,54 @@ static int sun6i_rtc_setalarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 	struct sun6i_rtc_dev *chip = dev_get_drvdata(dev);
 	struct rtc_time *alrm_tm = &wkalrm->time;
 	struct rtc_time tm_now;
-	time64_t time_now, time_set;
+	time64_t time_set;
+	u32 counter_val, counter_val_hms;
 	int ret;
 
-	ret = sun6i_rtc_gettime(dev, &tm_now);
-	if (ret < 0) {
-		dev_err(dev, "Error in getting time\n");
-		return -EINVAL;
-	}
-
 	time_set = rtc_tm_to_time64(alrm_tm);
-	time_now = rtc_tm_to_time64(&tm_now);
-	if (time_set <= time_now) {
-		dev_err(dev, "Date to set in the past\n");
-		return -EINVAL;
-	}
 
-	if ((time_set - time_now) > U32_MAX) {
-		dev_err(dev, "Date too far in the future\n");
-		return -EINVAL;
+	if (chip->flags & RTC_LINEAR_DAY) {
+		/*
+		 * The alarm registers hold the actual alarm time, encoded
+		 * in the same way (linear day + HMS) as the current time.
+		 */
+		counter_val_hms = SUN6I_TIME_SET_SEC_VALUE(alrm_tm->tm_sec)  |
+				  SUN6I_TIME_SET_MIN_VALUE(alrm_tm->tm_min)  |
+				  SUN6I_TIME_SET_HOUR_VALUE(alrm_tm->tm_hour);
+		/* The division will cut off the H:M:S part of alrm_tm. */
+		counter_val = div_u64(rtc_tm_to_time64(alrm_tm), SECS_PER_DAY);
+	} else {
+		/* The alarm register holds the number of seconds left. */
+		time64_t time_now;
+
+		ret = sun6i_rtc_gettime(dev, &tm_now);
+		if (ret < 0) {
+			dev_err(dev, "Error in getting time\n");
+			return -EINVAL;
+		}
+
+		time_now = rtc_tm_to_time64(&tm_now);
+		if (time_set <= time_now) {
+			dev_err(dev, "Date to set in the past\n");
+			return -EINVAL;
+		}
+		if ((time_set - time_now) > U32_MAX) {
+			dev_err(dev, "Date too far in the future\n");
+			return -EINVAL;
+		}
+
+		counter_val = time_set - time_now;
 	}
 
 	sun6i_rtc_setaie(0, chip);
 	writel(0, chip->base + SUN6I_ALRM_COUNTER);
+	if (chip->flags & RTC_LINEAR_DAY)
+		writel(0, chip->base + SUN6I_ALRM_COUNTER_HMS);
 	usleep_range(100, 300);
 
-	writel(time_set - time_now, chip->base + SUN6I_ALRM_COUNTER);
+	writel(counter_val, chip->base + SUN6I_ALRM_COUNTER);
+	if (chip->flags & RTC_LINEAR_DAY)
+		writel(counter_val_hms, chip->base + SUN6I_ALRM_COUNTER_HMS);
 	chip->alarm = time_set;
 
 	sun6i_rtc_setaie(wkalrm->enabled, chip);
-- 
2.30.2

