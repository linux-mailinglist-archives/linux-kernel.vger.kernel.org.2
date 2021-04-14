Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB9435F759
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 17:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350190AbhDNPNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:13:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41106 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350114AbhDNPNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:13:16 -0400
Received: from mail-ej1-f69.google.com ([209.85.218.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWhCH-0002JA-9J
        for linux-kernel@vger.kernel.org; Wed, 14 Apr 2021 15:12:53 +0000
Received: by mail-ej1-f69.google.com with SMTP id d25so530723ejb.14
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XDuMOWplwoS/Ozw/sH4P7rpo1GEqNZMR1YEeGhTk/BM=;
        b=qeLbryM6k5TlVd6obz44ZlhxGdf6dZ3dn97bCg+vB3Ru28iPGbvtT2eh4F9yPNUPnJ
         DEhVR/2LfJrgpylQC32AqxzAO6wu4GXttAYKDYU2+dn7EgK6tVW8gCymunCtjos4lUt0
         bigeCWjnd2lqIw5DKyfX15WbK7YDSL0rf+c+X3mh+UwelSFaIr4cKc3j4dg+wBoCAsYj
         l6bphedn3A7vyctjKhDhCJBtG5naIuZU/39kOvgNmeaeU7E1H7VBKD5rKA7bADtgPKjK
         nki4aAXj411bexxh02nHwpF/CsmYaGpY7FatGYypTPmFcYL4sknewNYNkmnmuGRjPQ4G
         hM4Q==
X-Gm-Message-State: AOAM533QSIFaIQ8ek3ekXgyZEJGlSO72EOaJwLKAqy6N7IbPz2kb9Dtd
        q+2KDUzdvPfrNw+z8mbOqe7+DCkTYjVjDPVY4zBeKCG9asNbkCD7pWkp8DObb5u9CHggBUub8Rd
        D637mgkRLYiMtFzgYCIBvilRg4iMbpD+SHwaZ/EgG2w==
X-Received: by 2002:a17:906:b0f:: with SMTP id u15mr22151188ejg.156.1618413172820;
        Wed, 14 Apr 2021 08:12:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcwRUCAvHwOFEwoZEaELq0FzNrvJVSd2kUe34n6hhiPAf4c412FBslXbQ9BgEDdv2es3V8xQ==
X-Received: by 2002:a17:906:b0f:: with SMTP id u15mr22151171ejg.156.1618413172696;
        Wed, 14 Apr 2021 08:12:52 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id o9sm6608022ejg.56.2021.04.14.08.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 08:12:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 3/3] mmc: sdhci-s3c: constify uses of driver/match data
Date:   Wed, 14 Apr 2021 17:12:42 +0200
Message-Id: <20210414151242.102313-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414151242.102313-1-krzysztof.kozlowski@canonical.com>
References: <20210414151242.102313-1-krzysztof.kozlowski@canonical.com>
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

