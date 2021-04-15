Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5253604B6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhDOIok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:44:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38408 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbhDOIoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:44:39 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWxbj-0000IE-EO
        for linux-kernel@vger.kernel.org; Thu, 15 Apr 2021 08:44:15 +0000
Received: by mail-ed1-f70.google.com with SMTP id m18-20020a0564025112b0290378d2a266ebso4788216edd.15
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=afLlSFHqkyfNq8XB8hE8fEk1Bn9ss6leqQ5Uo7hmj+I=;
        b=Hzxwxw7Jg8PrT5JU7yM406vEVcmrQQr4v1AtRDhWgHDx+aahNcWOfhWB4LXlEQf89U
         8cnx/Aze1GkPUTzuhCg8UqeZ+OkRPy0pxVSsTZuCHjLn6ifzjK5T6Dt9vvkjaTgVXcR0
         JTNHXYWqbr3YyA9F5tzOzEkhXzX7WhWa+KLufj7IodF/QDfnVAeCaiUvBMODUx/BVim5
         NQDqmj0y+e8LmSXcnZk0Jd/BVir4hPN+8zSQZXwldSenyVagFqsCkV2Ty6fEjibJfgOl
         58/5XOBllWNUsIhge9EUR3z9mwCh/t/GRBmUIIVu+sAOD7QHpC/nv18kx6xJ4eCVSbfH
         dAQw==
X-Gm-Message-State: AOAM533OUr9eqpcybN+gxFSMHWt861GfN3iWWpnpbGQUuD4BnSwVVc9W
        YiuVCMBHRaUEikvGbMsMVMC0Ci5AHnXqV5tD70QXZSaeE+KLjq4WvdCyMamHBqWjdbbgIm8S9va
        OaANsGCc9fI2pz+63QItTmwod7EEren1NUfhJHd8TOg==
X-Received: by 2002:aa7:c3c3:: with SMTP id l3mr2804633edr.103.1618476255199;
        Thu, 15 Apr 2021 01:44:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGubMcxKW1PgZ0pez1xZE9dMYv7WAOyLtVFD1VPxJHQJ5kuB+Lmt0mE0mM3CucaQxZfp6qtw==
X-Received: by 2002:aa7:c3c3:: with SMTP id l3mr2804626edr.103.1618476255116;
        Thu, 15 Apr 2021 01:44:15 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id k26sm1419360ejk.29.2021.04.15.01.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 01:44:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2 1/3] mmc: sdhci-s3c: simplify getting of_device_id match data
Date:   Thu, 15 Apr 2021 10:44:10 +0200
Message-Id: <20210415084412.51125-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_device_get_match_data() to make the code slightly smaller and to
remove the of_device_id table forward declaration.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. Rewrite the commit msg as it is not a NULL pointer dereference.
---
 drivers/mmc/host/sdhci-s3c.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index f48a788a9d3d..8e1dca625620 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -20,6 +20,7 @@
 #include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
@@ -461,19 +462,12 @@ static int sdhci_s3c_parse_dt(struct device *dev,
 }
 #endif
 
-#ifdef CONFIG_OF
-static const struct of_device_id sdhci_s3c_dt_match[];
-#endif
-
 static inline struct sdhci_s3c_drv_data *sdhci_s3c_get_driver_data(
 			struct platform_device *pdev)
 {
 #ifdef CONFIG_OF
-	if (pdev->dev.of_node) {
-		const struct of_device_id *match;
-		match = of_match_node(sdhci_s3c_dt_match, pdev->dev.of_node);
-		return (struct sdhci_s3c_drv_data *)match->data;
-	}
+	if (pdev->dev.of_node)
+		return (struct sdhci_s3c_drv_data *)of_device_get_match_data(&pdev->dev);
 #endif
 	return (struct sdhci_s3c_drv_data *)
 			platform_get_device_id(pdev)->driver_data;
-- 
2.25.1

