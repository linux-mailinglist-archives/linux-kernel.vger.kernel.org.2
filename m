Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A091F40FEDE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 19:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245132AbhIQRxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 13:53:18 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:39744
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244461AbhIQRxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 13:53:15 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 80D9F3F4BE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 17:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631901112;
        bh=IQyt6zwgdp/OXUQMZuAbWILdBFofevDyEry11XS6jDo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Q15H1QxU+dwIzDZe7ArJMuTCGLow2b6kF1nr4CjGDb1ztsWC3W83NBJjqkJZdMK5+
         pwLbC9pHgMELf2Q4Eo7fe78B8ioG85SNkR/0+KCBMGUtYgubPOkO+WqPggheSMk9Vp
         tjNB9L9QG743KJ+N3GfHEY54wzp2dz7cxa5FGkHh7IQVDYhq6z2As/JSnC/e0B9wh3
         L/vl2ZdLLlcYZUpEdktpeTKTk2/W4f8s6u96eWSmReR74i1EDSFEGFKFa6RQ8CrtYH
         nxdJhwlhqg0QwukGc+Vx0/Jqqu7utw6msEU7At3xJ+1KXEqrxAVZum1MGbggBhDUTT
         puKeyn1BAbJ2Q==
Received: by mail-ed1-f72.google.com with SMTP id o18-20020a056402439200b003d2b11eb0a9so9756263edc.23
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 10:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IQyt6zwgdp/OXUQMZuAbWILdBFofevDyEry11XS6jDo=;
        b=0rtoKn5objiDKtRne6FWVTzYxyOR6FVKsND96NLaVfcmYgBMog3VByWGtxUuyhFzJw
         7WikmsDDQjuAc6O61SaJj4LQyrcMoe6vQFwn8ib0qLr3mWo3SiM1DdgfGdf6C87V80SQ
         OCzOfE9LA9xJAVYLCYQIgZSMZm5VEa2NybirP2H2oIVcd+kE9jySZvaKyMSbrU0VLUkb
         yWGUYwOEPPrY2Ff+39P0hSe3Sgo/GUpBsOmsU7Dd2KEu4UwtKPnb02khzemFzNCcjLtr
         0Td6l+clV5SiUnbcQ4nskaZasPJ40TmBfUUV1teX1gEKWCvL8q0kBBvEo0PsiWf5f1tA
         QUTw==
X-Gm-Message-State: AOAM531EWm2BpFPy8sdMhVaRlkP6Zs9RXm7iKgqhibykG9qsArNyVKta
        SwHQB0+pZ5cAAzm7geVpeo6bgz2gdZyKyg1hqm5Zlx7hYyW/v0vDfnyu/0Sqn6+C6ZqAbdwETle
        2MY0q5fRo6TNg3EkVpqNHearVWujQ5tftAJAf3RVM1Q==
X-Received: by 2002:a05:6402:1855:: with SMTP id v21mr14218392edy.349.1631901112208;
        Fri, 17 Sep 2021 10:51:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrXkcxqf38uw+p54oIGV1i+dULZdFAeCeaZAggyffnNn3NRF5jWbP5AYxDlvcEwOxSNXGLAA==
X-Received: by 2002:a05:6402:1855:: with SMTP id v21mr14218379edy.349.1631901112013;
        Fri, 17 Sep 2021 10:51:52 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id l11sm2951345edv.67.2021.09.17.10.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 10:51:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH 2/2] soc: samsung: exynos-chipid: convert to a module
Date:   Fri, 17 Sep 2021 19:51:34 +0200
Message-Id: <20210917175134.252882-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210917175134.252882-1-krzysztof.kozlowski@canonical.com>
References: <20210917175134.252882-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos ChipID and ASV (Adaptive Supply Voltage) driver is not essential
to system boot and it can successfully be built and loaded as module.

This makes core kernel image smaller and reduces the memory footprint
when multi-platform kernel is booted on non-Exynos board.  Usually it is
also distro-friendly.

Add multiple authors of the driver since its conversion from
mach-exynos, ordered alphabetically by first name.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/soc/samsung/Kconfig          |  3 ++-
 drivers/soc/samsung/Makefile         |  3 ++-
 drivers/soc/samsung/exynos-chipid.c  | 11 ++++++++++-
 drivers/soc/samsung/exynos5422-asv.c |  1 +
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index 1f643c0f5c93..fe139f26d093 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -13,13 +13,14 @@ config EXYNOS_ASV_ARM
 	depends on EXYNOS_CHIPID
 
 config EXYNOS_CHIPID
-	bool "Exynos ChipID controller and ASV driver" if COMPILE_TEST
+	tristate "Exynos ChipID controller and ASV driver" if COMPILE_TEST
 	depends on ARCH_EXYNOS || COMPILE_TEST
 	select EXYNOS_ASV_ARM if ARM && ARCH_EXYNOS
 	select MFD_SYSCON
 	select SOC_BUS
 	help
 	  Support for Samsung Exynos SoC ChipID and Adaptive Supply Voltage.
+	  This driver can also be built as module (exynos_chipid).
 
 config EXYNOS_PMU
 	bool "Exynos PMU controller driver" if COMPILE_TEST
diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
index 0c523a8de4eb..2ae4bea804cf 100644
--- a/drivers/soc/samsung/Makefile
+++ b/drivers/soc/samsung/Makefile
@@ -1,8 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_EXYNOS_ASV_ARM)	+= exynos5422-asv.o
+obj-$(CONFIG_EXYNOS_CHIPID)	+= exynos_chipid.o
+exynos_chipid-y			+= exynos-chipid.o exynos-asv.o
 
-obj-$(CONFIG_EXYNOS_CHIPID)	+= exynos-chipid.o exynos-asv.o
 obj-$(CONFIG_EXYNOS_PMU)	+= exynos-pmu.o
 
 obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)	+= exynos3250-pmu.o exynos4-pmu.o \
diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index 5c1d0f97f766..5e8c957231ff 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -15,6 +15,7 @@
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/mfd/syscon.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -129,6 +130,7 @@ static const struct of_device_id exynos_chipid_of_device_ids[] = {
 	{ .compatible = "samsung,exynos4210-chipid" },
 	{}
 };
+MODULE_DEVICE_TABLE(of, exynos_chipid_of_device_ids);
 
 static struct platform_driver exynos_chipid_driver = {
 	.driver = {
@@ -138,4 +140,11 @@ static struct platform_driver exynos_chipid_driver = {
 	.probe	= exynos_chipid_probe,
 	.remove	= exynos_chipid_remove,
 };
-builtin_platform_driver(exynos_chipid_driver);
+module_platform_driver(exynos_chipid_driver);
+
+MODULE_DESCRIPTION("Samsung Exynos ChipID controller and ASV driver");
+MODULE_AUTHOR("Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>");
+MODULE_AUTHOR("Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>");
+MODULE_AUTHOR("Pankaj Dubey <pankaj.dubey@samsung.com>");
+MODULE_AUTHOR("Sylwester Nawrocki <s.nawrocki@samsung.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/soc/samsung/exynos5422-asv.c b/drivers/soc/samsung/exynos5422-asv.c
index ca409a976e34..475ae5276529 100644
--- a/drivers/soc/samsung/exynos5422-asv.c
+++ b/drivers/soc/samsung/exynos5422-asv.c
@@ -503,3 +503,4 @@ int exynos5422_asv_init(struct exynos_asv *asv)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(exynos5422_asv_init);
-- 
2.30.2

