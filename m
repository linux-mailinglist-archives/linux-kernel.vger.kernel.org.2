Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52A433A5B1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 16:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbhCNPq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 11:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbhCNPpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 11:45:34 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6572AC061762;
        Sun, 14 Mar 2021 08:45:34 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so18057004wmi.3;
        Sun, 14 Mar 2021 08:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JzwcPFMRL4SCj5tKsLwkCgmRXrfYV7RwVK3lOrEUoZY=;
        b=PqY8pspjct7c05jJSezcs85mAeuYf73dp7Szi5jnqSaTZRKSiZUNhYfMKdF5y1XvR4
         1youylwgU7aKIKRwIaJZyVOy7D7iOhp9YJHv8G7f1MsDhqkyhoNufh2qPNYtG9W1QV/x
         wTI6qZ8jUTyG0YGS+t2oedPd0Fw8jcBzeXi2uAzLZbFDYJsc5gROXXAv+6V0DRhTUfCc
         DE7Xz0bv9xUfThPlljFe7FMU9HUbO8DKBaDv+7Z2B21uRMPg2oD3HM2QRUVSeGRkyWts
         ibSxsGUX3q8o+4XtW/IikvjhDDEoOL0WHVYmTMoxIERpIs0ZPx5cRYKc6DACFm24dgs+
         KYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JzwcPFMRL4SCj5tKsLwkCgmRXrfYV7RwVK3lOrEUoZY=;
        b=SbJtXSJm9DLL3W+VJe07D+zcGJ7bT7R/t2CXZMao1aYxhkgZkDss9UxyPS6N68Up95
         xnQDDVwNMTmQhrMnToWg72HOinJ+Vz/Uu1zwHgXqgxWqUa9ucMFXXs2S4TROlZ9W8D7b
         IzYq5X6i89RCbicKRNbmNEJszw8QMD5ToG7KjnQeg23lfehZ+tHkZL+tZnHJVFF9YN0z
         1L9ufWgADZDd8iG0GqUJrHfwNEQ08LUXEv+UAr9SVAvVvqRYO8spimk+So43Hi2Jl1/h
         wPoGX5df3e+IitQR0uZTZtsNffuonMHTQICO5IhIi20x6pxQuH1ERTDWa72OUQTk49Za
         W0yg==
X-Gm-Message-State: AOAM5303CgKoUh0bbMRLEPwvT3aMs5J/e5Ad8ZM0BudBdaCbgaYvRKGw
        ed/Bxc2x+6RoFLuVk4k/bnI=
X-Google-Smtp-Source: ABdhPJxAdO+J40W47Rep4O6fTXvR5JrD5THBQUw12KxSOR5d5ay1lUZWilaKKcsQK0emtmamSDHRtg==
X-Received: by 2002:a05:600c:608:: with SMTP id o8mr22841970wmm.42.1615736733234;
        Sun, 14 Mar 2021 08:45:33 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id f14sm9673507wmf.7.2021.03.14.08.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 08:45:33 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Paul Fertser <fercerpav@gmail.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/17] ASoC: tegra30: i2s: Correct driver removal order
Date:   Sun, 14 Mar 2021 18:44:54 +0300
Message-Id: <20210314154459.15375-13-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314154459.15375-1-digetx@gmail.com>
References: <20210314154459.15375-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra30 I2S driver has a wrong driver removal order, which should be
opposite to the registration order, but it's not. In particular the
runtime PM is disabled in a wrong order. Fix the order.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/tegra/tegra30_i2s.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/tegra/tegra30_i2s.c b/sound/soc/tegra/tegra30_i2s.c
index 614b67be1dd9..31e08c5c1405 100644
--- a/sound/soc/tegra/tegra30_i2s.c
+++ b/sound/soc/tegra/tegra30_i2s.c
@@ -544,10 +544,6 @@ static int tegra30_i2s_platform_remove(struct platform_device *pdev)
 {
 	struct tegra30_i2s *i2s = dev_get_drvdata(&pdev->dev);
 
-	pm_runtime_disable(&pdev->dev);
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		tegra30_i2s_runtime_suspend(&pdev->dev);
-
 	tegra_pcm_platform_unregister(&pdev->dev);
 	snd_soc_unregister_component(&pdev->dev);
 
@@ -557,6 +553,10 @@ static int tegra30_i2s_platform_remove(struct platform_device *pdev)
 	tegra30_ahub_unset_rx_cif_source(i2s->playback_i2s_cif);
 	tegra30_ahub_free_tx_fifo(i2s->playback_fifo_cif);
 
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		tegra30_i2s_runtime_suspend(&pdev->dev);
+
 	clk_put(i2s->clk_i2s);
 
 	return 0;
-- 
2.30.2

