Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036FF39E79B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 21:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhFGTl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 15:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhFGTlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 15:41:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A946FC061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 12:39:30 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b4f0088b5a9d37dea41e8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:4f00:88b5:a9d3:7dea:41e8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A7F3D1EC04DB;
        Mon,  7 Jun 2021 21:39:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623094767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DoLt7QiSt+BfyWY4kFZ5H1JanvQb4QpboBfjcHeZKnw=;
        b=qByJzw2IWPtqPLgD2NSmBHjk1YjNe8iQU0O/yQx1jroKyIlMPKJB7kaRAKv8rNtekOAZme
        erqLxr7wYGBVaeuwE0JLzHjtMcpe8u0pn7ZTRVt9S0CuotCZF/SzI4/q/UoFAMpyVSkP/q
        Cdu79dEVmAfqpcATwEM7vMTmGKzuWiQ=
Date:   Mon, 7 Jun 2021 21:39:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V2 06/14] x86/fpu: Sanitize xstateregs_set()
Message-ID: <YL516gIGRBw1Ahcw@zn.tnic>
References: <20210605234742.712464974@linutronix.de>
 <20210606001323.528989427@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210606001323.528989427@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2021 at 01:47:48AM +0200, Thomas Gleixner wrote:
> xstateregs_set() operates on a stopped task and tries to copy the provided
> buffer into the tasks fpu.state.xsave buffer.
> 
> Any error while copying or invalid state detected after copying results in
> wiping the target tasks FPU state completely including supervisor states.

Again, "task's" in both above pls.

> That's just wrong. The caller supplied invalid data or has a problem with
> unmapped memory, so there is absolutely no justification to wreckage the

Yeah, as amluto already pointed out "wreck the target".

> target.
> 
> Fix this with the following modifications:
> 
>  1) If data has to be copied from userspace, allocate a buffer and copy from
>     user first.
> 
>  2) Use copy_kernel_to_xstate() unconditionally so that header checking
>     works correctly.
> 
>  3) Return on error without wreckaging the target state.

"wrecking"

> 
> This prevents corrupting supervisor states and lets the caller deal with
> the problem it caused in the first place.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: Move the validate_user_xstate_header() static here - Borislav
>     Use copy_from_user() - Dave, Yu
>     Rename xbuf to tmpbuf - Borislav
> ---
>  arch/x86/include/asm/fpu/xstate.h |    4 ---
>  arch/x86/kernel/fpu/regset.c      |   41 +++++++++++++++-----------------------
>  arch/x86/kernel/fpu/xstate.c      |   12 ++++++-----
>  3 files changed, 24 insertions(+), 33 deletions(-)
> 
> --- a/arch/x86/include/asm/fpu/xstate.h
> +++ b/arch/x86/include/asm/fpu/xstate.h
> @@ -112,8 +112,4 @@ void copy_supervisor_to_kernel(struct xr
>  void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
>  void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask);
>  
> -
> -/* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
> -int validate_user_xstate_header(const struct xstate_header *hdr);
> -
>  #endif
> --- a/arch/x86/kernel/fpu/regset.c
> +++ b/arch/x86/kernel/fpu/regset.c
> @@ -6,8 +6,12 @@
>  #include <asm/fpu/signal.h>
>  #include <asm/fpu/regset.h>
>  #include <asm/fpu/xstate.h>
> +
> +#include <linux/vmalloc.h>
> +
>  #include <linux/sched/task_stack.h>

I think the linux/ namespace headers come first and then the asm/ ones.

IOW, this:

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index cc49078b74ce..cfa242d54a26 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -2,16 +2,15 @@
 /*
  * FPU register's regset abstraction, for ptrace, core dumps, etc.
  */
+
+#include <linux/sched/task_stack.h>
+#include <linux/vmalloc.h>
+
 #include <asm/fpu/internal.h>
 #include <asm/fpu/signal.h>
 #include <asm/fpu/regset.h>
 #include <asm/fpu/xstate.h>
 
-#include <linux/vmalloc.h>
-
-#include <linux/sched/task_stack.h>
-
-
 /*
  * The xstateregs_active() routine is the same as the regset_fpregs_active() routine,
  * as the "regset->n" for the xstate regset will be updated based on the feature


>   * The xstateregs_active() routine is the same as the regset_fpregs_active() routine,
>   * as the "regset->n" for the xstate regset will be updated based on the feature
> @@ -108,7 +112,7 @@ int xstateregs_set(struct task_struct *t
>  		  const void *kbuf, const void __user *ubuf)
>  {
>  	struct fpu *fpu = &target->thread.fpu;
> -	struct xregs_state *xsave;
> +	struct xregs_state *tmpbuf = NULL;
>  	int ret;
>  
>  	if (!boot_cpu_has(X86_FEATURE_XSAVE))

Can we sneak in a switch to cpu_feature_enabled() too, while at it?

> @@ -120,32 +124,21 @@ int xstateregs_set(struct task_struct *t
>  	if (pos != 0 || count != fpu_user_xstate_size)
>  		return -EFAULT;
>  
> -	xsave = &fpu->state.xsave;
> -
> -	fpu__prepare_write(fpu);
> -
> -	if (using_compacted_format()) {
> -		if (kbuf)
> -			ret = copy_kernel_to_xstate(xsave, kbuf);
> -		else
> -			ret = copy_user_to_xstate(xsave, ubuf);
> -	} else {
> -		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, xsave, 0, -1);
> -		if (!ret)
> -			ret = validate_user_xstate_header(&xsave->header);
> +	if (!kbuf) {
> +		tmpbuf = vmalloc(count);
> +		if (!tmpbuf)
> +			return -ENOMEM;

<---- newline here to split the vmalloc error handling from the next
step.

>  /*
> - * Convert from a ptrace or sigreturn standard-format user-space buffer to
> - * kernel XSAVES format and copy to the target thread. This is called from
> - * xstateregs_set(), as well as potentially from the sigreturn() and
> - * rt_sigreturn() system calls.
> + * Convert from a sigreturn standard-format user-space buffer to kernel

to compacted format.

> + * XSAVES format and copy to the target thread. This is called from the
> + * sigreturn() and rt_sigreturn() system calls.
>   */
>  int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
>  {
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
