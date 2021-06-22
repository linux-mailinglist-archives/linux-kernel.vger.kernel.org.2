Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2AF3B0941
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhFVPkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:40:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47566 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbhFVPkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:40:45 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 359C41FD45;
        Tue, 22 Jun 2021 15:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624376309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dYqkyJXGrlhrLuq6i1YuqTyaFTNfhX7/cG4lFyzdrpc=;
        b=2ZRvW3fxkIp3QooGP+kHDj+bR3utbG9Tr4HzUvimCUeLTUILn/VPwYThME9iHeJ/iniF1j
        bibnYD1qnIE6hNHw0vPADwFh1EhwrDso79luyzqh36MI1LBw+5aUQAgglGhcFd5J0X+k3h
        CdxmtoE7lf73cIsfHC9JZA1dZzc+MhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624376309;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dYqkyJXGrlhrLuq6i1YuqTyaFTNfhX7/cG4lFyzdrpc=;
        b=PszgkPgDMzcYMMVD7kFiE6MnvC023iT8G7BSZedzBxD0UpCarRz9x3Ee3yxrF/S7miIAQE
        MewdLpsnSg4XSACw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 21AD0118DD;
        Tue, 22 Jun 2021 15:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624376309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dYqkyJXGrlhrLuq6i1YuqTyaFTNfhX7/cG4lFyzdrpc=;
        b=2ZRvW3fxkIp3QooGP+kHDj+bR3utbG9Tr4HzUvimCUeLTUILn/VPwYThME9iHeJ/iniF1j
        bibnYD1qnIE6hNHw0vPADwFh1EhwrDso79luyzqh36MI1LBw+5aUQAgglGhcFd5J0X+k3h
        CdxmtoE7lf73cIsfHC9JZA1dZzc+MhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624376309;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dYqkyJXGrlhrLuq6i1YuqTyaFTNfhX7/cG4lFyzdrpc=;
        b=PszgkPgDMzcYMMVD7kFiE6MnvC023iT8G7BSZedzBxD0UpCarRz9x3Ee3yxrF/S7miIAQE
        MewdLpsnSg4XSACw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id xEYgB/UD0mCnBgAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 22 Jun 2021 15:38:29 +0000
Date:   Tue, 22 Jun 2021 17:38:24 +0200
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
Subject: Re: [patch V3 47/66] x86/fpu: Clean up the fpu__clear() variants
Message-ID: <YNID8GglJPaPqtE4@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143449.733176003@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143449.733176003@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only nitpicks:

On Fri, Jun 18, 2021 at 04:19:10PM +0200, Thomas Gleixner wrote:
> From: Andy Lutomirski <luto@kernel.org>
> 
> fpu__clear() currently resets both register state and kernel XSAVE buffer
> state.  It has two modes: one for all state (supervisor and user) and
> another for user state only.  fpu__clear_all() uses the "all state"
> (user_only=0) mode, while a number of signal paths use the user_only=1
> mode.
> 
> Make fpu__clear() work only for user state (user_only=1) and remove the
> "all state" (user_only=0) code.  Rename it to match so it can be used by
> the signal paths.
> 
> Replace the "all state" (user_only=0) fpu__clear() functionality.  Use the
> TIF_NEED_FPU_LOAD functionality instead of making any actual hardware
> registers changes in this path.
> 
> Instead of invoking fpu__initialize() just memcpy() init_fpstate into the
> tasks FPU state because that has already the correct format and in case of

task's

> PKRU also contains the default PKRU value. Move the actual PKRU write out
> into flush_thread() where it belongs and where it will end up anyway when
> PKRU and XSTATE have been distangled.

untangled

> 
> For bisectability a workaround is required which stores the PKRU value in
> the xstate memory until PKRU is distangled from XSTATE for context

untangled

> switching and return to user.
> 
> [ Dave Hansen: Polished changelog ]
> [ tglx: Fixed the PKRU fallout ]
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/fpu/core.c |  111 ++++++++++++++++++++++++++++++---------------
>  arch/x86/kernel/process.c  |   10 ++++
>  2 files changed, 85 insertions(+), 36 deletions(-)

...

