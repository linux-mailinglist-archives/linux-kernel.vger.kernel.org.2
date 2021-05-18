Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21771387B5B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbhEROkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbhEROjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:39:35 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC56C061761
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:38:17 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h4so10474718wrt.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qctUSYHr5HUHKNeM+US54ACn680xy5JVgv6pYiAbRJA=;
        b=PaUne/AV7EFIHDpv3RMhjn6V7KcBr2J/e9NpauLO3lQxMBLitfmWqwav5L/f0vI8jc
         264o2u+Nny5lTav6s7L2BmB206kRmrqj+g5evNoi7o5wpViKL45g2++JDMsSQX5X8FQO
         2JxzkInxMK0iXVSEyVdVirDN0ddTSVYQS8x5wKtX4Fs8lepIti1uqncD4ooBB7Lb3Ndo
         FGDXu/0mML9uHw5+SQa6d7l6V0bt3gnviWfc0SA3+aGkFzzTvvZ0VDkb/u7WPbDVcxqx
         dCuGrGpbqIvEYu9ku+cMp5UyBOfbaYxa048+FDEAd7bYsNNAlz1dlCXlEbEtkhtXenY7
         OlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qctUSYHr5HUHKNeM+US54ACn680xy5JVgv6pYiAbRJA=;
        b=UEB/VinxagzMgHtgecI+UOcawDUlO2qzAg/DhJsk87tWsDiumBK3S4ZNzjrQc11Upr
         uVyqEzCh2u+mjGE7jvGkOvR9ncJhBFtjVs8WqcCy7wLhp6QTtY+I6OGYX+q8dKnAs7Oy
         WnU2fum6dd1iX7RZ+UAt98Xb/u8JtWV0bE2BqQTJLnhGWjh7KQqaBkIP4irGdAH62u2J
         1gkC1E319dgdUpko8ajSIeB23SeZkdJS4WdZ4Zi6uXQ2XA9ZpHWivLNury24XQ9t45rQ
         28HySge/0i445vSrDjpi/U+9Kr6T7dCPlQjIOCnbyW336xLOrgw9T+dPkiI/HIJWuLWs
         Iv3w==
X-Gm-Message-State: AOAM532YFH2GFfjEQU/pG+krKJexY1DTsBHz+Qzs8KMzk6V1/qHaq+1J
        MuACXtyEBacC8SGzAH0vV9RkgA==
X-Google-Smtp-Source: ABdhPJzzGbp5vVhPB4fKLKZHZUQ0kejHsiNGIeuaxPEmPswfePeQdSGGd/2pmvFIfjeH79xeCVbQNg==
X-Received: by 2002:adf:f386:: with SMTP id m6mr7641808wro.111.1621348695908;
        Tue, 18 May 2021 07:38:15 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id m6sm21329087wrp.29.2021.05.18.07.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 07:38:15 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v6 9/9] ASoC: codecs: wcd938x: add audio routing
Date:   Tue, 18 May 2021 15:37:59 +0100
Message-Id: <20210518143759.16837-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210518143759.16837-1-srinivas.kandagatla@linaro.org>
References: <20210518143759.16837-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds audio routing for both playback and capture.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 94 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index dfd14b223bff..c16ec8c1620d 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3133,6 +3133,98 @@ static const struct snd_soc_dapm_widget wcd938x_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("AUX"),
 	SND_SOC_DAPM_OUTPUT("HPHL"),
 	SND_SOC_DAPM_OUTPUT("HPHR"),
+
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
+
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
 };
 
 static int wcd938x_get_micb_vout_ctl_val(u32 micb_mv)
@@ -3300,6 +3392,8 @@ static const struct snd_soc_component_driver soc_codec_dev_wcd938x = {
 	.num_controls = ARRAY_SIZE(wcd938x_snd_controls),
 	.dapm_widgets = wcd938x_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(wcd938x_dapm_widgets),
+	.dapm_routes = wcd938x_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(wcd938x_audio_map),
 };
 
 static void wcd938x_dt_parse_micbias_info(struct device *dev, struct wcd938x_priv *wcd)
-- 
2.21.0

