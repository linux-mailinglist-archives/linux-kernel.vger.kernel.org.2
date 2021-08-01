Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B060F3DCA25
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 07:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhHAFg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 01:36:26 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:28340 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhHAFgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 01:36:25 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 1715ZSKF016810;
        Sun, 1 Aug 2021 14:35:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 1715ZSKF016810
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1627796128;
        bh=fh/l176Gv84QVzfarclBp8DfOKNeU0iWUB1kJDrNrUE=;
        h=From:To:Cc:Subject:Date:From;
        b=KEPVvfjBKo/W4JIoi7XGtSInnk1QGmt+YyVjePUEvZZa6CZ0DUR2npVk5OSYNYddV
         GKWtLGVEQOZHLo1oNRA9q79XgehufmvQfHxZOcE/L+sLYIi7qsgCXNIof21cDkpv60
         spstLiyclOfz91fm9W07QmgoO3cgUva8D3bgFQ/GlUSbj/5vdMFtPk+Xe9ETz80+BI
         /NMDfaLpl5Pnt+ILJBBQD9AnGRqpv0ygGZrqgBJ5upOQKxb5QYcfqJMYuR/ZfHK6Jd
         7S1lxxYV4d2Rs67p405VrG6ZB4CoZNTiXxD4nhal8crvLebcZblOhyTDzezMieTfBt
         EJKLFQ29kyIAg==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: move warning about toolchains to archprepare
Date:   Sun,  1 Aug 2021 14:35:25 +0900
Message-Id: <20210801053525.105235-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 987fdfec2410 ("arm64: move --fix-cortex-a53-843419 linker test to
Kconfig") fixed the false-positive warning in the installation step.

Yet, there are some cases where this false-positive is shown. For example,
you can see it when you cross 987fdfec2410 during git-bisect.

  $ git checkout 987fdfec2410^
    [ snip ]
  $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig all
    [ snip ]
  $ git checkout v5.13
    [ snip]
  $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig all
    [ snip ]
  arch/arm64/Makefile:25: ld does not support --fix-cortex-a53-843419; kernel may be susceptible to erratum

In the stale include/config/auto.config, CONFIG_ARM64_ERRATUM_843419=y
is set without CONFIG_ARM64_LD_HAS_FIX_ERRATUM_843419, so the warning
is displayed while parsing the Makefiles.

Make will restart with the updated include/config/auto.config, hence
CONFIG_ARM64_LD_HAS_FIX_ERRATUM_843419 will be set eventually, but
this warning is a surprise for users.

Commit 25896d073d8a ("x86/build: Fix compiler support check for
CONFIG_RETPOLINE") addressed a similar issue.

Move $(warning ...) out of the parse stage of Makefiles.

The same applies to CONFIG_ARM64_USE_LSE_ATOMICS.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm64/Makefile | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index ded13230f901..8b0fd9d92390 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -21,19 +21,11 @@ LDFLAGS_vmlinux		+= -shared -Bsymbolic -z notext \
 endif
 
 ifeq ($(CONFIG_ARM64_ERRATUM_843419),y)
-  ifneq ($(CONFIG_ARM64_LD_HAS_FIX_ERRATUM_843419),y)
-$(warning ld does not support --fix-cortex-a53-843419; kernel may be susceptible to erratum)
-  else
+  ifeq ($(CONFIG_ARM64_LD_HAS_FIX_ERRATUM_843419),y)
 LDFLAGS_vmlinux	+= --fix-cortex-a53-843419
   endif
 endif
 
-ifeq ($(CONFIG_ARM64_USE_LSE_ATOMICS), y)
-  ifneq ($(CONFIG_ARM64_LSE_ATOMICS), y)
-$(warning LSE atomics not supported by binutils)
-  endif
-endif
-
 cc_has_k_constraint := $(call try-run,echo				\
 	'int main(void) {						\
 		asm volatile("and w0, w0, %w0" :: "K" (4294967295));	\
@@ -179,6 +171,17 @@ vdso_install:
 
 archprepare:
 	$(Q)$(MAKE) $(build)=arch/arm64/tools kapi
+ifeq ($(CONFIG_ARM64_ERRATUM_843419),y)
+  ifneq ($(CONFIG_ARM64_LD_HAS_FIX_ERRATUM_843419),y)
+	@echo "warning: ld does not support --fix-cortex-a53-843419; kernel may be susceptible to erratum" >&2
+  endif
+endif
+ifeq ($(CONFIG_ARM64_USE_LSE_ATOMICS),y)
+  ifneq ($(CONFIG_ARM64_LSE_ATOMICS),y)
+	@echo "warning: LSE atomics not supported by binutils" >&2
+  endif
+endif
+
 
 # We use MRPROPER_FILES and CLEAN_FILES now
 archclean:
-- 
2.27.0

