Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F643989C5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 14:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhFBMkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 08:40:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52784 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhFBMkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:40:00 -0400
Received: from zn.tnic (p200300ec2f0f0e0009598a6b6104e9d0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:e00:959:8a6b:6104:e9d0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D68A21EC051E;
        Wed,  2 Jun 2021 14:38:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622637497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mdoASBUa4Qv3xbqKAlEPW3ZCkB2pQW6JM5Lnhi6idXk=;
        b=GFtSHKcX99SbEU/pulL4h27cx3I9s68lDG0O5hIbjOgc3kNcFqx3NhNTBw83EqVM5AOPfc
        y0LJmHfJG1pkeBCMv7Ed5VLuMLLVXeW9XF7FujOh0/e7U1CLu33LdZw5mbl32sjhZNxRLQ
        xksYSTGkxL4USilE8qw04dfiNQMm3uQ=
Date:   Wed, 2 Jun 2021 14:38:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [patch 1/8] selftests/x86: Test signal frame XSTATE header
 corruption handling
Message-ID: <YLd7s/cw8MsUlWvM@zn.tnic>
References: <20210602095543.149814064@linutronix.de>
 <20210602101618.285452223@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210602101618.285452223@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 11:55:44AM +0200, Thomas Gleixner wrote:
> From: Andy Lutomirski <luto@kernel.org>
> 
> This is very heavily based on some code from Thomas Gleixner.  On a system
> without XSAVES, it triggers the WARN_ON():
> 
>     Bad FPU state detected at copy_kernel_to_fpregs+0x2f/0x40, reinitializing FPU registers.

That triggers

[  149.497274] corrupt_xstate_[1627] bad frame in rt_sigreturn frame:00000000dad08ab1 ip:7f031449ffe1 sp:7ffd0c5c59f0 orax:ffffffffffffffff in libpthread-2.31.so[7f0314493000+10000]

on an AMD laptop here.

> +static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
> +			   unsigned int *ecx, unsigned int *edx)
> +{
> +	asm volatile(
> +		"cpuid;"
> +		: "=a" (*eax),
> +		  "=b" (*ebx),
> +		  "=c" (*ecx),
> +		  "=d" (*edx)
> +		: "0" (*eax), "2" (*ecx));
> +}
> +
> +static inline int xsave_enabled(void)
> +{
> +	unsigned int eax, ebx, ecx, edx;
> +
> +	eax = 0x1;
> +	ecx = 0x0;
> +	__cpuid(&eax, &ebx, &ecx, &edx);
> +
> +	/* Is CR4.OSXSAVE enabled ? */
> +	return ecx & (1U << 27);
> +}

One fine day someone should sit down and unify all those auxillary
functions used in the selftests into a lib...

> +
> +static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
> +		       int flags)
> +{
> +	struct sigaction sa;
> +
> +	memset(&sa, 0, sizeof(sa));
> +	sa.sa_sigaction = handler;
> +	sa.sa_flags = SA_SIGINFO | flags;
> +	sigemptyset(&sa.sa_mask);
> +	if (sigaction(sig, &sa, 0))
> +		err(1, "sigaction");
> +}
> +
> +static void sigusr1(int sig, siginfo_t *info, void *uc_void)
> +{
> +	ucontext_t *uc = uc_void;
> +	uint8_t *fpstate = (uint8_t *)uc->uc_mcontext.fpregs;
> +	uint64_t *xfeatures = (uint64_t *)(fpstate + 512);
> +
> +	printf("\tWreckage XSTATE header\n");
> +	/* Wreckage the first reserved byte in the header */
> +	*(xfeatures + 2) = 0xfffffff;
> +}
> +
> +static void sigsegv(int sig, siginfo_t *info, void *uc_void)
> +{
> +	printf("\tGot SIGSEGV\n");
> +}
> +
> +int main()

ERROR: Bad function definition - int main() should probably be int main(void)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
