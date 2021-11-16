Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414C8453761
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 17:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhKPQaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 11:30:07 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:43764 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231458AbhKPQaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 11:30:01 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AG7FCkg005416;
        Tue, 16 Nov 2021 10:26:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=ngBWTmOs4HWlzyxq6lq8y8I2SnDqznU1MlnyKmnPGYE=;
 b=m0Miw1oCtsZPAWbSjLTaGJ4/fljh9hzlT59Cfpz2GwXeqObKbRX7bqK5m1Aw5APkerK+
 M3ZU5xJ54Pn9SiM2RJog4sIVelCtB0y0+gH5jdMeNi1BIyATWdaYbcpAGlUcQntL3+dZ
 PukPOGW3ugYp3BqWyZjONPaf1M1IBO/cIXct/zbEnam75tlBu7KtC/YQMO25tU7Yo0ld
 b8s7hC1Jxb850q44rfG1q2kbm3zXfYpTslBjhHBjwnCcEURD9boKo23Rvncc3TL7YevI
 SJOe/Zw0OdA3oZcRbv6e4hFFqtaj/AISOHasEW3U5atL+h7QOLsHNeWkqXrT5uNIx6V1 tA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cbdjgt3be-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Nov 2021 10:26:59 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 16 Nov
 2021 16:26:57 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 16 Nov 2021 16:26:57 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.41])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0646C11DC;
        Tue, 16 Nov 2021 16:26:56 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/3] ASoC: cs42l42: Correct configuring of switch inversion from ts-inv
Date:   Tue, 16 Nov 2021 16:26:48 +0000
Message-ID: <20211116162652.45225-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211116162652.45225-1-rf@opensource.cirrus.com>
References: <20211116162652.45225-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7wBvft3qXOae-DlyeaeXY_Gginh-4oFM
X-Proofpoint-GUID: 7wBvft3qXOae-DlyeaeXY_Gginh-4oFM
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The setting from the cirrus,ts-inv property should be applied to the
TIP_SENSE_INV bit, as this is the one that actually affects the jack
detect block. The TS_INV bit only swaps the meaning of the PLUG and
UNPLUG interrupts and should always be 1 for the interrupts to have
the normal meaning.

Due to some misunderstanding the driver had been implemented to
configure the TS_INV bit based on the jack switch polarity. This made
the interrupts behave the correct way around, but left the jack detect
block, button detect and analogue circuits always interpreting an open
switch as unplugged.

The signal chain inside the codec is:

SENSE pin -> TIP_SENSE_INV -> TS_INV -> (invert) -> interrupts
                  |
                  v
             Jack detect,
          button detect and
            analog control

As the TIP_SENSE_INV already performs the necessary inversion the
TS_INV bit never needs to change. It must always be 1 to yield the
expected interrupt behaviour.

Some extra confusion has arisen because of the additional invert in the
interrupt path, meaning that a value applied to the TS_INV bit produces
the opposite effect of applying it to the TIP_SENSE_INV bit. The ts-inv
property has therefore always had the opposite effect to what might be
expected (0 = inverted, 1 = not inverted). To maintain the meaning of
the ts-inv property it must be inverted when applied to TIP_SENSE_INV.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 2c394ca79604 ("ASoC: Add support for CS42L42 codec")
---
 sound/soc/codecs/cs42l42.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 1029f6b3eb48..27a1c4c73074 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -1818,12 +1818,15 @@ static void cs42l42_setup_hs_type_detect(struct cs42l42_private *cs42l42)
 			(1 << CS42L42_HS_CLAMP_DISABLE_SHIFT));
 
 	/* Enable the tip sense circuit */
+	regmap_update_bits(cs42l42->regmap, CS42L42_TSENSE_CTL,
+			   CS42L42_TS_INV_MASK, CS42L42_TS_INV_MASK);
+
 	regmap_update_bits(cs42l42->regmap, CS42L42_TIPSENSE_CTL,
 			CS42L42_TIP_SENSE_CTRL_MASK |
 			CS42L42_TIP_SENSE_INV_MASK |
 			CS42L42_TIP_SENSE_DEBOUNCE_MASK,
 			(3 << CS42L42_TIP_SENSE_CTRL_SHIFT) |
-			(0 << CS42L42_TIP_SENSE_INV_SHIFT) |
+			(!cs42l42->ts_inv << CS42L42_TIP_SENSE_INV_SHIFT) |
 			(2 << CS42L42_TIP_SENSE_DEBOUNCE_SHIFT));
 
 	/* Save the initial status of the tip sense */
@@ -1867,10 +1870,6 @@ static int cs42l42_handle_device_data(struct device *dev,
 		cs42l42->ts_inv = CS42L42_TS_INV_DIS;
 	}
 
-	regmap_update_bits(cs42l42->regmap, CS42L42_TSENSE_CTL,
-			CS42L42_TS_INV_MASK,
-			(cs42l42->ts_inv << CS42L42_TS_INV_SHIFT));
-
 	ret = device_property_read_u32(dev, "cirrus,ts-dbnc-rise", &val);
 	if (!ret) {
 		switch (val) {
-- 
2.11.0

