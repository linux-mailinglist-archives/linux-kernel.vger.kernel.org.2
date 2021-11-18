Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF2F4563C0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 20:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbhKRT6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 14:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhKRT6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 14:58:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADC4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 11:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+Wnee8+OIv7MXy7CHkPp6bI24jeoI3Uiy08a3GleuyA=; b=nTedDTh/uRBfE+5WQWhOw/Z+/x
        N4Ng9KrP6dGy+DGbUPay94dDkCF6NJhcUuNaroTlHZwLXt0hc2Ghdq9XNQ62LDAJlWd33ScoaviPP
        UrQLZjnZM6OoWg0qyRXvuxGVMKd/AqPbiBlZjP9cxUAQjbKTnl8l2FOawjCLr8IKjduqtF51sTQOk
        4AzArdIVQHmQWHu8i6Ey/sM83edHgv8nhcWuLCaeLGGLxVUHtmQBoI/ULSFLziazs5et2iRFwT/mU
        bwylPZ3gchoBwsbA2Jq0FBWCdDvA6VLrVAaGYltL3kQWGNOITjJyZpHo5CiSF1D1tTuJLIcEokjo0
        XAlBPdgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnnUv-008lSW-Ii; Thu, 18 Nov 2021 19:55:06 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EECF49863CD; Thu, 18 Nov 2021 20:55:04 +0100 (CET)
Date:   Thu, 18 Nov 2021 20:55:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH V5 03/50] x86/traps: Remove stack-protector from traps.c
Message-ID: <20211118195504.GM174703@worktop.programming.kicks-ass.net>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
 <20211110115736.3776-4-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110115736.3776-4-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 07:56:49PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> When stack-protector is enabled, the compiler adds some instrument code
> at the beginning and the end of some functions. Many functions in traps.c
> are non-instrumentable.  Moreover, stack-protector code in the beginning
> of the affected function accesses the canary that might be watched by
> hardware breakpoints which also violate the non-instrumentable
> nature of some functions and might cause infinite recursive #DB because
> the canary is accessed before resetting the dr7.
> 
> So it is better to remove stack-protector from traps.c.
> 
> It is also prepared for later patches that move some entry code into
> traps.c, some of which can NOT use percpu register until gsbase is
> properly switched.  And stack-protector depends on the percpu register
> to work.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/kernel/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 2ff3e600f426..8ac45801ba8b 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -50,6 +50,7 @@ KCOV_INSTRUMENT		:= n
>  
>  CFLAGS_head$(BITS).o	+= -fno-stack-protector
>  CFLAGS_cc_platform.o	+= -fno-stack-protector
> +CFLAGS_traps.o		+= -fno-stack-protector

Well, there's a lot more noinstr than just in traps. There's also real C
code in traps. This isn't really a solution.

I think GCC has recently grown __attribute__((no_stack_protector)),
which should be added to noinstr (GCC-11 and above).

Additionally we could add code to objtool to detect this problem.
