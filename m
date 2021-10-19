Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF0D433D15
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 19:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhJSRNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 13:13:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhJSRNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 13:13:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1495261355;
        Tue, 19 Oct 2021 17:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634663486;
        bh=OXSJPBEh+ma3f58EanrG7rg6+apPnZurYKY98a3izVs=;
        h=From:To:Cc:Subject:Date:From;
        b=AadextmZipO+28NFjLcTV3GJZiEhsU5zS76w5R58f9JNmlnWmf5V44H4w6WNSGKoV
         m+u9TRwyXcA3YAqojteYFbrMXnLCqAWIWtu5gYacmTsH7jNqj7JnkRjTeYRPeJufOu
         3yqhDf1xdbw1VlxQfBTQ9ygcupQo7vT5C0FmxUv2IxfvwSdGBGKxO35oWk2isBtpub
         J1Bn2uO1v5UfG8dsqpGOpLTBeqVUVH/WXlRTldmM6OFBJSJXFGRiQ5b3UtubBhk64Y
         7UgDBFli5o2TgJy6nK2siH152RQLCDGY+o6KBX09uIsO4NWOFHPIFrjcxRHLBciqga
         R9ETzFuua2iCw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] [RFC] x86: avoid -mtune=atom with clang
Date:   Tue, 19 Oct 2021 19:11:08 +0200
Message-Id: <20211019171121.3510624-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The clang optimization for atom results in a large number of objtool
warnings like

  drivers/video/hdmi.o: warning: objtool: hdmi_infoframe_check()+0x74: unreachable instruction
  lib/crypto/curve25519.o: warning: objtool: init_module()+0x12: unreachable instruction
  drivers/clk/bcm/clk-iproc-armpll.o: warning: objtool: iproc_armpll_setup()+0x10c: unreachable instruction
  drivers/video/fbdev/core/cfbfillrect.o: warning: objtool: cfb_fillrect()+0xa2: unreachable instruction
  drivers/clk/bcm/clk-iproc-pll.o: warning: objtool: iproc_pll_clk_setup()+0x36d: unreachable instruction
  drivers/clk/bcm/clk-iproc-asiu.o: warning: objtool: iproc_asiu_setup()+0x2cf: unreachable instruction

and in rare cases problems with the register allocator:

  arch/x86/crypto/curve25519-x86_64.c:610:3: error: inline assembly requires more registers than available

  error: ran out of registers during register allocation

All of those can be avoided by changing the -mtune= option for
clang, leaving the -march= option unchanged. It's really a bug
that should be fxied in llvm, but it's fairly clear that the
atom optimizations are not well exercised in llvm, so not
using them is probably the safe choice regardless.

Link: https://github.com/ClangBuiltLinux/linux/issues/1483
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/Makefile        | 4 ++++
 arch/x86/Makefile_32.cpu | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 7488cfbbd2f6..4c6f92b32385 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -120,7 +120,11 @@ else
         cflags-$(CONFIG_MK8)		+= -march=k8
         cflags-$(CONFIG_MPSC)		+= -march=nocona
         cflags-$(CONFIG_MCORE2)		+= -march=core2
+ifdef CONFIG_CC_IS_CLANG
+        cflags-$(CONFIG_MATOM)		+= -march=atom -mtune=generic
+else
         cflags-$(CONFIG_MATOM)		+= -march=atom
+endif
         cflags-$(CONFIG_GENERIC_CPU)	+= -mtune=generic
         KBUILD_CFLAGS += $(cflags-y)
 
diff --git a/arch/x86/Makefile_32.cpu b/arch/x86/Makefile_32.cpu
index 94834c4b5e5e..a17b089f367c 100644
--- a/arch/x86/Makefile_32.cpu
+++ b/arch/x86/Makefile_32.cpu
@@ -33,8 +33,12 @@ cflags-$(CONFIG_MCYRIXIII)	+= $(call cc-option,-march=c3,-march=i486) $(align)
 cflags-$(CONFIG_MVIAC3_2)	+= $(call cc-option,-march=c3-2,-march=i686)
 cflags-$(CONFIG_MVIAC7)		+= -march=i686
 cflags-$(CONFIG_MCORE2)		+= -march=i686 $(call tune,core2)
+ifdef CONFIG_CC_IS_CLANG
+cflags-$(CONFIG_MATOM)		+= -march=atom -mtune=generic
+else
 cflags-$(CONFIG_MATOM)		+= $(call cc-option,-march=atom,$(call cc-option,-march=core2,-march=i686)) \
 	$(call cc-option,-mtune=atom,$(call cc-option,-mtune=generic))
+endif
 
 # AMD Elan support
 cflags-$(CONFIG_MELAN)		+= -march=i486
-- 
2.29.2

