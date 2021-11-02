Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D20442C20
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhKBLIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:08:05 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35566
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230100AbhKBLIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:08:04 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D5C3A3F1B2
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 11:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635851128;
        bh=eCXkhtzwAkxmBwcMzvoTZ9XLgb1F/fHJXMlrCrHh7Fg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=MtbC5KbQDitQZKSYyONOYPcpqSOzvE/W13XCpeDYLifKwdg3Tj3D3FrxbqjcFfIx3
         LYQOfx+n2o4VJuFxCpZUkZH6/jhIOD2nMIgIzysG6BktkGJBIXBd+IOxQUB0QZblvd
         hXhNc62Qon5pgnkrUkeWXnup/2bshK5qp0W+f/J6E3AtDqp0MwhK3wJc+Olygptn1X
         jFFud3u4PqxTC7mFaKGD0UKZyFUnaDnOpRskCB5sbZxq1Qy89XsDRSIlCaFOMG5EhL
         ChRfxuexRgOFl14KqthiaiCzmSP1ibh+4Xho1vh4Gypq/gk++J0PGH7iFrxFxcGDUL
         EAv2s4Vakuz3A==
Received: by mail-lf1-f69.google.com with SMTP id p19-20020a056512139300b003ff6dfea137so6880331lfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 04:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eCXkhtzwAkxmBwcMzvoTZ9XLgb1F/fHJXMlrCrHh7Fg=;
        b=nBOnNpnEbpe1ffqS79kIQM/p8VonklRJnnuDLnhCZLS+fAZHeCUqEqDzJXXZgIf+Rx
         RXlAu+oMTn+wUO2GkySqTkd4EJbnnUo2WTF02JznOo12p49CgigMk6mtidl2yZRJPWUK
         nfuXaGjDyGoMqdSKczi1TMvTAJP1E6O/6m9U6TUcJcdY7ScdLfOq4E8huVBHc8X2W1Ah
         HoLxnoN+jcUyktLHIpsOHVFPHrM172S2Lvjgyl9hWklisTHarED4qQ8Nrqge9qH/wAA+
         UVYNpXzJLPUSTQrVsoCFFHuY5sKgsohrdoy317jgHcml9mQsZGjnb1h+MIPWm9IOzRv/
         CmdA==
X-Gm-Message-State: AOAM533vldAQ3fTGkndqaco95bvlPQiJPfLxCzMGp9ITVpym3waGL0bI
        w1WIskLDGV7trfjC2z3YRjiCp0Y6/wO23Pkd+a7XxvqClrozsoXaQxPmAA7pOXXhi/Z8EAszT9E
        CI+P6NzQxZHouiV2M6pv876pkxz9t4610u8D3c2x7qw==
X-Received: by 2002:a05:6512:e83:: with SMTP id bi3mr13362214lfb.479.1635851128161;
        Tue, 02 Nov 2021 04:05:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwseu9XzPZO5lqX9ofSsGGrNhP59zvsk8fmBNAtBvWsuKP4dwmjgVWVIem8UF2IObzhslAmzA==
X-Received: by 2002:a05:6512:e83:: with SMTP id bi3mr13362181lfb.479.1635851127903;
        Tue, 02 Nov 2021 04:05:27 -0700 (PDT)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id j26sm1655127lfb.84.2021.11.02.04.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 04:05:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Kukjin Kim <kgene@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>, Cedric Roux <sed@free.fr>,
        Sam Van Den Berge <sam.van.den.berge@telenet.be>,
        Lihua Yao <ylhuajnu@outlook.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [RFC PATCH] ARM: s3c: mark as deprecated and schedule removal after 2022
Date:   Tue,  2 Nov 2021 12:05:19 +0100
Message-Id: <20211102110519.142434-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung S3C24xx and S3C64xx platforms are very old designs. S3C2416
was introduced in 2008 and S3C6410 in 2009/2010.  They are not widely
available anymore - out-of-stock on FriendlyArm (one of manufacturers of
boards) and only few specialist stores still offer them for quite a high
price.

The community around these platforms was not very active, so I suspect
no one really uses them anymore. Maintenance takes precious time so
there is little sense in keeping them alive if there are no real users.

Let's mark all S3C24xx and S3C64xx platforms as deprecated and mention
possible removal in one year (after 2022).  The deprecation message will
be as text in Kconfig, build message (not a warning though) and runtime
print error.

If there are any users, they might respond and postpone the removal.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/Kconfig                  | 7 ++++++-
 arch/arm/mach-s3c/Kconfig.s3c64xx | 7 ++++++-
 arch/arm/mach-s3c/cpu.c           | 1 +
 arch/arm/mach-s3c/init.c          | 2 ++
 arch/arm/mach-s3c/s3c24xx.c       | 5 +++++
 arch/arm/mach-s3c/s3c64xx.c       | 5 +++++
 6 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f0f9e8bec83a..bd8237c7e7f1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -473,7 +473,7 @@ config ARCH_SA1100
 	  Support for StrongARM 11x0 based boards.
 
 config ARCH_S3C24XX
