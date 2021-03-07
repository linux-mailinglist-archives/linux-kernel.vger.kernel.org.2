Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4949D330292
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 16:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbhCGPTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 10:19:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232005AbhCGPSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 10:18:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615130333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sugb3iazT2T0PS0vPR1HftQyv5V++t/whIgIw0rGQuE=;
        b=OJ2wzPlyqpO4SpqKpyYHq93u8cQB/h1yDPfj+1lZiUgpjugelJiALp8jxs8l0MFALnxWBy
        /ySm1LlPFQ88MkNDCJGJwQi9hSuc2Lj5y0eIBMlD6Cx/OtQ2C6scOZsfuwySuIchtLrPKV
        uczBn0b0y2NiQudi1xdvPAk09c0eizw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-88m873hwMPaHx6x044iQWQ-1; Sun, 07 Mar 2021 10:18:52 -0500
X-MC-Unique: 88m873hwMPaHx6x044iQWQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 618EE1005D45;
        Sun,  7 Mar 2021 15:18:50 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-90.ams2.redhat.com [10.36.112.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA8E160BF1;
        Sun,  7 Mar 2021 15:18:44 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v4 resend 11/13] ASoC: arizona-jack: Cleanup logging
Date:   Sun,  7 Mar 2021 16:18:05 +0100
Message-Id: <20210307151807.35201-12-hdegoede@redhat.com>
In-Reply-To: <20210307151807.35201-1-hdegoede@redhat.com>
References: <20210307151807.35201-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup the use of dev_foo functions used for logging:

1. Many of these are unnecessarily split over multiple lines
2. Use dev_err_probe() in cases where we might get a -EPROBE_DEFER
   return value

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v4:
- While at it also change (on adjescent lines) "if (ret != 0)" into "if (ret)"
- Do not unnecessary split one of the dev_err_probe() calls over multiple lines

Changes in v3:
- This is a new patch in v3 of this patch-series
---
 sound/soc/codecs/arizona-jack.c | 145 +++++++++++---------------------
 1 file changed, 51 insertions(+), 94 deletions(-)

diff --git a/sound/soc/codecs/arizona-jack.c b/sound/soc/codecs/arizona-jack.c
index 268d2a44d891..9c15ddba6008 100644
--- a/sound/soc/codecs/arizona-jack.c
+++ b/sound/soc/codecs/arizona-jack.c
@@ -123,9 +123,8 @@ static void arizona_extcon_hp_clamp(struct arizona_priv *info,
 					 ARIZONA_HP_TEST_CTRL_1,
 					 ARIZONA_HP1_TST_CAP_SEL_MASK,
 					 cap_sel);
-		if (ret != 0)
-			dev_warn(arizona->dev,
-				 "Failed to set TST_CAP_SEL: %d\n", ret);
+		if (ret)
+			dev_warn(arizona->dev, "Failed to set TST_CAP_SEL: %d\n", ret);
 		break;
 	default:
 		mask = ARIZONA_RMV_SHRT_HP1L;
@@ -144,24 +143,20 @@ static void arizona_extcon_hp_clamp(struct arizona_priv *info,
 					 ARIZONA_OUTPUT_ENABLES_1,
 					 ARIZONA_OUT1L_ENA |
 					 ARIZONA_OUT1R_ENA, 0);
-		if (ret != 0)
-			dev_warn(arizona->dev,
-				"Failed to disable headphone outputs: %d\n",
-				 ret);
+		if (ret)
+			dev_warn(arizona->dev, "Failed to disable headphone outputs: %d\n", ret);
 	}
 
 	if (mask) {
 		ret = regmap_update_bits(arizona->regmap, ARIZONA_HP_CTRL_1L,
 					 mask, val);
-		if (ret != 0)
-			dev_warn(arizona->dev, "Failed to do clamp: %d\n",
-				 ret);
+		if (ret)
+			dev_warn(arizona->dev, "Failed to do clamp: %d\n", ret);
 
 		ret = regmap_update_bits(arizona->regmap, ARIZONA_HP_CTRL_1R,
 					 mask, val);
-		if (ret != 0)
-			dev_warn(arizona->dev, "Failed to do clamp: %d\n",
-				 ret);
+		if (ret)
+			dev_warn(arizona->dev, "Failed to do clamp: %d\n", ret);
 	}
 
 	/* Restore the desired state while not doing the clamp */
