Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABAA3DA605
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237900AbhG2OL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:11:27 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:59491 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238193AbhG2OG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:06:57 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 16TE3sm5009142;
        Thu, 29 Jul 2021 23:03:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 16TE3sm5009142
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1627567435;
        bh=bzFoF25ekptihRaZTAxt4g/hfk6mrcBC87PY0m7n+M0=;
        h=From:To:Cc:Subject:Date:From;
        b=Zq2g9KaD7MavnWzdVPtTYEqnK0ZbyLyiCyduQKLBeMDOROeXcTEsC21Tm4GCLz7O6
         q5sR0rqjiTf/4uN6P2Kw2qh6qEbPfVFjzzEmhqrFX+4K/VOplk6dydpqT46PinF6XK
         gZw0C6NXs06P2ODIv31SwpbyxS8prrT7GXDpTdnsLN/UQNwcrNhePeCPolVopBj3+j
         1V1OyiojEgOBRlgvyk0PGJp8uFH+nkpbyCNk+ZfgA8hA6S+N34PD9QSEqrqM+SNvJA
         DGODXtcrN02eCqFi/0Tzl4IpItP1LwEGRqJs+sY78CAWDrefJlZ0f+iLgRzw2EdKxG
         qmT3Gr6WIauVg==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     patches@arm.linux.org.uk
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: move the (z/u)install rules to arch/arm/Makefile
Date:   Thu, 29 Jul 2021 23:03:51 +0900
Message-Id: <20210729140351.442678-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the (z/u)install targets in arch/arm/Makefile descend into
arch/arm/boot/Makefile to invoke the shell script, but there is no
good reason to do so.

arch/arm/Makefile can run the shell script directly.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

KernelVersion: v5.14-rc1

 arch/arm/Makefile      |  3 ++-
 arch/arm/boot/Makefile | 14 +-------------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 173da685a52e..847c31e7c368 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -308,7 +308,8 @@ $(BOOT_TARGETS): vmlinux
 	@$(kecho) '  Kernel: $(boot)/$@ is ready'
 
 $(INSTALL_TARGETS):
-	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
+	$(CONFIG_SHELL) $(srctree)/$(boot)/install.sh "$(KERNELRELEASE)" \
+	$(boot)/$(patsubst %install,%Image,$@) System.map "$(INSTALL_PATH)"
 
 PHONY += vdso_install
 vdso_install:
diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index 0b3cd7a33a26..54a09f9464fb 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -96,23 +96,11 @@ $(obj)/bootp/bootp: $(obj)/zImage initrd FORCE
 $(obj)/bootpImage: $(obj)/bootp/bootp FORCE
 	$(call if_changed,objcopy)
 
-PHONY += initrd install zinstall uinstall
+PHONY += initrd
 initrd:
 	@test "$(INITRD_PHYS)" != "" || \
 	(echo This machine does not support INITRD; exit -1)
 	@test "$(INITRD)" != "" || \
 	(echo You must specify INITRD; exit -1)
 
-install:
-	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" \
-	$(obj)/Image System.map "$(INSTALL_PATH)"
-
-zinstall:
-	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" \
-	$(obj)/zImage System.map "$(INSTALL_PATH)"
-
-uinstall:
-	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" \
-	$(obj)/uImage System.map "$(INSTALL_PATH)"
-
 subdir-	    := bootp compressed dts
-- 
2.27.0

