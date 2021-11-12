Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4813B44EB70
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbhKLQfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbhKLQfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:35:45 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4536C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:32:54 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d5so16536729wrc.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+QipG3moXrpkh2YURj9JhExl3AcdSIwqw5E1yOYJddA=;
        b=JyorvgXBmxmsNhnms+ripo7aB4EgWROWWCo5bRvkc2vYFxbb2a8lcg33YB9Wiq+ZEK
         MUyRDOmb+EUl3MMc6XH1vmzi2T5Csgw4z1Yj1bdgbc3Nh9iJTXUAMaNK6hqMa+CplPsi
         pnFsD+wT6bQGzyiB/YBU1INtBZuOiVJ2g6i30kSXsuWIfj1b4SNd8mb5OlPBExUi2pdh
         7/+MhkcIMt38KZQGhGSYeR3YwSWURpof8pOm3d2PbQtcl8bKvOIXOST69MgDmbc+Km1Y
         CDMyp02bUAEGW1nS4xoOXS5U+8yZu7W72QCo7gC62hlTGw5imn+v+sfnuj3FGfoHlIb8
         Q9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+QipG3moXrpkh2YURj9JhExl3AcdSIwqw5E1yOYJddA=;
        b=skNbz1eEqj8LdLmzFD7mlEHow1abXtCLVgBFcfyvSf6JotvsKLjIZVaDTQtu+/QDFe
         WkBXTS7+fZW6rpg7tVD4twXCVkUW4UASy4ujtVUi9cic91yHEzSrlWFNLPvcKW/IF1/z
         0rTOMm92C6wdNyqv9JCW33n4/VecGme6SE0fgoBzvegr9BjB9gvkuC9sqVDzSOWgx2JS
         mJKqEHYVfBV+OrkUOue6Nri63DFk3jwLwE+Gqw5OBdVM8oAjLo0yzwirv5panBUzHX6f
         RO5j/JiGX+K9kVG7/+8fKJnygAXH4oGAh5dKq08ZD1TqMTcGTMKIjIW4SpPbDNEpFaz1
         CB6g==
X-Gm-Message-State: AOAM533RQvlhtfRqkNl5bigG+PzpdlAvaQHwyKFVZcY415fpCAlD32MU
        etDhlttj42w/9QSJQVP3QK2cug==
X-Google-Smtp-Source: ABdhPJwYAIW2CGWwtrkZv6a8wia60Ojdm2EmkVQMST/tv2MCGtp0hNMsNM5xPzPDhgP95OsxghTNkQ==
X-Received: by 2002:a5d:5888:: with SMTP id n8mr20121587wrf.234.1636734773433;
        Fri, 12 Nov 2021 08:32:53 -0800 (PST)
Received: from amjad.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h15sm6253796wml.9.2021.11.12.08.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 08:32:53 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     balbi@kernel.org
Cc:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        p.zabel@pengutronix.de, khilman@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v3 2/3] usb: dwc3: meson-g12a: fix shared reset control use
Date:   Fri, 12 Nov 2021 17:28:26 +0100
Message-Id: <20211112162827.128319-3-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211112162827.128319-1-aouledameur@baylibre.com>
References: <20211112162827.128319-1-aouledameur@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


reset_control_(de)assert() calls are called on a shared reset line when
reset_control_reset has been used. This is not allowed by the reset
framework.

Use reset_control_rearm() call in suspend() and remove() as a way to state
that the resource is no longer used, hence the shared reset line
may be triggered again by other devices. Use reset_control_rearm() also in
case probe fails after reset() has been called.

reset_control_rearm() keeps use of triggered_count sane in the reset
framework, use of reset_control_reset() on shared reset line should be
balanced with reset_control_rearm().

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Reported-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index d0f9b7c296b0..bd814df3bf8b 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -755,16 +755,16 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 
 	ret = dwc3_meson_g12a_get_phys(priv);
 	if (ret)
-		goto err_disable_clks;
+		goto err_rearm;
 
 	ret = priv->drvdata->setup_regmaps(priv, base);
 	if (ret)
-		goto err_disable_clks;
+		goto err_rearm;
 
 	if (priv->vbus) {
 		ret = regulator_enable(priv->vbus);
 		if (ret)
-			goto err_disable_clks;
+			goto err_rearm;
 	}
 
 	/* Get dr_mode */
@@ -825,6 +825,9 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 	if (priv->vbus)
 		regulator_disable(priv->vbus);
 
+err_rearm:
+	reset_control_rearm(priv->reset);
+
 err_disable_clks:
 	clk_bulk_disable_unprepare(priv->drvdata->num_clks,
 				   priv->drvdata->clks);
@@ -852,6 +855,8 @@ static int dwc3_meson_g12a_remove(struct platform_device *pdev)
 	pm_runtime_put_noidle(dev);
 	pm_runtime_set_suspended(dev);
 
+	reset_control_rearm(priv->reset);
+
 	clk_bulk_disable_unprepare(priv->drvdata->num_clks,
 				   priv->drvdata->clks);
 
@@ -892,7 +897,7 @@ static int __maybe_unused dwc3_meson_g12a_suspend(struct device *dev)
 		phy_exit(priv->phys[i]);
 	}
 
-	reset_control_assert(priv->reset);
+	reset_control_rearm(priv->reset);
 
 	return 0;
 }
@@ -902,7 +907,9 @@ static int __maybe_unused dwc3_meson_g12a_resume(struct device *dev)
 	struct dwc3_meson_g12a *priv = dev_get_drvdata(dev);
 	int i, ret;
 
-	reset_control_deassert(priv->reset);
+	ret = reset_control_reset(priv->reset);
+	if (ret)
+		return ret;
 
 	ret = priv->drvdata->usb_init(priv);
 	if (ret)
-- 
2.25.1

