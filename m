Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE9E3A87E5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhFORnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:43:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51296 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhFORnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:43:00 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4BD7221A62;
        Tue, 15 Jun 2021 17:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623778855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bd9ZGnUHEBK7lgiBT0DUsGcTVfKNMNmVpmEg/gStdvE=;
        b=iekzqTVHLlSbRlXJVDwwcmO0FYwmx1l12l5MGhvhEg6eRnYMtfNG6hg/PoMOC/3zAucH4i
        R4fmrKXOWwm8M/h9MTPOrWbqVkct+SeTg4E00Bdl5eCM/btdNHO6IvSCxW40KfA9C7VlWk
        qETqefLuLSdFmHcen7RlXVIXz7deVco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623778855;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bd9ZGnUHEBK7lgiBT0DUsGcTVfKNMNmVpmEg/gStdvE=;
        b=u4lIbYf6GCAUr2m8NRlCiUGlR2T0v3LUx/PzeL9W+Coa8NzAvmFBTHkZz0EhJcNt9KNONh
        L4JmxeMzTB3SaqDg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 374D5118DD;
        Tue, 15 Jun 2021 17:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623778855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bd9ZGnUHEBK7lgiBT0DUsGcTVfKNMNmVpmEg/gStdvE=;
        b=iekzqTVHLlSbRlXJVDwwcmO0FYwmx1l12l5MGhvhEg6eRnYMtfNG6hg/PoMOC/3zAucH4i
        R4fmrKXOWwm8M/h9MTPOrWbqVkct+SeTg4E00Bdl5eCM/btdNHO6IvSCxW40KfA9C7VlWk
        qETqefLuLSdFmHcen7RlXVIXz7deVco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623778855;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bd9ZGnUHEBK7lgiBT0DUsGcTVfKNMNmVpmEg/gStdvE=;
        b=u4lIbYf6GCAUr2m8NRlCiUGlR2T0v3LUx/PzeL9W+Coa8NzAvmFBTHkZz0EhJcNt9KNONh
        L4JmxeMzTB3SaqDg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id CMhRDCfmyGDuHwAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 15 Jun 2021 17:40:55 +0000
Date:   Tue, 15 Jun 2021 19:40:45 +0200
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
Subject: Re: [patch V2 08/52] x86/fpu: Sanitize xstateregs_set()
Message-ID: <YMjmHcW1HPbHfkMF@zn.tnic>
References: <20210614154408.673478623@linutronix.de>
 <20210614155354.534061373@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210614155354.534061373@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 05:44:16PM +0200, Thomas Gleixner wrote:
> @@ -108,10 +110,10 @@ int xstateregs_set(struct task_struct *t
>  		  const void *kbuf, const void __user *ubuf)
>  {
>  	struct fpu *fpu = &target->thread.fpu;
> -	struct xregs_state *xsave;
> +	struct xregs_state *tmpbuf = NULL;
>  	int ret;
>  
> -	if (!boot_cpu_has(X86_FEATURE_XSAVE))
> +	if (!static_cpu_has(X86_FEATURE_XSAVE))

cpu_feature_enabled() - we're going to use only that thing from now on
for simplicity.

> +	if (!kbuf) {
> +		tmpbuf = vmalloc(count);
> +		if (!tmpbuf)
> +			return -ENOMEM;
> +
> +		if (copy_from_user(tmpbuf, ubuf, count)) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
>  	}
>  
> -	/*
> -	 * mxcsr reserved bits must be masked to zero for security reasons.
> -	 */
> -	xsave->i387.mxcsr &= mxcsr_feature_mask;
> -
> -	/*
> -	 * In case of failure, mark all states as init:
> -	 */
> -	if (ret)
> -		fpstate_init(&fpu->state);
> +	fpu__prepare_write(fpu);

Yikes, why isn't this function called

fpu_invalidate_state(fpu)

?!

As in, what it does...

> @@ -1196,14 +1196,16 @@ int copy_kernel_to_xstate(struct xregs_s
>  	 */
>  	xsave->header.xfeatures |= hdr.xfeatures;
>  
> +	/* mxcsr reserved bits must be masked to zero for historical reasons. */

Wasn't that comment supposed to get some love?

https://lkml.kernel.org/r/87k0n0w3p8.ffs@nanos.tec.linutronix.de

> +	xsave->i387.mxcsr &= mxcsr_feature_mask;
> +

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
