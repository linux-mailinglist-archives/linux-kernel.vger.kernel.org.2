Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42059456F16
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 13:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhKSMwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 07:52:08 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:3518 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbhKSMwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 07:52:07 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AJCUn57016559;
        Fri, 19 Nov 2021 06:49:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=1KG6WEM5pcit/0cOBrJixvTwEkGLUWH0S9yAWcmK2K8=;
 b=k8d6gBvqOmlYfOzN6HioKcSb3hbK4/x6I43XRAQ/QdRJN4GqTJlGBNrpR/673gBQGCZj
 w/5ZyONTLdC33fdMAdKHFOdvGtIrGLBmSOw6AU9SVuAlRwLFNeOxpt2jWE4rMNhST6YQ
 MJI89U5ed/tRATIOISibkISzvFaippCg/hf/z+bCqPREWt6+aIgZk6W7Dg91AszFlV/T
 l5qGg1272NY/lA3PJ+0sNPAH48Z7f+uHoS/LEDOnIQqlpbdNEsej7/2+DjOII7mjWnqr
 j1am/FRKoebyVYiUsLCAfy5h8VFQpX8IwZHigzCHLwxxYdiLnT4v5+Lslqkuqj+DGLlp AQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cdj9esurs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Nov 2021 06:48:59 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 12:48:58 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 19 Nov 2021 12:48:58 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.41])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 911CF2A1;
        Fri, 19 Nov 2021 12:48:57 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs42l42: Report initial jack state
Date:   Fri, 19 Nov 2021 12:48:54 +0000
Message-ID: <20211119124854.58939-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 8fAUTdm_apuBc1B3nsIPDGY3x06OleEg
X-Proofpoint-ORIG-GUID: 8fAUTdm_apuBc1B3nsIPDGY3x06OleEg
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a jack handler is registered in cs42l42_set_jack() the
initial state should be reported if an attached headphone/headset
has already been detected.

The jack detect sequence takes around 1 second: typically long
enough for the machine driver to probe and register the jack handler
in time to receive the first report from the interrupt handler. So
it is possible on some systems that the correct initial state was seen
simply because of lucky timing. Modular builds were more likely to
miss the reporting of the initial state.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 4ca239f33737 ("ASoC: cs42l42: Always enable TS_PLUG and TS_UNPLUG interrupts")
---
 sound/soc/codecs/cs42l42.c | 22 ++++++++++++++++++++++
 sound/soc/codecs/cs42l42.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 0c4303547fd8..43d98bdb5b5b 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -549,8 +549,25 @@ static int cs42l42_set_jack(struct snd_soc_component *component, struct snd_soc_
 {
 	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
 
+	/* Prevent race with interrupt handler */
+	mutex_lock(&cs42l42->jack_detect_mutex);
 	cs42l42->jack = jk;
 
+	if (jk) {
+		switch (cs42l42->hs_type) {
+		case CS42L42_PLUG_CTIA:
+		case CS42L42_PLUG_OMTP:
+			snd_soc_jack_report(jk, SND_JACK_HEADSET, SND_JACK_HEADSET);
+			break;
+		case CS42L42_PLUG_HEADPHONE:
+			snd_soc_jack_report(jk, SND_JACK_HEADPHONE, SND_JACK_HEADPHONE);
+			break;
+		default:
+			break;
+		}
+	}
+	mutex_unlock(&cs42l42->jack_detect_mutex);
+
 	return 0;
 }
 
@@ -1618,6 +1635,8 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 		CS42L42_M_DETECT_FT_MASK |
 		CS42L42_M_HSBIAS_HIZ_MASK);
 
+	mutex_lock(&cs42l42->jack_detect_mutex);
+
 	/* Check auto-detect status */
 	if ((~masks[5]) & irq_params_table[5].mask) {
 		if (stickies[5] & CS42L42_HSDET_AUTO_DONE_MASK) {
@@ -1686,6 +1705,8 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 		}
 	}
 
+	mutex_unlock(&cs42l42->jack_detect_mutex);
+
 	return IRQ_HANDLED;
 }
 
@@ -2033,6 +2054,7 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 
 	cs42l42->dev = &i2c_client->dev;
 	i2c_set_clientdata(i2c_client, cs42l42);
+	mutex_init(&cs42l42->jack_detect_mutex);
 
 	cs42l42->regmap = devm_regmap_init_i2c(i2c_client, &cs42l42_regmap);
 	if (IS_ERR(cs42l42->regmap)) {
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 75ade987d0db..9fff183dce8e 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -12,6 +12,7 @@
 #ifndef __CS42L42_H__
 #define __CS42L42_H__
 
+#include <linux/mutex.h>
 #include <sound/jack.h>
 
 #define CS42L42_PAGE_REGISTER	0x00	/* Page Select Register */
@@ -841,6 +842,7 @@ struct  cs42l42_private {
 	struct gpio_desc *reset_gpio;
 	struct completion pdn_done;
 	struct snd_soc_jack *jack;
+	struct mutex jack_detect_mutex;
 	int pll_config;
 	int bclk;
 	u32 sclk;
-- 
2.11.0

