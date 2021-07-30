Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5D83DB9B8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 15:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbhG3NyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 09:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239160AbhG3NyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 09:54:06 -0400
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9305DC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:54:01 -0700 (PDT)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1m9Sq2-006bVS-Fs
        for linux-kernel@vger.kernel.org; Fri, 30 Jul 2021 15:46:10 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1m9Spz-006bUJ-5u; Fri, 30 Jul 2021 15:46:07 +0200
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1m9Spy-003a2R-MC; Fri, 30 Jul 2021 15:46:06 +0200
From:   Bert Vermeulen <bert@biot.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        John Crispin <john@phrozen.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Mike Rapoport <rppt@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Bert Vermeulen <bert@biot.com>, Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 4/5] ARM: Add basic support for EcoNet EN7523 SoC
Date:   Fri, 30 Jul 2021 15:45:51 +0200
Message-Id: <20210730134552.853350-5-bert@biot.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210730134552.853350-1-bert@biot.com>
References: <20210730134552.853350-1-bert@biot.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Crispin <john@phrozen.org>

EN7523 is an armv7 based silicon used inside broadband access type devices
such as xPON and xDSL. It shares various silicon blocks with MediaTek
silicon such as the MT7622.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Bert Vermeulen <bert@biot.com>
---
 arch/arm/Kconfig  | 14 ++++++++++++++
 arch/arm/Makefile |  1 +
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 82f908fa5676..e4a9401f8513 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -580,6 +580,20 @@ config ARCH_VIRT
 	select HAVE_ARM_ARCH_TIMER
 	select ARCH_SUPPORTS_BIG_ENDIAN
 
+config ARCH_ECONET
+	bool "Econet SoC Support"
+	depends on ARCH_MULTI_V7
+	select ARM_AMBA
+	select ARM_GIC
+	select ARM_GIC_V3
+	select ARM_DMA_USE_IOMMU
+	select ARM_PSCI
+	select HAVE_ARM_ARCH_TIMER
+	select IOMMU_DMA
+	select COMMON_CLK
+	help
+	  Support for Econet EN7523 SoCs
+
 #
 # This is sorted alphabetically by mach-* pathname.  However, plat-*
 # Kconfigs may be included either alphabetically (according to the
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 173da685a52e..1bff0aa29c07 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -152,6 +152,7 @@ textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
 textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
 textofs-$(CONFIG_ARCH_MESON) := 0x00208000
 textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
+textofs-$(CONFIG_ARCH_ECONET) := 0x00088000
 
 # Machine directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
-- 
2.25.1

