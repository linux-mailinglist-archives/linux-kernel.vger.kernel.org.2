Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3DA37C520
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 17:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhELPiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 11:38:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234421AbhELPQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:16:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1B6A61988;
        Wed, 12 May 2021 15:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620832014;
        bh=jdXoqO7aS1PfeihTyGQuH3yZSYGL53phwEtYSgzbKFs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DF3OTSiM1z2LcLOJfSKr2mxC7nEjBgYYDVdtpdcZzQaOuUc6G/urYmiM6ZOT21JXR
         7kkfNzcmPBWgnAVCu/Ri89m7QPsdrOtMvhbKJ50bxHX2gheend+O1ZU2y5zXtb9tQm
         Hnuw+nSD8lTKlbGrjFpIMZB9VjrskykrPNzL9II+WVeYDLNNtJzQQcGJw4PYe1jfo5
         fUbh/0O3shLWPE4LOuMLJ2Dmi9/PCZJ44jsMZmeCCZ5xH/wE6RkLwxarouSUtwzaFW
         QkTwd7ClUVaB/fnjnLg3PL5tT+Z0p1tb/yHGXkXN9ZXV6ujCviVP9i2fh6RVpH4HWt
         5np6owxSPNxVw==
Date:   Thu, 13 May 2021 00:06:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: arch/powerpc/kernel/optprobes.c:34:1: error: unused function
 'is_kprobe_ppc_optinsn_slot'
Message-Id: <20210513000649.23ac7bc69e30d8b9421a6ff6@kernel.org>
In-Reply-To: <20210512215057.6875aeaf67fb31495ab29987@kernel.org>
References: <202105120059.uTLH58Lm-lkp@intel.com>
        <48747467-cb93-c66d-4cf9-097be0568488@csgroup.eu>
        <208186f3-aab0-d94e-bcf4-8347983cc1a6@kernel.org>
        <0885f8b8-fea5-3fb0-42d7-b73e862a8c47@csgroup.eu>
        <520bd3e7-ddee-bbee-0735-6aad29acb5bb@csgroup.eu>
        <20210512215057.6875aeaf67fb31495ab29987@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021 21:50:57 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Wed, 12 May 2021 11:52:30 +0200
> Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> > 
> > Le 12/05/2021 à 11:36, Christophe Leroy a écrit :
> > > 
> > > 
> > > Le 11/05/2021 à 20:46, Nathan Chancellor a écrit :
> > >> On 5/11/2021 9:47 AM, Christophe Leroy wrote:
> > >>> Hi All,
> > >>>
> > >>> Le 11/05/2021 à 18:30, kernel test robot a écrit :
> > >>>> Hi Christophe,
> > >>>>
> > >>>> First bad commit (maybe != root cause):
> > >>>>
> > >>>> tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > >>>> head:   1140ab592e2ebf8153d2b322604031a8868ce7a5
> > >>>> commit: eacf4c0202654adfa94bbb17b5c5c77c0be14af8 powerpc: Enable OPTPROBES on PPC32
> > > 
> > > Ok, the problem appears on PPC32 with that patch, but it must have been there on PPC64 since the 
> > > implementation of optprobes with commit 51c9c0843993 ("powerpc/kprobes: Implement Optprobes")
> > > 
> > > 
> > >>>> date:   3 weeks ago
> > >>>> config: powerpc-randconfig-r033-20210511 (attached as .config)
> > >>>> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 
> > >>>> a0fed635fe1701470062495a6ffee1c608f3f1bc)
> > >>>
> > >>> A clang issue ?
> > >>>
> > >>>
> > >>>> reproduce (this is a W=1 build):
> > >>>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O 
> > >>>> ~/bin/make.cross
> > >>>>          chmod +x ~/bin/make.cross
> > >>>>          # install powerpc cross compiling tool for clang build
> > >>>>          # apt-get install binutils-powerpc-linux-gnu
> > >>>>          # 
> > >>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eacf4c0202654adfa94bbb17b5c5c77c0be14af8 
> > >>>>
> > >>>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >>>>          git fetch --no-tags linus master
> > >>>>          git checkout eacf4c0202654adfa94bbb17b5c5c77c0be14af8
> > >>>>          # save the attached .config to linux build tree
> > >>>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=powerpc
> > >>>>
> > >>>> If you fix the issue, kindly add following tag as appropriate
> > >>>> Reported-by: kernel test robot <lkp@intel.com>
> > >>>>
> > >>>> All errors (new ones prefixed by >>):
> > >>>>
> > >>>>>> arch/powerpc/kernel/optprobes.c:34:1: error: unused function 'is_kprobe_ppc_optinsn_slot' 
> > >>>>>> [-Werror,-Wunused-function]
> > >>>>     DEFINE_INSN_CACHE_OPS(ppc_optinsn);
> > >>>>     ^
> > >>>>     include/linux/kprobes.h:306:20: note: expanded from macro 'DEFINE_INSN_CACHE_OPS'
> > >>>>     static inline bool is_kprobe_##__name##_slot(unsigned long addr)        \
> > >>>
> > >>> That's a 'static inline', shouldn't generate an 'unused function' warning.
> > >> This is a W=1 build, which means that "inline" does not silence unused function warnings with 
> > >> clang because of commit 6863f5643dd7 ("kbuild: allow Clang to find unused static inline functions 
> > >> for W=1 build").
> > > 
> > > Ok, I didn't know that.
> > 
> > After looking at it in more details, I don't really know what should be done to avoid that.
> 
> Ah, thanks for reporting!
> 
> > 
> > This unused function is defined as part of DEFINE_INSN_CACHE_OPS(ppc_optinsn).
> > 
> > The code uses other items defined by macro DEFINE_INSN_CACHE_OPS, so it cannot be removed.
> > 
> > Solution could be to hide that in a .h, but is that worth it ?
> 
> The best solution is to remove ppc_optinsn, but that is defined in kernel/kprobes.c
> just because page allocation is different.
> I think the easiest fix is to add weak alloc_optinsn_page() and override it
> in arch/powerpc/kernel/optprobe.c.

Please try this patch.

Thank you,

From 7782fa154349923ed52baa8843cc1d5eed26e82d Mon Sep 17 00:00:00 2001
From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Wed, 12 May 2021 23:33:10 +0900
Subject: [PATCH] powerpc/kprobes: Define arch specific optinsn memory
 allocation

Define arch specific optinsn memory allocate functions
instead of using arch specific ppc_optinsn_slot.

This fixes the unused function warning on is_kprobe_ppc_optinsn_slot()
when building with W=1 and also this makes kernel_text_address()
works correctly on optinsn page.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/powerpc/kernel/optprobes.c | 24 +++++++-----------------
 kernel/kprobes.c                | 15 +++++++++++++--
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
index cdf87086fa33..aa017ccbd66e 100644
--- a/arch/powerpc/kernel/optprobes.c
+++ b/arch/powerpc/kernel/optprobes.c
@@ -31,11 +31,10 @@
 #define TMPL_END_IDX		\
 	(optprobe_template_end - optprobe_template_entry)
 
-DEFINE_INSN_CACHE_OPS(ppc_optinsn);
-
 static bool insn_page_in_use;
 
-static void *__ppc_alloc_insn_page(void)
+/* Override optinsn page allocation */
+void *alloc_optinsn_page(void)
 {
 	if (insn_page_in_use)
 		return NULL;
@@ -43,20 +42,11 @@ static void *__ppc_alloc_insn_page(void)
 	return &optinsn_slot;
 }
 
-static void __ppc_free_insn_page(void *page __maybe_unused)
+void free_optinsn_page(void *page __maybe_unused)
 {
 	insn_page_in_use = false;
 }
 
-struct kprobe_insn_cache kprobe_ppc_optinsn_slots = {
-	.mutex = __MUTEX_INITIALIZER(kprobe_ppc_optinsn_slots.mutex),
-	.pages = LIST_HEAD_INIT(kprobe_ppc_optinsn_slots.pages),
-	/* insn_size initialized later */
-	.alloc = __ppc_alloc_insn_page,
-	.free = __ppc_free_insn_page,
-	.nr_garbage = 0,
-};
-
 /*
  * Check if we can optimize this probe. Returns NIP post-emulation if this can
  * be optimized and 0 otherwise.
@@ -136,7 +126,7 @@ NOKPROBE_SYMBOL(optimized_callback);
 void arch_remove_optimized_kprobe(struct optimized_kprobe *op)
 {
 	if (op->optinsn.insn) {
-		free_ppc_optinsn_slot(op->optinsn.insn, 1);
+		free_optinsn_slot(op->optinsn.insn, 1);
 		op->optinsn.insn = NULL;
 	}
 }
@@ -203,14 +193,14 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
 	unsigned long nip, size;
 	int rc, i;
 
-	kprobe_ppc_optinsn_slots.insn_size = MAX_OPTINSN_SIZE;
+	kprobe_optinsn_slots.insn_size = MAX_OPTINSN_SIZE;
 
 	nip = can_optimize(p);
 	if (!nip)
 		return -EILSEQ;
 
 	/* Allocate instruction slot for detour buffer */
-	buff = get_ppc_optinsn_slot();
+	buff = get_optinsn_slot();
 	if (!buff)
 		return -ENOMEM;
 
@@ -297,7 +287,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
 	return 0;
 
 error:
-	free_ppc_optinsn_slot(buff, 0);
+	free_optinsn_slot(buff, 0);
 	return -ERANGE;
 
 }
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 745f08fdd7a6..251fcb9d6c4c 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -321,11 +321,22 @@ int kprobe_cache_get_kallsym(struct kprobe_insn_cache *c, unsigned int *symnum,
 }
 
 #ifdef CONFIG_OPTPROBES
+
+void * __weak alloc_optinsn_page(void)
+{
+	return alloc_insn_page();
+}
+
+void __weak free_optinsn_page(void *page)
+{
+	free_insn_page(page);
+}
+
 /* For optimized_kprobe buffer */
 struct kprobe_insn_cache kprobe_optinsn_slots = {
 	.mutex = __MUTEX_INITIALIZER(kprobe_optinsn_slots.mutex),
-	.alloc = alloc_insn_page,
-	.free = free_insn_page,
+	.alloc = alloc_optinsn_page,
+	.free = free_optinsn_page,
 	.sym = KPROBE_OPTINSN_PAGE_SYM,
 	.pages = LIST_HEAD_INIT(kprobe_optinsn_slots.pages),
 	/* .insn_size is initialized later */
-- 
2.25.1
