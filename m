Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D30640CF3B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 00:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbhIOWK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 18:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhIOWK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 18:10:28 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BA9C061764
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 15:09:08 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y8so3981327pfa.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 15:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=n3KHF55IFodQYbgODw8tAWg2yPPqSwTwT4qpENEhYPE=;
        b=p8sdCI+dYw+wpsvJEPpgC8kwT9RljDH7IMLia3YRCn+lSQ/x2NVM4GgJ87Di/xbpAq
         5MI/TcnzTacy8sfIgF1qx/N4P2wc0B+u0Gr2MaTBK6vIvNKqKdtSdIyCjHhOlor/WQAg
         cx0TCHShim8TB3VTCPx+DlxAJG9oCcg1jVGcpZyVwhAGTWd3h80DK3t4hvxclVzDOgiZ
         D3vjmEpGBgW1kQUJfIUictY6WLPPht8iz3voyYD2Xj2DGwKPgRre16+qDgP9NmtfQVn8
         bsAwMzMzxjYEtde1x3mMckKASK0FUGsQ4mx5MTJ7nIYqcDd2/b7P90Sc5vEkz3R48e/y
         tXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=n3KHF55IFodQYbgODw8tAWg2yPPqSwTwT4qpENEhYPE=;
        b=cKErUZdijhUnlmAOieYZWUzRk6S2ePr36rqsNPKYwALC45NTONIX+Tc01S7nOUv3ZR
         Q9R9UwbuBIjDacmnCv3aJsEzGDQZhRpIUkIBLgq+v6+x14VMGljAi+W3CZGQDLzfLd3e
         43t/FmaYKcbE3r0R6vKWGEhelDnJqmQJQfwayyQZG73YQS89FXZHRb/eGjorik6Tbuh4
         C8WTvx4yCKdyXOsPQO4cyf62TdbxPW6KeMlrIyhI7orIF3Imh3wjjahrMZen+K6Wo0dA
         29ws+au5PTINwvxgCa1mIBfnql0A8KhdCtZfYpVw1byrWaFAgRLJhO5+2tr/KwOcREIt
         xYQA==
X-Gm-Message-State: AOAM531WaWIbsJIJ+xULEU4Kw9oo57BESvpYNfbV0ZJ8SVxndYIF4Fp1
        QSf4/FnOABm2AP2DObI+VTxGFyakWTA=
X-Google-Smtp-Source: ABdhPJyOW4nWZsfE5SP5GchiJdDbd5CysUMMzkwVZ84yOX1xwy1AQpE0US909eXtPAQnWN6IKTgc0A==
X-Received: by 2002:a63:705:: with SMTP id 5mr1812929pgh.265.1631743748125;
        Wed, 15 Sep 2021 15:09:08 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:9b0:7226:558a:f377? ([2001:df0:0:200c:9b0:7226:558a:f377])
        by smtp.gmail.com with ESMTPSA id y4sm528191pjw.57.2021.09.15.15.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 15:09:07 -0700 (PDT)
Subject: Re: [PATCH 1/3] m68k: handle arrivals of multiple signals correctly
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-m68k@lists.linux-m68k.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-kernel@vger.kernel.org
References: <YP2c1xk9LJ0zE3KW@zeniv-ca.linux.org.uk>
 <YP2dBIAPTaVvHiZ6@zeniv-ca.linux.org.uk>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <d62fd0ae-9d25-ec36-107d-d99f15d52e90@gmail.com>
Date:   Thu, 16 Sep 2021 10:08:50 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YP2dBIAPTaVvHiZ6@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

On 26/07/21 5:19 am, Al Viro wrote:
> When we have several pending signals, have entered with the kernel
> with large exception frame *and* have already built at least one
> sigframe, regs->stkadj is going to be non-zero and regs->format/sr/pc
> are going to be junk - the real values are in shifted exception stack
> frame we'd built when putting together the first sigframe.
>
> If that happens, subsequent sigframes are going to be garbage.
> Not hard to fix - just need to find the "adjusted" frame first
> and look for format/vector/sr/pc in it.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good to me. What's more, it fixes a number of long standing issues 
dating back to the 4.10 ages - see discussions at:

https://lore.kernel.org/r/7517d306-21ad-daa1-a2fb-b273211cb588@gmail.com

https://lore.kernel.org/r/ed2ca322-b957-cd52-8d2f-a8edd2785625@linux-m68k.org

- so should be applied to -stable IMO.

Tested by me on 68030 - Finn Thain did some testing on 68040 and might 
add his own tag.

