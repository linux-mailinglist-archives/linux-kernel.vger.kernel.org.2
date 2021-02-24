Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E6532407D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbhBXPI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:08:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:50552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235882AbhBXOOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:14:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68DA064E6B;
        Wed, 24 Feb 2021 14:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614176031;
        bh=VyP3xcVVsxiIDvrvtowoCWywy5tp49rAvYkYC6TXFPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VPnVUBJdz+ChcPWRQglkQM3FdKMBLwQm+UHPr6lH8DUc6BYS9z61TVees47Z1Ss5j
         sYu9N1p8MH2p59Bh7pFY4utUYrchubFeqDEoukYvPyWDceBuqKU07XTJ3RnF4tQ6K1
         8zHMVeyjp083A6sx46z1UkIokCSEF2jI8N1sZ0Vf2gSM8nAbHCky5+ODW55aNq4Dgq
         IO0hLly2DlvIXqLSWdqWHqr6AWN0N1LLPLN3CMX19vtz8U9VCDwVsNTpSFeYAeP5Nz
         7ieWU4WteB26MqsDUUsIewlWwRWJqXIXVYWaJfM39nCShgszDl94fDCZmyiniVLooL
         AfjQtSYtk3L5A==
Date:   Wed, 24 Feb 2021 15:13:44 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?utf-8?B?77+8TWlyb3NsYXY=?= Benes <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [GIT PULL] Modules updates for v5.12
Message-ID: <YDZfGFhgZl0xBlZl@gunter>
References: <YDUibKAt5tpA1Hxs@gunter>
 <CAHk-=wipCbbXswcFvnrGae01H54dY1+XoaL+9YaiU71zGzko3Q@mail.gmail.com>
 <CAHk-=wh8vHL43v7GWK9MWrWitSmOmrEw1B0AJD9CrhBc4FvpxA@mail.gmail.com>
 <CAHk-=wiuoRKa=F3txoVHvnca+H=7gJyL3SFYwd3549v-sa0+QQ@mail.gmail.com>
 <20210223200130.GA8059@lst.de>
 <CAHk-=wj27tmZBzFRTZTAEPd6eRBzP5xCkQM+1cuSx7vzv8K4=g@mail.gmail.com>
 <CAHk-=whudLzx0zmn+xLDmC1su6DF4oMQT6uEgjDEq0RsHRsDwA@mail.gmail.com>
 <20210224075220.GA546@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210224075220.GA546@lst.de>
X-OS:   Linux gunter 5.11.0-rc4-1-default+ x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Christoph Hellwig [24/02/21 08:52 +0100]:
>On Tue, Feb 23, 2021 at 12:07:39PM -0800, Linus Torvalds wrote:
>> On Tue, Feb 23, 2021 at 12:03 PM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>> >
>> > This is unacceptably slow. If that symbol trimming takes 30% of the
>> > whole kernel build time, it needs to be fixed or removed.
>>
>> I think I'm going to mark TRIM_UNUSED_KSYMS as "depends on BROKEN".
>> There's no way I can accept that horrible overhead, and the rationale
>> for that config option is questionable at best,
>
>I think it is pretty useful for embedded setups.
>
>BROKEN seems pretty strong for something that absolutely works as
>intendended.  I guess to make you (and possibly others) not grumpy
>we just need to ensure it doesn't get pulled in by allmodconfig.
>
>So maybe just invert the symbol, default the KEEP_UNUSED_SYMBOL, and
>add a message to the helptext explaining the slowdown?

Hm, something like this maybe? (untested)

---
 From 08bc08229fc3801b1a580a07ce7ff3e806b3fe90 Mon Sep 17 00:00:00 2001
From: Jessica Yu <jeyu@kernel.org>
Date: Wed, 24 Feb 2021 14:54:09 +0100
Subject: [PATCH] Kconfig: invert TRIM_UNUSED_SYMBOLS option and rename it to
  KEEP_UNUSED_SYMBOLS

Removing CONFIG_UNUSED_SYMBOLS (commit 367948220fce "module: remove
EXPORT_UNUSED_SYMBOL*") unhid the CONFIG_TRIM_UNUSED_SYMBOLS option and
therefore it now gets automatically enabled with allyesconfig.

To prevent allyesconfig from enabling TRIM_UNUSED_SYMBOLS (which is known
to slow build times), invert the config option and name it
KEEP_UNUSED_SYMBOLS, which does the same thing as TRIM_UNUSED_SYMBOLS=n.
That way, allyesconfig will keep the previous behavior of not trimming
symbols.

Signed-off-by: Jessica Yu <jeyu@kernel.org>
---
  Makefile                            |  4 ++--
  arch/mips/configs/generic_defconfig |  2 +-
  include/asm-generic/export.h        |  2 +-
  include/linux/export.h              |  2 +-
  init/Kconfig                        | 21 +++++++++++----------
  kernel/livepatch/Kconfig            |  2 +-
  scripts/Makefile.build              |  2 +-
  7 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/Makefile b/Makefile
index b18dbc634690..23f50521e97f 100644
--- a/Makefile
+++ b/Makefile
@@ -1164,7 +1164,7 @@ vmlinux-deps := $(KBUILD_LDS) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS)
  
  # Recurse until adjust_autoksyms.sh is satisfied
  PHONY += autoksyms_recursive
