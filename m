Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2550459A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 03:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhKWCqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 21:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhKWCqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 21:46:48 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE296C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 18:43:40 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id x5so17976535pfr.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 18:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=SjomYuB3mIAoDTZTLD8mciVKT6P5jd4lu7zRg4g2c0U=;
        b=NcAryMbfNMlnzLFMptuGQjwoETrpRyp7wrlNtt0VE03uNXCKmk0JMS5ZHyec7L0D7g
         MGf9Wb9BYPqM/GTaqu3qixWcdHKQYK4l+iFcB0fDoSSmPq79pFaBwCyD3uqbbMX8KdJr
         BDTZn2mtXVCEHgBcs+KH2F/nWg4dNHvpCR5OEJBXdIcwd3Kug/Zi3ykoiAe5YwzPREBW
         cnefVTHzBqmITVq9TZ/RTWjdEOQwnCD/KBzHI0OPEP5HwLM291aPKMk8itdIc9zf0/Is
         4UB0nvHI/UNb5gsC67oox0p0JeQA/NRpoa1/2JKUzj0HnQpEWq53yrXAS3oi6J4nlUXq
         RAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SjomYuB3mIAoDTZTLD8mciVKT6P5jd4lu7zRg4g2c0U=;
        b=oFK5qT9LsSFB4N4+DyUBcyMnNmYAQMCT0RBwcsjQSHL/Q9uVIlRx37RcPoMVGqLHEi
         Tqyu2tsekslNnwrTNpgPqCYx0keuUxYnH6qPA7jTd74ifSxAGKfy3+Kcidnik0SeLqfU
         la0xEqDX+dbzsrZR3ah0psaKFNpqTi93+1LqhbPUZRod9jYBaZ8nVl/rGIhpkypkfQia
         f/orMP4BtHJzvNttEtGnaqP2eIP3vD+Sv+U8MtqqkSEEmbQJwCj6BLux7o5PoKBXODWC
         Slx2hc7OxtSN2dH9RZGogcnHEJSi/h4HiEGyNFPPF+xr+2gXouQyE5SVMf1E9pTRNTDq
         2A+Q==
X-Gm-Message-State: AOAM5326wlMN+CV4IU57s9SipSqqVh0rSxzXa1h4xlM3lTtL8H92eeSq
        lIlxuVIxgoPjaMtx4egjobFpUg==
X-Google-Smtp-Source: ABdhPJwtKTye1la96+6/qm4xdH8KimvoN04jghntv4ZyBBeShZImnpIt8kI3NV6oHCpQlTBw56aLCA==
X-Received: by 2002:aa7:9511:0:b0:49f:e35c:f6f1 with SMTP id b17-20020aa79511000000b0049fe35cf6f1mr1769722pfp.45.1637635420096;
        Mon, 22 Nov 2021 18:43:40 -0800 (PST)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id j15sm10387380pfh.35.2021.11.22.18.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 18:43:39 -0800 (PST)
From:   lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     alsa-devel@alsa-project.org, judyhsiao@google.com,
        derek.fang@realtek.com, albertchen@realtek.com,
        linux-kernel@vger.kernel.org,
        lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH] ASoC: qcom: Add support for ALC5682I-VS codec
Date:   Tue, 23 Nov 2021 10:43:29 +0800
Message-Id: <20211123024329.21998-1-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qcom machine driver adds rt5682s support in this patch.
Card name can be specified from dts by model property, and driver makes
use of the name to distinguish which headset codec is on the board.

Signed-off-by: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
---
 sound/soc/qcom/Kconfig  |  1 +
 sound/soc/qcom/sc7180.c | 24 +++++++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index b2173847dc47..cf3e151bb635 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -169,6 +169,7 @@ config SND_SOC_SC7180
 	select SND_SOC_LPASS_SC7180
 	select SND_SOC_MAX98357A
 	select SND_SOC_RT5682_I2C
+	select SND_SOC_RT5682S
 	select SND_SOC_ADAU7002
 	help
 	  To add support for audio on Qualcomm Technologies Inc.
diff --git a/sound/soc/qcom/sc7180.c b/sound/soc/qcom/sc7180.c
index 768566bb57a5..2fff764a00a7 100644
--- a/sound/soc/qcom/sc7180.c
+++ b/sound/soc/qcom/sc7180.c
@@ -17,6 +17,7 @@
 #include <uapi/linux/input-event-codes.h>
 
 #include "../codecs/rt5682.h"
+#include "../codecs/rt5682s.h"
 #include "common.h"
 #include "lpass.h"
 
@@ -128,7 +129,21 @@ static int sc7180_snd_startup(struct snd_pcm_substream *substream)
 	struct sc7180_snd_data *data = snd_soc_card_get_drvdata(card);
 	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
-	int ret;
+	int pll_id, pll_source, pll_in, pll_out, clk_id, ret;
+
+	if (!(strcmp(card->name, "sc7180-rt5682-max98357a-1mic"))) {
+		pll_source = RT5682_PLL1_S_MCLK;
+		pll_id = 0;
+		clk_id = RT5682_SCLK_S_PLL1;
+		pll_out = RT5682_PLL1_FREQ;
+		pll_in = DEFAULT_MCLK_RATE;
+	} else if (!(strcmp(card->name, "sc7180-rt5682s-max98357a-1mic"))) {
+		pll_source = RT5682S_PLL_S_MCLK;
+		pll_id = RT5682S_PLL2;
+		clk_id = RT5682S_SCLK_S_PLL2;
+		pll_out = RT5682_PLL1_FREQ;
+		pll_in = DEFAULT_MCLK_RATE;
+	}
 
 	switch (cpu_dai->id) {
 	case MI2S_PRIMARY:
@@ -145,16 +160,15 @@ static int sc7180_snd_startup(struct snd_pcm_substream *substream)
 				    SND_SOC_DAIFMT_I2S);
 
 		/* Configure PLL1 for codec */
-		ret = snd_soc_dai_set_pll(codec_dai, 0, RT5682_PLL1_S_MCLK,
-					  DEFAULT_MCLK_RATE, RT5682_PLL1_FREQ);
+		ret = snd_soc_dai_set_pll(codec_dai, pll_id, pll_source,
+					  pll_in, pll_out);
 		if (ret) {
 			dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
 			return ret;
 		}
 
 		/* Configure sysclk for codec */
-		ret = snd_soc_dai_set_sysclk(codec_dai, RT5682_SCLK_S_PLL1,
-					     RT5682_PLL1_FREQ,
+		ret = snd_soc_dai_set_sysclk(codec_dai, clk_id, pll_out,
 					     SND_SOC_CLOCK_IN);
 		if (ret)
 			dev_err(rtd->dev, "snd_soc_dai_set_sysclk err = %d\n",
-- 
2.17.1

