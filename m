Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068503604BA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhDOIoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:44:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38423 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbhDOIol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:44:41 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWxbl-0000Ji-Ip
        for linux-kernel@vger.kernel.org; Thu, 15 Apr 2021 08:44:17 +0000
Received: by mail-ed1-f72.google.com with SMTP id r4-20020a0564022344b0290382ce72b7f9so4792666eda.19
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C3RZMclgxc1FxJU/OrPHbJLizxo8O9HUjZmngSIwkM0=;
        b=PBtDf6cnGAopbdTi84MGcVTqZsyRw6QUBloPUWTlaa5rhdmSeXz04kxT3nZQXfPxi7
         AFXCpSloxzxH3odY+MAgOr9pw1Zw0NqzvmLdgOZoIy//R1Oe2xiBFmRc8/a1/SxX7ka1
         W+QxbyOL48W4WBEXeKxoW56ZeYlcyHCVCQOATPQNZJY77w+5ZPxQTmGOdjgB03+BM9FM
         vECQ9KocS/mmYNJC+qnIzCnZm2HNOICyrdHdpS9XQaahqimXTjLBvTZZJ4JXTFnQcJTr
         v4gz/qzgZkObTuIOUJ2VVo5rHsGNzd/QXYOj8COMcNAHO0flpWj7d9E9sXyCAdpZYq81
         WZ9w==
X-Gm-Message-State: AOAM5318LQvb6Ep7NC421iuJQ4zr/WR2AkPrc7Wm714JBGUt/HepNqhL
        7q5AT9I8aRmApmHInPtCaNH8vxdRIU5m4A27jJont+S4ZTz6QJ4MxDIowLLVAc2bSmcLg7gpqOO
        gBf3kOZCltueGYfC2Z/2n+eDSoNfk5SbpFyZSlxRRzQ==
X-Received: by 2002:a17:906:d04d:: with SMTP id bo13mr2252562ejb.157.1618476257341;
        Thu, 15 Apr 2021 01:44:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwL1iqD0K8UraIVtQPabESHzQRRgghEweHqa35iG9WZz8DZdnZL+3UB1rriHafe5y+OdtromA==
X-Received: by 2002:a17:906:d04d:: with SMTP id bo13mr2252555ejb.157.1618476257184;
        Thu, 15 Apr 2021 01:44:17 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id k26sm1419360ejk.29.2021.04.15.01.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 01:44:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2 3/3] mmc: sdhci-s3c: constify uses of driver/match data
Date:   Thu, 15 Apr 2021 10:44:12 +0200
Message-Id: <20210415084412.51125-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415084412.51125-1-krzysztof.kozlowski@canonical.com>
References: <20210415084412.51125-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver data (struct sdhci_s3c_drv_data) stored in of_device_id
table is allocated as const and used only in const-way.  Skip
unnecessary const-away casts and convert all users to work with pointer
to const.  This is both more logical and safer.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. None
---
 drivers/mmc/host/sdhci-s3c.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index a07a8f011741..862f033d235d 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -462,21 +462,21 @@ static int sdhci_s3c_parse_dt(struct device *dev,
 }
 #endif
 
-static inline struct sdhci_s3c_drv_data *sdhci_s3c_get_driver_data(
+static inline const struct sdhci_s3c_drv_data *sdhci_s3c_get_driver_data(
 			struct platform_device *pdev)
 {
 #ifdef CONFIG_OF
 	if (pdev->dev.of_node)
-		return (struct sdhci_s3c_drv_data *)of_device_get_match_data(&pdev->dev);
+		return of_device_get_match_data(&pdev->dev);
 #endif
-	return (struct sdhci_s3c_drv_data *)
+	return (const struct sdhci_s3c_drv_data *)
 			platform_get_device_id(pdev)->driver_data;
 }
 
 static int sdhci_s3c_probe(struct platform_device *pdev)
 {
 	struct s3c_sdhci_platdata *pdata;
-	struct sdhci_s3c_drv_data *drv_data;
+	const struct sdhci_s3c_drv_data *drv_data;
 	struct device *dev = &pdev->dev;
 	struct sdhci_host *host;
 	struct sdhci_s3c *sc;
@@ -761,7 +761,7 @@ static const struct platform_device_id sdhci_s3c_driver_ids[] = {
 MODULE_DEVICE_TABLE(platform, sdhci_s3c_driver_ids);
 
 #ifdef CONFIG_OF
-static struct sdhci_s3c_drv_data exynos4_sdhci_drv_data = {
+static const struct sdhci_s3c_drv_data exynos4_sdhci_drv_data = {
 	.no_divider = true,
 };
 
-- 
2.25.1

