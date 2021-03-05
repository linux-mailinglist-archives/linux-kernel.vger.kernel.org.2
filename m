Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EBD32F153
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhCERf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:35:29 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:13432 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229875AbhCERfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:35:12 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125HWLWe005729;
        Fri, 5 Mar 2021 11:34:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=M2+N2yfj7KJ/9KkUfuDtF5GUf9Pnf+67Qk0IZmBxmhM=;
 b=izwOjrpWQdzUehnfbq/lOezYjaG3Oc0aTB2XM3CceLwMCYsdygfkXO+rX/pe1Lt2/DWC
 0FHkthx2WBihXU04C04ADCdz+V6Msimh5ouEN9XYUf/v7e3Sza9u/79PfBB1c0SbHJwV
 j26/D/gGoTMo7jLd8CZ3V7vWF+hQk3qmeFk4soV75gy30v7Va5iPpE0cVb/MCvyO/iHN
 rSQXqXA0gkv1y1HAZSW62jtlFBYiwIjIfAOO+fRd7Yue3OYGX8IuqkOSDsayAlIU3WzJ
 T43M9jIad3ptfEyblPRx9qe5rgO+kUhXmDiBskk2EErBOGaEbnKtroMqF/mpmAsjRQIv fg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 36ymc70eyn-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Mar 2021 11:34:51 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 5 Mar 2021
 17:34:48 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Fri, 5 Mar 2021 17:34:48 +0000
Received: from mail1.cirrus.com (unknown [198.61.64.35])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6F84711D7;
        Fri,  5 Mar 2021 17:34:48 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v2 11/15] ASoC: cs42l42: Report jack and button detection
Date:   Fri, 5 Mar 2021 17:34:38 +0000
Message-ID: <20210305173442.195740-12-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305173442.195740-1-tanureal@opensource.cirrus.com>
References: <20210305173442.195740-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103050090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Report the Jack events to the user space through ALSA.
Also moves request_threaded_irq() to component_probe so it don't get
interrupts before the initialization the struct snd_soc_jack.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
Changes in v2:
- Don't move the code around
- Removed rename component
- Request IRQ moved back to main probe
- cs42l42_component_remove removed as is not needed anymore

 sound/soc/codecs/cs42l42.c | 70 ++++++++++++++++++++++++++++++--------
 sound/soc/codecs/cs42l42.h |  3 ++
 2 files changed, 59 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 54dd942f3731e..db8c8f0121d12 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -522,10 +522,18 @@ static int cs42l42_component_probe(struct snd_soc_component *component)
 {
 	struct cs42l42_private *cs42l42 =
 		(struct cs42l42_private *)snd_soc_component_get_drvdata(component);
+	struct snd_soc_card *crd = component->card;
+	int ret = 0;
 
 	cs42l42->component = component;
 
-	return 0;
+	ret = snd_soc_card_jack_new(crd, "CS42L42 Headset", SND_JACK_HEADSET | SND_JACK_BTN_0 |
+				    SND_JACK_BTN_1 | SND_JACK_BTN_2 | SND_JACK_BTN_3,
+				    &cs42l42->jack, NULL, 0);
+	if (ret < 0)
+		dev_err(component->dev, "Cannot create CS42L42 Headset: %d\n", ret);
+
+	return ret;
 }
 
 static const struct snd_soc_component_driver soc_component_dev_cs42l42 = {
@@ -1198,7 +1206,7 @@ static void cs42l42_cancel_hs_type_detect(struct cs42l42_private *cs42l42)
 				(3 << CS42L42_HSDET_AUTO_TIME_SHIFT));
 }
 
-static void cs42l42_handle_button_press(struct cs42l42_private *cs42l42)
+static int cs42l42_handle_button_press(struct cs42l42_private *cs42l42)
 {
 	int bias_level;
 	unsigned int detect_status;
@@ -1241,17 +1249,24 @@ static void cs42l42_handle_button_press(struct cs42l42_private *cs42l42)
 
 	switch (bias_level) {
 	case 1: /* Function C button press */
+		bias_level = SND_JACK_BTN_2;
 		dev_dbg(cs42l42->component->dev, "Function C button press\n");
 		break;
 	case 2: /* Function B button press */
+		bias_level = SND_JACK_BTN_1;
 		dev_dbg(cs42l42->component->dev, "Function B button press\n");
 		break;
 	case 3: /* Function D button press */
+		bias_level = SND_JACK_BTN_3;
 		dev_dbg(cs42l42->component->dev, "Function D button press\n");
 		break;
 	case 4: /* Function A button press */
+		bias_level = SND_JACK_BTN_0;
 		dev_dbg(cs42l42->component->dev, "Function A button press\n");
 		break;
+	default:
+		bias_level = 0;
+		break;
 	}
 
 	/* Set button detect level sensitivity back to default */
@@ -1281,6 +1296,8 @@ static void cs42l42_handle_button_press(struct cs42l42_private *cs42l42)
 		(0 << CS42L42_M_HSBIAS_HIZ_SHIFT) |
 		(1 << CS42L42_M_SHORT_RLS_SHIFT) |
 		(1 << CS42L42_M_SHORT_DET_SHIFT));
