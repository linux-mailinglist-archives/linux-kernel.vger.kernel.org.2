Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1959131356C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 15:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhBHOmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 09:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbhBHOUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 09:20:48 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93972C0617A7
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 06:17:33 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l12so17363160wry.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 06:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BdIlgwsMDKMTvksYi5sB6MjJxJr4ClHkBgo19OaTSW4=;
        b=sTBkWSjk/jGxa8bnGnLMNPtCo+TaKA6yGfJv+I1/LOO/vvKvXRjlU1oidSRCH2doED
         x79BhA+RY/k7QY4kvvogz3Uuidy29dijUahXBF0qvjUHO/W615NYiIk89Aigx7+9dPIi
         rPDHpJ03ul2EvdUt4UtCE5w8S6BYTS7CvsEY8Uug3pAml59n7zZZoFwRJGq9keCWBQ0G
         AT5x06fEn9jM1eOa4xcUanian//VBka+yiNnzIxfzCd0jxN1CJ0bBf2OSlTMeGJm4hhU
         BHtgJkU3rwrEKDVR+7new6txpIuQtyB+qpjXksInY31iE7duFhvqI4LHmnGAiuFBSX8z
         ZQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BdIlgwsMDKMTvksYi5sB6MjJxJr4ClHkBgo19OaTSW4=;
        b=olpMfGRnfowQYn7hg9pT68wg/BF03KdOY53qS4GrirvQEicSv18BBqKFrIVRCw+Jux
         8r530YGY8HMfmy5ZhCumlzRKU+syX0+O3MfcePEBaA6PPR8VXH4EcYktu5CZ7zqfLAuB
         AcEiB8jZQGR22p195Btm7CAQvdGEH3W3xWU5FWCRzaUqKCdUJe1QUZtdR6xS8XVeN6YB
         xIwwFPJ8Z5zKJc7v4AwtrIplSd1EAnT9kt9lpRKurm8t6K4pUfc7inoCVw6JPDW6SG05
         9GNgaFpy8DGlIRzU3Cz5EO6Vp1NnKdDkevtEzYGApTJUpirjg7paTx7IAqj/nyXZCe16
         ViRA==
X-Gm-Message-State: AOAM531hAXCDtZZYekhUsMY+H3OoGo61p4du8yICBHWssz1kR2wXI+9j
        MFO23YzoC2auICXoveNdv+BcMw==
X-Google-Smtp-Source: ABdhPJzheMAaJ2eT1eR4Itybq1nDScrAOYcPvZK5F2DlMckLzEfaLx2pIH9DTePRJ365ZJc5gFfe9g==
X-Received: by 2002:a5d:4ad0:: with SMTP id y16mr2571146wrs.399.1612793852299;
        Mon, 08 Feb 2021 06:17:32 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id t18sm27949809wrr.56.2021.02.08.06.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 06:17:31 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 4/7] ASoC: codec: lpass-rx-macro: add iir widgets
Date:   Mon,  8 Feb 2021 14:17:16 +0000
Message-Id: <20210208141719.23305-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210208141719.23305-1-srinivas.kandagatla@linaro.org>
References: <20210208141719.23305-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds irr widgets and mixers on this codec

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-rx-macro.c | 264 ++++++++++++++++++++++++++++++
 1 file changed, 264 insertions(+)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index b516fd72bcfe..fb3468b3d6e1 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -532,6 +532,38 @@ enum {
 	INTERP_MIX_PATH,
 };
 
