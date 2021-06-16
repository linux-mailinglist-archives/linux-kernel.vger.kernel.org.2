Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BB53AA03D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbhFPPq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:46:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45462 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235515AbhFPPoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:44:46 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 03F5B219C4;
        Wed, 16 Jun 2021 15:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623858158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=19yw1LaaIvwU2RJSCAJujeR3G1Rt3OIrFZhlwxYLBvE=;
        b=BgrpyWjOU1bQWkVNmPaRrcEwm4WJTyWkzjxUmwNKd1BqQ9RZUtkO2RMR4eRXpjX2eT63BI
        6tkkOSfd6QlO32vOdZBUIyl2KReYauOBW58Ym+84vuKr44TS5NpFSu2htLq7YCgtFMCBc4
        b67J8j8472IQqW+4TRyN4Ccbn+6Ea7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623858158;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=19yw1LaaIvwU2RJSCAJujeR3G1Rt3OIrFZhlwxYLBvE=;
        b=UTYLVetB1iRsr00O7+AVUrIdgDe0AZdBQ0EJmzAu+gR7GgPC3a4hslTQjuNLohlw/3ttUv
        cxS9zASA1IZMyGDg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id E1523118DD;
        Wed, 16 Jun 2021 15:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623858157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=19yw1LaaIvwU2RJSCAJujeR3G1Rt3OIrFZhlwxYLBvE=;
        b=tJV/xOoC8/SLcry3vfkWUtXmkK3GYwxGUvvCpij0GNz0egWWCISKMbYf8sWv9j7OBc4AU9
        G6AIbQgS6lLXQKdFAQEmp32TEjyQOr5OzLvQCBbn9MpIiABBhWkF9COlF0NS1/eUMxrFft
        N8r90r6bJJNuGLWWLhgs6pzNJO+emKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623858157;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=19yw1LaaIvwU2RJSCAJujeR3G1Rt3OIrFZhlwxYLBvE=;
        b=8pX2AOHezmTWbcw4xZ12Ef4kZJWn+r7mMTEhtdYxwJubJsk3BOYTJCOQJ2G+GVRym9lwgU
        96ZJwa8+XJU8smCQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id Za2NNO0bymAPBwAALh3uQQ
        (envelope-from <bp@suse.de>); Wed, 16 Jun 2021 15:42:37 +0000
Date:   Wed, 16 Jun 2021 17:42:27 +0200
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
Subject: Re: [patch V2 13/52] x86/fpu: Clean up fpregs_set()
Message-ID: <YMob4yofdD4Ox4+G@zn.tnic>
References: <20210614154408.673478623@linutronix.de>
 <20210614155355.033134539@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210614155355.033134539@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 05:44:21PM +0200, Thomas Gleixner wrote:
> From: Andy Lutomirski <luto@kernel.org>
> 
> fpregs_set() had unnecessary complexity to support short or nonzero-offset
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
>  arch/x86/kernel/fpu/regset.c |   27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
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
>  	if (!boot_cpu_has(X86_FEATURE_FPU))

cpu_feature_enabled(), and below too, while you're at it.

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
> +	if (static_cpu_has(X86_FEATURE_FXSR))
>  		convert_to_fxsr(&target->thread.fpu.state.fxsave, &env);
> +	else
> +		memcpy(&target->thread.fpu.state.fsave, &env, sizeof(env));
>  
>  	/*
> -	 * update the header bit in the xsave header, indicating the
> +	 * Update the header bit in the xsave header, indicating the
>  	 * presence of FP.
>  	 */
> -	if (boot_cpu_has(X86_FEATURE_XSAVE))
> +	if (static_cpu_has(X86_FEATURE_XSAVE))
>  		fpu->state.xsave.header.xfeatures |= XFEATURE_MASK_FP;
> -	return ret;
> +
> +	return 0;
>  }

With that addressed:

Reviewed-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
