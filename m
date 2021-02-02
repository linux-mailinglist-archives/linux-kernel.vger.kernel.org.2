Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12AF30BD3E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 12:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhBBLff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 06:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhBBLdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:33:41 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4F0C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 03:33:00 -0800 (PST)
Received: from zn.tnic (p200300ec2f0e1f00bc090c6ff424f9e7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:1f00:bc09:c6f:f424:f9e7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 61CC51EC04E2;
        Tue,  2 Feb 2021 12:32:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612265578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rdYkgh9wRGgkIpySOCNnG7YjbLsqjRNoPSeiXty+P6M=;
        b=eK4zfsQJRAcv6GNBwXPwg7dMuNVLD85jMZOd8By/vgLOBqjuNy6cKl9uVeNHEUosq5QUgN
        8zKNQQuSWlv2CyDCdHO6INccKtF/zAMRERkFDtMBCZF1pvT5Tg6PoDQr3geXm+z2uvH4bA
        e0eAxOkrXvrKR1Xrw3bFwQxJ/pMyruw=
Date:   Tue, 2 Feb 2021 12:32:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/ptrace: Clean up PTRACE_GETREGS/PTRACE_PUTREGS
 regset selection
Message-ID: <20210202113256.GC18075@zn.tnic>
References: <9268050ac1fb3db6b4ec20d3ef696cc44fa3e9d0.1611884439.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9268050ac1fb3db6b4ec20d3ef696cc44fa3e9d0.1611884439.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 05:41:21PM -0800, Andy Lutomirski wrote:
> task_user_regset_view() is fundamentally broken, but it's ABI for
> PTRACE_GETREGSET and PTRACE_SETREGSET.
> 
> We shouldn't be using it for PTRACE_GETREGS or PTRACE_SETREGS,

No "We" etc pls.

> though.  A native 64-bit ptrace() call and an x32 ptrace() call
> should use the 64-bit regset views, and a 32-bit ptrace() call
> (native or compat) should use the 32-bit regset.
> task_user_regset_view() almost does this except that it will
> malfunction if a ptracer is itself ptraced and the outer ptracer
> modifies CS on entry to a ptrace() syscall.

Is that the reason why task_user_regset_view() is fundamentally broken?
It is somewhat unclear what exactly is broken.

> Hopefully that has
> never happened.  (The compat ptrace() code already hardcoded the
> 32-bit regset, so this patch has no effect on that path.)
> 
> Fix it and deobfuscate the code by hardcoding the 64-bit view in the
> x32 ptrace() and selecting the view based on the kernel config in
> the native ptrace().
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
> 
> Every time I look at ptrace, it grosses me out.  This makes it slightly
> more comprehensible.
> 
>  arch/x86/kernel/ptrace.c | 37 +++++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)

Well, did you run the gdb testsuite on this and a bunch of other tests
we have?

I don't want us to break gdb or something else using ptrace() in some
sublte manner and then waste a bunch of time and energy chasing it, like
the DR6 thing earlier this week.

> +/*
> + * This is used by PTRACE_GETREGSET and PTRACE_SETREGSET to decide which
> + * regset format to use based on the register state of the tracee.
> + * This makes no sense whatsoever, but there appears to be existing user
> + * code that relies on it.

... because? It should use the native regset with which the kernel is
built? Please explain yourself Lutomirski!

:-)))

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
