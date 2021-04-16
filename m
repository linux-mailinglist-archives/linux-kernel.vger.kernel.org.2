Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9B3361FB0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243405AbhDPMXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:23:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36165 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240486AbhDPMXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:23:40 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lXNVD-0006mK-7V
        for linux-kernel@vger.kernel.org; Fri, 16 Apr 2021 12:23:15 +0000
Received: by mail-ed1-f71.google.com with SMTP id d2-20020aa7d6820000b0290384ee872881so2849815edr.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 05:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zyiHnszFk290pFE9xQFpSwJqvg0B5IFpzGvGacwtYN4=;
        b=fEQV8SkDnVmwbgxuozIDzsU8ejD3UnSRR8Ue5kc9MJUnYvnFGrTqCPn9uzQkh1U2Rw
         Ycu31GaIBVAdAQHChwXvB2fK/m6ip+OmycoFDk0FxYFRiq16FAEVEq2WLE7djAkPGQeG
         KrqkBrtjNQ5serFObT34OD1/6xdy2KU6a4VOALifjHSMBLU+0SJsFEr7p2bSn20dDmT5
         xheyshZj2MaU6Shws4t2E84bbvCMHNdxWEqK2fPaqUdba2SanYe81vEjmFdL8OGhprsH
         F76XDAikIdxe2aP7aCVm94GISVsA+85EmxYa1B0BhBc/VHiLmvVVXzKE1DQgjB0QCcb5
         7vig==
X-Gm-Message-State: AOAM531t8VAFgdQaRtcb6EMiEH5Gv8QjMjEc7U/rzRwjhgDVETyZ5nJG
        JPRuCMMhX63qil+RhoHeb0AC/UvjA9ug/M/2ad9nMJ+ZaNYDNbHuQmIP3Pp0bf0qSPMWdy8+3rs
        5wyfM/lQiYYqSSDvAS0dbeIUeVCAuPxC2+Hz1tr0g3g==
X-Received: by 2002:a17:906:cc88:: with SMTP id oq8mr3697677ejb.66.1618575794966;
        Fri, 16 Apr 2021 05:23:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3zbjnd4HQkCSJYV28UfiRyMLheJIB6t7IsbXsF8yk+dO9xyseBRuNJFTx+2VFeWEOHhu4hw==
X-Received: by 2002:a17:906:cc88:: with SMTP id oq8mr3697662ejb.66.1618575794849;
        Fri, 16 Apr 2021 05:23:14 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id i25sm2328924edr.68.2021.04.16.05.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 05:23:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] crypto: s5p-sss - simplify getting of_device_id match data
Date:   Fri, 16 Apr 2021 14:23:09 +0200
Message-Id: <20210416122311.223076-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_device_get_match_data() to make the code slightly smaller.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/crypto/s5p-sss.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
index 8ed08130196f..d613bd557016 100644
--- a/drivers/crypto/s5p-sss.c
+++ b/drivers/crypto/s5p-sss.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/scatterlist.h>
 
@@ -424,13 +425,9 @@ MODULE_DEVICE_TABLE(of, s5p_sss_dt_match);
 static inline const struct samsung_aes_variant *find_s5p_sss_version
 				   (const struct platform_device *pdev)
 {
-	if (IS_ENABLED(CONFIG_OF) && (pdev->dev.of_node)) {
-		const struct of_device_id *match;
+	if (IS_ENABLED(CONFIG_OF) && (pdev->dev.of_node))
+		return of_device_get_match_data(&pdev->dev);
 
-		match = of_match_node(s5p_sss_dt_match,
-					pdev->dev.of_node);
-		return (const struct samsung_aes_variant *)match->data;
-	}
 	return (const struct samsung_aes_variant *)
 			platform_get_device_id(pdev)->driver_data;
 }
-- 
2.25.1

