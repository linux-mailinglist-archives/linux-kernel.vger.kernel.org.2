Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503D237F017
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 01:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbhELXpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 19:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242436AbhELXnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 19:43:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CF4361405;
        Wed, 12 May 2021 23:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620862963;
        bh=bBPSkdJClvqx7hJbv2Uw+r6yTupo3DEBhnSqx77Z9G0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k6cWidD1WqlrCWf3BPzMKbY9Da1paqsrfqW0ThwCybJFtN7GSys0CNK/rOnPchazW
         W6L9ys4B2N1XmMQ5xk9wK/mVBtxiunERZWkcOFX1uraaA02imNBV9Bi/5fFyl9nXTv
         OypVTvGv5BKnGPc/uQVshTzH/qSVnYmJfundS5eLDePsjQ+A5QhAHeyu8N7gUwNTQQ
         9uTDsQzstzrr1b6Kl+y9r3SvjtNaCppB7T4dPEHF+pz8BI9ML86mHwDkAAsQ/DcpjD
         ZWIkI7upMu7JvWMH8pamr4BB1+c0ncC10LoI7tz//g+HkJStA8x7i1L7VI67Rg/FiV
         iLX/txjDzeCgQ==
Date:   Thu, 13 May 2021 08:42:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: arch/powerpc/kernel/optprobes.c:34:1: error: unused function
 'is_kprobe_ppc_optinsn_slot'
