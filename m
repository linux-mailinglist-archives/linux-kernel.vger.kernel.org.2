Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2813F689B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 20:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239818AbhHXSCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 14:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239149AbhHXSCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:02:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2019C061B3C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:48:00 -0700 (PDT)
Received: from zn.tnic (p200300ec2f114400ce3b938495d443bc.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:4400:ce3b:9384:95d4:43bc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 37E691EC04D1;
        Tue, 24 Aug 2021 19:47:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629827275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HaBtrWrajmGcfbWLYhDUsIXaLchGb1bstlD6N7edDYs=;
        b=g6VPThMZAQl+bN5jor6udrLQHslQI+kWjkakwucuN3cXS4VSEBJnQaGykKZw7VXPTuj4Yk
        sQq2QARrjzij8NZtkXOTwE+XyVBZbJ5DLqaZTd+mDSHj9VaekRNBGNdOerq3Q+Ne5yi1ui
        FNYhVfDNjhQoDort5l3IUEfHd3xabuo=
Date:   Tue, 24 Aug 2021 19:48:37 +0200
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
Subject: Re: [PATCH v5 12/12] x86/tdx: Handle CPUID via #VE
Message-ID: <YSUw9a7lzE+MB7ZW@zn.tnic>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-13-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210804181329.2899708-13-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 11:13:29AM -0700, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> TDX has three classes of CPUID leaves: some CPUID leaves
> are always handled by the CPU, others are handled by the TDX module,
> and some others are handled by the VMM. Since the VMM cannot directly
> intercept the instruction these are reflected with a #VE exception
> to the guest, which then converts it into a hypercall to the VMM,
> or handled directly.
> 
> The TDX module EAS has a full list of CPUID leaves which are handled

EAS?

> natively or by the TDX module in 16.2. Only unknown CPUIDs are handled by

16.2?

I believe that commit message was forgotten to be converted to
outside-Intel speak. Please do so.

> the #VE method. In practice this typically only applies to the
> hypervisor specific CPUIDs unknown to the native CPU.

hypervisor-specific

> Therefore there is no risk of causing this in early CPUID code which
> runs before the #VE handler is set up because it will never access
> those exotic CPUID leaves.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> 
> Changes since v4:
>  * None
> 
> Changes since v3:
>  * None
> 
>  arch/x86/kernel/tdx.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index d16c7f8759ea..5d2fd6c8b01c 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -153,6 +153,21 @@ static int tdg_write_msr_safe(unsigned int msr, unsigned int low,
>  	return ret ? -EIO : 0;
>  }
>  
> +static void tdg_handle_cpuid(struct pt_regs *regs)
> +{
> +	u64 ret;
> +	struct tdx_hypercall_output out = {0};
> +
> +	ret = _tdx_hypercall(EXIT_REASON_CPUID, regs->ax, regs->cx, 0, 0, &out);
> +
> +	WARN_ON(ret);

Why warn and not forward the error, instead, so that it lands in
ve_raise_fault() ?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
