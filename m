Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003203AEC65
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFUPcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:32:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57110 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhFUPcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:32:32 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 45D831FD3D;
        Mon, 21 Jun 2021 15:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624289417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fbUjd4Dn1lEYNmAX1UGERXtZ58wKrqzYxp+NDjL0tqc=;
        b=qWa/6emWYwO7sLVVgDSFBcxCGOZ4TUmyO1/jhy/MlVFG5256Firl7RaM3Yst9DYjVS2bY2
        EMMO901xah/A09q7Ms9R7PwJSxL+CKQ6/vaK0hk7e0JF8u9s9juy7Wv5UXmp7yz2zk/6r5
        OUXCiZCuLrmclbfACn2NshRD8fUAd6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624289417;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fbUjd4Dn1lEYNmAX1UGERXtZ58wKrqzYxp+NDjL0tqc=;
        b=x8jwFDYF5ZXZqhNzNaoR8dFuMcIPZMPon+O1/S4BZkvjtdR+6KCdMNqNBYlySYF4ZyTqAN
        WHHF63E7fP8ciaAA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 2DC4F118DD;
        Mon, 21 Jun 2021 15:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624289417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fbUjd4Dn1lEYNmAX1UGERXtZ58wKrqzYxp+NDjL0tqc=;
        b=qWa/6emWYwO7sLVVgDSFBcxCGOZ4TUmyO1/jhy/MlVFG5256Firl7RaM3Yst9DYjVS2bY2
        EMMO901xah/A09q7Ms9R7PwJSxL+CKQ6/vaK0hk7e0JF8u9s9juy7Wv5UXmp7yz2zk/6r5
        OUXCiZCuLrmclbfACn2NshRD8fUAd6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624289417;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fbUjd4Dn1lEYNmAX1UGERXtZ58wKrqzYxp+NDjL0tqc=;
        b=x8jwFDYF5ZXZqhNzNaoR8dFuMcIPZMPon+O1/S4BZkvjtdR+6KCdMNqNBYlySYF4ZyTqAN
        WHHF63E7fP8ciaAA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id U/NdC4mw0GC1EgAALh3uQQ
        (envelope-from <bp@suse.de>); Mon, 21 Jun 2021 15:30:17 +0000
Date:   Mon, 21 Jun 2021 17:30:07 +0200
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
Subject: Re: [patch V3 22/66] x86/fpu: Move fpu__write_begin() to regset
Message-ID: <YNCwf72K3LH6J8/T@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143446.905002907@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143446.905002907@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:18:45PM +0200, Thomas Gleixner wrote:
> The only usecase for fpu__write_begin is the set() callback of regset, so
> the function is pointlessly global.
> 
> Move it to the regset code and rename it to fpu_force_restore() which is
> exactly decribing what the function does.

And makes the _set() callbacks a lot more readable, nice!

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/fpu/internal.h |    1 -
>  arch/x86/kernel/fpu/core.c          |   24 ------------------------
>  arch/x86/kernel/fpu/regset.c        |   25 ++++++++++++++++++++++---
>  3 files changed, 22 insertions(+), 28 deletions(-)

...

> --- a/arch/x86/kernel/fpu/regset.c
> +++ b/arch/x86/kernel/fpu/regset.c
> @@ -44,6 +44,25 @@ static void fpu_sync_fpstate(struct fpu
>  		fpu__save(fpu);
>  }
>  
> +/*
> + * Invalidate cached FPU registers before modifying the stopped target
> + * task's fpstate.
> + *
> + * This forces the target task on resume to restore the FPU registers from
> + * modified fpstate. Otherwise the task might skip the restore and operate
> + * with the cached FPU registers which discards the modifications.
> + */
> +static void fpu_force_restore(struct fpu *fpu)
> +{
> +	/*
> +	 * Only stopped child tasks can be used to modify the FPU
> +	 * state in the fpstate buffer:
> +	 */
> +	WARN_ON_FPU(fpu == &current->thread.fpu);
> +
> +	__fpu_invalidate_fpregs_state(fpu);
> +}
> +
>  int xfpregs_get(struct task_struct *target, const struct user_regset *regset,
>  		struct membuf to)
>  {
> @@ -89,7 +108,7 @@ int xfpregs_set(struct task_struct *targ
>  	if (newstate.mxcsr & ~mxcsr_feature_mask)
>  		ret = -EINVAL;
		^^^^^^^^^^^^^^

Don't forget to fix that thing, btw.

> -	fpu__prepare_write(fpu);
> +	fpu_force_restore(fpu);
>  
>  	/* Copy the state  */
>  	memcpy(&fpu->state.fxsave, &newstate, sizeof(newstate));
> @@ -147,7 +166,7 @@ int xstateregs_set(struct task_struct *t
>  		}
>  	}
>  
> -	fpu__prepare_write(fpu);
> +	fpu_force_restore(fpu);
>  	ret = copy_kernel_to_xstate(&fpu->state.xsave, kbuf ?: tmpbuf);

Ok, this here:

fpu_force_restore() will unconditionally invalidate the fpregs but the
following copy_kernel_to_xstate() call can return -EINVAL when the
xstate header validation fails or mxcsr has reserved bits set so we will
not have copied anything to the target thread.

Or do we say this is a slowpath so we don't care?

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