@@ -170,10 +165,8 @@ static void arizona_extcon_hp_clamp(struct arizona_priv *info,
 					 ARIZONA_OUTPUT_ENABLES_1,
 					 ARIZONA_OUT1L_ENA |
 					 ARIZONA_OUT1R_ENA, arizona->hp_ena);
-		if (ret != 0)
-			dev_warn(arizona->dev,
-				 "Failed to restore headphone outputs: %d\n",
-				 ret);
+		if (ret)
+			dev_warn(arizona->dev, "Failed to restore headphone outputs: %d\n", ret);
 	}
 
 	snd_soc_dapm_mutex_unlock(arizona->dapm);
@@ -223,17 +216,15 @@ static void arizona_extcon_pulse_micbias(struct arizona_priv *info)
 	int ret;
 
 	ret = snd_soc_component_force_enable_pin(component, widget);
-	if (ret != 0)
-		dev_warn(arizona->dev, "Failed to enable %s: %d\n",
-			 widget, ret);
+	if (ret)
+		dev_warn(arizona->dev, "Failed to enable %s: %d\n", widget, ret);
 
 	snd_soc_dapm_sync(dapm);
 
 	if (!arizona->pdata.micd_force_micbias) {
 		ret = snd_soc_component_disable_pin(component, widget);
-		if (ret != 0)
-			dev_warn(arizona->dev, "Failed to disable %s: %d\n",
-				 widget, ret);
+		if (ret)
+			dev_warn(arizona->dev, "Failed to disable %s: %d\n", widget, ret);
 
 		snd_soc_dapm_sync(dapm);
 	}
@@ -251,18 +242,13 @@ static void arizona_start_mic(struct arizona_priv *info)
 
 	if (info->detecting) {
 		ret = regulator_allow_bypass(info->micvdd, false);
-		if (ret != 0) {
-			dev_err(arizona->dev,
-				"Failed to regulate MICVDD: %d\n",
-				ret);
-		}
+		if (ret)
+			dev_err(arizona->dev, "Failed to regulate MICVDD: %d\n", ret);
 	}
 
 	ret = regulator_enable(info->micvdd);
