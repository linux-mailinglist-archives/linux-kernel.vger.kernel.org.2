Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B147C426F93
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 19:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbhJHRdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 13:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhJHRde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 13:33:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CCAC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 10:31:39 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d56005271a08b055a2ed3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:5600:5271:a08b:55a:2ed3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BDB981EC051E;
        Fri,  8 Oct 2021 19:31:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633714297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KhlajtYxz4uxkGvv7MvDkO2RI4bEe41vosga3JrURI8=;
        b=jaCen8qLfftcWFq82RPCWSTvn46LuEZHpKhMycBLCfIHg0qc14Ew9/rn7p9XqsYW21cZVC
        ZBbnxNxTNmcyaqbt5SHrIYuBp+q5hUtiGyHSFDN0pJsJ2TVW3f/ZBK6bOWJ6qcuwPQnegQ
        ytCBExcNUynbc6qDr2xZ/7S6J1EK+7A=
Date:   Fri, 8 Oct 2021 19:31:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 07/11] x86/tdx: Add HLT support for TDX guest
Message-ID: <YWCAeCIYovTnqvbd@zn.tnic>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-8-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211005025205.1784480-8-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 07:52:01PM -0700, Kuppuswamy Sathyanarayanan wrote:
> @@ -240,6 +243,33 @@ SYM_FUNC_START(__tdx_hypercall)
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
> +	 *
> +	 * This leads to significant difference in network performance
> +	 * benchmarks. So add a special case for EXIT_REASON_HLT to
> +	 * trigger STI before TDCALL. But this change is not required
> +	 * for all HLT cases. So use R15 register value to identify the
> +	 * case which needs STI. So, if R11 is EXIT_REASON_HLT and R15
> +	 * is 1, then call STI before TDCALL instruction. Note that R15
> +	 * register is not required by TDCALL ABI when triggering the
> +	 * hypercall for EXIT_REASON_HLT case. So use it in software to
> +	 * select the STI case.
> +	 */
> +	cmpl $EXIT_REASON_HLT, %r11d
> +	jne skip_sti
> +	cmpl $1, %r15d
> +	jne skip_sti
> +	/* Set R15 register to 0, it is unused in EXIT_REASON_HLT case */
> +	xor %r15, %r15

Then you don't need to clear it either, right?

> +	sti
> +skip_sti:
>  	tdcall
>  
>  	/* Restore output pointer to R9 */

...

> +static __cpuidle void tdx_halt(void)
> +{
> +	const bool irq_disabled = irqs_disabled();
> +	const bool do_sti = false;
> +
> +	/*
> +	 * Non safe halt is mainly used in CPU off-lining
> +	 * and the guest will stay in halt state. So,
> +	 * STI instruction call is not required (set
> +	 * do_sti as false).
> +	 */

Just like you've done below, put the comment over the variable assignment:

        /*
         * Non safe halt is mainly used in CPU offlining  and the guest will stay in halt
         * state. So, STI instruction call is not required.
         */
        const bool do_sti = false;


> +	_tdx_halt(irq_disabled, do_sti);
> +}
> +
> +static __cpuidle void tdx_safe_halt(void)
> +{
> +	 /*
> +	  * Since STI instruction will be called in __tdx_hypercall()
> +	  * set irq_disabled as false.
> +	  */
> +	const bool irq_disabled = false;
> +	const bool do_sti = true;
> +
> +	_tdx_halt(irq_disabled, do_sti);
> +}
> +
>  unsigned long tdx_get_ve_info(struct ve_info *ve)
>  {
>  	struct tdx_module_output out = {0};

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
