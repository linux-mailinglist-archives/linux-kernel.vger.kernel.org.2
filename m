Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC873BE76F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 13:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhGGLy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 07:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhGGLy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 07:54:26 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019AAC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 04:51:46 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x3so922270pll.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 04:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oqyImscKIGHZdWry/NO6O15x9HwF7lH+KNgTMvp4IP0=;
        b=nbjaO/HS0vRkQUSzhOQo9OGmH9xkCc9dGZpPoV3gE/kGsalVhEFP8DqSM3ZS72N06C
         qHTWo46p/T+D1LLDr2KOYgCDAo6ybCAIFjTUcbofaIEyw4V60P6obGnOQdme2OjLBw1v
         ifxVbix1no0tLjRBnPpMxH1REEt4UI68aCE5to70vjO0sdEETxocHhkhCeTyr52mL2IX
         r8T49p4tjDZFOiA9Q0vvmbrsx79H0cdgHBD5glF6MGZyq2cog+i67iwfkIIsJ5rtYs5/
         AKr5tvIgFDPqDG2O0Qo5RupZsG8li/fSoDlcu/Sb0GPJLeI8tpHBMBPNQiBfQMH+HgpE
         C51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oqyImscKIGHZdWry/NO6O15x9HwF7lH+KNgTMvp4IP0=;
        b=SngaOi9zKZvR0vAehTw5zgxdIpCXnJibSdPCY8Ll5SXyvxuh7ygF+rRQSW/Yc3VHNp
         exSl4BfGa9IcG9j3wKOQwKfL6tru+nyU7zIJhmFTQaIm9q4L2gWJmarCzmnpMBpbxwN9
         Bj/Rx2UOkt3iwA+iEpTdaZAm7JGk+STW2XFVqhqjbVA/KQQsttYIWWdA5NVwRRtKk0z7
         TFkZeuj+peTwHfpttHXL3i1y2gAPwYEwW5Mqv3rHQMeJDlrTsVINntTMWTUsMEk0fQQa
         he46dOp/wCZ6HeV42HGTdGoZlcrz2kYydAZTse/pdZGcc718qignlvm4fyeQF/wqlcg8
         6YlQ==
X-Gm-Message-State: AOAM531QL6zJ89gzCo5WwzGjz4FnQ8kgLEPNubhMOge2YkyKeMcrxu20
        03gAyKBDz+hoBX56FBBgxXU=
X-Google-Smtp-Source: ABdhPJwCqWNYOYzIehnlB6QDB9F908y6VC7TdG0vhGLlJW0hfnDzf08sbaJiDGmxvy3A7PITrAtuuQ==
X-Received: by 2002:a17:902:b7c2:b029:128:c1cd:241e with SMTP id v2-20020a170902b7c2b0290128c1cd241emr21172571plz.14.1625658705391;
        Wed, 07 Jul 2021 04:51:45 -0700 (PDT)
Received: from ubuntu.localdomain ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id i24sm17795473pfr.56.2021.07.07.04.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 04:51:44 -0700 (PDT)
From:   Gu Shengxian <gushengxian507419@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, james.schulman@cirrus.com,
        david.rhodes@cirrus.com, matthias.bgg@gmail.com
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Gu Shengxian <gushengxian@yulong.com>
Subject: [PATCH] ASoC: codecs: remove unneeded variable: "ret"
Date:   Wed,  7 Jul 2021 19:51:30 +0800
Message-Id: <20210707115131.9060-1-gushengxian507419@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gu Shengxian <gushengxian@yulong.com>

The variable: "ret" is only defined and returned.
So it could be removed.
Fix some spelling mistakes.

