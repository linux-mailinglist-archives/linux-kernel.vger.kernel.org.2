Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30832324F0F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 12:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbhBYLW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 06:22:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:56710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234736AbhBYLWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 06:22:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A128964EF1;
        Thu, 25 Feb 2021 11:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614252090;
        bh=PqWn91KrIETiPlzBFDZjY6Somdl4vci+5xNgQ83B00Q=;
        h=From:To:Cc:Subject:Date:From;
        b=p/ZwyTzdtsjXQtkNhRRjE38XN33+oamIKs7NaqMoHtZ5ytJu2LGEPHiBMl3ZT1w+h
         T+emWFOtMZbM5WxWJvFg4DddYY9WFEGWcmLDhx0SQ+DViQRm/rb/Hzsc/3+0cvTKBf
         llrjN1TWCqgIwS30MJLYXt1tDML2guwysFs7QTumAdHCXf4uDLHvX6A+JFl7LWQzSt
         jfUL2aD3U61JqiZ9o4xbAkj8t/wo83rLjIOqpScBg4CQPcM8uTBcmTiNG6p3obE0BW
         d3FJcVWcjbff9/Y5b0nHXtz0OsfUtk9cB+bR2KCOfKR+7I8Ll4t79E3EstZU1Ur9O6
         kky/BAI/Xp31w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Scull <ascull@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] [RFC] arm64: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Date:   Thu, 25 Feb 2021 12:20:56 +0100
Message-Id: <20210225112122.2198845-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When looking at kernel size optimizations, I found that arm64
does not currently support HAVE_LD_DEAD_CODE_DATA_ELIMINATION,
which enables the --gc-sections flag to the linker.

I see that for a defconfig build with llvm, there are some
notable improvements from enabling this, in particular when
combined with the recently added CONFIG_LTO_CLANG_THIN
and CONFIG_TRIM_UNUSED_KSYMS:

   text    data     bss     dec     hex filename
16570322 10998617 506468 28075407 1ac658f defconfig/vmlinux
16318793 10569913 506468 27395174 1a20466 trim_defconfig/vmlinux
16281234 10984848 504291 27770373 1a7be05 gc_defconfig/vmlinux
16029705 10556880 504355 27090940 19d5ffc gc+trim_defconfig/vmlinux
17040142 11102945 504196 28647283 1b51f73 thinlto_defconfig/vmlinux
16788613 10663201 504196 27956010 1aa932a thinlto+trim_defconfig/vmlinux
16347062 11043384 502499 27892945 1a99cd1 gc+thinlto_defconfig/vmlinux
15759453 10532792 502395 26794640 198da90 gc+thinlto+trim_defconfig/vmlinux

I needed a small change to the linker script to get clean randconfig
builds, but I have not done any meaningful boot testing on it to
see if it works. If there are no regressions, I wonder whether this
should be autmatically done for LTO builds, given that it improves
both kernel size and compile speed.

Link: https://lore.kernel.org/lkml/CAK8P3a05VZ9hSKRzVTxTn+1nf9E+gqebJWTj6N23nfm+ELHt9A@mail.gmail.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/Kconfig              | 1 +
 arch/arm64/kernel/vmlinux.lds.S | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b94a678afce4..75e13cc52928 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2,6 +2,7 @@
 config ARM64
 	def_bool y
 	select ACPI_CCA_REQUIRED if ACPI
+	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_GTDT if ACPI
 	select ACPI_IORT if ACPI
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index bad2b9eaab22..926cdb597a45 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -217,7 +217,7 @@ SECTIONS
 		INIT_CALLS
 		CON_INITCALL
 		INIT_RAM_FS
-		*(.init.altinstructions .init.bss .init.bss.*)	/* from the EFI stub */
+		*(.init.altinstructions .init.data.* .init.bss .init.bss.*)	/* from the EFI stub */
 	}
 	.exit.data : {
 		EXIT_DATA
-- 
2.29.2

