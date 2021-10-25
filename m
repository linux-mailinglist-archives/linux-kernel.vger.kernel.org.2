Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEF64394B4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 13:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhJYLZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 07:25:38 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:29558 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232400AbhJYLZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 07:25:35 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19P5jNM9005112;
        Mon, 25 Oct 2021 06:23:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=VPcBbAqi2DbB27wZnmeP2IfVFq+8fG1M95X3zZOgA+c=;
 b=oFo4CXz/hhrrVTRnLL1VkDhU117ES+EF4wfEBQfrpp97+q3VSrtd9fRXSRViPH1GWBBq
 YCozk+NQbi+4K/N3FsLD5u/mprWExzIXP/OmHEgkQ59kPyN73KcJznFPkBPATHwMRMwX
 0o+fZCPkWlKALJnXGO8JMpbv9KbcNi545pUc2JqGOcVcWJlc3oay6EOXpRNz9EF/W7IC
 KEjgsJXgN0obW3aUljIVdsZ3HcY6xkB9wnrEoCozZSRfi59Y5dZ5poY0xaCr3AE1TZEQ
 ExNIVB0LIX909b73bJyIqXh1eweyHxSYW8sVsEx562m3pfzplKWRWD+U3vBe/DqRvLL/ Jw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3bw93g0xk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 25 Oct 2021 06:23:02 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 25 Oct
 2021 12:23:01 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Mon, 25 Oct 2021 12:23:01 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.32])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 347C0B0E;
        Mon, 25 Oct 2021 11:23:00 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs42l42: Prevent NULL pointer deref in interrupt handler
Date:   Mon, 25 Oct 2021 12:22:58 +0100
Message-ID: <20211025112258.9282-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: -H10n29Z69bf9x30lcrcu8m6FCZai6Zx
X-Proofpoint-ORIG-GUID: -H10n29Z69bf9x30lcrcu8m6FCZai6Zx
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt handling code was getting the struct device* from a
struct snd_soc_component* stored in struct cs42l42_private. If the
interrupt was asserted before ASoC calls component_probe() the
snd_soc_component* will be NULL.

The stored snd_soc_component* is not actually used for anything other
than indirectly getting the struct device*. Remove it, and store the
struct device* in struct cs42l42_private.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 28 +++++++++-------------------
 sound/soc/codecs/cs42l42.h |  2 +-
 2 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 0dbe4e23194b..a8fff274ec63 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -526,17 +526,7 @@ static int cs42l42_set_jack(struct snd_soc_component *component, struct snd_soc_
 	return 0;
 }
 
-static int cs42l42_component_probe(struct snd_soc_component *component)
-{
-	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
-
-	cs42l42->component = component;
-
-	return 0;
-}
-
 static const struct snd_soc_component_driver soc_component_dev_cs42l42 = {
-	.probe			= cs42l42_component_probe,
 	.set_jack		= cs42l42_set_jack,
 	.dapm_widgets		= cs42l42_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(cs42l42_dapm_widgets),
@@ -1207,7 +1197,7 @@ static void cs42l42_process_hs_type_detect(struct cs42l42_private *cs42l42)
 	 */
 	if (cs42l42->hs_type == CS42L42_PLUG_INVALID ||
 		cs42l42->hs_type == CS42L42_PLUG_HEADPHONE) {
-		dev_dbg(cs42l42->component->dev, "Running Manual Detection Fallback\n");
+		dev_dbg(cs42l42->dev, "Running Manual Detection Fallback\n");
 		cs42l42_manual_hs_type_detect(cs42l42);
 	}
 
@@ -1506,19 +1496,19 @@ static int cs42l42_handle_button_press(struct cs42l42_private *cs42l42)
 	switch (bias_level) {
 	case 1: /* Function C button press */
 		bias_level = SND_JACK_BTN_2;
-		dev_dbg(cs42l42->component->dev, "Function C button press\n");
+		dev_dbg(cs42l42->dev, "Function C button press\n");
 		break;
 	case 2: /* Function B button press */
 		bias_level = SND_JACK_BTN_1;
-		dev_dbg(cs42l42->component->dev, "Function B button press\n");
+		dev_dbg(cs42l42->dev, "Function B button press\n");
 		break;
 	case 3: /* Function D button press */
 		bias_level = SND_JACK_BTN_3;
-		dev_dbg(cs42l42->component->dev, "Function D button press\n");
+		dev_dbg(cs42l42->dev, "Function D button press\n");
 		break;
 	case 4: /* Function A button press */
 		bias_level = SND_JACK_BTN_0;
-		dev_dbg(cs42l42->component->dev, "Function A button press\n");
+		dev_dbg(cs42l42->dev, "Function A button press\n");
 		break;
 	default:
 		bias_level = 0;
@@ -1592,7 +1582,6 @@ static const struct cs42l42_irq_params irq_params_table[] = {
 static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 {
 	struct cs42l42_private *cs42l42 = (struct cs42l42_private *)data;
-	struct snd_soc_component *component = cs42l42->component;
 	unsigned int stickies[12];
 	unsigned int masks[12];
 	unsigned int current_plug_status;
@@ -1639,7 +1628,7 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 			default:
 				break;
 			}
-			dev_dbg(component->dev, "Auto detect done (%d)\n", cs42l42->hs_type);
+			dev_dbg(cs42l42->dev, "Auto detect done (%d)\n", cs42l42->hs_type);
 		}
 	}
 
@@ -1673,7 +1662,7 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 						    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 						    SND_JACK_BTN_2 | SND_JACK_BTN_3);
 
-				dev_dbg(component->dev, "Unplug event\n");
+				dev_dbg(cs42l42->dev, "Unplug event\n");
 			}
 			break;
 
@@ -1689,7 +1678,7 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 			CS42L42_M_HSBIAS_HIZ_MASK)) {
 
 			if (current_button_status & CS42L42_M_DETECT_TF_MASK) {
-				dev_dbg(component->dev, "Button released\n");
+				dev_dbg(cs42l42->dev, "Button released\n");
 				report = 0;
 			} else if (current_button_status & CS42L42_M_DETECT_FT_MASK) {
 				report = cs42l42_handle_button_press(cs42l42);
@@ -2043,6 +2032,7 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 	if (!cs42l42)
 		return -ENOMEM;
 
+	cs42l42->dev = &i2c_client->dev;
 	i2c_set_clientdata(i2c_client, cs42l42);
 
 	cs42l42->regmap = devm_regmap_init_i2c(i2c_client, &cs42l42_regmap);
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index dd4744de9e0a..f45bcc9a3a62 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -833,7 +833,7 @@ static const char *const cs42l42_supply_names[CS42L42_NUM_SUPPLIES] = {
 
 struct  cs42l42_private {
 	struct regmap *regmap;
-	struct snd_soc_component *component;
+	struct device *dev;
 	struct regulator_bulk_data supplies[CS42L42_NUM_SUPPLIES];
 	struct gpio_desc *reset_gpio;
 	struct completion pdn_done;
-- 
2.11.0

