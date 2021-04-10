Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DD135ACD8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 13:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbhDJLO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 07:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbhDJLOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 07:14:21 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A470CC061763
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 04:14:06 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so6339974wma.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 04:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tP2B7PpyvjqGNjx+bX56P7sB4iUvry5KkFolRNleklk=;
        b=ER/6JODqNnCYiew9ExFspdf9CLFlaQHxcUelbQSKowEOT/MYWOoqxbB0YGIYtZoZaQ
         UfbcRcDxgBE0dgTQqk6kSDpbLBcLMeIHFpbHP1c1twrlpRTH9pGqPg6TyShwyFG9y5St
         5UMnqoWLEEnp4bTDAiyMKB0/CIWckeYyl1As265mnZObJKKifZTo+FIFuWgNBcvVMHUR
         csmvWilnUGpt/xXOunB0xaW/WkTUyzqzznacYnbFe2n7aY7evhwNw8Hf52WMo21Qhu65
         gvEFSpYfKAOXg7yOle1Di7FsnozxDZvCrYz1vlTLuPm0hCyH3F+8LiDXophjGLIFR+y7
         KUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tP2B7PpyvjqGNjx+bX56P7sB4iUvry5KkFolRNleklk=;
        b=Ji2N1PC8b7BZlO9S4KUv3W/aDi3LyuR2SB2+xutMTOw5KbaFbFbSM7q/BgwaF+aUT6
         F6g+UJfHbpAbAAvurdahwHMi4XsDGFaoWMDY4BZF6CoHh7fXY9cai9XYDeKqabcR90lU
         QntPPnWKa+x3dsqLngpZwS67+HFMUKbVjSPhS/vi7xyQp2QkrTaQB5EI1/O0hAPjE6eG
         Pz1umL98+9LPwdHnimtjijnE8gqHxFM+9VvpCSmxAqJZwTWByFapM8aWMF4TIkZdQ/mN
         3Caj/GDmI9OLYOD9jhZ90o1k8ZfUTPkn/LbSuQnelOpsvc1YZsbpijHrLCjH7sMcFXo2
         fFqg==
X-Gm-Message-State: AOAM531JDXZhn4Jt0Qk1H+b5ZGWFUbDaskoS5+nHeD2b202iRRRUC7N5
        a6j1yfR0b+7pvD+Ip8JRztqY4w==
X-Google-Smtp-Source: ABdhPJwTzTHbQN8i5k02Db+ienjllS5Z03I5zxFQECMU0GrCRJK2v7QfxBehPGg7/tC1L0hI/k3vTw==
X-Received: by 2002:a1c:a182:: with SMTP id k124mr6414729wme.132.1618053245421;
        Sat, 10 Apr 2021 04:14:05 -0700 (PDT)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id s8sm8370117wrn.97.2021.04.10.04.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 04:14:05 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 5/5] ASoC: da7219: properly get clk from the provider
Date:   Sat, 10 Apr 2021 13:13:56 +0200
Message-Id: <20210410111356.467340-6-jbrunet@baylibre.com>
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
 sound/soc/codecs/da7219.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 13009d08b09a..bd3c523a8617 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -2181,7 +2181,10 @@ static int da7219_register_dai_clks(struct snd_soc_component *component)
 				 ret);
 			goto err;
 		}
-		da7219->dai_clks[i] = dai_clk_hw->clk;
+
+		da7219->dai_clks[i] = devm_clk_hw_get_clk(dev, dai_clk_hw, NULL);
+		if (IS_ERR(da7219->dai_clks[i]))
+			return PTR_ERR(da7219->dai_clks[i]);
 
 		/* For DT setup onecell data, otherwise create lookup */
 		if (np) {
-- 
2.30.2

