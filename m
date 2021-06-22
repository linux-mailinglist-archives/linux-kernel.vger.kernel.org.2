Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33C13B0183
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 12:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhFVKj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 06:39:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44848 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhFVKj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 06:39:26 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 502E321969;
        Tue, 22 Jun 2021 10:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624358230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BIKgNJmVYHH089EatK7g1CBaPMeWH009e/AkEX2sqw0=;
        b=aSByzYk1rvY1azp+ZLCDGPyPHH9htgjtXf6S+qyviLD4sXGK7hQT7TtEuBd1CldE5iqJF2
        ZzIDbuwuACY2XQzARE8wlhQCIcNsXoJnEmynYV0cSWebltu7DrcJp8PcJX52i9l4kiNy+Y
        5JsJ+Yhte7oQyAapCtL5V6OY6m8QKtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624358230;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BIKgNJmVYHH089EatK7g1CBaPMeWH009e/AkEX2sqw0=;
        b=GGwtmgyN3N6eh9E0v0DCpUtDmAFAo0uxOqOHO6vo3G+hFMO5pC44fw445dM/OKst7ibXYV
        gl6s7PkLwAOF9gCA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 3565D118DD;
        Tue, 22 Jun 2021 10:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624358230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BIKgNJmVYHH089EatK7g1CBaPMeWH009e/AkEX2sqw0=;
        b=aSByzYk1rvY1azp+ZLCDGPyPHH9htgjtXf6S+qyviLD4sXGK7hQT7TtEuBd1CldE5iqJF2
        ZzIDbuwuACY2XQzARE8wlhQCIcNsXoJnEmynYV0cSWebltu7DrcJp8PcJX52i9l4kiNy+Y
        5JsJ+Yhte7oQyAapCtL5V6OY6m8QKtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624358230;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BIKgNJmVYHH089EatK7g1CBaPMeWH009e/AkEX2sqw0=;
        b=GGwtmgyN3N6eh9E0v0DCpUtDmAFAo0uxOqOHO6vo3G+hFMO5pC44fw445dM/OKst7ibXYV
        gl6s7PkLwAOF9gCA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id I7YoDVa90WAxUQAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 22 Jun 2021 10:37:10 +0000
Date:   Tue, 22 Jun 2021 12:36:58 +0200
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
Subject: Re: [patch V3 34/66] x86/fpu: Get rid of the FNSAVE optimization
Message-ID: <YNG9SuCcMxMYCNGr@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143448.257336139@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143448.257336139@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:18:57PM +0200, Thomas Gleixner wrote:
> The FNSAVE support requires conditionals in quite some call paths because
> FNSAVE reinitialized the FPU hardware. If the save has to preserve the FPU

reinitializes

> register state then the caller has to conditionally restore it from memory
> when FNSAVE is in use.
> 
> This also requires a conditional in context switch because the restore
> avoidance optimization cannot work with FNSAVE. As this only affects 20+
> years old CPUs there is really no reason to keep this optimization
> effective for FNSAVE. It's about time to not optimize for antiques anymore.
> 
> Just unconditionally FRSTOR the save content to the registers and clean up
> the conditionals all over the place.
> 
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V3: New patch
> ---
>  arch/x86/include/asm/fpu/internal.h |   17 +++++++----
>  arch/x86/kernel/fpu/core.c          |   54 +++++++++++++++---------------------
>  2 files changed, 34 insertions(+), 37 deletions(-)
> 
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -375,7 +375,7 @@ static inline int os_xrstor_safe(struct
>  	return err;
>  }
>  
> -extern int save_fpregs_to_fpstate(struct fpu *fpu);
> +extern void save_fpregs_to_fpstate(struct fpu *fpu);

You can move that stray forward declaration up, to the others.

...

> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -83,16 +83,20 @@ bool irq_fpu_usable(void)
>  EXPORT_SYMBOL(irq_fpu_usable);
>  
>  /*
> - * These must be called with preempt disabled. Returns
> - * 'true' if the FPU state is still intact and we can
> - * keep registers active.
> + * Save the FPU register state in fpu->state. The register state is
> + * preserved.
>   *
> - * The legacy FNSAVE instruction cleared all FPU state
> - * unconditionally, so registers are essentially destroyed.
> - * Modern FPU state can be kept in registers, if there are
> - * no pending FP exceptions.
> + * Must be called with fpregs_lock() held.
> + *
> + * The legacy FNSAVE instruction clears all FPU state unconditionally, so
> + * register state has to be reloaded. That might be a pointless exercise
> + * when the FPU is going to be used by another task right after that. But
> + * this only affect 20+ years old 32bit systems and avoids conditionals all

affects

> + * over the place.
> + *
> + * FXSAVE and all XSAVE variants preserve the FPU register state.
>   */
> -int save_fpregs_to_fpstate(struct fpu *fpu)
> +void save_fpregs_to_fpstate(struct fpu *fpu)

With that addressed:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
