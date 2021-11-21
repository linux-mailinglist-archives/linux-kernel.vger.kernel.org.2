Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCAC45851D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 17:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbhKURAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 12:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238589AbhKURAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 12:00:14 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A9BC06175E
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 08:57:08 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b1so68824140lfs.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 08:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RPGplxAlfsrMBxxxDVYASCZ5qk+rBBPVdgk9dKyv7PY=;
        b=ZwaDmlxM+vsKBx4be18GALv9SlqQEa4WlsiEnLvCS6eUQ1A/6zRtnwE8pk3E1suc8V
         mTvA5NsIoMLiSrKax93WOv9CeKzERYdfAj+Ncx6bSWuUXlqlz9RYDpi+MDDKtnhZNuhQ
         CuhruSFgnAx7Wj6SUIIselYSCKzTJIsgSS9awsfIq0vOQmkiQJvJAXVUNFl2AQ61rdad
         32IzEsphPgJ7jacWp7ZBR9TxTP9d9gY/ZiJKcSf6Ih3D0MJCB0Aw6VAWEHqHoBDAuh+G
         ansvdDT3sBNHKPWtCezcQJeQ8oM/k/5hPwtgNlzBQaBuIfDYsIfYC8lGhenosgK432jp
         9R5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RPGplxAlfsrMBxxxDVYASCZ5qk+rBBPVdgk9dKyv7PY=;
        b=mc2CfRshCEKTfkenfM0N+xMhckqkJ9Gq/klFTVn+HcocfH9oomlRZyIfy39jJ73Cr5
         H18/G3VjxH5dIkygpvxhMM1+fQQ27+G+8hGAa6nZ1xP6wOg5vk7u64UeOVIws1BZcoOR
         E0VFW1dfmPWZltIwo+6PsL4nbgKvurxomtLZf05fFvvBR2wbbmKoktlqnQI+Vee1SFK0
         UowxRwJG6Q5NxeUQ1XWgI/grK1t70vLRDGS+HoG2CTyerl2mcKtOFnbWSy0IgwPgbaa/
         VwYrPfT2R8K170wJiUz9LLdsPnRo2U9EZ7af6vw1/0A++KUWBx4gc+OhvuSBcVci+buE
         3cNA==
X-Gm-Message-State: AOAM532PCuX11a7X1Yrz8aJZ9gbISJgB16pn6V/k6qhmEiU4yKweN+8p
        WmG5BXC3cjRnJLksMDqrtmzCDQ==
X-Google-Smtp-Source: ABdhPJxLcJ0O5DqGvj1B0gp/SOrBT3PVURj4zFBVz/KeOuqlXE8/giRhkzkR5y0zNmpN8Nc5CnDEtw==
X-Received: by 2002:a05:6512:b0d:: with SMTP id w13mr7935629lfu.266.1637513827263;
        Sun, 21 Nov 2021 08:57:07 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id b6sm594400ljr.103.2021.11.21.08.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 08:57:06 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v4 11/12] watchdog: s3c2410: Remove superfluous err label
Date:   Sun, 21 Nov 2021 18:56:46 +0200
Message-Id: <20211121165647.26706-12-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211121165647.26706-1-semen.protsenko@linaro.org>
References: <20211121165647.26706-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'err' label in probe function is not really need, it just returns.
Remove it and replace all 'goto' statements with actual returns in
place.

No functional change here, just a cleanup patch.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Changes in v4:
  - Added R-b tag by Guenter Roeck

Changes in v3:
  - Added R-b tag by Krzysztof Kozlowski

Changes in v2:
  - (none): it's a new patch

 drivers/watchdog/s3c2410_wdt.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index f31bc765a8a5..96aa5d9c6ed4 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -627,22 +627,18 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	wdt_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (wdt_irq == NULL) {
 		dev_err(dev, "no irq resource specified\n");
-		ret = -ENOENT;
-		goto err;
+		return -ENOENT;
 	}
 
 	/* get the memory region for the watchdog timer */
 	wdt->reg_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(wdt->reg_base)) {
-		ret = PTR_ERR(wdt->reg_base);
-		goto err;
-	}
+	if (IS_ERR(wdt->reg_base))
+		return PTR_ERR(wdt->reg_base);
 
 	wdt->bus_clk = devm_clk_get(dev, "watchdog");
 	if (IS_ERR(wdt->bus_clk)) {
 		dev_err(dev, "failed to find bus clock\n");
-		ret = PTR_ERR(wdt->bus_clk);
-		goto err;
+		return PTR_ERR(wdt->bus_clk);
 	}
 
 	ret = clk_prepare_enable(wdt->bus_clk);
@@ -757,7 +753,6 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
  err_bus_clk:
 	clk_disable_unprepare(wdt->bus_clk);
 
- err:
 	return ret;
 }
 
-- 
2.30.2

