Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4D63AE6EB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 12:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhFUKWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 06:22:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58032 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhFUKWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 06:22:30 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C3A031FD3D;
        Mon, 21 Jun 2021 10:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624270814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mGh2OZ+sU4YiZUPVUoCzIXLtAvtO7WYOIp/iaCBtXuA=;
        b=DvW648oTZiOMEIWxTmgurzNn+h3bgEIsQCnn4D4JaFHcp2X1KsBf0+XjehNWUYEfHepW5y
        foR/c0OoZ0Lc9XgND88cyDxsAHvmnTAGZkUEPgQnGvZZt2arPhRhy03qPFhVvO1ws0DN8W
        h7kgIlgOUAdWp3yb9L4bDrMZupjqXQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624270814;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mGh2OZ+sU4YiZUPVUoCzIXLtAvtO7WYOIp/iaCBtXuA=;
        b=WgsvjjWcmT3L3DieEOUyWv3HBHM8Ypdoi8a6qwPbhPWk28b/GMwwog+HLEVxfh8ewgBInv
        RULm+ucz40zCjtAQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id B0313118DD;
        Mon, 21 Jun 2021 10:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624270814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mGh2OZ+sU4YiZUPVUoCzIXLtAvtO7WYOIp/iaCBtXuA=;
        b=DvW648oTZiOMEIWxTmgurzNn+h3bgEIsQCnn4D4JaFHcp2X1KsBf0+XjehNWUYEfHepW5y
        foR/c0OoZ0Lc9XgND88cyDxsAHvmnTAGZkUEPgQnGvZZt2arPhRhy03qPFhVvO1ws0DN8W
        h7kgIlgOUAdWp3yb9L4bDrMZupjqXQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624270814;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mGh2OZ+sU4YiZUPVUoCzIXLtAvtO7WYOIp/iaCBtXuA=;
        b=WgsvjjWcmT3L3DieEOUyWv3HBHM8Ypdoi8a6qwPbhPWk28b/GMwwog+HLEVxfh8ewgBInv
        RULm+ucz40zCjtAQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id kIgqKt5n0GCSZgAALh3uQQ
        (envelope-from <bp@suse.de>); Mon, 21 Jun 2021 10:20:14 +0000
Date:   Mon, 21 Jun 2021 12:20:03 +0200
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
Subject: Re: [patch V3 14/66] x86/fpu: Rewrite xfpregs_set()
Message-ID: <YNBn05LUC7GYtA0u@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143445.984906200@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143445.984906200@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:18:37PM +0200, Thomas Gleixner wrote:
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
> +	if (!cpu_feature_enabled(X86_FEATURE_FXSR))
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

Like the last time: you can let that line stick out - it fits within 80
cols.

With that:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
