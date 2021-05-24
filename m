Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A60038E2AD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 10:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhEXIu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 04:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbhEXIuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 04:50:20 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55687C061346
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 01:48:51 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so1165697wmk.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 01:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k0A1E99UAZM7OxR1S9vW5m9G4Jwp2nl5kkXuxAXNj50=;
        b=h5j35hQRhT3DkFU5SwX7EFoIHMhrnG6F1IP1MFdpZ0YPHh174iv93FUXPQfcU77zPo
         iKN8nVUl5P81FKBrgHEghR9d6Z1okiARBz9nW3pSGn+qAaKcEBQ6jHtcU84ur7aqzLSU
         /jxFnBAC9b+EZAX9EoLwwh8CadnrC9W3OGW8W++C/gTzthcwpRNd1EWN0Gjmj4/iovbx
         CYSPppXY21Kq7Hh/Lb+K7xQPP7bveVGyrmqYZEGfho5rcWJhgTTgNICSM8RoDrNU3CPs
         e5imJOqLJZ5v8B2KU5WcrdEVNpw8f/H9y2jCE4Jp9fb/oq45URr21i5EdgV094Jh1kjo
         1l4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k0A1E99UAZM7OxR1S9vW5m9G4Jwp2nl5kkXuxAXNj50=;
        b=JjO/HGxq5+OnyJr8nKaCaNRT12QPm5vfQJ55h4BpaxPyAedbXObAnb92hWWijIs/UK
         JqfJX0RqwuI820p8b1JFVBHWbwxRiltkl32ePlhKr5e34hhYawrG/aakfimYjrwN7s2o
         ZDNwXf0AzeubhhvdllMeTjh8K9+f07JWp1YbXZzy9UXLtA3ZURduUtVASxqWde6bD4vn
         mg80lVyq2mumQ0efuPidfRYuvWV2kTxfttqyvuHWPOvRHug4ndfSe7UMSAckGyIz7ycN
         YKI6ZSCI3MneShSq9+5fvAxZQ1p4WsoPVjwTVYZ2KJaFVqKLi2VPML7wLf976mD6aLrH
         mWsA==
X-Gm-Message-State: AOAM531tIsHmXt7ZuxGCl/DKlpfu63lf8vlAIfSHfVuRyWk4QmaYNU19
        8T9rKXdh7HxZA4158xEMzD7GU11tVBS/MA==
X-Google-Smtp-Source: ABdhPJz1MnXvZ6/dG+c0qlU9dKa82LLT16PSycAoohj4OlOHHEg8TphSCE6WSnI4gBzaXKzfhk0Aag==
X-Received: by 2002:a7b:c346:: with SMTP id l6mr18414712wmj.109.1621846129781;
        Mon, 24 May 2021 01:48:49 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id x206sm4034548wmx.47.2021.05.24.01.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 01:48:49 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v7 7/9] ASoC: codecs: wcd938x: add playback dapm widgets
Date:   Mon, 24 May 2021 09:48:26 +0100
Message-Id: <20210524084828.12787-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210524084828.12787-1-srinivas.kandagatla@linaro.org>
References: <20210524084828.12787-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds required dapm widgets for playback.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 687 +++++++++++++++++++++++++++++++++++++
 1 file changed, 687 insertions(+)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 04639d3aea3f..26ff795d5e09 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -1329,6 +1329,593 @@ static int wcd938x_connect_port(struct wcd938x_sdw_priv *wcd, u8 ch_id, u8 enabl
 					enable);
 }
 
