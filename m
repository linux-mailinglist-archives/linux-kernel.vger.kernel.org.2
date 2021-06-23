Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1419F3B1620
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 10:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFWIrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 04:47:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55328 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFWIr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:47:29 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4806921971;
        Wed, 23 Jun 2021 08:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624437911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cE4bYv+K1a7sv52v46zmtwHcACNaYAGxMXHAvz0lsFc=;
        b=XdfY4sc4xWI2HTg0TDm9NQAoNiKU8ylIL8iqkvaGvjVwBpN0oF8DF2TVrvfkjHXL+wHv9b
        4u/B0V71Rf2L8Dn3/+WdO3BVwbi9ftfOBCSpPjV5t8hPBnTZk89FF9EiF6+2IQbDdEff7B
        4ax0Dga4uiUox2ZV5aBXt5XA9xKihsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624437911;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cE4bYv+K1a7sv52v46zmtwHcACNaYAGxMXHAvz0lsFc=;
        b=hQF/ypcJP95FN5mlNb1Yt2ZxxXLDCH8Psd0bsrZVybnRX8ielOdixLXPLL+296+PJxI5Rg
        9j8EBHSCwNHeZ4Aw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 32B9C11A97;
        Wed, 23 Jun 2021 08:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624437911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cE4bYv+K1a7sv52v46zmtwHcACNaYAGxMXHAvz0lsFc=;
        b=XdfY4sc4xWI2HTg0TDm9NQAoNiKU8ylIL8iqkvaGvjVwBpN0oF8DF2TVrvfkjHXL+wHv9b
        4u/B0V71Rf2L8Dn3/+WdO3BVwbi9ftfOBCSpPjV5t8hPBnTZk89FF9EiF6+2IQbDdEff7B
        4ax0Dga4uiUox2ZV5aBXt5XA9xKihsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624437911;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cE4bYv+K1a7sv52v46zmtwHcACNaYAGxMXHAvz0lsFc=;
        b=hQF/ypcJP95FN5mlNb1Yt2ZxxXLDCH8Psd0bsrZVybnRX8ielOdixLXPLL+296+PJxI5Rg
        9j8EBHSCwNHeZ4Aw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id Hde3C5f00mC1JgAALh3uQQ
        (envelope-from <bp@suse.de>); Wed, 23 Jun 2021 08:45:11 +0000
Date:   Wed, 23 Jun 2021 10:45:04 +0200
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
Subject: Re: [patch V3 65/66] x86/fpu/signal: Handle #PF in the direct
 restore path
Message-ID: <YNL0kPkir7+sQVoO@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143451.783907985@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143451.783907985@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:19:28PM +0200, Thomas Gleixner wrote:
> If *RSTOR raises an exception, then the slow path is taken. That's wrong
> because if the reason was not #PF then going through the slow path is waste
> of time because that will end up with the same conclusion that the data is
> invalid.
> 
> Now that the wrapper around *RSTOR return an negative error code, which is
> the negated trap number, it's possible to differentiate.
> 
> If the *RSTOR raised #PF then handle it directly in the fast path and if it
> was some other exception, e.g. #GP, then give up and do not try the fast
> path.
> 
> This removes the legacy frame FRSTOR code from the slow path because FRSTOR
> is not a ia32_fxstate frame and is therefore handled in the fast path.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/fpu/signal.c |   65 ++++++++++++++++++++-----------------------
>  1 file changed, 31 insertions(+), 34 deletions(-)
> 
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -270,11 +270,17 @@ static int restore_hwregs_from_user(void
>  	}
>  }
>  
> -static int restore_fpregs_from_user(void __user *buf, u64 xrestore, bool fx_only)
> +/*
> + * Attempt to restore the FPU registers directly from user memory.
> + * Pagefaults are handled and any errors returned are fatal.
> + */
> +static int restore_fpregs_from_user(void __user *buf, u64 xrestore,
> +				    bool fx_only, unsigned int size)
>  {
>  	struct fpu *fpu = &current->thread.fpu;
>  	int ret ;
>  
> +retry:
>  	fpregs_lock();
>  	pagefault_disable();
>  	ret = restore_hwregs_from_user(buf, xrestore, fx_only);
> @@ -291,15 +297,16 @@ static int restore_fpregs_from_user(void
>  		 * invalidate the FPU register state otherwise the task
>  		 * might preempt current and return to user space with
>  		 * corrupted FPU registers.
> -		 *
> -		 * In case current owns the FPU registers then no further
> -		 * action is required. The fixup in the slow path will
> -		 * handle it correctly.
>  		 */
>  		if (test_thread_flag(TIF_NEED_FPU_LOAD))
>  			__cpu_invalidate_fpregs_state();
>  		fpregs_unlock();
> -		return ret;
> +
> +		if (ret == -EFAULT)
> +			ret = fault_in_pages_readable(buf, size);
> +		if (!ret)
> +			goto retry;
> +		return ret == -EFAULT ? ret : -EINVAL;

Uuuh, this is gonna make people stop and think, with all those different
ret assignments and cases. :)

In any case, __fpu_restore_sig() is starting to become somewhat saner
again, nice!

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
