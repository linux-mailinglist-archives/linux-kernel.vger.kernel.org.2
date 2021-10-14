Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3E842D6E1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 12:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhJNKXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 06:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhJNKX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 06:23:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC24C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 03:21:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634206882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1vPk+5UQWcz+Ur20Qebsfj4oslp4ZyN/IcZoWC4lt2Q=;
        b=4xLreLgKs9v3TiKPLjl9x9Lj9wQEZ33BP+7J+BeGO1WjbwCY6FRnLNpaT+4sgq4nWkN+n3
        vuPD66bu0sQrr7VMWgy3kRznbictPuR1TMKOd/mrVAm/tx1kFZYEB60JHeOeF616Ul9RTc
        I877oROxa8yRGq8Dfejusi9WuQthX8IOO9YCxlOa+D/zzO4F7z3qxYLg4j8bcw8qLpnRCr
        k2JGKZy+VmbFW7U658037+PJFYawtQaVKrrZjiefvmh0IbJ3HUMNqbKh6ljHYUOS1PYpxq
        fT++mYDNc6wx4Fg4ogVUv82Sh78yEnwH+ZJwtDIcd69Hg9ffSQJBRjsO2Yvhyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634206882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1vPk+5UQWcz+Ur20Qebsfj4oslp4ZyN/IcZoWC4lt2Q=;
        b=UtZzHVaohfIVm/F7sal/oMI44AbGPgrVWb4hHFNdv6s6vRbUntedcL81fDTtolALvBpgSo
        hyzbsX0yeH7Hl7DQ==
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 08/11] x86/tdx: Wire up KVM hypercalls
In-Reply-To: <20211009053747.1694419-9-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-9-sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Thu, 14 Oct 2021 12:21:21 +0200
Message-ID: <87ilxz7vq6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08 2021 at 22:37, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>  
>  #ifdef CONFIG_KVM_GUEST
> @@ -32,6 +34,10 @@ static inline bool kvm_check_and_clear_guest_paused(void)
>  static inline long kvm_hypercall0(unsigned int nr)
>  {
>  	long ret;
> +
> +	if (cc_platform_has(CC_ATTR_GUEST_TDX))
> +		return tdx_kvm_hypercall(nr, 0, 0, 0, 0);

So if TDX is not enabled in Kconfig this cannot be optimized out unless
CC_PLATFORM is disabled as well. But what's worse is that every
hypercall needs to call into cc_platform_has().

None of the hypercalls is used before the early TDX detection. So we can
simply use

       if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))

here, right? Then you add X86_FEATURE_TDX_GUEST to the disabled feature
bits correctly and all of the above is solved.

Hmm?
 
> +#if defined(CONFIG_KVM_GUEST) && defined(CONFIG_INTEL_TDX_GUEST)
> +static inline long tdx_kvm_hypercall(unsigned int nr, unsigned long p1,
> +				     unsigned long p2, unsigned long p3,
> +				     unsigned long p4)
> +{
> +	struct tdx_hypercall_output out;
> +	u64 err;
> +
> +	err = __tdx_hypercall(TDX_HYPERCALL_VENDOR_KVM, nr, p1, p2,
> +			      p3, p4, &out);
> +
> +	/*
> +	 * Non zero return value means buggy TDX module (which is fatal).
> +	 * So use BUG_ON() to panic.
> +	 */
> +	BUG_ON(err);
> +
> +	return out.r10;
> +}

Can we make that a proper exported function (instead of
tdx_kvm_hypercall) so we don't end up with the very same code inlined
all over the place?

Thanks,

        tglx

