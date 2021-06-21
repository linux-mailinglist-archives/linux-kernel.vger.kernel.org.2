Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B423AF8E7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 01:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhFUXCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 19:02:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35034 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhFUXCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 19:02:42 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B8B4A21982;
        Mon, 21 Jun 2021 23:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624316426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3K1dlxw4pZvRNkxBYF/NpgqSiBM3SAEbx0za59H56/k=;
        b=n2Hp1pIBWqAWsVuaHfL1R929W0T3OlFhTzQd0px/Ybu3g8OQVoAXrtjWZ26ZkQ64IrDQw+
        7pLHL26PksO3wqy3MVgYedlgg7T8IwrmURMWrlp/gC1Fzy2jU4cba2HW9v7D1MneZWn5xm
        lrdDDG0xAqXCmWmu/FZs936M6Hdp0fo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624316426;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3K1dlxw4pZvRNkxBYF/NpgqSiBM3SAEbx0za59H56/k=;
        b=0P2BYq1yzEM+7Q7NjUuKabZdgB5DEa8UMiv1Ob836pCwTv7YvKo9T9/5P8Hkd9/+udCrKB
        q+RiCzxoN+UQ3ICw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 9CAC6118DD;
        Mon, 21 Jun 2021 23:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624316426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3K1dlxw4pZvRNkxBYF/NpgqSiBM3SAEbx0za59H56/k=;
        b=n2Hp1pIBWqAWsVuaHfL1R929W0T3OlFhTzQd0px/Ybu3g8OQVoAXrtjWZ26ZkQ64IrDQw+
        7pLHL26PksO3wqy3MVgYedlgg7T8IwrmURMWrlp/gC1Fzy2jU4cba2HW9v7D1MneZWn5xm
        lrdDDG0xAqXCmWmu/FZs936M6Hdp0fo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624316426;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3K1dlxw4pZvRNkxBYF/NpgqSiBM3SAEbx0za59H56/k=;
        b=0P2BYq1yzEM+7Q7NjUuKabZdgB5DEa8UMiv1Ob836pCwTv7YvKo9T9/5P8Hkd9/+udCrKB
        q+RiCzxoN+UQ3ICw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id +KezJQoa0WBPRQAALh3uQQ
        (envelope-from <bp@suse.de>); Mon, 21 Jun 2021 23:00:26 +0000
Date:   Tue, 22 Jun 2021 01:00:14 +0200
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
Subject: Re: [patch V3 29/66] x86/fpu: Rename fxregs related copy functions
Message-ID: <YNEZ/qksqvjgmJLZ@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143447.676670973@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143447.676670973@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:18:52PM +0200, Thomas Gleixner wrote:
> The function names for fxsave/fxrstor operations are horribly named and
> a permanent source of confusion.
> 
> Rename:
> 	copy_fxregs_to_kernel() to fxsave()
> 	copy_kernel_to_fxregs() to fxrstor()
> 	copy_fxregs_to_user() to fxsave_to_user_sigframe()
> 	copy_user_to_fxregs() to fxrstor_from_user_sigframe()
> 
> so it's clear what these are doing. All these functions are really low
> level wrappers around the equaly named instructions, so mapping to the
> documentation is just natural.
> 
> While at it replace the static_cpu_has(X86_FEATURE_FXSR) with use_fxsr() to
> be consistent with the rest of the code.

I think you mean with this...

> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -107,7 +107,7 @@ int copy_fpregs_to_fpstate(struct fpu *f
>  	}
>  
>  	if (likely(use_fxsr())) {
> -		copy_fxregs_to_kernel(fpu);
> +		fxsave(&fpu->state.fxsave);
>  		return 1;
>  	}
>  
> @@ -360,7 +360,7 @@ static inline void copy_init_fpstate_to_
>  	if (use_xsave())
>  		os_xrstor(&init_fpstate.xsave, features_mask);
>  	else if (static_cpu_has(X86_FEATURE_FXSR))
> -		copy_kernel_to_fxregs(&init_fpstate.fxsave);
> +		fxrstor(&init_fpstate.fxsave);
>  	else
>  		copy_kernel_to_fregs(&init_fpstate.fsave);
>  

... this else if branch here. IOW, it should be:

	...
	else if (use_fxsr())
		fxrstor(&init_fpstate.fxsave);

		...


Gnight!

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