> +/* Temporary workaround. Will be removed once PKRU and XSTATE are distangled. */

untangled

> +static inline void pkru_set_default_in_xstate(struct xregs_state *xsave)
> +{
> +	struct pkru_state *pk;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
> +		return;
> +	/*
> +	 * Force XFEATURE_PKRU to be set in the header otherwise
> +	 * get_xsave_addr() does not work and it also needs to be set to
> +	 * make XRSTOR(S) load it.
> +	 */
> +	xsave->header.xfeatures |= XFEATURE_MASK_PKRU;
> +	pk = get_xsave_addr(xsave, XFEATURE_PKRU);
> +	pk->pkru = pkru_get_init_value();
> +}
> +
>  /*
> - * Clear the FPU state back to init state.
> - *
> - * Called by sys_execve(), by the signal handler code and by various
> - * error paths.
> + * Reset current->fpu memory state to the init values.
>   */
> -static void fpu__clear(struct fpu *fpu, bool user_only)
> +static void fpu_reset_fpstate(void)
> +{
> +	struct fpu *fpu= &current->thread.fpu;

ERROR: spaces required around that '=' (ctx:VxW)
#167: FILE: arch/x86/kernel/fpu/core.c:335:
+	struct fpu *fpu= &current->thread.fpu;
 	               ^


> +
> +	fpregs_lock();
> +	fpu__drop(fpu);
> +	/*
> +	 * This does not change the actual hardware registers. It just
> +	 * resets the memory image and sets TIF_NEED_FPU_LOAD so a
> +	 * subsequent return to usermode will reload the registers from the
> +	 * tasks memory image.

task's

> +	 *
> +	 * Do not use fpstate_init() here. Just copy init_fpstate which has
> +	 * the correct content already except for PKRU.
> +	 */

Dunno, this comment can be over the function name - it is small enough
anyway.

> +	memcpy(&fpu->state, &init_fpstate, init_fpstate_copy_size());
> +	pkru_set_default_in_xstate(&fpu->state.xsave);
> +	set_thread_flag(TIF_NEED_FPU_LOAD);
> +	fpregs_unlock();
> +}
> +
> +/*
> + * Reset current's user FPU states to the init states.  current's
> + * supervisor states, if any, are not modified by this function.  The
> + * caller guarantees that the XSTATE header in memory is intact.
> + */
> +void fpu__clear_user_states(struct fpu *fpu)
>  {
>  	WARN_ON_FPU(fpu != &current->thread.fpu);
>  
> +	fpregs_lock();
>  	if (!static_cpu_has(X86_FEATURE_FPU)) {

cpu_feature_enabled()

> -		fpu__drop(fpu);
> -		fpu__initialize(fpu);
> +		fpu_reset_fpstate();
> +		fpregs_unlock();
>  		return;
>  	}
>  
> -	fpregs_lock();
> -
> -	if (user_only) {
> -		if (!fpregs_state_valid(fpu, smp_processor_id()) &&
> -		    xfeatures_mask_supervisor())
> -			os_xrstor(&fpu->state.xsave, xfeatures_mask_supervisor());
> -		load_fpregs_from_init_fpstate(xfeatures_mask_user());
> -	} else {
> -		load_fpregs_from_init_fpstate(xfeatures_mask_all);
> +	/*
> +	 * Ensure that current's supervisor states are loaded into their
> +	 * corresponding registers.
> +	 */
> +	if (xfeatures_mask_supervisor() &&
> +	    !fpregs_state_valid(fpu, smp_processor_id())) {
> +		os_xrstor(&fpu->state.xsave, xfeatures_mask_supervisor());
>  	}
>  
> +	/* Reset user states in registers. */
> +	load_fpregs_from_init_fpstate(xfeatures_mask_user());
> +
> +	/*
> +	 * Now all FPU registers have their desired values.  Inform the FPU
> +	 * state machine that current's FPU registers are in the hardware
> +	 * registers. The memory image does not need to be updated because
> +	 * any operation relying on it has to save the registers first when
> +	 * currents FPU is marked active.

current's

> +	 */
>  	fpregs_mark_activate();
>  	fpregs_unlock();
>  }
>  

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
