Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFC3366A67
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 14:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239539AbhDUMGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 08:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239269AbhDUMGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 08:06:12 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1988CC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 05:05:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u21so63165160ejo.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 05:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ikxfjDLYuq4kmVi2M+ovf7fio+tFDbJkofoad8Wbu0g=;
        b=bZvUjjNLNycuXvipWLEzb+IRDabF3NqVkumB+urNNTl1cXvQ2tbDoeaNQ+PV5jhBNb
         GOvF3LjcGgB2+6qQxDUg0dNiPQE2ty6uqGkRF8xa0G4M9wpqV/H2yG5fCngolCGOo0WJ
         rd00FfT39Ifgw26+2uofxT58NA9nGLilcFP+CL0jDI5LmCEmi+bTsQ2cvZfkZlAe+3ZN
         hjJZLJtXl7mU0cH4gGwf43urBY68qMCCK///rYWYaqeOIJCUhD17TEunZVjX9MWDhdc5
         3CpvuPAMLadNQ87jHpKdxLDhWKilWpHc6QiKBEe9Lg4CEhPvwBic+zkAgU6aCm//X8RO
         gazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ikxfjDLYuq4kmVi2M+ovf7fio+tFDbJkofoad8Wbu0g=;
        b=RaJY3szB2rwib9Upd2ztBH0VUSfQLBQ0Jyj4QN5ZSurqGiPxC6D1UIel3tAbS9JeHg
         e36dZn3e9Ks3Gw4zJrbigVUhRwFRrxaM6YTHNmmi+pnXKzSNiuGDqu++HT8rh08By8O5
         i1cU+gK/JdLipYKqR5trLekhlnY6J/aKC5AwVgIlnL9HUQxPk+SvEsm/ZCshTQNEi4ki
         uRh3Ksfp/4PGD3dbWg9t9UMXttWDFXVSiM5Dj0aVZhQmaz54R0Hau05DE1KcnLNG8FA0
         Nms9X81WWkM9dtNao0a1UYfyQQ+4bMcVuXhVAwebmh4k3JDH2t8fOmB4/eZGlr1qHgDn
         wjYw==
X-Gm-Message-State: AOAM533SFEywgWEAEPk2OwpBr68S5f+q/Uf2I4YP9NAKXUxxYgpBtWsH
        Y3qhyKHqACwSCufcZzxgI+uldQ==
X-Google-Smtp-Source: ABdhPJy+yR5RdrEp9RuiwBCe5WB4EkVI5Wk0TTahYh4a4mJGaGvyiF6KNG2gJb5W7XsSeHzL/Eoyzw==
X-Received: by 2002:a17:907:d06:: with SMTP id gn6mr30014894ejc.449.1619006737773;
        Wed, 21 Apr 2021 05:05:37 -0700 (PDT)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id n2sm3151431edi.32.2021.04.21.05.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 05:05:37 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v2 1/5] ASoC: stm32: properly get clk from the provider
Date:   Wed, 21 Apr 2021 14:05:08 +0200
Message-Id: <20210421120512.413057-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421120512.413057-1-jbrunet@baylibre.com>
References: <20210421120512.413057-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using the clk embedded in the clk_hw (which is meant to go
away), a clock provider which need to interact with its own clock should
request clk reference through the clock provider API.

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
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
2.31.1