Message-Id: <20210513084239.3af8c2498263e7f0b233b72e@kernel.org>
In-Reply-To: <8d12be5a-d700-c0aa-86ee-ebb97927c34c@csgroup.eu>
References: <202105120059.uTLH58Lm-lkp@intel.com>
        <48747467-cb93-c66d-4cf9-097be0568488@csgroup.eu>
        <208186f3-aab0-d94e-bcf4-8347983cc1a6@kernel.org>
        <0885f8b8-fea5-3fb0-42d7-b73e862a8c47@csgroup.eu>
        <520bd3e7-ddee-bbee-0735-6aad29acb5bb@csgroup.eu>
        <20210512215057.6875aeaf67fb31495ab29987@kernel.org>
        <20210513000649.23ac7bc69e30d8b9421a6ff6@kernel.org>
        <8d12be5a-d700-c0aa-86ee-ebb97927c34c@csgroup.eu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021 17:12:32 +0200
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> 
> 
> Le 12/05/2021 à 17:06, Masami Hiramatsu a écrit :
> > On Wed, 12 May 2021 21:50:57 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> >> On Wed, 12 May 2021 11:52:30 +0200
> >> Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> > 
> >>>
> >>> Le 12/05/2021 à 11:36, Christophe Leroy a écrit :
> >>>>
> >>>>
> >>>> Le 11/05/2021 à 20:46, Nathan Chancellor a écrit :
> >>>>> On 5/11/2021 9:47 AM, Christophe Leroy wrote:
> >>>>>> Hi All,
> >>>>>>
> >>>>>> Le 11/05/2021 à 18:30, kernel test robot a écrit :
> >>>>>>> Hi Christophe,
> >>>>>>>
> >>>>>>> First bad commit (maybe != root cause):
> >>>>>>>
> >>>>>>> tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >>>>>>> head:   1140ab592e2ebf8153d2b322604031a8868ce7a5
> >>>>>>> commit: eacf4c0202654adfa94bbb17b5c5c77c0be14af8 powerpc: Enable OPTPROBES on PPC32
> >>>>
> >>>> Ok, the problem appears on PPC32 with that patch, but it must have been there on PPC64 since the
> >>>> implementation of optprobes with commit 51c9c0843993 ("powerpc/kprobes: Implement Optprobes")
> >>>>
> >>>>
> >>>>>>> date:   3 weeks ago
> >>>>>>> config: powerpc-randconfig-r033-20210511 (attached as .config)
> >>>>>>> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project
> >>>>>>> a0fed635fe1701470062495a6ffee1c608f3f1bc)
> >>>>>>
> >>>>>> A clang issue ?
> >>>>>>
> >>>>>>
> >>>>>>> reproduce (this is a W=1 build):
> >>>>>>>           wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O
> >>>>>>> ~/bin/make.cross
> >>>>>>>           chmod +x ~/bin/make.cross
> >>>>>>>           # install powerpc cross compiling tool for clang build
> >>>>>>>           # apt-get install binutils-powerpc-linux-gnu
> >>>>>>>           #
> >>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eacf4c0202654adfa94bbb17b5c5c77c0be14af8
> >>>>>>>
> >>>>>>>           git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >>>>>>>           git fetch --no-tags linus master
> >>>>>>>           git checkout eacf4c0202654adfa94bbb17b5c5c77c0be14af8
> >>>>>>>           # save the attached .config to linux build tree
> >>>>>>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=powerpc
> >>>>>>>
> >>>>>>> If you fix the issue, kindly add following tag as appropriate
> >>>>>>> Reported-by: kernel test robot <lkp@intel.com>
> >>>>>>>
> >>>>>>> All errors (new ones prefixed by >>):
> >>>>>>>
> >>>>>>>>> arch/powerpc/kernel/optprobes.c:34:1: error: unused function 'is_kprobe_ppc_optinsn_slot'
> >>>>>>>>> [-Werror,-Wunused-function]
> >>>>>>>      DEFINE_INSN_CACHE_OPS(ppc_optinsn);
> >>>>>>>      ^
> >>>>>>>      include/linux/kprobes.h:306:20: note: expanded from macro 'DEFINE_INSN_CACHE_OPS'
> >>>>>>>      static inline bool is_kprobe_##__name##_slot(unsigned long addr)        \
> >>>>>>
> >>>>>> That's a 'static inline', shouldn't generate an 'unused function' warning.
> >>>>> This is a W=1 build, which means that "inline" does not silence unused function warnings with
> >>>>> clang because of commit 6863f5643dd7 ("kbuild: allow Clang to find unused static inline functions
> >>>>> for W=1 build").
> >>>>
> >>>> Ok, I didn't know that.
> >>>
> >>> After looking at it in more details, I don't really know what should be done to avoid that.
> >>
> >> Ah, thanks for reporting!
> >>
> >>>
> >>> This unused function is defined as part of DEFINE_INSN_CACHE_OPS(ppc_optinsn).
> >>>
> >>> The code uses other items defined by macro DEFINE_INSN_CACHE_OPS, so it cannot be removed.
> >>>
> >>> Solution could be to hide that in a .h, but is that worth it ?
> >>
> >> The best solution is to remove ppc_optinsn, but that is defined in kernel/kprobes.c
> >> just because page allocation is different.
> >> I think the easiest fix is to add weak alloc_optinsn_page() and override it
> >> in arch/powerpc/kernel/optprobe.c.
> > 
> > Please try this patch.
> > 
> > Thank you,
> 
> 
> Yeah, look pretty similar to the two patches I sent 30 minutes ago.

Ah, I missed it.
OK, let me check.


> 
> 
> 
> > 
> >  From 7782fa154349923ed52baa8843cc1d5eed26e82d Mon Sep 17 00:00:00 2001
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> > Date: Wed, 12 May 2021 23:33:10 +0900
> > Subject: [PATCH] powerpc/kprobes: Define arch specific optinsn memory
> >   allocation
> > 
> 
> > @@ -203,14 +193,14 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
> >   	unsigned long nip, size;
> >   	int rc, i;
> >   
> > -	kprobe_ppc_optinsn_slots.insn_size = MAX_OPTINSN_SIZE;
> > +	kprobe_optinsn_slots.insn_size = MAX_OPTINSN_SIZE;
> 
> Is this still needed ? It looks like it is already done by init_kprobes() in kernel/kprobes.c

No, not needed anymore.

Thanks!

> 
> >   
> >   	nip = can_optimize(p);
> >   	if (!nip)
> >   		return -EILSEQ;
> >   
> >   	/* Allocate instruction slot for detour buffer */
> > -	buff = get_ppc_optinsn_slot();
> > +	buff = get_optinsn_slot();
> >   	if (!buff)
> >   		return -ENOMEM;
> >   
> 
> Christophe


-- 
Masami Hiramatsu <mhiramat@kernel.org>
