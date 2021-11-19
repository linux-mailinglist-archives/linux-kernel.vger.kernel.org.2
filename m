Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7FF4571AB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 16:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbhKSPh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 10:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbhKSPh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 10:37:27 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B15C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 07:34:25 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id ACE3C1F4755E
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637336064; bh=oRI81qODQfEJ663yl3lbyzEbdUf5G6FtXTTtsMOhnZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BHgQA+ZeKvvoPLbEsSijKakWD/VMNBAwlsrox6vI3l5W9wzdBgdfCoW7MLj4CKrkc
         DNoeAwiwZ+qkwSwXCY3WMFdEtkKvwgWdh1ymyotJgcXcYR73RUu38k0bEDxl+mPwEu
         KRjVHnW303E/9BbBrQ+Rwx4T9L+Ah586iRL1swBEORPOchISBD0OfydF2I6i6B6wNF
         5qEZNTev8iBLnMRbswL4DC6i3C9kTbdqAxGt5uubKauxlGfkUuIIfzA5/WWf0zOVdp
         DEfK++6HHIFjt02E30ajh85ugmKVEExjgGTk/4gEP9uCt3NpQfFhjrxaPt6OMC3rH5
         vS5xE1/IOlmnA==
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     Xiubo.Lee@gmail.com, ariel.dalessandro@collabora.com,
        bkylerussell@gmail.com, broonie@kernel.org, festevam@gmail.com,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        michael@amarulasolutions.com, nicoleotsuka@gmail.com,
        perex@perex.cz, shengjiu.wang@gmail.com, tiwai@suse.com
Subject: [RFC patch 4/5] ASoC: tlv320aic31xx: Handle BCLK set as PLL input configuration
Date:   Fri, 19 Nov 2021 12:32:47 -0300
Message-Id: <20211119153248.419802-5-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211119153248.419802-1-ariel.dalessandro@collabora.com>
References: <20211119153248.419802-1-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If BCLK is used as PLL input, the sysclk is determined by the hw
params. So it must be updated here to match the input frequency, based
on sample rate, format and channels.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index e8307f0737f2..4224b4b3cae6 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
@@ -169,6 +170,7 @@ struct aic31xx_priv {
 	struct regulator_bulk_data supplies[AIC31XX_NUM_SUPPLIES];
 	struct aic31xx_disable_nb disable_nb[AIC31XX_NUM_SUPPLIES];
 	struct snd_soc_jack *jack;
+	u32 sysclk_id;
 	unsigned int sysclk;
 	u8 p_div;
 	int rate_div_line;
@@ -962,6 +964,7 @@ static int aic31xx_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_component *component = dai->component;
+	struct aic31xx_priv *aic31xx = snd_soc_component_get_drvdata(component);
 	u8 data = 0;
 
 	dev_dbg(component->dev, "## %s: width %d rate %d\n",
@@ -993,6 +996,16 @@ static int aic31xx_hw_params(struct snd_pcm_substream *substream,
 			    AIC31XX_IFACE1_DATALEN_MASK,
 			    data);
 
+	/*
+	 * If BCLK is used as PLL input, the sysclk is determined by the hw
+	 * params. So it must be updated here to match the input frequency.
+	 */
+	if (aic31xx->sysclk_id == AIC31XX_PLL_CLKIN_BCLK) {
+		aic31xx->sysclk = params_rate(params) * params_width(params) *
+				  params_channels(params);
+		aic31xx->p_div = 1;
+	}
+
 	return aic31xx_setup_pll(component, params);
 }
 
@@ -1177,6 +1190,7 @@ static int aic31xx_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	snd_soc_component_update_bits(component, AIC31XX_CLKMUX, AIC31XX_PLL_CLKIN_MASK,
 			    clk_id << AIC31XX_PLL_CLKIN_SHIFT);
 
+	aic31xx->sysclk_id = clk_id;
 	aic31xx->sysclk = freq;
 
 	return 0;
-- 
2.30.2

