Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA6035ACD4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 13:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbhDJLOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 07:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234433AbhDJLOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 07:14:18 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A6CC061763
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 04:14:04 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id y204so2781768wmg.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 04:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uz/XMPMDwu/USy5yxTKfqvGGy1RjhUNSpCmU6fo9xwM=;
        b=cTxE100ExRKHnpQ1JKrCRUOQl5hvHud03dZ1qSIKDgRRCd9kMJ+Qqp6Nh3sjBmuZh1
         +ULWzAk2ZXw5RuS3EGilrJViITuxIr21e0PfKmdoDqGd2wm2AJCacOmOF8zF86A5fWXu
         XcjyS22+fvxmPtG1ouWIXKc/c2mfnMrvu0qp8DCtKQw6VvMiO5OOUM545q/+MYH4fBdg
         ugNenDSHk75mGuHoz2rsn+PEUTp/mrlVcgT0VZEsAU5q++kNXlHdOPnHTfB1cqd53ywL
         HitZFWTj8XMCNWCBpWPAVqMoqSATL9U82a6q8a8h6yQAgLSx/CxKCPcjCxeHs18M6hkW
         Eodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uz/XMPMDwu/USy5yxTKfqvGGy1RjhUNSpCmU6fo9xwM=;
        b=E1wzRplSDcOP6kYTZ4OMsheV1YVvjvvSBCgkmdte+0E7mjEAJ8WluGfARyj+pu5tKN
         MxcvEz4EnK+pQAwyw2wbj9wJgDwR8MI3mBHz7n89wsMne9kwqn/UkkzHcHgjtevZwi0y
         JgI6cxfa935JvrOtmLiZnOZwWY60aGhs2fWiHP5xDmb9w5Ami/5aivpA0iKBN7IehwKU
         HGf+JXxGUgu27Px/kQhlcOq11lCwWOkFFkCpigU+jLnsO4BdcKUs5Sm0cW0e/IYjCrnW
         a4gOBqt4kM0WarhLRezr6pmBJf5YqkQijxxmRN43KmYBiVJ9P43dgEcKAgJm3Hextn5U
         LtQA==
X-Gm-Message-State: AOAM532qxibuFXGBJx9UHzIqgeCO5irPvMGIJi0H9Cm2EqwO8271S+Lv
        6/FftyON3i7fk2qs83LubvwKIw==
X-Google-Smtp-Source: ABdhPJweBCqlynJKqrELKofDcADCJIyh3r50EE1Req4qnVkQmoilKGiFcjGHxPxV43o/n0PNcP0MEQ==
X-Received: by 2002:a7b:c34a:: with SMTP id l10mr17823837wmj.46.1618053243078;
        Sat, 10 Apr 2021 04:14:03 -0700 (PDT)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id s8sm8370117wrn.97.2021.04.10.04.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 04:14:02 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 1/5] ASoC: stm32: properly get clk from the provider
Date:   Sat, 10 Apr 2021 13:13:52 +0200
Message-Id: <20210410111356.467340-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210410111356.467340-1-jbrunet@baylibre.com>
References: <20210410111356.467340-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using the clk embedded in the clk_hw (which is meant to go
away), a clock provider which need to interact with its own clock should
request clk reference through the clock provider API.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/stm/stm32_sai_sub.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 3aa1cf262402..c1561237ee24 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -484,7 +484,10 @@ static int stm32_sai_add_mclk_provider(struct stm32_sai_sub_data *sai)
 		dev_err(dev, "mclk register returned %d\n", ret);
 		return ret;
 	}
-	sai->sai_mclk = hw->clk;
+
+	sai->sai_mclk = devm_clk_hw_get_clk(dev, hw, NULL);
+	if (IS_ERR(sai->sai_mclk))
+		return PTR_ERR(sai->sai_mclk);
 
 	/* register mclk provider */
 	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
-- 
2.30.2

