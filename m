Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677AE35ACD7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 13:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbhDJLO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 07:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbhDJLOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 07:14:20 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F6CC061762
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 04:14:06 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id z24-20020a1cf4180000b029012463a9027fso4258586wma.5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 04:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TP8T7u/GZFTrtgKPlRTZREBN4itlWMrED3RXVnj2Hvk=;
        b=A3xrc6nvjZqOxDDtK7Wx3wmDtTLWfx71NNoOx2Eq7lEMJwyrIsFIVSq5FFPUIcibcp
         rkSQB+P1yoi1YGs+ip7cvj3aJ3M7f8k2hlVQOPTwGQsjEQLYe7b/nDCE03dmnjDBU7c3
         waSD8DKKGazkEEHzmZo9dX22J9wwfcSztUkq1n/+1OKe6lswa3gTn4325ZxgAwWE4j+4
         K0ovXowaDT5Qb3NCmmbghjL2prSKgJbRzwDGoFMkfD64WqZ/iMIVpvQ8pqe0hx3n0M3f
         9EaQHGHdiIMARyC3N/GUrt0NuuMpS9W836Bq34pUCMcVQQOvN86EJ8mGAEoVJvLLM9L9
         Xrlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TP8T7u/GZFTrtgKPlRTZREBN4itlWMrED3RXVnj2Hvk=;
        b=MG3tVt3WE06r2vUFNuy4AafzeQ+JBpIIY6PJ/ceOs+1eYiQ1+O8f6toRfNbD4veupw
         vh6zik7B28Tge/c3Ri5W/AxCFTKKaokOS8SCQz9v38Qk6cE9kwdJsiNQ6H/rCdfzldou
         y7zy/gebu0fgITMZFhfgvWGH+R3yAu7tNQSrdcQkHOcp2psYSKKTk+rPF4LQ6tAYRN+U
         sQll68Fbtmz14g+o28QXgEY+hP22tNUnf0hVbKDXCoNorAUkbD9KvMiGGKD4MVyuGRsb
         AwCQjq5O+X6zoDXc3H/xw8URV1g28+sHqLYU+dAsX3KddExZiYczXWYr3prlrNPRpVw9
         vakw==
X-Gm-Message-State: AOAM5329AvUScd8MKVExas69dVxGxsi+jn5qMXp26WAcqrZXhSj6nFP2
        xeAzrfDeCGpHzINKs+77O2dqsg==
X-Google-Smtp-Source: ABdhPJw9q7x+1VOwDxzk2hAmfo7HajBJAxPBRPLtfyVt6RgWc3TQJxduuAimU7XHHgvYNPMwoLvJMQ==
X-Received: by 2002:a1c:2704:: with SMTP id n4mr18029046wmn.143.1618053244789;
        Sat, 10 Apr 2021 04:14:04 -0700 (PDT)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id s8sm8370117wrn.97.2021.04.10.04.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 04:14:04 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4/5] ASoC: lpass: use the clock provider API
Date:   Sat, 10 Apr 2021 13:13:55 +0200
Message-Id: <20210410111356.467340-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210410111356.467340-1-jbrunet@baylibre.com>
References: <20210410111356.467340-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock providers should be registered using the clk_hw API.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/lpass-va-macro.c  | 2 +-
 sound/soc/codecs/lpass-wsa-macro.c | 9 +++------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index 5294c57b2cd4..56b887301172 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -1343,7 +1343,7 @@ static int va_macro_register_fsgen_output(struct va_macro *va)
 	if (ret)
 		return ret;
 
-	return of_clk_add_provider(np, of_clk_src_simple_get, va->hw.clk);
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, &va->hw);
 }
 
 static int va_macro_validate_dmic_sample_rate(u32 dmic_sample_rate,
diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index e79a70386b4b..acb95e83c788 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -2337,10 +2337,9 @@ static const struct clk_ops swclk_gate_ops = {
 	.recalc_rate = swclk_recalc_rate,
 };
 
-static struct clk *wsa_macro_register_mclk_output(struct wsa_macro *wsa)
+static int wsa_macro_register_mclk_output(struct wsa_macro *wsa)
 {
 	struct device *dev = wsa->dev;
-	struct device_node *np = dev->of_node;
 	const char *parent_clk_name;
 	const char *clk_name = "mclk";
 	struct clk_hw *hw;
@@ -2358,11 +2357,9 @@ static struct clk *wsa_macro_register_mclk_output(struct wsa_macro *wsa)
 	hw = &wsa->hw;
 	ret = clk_hw_register(wsa->dev, hw);
 	if (ret)
-		return ERR_PTR(ret);
-
-	of_clk_add_provider(np, of_clk_src_simple_get, hw->clk);
+		return ret;
 
-	return NULL;
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
 }
 
 static const struct snd_soc_component_driver wsa_macro_component_drv = {
-- 
2.30.2

