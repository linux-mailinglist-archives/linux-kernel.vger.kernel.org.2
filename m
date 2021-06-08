Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F6D39FB04
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 17:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFHPm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhFHPmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:42:21 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E24C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 08:40:27 -0700 (PDT)
Received: from zn.tnic (p200300ec2f16b10061e36e09eea20757.dip0.t-ipconnect.de [IPv6:2003:ec:2f16:b100:61e3:6e09:eea2:757])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8DAA91EC0501;
        Tue,  8 Jun 2021 17:40:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623166825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=82i8txEp3ospV0ft/E9iYm41kfODaP6cCj7DPKidEAE=;
        b=Vc7dkd1n917Xr/SKeuCwQXYMxoShV+Nv9qgzeEVT90q4dUTMvQxAFfaBGYwxsbdyMODlKu
        EBd56rePBkws3GgEo1L9IBXy57rxDLIbXZYIC1/j9wmSSXTpFgOBcMw0wK0N7flc3h7zC2
        hgP2p2OI2AVk8bsUJAZHzIiEAEKdeQA=
Date:   Tue, 8 Jun 2021 17:40:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [patch V3 4/6] x86/pkru: Make PKRU=0 actually work
Message-ID: <YL+PYz/cZPhSVmf2@zn.tnic>
References: <20210608143617.565868844@linutronix.de>
 <20210608144346.045616965@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210608144346.045616965@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just typos:

On Tue, Jun 08, 2021 at 04:36:21PM +0200, Thomas Gleixner wrote:
> So that wreckages any copy_to/from_user() on the way back to user space

wrecks

> which hits memory which is protected by the default PKRU value.
> 
> Assumed that this does not fail (pure luck) then T1 goes back to user
> space and because TIF_NEED_FPU_LOAD is set it ends up in
> 
> switch_fpu_return()
>     __fpregs_load_activate()
>       if (!fpregs_state_valid()) {
> 	 load_XSTATE_from_task();
>       }
> 
> But if nothing touched the FPU between T1 scheduling out and in the
							       ^^

							s/in/if/ it seems.

> fpregs_state is valid so switch_fpu_return() does nothing and just clears
> TIF_NEED_FPU_LOAD. Back to user space with DEFAULT_PKRU loaded. -> FAIL #2!
> 
> The fix is simple: if get_xsave_addr() returns NULL then set the PKRU value
> to 0 instead of the restrictive default PKRU value.
> 
> Fixes: 0cecca9d03c9 ("x86/fpu: Eager switch PKRU state")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/include/asm/fpu/internal.h |   11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -579,9 +579,16 @@ static inline void switch_fpu_finish(str
>  	 * return to userland e.g. for a copy_to_user() operation.
>  	 */
>  	if (!(current->flags & PF_KTHREAD)) {
> +		/*
> +		 * If the PKRU bit in xsave.header.xfeatures is not set,
> +		 * then the PKRU compoment was in init state, which means
                                 ^^^^^^^^^

component

> +		 * XRSTOR will set PKRU to 0. If the bit is not set then
> +		 * get_xsave_addr() will return NULL because the PKRU value
> +		 * in memory is not valid. This means pkru_val has to be
> +		 * set to 0 and not to init_pkru_value.
> +		 */
>  		pk = get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
> -		if (pk)
> -			pkru_val = pk->pkru;
> +		pkru_val = pk ? pk->pkru : 0;
>  	}

Hohumm, let's see who cries out... :-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