+
+	return bias_level;
 }
 
 struct cs42l42_irq_params {
@@ -1325,6 +1342,8 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 	unsigned int current_plug_status;
 	unsigned int current_button_status;
 	unsigned int i;
+	int report = 0;
+
 
 	/* Read sticky registers to clear interurpt */
 	for (i = 0; i < ARRAY_SIZE(stickies); i++) {
@@ -1351,9 +1370,20 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 	if ((~masks[5]) & irq_params_table[5].mask) {
 		if (stickies[5] & CS42L42_HSDET_AUTO_DONE_MASK) {
 			cs42l42_process_hs_type_detect(cs42l42);
-			dev_dbg(component->dev,
-				"Auto detect done (%d)\n",
-				cs42l42->hs_type);
+			switch(cs42l42->hs_type){
+			case CS42L42_PLUG_CTIA:
+			case CS42L42_PLUG_OMTP:
+				snd_soc_jack_report(&cs42l42->jack, SND_JACK_HEADSET,
+						    SND_JACK_HEADSET);
+				break;
+			case CS42L42_PLUG_HEADPHONE:
+				snd_soc_jack_report(&cs42l42->jack, SND_JACK_HEADPHONE,
+						    SND_JACK_HEADPHONE);
+				break;
+			default:
+				break;
+			}
+			dev_dbg(component->dev, "Auto detect done (%d)\n", cs42l42->hs_type);
 		}
 	}
 
@@ -1371,8 +1401,19 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 			if (cs42l42->plug_state != CS42L42_TS_UNPLUG) {
 				cs42l42->plug_state = CS42L42_TS_UNPLUG;
 				cs42l42_cancel_hs_type_detect(cs42l42);
-				dev_dbg(component->dev,
-					"Unplug event\n");
+
+				switch(cs42l42->hs_type){
+				case CS42L42_PLUG_CTIA:
+				case CS42L42_PLUG_OMTP:
+					snd_soc_jack_report(&cs42l42->jack, 0, SND_JACK_HEADSET);
+					break;
+				case CS42L42_PLUG_HEADPHONE:
+					snd_soc_jack_report(&cs42l42->jack, 0, SND_JACK_HEADPHONE);
+					break;
+				default:
+					break;
+				}
+				dev_dbg(component->dev, "Unplug event\n");
 			}
 			break;
 
@@ -1387,14 +1428,15 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 		if (!(current_button_status &
 			CS42L42_M_HSBIAS_HIZ_MASK)) {
 
-			if (current_button_status &
-				CS42L42_M_DETECT_TF_MASK) {
-				dev_dbg(component->dev,
-					"Button released\n");
-			} else if (current_button_status &
-				CS42L42_M_DETECT_FT_MASK) {
-				cs42l42_handle_button_press(cs42l42);
+			if (current_button_status & CS42L42_M_DETECT_TF_MASK) {
+				dev_dbg(component->dev, "Button released\n");
+				report = 0;
+			} else if (current_button_status & CS42L42_M_DETECT_FT_MASK) {
+				report = cs42l42_handle_button_press(cs42l42);
+
 			}
+			snd_soc_jack_report(&cs42l42->jack, report, SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+								   SND_JACK_BTN_2 | SND_JACK_BTN_3);
 		}
 	}
 
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index c373259ed46f7..e12828877a20d 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -12,6 +12,8 @@
 #ifndef __CS42L42_H__
 #define __CS42L42_H__
 
+#include <sound/jack.h>
+
 #define CS42L42_PAGE_REGISTER	0x00	/* Page Select Register */
 #define CS42L42_WIN_START	0x00
 #define CS42L42_WIN_LEN		0x100
@@ -768,6 +770,7 @@ struct  cs42l42_private {
 	struct regulator_bulk_data supplies[CS42L42_NUM_SUPPLIES];
 	struct gpio_desc *reset_gpio;
 	struct completion pdn_done;
+	struct snd_soc_jack jack;
 	u32 sclk;
 	u32 srate;
 	u8 plug_state;
-- 
2.30.1

