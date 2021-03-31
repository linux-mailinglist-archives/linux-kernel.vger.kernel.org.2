Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168DF350540
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 19:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhCaRM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 13:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbhCaRMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 13:12:42 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBFFC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 10:12:41 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id hq27so31157503ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 10:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BgKO/uJM9usGKkAZQ7112LlmNK3ckgd64ltcjRPeQnY=;
        b=R5iOnGAF3Hhu7q7PWajbjt6p2aPktRJxfzeZR8mN8sUN3IX+i4ISSH83wUhxOgWItT
         tRSW6IaY9BkXqKzS1d9zNgKhBfeP/U2GCAPdvCVy0fSyfZIhTuIEoDzhyvYzSyEu4UyA
         RJzjRPwfS2sX2PDEbqRdPxPGVgzV/5teKBHPquv+xXSjgAOGNAyVUOcYmMWWAbeS8S+r
         p7tdVmjRS8StMfJ5+bsMHAUXTRGt731TkhfnyqCDnwYxH5na7V94tvbNb2A0hS3/eyqT
         z7GhCK+LfuZA/zwkcNyt6RBivMQgdyqYinsOnPi/Nm0kWDhrCV2nSWvEvRU4NrrLuZ0W
         OIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BgKO/uJM9usGKkAZQ7112LlmNK3ckgd64ltcjRPeQnY=;
        b=UQo/PLJBhzs8pxllHND35nyCskckRLU7gnz/tJ5YFvBR0KHTp+E1GNwPO7/hg9jkWd
         mmHxlNy0N8JtPQgZtg+Oh8wAz24ptude0g6DN2bNluRfimETyTd1Lqo/D8MjLrM5f5hU
         1LHIQC6UTQyrNzF9ny/U/sIwmX0dF8VE8ISGv5KzcLAwBw/Fnd0JIyVEneQinuqgh0nb
         PvYBYk69ZMlXuOW6gmdh8OLFZ7e9EeRHonYFgnWXIzMJ/DjBigtpg/LupaVsaAH3rxZH
         juX7O4rdO3WdZK49YAyL4X4zmItAWVNaQFYsfHaJIQ0+ovCul3TN9inrtCeEZFmzOZ7V
         Jc2g==
X-Gm-Message-State: AOAM531dE9HTm7Vnne6KwXs8a5BrOi/6GkXLXYaQ7I37sXIHCW0YdUoU
        FSlDti7jBXrzyjEByOduBQggrQ==
X-Google-Smtp-Source: ABdhPJx56htzifkuQ1Xzf58GGKV86MVxp0YeQrwdPt9wgfAwheAnRrJGJPLp4C2XW1y6mrtBpV2aXA==
X-Received: by 2002:a17:906:6d8e:: with SMTP id h14mr4666240ejt.410.1617210760507;
        Wed, 31 Mar 2021 10:12:40 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id h24sm1554131ejl.9.2021.03.31.10.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 10:12:39 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] ASoC: codecs: lpass-tx-macro: set npl clock rate correctly
Date:   Wed, 31 Mar 2021 18:12:34 +0100
Message-Id: <20210331171235.24824-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NPL clock rate is twice the MCLK rate, so set this correctly to
avoid soundwire timeouts.

Fixes: c39667ddcfc5 ("ASoC: codecs: lpass-tx-macro: add support for lpass tx macro")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-tx-macro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 36d7a6442cdb..e8c6c738bbaa 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -1811,7 +1811,7 @@ static int tx_macro_probe(struct platform_device *pdev)
 
 	/* set MCLK and NPL rates */
 	clk_set_rate(tx->clks[2].clk, MCLK_FREQ);
-	clk_set_rate(tx->clks[3].clk, MCLK_FREQ);
+	clk_set_rate(tx->clks[3].clk, 2 * MCLK_FREQ);
 
 	ret = clk_bulk_prepare_enable(TX_NUM_CLKS_MAX, tx->clks);
 	if (ret)
-- 
2.21.0