-	bool "Samsung S3C24XX SoCs"
+	bool "Samsung S3C24XX SoCs (deprecated, see help)"
 	select ATAGS
 	select CLKSRC_SAMSUNG_PWM
 	select GPIO_SAMSUNG
@@ -491,6 +491,11 @@ config ARCH_S3C24XX
 	  (<http://www.simtec.co.uk/products/EB110ITX/>), the IPAQ 1940 or the
 	  Samsung SMDK2410 development board (and derivatives).
 
+	  The platform is deprecated and scheduled in removal. Please reach to
+	  the maintainers of the platform and linux-samsung-soc@vger.kernel.org if
+	  you still use it.
+	  Without such feedback, the platform will be removed after 2022.
+
 config ARCH_OMAP1
 	bool "TI OMAP1"
 	depends on MMU
diff --git a/arch/arm/mach-s3c/Kconfig.s3c64xx b/arch/arm/mach-s3c/Kconfig.s3c64xx
index f3fcb570edf5..3b090ae72bbd 100644
--- a/arch/arm/mach-s3c/Kconfig.s3c64xx
+++ b/arch/arm/mach-s3c/Kconfig.s3c64xx
@@ -4,7 +4,7 @@
 #	Simtec Electronics, Ben Dooks <ben@simtec.co.uk>
 
 menuconfig ARCH_S3C64XX
-	bool "Samsung S3C64XX"
+	bool "Samsung S3C64XX (deprecated, see help)"
 	depends on ARCH_MULTI_V6
 	select ARM_AMBA
 	select ARM_VIC
@@ -25,6 +25,11 @@ menuconfig ARCH_S3C64XX
 	help
 	  Samsung S3C64XX series based systems
 
+	  The platform is deprecated and scheduled in removal. Please reach to
+	  the maintainers of the platform and linux-samsung-soc@vger.kernel.org if
+	  you still use it.
+	  Without such feedback, the platform will be removed after 2022.
+
 if ARCH_S3C64XX
 
 # Configuration options for the S3C6410 CPU
diff --git a/arch/arm/mach-s3c/cpu.c b/arch/arm/mach-s3c/cpu.c
index 6e9772555f0d..3b16cf42910f 100644
--- a/arch/arm/mach-s3c/cpu.c
+++ b/arch/arm/mach-s3c/cpu.c
@@ -28,4 +28,5 @@ void __init s3c64xx_init_cpu(void)
 	}
 
 	pr_info("Samsung CPU ID: 0x%08lx\n", samsung_cpu_id);
+	pr_err("The platform is deprecated and scheduled in removal. Please reach to the maintainers of the platform and linux-samsung-soc@vger.kernel.org if you still use it.  Without such feedback, the platform will be removed after 2022.\n");
 }
diff --git a/arch/arm/mach-s3c/init.c b/arch/arm/mach-s3c/init.c
index 9d92f03e9bc1..5db7dc54340c 100644
--- a/arch/arm/mach-s3c/init.c
+++ b/arch/arm/mach-s3c/init.c
@@ -59,6 +59,8 @@ void __init s3c_init_cpu(unsigned long idcode,
 
 	if (cpu->map_io)
 		cpu->map_io();
+
+	pr_err("The platform is deprecated and scheduled in removal. Please reach to the maintainers of the platform and linux-samsung-soc@vger.kernel.org if you still use it.  Without such feedback, the platform will be removed after 2022.\n");
 }
 
 /* s3c24xx_init_clocks
diff --git a/arch/arm/mach-s3c/s3c24xx.c b/arch/arm/mach-s3c/s3c24xx.c
index ccfed48c98aa..2ea1cb21dfbc 100644
--- a/arch/arm/mach-s3c/s3c24xx.c
+++ b/arch/arm/mach-s3c/s3c24xx.c
@@ -678,3 +678,8 @@ struct platform_device s3c2410_device_dclk = {
 	},
 };
 #endif
+
+#pragma message "The platform is deprecated and scheduled in removal (see platform help). " \
+		"Please reach to the maintainers of the platform " \
+		"and linux-samsung-soc@vger.kernel.org if you still use it." \
+		"Without such feedback, the platform will be removed after 2022."
diff --git a/arch/arm/mach-s3c/s3c64xx.c b/arch/arm/mach-s3c/s3c64xx.c
index 4dfb648142f2..3e248f0e96a2 100644
--- a/arch/arm/mach-s3c/s3c64xx.c
+++ b/arch/arm/mach-s3c/s3c64xx.c
@@ -425,3 +425,8 @@ static int __init s3c64xx_init_irq_eint(void)
 	return 0;
 }
 arch_initcall(s3c64xx_init_irq_eint);
+
+#pragma message "The platform is deprecated and scheduled in removal (see platform help). " \
+		"Please reach to the maintainers of the platform " \
+		"and linux-samsung-soc@vger.kernel.org if you still use it." \
+		"Without such feedback, the platform will be removed after 2022."
-- 
2.32.0

