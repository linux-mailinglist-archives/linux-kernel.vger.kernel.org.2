Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999D63F4C79
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 16:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhHWOgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 10:36:05 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:46895 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229726AbhHWOgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:36:04 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4GtZXS1SCWz9sWm;
        Mon, 23 Aug 2021 16:35:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tR-DsJezzt9w; Mon, 23 Aug 2021 16:35:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4GtZXR6SBtz9sVJ;
        Mon, 23 Aug 2021 16:35:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BC6CC8B7B7;
        Mon, 23 Aug 2021 16:35:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id O8Jtrd-PZl3w; Mon, 23 Aug 2021 16:35:19 +0200 (CEST)
Received: from [172.25.230.100] (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 776078B7B3;
        Mon, 23 Aug 2021 16:35:19 +0200 (CEST)
Subject: Re: arch/powerpc/kernel/signal_32.c:297:2: warning: Value stored to
 'msr' is never read [clang-analyzer-deadcode.DeadStores]
To:     kernel test robot <lkp@intel.com>
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
References: <202108231827.N9VUIKbD-lkp@intel.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <3db8de6e-a971-be9f-19eb-e7d95faf2870@csgroup.eu>
Date:   Mon, 23 Aug 2021 16:35:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <202108231827.N9VUIKbD-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 23/08/2021 à 12:59, kernel test robot a écrit :
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93
> commit: ef75e73182949a94bde169a774de1b62ae21fbbc powerpc/signal32: Transform save_user_regs() and save_tm_user_regs() in 'unsafe' version
> date:   9 months ago
> config: powerpc-randconfig-c003-20210821 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d9c5613e856cf2addfbf892fc4c1ce9ef9feceaa)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install powerpc cross compiling tool for clang build
>          # apt-get install binutils-powerpc-linux-gnu
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ef75e73182949a94bde169a774de1b62ae21fbbc
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout ef75e73182949a94bde169a774de1b62ae21fbbc
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc clang-analyzer
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> clang-analyzer warnings: (new ones prefixed by >>)
>             ^
>>> arch/powerpc/kernel/signal_32.c:297:2: warning: Value stored to 'msr' is never read [clang-analyzer-deadcode.DeadStores]
>             msr &= ~MSR_VSX;
>             ^      ~~~~~~~~
>     arch/powerpc/kernel/signal_32.c:297:2: note: Value stored to 'msr' is never read
>             msr &= ~MSR_VSX;
>             ^      ~~~~~~~~


This is wrong.

msr is used at line 326:

ef75e73182949a arch/powerpc/kernel/signal_32.c Christophe Leroy 2020-08-18  326 
unsafe_put_user(msr, &frame->mc_gregs[PT_MSR], failed);





