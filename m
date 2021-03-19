Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841F6341850
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhCSJad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhCSJaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:30:11 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E5CC061761
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:30:09 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j7so8398159wrd.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vqI3h7bL5GxJbr7rqQ7z7EzfqDP73iW8gqEA97t5wxg=;
        b=QUKbXNVtMA1qSqMQUoRNrYi0/clVcH86A8rp/qzH5W4p1OFvYyhihiVAkaSOlYONWg
         /7iQxzfFTYOpfz5gWPo7a3Nfy6qGCXiHwztt8PaRJkJv5npo0i3aMUYyXde7hEeOtXj+
         fFQCfUYSAfJw4RfjcAdpVxDxhbIPbEJgSg5Nw9QTwTk9yI5QpJKmLb5r+Jag4YkySzwb
         +lVZb9mb2TXEdsnLNVTXux8AJG/MjFuAC2LxxSXQ6Wli8YzBTOxuWdOs4kTO5AjthNkq
         rbDFyF/9h3Pk+siM3UMdMcPmZS8O8KQGXlWQsXV1FxFwtf1NDRmAet81tcWP0AnGvqxQ
         wh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vqI3h7bL5GxJbr7rqQ7z7EzfqDP73iW8gqEA97t5wxg=;
        b=NNDkOeZZqnAWFi8bz4P8IUeANahMktnTcIwDzm+t+reuC5/38ryyCuaN0OO/Vy81AZ
         +QzidW6gcB7WJQ9ryhP/Sf7NWWwg2i8U2r+Rv/kfr5pWbk6T3GqoLLEdDMuK5m6xTglN
         9LBp7NCL/+CB7q2woxWOG7JzVyGH+7GhNgMNWI3lMdoXTKUAhGQzUhP+Neub/wELxzWQ
         d7gykg3qGy01Zj4+siYwsCWs2e42PtGdyCzK5l8aexj3NpSPzZfS4ka1Ap12NSNf3qNE
         kx7gVbCQv8uLnVkoE8Gz0Y4B03AidIS5X6lWhH0e6I8EMq6QcoGaI6KDn+GUQgNQYcgz
         UXPQ==
X-Gm-Message-State: AOAM530UDhMrlRoKeJ+99k3t/cw6TZiCyEL41tMKldRZ4YWfUjodqOxL
        BIUdkjdbKUmrccLK6EV3P4y62A==
X-Google-Smtp-Source: ABdhPJz9i3KLAPCw9rQKb6DYp9trYbsyTWmwpEaA7xIoO56/m3FgCSmKcgHc7cN6eY+faNCcEzPmIA==
X-Received: by 2002:a5d:6c6a:: with SMTP id r10mr3606331wrz.42.1616146208353;
        Fri, 19 Mar 2021 02:30:08 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id p6sm6779058wru.2.2021.03.19.02.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 02:30:07 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 4/7] ASoC: codecs: wcd938x: add basic controls
Date:   Fri, 19 Mar 2021 09:29:16 +0000
Message-Id: <20210319092919.21218-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210319092919.21218-1-srinivas.kandagatla@linaro.org>
References: <20210319092919.21218-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic controls found in wcd938x codec.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 415 +++++++++++++++++++++++++++++++++++++
 1 file changed, 415 insertions(+)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 9e8d588e2235..9b5dda775a17 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -66,6 +66,15 @@
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
@@ -187,6 +196,9 @@ enum {
 };
 
 static struct wcd938x_priv *g_wcd938x;