+static int wcd938x_codec_enable_rxclk(struct snd_soc_dapm_widget *w,
+				      struct snd_kcontrol *kcontrol,
+				      int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_component_write_field(component, WCD938X_DIGITAL_CDC_ANA_CLK_CTL,
+				WCD938X_ANA_RX_CLK_EN_MASK, 1);
+		snd_soc_component_write_field(component, WCD938X_ANA_RX_SUPPLIES,
+				WCD938X_RX_BIAS_EN_MASK, 1);
+		snd_soc_component_write_field(component, WCD938X_DIGITAL_CDC_RX0_CTL,
+				WCD938X_DEM_DITHER_ENABLE_MASK, 0);
+		snd_soc_component_write_field(component, WCD938X_DIGITAL_CDC_RX1_CTL,
+				WCD938X_DEM_DITHER_ENABLE_MASK, 0);
+		snd_soc_component_write_field(component, WCD938X_DIGITAL_CDC_RX2_CTL,
+				WCD938X_DEM_DITHER_ENABLE_MASK, 0);
+		snd_soc_component_write_field(component, WCD938X_DIGITAL_CDC_ANA_CLK_CTL,
+				WCD938X_ANA_RX_DIV2_CLK_EN_MASK, 1);
+		snd_soc_component_write_field(component, WCD938X_AUX_AUXPA,
+					      WCD938X_AUXPA_CLK_EN_MASK, 1);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_component_write_field(component, WCD938X_ANA_RX_SUPPLIES,
+				WCD938X_VNEG_EN_MASK, 0);
+		snd_soc_component_write_field(component, WCD938X_ANA_RX_SUPPLIES,
+				WCD938X_VPOS_EN_MASK, 0);
+		snd_soc_component_write_field(component, WCD938X_ANA_RX_SUPPLIES,
+				WCD938X_RX_BIAS_EN_MASK, 0);
+		snd_soc_component_write_field(component, WCD938X_DIGITAL_CDC_ANA_CLK_CTL,
+				WCD938X_ANA_RX_DIV2_CLK_EN_MASK, 0);
+		snd_soc_component_write_field(component, WCD938X_DIGITAL_CDC_ANA_CLK_CTL,
+				WCD938X_ANA_RX_CLK_EN_MASK, 0);
+		break;
+	}
+	return 0;
+}
+
+static int wcd938x_codec_hphl_dac_event(struct snd_soc_dapm_widget *w,
+					struct snd_kcontrol *kcontrol,
+					int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_component_write_field(component,
+				WCD938X_DIGITAL_CDC_DIG_CLK_CTL,
+				WCD938X_RXD0_CLK_EN_MASK, 0x01);
+		snd_soc_component_write_field(component,
+				WCD938X_DIGITAL_CDC_HPH_GAIN_CTL,
+				WCD938X_HPHL_RX_EN_MASK, 1);
+		snd_soc_component_write_field(component,
+				WCD938X_HPH_RDAC_CLK_CTL1,
+				WCD938X_CHOP_CLK_EN_MASK, 0);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		snd_soc_component_write_field(component,
+				WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_L,
+				WCD938X_HPH_RES_DIV_MASK, 0x02);
+		if (wcd938x->comp1_enable) {
+			snd_soc_component_write_field(component,
+				WCD938X_DIGITAL_CDC_COMP_CTL_0,
+				WCD938X_HPHL_COMP_EN_MASK, 1);
+			/* 5msec compander delay as per HW requirement */
+			if (!wcd938x->comp2_enable || (snd_soc_component_read(component,
+							 WCD938X_DIGITAL_CDC_COMP_CTL_0) & 0x01))
+				usleep_range(5000, 5010);
+			snd_soc_component_write_field(component, WCD938X_HPH_NEW_INT_HPH_TIMER1,
+					      WCD938X_AUTOCHOP_TIMER_EN, 0);
+		} else {
+			snd_soc_component_write_field(component,
+					WCD938X_DIGITAL_CDC_COMP_CTL_0,
+					WCD938X_HPHL_COMP_EN_MASK, 0);
+			snd_soc_component_write_field(component,
+					WCD938X_HPH_L_EN,
+					WCD938X_GAIN_SRC_SEL_MASK,
+					WCD938X_GAIN_SRC_SEL_REGISTER);
+
+		}
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_component_write_field(component,
+			WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_R,
+			WCD938X_HPH_RES_DIV_MASK, 0x1);
+		break;
+	}
+
+	return 0;
+}
+
+static int wcd938x_codec_hphr_dac_event(struct snd_soc_dapm_widget *w,
+					struct snd_kcontrol *kcontrol,
+					int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_component_write_field(component,
+				WCD938X_DIGITAL_CDC_DIG_CLK_CTL,
+				WCD938X_RXD1_CLK_EN_MASK, 1);
+		snd_soc_component_write_field(component,
+				WCD938X_DIGITAL_CDC_HPH_GAIN_CTL,
+				WCD938X_HPHR_RX_EN_MASK, 1);
+		snd_soc_component_write_field(component,
+				WCD938X_HPH_RDAC_CLK_CTL1,
+				WCD938X_CHOP_CLK_EN_MASK, 0);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		snd_soc_component_write_field(component,
+				WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_R,
+				WCD938X_HPH_RES_DIV_MASK, 0x02);
+		if (wcd938x->comp2_enable) {
+			snd_soc_component_write_field(component,
+				WCD938X_DIGITAL_CDC_COMP_CTL_0,
+				WCD938X_HPHR_COMP_EN_MASK, 1);
+			/* 5msec compander delay as per HW requirement */
+			if (!wcd938x->comp1_enable ||
+				(snd_soc_component_read(component,
+					WCD938X_DIGITAL_CDC_COMP_CTL_0) & 0x02))
+				usleep_range(5000, 5010);
+			snd_soc_component_write_field(component, WCD938X_HPH_NEW_INT_HPH_TIMER1,
+					      WCD938X_AUTOCHOP_TIMER_EN, 0);
+		} else {
+			snd_soc_component_write_field(component,
+					WCD938X_DIGITAL_CDC_COMP_CTL_0,
+					WCD938X_HPHR_COMP_EN_MASK, 0);
+			snd_soc_component_write_field(component,
+					WCD938X_HPH_R_EN,
+					WCD938X_GAIN_SRC_SEL_MASK,
+					WCD938X_GAIN_SRC_SEL_REGISTER);
+		}
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_component_write_field(component,
+			WCD938X_HPH_NEW_INT_RDAC_HD2_CTL_R,
+			WCD938X_HPH_RES_DIV_MASK, 0x01);
+		break;
+	}
+
+	return 0;
+}
+
+static int wcd938x_codec_ear_dac_event(struct snd_soc_dapm_widget *w,
+				       struct snd_kcontrol *kcontrol,
+				       int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		wcd938x->ear_rx_path =
+			snd_soc_component_read(
+				component, WCD938X_DIGITAL_CDC_EAR_PATH_CTL);
+		if (wcd938x->ear_rx_path & EAR_RX_PATH_AUX) {
+			snd_soc_component_write_field(component,
+				WCD938X_EAR_EAR_DAC_CON,
+				WCD938X_DAC_SAMPLE_EDGE_SEL_MASK, 0);
+			snd_soc_component_write_field(component,
+				WCD938X_DIGITAL_CDC_AUX_GAIN_CTL,
+				WCD938X_AUX_EN_MASK, 1);
+			snd_soc_component_write_field(component,
+				WCD938X_DIGITAL_CDC_DIG_CLK_CTL,
+				WCD938X_RXD2_CLK_EN_MASK, 1);
+			snd_soc_component_write_field(component,
+				WCD938X_ANA_EAR_COMPANDER_CTL,
+				WCD938X_GAIN_OVRD_REG_MASK, 1);
+		} else {
+			snd_soc_component_write_field(component,
+				WCD938X_DIGITAL_CDC_HPH_GAIN_CTL,
+				WCD938X_HPHL_RX_EN_MASK, 1);
+			snd_soc_component_write_field(component,
+				WCD938X_DIGITAL_CDC_DIG_CLK_CTL,
+				WCD938X_RXD0_CLK_EN_MASK, 1);
+			if (wcd938x->comp1_enable)
+				snd_soc_component_write_field(component,
+					WCD938X_DIGITAL_CDC_COMP_CTL_0,
+					WCD938X_HPHL_COMP_EN_MASK, 1);
+		}
+		/* 5 msec delay as per HW requirement */
+		usleep_range(5000, 5010);
+		if (wcd938x->flyback_cur_det_disable == 0)
+			snd_soc_component_write_field(component, WCD938X_FLYBACK_EN,
+						      WCD938X_EN_CUR_DET_MASK, 0);
+		wcd938x->flyback_cur_det_disable++;
+		wcd_clsh_ctrl_set_state(wcd938x->clsh_info,
+			     WCD_CLSH_EVENT_PRE_DAC,
+			     WCD_CLSH_STATE_EAR,
+			     wcd938x->hph_mode);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		if (wcd938x->ear_rx_path & EAR_RX_PATH_AUX) {
+			snd_soc_component_write_field(component,
+				WCD938X_DIGITAL_CDC_AUX_GAIN_CTL,
+				WCD938X_AUX_EN_MASK, 0);
+			snd_soc_component_write_field(component,
+				WCD938X_DIGITAL_CDC_DIG_CLK_CTL,
+				WCD938X_RXD2_CLK_EN_MASK, 0);
+		} else {
+			snd_soc_component_write_field(component,
+				WCD938X_DIGITAL_CDC_HPH_GAIN_CTL,
+				WCD938X_HPHL_RX_EN_MASK, 0);
+			snd_soc_component_write_field(component,
+				WCD938X_DIGITAL_CDC_DIG_CLK_CTL,
+				WCD938X_RXD0_CLK_EN_MASK, 0);
+			if (wcd938x->comp1_enable)
+				snd_soc_component_write_field(component,
+					WCD938X_DIGITAL_CDC_COMP_CTL_0,
+					WCD938X_HPHL_COMP_EN_MASK, 0);
+		}
+		snd_soc_component_write_field(component, WCD938X_ANA_EAR_COMPANDER_CTL,
+					      WCD938X_GAIN_OVRD_REG_MASK, 0);
+		snd_soc_component_write_field(component,
+				WCD938X_EAR_EAR_DAC_CON,
+				WCD938X_DAC_SAMPLE_EDGE_SEL_MASK, 1);
+		break;
+	};
+	return 0;
+
+}
+
+static int wcd938x_codec_aux_dac_event(struct snd_soc_dapm_widget *w,
+				       struct snd_kcontrol *kcontrol,
+				       int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+	int ret = 0;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_component_write_field(component,
+				WCD938X_DIGITAL_CDC_ANA_CLK_CTL,
+				WCD938X_ANA_RX_DIV4_CLK_EN_MASK, 1);
+		snd_soc_component_write_field(component,
+				WCD938X_DIGITAL_CDC_DIG_CLK_CTL,
+				WCD938X_RXD2_CLK_EN_MASK, 1);
+		snd_soc_component_write_field(component,
+				WCD938X_DIGITAL_CDC_AUX_GAIN_CTL,
+				WCD938X_AUX_EN_MASK, 1);
+		if (wcd938x->flyback_cur_det_disable == 0)
+			snd_soc_component_write_field(component, WCD938X_FLYBACK_EN,
+						      WCD938X_EN_CUR_DET_MASK, 0);
+		wcd938x->flyback_cur_det_disable++;
+		wcd_clsh_ctrl_set_state(wcd938x->clsh_info,
+			     WCD_CLSH_EVENT_PRE_DAC,
+			     WCD_CLSH_STATE_AUX,
+			     wcd938x->hph_mode);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_component_write_field(component,
+				WCD938X_DIGITAL_CDC_ANA_CLK_CTL,
+				WCD938X_ANA_RX_DIV4_CLK_EN_MASK, 0);
+		break;
+	};
+	return ret;
+
+}
+
+static int wcd938x_codec_enable_hphr_pa(struct snd_soc_dapm_widget *w,
+					struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+	int hph_mode = wcd938x->hph_mode;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (wcd938x->ldoh)
+			snd_soc_component_write_field(component, WCD938X_LDOH_MODE,
+						      WCD938X_LDOH_EN_MASK, 1);
+		wcd_clsh_ctrl_set_state(wcd938x->clsh_info, WCD_CLSH_EVENT_PRE_DAC,
+					WCD_CLSH_STATE_HPHR, hph_mode);
+		wcd_clsh_set_hph_mode(wcd938x->clsh_info, CLS_H_HIFI);
+
+		if (hph_mode == CLS_H_LP || hph_mode == CLS_H_LOHIFI ||
+		    hph_mode == CLS_H_ULP) {
+			snd_soc_component_write_field(component,
+				WCD938X_HPH_REFBUFF_LP_CTL,
+				WCD938X_PREREF_FLIT_BYPASS_MASK, 1);
+		}
+		snd_soc_component_write_field(component, WCD938X_ANA_HPH,
+					      WCD938X_HPHR_REF_EN_MASK, 1);
+		wcd_clsh_set_hph_mode(wcd938x->clsh_info, hph_mode);
+		/* 100 usec delay as per HW requirement */
+		usleep_range(100, 110);
+		set_bit(HPH_PA_DELAY, &wcd938x->status_mask);
+		snd_soc_component_write_field(component,
+					      WCD938X_DIGITAL_PDM_WD_CTL1,
+					      WCD938X_PDM_WD_EN_MASK, 0x3);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		/*
+		 * 7ms sleep is required if compander is enabled as per
+		 * HW requirement. If compander is disabled, then
+		 * 20ms delay is required.
+		 */
+		if (test_bit(HPH_PA_DELAY, &wcd938x->status_mask)) {
+			if (!wcd938x->comp2_enable)
+				usleep_range(20000, 20100);
+			else
+				usleep_range(7000, 7100);
+
+			if (hph_mode == CLS_H_LP || hph_mode == CLS_H_LOHIFI ||
+			    hph_mode == CLS_H_ULP)
+				snd_soc_component_write_field(component,
+						WCD938X_HPH_REFBUFF_LP_CTL,
+						WCD938X_PREREF_FLIT_BYPASS_MASK, 0);
+			clear_bit(HPH_PA_DELAY, &wcd938x->status_mask);
+		}
+		snd_soc_component_write_field(component, WCD938X_HPH_NEW_INT_HPH_TIMER1,
+					      WCD938X_AUTOCHOP_TIMER_EN, 1);
+		if (hph_mode == CLS_AB || hph_mode == CLS_AB_HIFI ||
+			hph_mode == CLS_AB_LP || hph_mode == CLS_AB_LOHIFI)
+			snd_soc_component_write_field(component, WCD938X_ANA_RX_SUPPLIES,
+					WCD938X_REGULATOR_MODE_MASK,
+					WCD938X_REGULATOR_MODE_CLASS_AB);
+		enable_irq(wcd938x->hphr_pdm_wd_int);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		disable_irq_nosync(wcd938x->hphr_pdm_wd_int);
+		/*
+		 * 7ms sleep is required if compander is enabled as per
+		 * HW requirement. If compander is disabled, then
+		 * 20ms delay is required.
+		 */
+		if (!wcd938x->comp2_enable)
+			usleep_range(20000, 20100);
+		else
+			usleep_range(7000, 7100);
+		snd_soc_component_write_field(component, WCD938X_ANA_HPH,
+					      WCD938X_HPHR_EN_MASK, 0);
+		set_bit(HPH_PA_DELAY, &wcd938x->status_mask);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		/*
+		 * 7ms sleep is required if compander is enabled as per
+		 * HW requirement. If compander is disabled, then
+		 * 20ms delay is required.
+		 */
+		if (test_bit(HPH_PA_DELAY, &wcd938x->status_mask)) {
+			if (!wcd938x->comp2_enable)
+				usleep_range(20000, 20100);
+			else
+				usleep_range(7000, 7100);
+			clear_bit(HPH_PA_DELAY, &wcd938x->status_mask);
+		}
+		snd_soc_component_write_field(component, WCD938X_ANA_HPH,
+					      WCD938X_HPHR_REF_EN_MASK, 0);
+		snd_soc_component_write_field(component, WCD938X_DIGITAL_PDM_WD_CTL1,
+					      WCD938X_PDM_WD_EN_MASK, 0);
+		wcd_clsh_ctrl_set_state(wcd938x->clsh_info, WCD_CLSH_EVENT_POST_PA,
+					WCD_CLSH_STATE_HPHR, hph_mode);
+		if (wcd938x->ldoh)
+			snd_soc_component_write_field(component, WCD938X_LDOH_MODE,
+						      WCD938X_LDOH_EN_MASK, 0);
+		break;
+	};
+
+	return 0;
+}
+
+static int wcd938x_codec_enable_hphl_pa(struct snd_soc_dapm_widget *w,
+					struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+	int hph_mode = wcd938x->hph_mode;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (wcd938x->ldoh)
+			snd_soc_component_write_field(component, WCD938X_LDOH_MODE,
+						      WCD938X_LDOH_EN_MASK, 1);
+		wcd_clsh_ctrl_set_state(wcd938x->clsh_info, WCD_CLSH_EVENT_PRE_DAC,
+					WCD_CLSH_STATE_HPHL, hph_mode);
+		wcd_clsh_set_hph_mode(wcd938x->clsh_info, CLS_H_HIFI);
+		if (hph_mode == CLS_H_LP || hph_mode == CLS_H_LOHIFI ||
+		    hph_mode == CLS_H_ULP) {
+			snd_soc_component_write_field(component,
+					WCD938X_HPH_REFBUFF_LP_CTL,
+					WCD938X_PREREF_FLIT_BYPASS_MASK, 1);
+		}
+		snd_soc_component_write_field(component, WCD938X_ANA_HPH,
+					      WCD938X_HPHL_REF_EN_MASK, 1);
+		wcd_clsh_set_hph_mode(wcd938x->clsh_info, hph_mode);
+		/* 100 usec delay as per HW requirement */
+		usleep_range(100, 110);
+		set_bit(HPH_PA_DELAY, &wcd938x->status_mask);
+		snd_soc_component_write_field(component,
+					WCD938X_DIGITAL_PDM_WD_CTL0,
+					WCD938X_PDM_WD_EN_MASK, 0x3);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		/*
+		 * 7ms sleep is required if compander is enabled as per
+		 * HW requirement. If compander is disabled, then
+		 * 20ms delay is required.
+		 */
+		if (test_bit(HPH_PA_DELAY, &wcd938x->status_mask)) {
+			if (!wcd938x->comp1_enable)
+				usleep_range(20000, 20100);
+			else
+				usleep_range(7000, 7100);
+			if (hph_mode == CLS_H_LP || hph_mode == CLS_H_LOHIFI ||
+			    hph_mode == CLS_H_ULP)
+				snd_soc_component_write_field(component,
+					WCD938X_HPH_REFBUFF_LP_CTL,
+					WCD938X_PREREF_FLIT_BYPASS_MASK, 0);
+			clear_bit(HPH_PA_DELAY, &wcd938x->status_mask);
+		}
+
+		snd_soc_component_write_field(component, WCD938X_HPH_NEW_INT_HPH_TIMER1,
+					      WCD938X_AUTOCHOP_TIMER_EN, 1);
+		if (hph_mode == CLS_AB || hph_mode == CLS_AB_HIFI ||
+			hph_mode == CLS_AB_LP || hph_mode == CLS_AB_LOHIFI)
+			snd_soc_component_write_field(component, WCD938X_ANA_RX_SUPPLIES,
+					WCD938X_REGULATOR_MODE_MASK,
+					WCD938X_REGULATOR_MODE_CLASS_AB);
+		enable_irq(wcd938x->hphl_pdm_wd_int);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		disable_irq_nosync(wcd938x->hphl_pdm_wd_int);
+		/*
+		 * 7ms sleep is required if compander is enabled as per
+		 * HW requirement. If compander is disabled, then
+		 * 20ms delay is required.
+		 */
+		if (!wcd938x->comp1_enable)
+			usleep_range(20000, 20100);
+		else
+			usleep_range(7000, 7100);
+		snd_soc_component_write_field(component, WCD938X_ANA_HPH,
+					      WCD938X_HPHL_EN_MASK, 0);
+		set_bit(HPH_PA_DELAY, &wcd938x->status_mask);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		/*
+		 * 7ms sleep is required if compander is enabled as per
+		 * HW requirement. If compander is disabled, then
+		 * 20ms delay is required.
+		 */
+		if (test_bit(HPH_PA_DELAY, &wcd938x->status_mask)) {
+			if (!wcd938x->comp1_enable)
+				usleep_range(21000, 21100);
+			else
+				usleep_range(7000, 7100);
+			clear_bit(HPH_PA_DELAY, &wcd938x->status_mask);
+		}
+		snd_soc_component_write_field(component, WCD938X_ANA_HPH,
+					      WCD938X_HPHL_REF_EN_MASK, 0);
+		snd_soc_component_write_field(component, WCD938X_DIGITAL_PDM_WD_CTL0,
+					      WCD938X_PDM_WD_EN_MASK, 0);
+		wcd_clsh_ctrl_set_state(wcd938x->clsh_info, WCD_CLSH_EVENT_POST_PA,
+					WCD_CLSH_STATE_HPHL, hph_mode);
+		if (wcd938x->ldoh)
+			snd_soc_component_write_field(component, WCD938X_LDOH_MODE,
+						      WCD938X_LDOH_EN_MASK, 0);
+		break;
+	};
+
+	return 0;
+}
+
+static int wcd938x_codec_enable_aux_pa(struct snd_soc_dapm_widget *w,
+				       struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+	int hph_mode = wcd938x->hph_mode;
+	int ret = 0;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_component_write_field(component, WCD938X_DIGITAL_PDM_WD_CTL2,
+					      WCD938X_AUX_PDM_WD_EN_MASK, 1);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		/* 1 msec delay as per HW requirement */
+		usleep_range(1000, 1010);
+		if (hph_mode == CLS_AB || hph_mode == CLS_AB_HIFI ||
+			hph_mode == CLS_AB_LP || hph_mode == CLS_AB_LOHIFI)
+			snd_soc_component_write_field(component, WCD938X_ANA_RX_SUPPLIES,
+					WCD938X_REGULATOR_MODE_MASK,
+					WCD938X_REGULATOR_MODE_CLASS_AB);
+		enable_irq(wcd938x->aux_pdm_wd_int);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		disable_irq_nosync(wcd938x->aux_pdm_wd_int);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		/* 1 msec delay as per HW requirement */
+		usleep_range(1000, 1010);
+		snd_soc_component_write_field(component, WCD938X_DIGITAL_PDM_WD_CTL2,
+					      WCD938X_AUX_PDM_WD_EN_MASK, 0);
+		wcd_clsh_ctrl_set_state(wcd938x->clsh_info,
+			     WCD_CLSH_EVENT_POST_PA,
+			     WCD_CLSH_STATE_AUX,
+			     hph_mode);
+
+		wcd938x->flyback_cur_det_disable--;
+		if (wcd938x->flyback_cur_det_disable == 0)
+			snd_soc_component_write_field(component, WCD938X_FLYBACK_EN,
+						      WCD938X_EN_CUR_DET_MASK, 1);
+		break;
+	};
+	return ret;
+}
+
+static int wcd938x_codec_enable_ear_pa(struct snd_soc_dapm_widget *w,
+				       struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+	int hph_mode = wcd938x->hph_mode;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		/*
+		 * Enable watchdog interrupt for HPHL or AUX
+		 * depending on mux value
+		 */
+		wcd938x->ear_rx_path = snd_soc_component_read(component,
+							      WCD938X_DIGITAL_CDC_EAR_PATH_CTL);
+		if (wcd938x->ear_rx_path & EAR_RX_PATH_AUX)
+			snd_soc_component_write_field(component, WCD938X_DIGITAL_PDM_WD_CTL2,
+					      WCD938X_AUX_PDM_WD_EN_MASK, 1);
+		else
+			snd_soc_component_write_field(component,
+						      WCD938X_DIGITAL_PDM_WD_CTL0,
+						      WCD938X_PDM_WD_EN_MASK, 0x3);
+		if (!wcd938x->comp1_enable)
+			snd_soc_component_write_field(component,
+						      WCD938X_ANA_EAR_COMPANDER_CTL,
+						      WCD938X_GAIN_OVRD_REG_MASK, 1);
+
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		/* 6 msec delay as per HW requirement */
+		usleep_range(6000, 6010);
+		if (hph_mode == CLS_AB || hph_mode == CLS_AB_HIFI ||
+			hph_mode == CLS_AB_LP || hph_mode == CLS_AB_LOHIFI)
+			snd_soc_component_write_field(component, WCD938X_ANA_RX_SUPPLIES,
+					WCD938X_REGULATOR_MODE_MASK,
+					WCD938X_REGULATOR_MODE_CLASS_AB);
+		if (wcd938x->ear_rx_path & EAR_RX_PATH_AUX)
+			enable_irq(wcd938x->aux_pdm_wd_int);
+		else
+			enable_irq(wcd938x->hphl_pdm_wd_int);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		if (wcd938x->ear_rx_path & EAR_RX_PATH_AUX)
+			disable_irq_nosync(wcd938x->aux_pdm_wd_int);
+		else
+			disable_irq_nosync(wcd938x->hphl_pdm_wd_int);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		if (!wcd938x->comp1_enable)
+			snd_soc_component_write_field(component, WCD938X_ANA_EAR_COMPANDER_CTL,
+						      WCD938X_GAIN_OVRD_REG_MASK, 0);
+		/* 7 msec delay as per HW requirement */
+		usleep_range(7000, 7010);
+		if (wcd938x->ear_rx_path & EAR_RX_PATH_AUX)
+			snd_soc_component_write_field(component, WCD938X_DIGITAL_PDM_WD_CTL2,
+					      WCD938X_AUX_PDM_WD_EN_MASK, 0);
+		else
+			snd_soc_component_write_field(component, WCD938X_DIGITAL_PDM_WD_CTL0,
+					WCD938X_PDM_WD_EN_MASK, 0);
+
+		wcd_clsh_ctrl_set_state(wcd938x->clsh_info, WCD_CLSH_EVENT_POST_PA,
+					WCD_CLSH_STATE_EAR, hph_mode);
+
+		wcd938x->flyback_cur_det_disable--;
+		if (wcd938x->flyback_cur_det_disable == 0)
+			snd_soc_component_write_field(component, WCD938X_FLYBACK_EN,
+						      WCD938X_EN_CUR_DET_MASK, 1);
+		break;
+	};
+
+	return 0;
+}
+
 static int wcd938x_tx_mode_get(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
@@ -1507,6 +2094,10 @@ static const char * const rx_hph_mode_mux_text[] = {
 	"CLS_H_ULP", "CLS_AB_HIFI", "CLS_AB_LP", "CLS_AB_LOHIFI",
 };
 
+static const char * const rdac3_mux_text[] = {
+	"RX1", "RX3"
+};
+
 static const struct soc_enum tx_mode_mux_enum_wcd9380[] = {
 	SOC_ENUM_SINGLE(SND_SOC_NOPM, 0, ARRAY_SIZE(tx_mode_mux_text_wcd9380),
 			tx_mode_mux_text_wcd9380),
@@ -1537,6 +2128,29 @@ static const struct soc_enum rx_hph_mode_mux_enum =
 		SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(rx_hph_mode_mux_text),
 				    rx_hph_mode_mux_text);
 
+static const struct soc_enum rdac3_enum =
+		SOC_ENUM_SINGLE(WCD938X_DIGITAL_CDC_EAR_PATH_CTL, 0,
+				ARRAY_SIZE(rdac3_mux_text), rdac3_mux_text);
+
+static const struct snd_kcontrol_new ear_rdac_switch[] = {
+	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 0, 1, 0)
+};
+
+static const struct snd_kcontrol_new aux_rdac_switch[] = {
+	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 0, 1, 0)
+};
+
+static const struct snd_kcontrol_new hphl_rdac_switch[] = {
+	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 0, 1, 0)
+};
+
+static const struct snd_kcontrol_new hphr_rdac_switch[] = {
+	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 0, 1, 0)
+};
+
+static const struct snd_kcontrol_new rx_rdac3_mux =
+	SOC_DAPM_ENUM("RDAC3_MUX Mux", rdac3_enum);
+
 static const struct snd_kcontrol_new wcd9380_snd_controls[] = {
 	SOC_ENUM_EXT("RX HPH Mode", rx_hph_mode_mux_enum_wcd9380,
 		     wcd938x_rx_hph_mode_get, wcd938x_rx_hph_mode_put),
@@ -1665,6 +2279,77 @@ static const struct snd_kcontrol_new wcd938x_snd_controls[] = {
 	SOC_SINGLE_TLV("ADC4 Volume", WCD938X_ANA_TX_CH4, 0, 20, 0, analog_gain),
 };
 
+static const struct snd_soc_dapm_widget wcd938x_dapm_widgets[] = {
+	SND_SOC_DAPM_INPUT("IN1_HPHL"),
+	SND_SOC_DAPM_INPUT("IN2_HPHR"),
+	SND_SOC_DAPM_INPUT("IN3_AUX"),
+
+	/*rx widgets*/
+	SND_SOC_DAPM_PGA_E("EAR PGA", WCD938X_ANA_EAR, 7, 0, NULL, 0,
+			   wcd938x_codec_enable_ear_pa,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_PGA_E("AUX PGA", WCD938X_AUX_AUXPA, 7, 0, NULL, 0,
+			   wcd938x_codec_enable_aux_pa,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_PGA_E("HPHL PGA", WCD938X_ANA_HPH, 7, 0, NULL, 0,
+			   wcd938x_codec_enable_hphl_pa,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_PGA_E("HPHR PGA", WCD938X_ANA_HPH, 6, 0, NULL, 0,
+			   wcd938x_codec_enable_hphr_pa,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_DAC_E("RDAC1", NULL, SND_SOC_NOPM, 0, 0,
+			   wcd938x_codec_hphl_dac_event,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_DAC_E("RDAC2", NULL, SND_SOC_NOPM, 0, 0,
+			   wcd938x_codec_hphr_dac_event,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_DAC_E("RDAC3", NULL, SND_SOC_NOPM, 0, 0,
+			   wcd938x_codec_ear_dac_event,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_DAC_E("RDAC4", NULL, SND_SOC_NOPM, 0, 0,
+			   wcd938x_codec_aux_dac_event,
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_MUX("RDAC3_MUX", SND_SOC_NOPM, 0, 0, &rx_rdac3_mux),
+
+	SND_SOC_DAPM_SUPPLY("VDD_BUCK", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("RXCLK", SND_SOC_NOPM, 0, 0,
+			    wcd938x_codec_enable_rxclk,
+			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			    SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_SUPPLY_S("CLS_H_PORT", 1, SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_MIXER_E("RX1", SND_SOC_NOPM, 0, 0, NULL, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER_E("RX2", SND_SOC_NOPM, 0, 0, NULL, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER_E("RX3", SND_SOC_NOPM, 0, 0, NULL, 0, NULL, 0),
+
+	/* rx mixer widgets*/
+	SND_SOC_DAPM_MIXER("EAR_RDAC", SND_SOC_NOPM, 0, 0,
+			   ear_rdac_switch, ARRAY_SIZE(ear_rdac_switch)),
+	SND_SOC_DAPM_MIXER("AUX_RDAC", SND_SOC_NOPM, 0, 0,
+			   aux_rdac_switch, ARRAY_SIZE(aux_rdac_switch)),
+	SND_SOC_DAPM_MIXER("HPHL_RDAC", SND_SOC_NOPM, 0, 0,
+			   hphl_rdac_switch, ARRAY_SIZE(hphl_rdac_switch)),
+	SND_SOC_DAPM_MIXER("HPHR_RDAC", SND_SOC_NOPM, 0, 0,
+			   hphr_rdac_switch, ARRAY_SIZE(hphr_rdac_switch)),
+
+	/*output widgets rx*/
+	SND_SOC_DAPM_OUTPUT("EAR"),
+	SND_SOC_DAPM_OUTPUT("AUX"),
+	SND_SOC_DAPM_OUTPUT("HPHL"),
+	SND_SOC_DAPM_OUTPUT("HPHR"),
+};
+
 static int wcd938x_get_micb_vout_ctl_val(u32 micb_mv)
 {
 	/* min micbias voltage is 1V and maximum is 2.85V */
@@ -1828,6 +2513,8 @@ static const struct snd_soc_component_driver soc_codec_dev_wcd938x = {
 	.probe = wcd938x_soc_codec_probe,
 	.controls = wcd938x_snd_controls,
 	.num_controls = ARRAY_SIZE(wcd938x_snd_controls),
+	.dapm_widgets = wcd938x_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wcd938x_dapm_widgets),
 };
 
 static void wcd938x_dt_parse_micbias_info(struct device *dev, struct wcd938x_priv *wcd)
-- 
2.21.0

