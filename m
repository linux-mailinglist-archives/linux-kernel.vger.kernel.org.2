Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51433893B8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355352AbhESQ2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355321AbhESQ1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:27:15 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAFBC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:25:54 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h4so14632343wrt.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h9ACoFyscr2mGx2hv7BWBvdkBNtd8ng9Fu2si46cdq4=;
        b=byisdwD/i5u3WtSKYw+sYWGk0u8xFD4aI4NdDxMw+ffgIcjDqEhv7ahv61jA6USQgk
         jm9vALBRIHhaWHsrnl4alI9tjghWi/KDqej7GJsI+Kh4+CiH0JVQT0LCLcEZJlSVxSxX
         jj3JoW++94xEI/00y2L7l5sdQNlHQsyE9iBR37drGXa3B+/DmIvmUTXJqrKzGH3GoeOw
         XAMQ1MECR83nnQKSRbgV7bTxboQM9oo/dUiqmRqnU1zBiQl1kBpBniegFK6NnaUyMYJs
         dGv3epgWNZMUAMRxznt6TtyULLsjNPeZZZZRIBCFCcBlAEE6+cO/T9jXmsp2Z9ceZfa7
         EZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h9ACoFyscr2mGx2hv7BWBvdkBNtd8ng9Fu2si46cdq4=;
        b=e2wPAxl/vs/hLM3t9uHQ5YKOhhhmFZ0zkdcFmNET2sdpyfW1P4ehaWAyPerw5uBPKK
         ExsoJNAyLpHoHgVc6jgZQMazxKgK0NRWHGYJR0idcCO0lYzAXDTL9Ns8dntXJ68grUL/
         ri/jdxYf5hkvPJ6spViM0wyQsYQ7Oic7k2semmFYOw6pYIGAKUrNbSQflb1FivqTrl5x
         euXMOd2mrJgqW1ECclvFwcd0MHvk3Ak5CO31KaszEGrj8vyKMbczO4q9Gk9zFXndLKT/
         4ZyuSGGAvlJCPJVvKSQ0R7663ZbAnuo1mKFyIUDMR8kaowBr6pzDaG1avl2H06fyVx8b
         mJIA==
X-Gm-Message-State: AOAM531xZBxAMiCBftBWo/6hOhhXjZGqU4hv8JFqfu5oFJCYanvUmDhd
        N07WqLsDP2TTbecam5Iz+fYJtg==
X-Google-Smtp-Source: ABdhPJwr3K6AGuoWpHTQgaEA3SUgfH1bxgCXJJ3IVhKq00yPr1NJM+0gcq90Ro1URVdiivdA8wZX8A==
X-Received: by 2002:adf:e411:: with SMTP id g17mr15445759wrm.402.1621441553089;
        Wed, 19 May 2021 09:25:53 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id k205sm5827724wmf.13.2021.05.19.09.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 09:25:52 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     mkorpershoek@baylibre.com, Fabien Parent <fparent@baylibre.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] cpufreq: mediatek: add support for mt8365
Date:   Wed, 19 May 2021 18:25:50 +0200
Message-Id: <20210519162550.3757832-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible stirng for MediaTek MT8365 SoC. Add also the
compatible in the blacklist of the cpufreq-dt-platdev driver.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 drivers/cpufreq/mediatek-cpufreq.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 5e07065ec22f..d6fd821e3f5a 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -126,6 +126,7 @@ static const struct of_device_id blacklist[] __initconst = {
 	{ .compatible = "mediatek,mt8173", },
 	{ .compatible = "mediatek,mt8176", },
 	{ .compatible = "mediatek,mt8183", },
+	{ .compatible = "mediatek,mt8365", },
 	{ .compatible = "mediatek,mt8516", },
 
 	{ .compatible = "nvidia,tegra20", },
diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index f2e491b25b07..87019d5a9547 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -537,6 +537,7 @@ static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
 	{ .compatible = "mediatek,mt8173", },
 	{ .compatible = "mediatek,mt8176", },
 	{ .compatible = "mediatek,mt8183", },
+	{ .compatible = "mediatek,mt8365", },
 	{ .compatible = "mediatek,mt8516", },
 
 	{ }
-- 
2.31.1

