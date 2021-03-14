Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC6133A5BA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 16:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbhCNPrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 11:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbhCNPpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 11:45:40 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7836AC061574;
        Sun, 14 Mar 2021 08:45:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso18771215wmi.3;
        Sun, 14 Mar 2021 08:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q2VvKGS2IBfU/FyzkzlhapnFhEuPDgTyFY3A2pVCWuc=;
        b=i/b/ENnVfmEm7gJZEiJN2YTGqMz6qL70iprAM+NYUEEBXgzljDTTvb+IEgAQrdAlzw
         RRI/kUonxFW04TF69GppVa/5TpkFs5NyObtXDqlVb23mxcCNI0YRN647B/M6ANMtF6qd
         1mWai9P7B6/XNLswXwsbfAjNZ6lEfjwmZrZEcC/zUm7M6D7OBaN+CfuQjAu/+mHcMEiI
         vEMgGMQotDEac0bFpZEG/2i6miMI9hZz5mCgwZuC2y4cXXm+49oxYO2YEDOdrh8Yu2Ep
         tfOqLmAAI2Z06dhzpWb84yxjGXkJ0ug9HBDC22uUwwFXyoVh0PQ+h1OMZ4EEQZQvImhr
         b77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q2VvKGS2IBfU/FyzkzlhapnFhEuPDgTyFY3A2pVCWuc=;
        b=F+Yi4Mn4kaNmUX9hxbobjIv7ofA1B+lEdQAYu/jZyl2Apzt3fqLqpCI6rttnyUl8le
         SVDEexiNx2POdaedBg5bI5Xq0huouyYOTeZE0VeWocR2B5mhBwch5BAOMK9n9yb/A7Gq
         4i+qoJ6y4XzLCPwD94MgLszmhnUGPNI5G1Uwx2b4wLW5ah+Qu9jv+Z5mnlvcAdFot6/M
         nEnLNflSZCf2A9/JmVliv8M2avSN3SqSmuaOK6alq3mM1JYKQ9DNxdMfv7ut4P3/7lTa
         HbkEh5sr4mKYWISPmD10F1mm+zIyoF6p0/r0x2+1JOY6CPN9h/jE6rq4pqnyEjB5tQSQ
         r3yw==
X-Gm-Message-State: AOAM532R+gTD1P3okYuLwiq5TTck5CXta+MDNb8yMQElRzTqbHLjEzqK
        QhC5lGfIAp/X2WMaFxY+U+c=
X-Google-Smtp-Source: ABdhPJzPUOQiE4u6hODiaXeNZpPVy34v31wjC2p8noKP8thVkp98ivhkzcje9/QeTF2Dt9Lhmeo10Q==
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr22842264wmo.36.1615736738237;
        Sun, 14 Mar 2021 08:45:38 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id f14sm9673507wmf.7.2021.03.14.08.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 08:45:38 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Paul Fertser <fercerpav@gmail.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 17/17] ASoC: tegra30: ahub: Remove handing of disabled runtime PM
Date:   Sun, 14 Mar 2021 18:44:59 +0300
Message-Id: <20210314154459.15375-18-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314154459.15375-1-digetx@gmail.com>
References: <20210314154459.15375-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Runtime PM is always available on Tegra since commit 40b2bb1b132a
("ARM: tegra: enforce PM requirement"), hence there is no need to
handle the case of a disabled RPM by Tegra drivers. Remove handing
of a disabled runtime PM from Tegra30 AHUB driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/tegra/tegra30_ahub.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
index e64b41bc5fdf..d1718f3af3cd 100644
--- a/sound/soc/tegra/tegra30_ahub.c
+++ b/sound/soc/tegra/tegra30_ahub.c
@@ -584,18 +584,11 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
 	regcache_cache_only(ahub->regmap_ahub, true);
 
 	pm_runtime_enable(&pdev->dev);
-	if (!pm_runtime_enabled(&pdev->dev)) {
-		ret = tegra30_ahub_runtime_resume(&pdev->dev);
-		if (ret)
-			goto err_pm_disable;
-	}
 
 	of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
 
 	return 0;
 
-err_pm_disable:
-	pm_runtime_disable(&pdev->dev);
 err_unset_ahub:
 	ahub = NULL;
 
@@ -605,8 +598,6 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
 static int tegra30_ahub_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		tegra30_ahub_runtime_suspend(&pdev->dev);
 
 	ahub = NULL;
 
-- 
2.30.2

