Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4192538E2AC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 10:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbhEXIu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 04:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbhEXIuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 04:50:18 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E0DC06138C
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 01:48:49 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id y184-20020a1ce1c10000b02901769b409001so10569359wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 01:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SAwOaWExRuNrARy+05KElCmtxaHIS/5zvoaKTDBc+m0=;
        b=DvSxZIx51Un+g7E0Zh18eDcbm9vEOUaOqbZzfZKtRMNmt9N2w5c3ZKe7jukkE7OEdg
         i0ZVqoyFgkE5MnQTseOo0xPwEzBsPK02WXcakP/YP/C0BrN+Mn7hUJlzyOp6xLqZcnj4
         Enirc8lW6hazj1C2ATQj18xaxjoNXvJfS75PSP+2HxyOyLglm/2n6m5A7m866U7cM2bK
         XcwpwtU7r4HEilkpKbFHNt9zDkgZdmU8+GOdrsRtAF/9cEWPNvzHHda3TMd1LLhVLZBP
         mrOyaBDbq9RlfXN+ET/ZJTy1q4CL2O7DrDiYDTTf8RTbDVjBB9hG0H6zdgsX9Bta3/6e
         kCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SAwOaWExRuNrARy+05KElCmtxaHIS/5zvoaKTDBc+m0=;
        b=OA6T89xSvuROqrMhtby7AUEbTc0MEF0VauohQUbUxka8KJCIPYVC0oUHPouYhW7eq2
         4mRLN3KcM9QCzF3c2OqtVvnLM1fDYl+fv4BQlZFVC1IKifpYZqAbQ5j5lhZ/hr8rTmny
         m01wjGx8YKDs/VI87KYnCbx+5tXtZxrQE6yUqtoTIJJMdT1PXrJxGQC+XfvG/iTBVXtn
         tAEtdozhvcvlqjT2g4W1o08laEuE0fE/YugHAJloPXSo0YMvJW6nEJBiNCzbnFc7Teql
         uzHBDZYTB1lSp6HkcgOl4ihyIqmgYZQMfjE1xS07cSM6Y+Vd2KGHFSG2pErisg4fEXQq
         ARIQ==
X-Gm-Message-State: AOAM532WTZAUAaOSVoSoHUiti2mDxZv4+cyFXS74aNbkSpKiTeSJnT4T
        oCWRgfMkLeHUnLqQMM/9V7EyWQ==
X-Google-Smtp-Source: ABdhPJwa7vPGB0I8jzPejbJNC3AbWVdzFtMUfIOR4fLRtUb5GDYFGbE/RrFlCqsZZuIVBWCcwOBYdw==
X-Received: by 2002:a7b:cb88:: with SMTP id m8mr19115152wmi.154.1621846128529;
        Mon, 24 May 2021 01:48:48 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id x206sm4034548wmx.47.2021.05.24.01.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 01:48:47 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v7 6/9] ASoC: codecs: wcd938x: add basic controls
Date:   Mon, 24 May 2021 09:48:25 +0100
Message-Id: <20210524084828.12787-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210524084828.12787-1-srinivas.kandagatla@linaro.org>
References: <20210524084828.12787-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic controls found in wcd938x codec.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 409 +++++++++++++++++++++++++++++++++++++
 1 file changed, 409 insertions(+)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 18d2c49314fd..04639d3aea3f 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -75,6 +75,15 @@
 #define WCD938X_MBHC_MOISTURE_RREF      R_24_KOHM
 #define WCD_MBHC_HS_V_MAX           1600
 
