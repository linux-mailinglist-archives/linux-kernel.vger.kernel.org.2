Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C8336D73F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 14:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbhD1M1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 08:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhD1M12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 08:27:28 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C935EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 05:26:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n2so9673200wrm.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 05:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2s9J474JZEARtTyoYarg8YHk4rTHZwi14Y+KDirOQUE=;
        b=Vi2yGBQwLLvbUL/PZNfqnZWUQEW3eb7RyybrpCOByvM/YIEE2TP7jdEk9ko1KePQFR
         YyrdEbq58ghqLszXpKU+fYwHdOLGtF6OCedhP02ErXj9yK8kXGyNoLe/qD5ECmD9UAjh
         nrD85fsrfFfbNSgLBEocEDoYjeLirccPc4egnhMjXoNJcDTlHG4dkswd8mojF734iJ1v
         p0rs4ClW4Cro5OQpbHuRHercHRDTSLCr8QwSzClGK/64A8VonQ3nGwUk4ZtUG1Fkyvs+
         sjAXa8PrGInVtf3757M9CWvszPWEjgtsILgad0FJEpPm0WvZe43UR5W5ceCYdlUUiOtl
         jfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2s9J474JZEARtTyoYarg8YHk4rTHZwi14Y+KDirOQUE=;
        b=tKSOsVJCN0gqjLHjezeepDmWdi5ZKjCT/Smx3kHRGdTwIJ91voiJVZ9l0I3e7mgG6J
         7sAs8b1ZmIEJpgN3XqhlFo3+v+Q9kzkqaxC0rvFthrKCpB+JWTkmWUZma8K0Mb1yLJP4
         WmWW5BQPEEOW+dJvLOePhMMrN4R/oULIXSQAEJLF6cLwbDcU9oIflyn7CtgB4BYiz0qr
         hF69qScnykmfk6YkOFnKhniDkAEM34i1oY3vGFoejlak7//sskmb7akh3pDNqF3qGzoE
         4captmu7DKy0GasFPK4gScbhqTtVrrDJ8rwVqRrn096SEM+hertI5hxNlLGwuKe+u4np
         Ecmg==
X-Gm-Message-State: AOAM531Suv4scOE7ezJPSwEvOAqNiMtwac8boWV4EXP/Ap//Sh6dTAJz
        WPFjWXAG05+n6A0FmgR2AStqJQ==
X-Google-Smtp-Source: ABdhPJzsHvIsdh84+IkiXywToPZY4EDZs2ETaU+bB51962XC6NGy8KF0p7RFdurlu0tLNFYvg44EJQ==
X-Received: by 2002:a05:6000:1290:: with SMTP id f16mr2680463wrx.52.1619612802473;
        Wed, 28 Apr 2021 05:26:42 -0700 (PDT)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id 6sm7872021wmg.9.2021.04.28.05.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 05:26:42 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/2] ASoC: da7219: do not request a new clock consummer reference
Date:   Wed, 28 Apr 2021 14:26:32 +0200
Message-Id: <20210428122632.46244-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210428122632.46244-1-jbrunet@baylibre.com>
References: <20210428122632.46244-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 12f8127fe9e6154dd4197df97e44f3fd67583071.

There is problem with clk_hw_get_hw(). Using it pins the clock provider to
itself, making it impossible to remove the module.

Revert commit 12f8127fe9e6 ("ASoC: da7219: properly get clk from the
provider") until this gets sorted out.

Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/da7219.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index bd3c523a8617..13009d08b09a 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -2181,10 +2181,7 @@ static int da7219_register_dai_clks(struct snd_soc_component *component)
 				 ret);
 			goto err;
 		}
-
-		da7219->dai_clks[i] = devm_clk_hw_get_clk(dev, dai_clk_hw, NULL);
-		if (IS_ERR(da7219->dai_clks[i]))
-			return PTR_ERR(da7219->dai_clks[i]);
+		da7219->dai_clks[i] = dai_clk_hw->clk;
 
 		/* For DT setup onecell data, otherwise create lookup */
 		if (np) {
-- 
2.31.1

