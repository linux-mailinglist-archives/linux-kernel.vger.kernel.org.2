Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D34417606
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344594AbhIXNio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:38:44 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59970
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346761AbhIXNid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:38:33 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C47AF40784
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632490618;
        bh=90LQqsSK32tSFh91aPRZL+TZq8U0f1YD/IqlXackaD4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=QiO++ncXagNBni5eEPObLWainVDoeYhiXhjWxZcbAD6toDvwAqUKIklmrMmjU40s/
         1445Ky9mvogjMAL9ZWZBdpi+JzZy7tFTHEyAQFjJ9mpbEMs/v1OFINoazDsIZtupzI
         BmVsOx7QsSXegdwzpI6eDI2zEJtbCzBzOPJM/Bvln+5efltvGINr2O2Rj71l1cRm7Y
         bvVyyx4Y9Jh9SGjhHZ14S02NbF8yMZ/QTn+2VyGXX61n5/LeMpXEjYERxhr9T2Hf3f
         3VQAlsauyTkR8J9BJ+2WYYYa+gAwZp5jW7L9pcwEi6sZfzKEsylLdG+Ryk8urodJ3L
         XYFUcx6DNBD0Q==
Received: by mail-wr1-f69.google.com with SMTP id a17-20020adfed11000000b00160525e875aso573063wro.23
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=90LQqsSK32tSFh91aPRZL+TZq8U0f1YD/IqlXackaD4=;
        b=hjmrecUQHTAFRJgIwsHv07Ml8PfXMTvkjDqdkOEO68ZLFnhDD4iCNisPUzKjrjsoms
         Z89JM/0jo0nRSY59iCrS3AraeS+q9zrxH16MyS9z0j+H+L8mfpKVtdUWYXmEpdKbE/m5
         1KBTaR45Y1Ocj4B3j8EvRa1F1ENTDmoZ7ce6+uBFq/86S4McdDOMOP2nXMweBp8inxdb
         fG4TGWe33hjoibHYxrfRqWjJIgt4ttKDs/4zIXNcX75i29SVp9+9k69pJ0nOfEiRmi8j
         UtU3xow23SEuRv66LySS0u4EzwNjgVPN4B4FZff++0TVRhSEbXOLECnR8JmOVtyITAjk
         39qQ==
X-Gm-Message-State: AOAM531DgOPpIrE0Kp2kgADhF3EIZhh1Z9zl8idCrRoclztLeOW1/nhY
        YXCWEMDfvg3CnrnwE4/ECC0AH6jaEy8Z9WJ8JqIaAukPbZB7sR9Dwa/nhxitaQqwfybvkuIl46A
        CrzL9bFGPWReOzeAXvv3hVRvkDOTgJZV25rB5AkLD2g==
X-Received: by 2002:a05:600c:4106:: with SMTP id j6mr2248101wmi.99.1632490618455;
        Fri, 24 Sep 2021 06:36:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOzWcfCKTUfPBl8cAWjFiXGRe8fe974eq3o4JN39+VEZHWSXwMJ+8CTcRTSWPLHrokroGXgw==
X-Received: by 2002:a05:600c:4106:: with SMTP id j6mr2248085wmi.99.1632490618319;
        Fri, 24 Sep 2021 06:36:58 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id j19sm8122245wra.92.2021.09.24.06.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:36:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH] clk: samsung: describe drivers in KConfig
Date:   Fri, 24 Sep 2021 15:36:24 +0200
Message-Id: <20210924133624.112593-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe better which driver applies to which SoC, to make configuring
kernel for Samsung SoC easier.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/clk/samsung/Kconfig | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/samsung/Kconfig b/drivers/clk/samsung/Kconfig
index 0441c4f73ac9..0e18d6ff2916 100644
--- a/drivers/clk/samsung/Kconfig
+++ b/drivers/clk/samsung/Kconfig
@@ -67,7 +67,8 @@ config EXYNOS_5420_COMMON_CLK
 	depends on COMMON_CLK_SAMSUNG
 	help
 	  Support for the clock controller present on the Samsung
-	  Exynos5420 SoCs. Choose Y here only if you build for this SoC.
+	  Exynos5420/Exynos5422/Exynos5800 SoCs. Choose Y here only if you
+	  build for this SoC.
 
 config EXYNOS_ARM64_COMMON_CLK
 	bool "Samsung Exynos ARMv8-family clock controller support" if COMPILE_TEST
@@ -79,38 +80,47 @@ config EXYNOS_AUDSS_CLK_CON
 	default y if ARCH_EXYNOS
 	help
 	  Support for the Audio Subsystem CLKCON clock controller present
-	  on some Exynos SoC variants. Choose M or Y here if you want to
-	  use audio devices such as I2S, PCM, etc.
+	  on some Samsung Exynos SoC variants. Choose M or Y here if you want
+	  to use audio devices such as I2S, PCM, etc.
 
 config EXYNOS_CLKOUT
 	tristate "Samsung Exynos clock output driver"
 	depends on COMMON_CLK_SAMSUNG
 	default y if ARCH_EXYNOS
 	help
-	  Support for the clock output (XCLKOUT) present on some of Exynos SoC
-	  variants. Usually the XCLKOUT is used to monitor the status of the
-	  certains clocks from SoC, but it could also be tied to other devices
-	  as an input clock.
+	  Support for the clock output (XCLKOUT) present on some of Samsung
+	  Exynos SoC variants. Usually the XCLKOUT is used to monitor the
+	  status of the certains clocks from SoC, but it could also be tied to
+	  other devices as an input clock.
 
 # For S3C24XX platforms, select following symbols:
 config S3C2410_COMMON_CLK
 	bool "Samsung S3C2410 clock controller support" if COMPILE_TEST
 	select COMMON_CLK_SAMSUNG
 	help
-	  Build the s3c2410 clock driver based on the common clock framework.
+	  Support for the clock controller present on the Samsung
+	  S3C2410/S3C2440/S3C2442 SoCs. Choose Y here only if you build for
+	  this SoC.
 
 config S3C2410_COMMON_DCLK
 	bool
 	select COMMON_CLK_SAMSUNG
 	select REGMAP_MMIO
 	help
-	  Temporary symbol to build the dclk driver based on the common clock
-	  framework.
+	  Support for the dclk clock controller present on the Samsung
+	  S3C2410/S3C2412/S3C2440/S3C2443 SoCs. Choose Y here only if you build
+	  for this SoC.
 
 config S3C2412_COMMON_CLK
 	bool "Samsung S3C2412 clock controller support" if COMPILE_TEST
 	select COMMON_CLK_SAMSUNG
+	help
+	  Support for the clock controller present on the Samsung S3C2412 SoCs.
+	  Choose Y here only if you build for this SoC.
 
 config S3C2443_COMMON_CLK
 	bool "Samsung S3C2443 clock controller support" if COMPILE_TEST
 	select COMMON_CLK_SAMSUNG
+	help
+	  Support for the clock controller present on the Samsung
+	  S3C2416/S3C2443 SoCs. Choose Y here only if you build for this SoC.
-- 
2.30.2

