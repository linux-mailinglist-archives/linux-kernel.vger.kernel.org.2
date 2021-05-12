Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F6737BCDA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhELMwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:52:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230218AbhELMwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:52:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B2F4613CD;
        Wed, 12 May 2021 12:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823862;
        bh=F/M6uMXuZZRxtXvuO+aRLzwIVU9P+qGeSVqolMdXCEA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=osjVDqbECShh09DmGTHrCWu0gJ7gpSoYT1AP6ojbhYMCnQN3WbxD3W6OOSQdVt8oM
         AJVZEUW8oTyUhrek1VVB+Ea6DBq1xcKBSf1TFUGdN5kjiCecuXIXyueufOg0v9Sgee
         4VP0KfhXBL/RcjL6XwwsEC4tI8I+5f/9BGdjDO8Lwzi7AsSFRWEWbboG2xNdoIRlmF
         dPTJKlG6BV8pM5lMg5FFD9hK2R0TjhL008q1riXOkHxDoSojfdWDrD7MmmS4GrxTiA
         T0F3NCJO0nSlXWD14x6xGv0c6EIFIETZJENB6VZb4qs9HIsWzDtWr1XcPu0k9B7Uib
         MzEG/nwXmuftQ==
Date:   Wed, 12 May 2021 21:50:57 +0900
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
Message-Id: <20210512215057.6875aeaf67fb31495ab29987@kernel.org>
In-Reply-To: <520bd3e7-ddee-bbee-0735-6aad29acb5bb@csgroup.eu>
References: <202105120059.uTLH58Lm-lkp@intel.com>
        <48747467-cb93-c66d-4cf9-097be0568488@csgroup.eu>
        <208186f3-aab0-d94e-bcf4-8347983cc1a6@kernel.org>
        <0885f8b8-fea5-3fb0-42d7-b73e862a8c47@csgroup.eu>
        <520bd3e7-ddee-bbee-0735-6aad29acb5bb@csgroup.eu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021 11:52:30 +0200
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> 
> 
> Le 12/05/2021 à 11:36, Christophe Leroy a écrit :
> > 
> > 
> > Le 11/05/2021 à 20:46, Nathan Chancellor a écrit :
> >> On 5/11/2021 9:47 AM, Christophe Leroy wrote:
> >>> Hi All,
> >>>
> >>> Le 11/05/2021 à 18:30, kernel test robot a écrit :
> >>>> Hi Christophe,
> >>>>
> >>>> First bad commit (maybe != root cause):
> >>>>
> >>>> tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >>>> head:   1140ab592e2ebf8153d2b322604031a8868ce7a5
> >>>> commit: eacf4c0202654adfa94bbb17b5c5c77c0be14af8 powerpc: Enable OPTPROBES on PPC32
> > 
> > Ok, the problem appears on PPC32 with that patch, but it must have been there on PPC64 since the 
> > implementation of optprobes with commit 51c9c0843993 ("powerpc/kprobes: Implement Optprobes")
> > 
> > 
> >>>> date:   3 weeks ago
> >>>> config: powerpc-randconfig-r033-20210511 (attached as .config)
> >>>> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 
> >>>> a0fed635fe1701470062495a6ffee1c608f3f1bc)
> >>>
> >>> A clang issue ?
> >>>
> >>>
> >>>> reproduce (this is a W=1 build):
> >>>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O 
> >>>> ~/bin/make.cross
> >>>>          chmod +x ~/bin/make.cross
> >>>>          # install powerpc cross compiling tool for clang build
> >>>>          # apt-get install binutils-powerpc-linux-gnu
> >>>>          # 
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eacf4c0202654adfa94bbb17b5c5c77c0be14af8 
> >>>>
> >>>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >>>>          git fetch --no-tags linus master
> >>>>          git checkout eacf4c0202654adfa94bbb17b5c5c77c0be14af8
> >>>>          # save the attached .config to linux build tree
> >>>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=powerpc
> >>>>
> >>>> If you fix the issue, kindly add following tag as appropriate
> >>>> Reported-by: kernel test robot <lkp@intel.com>
> >>>>
> >>>> All errors (new ones prefixed by >>):
> >>>>
> >>>>>> arch/powerpc/kernel/optprobes.c:34:1: error: unused function 'is_kprobe_ppc_optinsn_slot' 
> >>>>>> [-Werror,-Wunused-function]
> >>>>     DEFINE_INSN_CACHE_OPS(ppc_optinsn);
> >>>>     ^
> >>>>     include/linux/kprobes.h:306:20: note: expanded from macro 'DEFINE_INSN_CACHE_OPS'
> >>>>     static inline bool is_kprobe_##__name##_slot(unsigned long addr)        \
> >>>
> >>> That's a 'static inline', shouldn't generate an 'unused function' warning.
> >> This is a W=1 build, which means that "inline" does not silence unused function warnings with 
> >> clang because of commit 6863f5643dd7 ("kbuild: allow Clang to find unused static inline functions 
> >> for W=1 build").
> > 
> > Ok, I didn't know that.
> 
> After looking at it in more details, I don't really know what should be done to avoid that.

Ah, thanks for reporting!

> 
> This unused function is defined as part of DEFINE_INSN_CACHE_OPS(ppc_optinsn).
> 
> The code uses other items defined by macro DEFINE_INSN_CACHE_OPS, so it cannot be removed.
> 
> Solution could be to hide that in a .h, but is that worth it ?

The best solution is to remove ppc_optinsn, but that is defined in kernel/kprobes.c
just because page allocation is different.
I think the easiest fix is to add weak alloc_optinsn_page() and override it
in arch/powerpc/kernel/optprobe.c.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
