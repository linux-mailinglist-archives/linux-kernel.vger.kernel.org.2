Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7903AAF39
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhFQJCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:02:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54928 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhFQJCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:02:31 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D466821AFA;
        Thu, 17 Jun 2021 09:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623920423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OXnc0QxqbzQdECokp6uvOK9ZrPSnhBPf8VAewf6sgb8=;
        b=fh72KYVP2TJ8/KVv5GwKZ2muCoCKEf1oiCsy1qkdq2V6l8/3rH/ekC0iVkMzUAdma9vqGL
        EiUE5Po8beYPhzUYzwqW8egEWLVR7iemkN0fOGQhuZUDcbvThYKGa1851Ua7khsKbL/V1t
        wD73zviFTzEeQiu2JusJz8AGZaALNIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623920423;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OXnc0QxqbzQdECokp6uvOK9ZrPSnhBPf8VAewf6sgb8=;
        b=PCwD1JawslyDmSBkQZLGGkke8L3BELlHRTNy/JwZpYix3TdUf+qW+w9cqMgU0MjPdbOQ51
        ZCal86g2zIo+2SDQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id C26BB118DD;
        Thu, 17 Jun 2021 09:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623920423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OXnc0QxqbzQdECokp6uvOK9ZrPSnhBPf8VAewf6sgb8=;
        b=fh72KYVP2TJ8/KVv5GwKZ2muCoCKEf1oiCsy1qkdq2V6l8/3rH/ekC0iVkMzUAdma9vqGL
        EiUE5Po8beYPhzUYzwqW8egEWLVR7iemkN0fOGQhuZUDcbvThYKGa1851Ua7khsKbL/V1t
        wD73zviFTzEeQiu2JusJz8AGZaALNIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623920423;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OXnc0QxqbzQdECokp6uvOK9ZrPSnhBPf8VAewf6sgb8=;
        b=PCwD1JawslyDmSBkQZLGGkke8L3BELlHRTNy/JwZpYix3TdUf+qW+w9cqMgU0MjPdbOQ51
        ZCal86g2zIo+2SDQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id oRhtLicPy2CzNwAALh3uQQ
        (envelope-from <bp@suse.de>); Thu, 17 Jun 2021 09:00:23 +0000
Date:   Thu, 17 Jun 2021 10:59:55 +0200
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
Subject: Re: [patch V2 15/52] x86/fpu: Use copy_uabi_xstate_to_membuf() in
 xfpregs_get()
Message-ID: <YMsPCyL8YkT9W+9o@zn.tnic>
References: <20210614154408.673478623@linutronix.de>
 <20210614155355.241932488@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210614155355.241932488@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 05:44:23PM +0200, Thomas Gleixner wrote:
> Use the new functionality of copy_uabi_xstate_to_membuf() to retrieve the
> FX state when XSAVE* is in use. This avoids to overwrite the FPU state

					avoids overwriting...

> buffer with fpstate_sanitize_xstate() which is error prone and duplicated
> code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: New patch
> ---
>  arch/x86/kernel/fpu/regset.c |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> --- a/arch/x86/kernel/fpu/regset.c
> +++ b/arch/x86/kernel/fpu/regset.c
> @@ -33,13 +33,18 @@ int xfpregs_get(struct task_struct *targ

So AFAICT, this thing is called by PTRACE_GETFPREGS but looking at ltp:

$ git grep PTRACE_GETFPREGS
$

so this is used - if at all used - by some super duper old binaries
somewhere.

manpage says "PTRACE_GETREGS and PTRACE_GETFPREGS are not present on all
architectures." which could explain why. I wonder if we should add some
stupid test cases so that we can at least exercise this...

>  	struct fpu *fpu = &target->thread.fpu;
>  
> -	if (!boot_cpu_has(X86_FEATURE_FXSR))
> +	if (!static_cpu_has(X86_FEATURE_FXSR))

cpu_feature_enabled

>  		return -ENODEV;
>  
>  	fpu__prepare_read(fpu);
> -	fpstate_sanitize_xstate(fpu);
>  
> -	return membuf_write(&to, &fpu->state.fxsave, sizeof(struct fxregs_state));
> +	if (!use_xsave()) {
> +		return membuf_write(&to, &fpu->state.fxsave,
> +				    sizeof(fpu->state.fxsave));
> +	}
> +
> +	copy_uabi_xstate_to_membuf(to, &fpu->state.xsave, XSTATE_COPY_FX);
> +	return 0;

With the above nitpicks addressed:

Reviewed-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
