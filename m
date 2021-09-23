Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEAF416262
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 17:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242114AbhIWPuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232190AbhIWPsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:48:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99F05610A0;
        Thu, 23 Sep 2021 15:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632411972;
        bh=afMPfkpCLeQq8KQG8vaAXZcp6/3h0TGufod88IrBv6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f6n42aRGEh3yIBpCHGgPRwa14dKOrDYZp9Pd+dHBzXCEyg2A3909ZGbYGOVXffVr/
         nZWfziXeoeoXjiUK/C5tOiFTBHTlJ2HZl/sUxVHCWI4npkzOIXXOTXt+TBwAxoYUOs
         kg9td8q7+3Ub7F7svItGSNRH5wm1qak6snEwS6GHHiTknlBHC7belXXLZqnW90BNhp
         MYtal4Xv0cmXXeJl4Itj8ZgHG2oqrdu5AMqWlEzLidhwSmK45jLKPQs0gKpJ4G8QK3
         wlHsckAiHj0J1UDULcaoaSvwime3QcocbP3/RLHhtAQAEZs/QEj/M7psl88oyJLOGm
         WlJea8uf8A/pw==
Date:   Thu, 23 Sep 2021 08:46:06 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>,
        linux-kernel@vger.kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Rik van Riel <riel@surriel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: next/master bisection: baseline.login on minnowboard-turbot-E3826
Message-ID: <YUyhPqPDfmSOI3+m@archlinux-ax161>
References: <614c7bae.1c69fb81.6c8f4.489e@mx.google.com>
 <9dc8c966-9a34-6d8d-b8da-640aec33eea9@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dc8c966-9a34-6d8d-b8da-640aec33eea9@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guillaume,

On Thu, Sep 23, 2021 at 04:38:52PM +0100, Guillaume Tucker wrote:
> Hi Thomas,
> 
> Please see the bisection report below about a kernel panic on
> minnowboard-turbot-E3826 right after starting init.
> 
> Reports aren't automatically sent to the public while we're
> trialing new bisection features on kernelci.org but this one
> looks valid.
> 
> Some more details can be found here:
> 
>   https://linux.kernelci.org/test/case/id/614c1a1e98c5ed9ffc99a2e9/
> 
> The same issue appears to be reproducible with QEMU:
> 
>   https://linux.kernelci.org/test/case/id/614c71a50d39b53eee99a2f8/
> 
> Please let us know if you need help debugging the issue or if you
> have a fix to try.
> 
> Best wishes,
> Guillaume
> 
> 
> GitHub: https://github.com/kernelci/kernelci-project/issues/53

I believe this should be fixed with
https://git.kernel.org/tip/724fc0248d450224b19ef5b5ee41e392348f6704,
multiple CI systems tripped over it.

Cheers,
Nathan

