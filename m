Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812BB366A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 14:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbhDUMGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 08:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239576AbhDUMGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 08:06:17 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A9EC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 05:05:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id mh2so41587090ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 05:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WBvDDO3AKgp6HTsSIcTOIT+KCHK50v2vbG7h5wPnh6A=;
        b=ZQiDoc4IpWNOVnVThvEFhumSPBLHtbewiHEKSIHIOSx5I8x7cZt/mJ6PjBZ4zA0WHH
         MKDdn7s1SFlQHMRAkYerAo60U+rde7gj2KqAYDNb9OtSKpFiqZysc4v6MfwAkWJxRuaq
         cjNKPpbR/eoyvxrPd9blBLTfJgoNiTPLh9i/NAo/4qljDRN3GFX/KXdHHnMAPap7KaGJ
         x1Pky1d0iB++nNFBuNsjs9Ny7Nr74NyL+gg3plySGVVtLAAJCjyXgmflkF9WHteXUTKv
         qpLHYdBIUFKN1lmM3/LgeoZGhnILl5TcaxkJybIf2GpZvSbuOlYIF1Td6GNaRgSSmYfK
         aVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WBvDDO3AKgp6HTsSIcTOIT+KCHK50v2vbG7h5wPnh6A=;
        b=FEU+U9Yk02YImkkizNRHxsGktylgb6vOKWmbiPaTxo/NRfRBERmqXgjx2O444WPfQE
         tDI0ucI16X8sIjxHGhy3B4a/CVRr5zhjrnKasLsGIqbrdkrUa3tbwGz/sI7uSvXXsqp7
         xbmSKGVuBEN+MFkexbn8H/tK+mH3orL4RKPsTuM1iXIK4GOcuZEl+lcTBEybw/9svrmR
         8TFrZa9Nxg69uNk9UX2hgI905F9AJV4CzbAvUW/wppqnm0WcQ/XgSqPuPU4cQyv9JFCC
         RDZyAhQ/NiCPBxiFCiq0yb1awuQKxshwWjEUwQPCW8Wu2qelirMIeWMrMcd5znZQNFRT
         s0XA==
X-Gm-Message-State: AOAM533BbvD3FQHB48qYXVq66YyLr5HEs83rpJkjJmlO1imQ6ODvJMFT
        rbqF5n2XwNG40RvozMYspU/jFQ==
X-Google-Smtp-Source: ABdhPJw7RBl39HDAf6162Lb+vNNYdFWkpn3xny4FcphRHCsNTHcKKiqoBS6LkEYz3O0d7GgbAK6fvw==
X-Received: by 2002:a17:906:2818:: with SMTP id r24mr32281084ejc.502.1619006739211;
        Wed, 21 Apr 2021 05:05:39 -0700 (PDT)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id n2sm3151431edi.32.2021.04.21.05.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 05:05:38 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v2 3/5] ASoC: rt5682: clock driver must use the clock provider API
Date:   Wed, 21 Apr 2021 14:05:10 +0200
Message-Id: <20210421120512.413057-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421120512.413057-1-jbrunet@baylibre.com>
References: <20210421120512.413057-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock drivers ops should not call the clk API but the clock provider
(clk_hw) instead.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/rt5682.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index a5aacfe01a0d..e4c91571abae 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2634,7 +2634,7 @@ static int rt5682_wclk_set_rate(struct clk_hw *hw, unsigned long rate,
 		container_of(hw, struct rt5682_priv,
 			     dai_clks_hw[RT5682_DAI_WCLK_IDX]);
 	struct snd_soc_component *component = rt5682->component;
-	struct clk *parent_clk;
+	struct clk_hw *parent_hw;
 	const char * const clk_name = clk_hw_get_name(hw);
 	int pre_div;
 	unsigned int clk_pll2_out;
@@ -2649,8 +2649,8 @@ static int rt5682_wclk_set_rate(struct clk_hw *hw, unsigned long rate,
 	 *
 	 * It will set the codec anyway by assuming mclk is 48MHz.
 	 */
-	parent_clk = clk_get_parent(hw->clk);
-	if (!parent_clk)
+	parent_hw = clk_hw_get_parent(hw);
+	if (!parent_hw)
 		dev_warn(component->dev,
 			"Parent mclk of wclk not acquired in driver. Please ensure mclk was provided as %d Hz.\n",
 			CLK_PLL2_FIN);
-- 
2.31.1

