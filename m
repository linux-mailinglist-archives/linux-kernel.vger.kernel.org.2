Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2923B1579
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 10:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhFWINL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 04:13:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45094 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFWINH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:13:07 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BBB371FD65;
        Wed, 23 Jun 2021 08:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624435848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wUSXtAyfCTHluwzt1Ag75fz9EwMswluyA6LLKhKGOro=;
        b=iYu1X6LTxk06+fHTUOZpl0OVWuzokWgzemWqc4o8ML26wmd6lpj0rjgSdULGHBZpQpj7GA
        +tgbzxNnzqwT9KmJHedrr2YoVIfm8PNcNS1qzbLHSyqpULJaiPHJE8exLZ1C2Odba+H6wy
        x7vyn3U5HKOAFZdtQZPIIryxTiGnsq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624435848;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wUSXtAyfCTHluwzt1Ag75fz9EwMswluyA6LLKhKGOro=;
        b=ZSMoA6u9NzhAtAjbE1BkgNfUtXqR9NE52G93mRoU/M/PXBJGiC5rQVVW0s/zYtIrDPmxaS
        Qh5/n9//sn/km/BQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id A88F311A97;
        Wed, 23 Jun 2021 08:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624435848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wUSXtAyfCTHluwzt1Ag75fz9EwMswluyA6LLKhKGOro=;
        b=iYu1X6LTxk06+fHTUOZpl0OVWuzokWgzemWqc4o8ML26wmd6lpj0rjgSdULGHBZpQpj7GA
        +tgbzxNnzqwT9KmJHedrr2YoVIfm8PNcNS1qzbLHSyqpULJaiPHJE8exLZ1C2Odba+H6wy
        x7vyn3U5HKOAFZdtQZPIIryxTiGnsq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624435848;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wUSXtAyfCTHluwzt1Ag75fz9EwMswluyA6LLKhKGOro=;
        b=ZSMoA6u9NzhAtAjbE1BkgNfUtXqR9NE52G93mRoU/M/PXBJGiC5rQVVW0s/zYtIrDPmxaS
        Qh5/n9//sn/km/BQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id iatGKYjs0mBEFAAALh3uQQ
        (envelope-from <bp@suse.de>); Wed, 23 Jun 2021 08:10:48 +0000
Date:   Wed, 23 Jun 2021 10:10:42 +0200
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
Subject: Re: [patch V3 63/66] x86/fpu/signal: Split out the direct restore
 code
Message-ID: <YNLsgprAfL1Sy7uu@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143451.562513044@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143451.562513044@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:19:26PM +0200, Thomas Gleixner wrote:
> Prepare for smarter failure handling of the direct restore.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/fpu/signal.c |  110 +++++++++++++++++++++----------------------
>  1 file changed, 56 insertions(+), 54 deletions(-)
> 
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -249,10 +249,7 @@ sanitize_restored_user_xstate(union fpre
>  	}
>  }
>  
> -/*
> - * Restore the FPU state directly from the userspace signal frame.
> - */
> -static int restore_fpregs_from_user(void __user *buf, u64 xrestore, bool fx_only)
> +static int restore_hwregs_from_user(void __user *buf, u64 xrestore, bool fx_only)

Or simply

	__restore_fpregs_from_user

to denote it is the low-level helper like the rest of the code does
around here.

>  {
>  	if (use_xsave()) {
>  		u64 init_bv = xfeatures_mask_uabi() & ~xrestore;
> @@ -273,6 +270,56 @@ static int restore_fpregs_from_user(void
>  	}
>  }
>  
> +static int restore_fpregs_from_user(void __user *buf, u64 xrestore, bool fx_only)
> +{
> +	struct fpu *fpu = &current->thread.fpu;
> +	int ret ;
	       ^

superfluous space.


> +	fpregs_lock();
> +	pagefault_disable();
> +	ret = restore_hwregs_from_user(buf, xrestore, fx_only);
> +	pagefault_enable();
> +
> +	if (unlikely(ret)) {
> +		/*
> +		 * The above did an FPU restore operation, restricted to
> +		 * the user portion of the registers, and failed, but the
> +		 * microcode might have modified the FPU registers
> +		 * nevertheless.
> +		 *
> +		 * If the FPU registers do not belong to current, then
> +		 * invalidate the FPU register state otherwise the task
> +		 * might preempt current and return to user space with
> +		 * corrupted FPU registers.
> +		 *
> +		 * In case current owns the FPU registers then no further
> +		 * action is required. The fixup in the slow path will
> +		 * handle it correctly.
> +		 */
> +		if (test_thread_flag(TIF_NEED_FPU_LOAD))
> +			__cpu_invalidate_fpregs_state();
> +		fpregs_unlock();
> +		return ret;
> +	}
> +
> +	/*
> +	 * Restore supervisor states: previous context switch etc has done
> +	 * XSAVES and saved the supervisor states in the kernel buffer from
> +	 * which they can be restored now.
> +	 *
> +	 * We cannot do a single XRSTORS here - which would be nice -

Might wanna fix up the "We" brotherhood formulation, while at it. :)

> +	 * because the rest of the FPU registers are being restored from a
> +	 * user buffer directly. The single XRSTORS happens below, when the
> +	 * user buffer has been copied to the kernel one.
> +	 */
> +	if (test_thread_flag(TIF_NEED_FPU_LOAD) && xfeatures_mask_supervisor())
> +		os_xrstor(&fpu->state.xsave, xfeatures_mask_supervisor());
> +
> +	fpregs_mark_activate();
> +	fpregs_unlock();
> +	return 0;

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
