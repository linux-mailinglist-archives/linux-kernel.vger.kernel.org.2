Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07F34164D4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 20:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242706AbhIWSLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 14:11:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60444 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242152AbhIWSLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 14:11:31 -0400
Received: from zn.tnic (p200300ec2f0d6800010999bf90259edb.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6800:109:99bf:9025:9edb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 177BB1EC056D;
        Thu, 23 Sep 2021 20:09:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632420594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=P1NIfMbEKUHto8DXtgrPzDbmQRZhbi/Suj6rv7Lc25s=;
        b=YHn6LJJPut2Az8NapSiMh0YxdOPTrBNlzyos+YAOFNJJ087ctk2WkdIayauynLj5VnFsjv
        53iBWjTBqxo4wI4yyfuRU7UFGjWaUVYOxEbvx1hebin4k9i4He6IdPSBoMbDEBLsFyeU6y
        DmdnDlq39NzrZSApWW0ENFSqMY1U1n4=
Date:   Thu, 23 Sep 2021 20:09:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
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
Subject: Re: [PATCH v7 08/12] x86/tdx: Add HLT support for TDX guest
Message-ID: <YUzC7N8/MHI++y/G@zn.tnic>
References: <20210916183550.15349-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210916183550.15349-9-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210916183550.15349-9-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 11:35:46AM -0700, Kuppuswamy Sathyanarayanan wrote:
> +static __cpuidle void _tdx_halt(const bool irq_disabled, const bool do_sti)
> +{
> +	u64 ret;
> +
> +	/*
> +	 * Emulate HLT operation via hypercall. More info about ABI
> +	 * can be found in TDX Guest-Host-Communication Interface
> +	 * (GHCI), sec 3.8.

	"3.8 TDG.VP.VMCALL<Instruction.HLT>"

write that section name because those numbers do change.

> +	 *
> +	 * The VMM uses the "IRQ disabled" param to understand IRQ
> +	 * enabled status (RFLAGS.IF) of TD guest and determine
> +	 * whether or not it should schedule the halted vCPU if an
> +	 * IRQ becomes pending. E.g. if IRQs are disabled the VMM
> +	 * can keep the vCPU in virtual HLT, even if an IRQ is
> +	 * pending, without hanging/breaking the guest.
> +	 *
> +	 * do_sti parameter is used by __tdx_hypercall() to decide
> +	 * whether to call STI instruction before executing TDCALL
> +	 * instruction.
> +	 */
> +	ret = _tdx_hypercall(EXIT_REASON_HLT, irq_disabled, 0, 0, do_sti, NULL);

So that irq_disabled goes into r12. Nothing in that section 3.8 above
talks about r12. The doc version I'm looking at is:

344426-001US
SEPTEMBER 2020

Where is that "the IRQs in the guest were disabled/enabled" bit
documented?

> +
> +	/*
> +	 * Use WARN_ONCE() to report the failure. Since tdx_*halt() calls
> +	 * are also used in pv_ops, #VE handler error handler cannot be

one "handler"'s enough.

> +	 * used to report the failure.
> +	 */
> +	WARN_ONCE(ret, "HLT instruction emulation failed\n");
> +}
> +
> +static __cpuidle void tdx_halt(void)
> +{
> +	const bool irq_disabled = irqs_disabled();
> +	const bool do_sti = false;

What is the logic here?

This is not a safe halt so it doesn't matter to the TDX module whether
irqs are disabled or not?

That comment above is again keeping it to itself:

"But this change is not required for all HLT cases."

So for which cases is it required?

Is that explained in the comment in _tdx_halt() where irqs_disabled
tells the VMM what to do with the guest - to wake it up or to keep it in
virtual halt?

> +
> +	_tdx_halt(irq_disabled, do_sti);
> +}
> +
> +static __cpuidle void tdx_safe_halt(void)
> +{
> +	const bool irq_disabled = false; /* since sti will be called */

Comments usually go ontop not on the side.

> +	const bool do_sti = true;
> +
> +	_tdx_halt(irq_disabled, do_sti);
> +}
> +
>  unsigned long tdx_get_ve_info(struct ve_info *ve)
>  {
>  	struct tdx_module_output out = {0};

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