> On 23/09/2021 14:05, KernelCI bot wrote:
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > * This automated bisection report was sent to you on the basis  *
> > * that you may be involved with the breaking commit it has      *
> > * found.  No manual investigation has been done to verify it,   *
> > * and the root cause of the problem may be somewhere else.      *
> > *                                                               *
> > * If you do send a fix, please include this trailer:            *
> > *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> > *                                                               *
> > * Hope this helps!                                              *
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > 
> > next/master bisection: baseline.login on minnowboard-turbot-E3826
> > 
> > Summary:
> >   Start:      bc5aa70f2699 Add linux-next specific files for 20210923
> >   Plain log:  https://storage.kernelci.org/next/master/next-20210923/x86_64/x86_64_defconfig/clang-12/lab-collabora/baseline-minnowboard-turbot-E3826.txt
> >   HTML log:   https://storage.kernelci.org/next/master/next-20210923/x86_64/x86_64_defconfig/clang-12/lab-collabora/baseline-minnowboard-turbot-E3826.html
> >   Result:     2af07f3a6e9f x86/fpu/signal: Change return type of copy_fpregs_to_sigframe() helpers to boolean
> > 
> > Checks:
> >   revert:     PASS
> >   verify:     PASS
> > 
> > Parameters:
> >   Tree:       next
> >   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> >   Branch:     master
> >   Target:     minnowboard-turbot-E3826
> >   CPU arch:   x86_64
> >   Lab:        lab-collabora
> >   Compiler:   clang-12
> >   Config:     x86_64_defconfig
> >   Test case:  baseline.login
> > 
> > Breaking commit found:
> > 
> > -------------------------------------------------------------------------------
> > commit 2af07f3a6e9fb81331421ca24b26a96180d792dd
> > Author: Thomas Gleixner <tglx@linutronix.de>
> > Date:   Wed Sep 8 15:29:34 2021 +0200
> > 
> >     x86/fpu/signal: Change return type of copy_fpregs_to_sigframe() helpers to boolean
> >     
> >     Now that copy_fpregs_to_sigframe() returns boolean the individual return
> >     codes in the related helper functions do not make sense anymore. Change
> >     them to return boolean success/fail.
> >     
> >     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> >     Signed-off-by: Borislav Petkov <bp@suse.de>
> >     Link: https://lkml.kernel.org/r/20210908132525.794334915@linutronix.de
> > 
> > diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> > index 7ce396dcc942..1d10fe9b5b6b 100644
> > --- a/arch/x86/kernel/fpu/signal.c
> > +++ b/arch/x86/kernel/fpu/signal.c
> > @@ -65,7 +65,7 @@ static inline int check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
> >  /*
> >   * Signal frame handlers.
> >   */
> > -static inline int save_fsave_header(struct task_struct *tsk, void __user *buf)
> > +static inline bool save_fsave_header(struct task_struct *tsk, void __user *buf)
> >  {
> >  	if (use_fxsr()) {
> >  		struct xregs_state *xsave = &tsk->thread.fpu.state.xsave;
> > @@ -82,18 +82,19 @@ static inline int save_fsave_header(struct task_struct *tsk, void __user *buf)
> >  		if (__copy_to_user(buf, &env, sizeof(env)) ||
> >  		    __put_user(xsave->i387.swd, &fp->status) ||
> >  		    __put_user(X86_FXSR_MAGIC, &fp->magic))
> > -			return -1;
> > +			return false;
> >  	} else {
> >  		struct fregs_state __user *fp = buf;
> >  		u32 swd;
> > +
> >  		if (__get_user(swd, &fp->swd) || __put_user(swd, &fp->status))
> > -			return -1;
> > +			return false;
> >  	}
> >  
> > -	return 0;
> > +	return true;
> >  }
> >  
> > -static inline int save_xstate_epilog(void __user *buf, int ia32_frame)
> > +static inline bool save_xstate_epilog(void __user *buf, int ia32_frame)
> >  {
> >  	struct xregs_state __user *x = buf;
> >  	struct _fpx_sw_bytes *sw_bytes;
> > @@ -131,7 +132,7 @@ static inline int save_xstate_epilog(void __user *buf, int ia32_frame)
> >  
> >  	err |= __put_user(xfeatures, (__u32 __user *)&x->header.xfeatures);
> >  
> > -	return err;
> > +	return !err;
> >  }
> >  
> >  static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
> > @@ -218,10 +219,10 @@ bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
> >  	}
> >  
> >  	/* Save the fsave header for the 32-bit frames. */
> > -	if ((ia32_fxstate || !use_fxsr()) && save_fsave_header(tsk, buf))
> > +	if ((ia32_fxstate || !use_fxsr()) && !save_fsave_header(tsk, buf))
> >  		return false;
> >  
> > -	if (use_fxsr() && save_xstate_epilog(buf_fx, ia32_fxstate))
> > +	if (use_fxsr() && !save_xstate_epilog(buf_fx, ia32_fxstate))
> >  		return false;
> >  
> >  	return true;
> > -------------------------------------------------------------------------------
> > 
> > 
> > Git bisection log:
> > 
> > -------------------------------------------------------------------------------
> > git bisect start
> > # good: [58e2cf5d794616b84f591d4d1276c8953278ce24] init: Revert accidental changes to print irqs_disabled()
> > git bisect good 58e2cf5d794616b84f591d4d1276c8953278ce24
> > # bad: [bc5aa70f26995791074a00da8b57ead3a9c1a646] Add linux-next specific files for 20210923
> > git bisect bad bc5aa70f26995791074a00da8b57ead3a9c1a646
> > # good: [18b9b2db40708ef6bbcaa9b8d8d10b7bb21e26e6] Merge branch 'nand/next' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
> > git bisect good 18b9b2db40708ef6bbcaa9b8d8d10b7bb21e26e6
> > # bad: [bcb42fa2db7240d8167cb1e7179f6377e468145e] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git
> > git bisect bad bcb42fa2db7240d8167cb1e7179f6377e468145e
> > # good: [c1d789f5e5155df5f629b95d93ac830fd7de97d6] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
> > git bisect good c1d789f5e5155df5f629b95d93ac830fd7de97d6
> > # good: [ba8b54a3a086472c81ba2b4cda62dbd4adab45f6] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
> > git bisect good ba8b54a3a086472c81ba2b4cda62dbd4adab45f6
> > # bad: [dcb7b66df80dc908f7dded6e8839093169e56a7b] Merge branch 'tip-x86-misc' into tip-auto-latest
> > git bisect bad dcb7b66df80dc908f7dded6e8839093169e56a7b
> > # good: [ccb4a51cd81f7ab035ba25df2c46f6f3c79f180d] Merge branch 'sched/core'
> > git bisect good ccb4a51cd81f7ab035ba25df2c46f6f3c79f180d
> > # bad: [1acd24c77ba4ec1f141f5175d19ae7275ce311d0] Merge branch 'x86/fpu'
> > git bisect bad 1acd24c77ba4ec1f141f5175d19ae7275ce311d0
> > # good: [fcfb7163329ce832aafef31f26345ef5e8642a17] x86/fpu/signal: Move xstate clearing out of copy_fpregs_to_sigframe()
> > git bisect good fcfb7163329ce832aafef31f26345ef5e8642a17
> > # bad: [be0040144152ed834c369a7830487e5ee4f27080] x86/fpu/signal: Change return code of check_xstate_in_sigframe() to boolean
> > git bisect bad be0040144152ed834c369a7830487e5ee4f27080
> > # bad: [ee4ecdfbd28954086a09740dc931c10c93e39370] x86/signal: Change return type of restore_sigcontext() to boolean
> > git bisect bad ee4ecdfbd28954086a09740dc931c10c93e39370
> > # bad: [2af07f3a6e9fb81331421ca24b26a96180d792dd] x86/fpu/signal: Change return type of copy_fpregs_to_sigframe() helpers to boolean
> > git bisect bad 2af07f3a6e9fb81331421ca24b26a96180d792dd
> > # good: [052adee668284b67105375c0a524f16a423f1424] x86/fpu/signal: Change return type of copy_fpstate_to_sigframe() to boolean
> > git bisect good 052adee668284b67105375c0a524f16a423f1424
> > # first bad commit: [2af07f3a6e9fb81331421ca24b26a96180d792dd] x86/fpu/signal: Change return type of copy_fpregs_to_sigframe() helpers to boolean
> > -------------------------------------------------------------------------------
> 
