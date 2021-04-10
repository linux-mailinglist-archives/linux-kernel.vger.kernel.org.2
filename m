Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C54035ACD6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 13:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbhDJLOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 07:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbhDJLOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 07:14:20 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F2AC061763
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 04:14:05 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso4283710wmi.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 04:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QNN+T8BLDOEY3hY3Q8J1z1U466PRLMSEBuyc1PHvJfo=;
        b=v9U97RoSwZSup94uN9Uxxm1PqJKrOJHw3i4+6XE11F7YO0YlBQFFBKNGBgsFykzzO+
         SyJybwBPDP3LoWKZbqGTtLsZCmDWDjxCu9p50M6UcKPO5dJIR+z2jXzZwWW+lUZdPibF
         RPfdXU+rrfv5v6P5U9WSyt/bc8mwJ4eL13BvakKp6hNqd7OJ1yvJYeIxWmp2dZ11zMO9
         cvJcLF90mrSx4cVlx5xiEPQUKiEe7l7Orc2kJNhK41wGd1QFHW2wNuwkRy+AqwYUJcTB
         9dI5scsAd47NO5N+I48qS/uNxv2InLZFW+7wXZsW3RKCCXFyIHlzdiry+/tuSAjsC9mp
         +yMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNN+T8BLDOEY3hY3Q8J1z1U466PRLMSEBuyc1PHvJfo=;
        b=Iu/U2SGipskRnfh06gsRcl9fekiUmaWBFw/COsxXWDbibxG7GjuBfyM8X2Y0fngYMk
         9nNaAZjVky0ccW+L6NUTNj75Bq9dRr72lJMIf+voyEKbladRTprc++gjd6dUi4LzwS7R
         bD1bzk9jm/WnhD1ayIYxxTTYSRYly524/8ZaRkZG3q70eV0jRPbQ//RxsKi0G+94BhE2
         hfyoBulJV+ilamRE2nIx4PxmIOTZpe6gm+L/eMnSB4RNs7Zt6WuHV4og+DjEOCS9rhGk
         uaoYgLP7pDN3zJkD0QccSH6dBfEvfqa6XeCnIqfoxt2Gyunlk0D4GzZ2pwweqdUPlzOY
         xmqg==
X-Gm-Message-State: AOAM531jIFHBPeRsgEQ7Fzae0br8gLLjGs44CsMoJH1r6ebd4WZOt1Qy
        Gb2yeNjUVuJOZactFfigUb27fA==
X-Google-Smtp-Source: ABdhPJzPWFJbT8j9mVKSkGi4AalpAZcoxl73akrvuCpEf0o1LSZf+CIY4lYmIhXbZ6f56s90pj0Djg==
X-Received: by 2002:a05:600c:ad3:: with SMTP id c19mr17827365wmr.125.1618053244161;
        Sat, 10 Apr 2021 04:14:04 -0700 (PDT)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id s8sm8370117wrn.97.2021.04.10.04.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 04:14:03 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 3/5] ASoC: rt5682: clock driver must use the clock provider API
Date:   Sat, 10 Apr 2021 13:13:54 +0200
Message-Id: <20210410111356.467340-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210410111356.467340-1-jbrunet@baylibre.com>
References: <20210410111356.467340-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock drivers ops should not the clk API but the clock provider (clk_hw)
instead.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/rt5682.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 0e2a10ed11da..2eee02ac8d49 100644
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
2.30.2

