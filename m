Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A76B33D250
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbhCPK7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 06:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236935AbhCPK6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 06:58:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92369C0613DB
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 03:58:45 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 12so4826125wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 03:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/vUWvhAchaqpjbMn74HpIxb8CiMc71rLCGrcTJNmxv0=;
        b=K3MKD6XXGXJ0yT+1v/UqRy2TXWDGhBzNxHRnOrIAVvwvDDoU6GAQxmwOE7mvD1tUE3
         AKFSQiD4ypdPsEzPOAyt41Mxs/fig+i4h5xsf0syMKWMpZiC3GlTs6KcKMiP69gv7wkB
         HlvjofddxDGpNOP4hdkKKwSjHWuGbWb3ycYlcNMHkXPQloKT8NREPY7z2rlP1ZpPqabc
         kZkVxYf+CZdvHsYkeQwFedVize36XaJMu2u1tMkO7HkD9+TkUDX1FlQh0LnebNzLbXYN
         5UvZjwPrdUsxq13WKrFcIQrRMkBXcoGkVfal8XsNL4lItMeu0DwKgEtFZCs/w26aQet7
         ofEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/vUWvhAchaqpjbMn74HpIxb8CiMc71rLCGrcTJNmxv0=;
        b=JJc1gBQsLihdTzZ2X8cx2XNrGpKlaO4KF790cpV72pl65Rh9Y1qvmo+NAtY5L8ACq5
         A8b1XnkWZKOUlIMjxQb4acl60F2RvYKvy5D40bDAPzfLf3bMdi/aTum2R5+cJPNGgT3C
         CzdcSwU1p48kk9lFtjB6rs4bULa3T0VYzDOBX7+/VMtuJ3aASyXCjAiFOmmXNmGIOOwq
         bSGHtBHY/8HCOW7cJcdMoMUsfhUwhPWU8tAMiU+4Y/hV+gV9xxaFb9FzijnnDD0JYwth
         UqoYoF7gi5FF3l4uOWQx4gaR7+rz18w8wG9dHeoXo6Nz6Myl0CAMgxfSPtXPMgKlZB3r
         LD/g==
X-Gm-Message-State: AOAM531Y78diHpdL64RzAnXRwctnUKSCP4V6LiduPxMWMJ/9p8GvNOiW
        EZmURwvjOrcGKv+PVfBL5vTEKg==
X-Google-Smtp-Source: ABdhPJyKTSKACAk+lp92kC+DHrswcSM1Gp1jpdsT1V/AY8PmVwMnsNRsazY7+k/1tFe9BOerX3Nszg==
X-Received: by 2002:a1c:6a05:: with SMTP id f5mr4078106wmc.75.1615892324353;
        Tue, 16 Mar 2021 03:58:44 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id t8sm21465956wrr.10.2021.03.16.03.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 03:58:43 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 7/7] ASoC: codecs: wcd938x: add audio routing
Date:   Tue, 16 Mar 2021 10:58:28 +0000
Message-Id: <20210316105828.16436-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210316105828.16436-1-srinivas.kandagatla@linaro.org>
References: <20210316105828.16436-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds audio routing for both playback and capture.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 97 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 31e3cf729568..0f801920ebac 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3153,6 +3153,99 @@ static const struct snd_soc_dapm_widget wcd938x_rx_dapm_widgets[] = {
 
 };
 