+static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(ear_pa_gain, 600, -1800);
+static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(line_gain, 600, -3000);
+static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(analog_gain, 0, 3000);
 
 static const struct reg_default wcd938x_defaults[] = {
 	{WCD938X_ANA_PAGE_REGISTER,                            0x00},
@@ -1275,6 +1287,380 @@ int wcd938x_io_init(struct wcd938x_sdw_priv *wcd)
 
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
+static int wcd938x_connect_port(struct snd_soc_component *component, u8 ch_id, u8 enable)
+{
+	struct wcd938x_sdw_priv *wcd = snd_soc_component_get_drvdata(component);
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
+	struct wcd938x_sdw_priv *wcd = snd_soc_component_get_drvdata(component);
+	struct wcd938x_priv *wcd938x = wcd->wcd938x;
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
+	struct wcd938x_sdw_priv *wcd = snd_soc_component_get_drvdata(component);
+	struct wcd938x_priv *wcd938x = wcd->wcd938x;
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
+	struct wcd938x_sdw_priv *wcd = snd_soc_component_get_drvdata(component);
+	struct wcd938x_priv *wcd938x = wcd->wcd938x;
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
+	struct wcd938x_sdw_priv *wcd = snd_soc_component_get_drvdata(component);
+	struct wcd938x_priv *wcd938x = wcd->wcd938x;
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
+	struct wcd938x_sdw_priv *wcd = snd_soc_component_get_drvdata(component);
+	struct wcd938x_priv *wcd938x = wcd->wcd938x;
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
+	struct wcd938x_sdw_priv *wcd = snd_soc_component_get_drvdata(component);
+	struct wcd938x_priv *wcd938x = wcd->wcd938x;
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
+	struct wcd938x_sdw_priv *wcd = snd_soc_component_get_drvdata(component);
+	struct wcd938x_priv *wcd938x = wcd->wcd938x;
+	int value = ucontrol->value.integer.value[0];
+	struct soc_mixer_control *mc;
+	bool hphr;
+
+	mc = (struct soc_mixer_control *)(kcontrol->private_value);
+	hphr = mc->shift;
+
+	if (hphr)
+		wcd938x->comp2_enable = value;
+	else
+		wcd938x->comp1_enable = value;
+
+	if (value)
+		wcd938x_connect_port(component, mc->reg, true);
+	else
+		wcd938x_connect_port(component, mc->reg, false);
+
+	return 0;
+}
+
+static int wcd938x_ldoh_get(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wcd938x_sdw_priv *wcd = snd_soc_component_get_drvdata(component);
+	struct wcd938x_priv *wcd938x = wcd->wcd938x;
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
+	struct wcd938x_sdw_priv *wcd = snd_soc_component_get_drvdata(component);
+	struct wcd938x_priv *wcd938x = wcd->wcd938x;
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
+	struct wcd938x_sdw_priv *wcd = snd_soc_component_get_drvdata(component);
+	struct wcd938x_priv *wcd938x = wcd->wcd938x;
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
+	struct wcd938x_sdw_priv *wcd = snd_soc_component_get_drvdata(component);
+	struct wcd938x_priv *wcd938x = wcd->wcd938x;
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
+	struct wcd938x_sdw_priv *wcd = snd_soc_component_get_drvdata(comp);
+	struct soc_mixer_control *mixer = (struct soc_mixer_control *)kcontrol->private_value;
+	int portidx = mixer->reg;
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
+	struct wcd938x_sdw_priv *wcd = snd_soc_component_get_drvdata(comp);
+	struct soc_mixer_control *mixer =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	int portidx = mixer->reg;
+	bool enable;
+
+	if (ucontrol->value.integer.value[0])
+		enable = true;
+	else
+		enable = false;
+
+	wcd->port_enable[portidx] = enable;
+
+	wcd938x_connect_port(comp, portidx, enable);
+
+	return 0;
+
+}
+
+static const struct snd_kcontrol_new wcd938x_rx_snd_controls[] = {
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
+};
+
+static const struct snd_kcontrol_new wcd938x_snd_controls[] = {
+
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
@@ -1419,17 +1805,46 @@ static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
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
 
 static const struct snd_soc_component_driver soc_codec_dev_wcd938x_sdw_rx = {
 	.name = "wcd938x_codec_rx",
 	.probe = wcd938x_soc_codec_rx_probe,
+	.controls = wcd938x_rx_snd_controls,
+	.num_controls = ARRAY_SIZE(wcd938x_rx_snd_controls),
 };
 
 static const struct snd_soc_component_driver soc_codec_dev_wcd938x_sdw_tx = {
 	.name = "wcd938x_codec_tx",
 	.probe = wcd938x_soc_codec_probe,
+	.controls = wcd938x_snd_controls,
+	.num_controls = ARRAY_SIZE(wcd938x_snd_controls),
 };
 
 static void wcd938x_dt_parse_micbias_info(struct device *dev, struct wcd938x_priv *wcd)
-- 
2.21.0