Tested-by: Michael Schmitz <schmitzmic@gmail.com>

Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>

> ---
>   arch/m68k/kernel/signal.c | 88 ++++++++++++++++++++++-------------------------
>   1 file changed, 42 insertions(+), 46 deletions(-)
>
> diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
> index 8f215e79e70e..cd11eb101eac 100644
> --- a/arch/m68k/kernel/signal.c
> +++ b/arch/m68k/kernel/signal.c
> @@ -447,7 +447,7 @@ static inline void save_fpu_state(struct sigcontext *sc, struct pt_regs *regs)
>   
>   	if (CPU_IS_060 ? sc->sc_fpstate[2] : sc->sc_fpstate[0]) {
>   		fpu_version = sc->sc_fpstate[0];
> -		if (CPU_IS_020_OR_030 &&
> +		if (CPU_IS_020_OR_030 && !regs->stkadj &&
>   		    regs->vector >= (VEC_FPBRUC * 4) &&
>   		    regs->vector <= (VEC_FPNAN * 4)) {
>   			/* Clear pending exception in 68882 idle frame */
> @@ -510,7 +510,7 @@ static inline int rt_save_fpu_state(struct ucontext __user *uc, struct pt_regs *
>   		if (!(CPU_IS_060 || CPU_IS_COLDFIRE))
>   			context_size = fpstate[1];
>   		fpu_version = fpstate[0];
> -		if (CPU_IS_020_OR_030 &&
> +		if (CPU_IS_020_OR_030 && !regs->stkadj &&
>   		    regs->vector >= (VEC_FPBRUC * 4) &&
>   		    regs->vector <= (VEC_FPNAN * 4)) {
>   			/* Clear pending exception in 68882 idle frame */
> @@ -832,18 +832,24 @@ asmlinkage int do_rt_sigreturn(struct pt_regs *regs, struct switch_stack *sw)
>   	return 0;
>   }
>   
> +static inline struct pt_regs *rte_regs(struct pt_regs *regs)
> +{
> +	return (void *)regs + regs->stkadj;
> +}
> +
>   static void setup_sigcontext(struct sigcontext *sc, struct pt_regs *regs,
>   			     unsigned long mask)
>   {
> +	struct pt_regs *tregs = rte_regs(regs);
>   	sc->sc_mask = mask;
>   	sc->sc_usp = rdusp();
>   	sc->sc_d0 = regs->d0;
>   	sc->sc_d1 = regs->d1;
>   	sc->sc_a0 = regs->a0;
>   	sc->sc_a1 = regs->a1;
> -	sc->sc_sr = regs->sr;
> -	sc->sc_pc = regs->pc;
> -	sc->sc_formatvec = regs->format << 12 | regs->vector;
> +	sc->sc_sr = tregs->sr;
> +	sc->sc_pc = tregs->pc;
> +	sc->sc_formatvec = tregs->format << 12 | tregs->vector;
>   	save_a5_state(sc, regs);
>   	save_fpu_state(sc, regs);
>   }
> @@ -851,6 +857,7 @@ static void setup_sigcontext(struct sigcontext *sc, struct pt_regs *regs,
>   static inline int rt_setup_ucontext(struct ucontext __user *uc, struct pt_regs *regs)
>   {
>   	struct switch_stack *sw = (struct switch_stack *)regs - 1;
> +	struct pt_regs *tregs = rte_regs(regs);
>   	greg_t __user *gregs = uc->uc_mcontext.gregs;
>   	int err = 0;
>   
> @@ -871,9 +878,9 @@ static inline int rt_setup_ucontext(struct ucontext __user *uc, struct pt_regs *
>   	err |= __put_user(sw->a5, &gregs[13]);
>   	err |= __put_user(sw->a6, &gregs[14]);
>   	err |= __put_user(rdusp(), &gregs[15]);
> -	err |= __put_user(regs->pc, &gregs[16]);
> -	err |= __put_user(regs->sr, &gregs[17]);
> -	err |= __put_user((regs->format << 12) | regs->vector, &uc->uc_formatvec);
> +	err |= __put_user(tregs->pc, &gregs[16]);
> +	err |= __put_user(tregs->sr, &gregs[17]);
> +	err |= __put_user((tregs->format << 12) | tregs->vector, &uc->uc_formatvec);
>   	err |= rt_save_fpu_state(uc, regs);
>   	return err;
>   }
> @@ -890,13 +897,14 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
>   			struct pt_regs *regs)
>   {
>   	struct sigframe __user *frame;
> -	int fsize = frame_extra_sizes(regs->format);
> +	struct pt_regs *tregs = rte_regs(regs);
> +	int fsize = frame_extra_sizes(tregs->format);
>   	struct sigcontext context;
>   	int err = 0, sig = ksig->sig;
>   
>   	if (fsize < 0) {
>   		pr_debug("setup_frame: Unknown frame format %#x\n",
> -			 regs->format);
> +			 tregs->format);
>   		return -EFAULT;
>   	}
>   
> @@ -907,7 +915,7 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
>   
>   	err |= __put_user(sig, &frame->sig);
>   
> -	err |= __put_user(regs->vector, &frame->code);
> +	err |= __put_user(tregs->vector, &frame->code);
>   	err |= __put_user(&frame->sc, &frame->psc);
>   
>   	if (_NSIG_WORDS > 1)
> @@ -934,33 +942,27 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
>   	push_cache ((unsigned long) &frame->retcode);
>   
>   	/*
> -	 * Set up registers for signal handler.  All the state we are about
> -	 * to destroy is successfully copied to sigframe.
> -	 */
> -	wrusp ((unsigned long) frame);
> -	regs->pc = (unsigned long) ksig->ka.sa.sa_handler;
> -	adjustformat(regs);
> -
> -	/*
>   	 * This is subtle; if we build more than one sigframe, all but the
>   	 * first one will see frame format 0 and have fsize == 0, so we won't
>   	 * screw stkadj.
>   	 */
> -	if (fsize)
> +	if (fsize) {
>   		regs->stkadj = fsize;
> -
> -	/* Prepare to skip over the extra stuff in the exception frame.  */
> -	if (regs->stkadj) {
> -		struct pt_regs *tregs =
> -			(struct pt_regs *)((ulong)regs + regs->stkadj);
> +		tregs = rte_regs(regs);
>   		pr_debug("Performing stackadjust=%04lx\n", regs->stkadj);
> -		/* This must be copied with decreasing addresses to
> -                   handle overlaps.  */
>   		tregs->vector = 0;
>   		tregs->format = 0;
> -		tregs->pc = regs->pc;
>   		tregs->sr = regs->sr;
>   	}
> +
> +	/*
> +	 * Set up registers for signal handler.  All the state we are about
> +	 * to destroy is successfully copied to sigframe.
> +	 */
> +	wrusp ((unsigned long) frame);
> +	tregs->pc = (unsigned long) ksig->ka.sa.sa_handler;
> +	adjustformat(regs);
> +
>   	return 0;
>   }
>   
> @@ -968,7 +970,8 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
>   			   struct pt_regs *regs)
>   {
>   	struct rt_sigframe __user *frame;
> -	int fsize = frame_extra_sizes(regs->format);
> +	struct pt_regs *tregs = rte_regs(regs);
> +	int fsize = frame_extra_sizes(tregs->format);
>   	int err = 0, sig = ksig->sig;
>   
>   	if (fsize < 0) {
> @@ -1019,33 +1022,26 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
>   	push_cache ((unsigned long) &frame->retcode);
>   
>   	/*
> -	 * Set up registers for signal handler.  All the state we are about
> -	 * to destroy is successfully copied to sigframe.
> -	 */
> -	wrusp ((unsigned long) frame);
> -	regs->pc = (unsigned long) ksig->ka.sa.sa_handler;
> -	adjustformat(regs);
> -
> -	/*
>   	 * This is subtle; if we build more than one sigframe, all but the
>   	 * first one will see frame format 0 and have fsize == 0, so we won't
>   	 * screw stkadj.
>   	 */
> -	if (fsize)
> +	if (fsize) {
>   		regs->stkadj = fsize;
> -
> -	/* Prepare to skip over the extra stuff in the exception frame.  */
> -	if (regs->stkadj) {
> -		struct pt_regs *tregs =
> -			(struct pt_regs *)((ulong)regs + regs->stkadj);
> +		tregs = rte_regs(regs);
>   		pr_debug("Performing stackadjust=%04lx\n", regs->stkadj);
> -		/* This must be copied with decreasing addresses to
> -                   handle overlaps.  */
>   		tregs->vector = 0;
>   		tregs->format = 0;
> -		tregs->pc = regs->pc;
>   		tregs->sr = regs->sr;
>   	}
> +
> +	/*
> +	 * Set up registers for signal handler.  All the state we are about
> +	 * to destroy is successfully copied to sigframe.
> +	 */
> +	wrusp ((unsigned long) frame);
> +	tregs->pc = (unsigned long) ksig->ka.sa.sa_handler;
> +	adjustformat(regs);
>   	return 0;
>   }
>   
