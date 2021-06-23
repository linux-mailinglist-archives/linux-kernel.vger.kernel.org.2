Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626CE3B15DF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 10:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFWIc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 04:32:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46326 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhFWIc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:32:57 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 265B81FD65;
        Wed, 23 Jun 2021 08:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624437040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pfxXoE59vW3i1oXCb2xd4QXiuJGD7urPR2kxDFn8kuI=;
        b=BJhsgxEsGfh6+c3uQ4zEZa7elBrHzQFb0fwvZNmLKzfSCfyh5thvSppQ5roUC7CFOAbIld
        dVVFqpzBjd/R3x+BKzDpgNPcsix2tKOSTD2gKPHa9IdlHCzHv3YhhDrzFRMtUV1gjK9Bh7
        mBWx+G/rhivkoxBc7FlGqONmblxfYd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624437040;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pfxXoE59vW3i1oXCb2xd4QXiuJGD7urPR2kxDFn8kuI=;
        b=q6sUNhPtTH27ShfQMUxpfpjd8iDRQfjYBR9HhDCy7cOKqz1RXJAfAQJrl0r/3HvzELgphe
        IgeAZWmCJ5P4OkAw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 10E9711A97;
        Wed, 23 Jun 2021 08:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624437040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pfxXoE59vW3i1oXCb2xd4QXiuJGD7urPR2kxDFn8kuI=;
        b=BJhsgxEsGfh6+c3uQ4zEZa7elBrHzQFb0fwvZNmLKzfSCfyh5thvSppQ5roUC7CFOAbIld
        dVVFqpzBjd/R3x+BKzDpgNPcsix2tKOSTD2gKPHa9IdlHCzHv3YhhDrzFRMtUV1gjK9Bh7
        mBWx+G/rhivkoxBc7FlGqONmblxfYd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624437040;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pfxXoE59vW3i1oXCb2xd4QXiuJGD7urPR2kxDFn8kuI=;
        b=q6sUNhPtTH27ShfQMUxpfpjd8iDRQfjYBR9HhDCy7cOKqz1RXJAfAQJrl0r/3HvzELgphe
        IgeAZWmCJ5P4OkAw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id V37wAjDx0mAyHwAALh3uQQ
        (envelope-from <bp@suse.de>); Wed, 23 Jun 2021 08:30:40 +0000
Date:   Wed, 23 Jun 2021 10:30:32 +0200
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
Subject: Re: [patch V3 64/66] x86/fpu: Return proper error codes from user
 access functions
Message-ID: <YNLxKB9a6XQHW+w3@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143451.682092608@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143451.682092608@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:19:27PM +0200, Thomas Gleixner wrote:
> When *RSTOR from user memory raises an exception there is no way to
> differentiate them. That's bad because it forces the slow path even when
> the failure was not a fault. If the operation raised eg. #GP then going
> through the slow path is pointless.
> 
> Use _ASM_EXTABLE_FAULT() which stores the trap number and let the exception
> fixup return the negated trap number as error.
> 
> This allows to seperate the fast path and let it handle faults directly and

separate

> avoid the slow path for all other exceptions.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/fpu/internal.h |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -87,6 +87,7 @@ extern void fpstate_init_soft(struct swr
>  static inline void fpstate_init_soft(struct swregs_state *soft) {}
>  #endif
>  
> +/* Returns 0 or the negated trap number, which results in -EFAULT for #PF */
>  #define user_insn(insn, output, input...)				\
>  ({									\
>  	int err;							\
> @@ -94,14 +95,14 @@ static inline void fpstate_init_soft(str
>  	might_fault();							\
>  									\
>  	asm volatile(ASM_STAC "\n"					\
> -		     "1:" #insn "\n\t"					\
> +		     "1: " #insn "\n"					\
>  		     "2: " ASM_CLAC "\n"				\
>  		     ".section .fixup,\"ax\"\n"				\
> -		     "3:  movl $-1,%[err]\n"				\
> +		     "3:  negl %%eax\n"					\
>  		     "    jmp  2b\n"					\
>  		     ".previous\n"					\
> -		     _ASM_EXTABLE(1b, 3b)				\
> -		     : [err] "=r" (err), output				\
> +		     _ASM_EXTABLE_FAULT(1b, 3b)				\
> +		     : [err] "=a" (err), output				\
>  		     : "0"(0), input);					\
>  	err;								\

Don't we wanna do the same for XSTATE_OP() too?

Because restore_hwregs_from_user() could call
xrstor_from_user_sigframe() too which ends up doing XRSTOR and latter
can cause a #PF too.

Hmm.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