+/* Codec supports 2 IIR filters */
+enum {
+	IIR0 = 0,
+	IIR1,
+	IIR_MAX,
+};
+
+/* Each IIR has 5 Filter Stages */
+enum {
+	BAND1 = 0,
+	BAND2,
+	BAND3,
+	BAND4,
+	BAND5,
+	BAND_MAX,
+};
+
+#define RX_MACRO_IIR_FILTER_SIZE	(sizeof(u32) * BAND_MAX)
+
+#define RX_MACRO_IIR_FILTER_CTL(xname, iidx, bidx) \
+{ \
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = rx_macro_iir_filter_info, \
+	.get = rx_macro_get_iir_band_audio_mixer, \
+	.put = rx_macro_put_iir_band_audio_mixer, \
+	.private_value = (unsigned long)&(struct wcd_iir_filter_ctl) { \
+		.iir_idx = iidx, \
+		.band_idx = bidx, \
+		.bytes_ext = {.max = RX_MACRO_IIR_FILTER_SIZE, }, \
+	} \
+}
+
 struct interp_sample_rate {
 	int sample_rate;
 	int rate_val;
@@ -588,6 +620,12 @@ struct rx_macro {
 };
 #define to_rx_macro(_hw) container_of(_hw, struct rx_macro, hw)
 
+struct wcd_iir_filter_ctl {
+	unsigned int iir_idx;
+	unsigned int band_idx;
+	struct soc_bytes_ext bytes_ext;
+};
+
 static const DECLARE_TLV_DB_SCALE(digital_gain, -8400, 100, -8400);
 
 static const char * const rx_int_mix_mux_text[] = {
@@ -2601,6 +2639,166 @@ static int rx_macro_enable_rx_path_clk(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int rx_macro_set_iir_gain(struct snd_soc_dapm_widget *w,
+				 struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU: /* fall through */
+	case SND_SOC_DAPM_PRE_PMD:
+		if (strnstr(w->name, "IIR0", sizeof("IIR0"))) {
+			snd_soc_component_write(component,
+				CDC_RX_SIDETONE_IIR0_IIR_GAIN_B1_CTL,
+			snd_soc_component_read(component,
+				CDC_RX_SIDETONE_IIR0_IIR_GAIN_B1_CTL));
+			snd_soc_component_write(component,
+				CDC_RX_SIDETONE_IIR0_IIR_GAIN_B2_CTL,
+			snd_soc_component_read(component,
+				CDC_RX_SIDETONE_IIR0_IIR_GAIN_B2_CTL));
+			snd_soc_component_write(component,
+				CDC_RX_SIDETONE_IIR0_IIR_GAIN_B3_CTL,
+			snd_soc_component_read(component,
+				CDC_RX_SIDETONE_IIR0_IIR_GAIN_B3_CTL));
+			snd_soc_component_write(component,
+				CDC_RX_SIDETONE_IIR0_IIR_GAIN_B4_CTL,
+			snd_soc_component_read(component,
+				CDC_RX_SIDETONE_IIR0_IIR_GAIN_B4_CTL));
+		} else {
+			snd_soc_component_write(component,
+				CDC_RX_SIDETONE_IIR1_IIR_GAIN_B1_CTL,
+			snd_soc_component_read(component,
+				CDC_RX_SIDETONE_IIR1_IIR_GAIN_B1_CTL));
+			snd_soc_component_write(component,
+				CDC_RX_SIDETONE_IIR1_IIR_GAIN_B2_CTL,
+			snd_soc_component_read(component,
+				CDC_RX_SIDETONE_IIR1_IIR_GAIN_B2_CTL));
+			snd_soc_component_write(component,
+				CDC_RX_SIDETONE_IIR1_IIR_GAIN_B3_CTL,
+			snd_soc_component_read(component,
+				CDC_RX_SIDETONE_IIR1_IIR_GAIN_B3_CTL));
+			snd_soc_component_write(component,
+				CDC_RX_SIDETONE_IIR1_IIR_GAIN_B4_CTL,
+			snd_soc_component_read(component,
+				CDC_RX_SIDETONE_IIR1_IIR_GAIN_B4_CTL));
+		}
+		break;
+	}
+	return 0;
+}
+
+static uint32_t get_iir_band_coeff(struct snd_soc_component *component,
+				   int iir_idx, int band_idx, int coeff_idx)
+{
+	u32 value;
+	int reg, b2_reg;
+
+	/* Address does not automatically update if reading */
+	reg = CDC_RX_SIDETONE_IIR0_IIR_COEF_B1_CTL + 16 * iir_idx;
+	b2_reg = CDC_RX_SIDETONE_IIR0_IIR_COEF_B2_CTL + 16 * iir_idx;
+
+	snd_soc_component_write(component, reg,
+				((band_idx * BAND_MAX + coeff_idx) *
+				 sizeof(uint32_t)) & 0x7F);
+
+	value = snd_soc_component_read(component, b2_reg);
+	snd_soc_component_write(component, reg,
+				((band_idx * BAND_MAX + coeff_idx)
+				 * sizeof(uint32_t) + 1) & 0x7F);
+
+	value |= (snd_soc_component_read(component, b2_reg) << 8);
+	snd_soc_component_write(component, reg,
+				((band_idx * BAND_MAX + coeff_idx)
+				 * sizeof(uint32_t) + 2) & 0x7F);
+
+	value |= (snd_soc_component_read(component, b2_reg) << 16);
+	snd_soc_component_write(component, reg,
+		((band_idx * BAND_MAX + coeff_idx)
+		* sizeof(uint32_t) + 3) & 0x7F);
+
+	/* Mask bits top 2 bits since they are reserved */
+	value |= (snd_soc_component_read(component, b2_reg) << 24);
+	return value;
+}
+
+static void set_iir_band_coeff(struct snd_soc_component *component,
+			       int iir_idx, int band_idx, uint32_t value)
+{
+	int reg = CDC_RX_SIDETONE_IIR0_IIR_COEF_B2_CTL + 16 * iir_idx;
+
+	snd_soc_component_write(component, reg, (value & 0xFF));
+	snd_soc_component_write(component, reg, (value >> 8) & 0xFF);
+	snd_soc_component_write(component, reg, (value >> 16) & 0xFF);
+	/* Mask top 2 bits, 7-8 are reserved */
+	snd_soc_component_write(component, reg, (value >> 24) & 0x3F);
+}
+
+static int rx_macro_put_iir_band_audio_mixer(
+					struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+			snd_soc_kcontrol_component(kcontrol);
+	struct wcd_iir_filter_ctl *ctl =
+			(struct wcd_iir_filter_ctl *)kcontrol->private_value;
+	struct soc_bytes_ext *params = &ctl->bytes_ext;
+	int iir_idx = ctl->iir_idx;
+	int band_idx = ctl->band_idx;
+	u32 coeff[BAND_MAX];
+	int reg = CDC_RX_SIDETONE_IIR0_IIR_COEF_B1_CTL + 16 * iir_idx;
+
+	memcpy(&coeff[0], ucontrol->value.bytes.data, params->max);
+
+	/* Mask top bit it is reserved */
+	/* Updates addr automatically for each B2 write */
+	snd_soc_component_write(component, reg, (band_idx * BAND_MAX *
+						 sizeof(uint32_t)) & 0x7F);
+
+	set_iir_band_coeff(component, iir_idx, band_idx, coeff[0]);
+	set_iir_band_coeff(component, iir_idx, band_idx, coeff[1]);
+	set_iir_band_coeff(component, iir_idx, band_idx, coeff[2]);
+	set_iir_band_coeff(component, iir_idx, band_idx, coeff[3]);
+	set_iir_band_coeff(component, iir_idx, band_idx, coeff[4]);
+
+	return 0;
+}
+
+static int rx_macro_get_iir_band_audio_mixer(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+			snd_soc_kcontrol_component(kcontrol);
+	struct wcd_iir_filter_ctl *ctl =
+			(struct wcd_iir_filter_ctl *)kcontrol->private_value;
+	struct soc_bytes_ext *params = &ctl->bytes_ext;
+	int iir_idx = ctl->iir_idx;
+	int band_idx = ctl->band_idx;
+	u32 coeff[BAND_MAX];
+
+	coeff[0] = get_iir_band_coeff(component, iir_idx, band_idx, 0);
+	coeff[1] = get_iir_band_coeff(component, iir_idx, band_idx, 1);
+	coeff[2] = get_iir_band_coeff(component, iir_idx, band_idx, 2);
+	coeff[3] = get_iir_band_coeff(component, iir_idx, band_idx, 3);
+	coeff[4] = get_iir_band_coeff(component, iir_idx, band_idx, 4);
+
+	memcpy(ucontrol->value.bytes.data, &coeff[0], params->max);
+
+	return 0;
+}
+
+static int rx_macro_iir_filter_info(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_info *ucontrol)
+{
+	struct wcd_iir_filter_ctl *ctl =
+		(struct wcd_iir_filter_ctl *)kcontrol->private_value;
+	struct soc_bytes_ext *params = &ctl->bytes_ext;
+
+	ucontrol->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+	ucontrol->count = params->max;
+
+	return 0;
+}
+
 static const struct snd_kcontrol_new rx_macro_snd_controls[] = {
 	SOC_SINGLE_S8_TLV("RX_RX0 Digital Volume", CDC_RX_RX0_RX_VOL_CTL,
 			  -84, 40, digital_gain),
@@ -2635,6 +2833,65 @@ static const struct snd_kcontrol_new rx_macro_snd_controls[] = {
 	SOC_SINGLE_EXT("AUX_HPF Enable", SND_SOC_NOPM, 0, 1, 0,
 			rx_macro_aux_hpf_mode_get,
 			rx_macro_aux_hpf_mode_put),
+
+	SOC_SINGLE_S8_TLV("IIR0 INP0 Volume",
+		CDC_RX_SIDETONE_IIR0_IIR_GAIN_B1_CTL, -84, 40,
+		digital_gain),
+	SOC_SINGLE_S8_TLV("IIR0 INP1 Volume",
+		CDC_RX_SIDETONE_IIR0_IIR_GAIN_B2_CTL, -84, 40,
+		digital_gain),
+	SOC_SINGLE_S8_TLV("IIR0 INP2 Volume",
+		CDC_RX_SIDETONE_IIR0_IIR_GAIN_B3_CTL, -84, 40,
+		digital_gain),
+	SOC_SINGLE_S8_TLV("IIR0 INP3 Volume",
+		CDC_RX_SIDETONE_IIR0_IIR_GAIN_B4_CTL, -84, 40,
+		digital_gain),
+	SOC_SINGLE_S8_TLV("IIR1 INP0 Volume",
+		CDC_RX_SIDETONE_IIR1_IIR_GAIN_B1_CTL, -84, 40,
+		digital_gain),
+	SOC_SINGLE_S8_TLV("IIR1 INP1 Volume",
+		CDC_RX_SIDETONE_IIR1_IIR_GAIN_B2_CTL, -84, 40,
+		digital_gain),
+	SOC_SINGLE_S8_TLV("IIR1 INP2 Volume",
+		CDC_RX_SIDETONE_IIR1_IIR_GAIN_B3_CTL, -84, 40,
+		digital_gain),
+	SOC_SINGLE_S8_TLV("IIR1 INP3 Volume",
+		CDC_RX_SIDETONE_IIR1_IIR_GAIN_B4_CTL, -84, 40,
+		digital_gain),
+
+	SOC_SINGLE("IIR1 Band1 Switch", CDC_RX_SIDETONE_IIR0_IIR_CTL,
+		   0, 1, 0),
+	SOC_SINGLE("IIR1 Band2 Switch", CDC_RX_SIDETONE_IIR0_IIR_CTL,
+		   1, 1, 0),
+	SOC_SINGLE("IIR1 Band3 Switch", CDC_RX_SIDETONE_IIR0_IIR_CTL,
+		   2, 1, 0),
+	SOC_SINGLE("IIR1 Band4 Switch", CDC_RX_SIDETONE_IIR0_IIR_CTL,
+		   3, 1, 0),
+	SOC_SINGLE("IIR1 Band5 Switch", CDC_RX_SIDETONE_IIR0_IIR_CTL,
+		   4, 1, 0),
+	SOC_SINGLE("IIR2 Band1 Switch", CDC_RX_SIDETONE_IIR1_IIR_CTL,
+		   0, 1, 0),
+	SOC_SINGLE("IIR2 Band2 Switch", CDC_RX_SIDETONE_IIR1_IIR_CTL,
+		   1, 1, 0),
+	SOC_SINGLE("IIR2 Band3 Switch", CDC_RX_SIDETONE_IIR1_IIR_CTL,
+		   2, 1, 0),
+	SOC_SINGLE("IIR2 Band4 Switch", CDC_RX_SIDETONE_IIR1_IIR_CTL,
+		   3, 1, 0),
+	SOC_SINGLE("IIR2 Band5 Switch", CDC_RX_SIDETONE_IIR1_IIR_CTL,
+		   4, 1, 0),
+
+	RX_MACRO_IIR_FILTER_CTL("IIR0 Band1", IIR0, BAND1),
+	RX_MACRO_IIR_FILTER_CTL("IIR0 Band2", IIR0, BAND2),
+	RX_MACRO_IIR_FILTER_CTL("IIR0 Band3", IIR0, BAND3),
+	RX_MACRO_IIR_FILTER_CTL("IIR0 Band4", IIR0, BAND4),
+	RX_MACRO_IIR_FILTER_CTL("IIR0 Band5", IIR0, BAND5),
+
+	RX_MACRO_IIR_FILTER_CTL("IIR1 Band1", IIR1, BAND1),
+	RX_MACRO_IIR_FILTER_CTL("IIR1 Band2", IIR1, BAND2),
+	RX_MACRO_IIR_FILTER_CTL("IIR1 Band3", IIR1, BAND3),
+	RX_MACRO_IIR_FILTER_CTL("IIR1 Band4", IIR1, BAND4),
+	RX_MACRO_IIR_FILTER_CTL("IIR1 Band5", IIR1, BAND5),
+
 };
 
 static int rx_macro_enable_echo(struct snd_soc_dapm_widget *w,
@@ -2730,6 +2987,13 @@ static const struct snd_soc_dapm_widget rx_macro_dapm_widgets[] = {
 			   RX_MACRO_EC2_MUX, 0,
 			   &rx_mix_tx2_mux, rx_macro_enable_echo,
 			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_MIXER_E("IIR0", CDC_RX_SIDETONE_IIR0_IIR_PATH_CTL,
+		4, 0, NULL, 0, rx_macro_set_iir_gain,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_MIXER_E("IIR1", CDC_RX_SIDETONE_IIR1_IIR_PATH_CTL,
+		4, 0, NULL, 0, rx_macro_set_iir_gain,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 	SND_SOC_DAPM_MIXER("SRC0", CDC_RX_SIDETONE_SRC0_ST_SRC_PATH_CTL,
 		4, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER("SRC1", CDC_RX_SIDETONE_SRC1_ST_SRC_PATH_CTL,
-- 
2.21.0