Signed-off-by: Gu Shengxian <gushengxian@yulong.com>
---
 sound/soc/codecs/ad1836.c        |  2 +-
 sound/soc/codecs/adau1372.c      |  2 +-
 sound/soc/codecs/adau1701.c      |  2 +-
 sound/soc/codecs/adau17x1.c      |  2 +-
 sound/soc/codecs/adau1977.c      |  2 +-
 sound/soc/codecs/ak4554.c        |  2 +-
 sound/soc/codecs/ak4613.c        |  2 +-
 sound/soc/codecs/alc5632.c       |  2 +-
 sound/soc/codecs/arizona.c       |  2 +-
 sound/soc/codecs/cpcap.c         |  2 +-
 sound/soc/codecs/cs35l33.c       |  2 +-
 sound/soc/codecs/cs35l34.c       |  2 +-
 sound/soc/codecs/cs35l36.c       |  2 +-
 sound/soc/codecs/cs4270.c        |  2 +-
 sound/soc/codecs/cs42l42.c       |  2 +-
 sound/soc/codecs/cs42l73.c       |  2 +-
 sound/soc/codecs/cs42xx8.c       |  2 +-
 sound/soc/codecs/cx20442.c       |  4 ++--
 sound/soc/codecs/cx2072x.c       |  6 +++---
 sound/soc/codecs/cx2072x.h       |  2 +-
 sound/soc/codecs/da7210.c        |  2 +-
 sound/soc/codecs/da7213.c        |  2 +-
 sound/soc/codecs/hdac_hda.c      |  2 +-
 sound/soc/codecs/hdac_hdmi.c     |  6 +++---
 sound/soc/codecs/max98088.c      |  2 +-
 sound/soc/codecs/max98373.c      |  2 +-
 sound/soc/codecs/max98390.c      |  2 +-
 sound/soc/codecs/max98927.c      |  4 ++--
 sound/soc/codecs/mt6359-accdet.c |  2 +-
 sound/soc/codecs/mt6359.c        | 10 +++++-----
 sound/soc/codecs/wcd938x.c       |  6 ++----
 31 files changed, 42 insertions(+), 44 deletions(-)

diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index 08a5651bed9f..2db3e42fc6c1 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -265,7 +265,7 @@ static int ad1836_probe(struct snd_soc_component *component)
 	regmap_write(ad1836->regmap, AD1836_DAC_CTRL2, 0x0);
 	/* high-pass filter enable, power-on adc */
 	regmap_write(ad1836->regmap, AD1836_ADC_CTRL1, 0x100);
