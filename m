Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CC83A9EE4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbhFPPYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:24:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43852 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbhFPPYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:24:42 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8A702219E3;
        Wed, 16 Jun 2021 15:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623856955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ST8c7a5bQHAFlmR3FSW1Gk4szH4TCwzOw3Iob4jT+Q=;
        b=dengqMEIOBhyQG7C7UAo3Azcr82YmbRd/euwO2/PQlSmJJxlrO/MuzhPF1ZLQQacKnotuO
        Y+oMjMly9D/l5ZFNNhSSYzbtwaGSvaOrJWM3GBYsDUpqHZmbztUQ8Gcz4NOdhrrySIcpQc
        Na+Yihj9HJTzrQnSqqLAD75/B3H8H9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623856955;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ST8c7a5bQHAFlmR3FSW1Gk4szH4TCwzOw3Iob4jT+Q=;
        b=55mUAW5wDAILTeZ0uL1bQxM17b1QHO/D1Vt2eBuKTSrdP/BbAleQBpAts62gFpTbhaqvdO
        aNGteiTeXUFxeIAg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 77AC7118DD;
        Wed, 16 Jun 2021 15:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623856955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ST8c7a5bQHAFlmR3FSW1Gk4szH4TCwzOw3Iob4jT+Q=;
        b=dengqMEIOBhyQG7C7UAo3Azcr82YmbRd/euwO2/PQlSmJJxlrO/MuzhPF1ZLQQacKnotuO
        Y+oMjMly9D/l5ZFNNhSSYzbtwaGSvaOrJWM3GBYsDUpqHZmbztUQ8Gcz4NOdhrrySIcpQc
        Na+Yihj9HJTzrQnSqqLAD75/B3H8H9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623856955;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ST8c7a5bQHAFlmR3FSW1Gk4szH4TCwzOw3Iob4jT+Q=;
        b=55mUAW5wDAILTeZ0uL1bQxM17b1QHO/D1Vt2eBuKTSrdP/BbAleQBpAts62gFpTbhaqvdO
        aNGteiTeXUFxeIAg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id YQoRHDsXymChegAALh3uQQ
        (envelope-from <bp@suse.de>); Wed, 16 Jun 2021 15:22:35 +0000
Date:   Wed, 16 Jun 2021 17:22:23 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [patch V2 11/52] x86/fpu: Rewrite xfpregs_set()
Message-ID: <YMoW0KfMWw+T0YAg@zn.tnic>
References: <20210614154408.673478623@linutronix.de>
 <20210614155354.838654334@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210614155354.838654334@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 05:44:19PM +0200, Thomas Gleixner wrote:
> From: Andy Lutomirski <luto@kernel.org>
> 
> xfpregs_set() was incomprehensible.  Almost all of the complexity was due
> to trying to support nonsensically sized writes or -EFAULT errors that
> would have partially or completely overwritten the destination before
> failing.  Nonsensically sized input would only have been possible using
> PTRACE_SETREGSET on REGSET_XFP.  Fortunately, it appears (based on Debian
> code search results) that no one uses that API at all, let alone with the
> wrong sized buffer.  Failed user access can be handled more cleanly by
> first copying to kernel memory.
> 
> Just rewrite it to require sensible input.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: New patch picked up from Andy
> ---
>  arch/x86/kernel/fpu/regset.c |   40 +++++++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
> 
> --- a/arch/x86/kernel/fpu/regset.c
> +++ b/arch/x86/kernel/fpu/regset.c
> @@ -47,30 +47,40 @@ int xfpregs_set(struct task_struct *targ
>  		const void *kbuf, const void __user *ubuf)
>  {
>  	struct fpu *fpu = &target->thread.fpu;
> +	struct user32_fxsr_struct newstate;
>  	int ret;
>  
> -	if (!boot_cpu_has(X86_FEATURE_FXSR))
> +	BUILD_BUG_ON(sizeof(newstate) != sizeof(struct fxregs_state));
> +
> +	if (!static_cpu_has(X86_FEATURE_FXSR))

cpu_feature_enabled

>  		return -ENODEV;
>  
> -	fpu__prepare_write(fpu);
> -	fpstate_sanitize_xstate(fpu);
> +	/* No funny business with partial or oversized writes is permitted. */
> +	if (pos != 0 || count != sizeof(newstate))
> +		return -EINVAL;
>  
>  	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> -				 &fpu->state.fxsave, 0, -1);
> +				 &newstate, 0, -1);

Let that line stick out.

> +	if (ret)
> +		return ret;
> +
> +	/* Mask invalid MXCSR bits (for historical reasons). */

security reasons became historical reasons huh? :-)

With those fixed:

Reviewed-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