+static const struct snd_soc_dapm_route wcd938x_rx_audio_map[] = {
+	{"IN1_HPHL", NULL, "VDD_BUCK"},
+	{"IN1_HPHL", NULL, "CLS_H_PORT"},
+
+	{"RX1", NULL, "IN1_HPHL"},
+	{"RX1", NULL, "RXCLK"},
+	{"RDAC1", NULL, "RX1"},
+	{"HPHL_RDAC", "Switch", "RDAC1"},
+	{"HPHL PGA", NULL, "HPHL_RDAC"},
+	{"HPHL", NULL, "HPHL PGA"},
+
+	{"IN2_HPHR", NULL, "VDD_BUCK"},
+	{"IN2_HPHR", NULL, "CLS_H_PORT"},
+	{"RX2", NULL, "IN2_HPHR"},
+	{"RDAC2", NULL, "RX2"},
+	{"RX2", NULL, "RXCLK"},
+	{"HPHR_RDAC", "Switch", "RDAC2"},
+	{"HPHR PGA", NULL, "HPHR_RDAC"},
+	{"HPHR", NULL, "HPHR PGA"},
+
+	{"IN3_AUX", NULL, "VDD_BUCK"},
+	{"IN3_AUX", NULL, "CLS_H_PORT"},
+	{"RX3", NULL, "IN3_AUX"},
+	{"RDAC4", NULL, "RX3"},
+	{"RX3", NULL, "RXCLK"},
+	{"AUX_RDAC", "Switch", "RDAC4"},
+	{"AUX PGA", NULL, "AUX_RDAC"},
+	{"AUX", NULL, "AUX PGA"},
+
+	{"RDAC3_MUX", "RX3", "RX3"},
+	{"RDAC3_MUX", "RX1", "RX1"},
+	{"RDAC3", NULL, "RDAC3_MUX"},
+	{"EAR_RDAC", "Switch", "RDAC3"},
+	{"EAR PGA", NULL, "EAR_RDAC"},
+	{"EAR", NULL, "EAR PGA"},
+};
+
+static const struct snd_soc_dapm_route wcd938x_audio_map[] = {
+	{"ADC1_OUTPUT", NULL, "ADC1_MIXER"},
+	{"ADC1_MIXER", "Switch", "ADC1 REQ"},
+	{"ADC1 REQ", NULL, "ADC1"},
+	{"ADC1", NULL, "AMIC1"},
+
+	{"ADC2_OUTPUT", NULL, "ADC2_MIXER"},
+	{"ADC2_MIXER", "Switch", "ADC2 REQ"},
+	{"ADC2 REQ", NULL, "ADC2"},
+	{"ADC2", NULL, "HDR12 MUX"},
+	{"HDR12 MUX", "NO_HDR12", "ADC2 MUX"},
+	{"HDR12 MUX", "HDR12", "AMIC1"},
+	{"ADC2 MUX", "INP3", "AMIC3"},
+	{"ADC2 MUX", "INP2", "AMIC2"},
+
+	{"ADC3_OUTPUT", NULL, "ADC3_MIXER"},
+	{"ADC3_MIXER", "Switch", "ADC3 REQ"},
+	{"ADC3 REQ", NULL, "ADC3"},
+	{"ADC3", NULL, "HDR34 MUX"},
+	{"HDR34 MUX", "NO_HDR34", "ADC3 MUX"},
+	{"HDR34 MUX", "HDR34", "AMIC5"},
+	{"ADC3 MUX", "INP4", "AMIC4"},
+	{"ADC3 MUX", "INP6", "AMIC6"},
+
+	{"ADC4_OUTPUT", NULL, "ADC4_MIXER"},
+	{"ADC4_MIXER", "Switch", "ADC4 REQ"},
+	{"ADC4 REQ", NULL, "ADC4"},
+	{"ADC4", NULL, "ADC4 MUX"},
+	{"ADC4 MUX", "INP5", "AMIC5"},
+	{"ADC4 MUX", "INP7", "AMIC7"},
+
+	{"DMIC1_OUTPUT", NULL, "DMIC1_MIXER"},
+	{"DMIC1_MIXER", "Switch", "DMIC1"},
+
+	{"DMIC2_OUTPUT", NULL, "DMIC2_MIXER"},
+	{"DMIC2_MIXER", "Switch", "DMIC2"},
+
+	{"DMIC3_OUTPUT", NULL, "DMIC3_MIXER"},
+	{"DMIC3_MIXER", "Switch", "DMIC3"},
+
+	{"DMIC4_OUTPUT", NULL, "DMIC4_MIXER"},
+	{"DMIC4_MIXER", "Switch", "DMIC4"},
+
+	{"DMIC5_OUTPUT", NULL, "DMIC5_MIXER"},
+	{"DMIC5_MIXER", "Switch", "DMIC5"},
+
+	{"DMIC6_OUTPUT", NULL, "DMIC6_MIXER"},
+	{"DMIC6_MIXER", "Switch", "DMIC6"},
+
+	{"DMIC7_OUTPUT", NULL, "DMIC7_MIXER"},
+	{"DMIC7_MIXER", "Switch", "DMIC7"},
+
+	{"DMIC8_OUTPUT", NULL, "DMIC8_MIXER"},
+	{"DMIC8_MIXER", "Switch", "DMIC8"},
+};
+
 static int wcd938x_get_micb_vout_ctl_val(u32 micb_mv)
 {
 	/* min micbias voltage is 1V and maximum is 2.85V */
@@ -3332,6 +3425,8 @@ static const struct snd_soc_component_driver soc_codec_dev_wcd938x_sdw_rx = {
 	.num_controls = ARRAY_SIZE(wcd938x_rx_snd_controls),
 	.dapm_widgets = wcd938x_rx_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(wcd938x_rx_dapm_widgets),
+	.dapm_routes = wcd938x_rx_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(wcd938x_rx_audio_map),
 };
 
 static const struct snd_soc_component_driver soc_codec_dev_wcd938x_sdw_tx = {
@@ -3341,6 +3436,8 @@ static const struct snd_soc_component_driver soc_codec_dev_wcd938x_sdw_tx = {
 	.num_controls = ARRAY_SIZE(wcd938x_snd_controls),
 	.dapm_widgets = wcd938x_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(wcd938x_dapm_widgets),
+	.dapm_routes = wcd938x_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(wcd938x_audio_map),
 };
 
 static void wcd938x_dt_parse_micbias_info(struct device *dev, struct wcd938x_priv *wcd)
-- 
2.21.0

