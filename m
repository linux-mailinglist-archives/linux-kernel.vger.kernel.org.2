Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D033F6269
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbhHXQK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:10:58 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41244 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232300AbhHXQKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:10:55 -0400
Received: from zn.tnic (p200300ec2f11440049ee8a07127e6a59.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:4400:49ee:8a07:127e:6a59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 589881EC046C;
        Tue, 24 Aug 2021 18:10:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629821405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OfTc1qD5QEzHX66sy7oSqCLaN3XZ+0WymwWC2y0O8Ok=;
        b=RhEK0K0KsECKdd9IdOXaHrbQ1KITetii0T6wcrH4AIK1PK66jcUkguM566m6uc6W6QEg16
        yAaDJBf3rWLzk8g5VLHgDsMThOxsA8+omCsmMwDtoDd+0Q2fVRcL4ZRK/0rSllPs7X7izE
        6OJbfWkU1gsglQXVU03SXozXl1em+LE=
Date:   Tue, 24 Aug 2021 18:10:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 08/12] x86/tdx: Add HLT support for TDX guest
Message-ID: <YSUaAQPiBUqubBHM@zn.tnic>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-9-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210804181329.2899708-9-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 11:13:25AM -0700, Kuppuswamy Sathyanarayanan wrote:
> @@ -240,6 +243,32 @@ SYM_FUNC_START(__tdx_hypercall)
>  
>  	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
>  
> +	/*
> +	 * For the idle loop STI needs to be called directly before
> +	 * the TDCALL that enters idle (EXIT_REASON_HLT case). STI
> +	 * enables interrupts only one instruction later. If there
> +	 * are any instructions between the STI and the TDCALL for
> +	 * HLT then an interrupt could happen in that time, but the
> +	 * code would go back to sleep afterwards, which can cause
> +	 * longer delays.

<-- newline in the comment here for better readability.

> There leads to significant difference in

"There leads..." ?

> +	 * network performance benchmarks. So add a special case for
> +	 * EXIT_REASON_HLT to trigger sti before TDCALL. But this
> +	 * change is not required for all HLT cases. So use R15
> +	 * register value to identify the case which needs sti. So,

s/sti/STI/g

> +	 * if R11 is EXIT_REASON_HLT and R15 is 1, then call sti
> +	 * before TDCALL instruction. Note that R15 register is not
> +	 * required by TDCALL ABI when triggering the hypercall for
> +	 * EXIT_REASON_HLT case. So use it in software to select the
> +	 * sti case.
> +	 */
> +	cmpl $EXIT_REASON_HLT, %r11d
> +	jne skip_sti
> +	cmpl $1, %r15d
> +	jne skip_sti
> +	/* Set R15 register to 0, it is unused in EXIT_REASON_HLT case */
> +	xor %r15, %r15
> +	sti
> +skip_sti:
>  	tdcall

...

> +static __cpuidle void tdg_safe_halt(void)
> +{
> +	u64 ret;
> +
> +	/*
> +	 * Enable interrupts next to the TDVMCALL to avoid
> +	 * performance degradation.

That comment needs some more love to say exactly what the problem is.

> +	 */
> +	local_irq_enable();
> +
> +	/* IRQ is enabled, So set R12 as 0 */
> +	ret = _tdx_hypercall(EXIT_REASON_HLT, 0, 0, 0, 1, NULL);
> +
> +	/* It should never fail */
> +	BUG_ON(ret);
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
