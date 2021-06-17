Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBE23AB306
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhFQLww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:52:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41074 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbhFQLwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:52:51 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1C3AC1FDBF;
        Thu, 17 Jun 2021 11:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623930643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=16YivUy58OCNz3PP5EhuP1txKAUGi+Q+lFsH/tWWLb0=;
        b=UgOwF7VzJlQl0mm/ds1T5npzx/iKd+y2e8y8E/6l6FD4qxJfNPH3uPz0M4+SkYfHKiEog+
        dAMEJdgg9j0ejRlH828XVwbD/VAtv12sl1sdJArEYdFImwzEToxGSTh7+qFF3OE3aLTznP
        Q40cZacrQzT8EzcJh/cpupEy1xA4GbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623930643;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=16YivUy58OCNz3PP5EhuP1txKAUGi+Q+lFsH/tWWLb0=;
        b=5UZMncToLz5RdEVFXvFhFUGkNFEjHu74ByeGsYjJEMC3AvdBCrk4XTiFaJX3l4RLtWbQal
        dtdAh47GlLUy/lBg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 07F16118DD;
        Thu, 17 Jun 2021 11:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623930643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=16YivUy58OCNz3PP5EhuP1txKAUGi+Q+lFsH/tWWLb0=;
        b=UgOwF7VzJlQl0mm/ds1T5npzx/iKd+y2e8y8E/6l6FD4qxJfNPH3uPz0M4+SkYfHKiEog+
        dAMEJdgg9j0ejRlH828XVwbD/VAtv12sl1sdJArEYdFImwzEToxGSTh7+qFF3OE3aLTznP
        Q40cZacrQzT8EzcJh/cpupEy1xA4GbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623930643;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=16YivUy58OCNz3PP5EhuP1txKAUGi+Q+lFsH/tWWLb0=;
        b=5UZMncToLz5RdEVFXvFhFUGkNFEjHu74ByeGsYjJEMC3AvdBCrk4XTiFaJX3l4RLtWbQal
        dtdAh47GlLUy/lBg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id E3LdABM3y2A5EAAALh3uQQ
        (envelope-from <bp@suse.de>); Thu, 17 Jun 2021 11:50:43 +0000
Date:   Thu, 17 Jun 2021 13:50:31 +0200
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
Subject: Re: [patch V2 16/52] x86/fpu: Use copy_uabi_xstate_to_membuf() in
 fpregs_get()
Message-ID: <YMs3B6i6mK5F7+gd@zn.tnic>
References: <20210614154408.673478623@linutronix.de>
 <20210614155355.354479349@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210614155355.354479349@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 05:44:24PM +0200, Thomas Gleixner wrote:
> Use the new functionality of copy_uabi_xstate_to_membuf() to retrieve the
> FX state when XSAVE* is in use. This avoids to overwrite the FPU state
> buffer with fpstate_sanitize_xstate() which is error prone and duplicated
> code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: New patch
> ---
>  arch/x86/kernel/fpu/regset.c |   30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> --- a/arch/x86/kernel/fpu/regset.c
> +++ b/arch/x86/kernel/fpu/regset.c
> @@ -211,10 +211,10 @@ static inline u32 twd_fxsr_to_i387(struc
>   * FXSR floating point environment conversions.
>   */
>  
> -void
> -convert_from_fxsr(struct user_i387_ia32_struct *env, struct task_struct *tsk)
> +static void __convert_from_fxsr(struct user_i387_ia32_struct *env,
> +				struct task_struct *tsk,
> +				struct fxregs_state *fxsave)
>  {
> -	struct fxregs_state *fxsave = &tsk->thread.fpu.state.fxsave;
>  	struct _fpreg *to = (struct _fpreg *) &env->st_space[0];
>  	struct _fpxreg *from = (struct _fpxreg *) &fxsave->st_space[0];
>  	int i;
> @@ -248,6 +248,12 @@ convert_from_fxsr(struct user_i387_ia32_
>  		memcpy(&to[i], &from[i], sizeof(to[0]));
>  }
>  
> +void
> +convert_from_fxsr(struct user_i387_ia32_struct *env, struct task_struct *tsk)
> +{
> +	__convert_from_fxsr(env, tsk, &tsk->thread.fpu.state.fxsave);
> +}
> +
>  void convert_to_fxsr(struct fxregs_state *fxsave,
>  		     const struct user_i387_ia32_struct *env)
>  
> @@ -280,25 +286,29 @@ int fpregs_get(struct task_struct *targe
>  {
>  	struct fpu *fpu = &target->thread.fpu;
>  	struct user_i387_ia32_struct env;
> +	struct fxregs_state fxsave, *fx;
>  
>  	fpu__prepare_read(fpu);
>  
> -	if (!boot_cpu_has(X86_FEATURE_FPU))
> +	if (!static_cpu_has(X86_FEATURE_FPU))
>  		return fpregs_soft_get(target, regset, to);
>  
> -	if (!boot_cpu_has(X86_FEATURE_FXSR)) {
> +	if (!static_cpu_has(X86_FEATURE_FXSR)) {

both: cpu_feature_enabled

With that:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