+#define WCD938X_EAR_PA_GAIN_TLV(xname, reg, shift, max, invert, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
+		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.tlv.p = (tlv_array), \
+	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
+	.put = wcd938x_ear_pa_put_gain, \
+	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 0) }
+
 enum {
 	WCD9380 = 0,
 	WCD9385 = 5,
@@ -198,6 +207,10 @@ enum {
 	MICB_DISABLE,
 };
 
+static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(ear_pa_gain, 600, -1800);
+static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(line_gain, 600, -3000);
+static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(analog_gain, 0, 3000);
+
 static const struct reg_default wcd938x_defaults[] = {
 	{WCD938X_ANA_PAGE_REGISTER,                            0x00},
 	{WCD938X_ANA_BIAS,                                     0x00},
@@ -1283,6 +1296,375 @@ static int wcd938x_io_init(struct wcd938x_priv *wcd938x)
 
 }
 
+static int wcd938x_sdw_connect_port(struct wcd938x_sdw_ch_info *ch_info,
+				    struct sdw_port_config *port_config,
+				    u32 mstr_port_num,
+				    u8 enable)
+{
+	u8 ch_mask, port_num;
+
+	port_num = ch_info->port_num;
+	ch_mask = ch_info->ch_mask;
+
+	port_config->num = port_num;
+
+	if (enable)
+		port_config->ch_mask |= ch_mask;
+	else
+		port_config->ch_mask &= ~ch_mask;
+
+	return 0;
+}
+
+static int wcd938x_connect_port(struct wcd938x_sdw_priv *wcd, u8 ch_id, u8 enable)
+{
+	u8 port_num, mstr_port_num;
+
+	port_num = wcd->ch_info[ch_id].port_num;
+	mstr_port_num = wcd->port_map[port_num - 1];
+
+	return wcd938x_sdw_connect_port(&wcd->ch_info[ch_id],
+					&wcd->port_config[port_num],
+					mstr_port_num,
+					enable);
+}
+
+static int wcd938x_tx_mode_get(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	int path = e->shift_l;
+
+	ucontrol->value.integer.value[0] = wcd938x->tx_mode[path];
+
+	return 0;
+}
+
+static int wcd938x_tx_mode_put(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	int path = e->shift_l;
+
+	wcd938x->tx_mode[path] = ucontrol->value.enumerated.item[0];
+
+	return 0;
+}
+
+static int wcd938x_rx_hph_mode_get(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+
+	ucontrol->value.integer.value[0] = wcd938x->hph_mode;
+
+	return 0;
+}
+
+static int wcd938x_rx_hph_mode_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+
+	wcd938x->hph_mode = ucontrol->value.enumerated.item[0];
+
+	return 0;
+}
+
+static int wcd938x_ear_pa_put_gain(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+
+	if (wcd938x->comp1_enable) {
+		dev_err(component->dev, "Can not set EAR PA Gain, compander1 is enabled\n");
+		return -EINVAL;
+	}
+
+	snd_soc_component_write_field(component, WCD938X_ANA_EAR_COMPANDER_CTL,
+				      WCD938X_EAR_GAIN_MASK,
+				      ucontrol->value.integer.value[0]);
+
+	return 0;
+}
+
+static int wcd938x_get_compander(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+	struct soc_mixer_control *mc;
+	bool hphr;
+
+	mc = (struct soc_mixer_control *)(kcontrol->private_value);
+	hphr = mc->shift;
+
+	if (hphr)
+		ucontrol->value.integer.value[0] = wcd938x->comp2_enable;
+	else
+		ucontrol->value.integer.value[0] = wcd938x->comp1_enable;
+
+	return 0;
+}
+
+static int wcd938x_set_compander(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+	struct wcd938x_sdw_priv *wcd;
+	int value = ucontrol->value.integer.value[0];
+	struct soc_mixer_control *mc;
+	bool hphr;
+
+	mc = (struct soc_mixer_control *)(kcontrol->private_value);
+	hphr = mc->shift;
+
+	wcd = wcd938x->sdw_priv[AIF1_PB];
+
+	if (hphr)
+		wcd938x->comp2_enable = value;
+	else
+		wcd938x->comp1_enable = value;
+
+	if (value)
+		wcd938x_connect_port(wcd, mc->reg, true);
+	else
+		wcd938x_connect_port(wcd, mc->reg, false);
+
+	return 0;
+}
+
+static int wcd938x_ldoh_get(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+
+	ucontrol->value.integer.value[0] = wcd938x->ldoh;
+
+	return 0;
+}
+
+static int wcd938x_ldoh_put(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+
+	wcd938x->ldoh = ucontrol->value.integer.value[0];
+
+	return 0;
+}
+
+static int wcd938x_bcs_get(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+
+	ucontrol->value.integer.value[0] = wcd938x->bcs_dis;
+
+	return 0;
+}
+
+static int wcd938x_bcs_put(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+
+	wcd938x->bcs_dis = ucontrol->value.integer.value[0];
+
+	return 0;
+}
+
+static const char * const tx_mode_mux_text_wcd9380[] = {
+	"ADC_INVALID", "ADC_HIFI", "ADC_LO_HIF", "ADC_NORMAL", "ADC_LP",
+};
+
+static const char * const tx_mode_mux_text[] = {
+	"ADC_INVALID", "ADC_HIFI", "ADC_LO_HIF", "ADC_NORMAL", "ADC_LP",
+	"ADC_ULP1", "ADC_ULP2",
+};
+
+static const char * const rx_hph_mode_mux_text_wcd9380[] = {
+	"CLS_H_INVALID", "CLS_H_INVALID_1", "CLS_H_LP", "CLS_AB",
+	"CLS_H_LOHIFI", "CLS_H_ULP", "CLS_H_INVALID_2", "CLS_AB_LP",
+	"CLS_AB_LOHIFI",
+};
+
+static const char * const rx_hph_mode_mux_text[] = {
+	"CLS_H_INVALID", "CLS_H_HIFI", "CLS_H_LP", "CLS_AB", "CLS_H_LOHIFI",
+	"CLS_H_ULP", "CLS_AB_HIFI", "CLS_AB_LP", "CLS_AB_LOHIFI",
+};
+
+static const struct soc_enum tx_mode_mux_enum_wcd9380[] = {
+	SOC_ENUM_SINGLE(SND_SOC_NOPM, 0, ARRAY_SIZE(tx_mode_mux_text_wcd9380),
+			tx_mode_mux_text_wcd9380),
+	SOC_ENUM_SINGLE(SND_SOC_NOPM, 1, ARRAY_SIZE(tx_mode_mux_text_wcd9380),
+			tx_mode_mux_text_wcd9380),
+	SOC_ENUM_SINGLE(SND_SOC_NOPM, 2, ARRAY_SIZE(tx_mode_mux_text_wcd9380),
+			tx_mode_mux_text_wcd9380),
+	SOC_ENUM_SINGLE(SND_SOC_NOPM, 3, ARRAY_SIZE(tx_mode_mux_text_wcd9380),
+			tx_mode_mux_text_wcd9380),
+};
+
+static const struct soc_enum tx_mode_mux_enum[] = {
+	SOC_ENUM_SINGLE(SND_SOC_NOPM, 0, ARRAY_SIZE(tx_mode_mux_text),
+			tx_mode_mux_text),
+	SOC_ENUM_SINGLE(SND_SOC_NOPM, 1, ARRAY_SIZE(tx_mode_mux_text),
+			tx_mode_mux_text),
+	SOC_ENUM_SINGLE(SND_SOC_NOPM, 2, ARRAY_SIZE(tx_mode_mux_text),
+			tx_mode_mux_text),
+	SOC_ENUM_SINGLE(SND_SOC_NOPM, 3, ARRAY_SIZE(tx_mode_mux_text),
+			tx_mode_mux_text),
+};
+
+static const struct soc_enum rx_hph_mode_mux_enum_wcd9380 =
+		SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(rx_hph_mode_mux_text_wcd9380),
+				    rx_hph_mode_mux_text_wcd9380);
+
+static const struct soc_enum rx_hph_mode_mux_enum =
+		SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(rx_hph_mode_mux_text),
+				    rx_hph_mode_mux_text);
+
+static const struct snd_kcontrol_new wcd9380_snd_controls[] = {
+	SOC_ENUM_EXT("RX HPH Mode", rx_hph_mode_mux_enum_wcd9380,
+		     wcd938x_rx_hph_mode_get, wcd938x_rx_hph_mode_put),
+	SOC_ENUM_EXT("TX0 MODE", tx_mode_mux_enum_wcd9380[0],
+		     wcd938x_tx_mode_get, wcd938x_tx_mode_put),
+	SOC_ENUM_EXT("TX1 MODE", tx_mode_mux_enum_wcd9380[1],
+		     wcd938x_tx_mode_get, wcd938x_tx_mode_put),
+	SOC_ENUM_EXT("TX2 MODE", tx_mode_mux_enum_wcd9380[2],
+		     wcd938x_tx_mode_get, wcd938x_tx_mode_put),
+	SOC_ENUM_EXT("TX3 MODE", tx_mode_mux_enum_wcd9380[3],
+		     wcd938x_tx_mode_get, wcd938x_tx_mode_put),
+};
+
+static const struct snd_kcontrol_new wcd9385_snd_controls[] = {
+	SOC_ENUM_EXT("RX HPH Mode", rx_hph_mode_mux_enum,
+		     wcd938x_rx_hph_mode_get, wcd938x_rx_hph_mode_put),
+	SOC_ENUM_EXT("TX0 MODE", tx_mode_mux_enum[0],
+		     wcd938x_tx_mode_get, wcd938x_tx_mode_put),
+	SOC_ENUM_EXT("TX1 MODE", tx_mode_mux_enum[1],
+		     wcd938x_tx_mode_get, wcd938x_tx_mode_put),
+	SOC_ENUM_EXT("TX2 MODE", tx_mode_mux_enum[2],
+		     wcd938x_tx_mode_get, wcd938x_tx_mode_put),
+	SOC_ENUM_EXT("TX3 MODE", tx_mode_mux_enum[3],
+		     wcd938x_tx_mode_get, wcd938x_tx_mode_put),
+};
+
+static int wcd938x_get_swr_port(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *comp = snd_soc_kcontrol_component(kcontrol);
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(comp);
+	struct wcd938x_sdw_priv *wcd;
+	struct soc_mixer_control *mixer = (struct soc_mixer_control *)kcontrol->private_value;
+	int dai_id = mixer->shift;
+	int portidx = mixer->reg;
+
+	wcd = wcd938x->sdw_priv[dai_id];
+
+	ucontrol->value.integer.value[0] = wcd->port_enable[portidx];
+
+	return 0;
+}
+
+static int wcd938x_set_swr_port(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *comp = snd_soc_kcontrol_component(kcontrol);
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(comp);
+	struct wcd938x_sdw_priv *wcd;
+	struct soc_mixer_control *mixer =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	int portidx = mixer->reg;
+	int dai_id = mixer->shift;
+	bool enable;
+
+	wcd = wcd938x->sdw_priv[dai_id];
+
+	if (ucontrol->value.integer.value[0])
+		enable = true;
+	else
+		enable = false;
+
+	wcd->port_enable[portidx] = enable;
+
+	wcd938x_connect_port(wcd, portidx, enable);
+
+	return 0;
+
+}
+
+static const struct snd_kcontrol_new wcd938x_snd_controls[] = {
+	SOC_SINGLE_EXT("HPHL_COMP Switch", WCD938X_COMP_L, 0, 1, 0,
+		       wcd938x_get_compander, wcd938x_set_compander),
+	SOC_SINGLE_EXT("HPHR_COMP Switch", WCD938X_COMP_R, 1, 1, 0,
+		       wcd938x_get_compander, wcd938x_set_compander),
+	SOC_SINGLE_EXT("HPHL Switch", WCD938X_HPH_L, 0, 1, 0,
+		       wcd938x_get_swr_port, wcd938x_set_swr_port),
+	SOC_SINGLE_EXT("HPHR Switch", WCD938X_HPH_R, 0, 1, 0,
+		       wcd938x_get_swr_port, wcd938x_set_swr_port),
+	SOC_SINGLE_EXT("CLSH Switch", WCD938X_CLSH, 0, 1, 0,
+		       wcd938x_get_swr_port, wcd938x_set_swr_port),
+	SOC_SINGLE_EXT("LO Switch", WCD938X_LO, 0, 1, 0,
+		       wcd938x_get_swr_port, wcd938x_set_swr_port),
+	SOC_SINGLE_EXT("DSD_L Switch", WCD938X_DSD_L, 0, 1, 0,
+		       wcd938x_get_swr_port, wcd938x_set_swr_port),
+	SOC_SINGLE_EXT("DSD_R Switch", WCD938X_DSD_R, 0, 1, 0,
+		       wcd938x_get_swr_port, wcd938x_set_swr_port),
+	SOC_SINGLE_TLV("HPHL Volume", WCD938X_HPH_L_EN, 0, 0x18, 0, line_gain),
+	SOC_SINGLE_TLV("HPHR Volume", WCD938X_HPH_R_EN, 0, 0x18, 0, line_gain),
+	WCD938X_EAR_PA_GAIN_TLV("EAR_PA Volume", WCD938X_ANA_EAR_COMPANDER_CTL,
+				2, 0x10, 0, ear_pa_gain),
+	SOC_SINGLE_EXT("ADC1 Switch", WCD938X_ADC1, 1, 1, 0,
+		       wcd938x_get_swr_port, wcd938x_set_swr_port),
+	SOC_SINGLE_EXT("ADC2 Switch", WCD938X_ADC2, 1, 1, 0,
+		       wcd938x_get_swr_port, wcd938x_set_swr_port),
+	SOC_SINGLE_EXT("ADC3 Switch", WCD938X_ADC3, 1, 1, 0,
+		       wcd938x_get_swr_port, wcd938x_set_swr_port),
+	SOC_SINGLE_EXT("ADC4 Switch", WCD938X_ADC4, 1, 1, 0,
+		       wcd938x_get_swr_port, wcd938x_set_swr_port),
+	SOC_SINGLE_EXT("DMIC0 Switch", WCD938X_DMIC0, 1, 1, 0,
+		       wcd938x_get_swr_port, wcd938x_set_swr_port),
+	SOC_SINGLE_EXT("DMIC1 Switch", WCD938X_DMIC1, 1, 1, 0,
+		       wcd938x_get_swr_port, wcd938x_set_swr_port),
+	SOC_SINGLE_EXT("MBHC Switch", WCD938X_MBHC, 1, 1, 0,
+		       wcd938x_get_swr_port, wcd938x_set_swr_port),
+	SOC_SINGLE_EXT("DMIC2 Switch", WCD938X_DMIC2, 1, 1, 0,
+		       wcd938x_get_swr_port, wcd938x_set_swr_port),
+	SOC_SINGLE_EXT("DMIC3 Switch", WCD938X_DMIC3, 1, 1, 0,
+		       wcd938x_get_swr_port, wcd938x_set_swr_port),
+	SOC_SINGLE_EXT("DMIC4 Switch", WCD938X_DMIC4, 1, 1, 0,
+		       wcd938x_get_swr_port, wcd938x_set_swr_port),
+	SOC_SINGLE_EXT("DMIC5 Switch", WCD938X_DMIC5, 1, 1, 0,
+		       wcd938x_get_swr_port, wcd938x_set_swr_port),
+	SOC_SINGLE_EXT("DMIC6 Switch", WCD938X_DMIC6, 1, 1, 0,
+		       wcd938x_get_swr_port, wcd938x_set_swr_port),
+	SOC_SINGLE_EXT("DMIC7 Switch", WCD938X_DMIC7, 1, 1, 0,
+		       wcd938x_get_swr_port, wcd938x_set_swr_port),
+	SOC_SINGLE_EXT("LDOH Enable Switch", SND_SOC_NOPM, 0, 1, 0,
+		       wcd938x_ldoh_get, wcd938x_ldoh_put),
+	SOC_SINGLE_EXT("ADC2_BCS Disable Switch", SND_SOC_NOPM, 0, 1, 0,
+		       wcd938x_bcs_get, wcd938x_bcs_put),
+
+	SOC_SINGLE_TLV("ADC1 Volume", WCD938X_ANA_TX_CH1, 0, 20, 0, analog_gain),
+	SOC_SINGLE_TLV("ADC2 Volume", WCD938X_ANA_TX_CH2, 0, 20, 0, analog_gain),
+	SOC_SINGLE_TLV("ADC3 Volume", WCD938X_ANA_TX_CH3, 0, 20, 0, analog_gain),
+	SOC_SINGLE_TLV("ADC4 Volume", WCD938X_ANA_TX_CH4, 0, 20, 0, analog_gain),
+};
+
 static int wcd938x_get_micb_vout_ctl_val(u32 micb_mv)
 {
 	/* min micbias voltage is 1V and maximum is 2.85V */
@@ -1413,12 +1795,39 @@ static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 	disable_irq_nosync(wcd938x->hphl_pdm_wd_int);
 	disable_irq_nosync(wcd938x->aux_pdm_wd_int);
 
+	switch (wcd938x->variant) {
+	case WCD9380:
+		ret = snd_soc_add_component_controls(component, wcd9380_snd_controls,
+					ARRAY_SIZE(wcd9380_snd_controls));
+		if (ret < 0) {
+			dev_err(component->dev,
+				"%s: Failed to add snd ctrls for variant: %d\n",
+				__func__, wcd938x->variant);
+			goto err;
+		}
+		break;
+	case WCD9385:
+		ret = snd_soc_add_component_controls(component, wcd9385_snd_controls,
+					ARRAY_SIZE(wcd9385_snd_controls));
+		if (ret < 0) {
+			dev_err(component->dev,
+				"%s: Failed to add snd ctrls for variant: %d\n",
+				__func__, wcd938x->variant);
+			goto err;
+		}
+		break;
+	default:
+		break;
+	}
+err:
 	return ret;
 }
 
 static const struct snd_soc_component_driver soc_codec_dev_wcd938x = {
 	.name = "wcd938x_codec",
 	.probe = wcd938x_soc_codec_probe,
+	.controls = wcd938x_snd_controls,
+	.num_controls = ARRAY_SIZE(wcd938x_snd_controls),
 };
 
 static void wcd938x_dt_parse_micbias_info(struct device *dev, struct wcd938x_priv *wcd)
-- 
2.21.0

