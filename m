Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B5435FCBA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 22:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244538AbhDNUea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 16:34:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50449 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbhDNUeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 16:34:24 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWmD3-0007QZ-LA
        for linux-kernel@vger.kernel.org; Wed, 14 Apr 2021 20:34:01 +0000
Received: by mail-ej1-f71.google.com with SMTP id bx15-20020a170906a1cfb029037415131f28so219361ejb.18
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 13:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x2hO5DXMeLJZo3Sq4pJYNG0FO8H5GrNmCBQcI+p7buM=;
        b=hHEgzp1W6hUAJX7kYCPOX/rHNDC/xuUZBJQCq1i72LfqJswyqk9E+FW2O94US+fnyP
         1Xo2YRnIAWM6Ir9+R1wdlAhfY/9O0ro8vVLmfix4qkZqrlm76lltYrWb9AnJgg/aD1Py
         AdD9FIaigO5HviKYZl36RN5YqA8aVYXDUKqXPkQbT/xzqJJ3BELyjAlpimqqGFszdvs3
         XeTbsVSxRr0LvN5TUKxcTEGa5+ba34NhiWHFhORsjEu0NdX4g+of7JrBkPnP2h0p5D6H
         9hasKTlpsIhYc7FUD9404Qnu+4NPMmMnExymyqzkvjLBAx3cZ+nWrtTH2plf93eOhRjF
         e2ig==
X-Gm-Message-State: AOAM530zJvzaVWczQ6LejipvaLc0XlfOlbbvqDLQxLChodEeQSG2Kg8Q
        opxZC3viEsB9ehFVUKJ3ODFTEL49gYuyf0wZcT/IjGPsy+pJXFrsNsXHUsQIYf6S7rQew2uGLnA
        0mZ/APUg3CKcF5zOthG/aYWVbiWjyHVBbb/Wqm2wo4w==
X-Received: by 2002:a05:6402:5189:: with SMTP id q9mr72094edd.168.1618432441434;
        Wed, 14 Apr 2021 13:34:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8Z5ptlAYigxFNCd5S/xT8AwrP3ue/ADlxR9AJcWKfkq3TLq+hwkPI3X1JJfIFB9MPghvAVg==
X-Received: by 2002:a05:6402:5189:: with SMTP id q9mr72086edd.168.1618432441295;
        Wed, 14 Apr 2021 13:34:01 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id q6sm372209ejt.51.2021.04.14.13.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 13:34:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 1/3] spi: s3c64xx: simplify getting of_device_id match data
Date:   Wed, 14 Apr 2021 22:33:41 +0200
Message-Id: <20210414203343.203119-1-krzysztof.kozlowski@canonical.com>
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
 drivers/spi/spi-s3c64xx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index dfa7c91e13aa..c6d7641ea342 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -15,6 +15,7 @@
 #include <linux/spi/spi.h>
 #include <linux/gpio.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_gpio.h>
 
 #include <linux/platform_data/spi-s3c64xx.h>
@@ -1048,17 +1049,12 @@ static struct s3c64xx_spi_info *s3c64xx_spi_parse_dt(struct device *dev)
 }
 #endif
 
-static const struct of_device_id s3c64xx_spi_dt_match[];
-
 static inline struct s3c64xx_spi_port_config *s3c64xx_spi_get_port_config(
 						struct platform_device *pdev)
 {
 #ifdef CONFIG_OF
-	if (pdev->dev.of_node) {
-		const struct of_device_id *match;
-		match = of_match_node(s3c64xx_spi_dt_match, pdev->dev.of_node);
-		return (struct s3c64xx_spi_port_config *)match->data;
-	}
+	if (pdev->dev.of_node)
+		return (struct s3c64xx_spi_port_config *)of_device_get_match_data(&pdev->dev);
 #endif
 	return (struct s3c64xx_spi_port_config *)
 			 platform_get_device_id(pdev)->driver_data;
-- 
2.25.1

