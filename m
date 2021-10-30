Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA24440AC6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 19:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhJ3R5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 13:57:01 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:32378 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhJ3R5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 13:57:00 -0400
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 19UHr1AA012295;
        Sun, 31 Oct 2021 02:53:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 19UHr1AA012295
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1635616381;
        bh=ZK+grd221AxXUXX2rlYHuK3dONgxNZo6X1wP17ipnTM=;
        h=From:To:Cc:Subject:Date:From;
        b=SgITaTmWkqBCjEdCFdpHxExBLuMSJ2vutEntXQTkbV6lsTzxcRftSkptSucAn+aMe
         21g5RoEDzYRuP+mk5B5c5fH/y9L6TAPKIc8o+Gq0f4kdNZ4rK4Pees6jh+K0bLFqTJ
         Kkutv9jQ4lyZZjI2p3FKNiOc09xwiZhJPITvJsNehV0/SrF3xMdNzyRb3bNkIuDRg4
         U79vgtqE/NuaNqOu8NlpgMUUgXN5uIQdfuHIH2ivGpoIhgqHbtPJCfSbGCwPkgz3uj
         rvqARUz82AhBgoWcKUEFqmkINqxmrSo2/fmvBhqs+BY5JZPaAJuhC0PxkxRp1rr9qq
         lRFwzc15LS7qQ==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     patches@arm.linux.org.uk
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: decompressor: do not copy source files while building
Date:   Sun, 31 Oct 2021 02:52:58 +0900
Message-Id: <20211030175258.1716178-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commit 7ae4a78daacf ("ARM: 8969/1: decompressor: simplify libfdt
builds") stated, copying source files during the build time may not
end up with as clean code as expected.

Do similar for the other library files for further cleanups of the
Makefile and .gitignore.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

KernelVersion: v5.15-rc1

 arch/arm/boot/compressed/.gitignore  |  5 -----
 arch/arm/boot/compressed/Makefile    | 33 +++-------------------------
 arch/arm/boot/compressed/ashldi3.S   |  3 +++
 arch/arm/boot/compressed/bswapsdi2.S |  3 +++
 arch/arm/boot/compressed/font.c      |  2 ++
 arch/arm/boot/compressed/hyp-stub.S  |  2 ++
 arch/arm/boot/compressed/lib1funcs.S |  3 +++
 scripts/remove-stale-files           |  2 +-
 8 files changed, 17 insertions(+), 36 deletions(-)
 create mode 100644 arch/arm/boot/compressed/ashldi3.S
 create mode 100644 arch/arm/boot/compressed/bswapsdi2.S
 create mode 100644 arch/arm/boot/compressed/font.c
 create mode 100644 arch/arm/boot/compressed/hyp-stub.S
 create mode 100644 arch/arm/boot/compressed/lib1funcs.S

diff --git a/arch/arm/boot/compressed/.gitignore b/arch/arm/boot/compressed/.gitignore
index 60606b0f378d..d32f41778437 100644
--- a/arch/arm/boot/compressed/.gitignore
+++ b/arch/arm/boot/compressed/.gitignore
@@ -1,9 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ashldi3.S
-bswapsdi2.S
-font.c
-lib1funcs.S
-hyp-stub.S
 piggy_data
 vmlinux
 vmlinux.lds
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 91265e7ff672..74d2f1401acb 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -13,7 +13,6 @@ ifeq ($(CONFIG_DEBUG_UNCOMPRESS),y)
 OBJS	+= debug.o
 AFLAGS_head.o += -DDEBUG
 endif
-FONTC	= $(srctree)/lib/fonts/font_acorn_8x8.c
 
 # string library code (-Os is enforced to keep it much smaller)
 OBJS		+= string.o
@@ -99,11 +98,8 @@ $(foreach o, $(libfdt_objs) atags_to_fdt.o fdt_check_mem_start.o, \
 	$(eval CFLAGS_$(o) := -I $(srctree)/scripts/dtc/libfdt -fno-stack-protector))
 
 targets       := vmlinux vmlinux.lds piggy_data piggy.o \
-		 lib1funcs.o ashldi3.o bswapsdi2.o \
 		 head.o $(OBJS)
 
-clean-files += lib1funcs.S ashldi3.S bswapsdi2.S hyp-stub.S
-
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 
 ccflags-y := -fpic $(call cc-option,-mno-single-pic-base,) -fno-builtin \
@@ -134,23 +130,7 @@ endif
 # Next argument is a linker script
 LDFLAGS_vmlinux += -T
 
-# For __aeabi_uidivmod
-lib1funcs = $(obj)/lib1funcs.o
-
-$(obj)/lib1funcs.S: $(srctree)/arch/$(SRCARCH)/lib/lib1funcs.S
-	$(call cmd,shipped)
-
-# For __aeabi_llsl
-ashldi3 = $(obj)/ashldi3.o
-
-$(obj)/ashldi3.S: $(srctree)/arch/$(SRCARCH)/lib/ashldi3.S
-	$(call cmd,shipped)
-
-# For __bswapsi2, __bswapdi2
-bswapsdi2 = $(obj)/bswapsdi2.o
-
-$(obj)/bswapsdi2.S: $(srctree)/arch/$(SRCARCH)/lib/bswapsdi2.S
-	$(call cmd,shipped)
+OBJS	+= lib1funcs.o ashldi3.o bswapsdi2.o
 
 # We need to prevent any GOTOFF relocs being used with references
 # to symbols in the .bss section since we cannot relocate them
@@ -175,8 +155,8 @@ fi
 efi-obj-$(CONFIG_EFI_STUB) := $(objtree)/drivers/firmware/efi/libstub/lib.a
 
 $(obj)/vmlinux: $(obj)/vmlinux.lds $(obj)/$(HEAD) $(obj)/piggy.o \
-		$(addprefix $(obj)/, $(OBJS)) $(lib1funcs) $(ashldi3) \
-		$(bswapsdi2) $(efi-obj-y) FORCE
+		$(addprefix $(obj)/, $(OBJS)) \
+		$(efi-obj-y) FORCE
 	@$(check_for_multiple_zreladdr)
 	$(call if_changed,ld)
 	@$(check_for_bad_syms)
@@ -187,11 +167,4 @@ $(obj)/piggy_data: $(obj)/../Image FORCE
 $(obj)/piggy.o: $(obj)/piggy_data
 
 CFLAGS_font.o := -Dstatic=
-
-$(obj)/font.c: $(FONTC)
-	$(call cmd,shipped)
-
 AFLAGS_hyp-stub.o := -Wa,-march=armv7-a
-
-$(obj)/hyp-stub.S: $(srctree)/arch/$(SRCARCH)/kernel/hyp-stub.S
-	$(call cmd,shipped)
diff --git a/arch/arm/boot/compressed/ashldi3.S b/arch/arm/boot/compressed/ashldi3.S
new file mode 100644
index 000000000000..216f82eda609
--- /dev/null
+++ b/arch/arm/boot/compressed/ashldi3.S
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* For __aeabi_llsl */
+#include "../../lib/ashldi3.S"
diff --git a/arch/arm/boot/compressed/bswapsdi2.S b/arch/arm/boot/compressed/bswapsdi2.S
new file mode 100644
index 000000000000..b2156b378c7b
--- /dev/null
+++ b/arch/arm/boot/compressed/bswapsdi2.S
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* For __bswapsi2, __bswapdi2 */
+#include "../../lib/bswapsdi2.S"
diff --git a/arch/arm/boot/compressed/font.c b/arch/arm/boot/compressed/font.c
new file mode 100644
index 000000000000..46a677649db4
--- /dev/null
+++ b/arch/arm/boot/compressed/font.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "../../../../lib/fonts/font_acorn_8x8.c"
diff --git a/arch/arm/boot/compressed/hyp-stub.S b/arch/arm/boot/compressed/hyp-stub.S
new file mode 100644
index 000000000000..a703eaa86f10
--- /dev/null
+++ b/arch/arm/boot/compressed/hyp-stub.S
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#include "../../kernel/hyp-stub.S"
diff --git a/arch/arm/boot/compressed/lib1funcs.S b/arch/arm/boot/compressed/lib1funcs.S
new file mode 100644
index 000000000000..815dec73ba4d
--- /dev/null
+++ b/arch/arm/boot/compressed/lib1funcs.S
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* For __aeabi_uidivmod */
+#include "../../lib/lib1funcs.S"
diff --git a/scripts/remove-stale-files b/scripts/remove-stale-files
index c3eb81c3f7de..eb630ee287c3 100755
--- a/scripts/remove-stale-files
+++ b/scripts/remove-stale-files
@@ -24,7 +24,7 @@ set -e
 # with O=, make sure to remove the stale files in the output tree. Otherwise,
 # the build system wrongly compiles the stale ones.
 if [ -n "${building_out_of_srctree}" ]; then
-	for f in fdt_rw.c fdt_ro.c fdt_wip.c fdt.c
+	for f in fdt_rw.c fdt_ro.c fdt_wip.c fdt.c ashldi3.S bswapsdi2.S font.c lib1funcs.S hyp-stub.S
 	do
 		rm -f arch/arm/boot/compressed/${f}
 	done
-- 
2.30.2

