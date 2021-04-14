Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A730235F756
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 17:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349840AbhDNPNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:13:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41079 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbhDNPNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:13:13 -0400
Received: from mail-ej1-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWhCE-0002Hr-7p
        for linux-kernel@vger.kernel.org; Wed, 14 Apr 2021 15:12:50 +0000
Received: by mail-ej1-f70.google.com with SMTP id t23so534108ejx.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WryX6gSc+ItY/rCx8dz1xB9HPi4k+9GNIEb2q0R+7K4=;
        b=jSM7dw6pRSPuVHAogpT5AMJBjEVvRz6JS4v/7lxSji5eFPctThItK9OHrTKs+clWFQ
         hziU37ENakkHLEa5Gk/xSevkQYOvJsPuUfCoj9CWUkV0osOyGlATkU1WmX1QVEuzMs/7
         OpCRWZAftAvIK//buonxmFg2rCmUKSkp40LdYGV0t2N4icy3+NcilPDOqrdcA1+ikf9p
         k0wbmw/Qaln5E8CygrKeprZm2xAtNq9ri7nRNkxpoWL5K10sfFOv6nwRut/Qh7/vnYg3
         Ie8d3Ws4iZFqjP2eI3vD36X2b2IB382Ttrcptx6eGSK9vt6ejoHEjL6nZdEJ01a3dpRw
         VFEw==
X-Gm-Message-State: AOAM531YBAbsmOYtuNoY6dRzfdThZhxNwD2jHDXaHTDnEA5gdqvD3/Ab
        ZPAemHuyz4V6cOwIj/YZZZDnL0KfWM7uVAu3KZHdwW7w2Zn2hssatrQglPCK7fUx/c0KngGDriC
        SriKu5ZmHZGhOhjJQjWDTkUd3j1LcT2jSCTlNK54gzg==
X-Received: by 2002:a17:906:1d10:: with SMTP id n16mr2942883ejh.445.1618413169931;
        Wed, 14 Apr 2021 08:12:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVuLhdr/RdbFjzizZO7TcF3wf/gDWnzeZJthNfbAkiMwzS0ryDeIT3XxIzo5k8joG1VRS4vQ==
X-Received: by 2002:a17:906:1d10:: with SMTP id n16mr2942861ejh.445.1618413169763;
        Wed, 14 Apr 2021 08:12:49 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id o9sm6608022ejg.56.2021.04.14.08.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 08:12:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 1/3] mmc: sdhci-s3c: fix possible NULL pointer dereference when probed via platform
Date:   Wed, 14 Apr 2021 17:12:40 +0200
Message-Id: <20210414151242.102313-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be matched by legacy platform way or OF-device matching.
In the first case, of_match_node() can return NULL, which immediately
would be dereferenced to get the match data.

Addresses-Coverity: Dereference null return value
Fixes: cd1b00eb24b0 ("mmc: sdhci-s3c: Add device tree support")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---

Not tested on HW, but the code should be equivalent (plus safer).

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

