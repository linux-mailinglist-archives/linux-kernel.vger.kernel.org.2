Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0085C4216FB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 21:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbhJDTFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 15:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238861AbhJDTFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 15:05:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A4CC061753
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 12:04:01 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633374238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SO+cZ+YFKZSpGsGCCDK9F64VBp/Hum1Pxx9B3QO8XG8=;
        b=W786jS21HN7ePvT4f2ng3uCvWD/7WzMq+Q6s5mg48DuafLvhXBC37frG6lQRqXxE6E/pAD
        aQAUTkr5XljUY9CnTLl7ais8fe6mOACuK49M8mQT6j2j90ICdLslsqPONLNxkFwAn8MWgt
        7RrkKE4i5unnl3UjCq4PIiRzR7wVmutdcQXTcwKiy5w/wbYhhNnFv3/oxoO04ESMrgP4M9
        JTj0B0hOyg0Xv9UFdowiHN41ByTDIH9o7JiwwK6ziljLQ5aclCscdM1LdUJgmjzmo4OO0y
        UiDq0svqTuc42X3l9NLFqlubb5eNvrv/RrW2qNN82FXc41uI+rcqM/sCS02JXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633374238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SO+cZ+YFKZSpGsGCCDK9F64VBp/Hum1Pxx9B3QO8XG8=;
        b=tIrZf+dSR/+GoK1wiYTnBurxPwbF1kVp2ZVf87o+QpkaK75qk1QDvejd1DLVgznwe8dWyH
        cs3G7l4FVOqV1oCg==
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     "bp@suse.de" <bp@suse.de>, "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 13/28] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
In-Reply-To: <66A19E8A-11BF-4532-878F-A8D0935FDBC7@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
 <20210825155413.19673-14-chang.seok.bae@intel.com> <871r546b52.ffs@tglx>
 <87ee944hvj.ffs@tglx> <66A19E8A-11BF-4532-878F-A8D0935FDBC7@intel.com>
Date:   Mon, 04 Oct 2021 21:03:58 +0200
Message-ID: <87zgrofw81.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03 2021 at 22:39, Chang Seok Bae wrote:
> On Oct 1, 2021, at 13:20, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Looking at the changelog of the patch to delay XSTATE [1] load:
>
>     This gives the kernel the potential to skip loading FPU state for tasks
>     that stay in kernel mode, or for tasks that end up with repeated
>     invocations of kernel_fpu_begin() & kernel_fpu_end().

Correct.

> But I think XFD state is different from XSTATE. There is no use case for
> XFD-enabled features in kernel mode.

Correct, but your patch does not ensure that XFD features are disabled
on context switch. You write the XFD mask of the next task when it
differs frome the XFD mask of the previous task. So we have the following:

        prev XFD	next XFD
        DISABLED  	DISABLED         XFD features stay disabled
        ENABLED         DISABLED         XFD features are disabled
        DISABLED        ENABLED          XFD features are enabled
        ENABLED         ENABLED          XFD features stay enabled

So it still runs in the kernel with XFD features enabled including
interrupts, soft interupts, exceptions and NMIs. So what's the problem
when it does a user -> kernel -> user transition with the user XFD on?

> So, XFD state was considered to be switched under switch_to() just
> like other user states. E.g. user FSBASE is switched here as kernel
> does not use it.

That's not really a justification.

> But user GSBASE is loaded at returning to userspace.

And so is XSTATE

> Potentially, it is also beneficial as XFD-armed states will hold
> INIT-state [3]:
>
>     If XSAVE, XSAVEC, XSAVEOPT, or XSAVES is saving the state component i, the
>     instruction does not generate #NM when XCR0[i] = IA32_XFD[i] = 1; instead,
>     it saves bit i of XSTATE_BV field of the XSAVE header as 0 (indicating
>     that the state component is in its initialized state).

How does that matter? The point is that if the FPU registers are
unmodified then a task can return to user space without doing anything
even if it went through five context switches. So how is XFD any
different?

Where is the kernel doing XSAVE / XSAVES:

     1) On context switch which sets TIF_NEED_FPU_LOAD

        Once TIF_NEED_FPU_LOAD is set the kernel does not do XSAVES in
        the context of the task simply because it knows that the content
        is in the memory buffer.

     2) In signal handling

        Only happens when TIF_NEED_FPU_LOAD == 0

Where is the kernel doing XRSTOR / XRSTORS:

     1) On return to user space if the FPU registers are not up to date

        So this can restore XFD as well

     2) In signal handling and related functions

        Only happens when TIF_NEED_FPU_LOAD == 0

So what's the win?

No wrmsrl() on context switch, which means for the user -> kthread ->
user context switch scenario for which the register preserving is
optimized you spare two wrmsrl() invocations, run less code with less
conditionals.

What's the price?

A few trivial XFD sanity checks for debug enabled kernels to ensure that
XFD is correct on XSAVE[S] and XRSTOR[S], which have no runtime overhead
on production systems.

Even if we decide that these checks should be permanent then they happen
in code pathes which are doing a slow X* operation anyway.

Thanks,

        tglx


        