-	/* unmute adc channles, adc aux mode */
+	/* unmute adc channels, adc aux mode */
 	regmap_write(ad1836->regmap, AD1836_ADC_CTRL2, 0x180);
 	/* volume */
 	for (i = 1; i <= num_dacs; ++i) {
diff --git a/sound/soc/codecs/adau1372.c b/sound/soc/codecs/adau1372.c
index 6811a8b3866d..6e9061c60f9f 100644
--- a/sound/soc/codecs/adau1372.c
+++ b/sound/soc/codecs/adau1372.c
@@ -684,7 +684,7 @@ static int adau1372_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 
 	/* I2S mode */
 	if (slots == 0) {
-		/* The other settings dont matter in I2S mode */
+		/* The other settings don't matter in I2S mode */
 		regmap_update_bits(adau1372->regmap, ADAU1372_REG_SAI0,
 				   ADAU1372_SAI0_SAI_MASK, ADAU1372_SAI0_SAI_I2S);
 		adau1372->rate_constraints.mask = ADAU1372_RATE_MASK_TDM2;
diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index 5ce74697564a..ab6fcfca7506 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -689,7 +689,7 @@ static int adau1701_probe(struct snd_soc_component *component)
 	 */
 	adau1701->pll_clkdiv = ADAU1707_CLKDIV_UNSET;
 
-	/* initalize with pre-configured pll mode settings */
+	/* initialize with pre-configured pll mode settings */
 	ret = adau1701_reset(component, adau1701->pll_clkdiv, 0);
 	if (ret < 0)
 		goto exit_regulators_disable;
diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index 8aae7ab74091..c6df4272363c 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -876,7 +876,7 @@ static int adau17x1_setup_firmware(struct snd_soc_component *component,
 	 * point in performing the below steps as the call to
 	 * sigmadsp_setup(...) will return directly when it finds the sample
 	 * rate to be the same as before. By checking this we can prevent an
-	 * audiable popping noise which occours when toggling DSP_RUN.
+	 * audible popping noise which occurs when toggling DSP_RUN.
 	 */
 	if (adau->sigmadsp->current_samplerate == rate)
 		return 0;
diff --git a/sound/soc/codecs/adau1977.c b/sound/soc/codecs/adau1977.c
index e347a48131d1..9e40a223a7fa 100644
--- a/sound/soc/codecs/adau1977.c
+++ b/sound/soc/codecs/adau1977.c
@@ -241,7 +241,7 @@ static int adau1977_reset(struct adau1977 *adau1977)
 }
 
 /*
- * Returns the appropriate setting for ths FS field in the CTRL0 register
+ * Returns the appropriate setting for the FS field in the CTRL0 register
  * depending on the rate.
  */
 static int adau1977_lookup_fs(unsigned int rate)
diff --git a/sound/soc/codecs/ak4554.c b/sound/soc/codecs/ak4554.c
index 8e60e2b56ad6..1e79ac831f69 100644
--- a/sound/soc/codecs/ak4554.c
+++ b/sound/soc/codecs/ak4554.c
@@ -19,7 +19,7 @@
  *
  * CPU/Codec DAI image
  *
- * CPU-DAI1 (plaback only fmt = RIGHT_J) --+-- ak4554
+ * CPU-DAI1 (playback only fmt = RIGHT_J) --+-- ak4554
  *					   |
  * CPU-DAI2 (capture only fmt = LEFT_J) ---+
  */
diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index 4d2e78101f28..ed8a069129a5 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -521,7 +521,7 @@ static int ak4613_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	 *
 	 * Calling ak4613_dummy_write() function might be delayed.
 	 * In such case, ak4613 volume might be temporarily 0dB when
-	 * beggining of playback.
+	 * beginning of playback.
 	 * see also
 	 *	ak4613_dummy_write()
 	 */
diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 79813882a955..df6a6da681cf 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -149,7 +149,7 @@ static const DECLARE_TLV_DB_RANGE(boost_tlv,
 );
 /* 0db min scale, 6 db steps, no mute */
 static const DECLARE_TLV_DB_SCALE(dig_tlv, 0, 600, 0);
-/* 0db min scalem 0.75db steps, no mute */
+/* 0db min scale 0.75db steps, no mute */
 static const DECLARE_TLV_DB_SCALE(vdac_tlv, -3525, 75, 0);
 
 static const struct snd_kcontrol_new alc5632_vol_snd_controls[] = {
diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index e32871b3f68a..f7f6c5925a41 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -2261,7 +2261,7 @@ static int arizona_calc_fll(struct arizona_fll *fll,
 
 	arizona_fll_dbg(fll, "Fref=%u Fout=%u\n", Fref, fll->fout);
 
-	/* Fvco should be over the targt; don't check the upper bound */
+	/* Fvco should be over the target; don't check the upper bound */
 	div = ARIZONA_FLL_MIN_OUTDIV;
 	while (fll->fout * div < ARIZONA_FLL_MIN_FVCO * fll->vco_mult) {
 		div++;
diff --git a/sound/soc/codecs/cpcap.c b/sound/soc/codecs/cpcap.c
index 05bbacd0d174..fa4e024804a5 100644
--- a/sound/soc/codecs/cpcap.c
+++ b/sound/soc/codecs/cpcap.c
@@ -800,7 +800,7 @@ static const struct snd_soc_dapm_widget cpcap_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("EMU Left PGA",
 		CPCAP_REG_RXOA, CPCAP_BIT_EMU_SPKR_L_EN, 0, NULL, 0),
 
-	/* Headet Charge Pump */
+	/* Headset Charge Pump */
 	SND_SOC_DAPM_SUPPLY("Headset Charge Pump",
 		CPCAP_REG_RXOA, CPCAP_BIT_ST_HS_CP_EN, 0, NULL, 0),
 
diff --git a/sound/soc/codecs/cs35l33.c b/sound/soc/codecs/cs35l33.c
index 2a6f5e46d031..7dd80cb8cae6 100644
--- a/sound/soc/codecs/cs35l33.c
+++ b/sound/soc/codecs/cs35l33.c
@@ -581,7 +581,7 @@ static int cs35l33_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 			| CS35L33_X_LOC);
 	}
 
-	/* disconnect {vp,vbst}_mon routes: eanble later if set in tx_mask*/
+	/* disconnect {vp,vbst}_mon routes: enable later if set in tx_mask*/
 	snd_soc_dapm_del_routes(dapm, cs35l33_vp_vbst_mon_route,
 		ARRAY_SIZE(cs35l33_vp_vbst_mon_route));
 
diff --git a/sound/soc/codecs/cs35l34.c b/sound/soc/codecs/cs35l34.c
index ed678241c22b..b8f19a5d1c10 100644
--- a/sound/soc/codecs/cs35l34.c
+++ b/sound/soc/codecs/cs35l34.c
@@ -298,7 +298,7 @@ static int cs35l34_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 				CS35L34_X_STATE | CS35L34_X_LOC,
 				CS35L34_X_STATE | CS35L34_X_LOC);
 
-	/* disconnect {vp,vbst}_mon routes: eanble later if set in tx_mask*/
+	/* disconnect {vp,vbst}_mon routes: enable later if set in tx_mask*/
 	while (slot >= 0) {
 		/* configure VMON_TX_LOC */
 		if (slot_num == 0)
diff --git a/sound/soc/codecs/cs35l36.c b/sound/soc/codecs/cs35l36.c
index d83c1b318c1c..8bfc680a1177 100644
--- a/sound/soc/codecs/cs35l36.c
+++ b/sound/soc/codecs/cs35l36.c
@@ -1246,7 +1246,7 @@ static int cs35l36_component_probe(struct snd_soc_component *component)
 	 * L37 is 12V
 	 * If L36 we need to clamp some values for safety
 	 * after probe has setup dt values. We want to make
-	 * sure we dont miss any values set in probe
+	 * sure we don't miss any values set in probe
 	 */
 	if (cs35l36->chip_version == CS35L36_10V_L36) {
 		regmap_update_bits(cs35l36->regmap,
diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 2d239e983a83..20c33e7edb22 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -176,7 +176,7 @@ static const struct snd_soc_dapm_route cs4270_dapm_routes[] = {
  * @speed_mode is the corresponding bit pattern to be written to the
  * MODE bits of the Mode Control Register
  *
- * @mclk is the corresponding bit pattern to be wirten to the MCLK bits of
+ * @mclk is the corresponding bit pattern to be written to the MCLK bits of
  * the Mode Control Register.
  *
  * In situations where a single ratio is represented by multiple speed
diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index eff013f295be..111fc0c04015 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -1410,7 +1410,7 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 	int report = 0;
 
 
-	/* Read sticky registers to clear interurpt */
+	/* Read sticky registers to clear interrupt */
 	for (i = 0; i < ARRAY_SIZE(stickies); i++) {
 		regmap_read(cs42l42->regmap, irq_params_table[i].status_addr,
 				&(stickies[i]));
diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 018463f34e12..95d50fa22274 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1118,7 +1118,7 @@ static int cs42l73_set_bias_level(struct snd_soc_component *component,
 			mdelay(cs42l73->shutdwn_delay);
 			cs42l73->shutdwn_delay = 0;
 		} else {
-			mdelay(15); /* Min amount of time requred to power
+			mdelay(15); /* Min amount of time required to power
 				     * down.
 				     */
 		}
diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
index 5d6ef660f851..bbfe7651b469 100644
--- a/sound/soc/codecs/cs42xx8.c
+++ b/sound/soc/codecs/cs42xx8.c
@@ -184,7 +184,7 @@ struct cs42xx8_ratios {
 };
 
 /*
- * According to reference mannual, define the cs42xx8_ratio struct
+ * According to reference manual, define the cs42xx8_ratio struct
  * MFreq2 | MFreq1 | MFreq0 |     Description     | SSM | DSM | QSM |
  * 0      | 0      | 0      |1.029MHz to 12.8MHz  | 256 | 128 |  64 |
  * 0      | 0      | 1      |1.536MHz to 19.2MHz  | 384 | 192 |  96 |
diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index ec8d6e74b467..824c09f3fd1a 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -197,10 +197,10 @@ static int cx20442_write(struct snd_soc_component *component, unsigned int reg,
 }
 
 /*
- * Line discpline related code
+ * Line discipline related code
  *
  * Any of the callback functions below can be used in two ways:
- * 1) registerd by a machine driver as one of line discipline operations,
+ * 1) registered by a machine driver as one of line discipline operations,
  * 2) called from a machine's provided line discipline callback function
  *    in case when extra machine specific code must be run as well.
  */
diff --git a/sound/soc/codecs/cx2072x.c b/sound/soc/codecs/cx2072x.c
index 1f5c57fab1d8..2691d747692f 100644
--- a/sound/soc/codecs/cx2072x.c
+++ b/sound/soc/codecs/cx2072x.c
@@ -565,7 +565,7 @@ static int cx2072x_reg_read(void *context, unsigned int reg,
 	return 0;
 }
 
-/* get suggested pre_div valuce from mclk frequency */
+/* get suggested pre_div value from mclk frequency */
 static unsigned int get_div_from_mclk(unsigned int mclk)
 {
 	unsigned int div = 8;
@@ -1571,7 +1571,7 @@ static struct snd_soc_dai_driver soc_codec_cx2072x_dai[] = {
 		.ops = &cx2072x_dai_ops,
 		.symmetric_rate = 1,
 	},
-	{ /* plabayck only, return echo reference to Conexant DSP chip */
+	{ /* playback only, return echo reference to Conexant DSP chip */
 		.name = "cx2072x-dsp",
 		.id	= CX2072X_DAI_DSP,
 		.probe = cx2072x_dsp_dai_probe,
@@ -1584,7 +1584,7 @@ static struct snd_soc_dai_driver soc_codec_cx2072x_dai[] = {
 		},
 		.ops = &cx2072x_dai_ops,
 	},
-	{ /* plabayck only, return echo reference through I2S TX */
+	{ /* playback only, return echo reference through I2S TX */
 		.name = "cx2072x-aec",
 		.id	= 3,
 		.capture = {
diff --git a/sound/soc/codecs/cx2072x.h b/sound/soc/codecs/cx2072x.h
index ebdd567fa225..09e3a92b184f 100644
--- a/sound/soc/codecs/cx2072x.h
+++ b/sound/soc/codecs/cx2072x.h
@@ -177,7 +177,7 @@
 #define CX2072X_PLBK_DRC_PARM_LEN	9
 #define CX2072X_CLASSD_AMP_LEN		6
 
-/* DAI interfae type */
+/* DAI interface type */
 #define CX2072X_DAI_HIFI	1
 #define CX2072X_DAI_DSP		2
 #define CX2072X_DAI_DSP_PWM	3 /* 4 ch, including mic and AEC */
diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 8af344b2fdbf..2b6ed0a5a697 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -1151,7 +1151,7 @@ static int da7210_probe(struct snd_soc_component *component)
 	snd_soc_component_write(component, DA7210_PLL_DIV3, DA7210_MCLK_RANGE_10_20_MHZ |
 					      DA7210_PLL_BYP);
 
-	/* Diable PLL and bypass it */
+	/* Disable PLL and bypass it */
 	snd_soc_component_write(component, DA7210_PLL, DA7210_PLL_FS_48000);
 
 	/* Activate all enabled subsystem */
diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 3ab89387b4e6..5c3af89ff21e 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -778,7 +778,7 @@ static int da7213_dai_event(struct snd_soc_dapm_widget *w,
 
 		return 0;
 	case SND_SOC_DAPM_POST_PMD:
-		/* Revert 32KHz PLL lock udpates if applied previously */
+		/* Revert 32KHz PLL lock updates if applied previously */
 		pll_ctrl = snd_soc_component_read(component, DA7213_PLL_CTRL);
 		if (pll_ctrl & DA7213_PLL_32K_MODE) {
 			snd_soc_component_write(component, 0xF0, 0x8B);
diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index 390dd6c7f6a5..7298244ba92d 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -487,7 +487,7 @@ static int hdac_hda_codec_probe(struct snd_soc_component *component)
 	/*
 	 * hdac_device core already sets the state to active and calls
 	 * get_noresume. So enable runtime and set the device to suspend.
-	 * pm_runtime_enable is also called during codec registeration
+	 * pm_runtime_enable is also called during codec registration
 	 */
 	pm_runtime_put(&hdev->dev);
 	pm_runtime_suspend(&hdev->dev);
diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 66408a98298b..36b194a51fed 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1051,7 +1051,7 @@ static void hdac_hdmi_add_pinmux_cvt_route(struct hdac_device *hdev,
  * Widgets are added in the below sequence
  *	Converter widgets for num converters enumerated
  *	Pin-port widgets for num ports for Pins enumerated
- *	Pin-port mux widgets to represent connenction list of pin widget
+ *	Pin-port mux widgets to represent connection list of pin widget
  *
  * For each port, one Mux and One output widget is added
  * Total widgets elements = num_cvt + (num_ports * 2);
@@ -1256,7 +1256,7 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin,
 		return;
 
 	/*
-	 * In case of non MST pin, get_eld info API expectes port
+	 * In case of non MST pin, get_eld info API expects port
 	 * to be -1.
 	 */
 	mutex_lock(&hdmi->pin_mutex);
@@ -2039,7 +2039,7 @@ static int hdmi_codec_resume(struct device *dev)
 	/*
 	 * As the ELD notify callback request is not entertained while the
 	 * device is in suspend state. Need to manually check detection of
-	 * all pins here. pin capablity change is not support, so use the
+	 * all pins here. pin capability change is not support, so use the
 	 * already set pin caps.
 	 *
 	 * NOTE: this is safe to call even if the codec doesn't actually resume.
diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index f8e49e45ce33..a4923601dd72 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -95,7 +95,7 @@ static const struct reg_default max98088_reg[] = {
 
 	{ 0x30, 0x00 }, /* 30 DAI1 playback level */
 	{ 0x31, 0x00 }, /* 31 DAI2 playback level */
-	{ 0x32, 0x00 }, /* 32 DAI2 playbakc level */
+	{ 0x32, 0x00 }, /* 32 DAI2 playback level */
 	{ 0x33, 0x00 }, /* 33 left ADC level */
 	{ 0x34, 0x00 }, /* 34 right ADC level */
 	{ 0x35, 0x00 }, /* 35 MIC1 level */
diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index e14fe98349a5..8eaba126f534 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -307,7 +307,7 @@ SOC_ENUM("Limiter Release Rate", max98373_limiter_release_rate_enum),
 };
 
 static const struct snd_soc_dapm_route max98373_audio_map[] = {
-	/* Plabyack */
+	/* Playback */
 	{"DAI Sel Mux", "Left", "Amp Enable"},
 	{"DAI Sel Mux", "Right", "Amp Enable"},
 	{"DAI Sel Mux", "LeftRight", "Amp Enable"},
diff --git a/sound/soc/codecs/max98390.c b/sound/soc/codecs/max98390.c
index 94773ccee9d5..1c8e81499378 100644
--- a/sound/soc/codecs/max98390.c
+++ b/sound/soc/codecs/max98390.c
@@ -686,7 +686,7 @@ static const struct snd_soc_dapm_widget max98390_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route max98390_audio_map[] = {
-	/* Plabyack */
+	/* Playback */
 	{"DAI Sel Mux", "Left", "Amp Enable"},
 	{"DAI Sel Mux", "Right", "Amp Enable"},
 	{"DAI Sel Mux", "LeftRight", "Amp Enable"},
diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 8b206ee77709..8846b99218f6 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -696,7 +696,7 @@ static int max98927_probe(struct snd_soc_component *component)
 	regmap_write(max98927->regmap,
 		MAX98927_R0026_PCM_TO_SPK_MONOMIX_B,
 		0x1);
-	/* Set inital volume (+13dB) */
+	/* Set initial volume (+13dB) */
 	regmap_write(max98927->regmap,
 		MAX98927_R0036_AMP_VOL_CTRL,
 		0x38);
@@ -911,7 +911,7 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
 	/* voltage/current slot configuration */
 	max98927_slot_config(i2c, max98927);
 
-	/* codec registeration */
+	/* codec registration */
 	ret = devm_snd_soc_register_component(&i2c->dev,
 		&soc_component_dev_max98927,
 		max98927_dai, ARRAY_SIZE(max98927_dai));
diff --git a/sound/soc/codecs/mt6359-accdet.c b/sound/soc/codecs/mt6359-accdet.c
index 78314187d37e..ad3cf4b35488 100644
--- a/sound/soc/codecs/mt6359-accdet.c
+++ b/sound/soc/codecs/mt6359-accdet.c
@@ -752,7 +752,7 @@ static void config_eint_init_by_mode(struct mt6359_accdet *priv)
 	/* ESD switches on */
 	regmap_update_bits(priv->regmap, RG_ACCDETSPARE_ADDR,
 			   1 << 8, 1 << 8);
-	/* before playback, set NCP pull low before nagative voltage */
+	/* before playback, set NCP pull low before negative voltage */
 	regmap_update_bits(priv->regmap, RG_NCP_PDDIS_EN_ADDR,
 			   RG_NCP_PDDIS_EN_MASK_SFT, BIT(RG_NCP_PDDIS_EN_SFT));
 
diff --git a/sound/soc/codecs/mt6359.c b/sound/soc/codecs/mt6359.c
index 2d6a4a29b850..89ff46374f1f 100644
--- a/sound/soc/codecs/mt6359.c
+++ b/sound/soc/codecs/mt6359.c
@@ -68,7 +68,7 @@ static void mt6359_reset_capture_gpio(struct mt6359_priv *priv)
 			   0x3 << 0, 0x0);
 }
 
-/* use only when doing mtkaif calibraiton at the boot time */
+/* use only when doing mtkaif calibration at the boot time */
 static void mt6359_set_dcxo(struct mt6359_priv *priv, bool enable)
 {
 	regmap_update_bits(priv->regmap, MT6359_DCXO_CW12,
@@ -76,7 +76,7 @@ static void mt6359_set_dcxo(struct mt6359_priv *priv, bool enable)
 			   (enable ? 1 : 0) << RG_XO_AUDIO_EN_M_SFT);
 }
 
-/* use only when doing mtkaif calibraiton at the boot time */
+/* use only when doing mtkaif calibration at the boot time */
 static void mt6359_set_clksq(struct mt6359_priv *priv, bool enable)
 {
 	/* Enable/disable CLKSQ 26MHz */
@@ -85,7 +85,7 @@ static void mt6359_set_clksq(struct mt6359_priv *priv, bool enable)
 			   (enable ? 1 : 0) << RG_CLKSQ_EN_SFT);
 }
 
-/* use only when doing mtkaif calibraiton at the boot time */
+/* use only when doing mtkaif calibration at the boot time */
 static void mt6359_set_aud_global_bias(struct mt6359_priv *priv, bool enable)
 {
 	regmap_update_bits(priv->regmap, MT6359_AUDDEC_ANA_CON13,
@@ -93,7 +93,7 @@ static void mt6359_set_aud_global_bias(struct mt6359_priv *priv, bool enable)
 			   (enable ? 0 : 1) << RG_AUDGLB_PWRDN_VA32_SFT);
 }
 
-/* use only when doing mtkaif calibraiton at the boot time */
+/* use only when doing mtkaif calibration at the boot time */
 static void mt6359_set_topck(struct mt6359_priv *priv, bool enable)
 {
 	regmap_update_bits(priv->regmap, MT6359_AUD_TOP_CKPDN_CON0,
@@ -1731,7 +1731,7 @@ static int mt_pga_3_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-/* It is based on hw's control sequenece to add some delay when PMU/PMD */
+/* It is based on hw's control sequence to add some delay when PMU/PMD */
 static int mt_delay_250_event(struct snd_soc_dapm_widget *w,
 			      struct snd_kcontrol *kcontrol,
 			      int event)
diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 78b76eceff8f..5fd708e013f9 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -1623,7 +1623,6 @@ static int wcd938x_codec_aux_dac_event(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -1651,7 +1650,7 @@ static int wcd938x_codec_aux_dac_event(struct snd_soc_dapm_widget *w,
 				WCD938X_ANA_RX_DIV4_CLK_EN_MASK, 0);
 		break;
 	}
-	return ret;
+	return 0;
 
 }
 
@@ -1866,7 +1865,6 @@ static int wcd938x_codec_enable_aux_pa(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
 	int hph_mode = wcd938x->hph_mode;
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -1902,7 +1900,7 @@ static int wcd938x_codec_enable_aux_pa(struct snd_soc_dapm_widget *w,
 						      WCD938X_EN_CUR_DET_MASK, 1);
 		break;
 	}
-	return ret;
+	return 0;
 }
 
 static int wcd938x_codec_enable_ear_pa(struct snd_soc_dapm_widget *w,
-- 
2.25.1