>     arch/powerpc/kernel/signal_32.c:765:16: warning: Value stored to 'msr' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
>             unsigned long msr = regs->msr;
>                           ^~~   ~~~~~~~~~
>     arch/powerpc/kernel/signal_32.c:765:16: note: Value stored to 'msr' during its initialization is never read
>             unsigned long msr = regs->msr;
>                           ^~~   ~~~~~~~~~
>     arch/powerpc/kernel/signal_32.c:869:16: warning: Value stored to 'msr' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
>             unsigned long msr = regs->msr;
>                           ^~~   ~~~~~~~~~
>     arch/powerpc/kernel/signal_32.c:869:16: note: Value stored to 'msr' during its initialization is never read
>             unsigned long msr = regs->msr;
>                           ^~~   ~~~~~~~~~
> 
> vim +/msr +297 arch/powerpc/kernel/signal_32.c
> 
> 968c4fccd1bb8b arch/powerpc/kernel/signal_32.c Christophe Leroy 2020-08-18  262
> ef75e73182949a arch/powerpc/kernel/signal_32.c Christophe Leroy 2020-08-18  263  static int save_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user *frame,
> 8d33001dd650b8 arch/powerpc/kernel/signal_32.c Christophe Leroy 2020-08-18  264  				 struct mcontext __user *tm_frame, int ctx_has_vsx_region)
> ^1da177e4c3f41 arch/ppc64/kernel/signal32.c    Linus Torvalds   2005-04-16  265  {
> 9e7511861c4f8d arch/powerpc/kernel/signal_32.c Michael Neuling  2008-06-25  266  	unsigned long msr = regs->msr;
> 9e7511861c4f8d arch/powerpc/kernel/signal_32.c Michael Neuling  2008-06-25  267
> c6e6771b87d4e3 arch/powerpc/kernel/signal_32.c Michael Neuling  2008-06-25  268  	/* save general registers */
> ef75e73182949a arch/powerpc/kernel/signal_32.c Christophe Leroy 2020-08-18  269  	unsafe_save_general_regs(regs, frame, failed);
> ^1da177e4c3f41 arch/ppc64/kernel/signal32.c    Linus Torvalds   2005-04-16  270
> ^1da177e4c3f41 arch/ppc64/kernel/signal32.c    Linus Torvalds   2005-04-16  271  #ifdef CONFIG_ALTIVEC
> ^1da177e4c3f41 arch/ppc64/kernel/signal32.c    Linus Torvalds   2005-04-16  272  	/* save altivec registers */
> ^1da177e4c3f41 arch/ppc64/kernel/signal32.c    Linus Torvalds   2005-04-16  273  	if (current->thread.used_vr) {
> ef75e73182949a arch/powerpc/kernel/signal_32.c Christophe Leroy 2020-08-18  274  		unsafe_copy_to_user(&frame->mc_vregs, &current->thread.vr_state,
> ef75e73182949a arch/powerpc/kernel/signal_32.c Christophe Leroy 2020-08-18  275  				    ELF_NVRREG * sizeof(vector128), failed);
> ^1da177e4c3f41 arch/ppc64/kernel/signal32.c    Linus Torvalds   2005-04-16  276  		/* set MSR_VEC in the saved MSR value to indicate that
> ^1da177e4c3f41 arch/ppc64/kernel/signal32.c    Linus Torvalds   2005-04-16  277  		   frame->mc_vregs contains valid data */
> 9e7511861c4f8d arch/powerpc/kernel/signal_32.c Michael Neuling  2008-06-25  278  		msr |= MSR_VEC;
> ^1da177e4c3f41 arch/ppc64/kernel/signal32.c    Linus Torvalds   2005-04-16  279  	}
> ^1da177e4c3f41 arch/ppc64/kernel/signal32.c    Linus Torvalds   2005-04-16  280  	/* else assert((regs->msr & MSR_VEC) == 0) */
> ^1da177e4c3f41 arch/ppc64/kernel/signal32.c    Linus Torvalds   2005-04-16  281
> ^1da177e4c3f41 arch/ppc64/kernel/signal32.c    Linus Torvalds   2005-04-16  282  	/* We always copy to/from vrsave, it's 0 if we don't have or don't
> ^1da177e4c3f41 arch/ppc64/kernel/signal32.c    Linus Torvalds   2005-04-16  283  	 * use altivec. Since VSCR only contains 32 bits saved in the least
> ^1da177e4c3f41 arch/ppc64/kernel/signal32.c    Linus Torvalds   2005-04-16  284  	 * significant bits of a vector, we "cheat" and stuff VRSAVE in the
> ^1da177e4c3f41 arch/ppc64/kernel/signal32.c    Linus Torvalds   2005-04-16  285  	 * most significant bits of that same vector. --BenH
> 408a7e08b2112f arch/powerpc/kernel/signal_32.c Paul Mackerras   2013-08-05  286  	 * Note that the current VRSAVE value is in the SPR at this point.
> ^1da177e4c3f41 arch/ppc64/kernel/signal32.c    Linus Torvalds   2005-04-16  287  	 */
> ef75e73182949a arch/powerpc/kernel/signal_32.c Christophe Leroy 2020-08-18  288  	unsafe_put_user(current->thread.vrsave, (u32 __user *)&frame->mc_vregs[32],
> ef75e73182949a arch/powerpc/kernel/signal_32.c Christophe Leroy 2020-08-18  289  			failed);
> ^1da177e4c3f41 arch/ppc64/kernel/signal32.c    Linus Torvalds   2005-04-16  290  #endif /* CONFIG_ALTIVEC */
> ef75e73182949a arch/powerpc/kernel/signal_32.c Christophe Leroy 2020-08-18  291  	unsafe_copy_fpr_to_user(&frame->mc_fregs, current, failed);
> ec67ad82814bee arch/powerpc/kernel/signal_32.c Michael Neuling  2013-11-25  292
> ec67ad82814bee arch/powerpc/kernel/signal_32.c Michael Neuling  2013-11-25  293  	/*
> ec67ad82814bee arch/powerpc/kernel/signal_32.c Michael Neuling  2013-11-25  294  	 * Clear the MSR VSX bit to indicate there is no valid state attached
> ec67ad82814bee arch/powerpc/kernel/signal_32.c Michael Neuling  2013-11-25  295  	 * to this context, except in the specific case below where we set it.
> ec67ad82814bee arch/powerpc/kernel/signal_32.c Michael Neuling  2013-11-25  296  	 */
> ec67ad82814bee arch/powerpc/kernel/signal_32.c Michael Neuling  2013-11-25 @297  	msr &= ~MSR_VSX;
> 6a274c08f2f4df arch/powerpc/kernel/signal_32.c Michael Neuling  2008-07-02  298  #ifdef CONFIG_VSX
> ce48b2100785e5 arch/powerpc/kernel/signal_32.c Michael Neuling  2008-06-25  299  	/*
> ce48b2100785e5 arch/powerpc/kernel/signal_32.c Michael Neuling  2008-06-25  300  	 * Copy VSR 0-31 upper half from thread_struct to local
> ce48b2100785e5 arch/powerpc/kernel/signal_32.c Michael Neuling  2008-06-25  301  	 * buffer, then write that to userspace.  Also set MSR_VSX in
> ce48b2100785e5 arch/powerpc/kernel/signal_32.c Michael Neuling  2008-06-25  302  	 * the saved MSR value to indicate that frame->mc_vregs
> ce48b2100785e5 arch/powerpc/kernel/signal_32.c Michael Neuling  2008-06-25  303  	 * contains valid data
> ce48b2100785e5 arch/powerpc/kernel/signal_32.c Michael Neuling  2008-06-25  304  	 */
> 16c29d180becc5 arch/powerpc/kernel/signal_32.c Michael Neuling  2008-10-23  305  	if (current->thread.used_vsr && ctx_has_vsx_region) {
> ef75e73182949a arch/powerpc/kernel/signal_32.c Christophe Leroy 2020-08-18  306  		unsafe_copy_vsx_to_user(&frame->mc_vsregs, current, failed);
> ce48b2100785e5 arch/powerpc/kernel/signal_32.c Michael Neuling  2008-06-25  307  		msr |= MSR_VSX;
> ec67ad82814bee arch/powerpc/kernel/signal_32.c Michael Neuling  2013-11-25  308  	}
> c6e6771b87d4e3 arch/powerpc/kernel/signal_32.c Michael Neuling  2008-06-25  309  #endif /* CONFIG_VSX */
> 81e7009ea46c95 arch/powerpc/kernel/signal_32.c Stephen Rothwell 2005-10-18  310  #ifdef CONFIG_SPE
> 81e7009ea46c95 arch/powerpc/kernel/signal_32.c Stephen Rothwell 2005-10-18  311  	/* save spe registers */
> 81e7009ea46c95 arch/powerpc/kernel/signal_32.c Stephen Rothwell 2005-10-18  312  	if (current->thread.used_spe) {
> ef75e73182949a arch/powerpc/kernel/signal_32.c Christophe Leroy 2020-08-18  313  		unsafe_copy_to_user(&frame->mc_vregs, current->thread.evr,
> ef75e73182949a arch/powerpc/kernel/signal_32.c Christophe Leroy 2020-08-18  314  				    ELF_NEVRREG * sizeof(u32), failed);
> 81e7009ea46c95 arch/powerpc/kernel/signal_32.c Stephen Rothwell 2005-10-18  315  		/* set MSR_SPE in the saved MSR value to indicate that
> 81e7009ea46c95 arch/powerpc/kernel/signal_32.c Stephen Rothwell 2005-10-18  316  		   frame->mc_vregs contains valid data */
> 9e7511861c4f8d arch/powerpc/kernel/signal_32.c Michael Neuling  2008-06-25  317  		msr |= MSR_SPE;
> 81e7009ea46c95 arch/powerpc/kernel/signal_32.c Stephen Rothwell 2005-10-18  318  	}
> 81e7009ea46c95 arch/powerpc/kernel/signal_32.c Stephen Rothwell 2005-10-18  319  	/* else assert((regs->msr & MSR_SPE) == 0) */
> 81e7009ea46c95 arch/powerpc/kernel/signal_32.c Stephen Rothwell 2005-10-18  320
> 81e7009ea46c95 arch/powerpc/kernel/signal_32.c Stephen Rothwell 2005-10-18  321  	/* We always copy to/from spefscr */
> ef75e73182949a arch/powerpc/kernel/signal_32.c Christophe Leroy 2020-08-18  322  	unsafe_put_user(current->thread.spefscr,
> ef75e73182949a arch/powerpc/kernel/signal_32.c Christophe Leroy 2020-08-18  323  			(u32 __user *)&frame->mc_vregs + ELF_NEVRREG, failed);
> 81e7009ea46c95 arch/powerpc/kernel/signal_32.c Stephen Rothwell 2005-10-18  324  #endif /* CONFIG_SPE */
> 81e7009ea46c95 arch/powerpc/kernel/signal_32.c Stephen Rothwell 2005-10-18  325
> ef75e73182949a arch/powerpc/kernel/signal_32.c Christophe Leroy 2020-08-18  326  	unsafe_put_user(msr, &frame->mc_gregs[PT_MSR], failed);
> ef75e73182949a arch/powerpc/kernel/signal_32.c Christophe Leroy 2020-08-18  327
> 1d25f11fdbcc53 arch/powerpc/kernel/signal_32.c Michael Neuling  2013-06-09  328  	/* We need to write 0 the MSR top 32 bits in the tm frame so that we
> 1d25f11fdbcc53 arch/powerpc/kernel/signal_32.c Michael Neuling  2013-06-09  329  	 * can check it on the restore to see if TM is active
> 1d25f11fdbcc53 arch/powerpc/kernel/signal_32.c Michael Neuling  2013-06-09  330  	 */
> ef75e73182949a arch/powerpc/kernel/signal_32.c Christophe Leroy 2020-08-18  331  	if (tm_frame)
> ef75e73182949a arch/powerpc/kernel/signal_32.c Christophe Leroy 2020-08-18  332  		unsafe_put_user(0, &tm_frame->mc_gregs[PT_MSR], failed);
> 1d25f11fdbcc53 arch/powerpc/kernel/signal_32.c Michael Neuling  2013-06-09  333
> ^1da177e4c3f41 arch/ppc64/kernel/signal32.c    Linus Torvalds   2005-04-16  334  	return 0;
> ef75e73182949a arch/powerpc/kernel/signal_32.c Christophe Leroy 2020-08-18  335
> ef75e73182949a arch/powerpc/kernel/signal_32.c Christophe Leroy 2020-08-18  336  failed:
> ef75e73182949a arch/powerpc/kernel/signal_32.c Christophe Leroy 2020-08-18  337  	return 1;
> ^1da177e4c3f41 arch/ppc64/kernel/signal32.c    Linus Torvalds   2005-04-16  338  }
> ^1da177e4c3f41 arch/ppc64/kernel/signal32.c    Linus Torvalds   2005-04-16  339
> 
> :::::: The code at line 297 was first introduced by commit
> :::::: ec67ad82814bee92251fd963bf01c7a173856555 powerpc/signals: Improved mark VSX not saved with small contexts fix
> 
> :::::: TO: Michael Neuling <mikey@neuling.org>
> :::::: CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
