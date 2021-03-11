Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBF6337AF8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhCKRfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhCKRfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:35:10 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDFCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 09:35:09 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h98so2955011wrh.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 09:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dmwld0IDC1/VOWzieR6BKsgTEmEgxYcesuBOqNZddyg=;
        b=UdIUHFtcpCc8g1KL7Z7LVur9YLn073u5jgtMXXB6zpFFL9aOv5EM+jVshrgGu2xT+C
         tdfFNj1p2uTY59JKdulxGQaWLpNEhicKK0G+3WiiYSu9dh1jE0oCWLLOw8m7VI7i/4Qc
         TT64GyNQKLA33VpNTtK2fjxmf3RVfeEKGzEZexjEk4r6abiEDdrEtJBx0P78a7XquLwj
         066C8hBpU66wjLGS+WN6+1BFmEbBDcAaMcI9JTBZgCUxQpotT7PuCAHFOts3pOTT/eMB
         VJaq7h75Peo2XTXO/wWMaTuKf9ZfqJEDCTFdeuwUGM9VKmFPxXiCrwgVCLWFkl4N0+SY
         fq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dmwld0IDC1/VOWzieR6BKsgTEmEgxYcesuBOqNZddyg=;
        b=HfjCSVrgFgxasHm2ZlNDSo8RsheohuNBxDuIDWz6r+mwhR8kJyRjDwNq+RSXsltwDQ
         Wjq4ppMelntCKbkJ1SENxBnIDIe93vBlYy4WOLsQRopTjeQYCOpzc9edIfp73PkW/oD2
         LcdcVC2UkFdn0oH93ZLb3RFOqMw7MyB5JICc6oo4iG7y2AbHVeMu4ToXmQb0lrh04P3L
         NSz3moabPo0PZJuDNhDeIaM51IEYC52Qaxm8jRY5p6+Lb45tj0ntHfPbAZDaT/NHGgbl
         ckOnvLvQlaA2xLxxpvBCxWXUhUQUAaXMUvTAX+gPHzmEvil4qprbZxUmyGaBPPz5dS15
         00qg==
X-Gm-Message-State: AOAM53232VmRbbK6oSk5716dmmS0cgdIxavGIe7RY8nYuT/IT2h5sD+G
        MSyHGZ4hP/dnzjbn2LLUpisIBw==
X-Google-Smtp-Source: ABdhPJxi1uHaxJEyBsCkfwTg5oVkY2ifXAmE0uv9xyqTI5zaTrMd+17FOR1P59M+tHYgxjf7ZYycbw==
X-Received: by 2002:adf:9bca:: with SMTP id e10mr9951025wrc.364.1615484108639;
        Thu, 11 Mar 2021 09:35:08 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id 36sm5221152wrh.94.2021.03.11.09.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:35:07 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 7/7] ASoC: codecs: wcd938x: add audio routing
Date:   Thu, 11 Mar 2021 17:34:16 +0000
Message-Id: <20210311173416.25219-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210311173416.25219-1-srinivas.kandagatla@linaro.org>
References: <20210311173416.25219-1-srinivas.kandagatla@linaro.org>
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
index d8aad187458f..f189d98e2f04 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3217,6 +3217,99 @@ static const struct snd_soc_dapm_widget wcd938x_rx_dapm_widgets[] = {
 
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
@@ -3393,6 +3486,8 @@ static const struct snd_soc_component_driver soc_codec_dev_wcd938x_sdw_rx = {
 	.num_controls = ARRAY_SIZE(wcd938x_rx_snd_controls),
 	.dapm_widgets = wcd938x_rx_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(wcd938x_rx_dapm_widgets),
+	.dapm_routes = wcd938x_rx_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(wcd938x_rx_audio_map),
 };
 
 static const struct snd_soc_component_driver soc_codec_dev_wcd938x_sdw_tx = {
@@ -3402,6 +3497,8 @@ static const struct snd_soc_component_driver soc_codec_dev_wcd938x_sdw_tx = {
 	.num_controls = ARRAY_SIZE(wcd938x_snd_controls),
 	.dapm_widgets = wcd938x_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(wcd938x_dapm_widgets),
+	.dapm_routes = wcd938x_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(wcd938x_audio_map),
 };
 
 static void wcd938x_dt_parse_micbias_info(struct device *dev, struct wcd938x_priv *wcd)
-- 
2.21.0

