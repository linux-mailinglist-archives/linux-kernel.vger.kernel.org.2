Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D42B43E325
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhJ1OLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:11:48 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:52912 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231133AbhJ1OLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:11:44 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19S8422u008357;
        Thu, 28 Oct 2021 09:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=ngBWTmOs4HWlzyxq6lq8y8I2SnDqznU1MlnyKmnPGYE=;
 b=W+yUmcYSo17ijhXNwEy3chSa70dVNGiQOtdFIfzzJ09BkfJqTOwMXNdcv++QMFXj3AxH
 FkXiwSN/UGiBaBRTev/l4NrWRyjZxzcyKji8FSoKIf0UyTnRoc/WJDHEsrPmT1CQdvRx
 ErZry6Foze3/KcniTItXo8z2+1IshdGhfnGcDtTyEpDiTmHM8yu0B5HMRRCTVm9MXR1X
 gQSIKOP8/nuK0WySTePc/+hDF6Ume3mDvpY12X/dVRPi4umxjTu8KcPNPI8CZ3lyTe2c
 hkvAWpvADlSr2efw8BA4xDWVu4ysh36HW56lzvVRtrQHpw6G2bWbBYLr2/WrWSnKrTN2 QQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3bya1wh98x-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 Oct 2021 09:09:10 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 28 Oct
 2021 15:09:07 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Thu, 28 Oct 2021 15:09:07 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.32])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7B3F8B2F;
        Thu, 28 Oct 2021 14:09:07 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/3] ASoC: cs42l42: Correct configuring of switch inversion from ts-inv
Date:   Thu, 28 Oct 2021 15:09:01 +0100
Message-ID: <20211028140902.11786-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211028140902.11786-1-rf@opensource.cirrus.com>
References: <20211028140902.11786-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: EviDpidQclLn-naTXo5TPHnY4VLZgnQ1
X-Proofpoint-ORIG-GUID: EviDpidQclLn-naTXo5TPHnY4VLZgnQ1
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

