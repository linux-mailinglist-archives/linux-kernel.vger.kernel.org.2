Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D063AE8BB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhFUMHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:07:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45178 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFUMHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:07:43 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AA31B21A2C;
        Mon, 21 Jun 2021 12:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624277128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xbaMfbL3qX1P1Vq1l4aN8Q68XfQmKAKQKhDEXhGLkoc=;
        b=b0SbYNL8tpIZMNzDkB4N4aTEkyddmhJ1a++aE/+fp+FJJ0YjDRKAfBSomV5++OjiGEpTJ1
        aeaBSqVXu017ymNeN+/TSFk8mwOJt9KkuGhmiYYc19CahEFIvUAuvKALuzi/msT/IloQLm
        RAmqyiuJ9sv77KrC3bwlKUSfnbu5Oyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624277128;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xbaMfbL3qX1P1Vq1l4aN8Q68XfQmKAKQKhDEXhGLkoc=;
        b=uPE4splr8oyArOaNn/dWaSx9j6qt7pU/EpUyFVEAN5EzhPEsc6I0um3SHDdwEBGlri5c6E
        OtZbzsB0y8WKsPDA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 98DFC118DD;
        Mon, 21 Jun 2021 12:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624277128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xbaMfbL3qX1P1Vq1l4aN8Q68XfQmKAKQKhDEXhGLkoc=;
        b=b0SbYNL8tpIZMNzDkB4N4aTEkyddmhJ1a++aE/+fp+FJJ0YjDRKAfBSomV5++OjiGEpTJ1
        aeaBSqVXu017ymNeN+/TSFk8mwOJt9KkuGhmiYYc19CahEFIvUAuvKALuzi/msT/IloQLm
        RAmqyiuJ9sv77KrC3bwlKUSfnbu5Oyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624277128;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xbaMfbL3qX1P1Vq1l4aN8Q68XfQmKAKQKhDEXhGLkoc=;
        b=uPE4splr8oyArOaNn/dWaSx9j6qt7pU/EpUyFVEAN5EzhPEsc6I0um3SHDdwEBGlri5c6E
        OtZbzsB0y8WKsPDA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id od5UJIiA0GAVIwAALh3uQQ
        (envelope-from <bp@suse.de>); Mon, 21 Jun 2021 12:05:28 +0000
Date:   Mon, 21 Jun 2021 14:05:16 +0200
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
Subject: Re: [patch V3 16/66] x86/fpu: Clean up fpregs_set()
Message-ID: <YNCAfJAn1872g7Fv@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143446.220042175@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143446.220042175@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:18:39PM +0200, Thomas Gleixner wrote:
> From: Andy Lutomirski <luto@kernel.org>
> 
> fpregs_set() has unnecessary complexity to support short or nonzero-offset
> writes and to handle the case in which a copy from userspace overwrites
> some of the target buffer and then fails.  Support for partial writes is
> useless -- just require that the write have offset 0 and the correct size,
> and copy into a temporary kernel buffer to avoid clobbering the state if
> the user access fails.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: New patch. Picked up from Andy
> ---
>  arch/x86/kernel/fpu/regset.c |   29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> ---
> --- a/arch/x86/kernel/fpu/regset.c
> +++ b/arch/x86/kernel/fpu/regset.c
> @@ -305,31 +305,32 @@ int fpregs_set(struct task_struct *targe
>  	struct user_i387_ia32_struct env;
>  	int ret;
>  
> -	fpu__prepare_write(fpu);
> -	fpstate_sanitize_xstate(fpu);
> +	/* No funny business with partial or oversized writes is permitted. */
> +	if (pos != 0 || count != sizeof(struct user_i387_ia32_struct))
> +		return -EINVAL;
>  
> -	if (!boot_cpu_has(X86_FEATURE_FPU))
> +	if (!cpu_feature_enabled(X86_FEATURE_FPU))
>  		return fpregs_soft_set(target, regset, pos, count, kbuf, ubuf);
>  
> -	if (!boot_cpu_has(X86_FEATURE_FXSR))
> -		return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> -					  &fpu->state.fsave, 0,
> -					  -1);
> +	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &env, 0, -1);
> +	if (ret)
> +		return ret;
>  
> -	if (pos > 0 || count < sizeof(env))
> -		convert_from_fxsr(&env, target);
> +	fpu__prepare_write(fpu);
>  
> -	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &env, 0, -1);
> -	if (!ret)
> +	if (cpu_feature_enabled(X86_FEATURE_FXSR))
>  		convert_to_fxsr(&target->thread.fpu.state.fxsave, &env);
> +	else
> +		memcpy(&target->thread.fpu.state.fsave, &env, sizeof(env));

You have above in the prologue:

	struct fpu *fpu = &target->thread.fpu;

so here you can just as well do:

        if (cpu_feature_enabled(X86_FEATURE_FXSR))
                convert_to_fxsr(&fpu->state.fxsave, &env);
        else
                memcpy(&fpu->state.fsave, &env, sizeof(env));

asm is identical.

With that:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
