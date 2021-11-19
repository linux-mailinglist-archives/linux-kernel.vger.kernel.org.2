Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1134571AC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 16:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbhKSPhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 10:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbhKSPhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 10:37:32 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5384CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 07:34:30 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 3E7A51F47564
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637336069; bh=glGcBOhnKZ0BIbBHiohniXke1QKqjnYDGYevH0VUGh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ILfz1eXr7vdpZP5d6eO3X/8p9GEPLZnO3SBSSolZJtd57CUrJFzUtCgLG7slX63ha
         6/d5Q48UzRABGeolToWZ5ZiHfqCKZISXoO3pGIr2yb52B0S0q+8b2FlRBd/Njrl2Cd
         FyqEaAx/ZvNeHr9n7JJorLCNaqUh1rl+oBV9dHNl9gXAz+OHLV93KBmnCzciereC9T
         bCsm3NLdC8erMAEPdxoQX+gKc1r8NJQR7AXHQcqy8kAlue8xFRnKyz3L2TwGwM+EFT
         hm1Zd8IiwiBNB+GjvTEUklfeIUfZ1i7oC0mLxz/STTM/FsIJRbhOokqMN3W17FgtNC
         yAOSdCCz6S8ow==
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     Xiubo.Lee@gmail.com, ariel.dalessandro@collabora.com,
        bkylerussell@gmail.com, broonie@kernel.org, festevam@gmail.com,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        michael@amarulasolutions.com, nicoleotsuka@gmail.com,
        perex@perex.cz, shengjiu.wang@gmail.com, tiwai@suse.com
Subject: [RFC patch 5/5] ASoC: fsl-asoc-card: Support fsl,imx-audio-tlv320aic31xx codec
Date:   Fri, 19 Nov 2021 12:32:48 -0300
Message-Id: <20211119153248.419802-6-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211119153248.419802-1-ariel.dalessandro@collabora.com>
References: <20211119153248.419802-1-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for fsl,imx-audio-tlv320aic31xx audio codec. This codec is
configured to use BCLK as clock input.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 6e6494f9f399..90cbed496f98 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -26,6 +26,7 @@
 #include "../codecs/wm8962.h"
 #include "../codecs/wm8960.h"
 #include "../codecs/wm8994.h"
+#include "../codecs/tlv320aic31xx.h"
 
 #define CS427x_SYSCLK_MCLK 0
 
@@ -629,6 +630,16 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	} else if (of_device_is_compatible(np, "fsl,imx-audio-tlv320aic32x4")) {
 		codec_dai_name = "tlv320aic32x4-hifi";
 		priv->dai_fmt |= SND_SOC_DAIFMT_CBP_CFP;
+	} else if (of_device_is_compatible(np, "fsl,imx-audio-tlv320aic31xx")) {
+		codec_dai_name = "tlv320dac31xx-hifi";
+		priv->dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
+		priv->dai_link[1].dpcm_capture = 0;
+		priv->dai_link[2].dpcm_capture = 0;
+		priv->cpu_priv.sysclk_dir[TX] = SND_SOC_CLOCK_OUT;
+		priv->cpu_priv.sysclk_dir[RX] = SND_SOC_CLOCK_OUT;
+		priv->codec_priv.mclk_id = AIC31XX_PLL_CLKIN_BCLK;
+		priv->card.dapm_routes = audio_map_tx;
+		priv->card.num_dapm_routes = ARRAY_SIZE(audio_map_tx);
 	} else if (of_device_is_compatible(np, "fsl,imx-audio-wm8962")) {
 		codec_dai_name = "wm8962";
 		priv->codec_priv.mclk_id = WM8962_SYSCLK_MCLK;
@@ -888,6 +899,7 @@ static const struct of_device_id fsl_asoc_card_dt_ids[] = {
 	{ .compatible = "fsl,imx-audio-cs42888", },
 	{ .compatible = "fsl,imx-audio-cs427x", },
 	{ .compatible = "fsl,imx-audio-tlv320aic32x4", },
+	{ .compatible = "fsl,imx-audio-tlv320aic31xx", },
 	{ .compatible = "fsl,imx-audio-sgtl5000", },
 	{ .compatible = "fsl,imx-audio-wm8962", },
 	{ .compatible = "fsl,imx-audio-wm8960", },
-- 
2.30.2