-ifdef CONFIG_TRIM_UNUSED_KSYMS
+ifndef CONFIG_KEEP_UNUSED_KSYMS
  # For the kernel to actually contain only the needed exported symbols,
  # we have to build modules as well to determine what those symbols are.
  # (this can be evaluated only once include/config/auto.conf has been included)
@@ -1175,7 +1175,7 @@ autoksyms_recursive: descend modules.order
  	  "$(MAKE) -f $(srctree)/Makefile vmlinux"
  endif
  
-autoksyms_h := $(if $(CONFIG_TRIM_UNUSED_KSYMS), include/generated/autoksyms.h)
+autoksyms_h := $(if $(CONFIG_KEEP_UNUSED_KSYMS),,include/generated/autoksyms.h)
  
  quiet_cmd_autoksyms_h = GEN     $@
        cmd_autoksyms_h = mkdir -p $(dir $@); \
diff --git a/arch/mips/configs/generic_defconfig b/arch/mips/configs/generic_defconfig
index 714169e411cf..d46da28ea032 100644
--- a/arch/mips/configs/generic_defconfig
+++ b/arch/mips/configs/generic_defconfig
@@ -29,7 +29,7 @@ CONFIG_MIPS_O32_FP64_SUPPORT=y
  CONFIG_JUMP_LABEL=y
  CONFIG_MODULES=y
  CONFIG_MODULE_UNLOAD=y
-CONFIG_TRIM_UNUSED_KSYMS=y
+CONFIG_KEEP_UNUSED_KSYMS=n
  CONFIG_NET=y
  CONFIG_PACKET=y
  CONFIG_UNIX=y
diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 07a36a874dca..06d401464195 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -57,7 +57,7 @@ __kstrtab_\name:
  #endif
  .endm
  
-#if defined(CONFIG_TRIM_UNUSED_KSYMS)
+#if !defined(CONFIG_KEEP_UNUSED_KSYMS)
  
  #include <linux/kconfig.h>
  #include <generated/autoksyms.h>
diff --git a/include/linux/export.h b/include/linux/export.h
index 6271a5d9c988..449f7d15e580 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -118,7 +118,7 @@ struct kernel_symbol {
   */
  #define __EXPORT_SYMBOL(sym, sec, ns)
  
-#elif defined(CONFIG_TRIM_UNUSED_KSYMS)
+#elif !defined(CONFIG_KEEP_UNUSED_KSYMS)
  
  #include <generated/autoksyms.h>
  
diff --git a/init/Kconfig b/init/Kconfig
index ba8bd5256980..db5d00bfc239 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2272,29 +2272,30 @@ config MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
  
  	  If unsure, say N.
  
-config TRIM_UNUSED_KSYMS
-	bool "Trim unused exported kernel symbols"
-	depends on BROKEN
+config KEEP_UNUSED_KSYMS
+	bool "Keep unused exported kernel symbols"
+	default y
  	help
  	  The kernel and some modules make many symbols available for
  	  other modules to use via EXPORT_SYMBOL() and variants. Depending
  	  on the set of modules being selected in your kernel configuration,
  	  many of those exported symbols might never be used.
  
-	  This option allows for unused exported symbols to be dropped from
-	  the build. In turn, this provides the compiler more opportunities
-	  (especially when using LTO) for optimizing the code and reducing
-	  binary size.  This might have some security advantages as well.
+	  This option allows for unused exported symbols to be kept in the
+	  build. Say N when you want to trim unused symbols from the build,
+	  which provides the compiler more opportunities (especially when using LTO)
+	  for optimizing the code and reducing binary size. This might have some
+	  security advantages as well.
  
-	  If unsure, or if you need to build out-of-tree modules, say N.
+	  If unsure, or if you need to build out-of-tree modules, say Y.
  
  config UNUSED_KSYMS_WHITELIST
  	string "Whitelist of symbols to keep in ksymtab"
-	depends on TRIM_UNUSED_KSYMS
+	depends on !KEEP_UNUSED_KSYMS
  	default "scripts/lto-used-symbollist.txt" if LTO_CLANG
  	help
  	  By default, all unused exported symbols will be un-exported from the
-	  build when TRIM_UNUSED_KSYMS is selected.
+	  build when KEEP_UNUSED_KSYMS is not selected.
  
  	  UNUSED_KSYMS_WHITELIST allows to whitelist symbols that must be kept
  	  exported at all times, even in absence of in-tree users. The value to
diff --git a/kernel/livepatch/Kconfig b/kernel/livepatch/Kconfig
index 53d51ed619a3..df8ebb7984e1 100644
--- a/kernel/livepatch/Kconfig
+++ b/kernel/livepatch/Kconfig
@@ -11,7 +11,7 @@ config LIVEPATCH
  	depends on SYSFS
  	depends on KALLSYMS_ALL
  	depends on HAVE_LIVEPATCH
-	depends on !TRIM_UNUSED_KSYMS
+	depends on KEEP_UNUSED_KSYMS
  	help
  	  Say Y here if you want to support kernel live patching.
  	  This option has no runtime impact until a kernel "patch"
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 3f6bf0ea7c0e..e5e95a6948a7 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -242,7 +242,7 @@ objtool_dep = $(objtool_obj)					\
  	      $(wildcard include/config/orc/unwinder.h		\
  			 include/config/stack/validation.h)
  
-ifdef CONFIG_TRIM_UNUSED_KSYMS
+ifndef CONFIG_KEEP_UNUSED_KSYMS
  cmd_gen_ksymdeps = \
  	$(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ >> $(dot-target).cmd
  