-	if (ret != 0) {
-		dev_err(arizona->dev, "Failed to enable MICVDD: %d\n",
-			ret);
-	}
+	if (ret)
+		dev_err(arizona->dev, "Failed to enable MICVDD: %d\n", ret);
 
 	if (info->micd_reva) {
 		const struct reg_sequence reva[] = {
@@ -312,10 +298,8 @@ static void arizona_stop_mic(struct arizona_priv *info)
 		dev_err(arizona->dev, "Failed to disable micd: %d\n", ret);
 
 	ret = snd_soc_component_disable_pin(component, widget);
-	if (ret != 0)
-		dev_warn(arizona->dev,
-			 "Failed to disable %s: %d\n",
-			 widget, ret);
+	if (ret)
+		dev_warn(arizona->dev, "Failed to disable %s: %d\n", widget, ret);
 
 	snd_soc_dapm_sync(dapm);
 
@@ -330,10 +314,8 @@ static void arizona_stop_mic(struct arizona_priv *info)
 	}
 
 	ret = regulator_allow_bypass(info->micvdd, true);
-	if (ret != 0) {
-		dev_err(arizona->dev, "Failed to bypass MICVDD: %d\n",
-			ret);
-	}
+	if (ret)
+		dev_err(arizona->dev, "Failed to bypass MICVDD: %d\n", ret);
 
 	if (change) {
 		regulator_disable(info->micvdd);
@@ -371,17 +353,15 @@ static int arizona_hpdet_read(struct arizona_priv *info)
 	int ret;
 
 	ret = regmap_read(arizona->regmap, ARIZONA_HEADPHONE_DETECT_2, &val);
-	if (ret != 0) {
-		dev_err(arizona->dev, "Failed to read HPDET status: %d\n",
-			ret);
+	if (ret) {
+		dev_err(arizona->dev, "Failed to read HPDET status: %d\n", ret);
 		return ret;
 	}
 
 	switch (info->hpdet_ip_version) {
 	case 0:
 		if (!(val & ARIZONA_HP_DONE)) {
-			dev_err(arizona->dev, "HPDET did not complete: %x\n",
-				val);
+			dev_err(arizona->dev, "HPDET did not complete: %x\n", val);
 			return -EAGAIN;
 		}
 
@@ -390,15 +370,13 @@ static int arizona_hpdet_read(struct arizona_priv *info)
 
 	case 1:
 		if (!(val & ARIZONA_HP_DONE_B)) {
-			dev_err(arizona->dev, "HPDET did not complete: %x\n",
-				val);
+			dev_err(arizona->dev, "HPDET did not complete: %x\n", val);
 			return -EAGAIN;
 		}
 
 		ret = regmap_read(arizona->regmap, ARIZONA_HP_DACVAL, &val);
-		if (ret != 0) {
-			dev_err(arizona->dev, "Failed to read HP value: %d\n",
-				ret);
+		if (ret) {
+			dev_err(arizona->dev, "Failed to read HP value: %d\n", ret);
 			return -EAGAIN;
 		}
 
@@ -411,8 +389,7 @@ static int arizona_hpdet_read(struct arizona_priv *info)
 		    (val < arizona_hpdet_b_ranges[range].threshold ||
 		     val >= ARIZONA_HPDET_B_RANGE_MAX)) {
 			range++;
-			dev_dbg(arizona->dev, "Moving to HPDET range %d\n",
-				range);
+			dev_dbg(arizona->dev, "Moving to HPDET range %d\n", range);
 			regmap_update_bits(arizona->regmap,
 					   ARIZONA_HEADPHONE_DETECT_1,
 					   ARIZONA_HP_IMPEDANCE_RANGE_MASK,
@@ -428,8 +405,7 @@ static int arizona_hpdet_read(struct arizona_priv *info)
 			return ARIZONA_HPDET_MAX;
 		}
 
-		dev_dbg(arizona->dev, "HPDET read %d in range %d\n",
-			val, range);
+		dev_dbg(arizona->dev, "HPDET read %d in range %d\n", val, range);
 
 		val = arizona_hpdet_b_ranges[range].factor_b
 			/ ((val * 100) -
@@ -438,8 +414,7 @@ static int arizona_hpdet_read(struct arizona_priv *info)
 
 	case 2:
 		if (!(val & ARIZONA_HP_DONE_B)) {
-			dev_err(arizona->dev, "HPDET did not complete: %x\n",
-				val);
+			dev_err(arizona->dev, "HPDET did not complete: %x\n", val);
 			return -EAGAIN;
 		}
 
@@ -475,8 +450,7 @@ static int arizona_hpdet_read(struct arizona_priv *info)
 		break;
 
 	default:
-		dev_warn(arizona->dev, "Unknown HPDET IP revision %d\n",
-			 info->hpdet_ip_version);
+		dev_warn(arizona->dev, "Unknown HPDET IP revision %d\n", info->hpdet_ip_version);
 		return -EINVAL;
 	}
 
@@ -664,9 +638,8 @@ static void arizona_identify_headphone(struct arizona_priv *info)
 
 	ret = regmap_update_bits(arizona->regmap, ARIZONA_HEADPHONE_DETECT_1,
 				 ARIZONA_HP_POLL, ARIZONA_HP_POLL);
-	if (ret != 0) {
-		dev_err(arizona->dev, "Can't start HPDETL measurement: %d\n",
-			ret);
+	if (ret) {
+		dev_err(arizona->dev, "Can't start HPDETL measurement: %d\n", ret);
 		goto err;
 	}
 
@@ -716,10 +689,8 @@ static void arizona_start_hpdet_acc_id(struct arizona_priv *info)
 		ret = regmap_update_bits(arizona->regmap,
 					 ARIZONA_HEADPHONE_DETECT_1,
 					 ARIZONA_HP_POLL, ARIZONA_HP_POLL);
-		if (ret != 0) {
-			dev_err(arizona->dev,
-				"Can't start HPDETL measurement: %d\n",
-				ret);
+		if (ret) {
+			dev_err(arizona->dev, "Can't start HPDETL measurement: %d\n", ret);
 			goto err;
 		}
 	} else {
@@ -764,9 +735,8 @@ static int arizona_micd_adc_read(struct arizona_priv *info)
 			   ARIZONA_MICD_ENA, 0);
 
 	ret = regmap_read(arizona->regmap, ARIZONA_MIC_DETECT_4, &val);
-	if (ret != 0) {
-		dev_err(arizona->dev,
-			"Failed to read MICDET_ADCVAL: %d\n", ret);
+	if (ret) {
+		dev_err(arizona->dev, "Failed to read MICDET_ADCVAL: %d\n", ret);
 		return ret;
 	}
 
@@ -798,17 +768,15 @@ static int arizona_micd_read(struct arizona_priv *info)
 
 	for (i = 0; i < 10 && !(val & MICD_LVL_0_TO_8); i++) {
 		ret = regmap_read(arizona->regmap, ARIZONA_MIC_DETECT_3, &val);
-		if (ret != 0) {
-			dev_err(arizona->dev,
-				"Failed to read MICDET: %d\n", ret);
+		if (ret) {
+			dev_err(arizona->dev, "Failed to read MICDET: %d\n", ret);
 			return ret;
 		}
 
 		dev_dbg(arizona->dev, "MICDET: %x\n", val);
 
 		if (!(val & ARIZONA_MICD_VALID)) {
-			dev_warn(arizona->dev,
-				 "Microphone detection state invalid\n");
+			dev_warn(arizona->dev, "Microphone detection state invalid\n");
 			return -EINVAL;
 		}
 	}
@@ -856,10 +824,8 @@ static int arizona_micdet_reading(void *priv)
 
 		/* Don't need to regulate for button detection */
 		ret = regulator_allow_bypass(info->micvdd, true);
-		if (ret != 0) {
-			dev_err(arizona->dev, "Failed to bypass MICVDD: %d\n",
-				ret);
-		}
+		if (ret)
+			dev_err(arizona->dev, "Failed to bypass MICVDD: %d\n", ret);
 
 		return 0;
 	}
@@ -941,8 +907,7 @@ static int arizona_button_reading(void *priv)
 				dev_err(arizona->dev, "Button out of range\n");
 			}
 		} else {
-			dev_warn(arizona->dev, "Button with no mic: %x\n",
-				 val);
+			dev_warn(arizona->dev, "Button with no mic: %x\n", val);
 		}
 	} else {
 		dev_dbg(arizona->dev, "Mic button released\n");
@@ -1025,8 +990,7 @@ static int arizona_hpdet_wait(struct arizona_priv *info)
 		ret = regmap_read(arizona->regmap, ARIZONA_HEADPHONE_DETECT_2,
 				&val);
 		if (ret) {
-			dev_err(arizona->dev,
-				"Failed to read HPDET state: %d\n", ret);
+			dev_err(arizona->dev, "Failed to read HPDET state: %d\n", ret);
 			return ret;
 		}
 
@@ -1076,9 +1040,8 @@ static irqreturn_t arizona_jackdet(int irq, void *data)
 	}
 
 	ret = regmap_read(arizona->regmap, ARIZONA_AOD_IRQ_RAW_STATUS, &val);
-	if (ret != 0) {
-		dev_err(arizona->dev, "Failed to read jackdet status: %d\n",
-			ret);
+	if (ret) {
+		dev_err(arizona->dev, "Failed to read jackdet status: %d\n", ret);
 		mutex_unlock(&info->lock);
 		pm_runtime_put_autosuspend(arizona->dev);
 		return IRQ_NONE;
@@ -1248,8 +1211,7 @@ static int arizona_extcon_device_get_pdata(struct device *dev,
 		pdata->hpdet_channel = val;
 		break;
 	default:
-		dev_err(arizona->dev,
-			"Wrong wlf,hpdet-channel DT value %d\n", val);
+		dev_err(arizona->dev, "Wrong wlf,hpdet-channel DT value %d\n", val);
 		pdata->hpdet_channel = ARIZONA_ACCDET_MODE_HPL;
 	}
 
@@ -1301,11 +1263,8 @@ int arizona_jack_codec_dev_probe(struct arizona_priv *info, struct device *dev)
 		arizona_extcon_device_get_pdata(dev, arizona);
 
 	info->micvdd = devm_regulator_get(dev, "MICVDD");
-	if (IS_ERR(info->micvdd)) {
-		ret = PTR_ERR(info->micvdd);
-		dev_err(arizona->dev, "Failed to get MICVDD: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(info->micvdd))
+		return dev_err_probe(arizona->dev, PTR_ERR(info->micvdd), "getting MICVDD\n");
 
 	mutex_init(&info->lock);
 	info->last_jackdet = ~(ARIZONA_MICD_CLAMP_STS | ARIZONA_JD1_STS);
@@ -1391,9 +1350,7 @@ int arizona_jack_codec_dev_probe(struct arizona_priv *info, struct device *dev)
 							 mode);
 		if (IS_ERR(info->micd_pol_gpio)) {
 			ret = PTR_ERR(info->micd_pol_gpio);
-			dev_err(arizona->dev,
-				"Failed to get microphone polarity GPIO: %d\n",
-				ret);
+			dev_err_probe(arizona->dev, ret, "getting microphone polarity GPIO\n");
 			return ret;
 		}
 	}
-- 
2.30.1

