Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8671742CB42
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 22:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbhJMUqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 16:46:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37352 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhJMUqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 16:46:43 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634157878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MZjN8I6TNN3RSbhgj/0YmLJpzhG18z0CsDXHiDNSaLs=;
        b=XTTAay9Zg0qYWuHD34wlB+ZgnnQ8cs2VF40KFbkE+YdpdFZhdtAx6tmbfKlLdvQo73Z04J
        xU+5P3ac1bZNYTTzJ+NY9ZSAzQt0TeCaFYI0yWA5UgqIJgE/rl8doXTLvpxx58w7bH2V7v
        MSFYCPUhgu8j3vJPSTZCvwtuU9nBCv9RPqIgMYLtBApkMS4BeoexVTt3RMPCgxU+3j2BXs
        5opm7WjXUuBuvXVNoq6IffsNvoN93Lok7hNvcYB/WKQjq2BvRhL/0Yc/mfT9ZBp2B+gOWr
        ck/UVqV9Y54kdiOJaOAcoaMm+tNjgQzgtyC1+AurxkTfa/e5SySLo35yEfbtGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634157878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MZjN8I6TNN3RSbhgj/0YmLJpzhG18z0CsDXHiDNSaLs=;
        b=LU0iVAnlh8gelKzVthRAug8oFCsCBLd+8kLxrT/0jXrdOwQ3PjXEjHG+jZZNd0F4o2tu0i
        WBp7l08zm+TH5sAw==
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
Subject: Re: [PATCH v10 03/11] x86/cpufeatures: Add TDX Guest CPU feature
In-Reply-To: <20211009053747.1694419-4-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-4-sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Wed, 13 Oct 2021 22:44:37 +0200
Message-ID: <87ee8o8xje.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08 2021 at 22:37, Kuppuswamy Sathyanarayanan wrote:
> +
> +bool is_tdx_guest(void)
> +{
> +	static int tdx_guest = -1;
> +	u32 eax, sig[3];
> +
> +	if (tdx_guest >= 0)
> +		goto done;
> +
> +	if (cpuid_eax(0) < TDX_CPUID_LEAF_ID) {
> +		tdx_guest = 0;
> +		goto done;
> +	}
> +
> +	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2], &sig[1]);
> +
> +	tdx_guest = !memcmp("IntelTDX    ", sig, 12);
> +
> +done:
> +	return !!tdx_guest;
> +}

No. This is tasteless garbage, really.

tdx_early_init() is invoked from x86_64_start_kernel() very early in the
boot process __before__ is_tdx_guest() is invoked.

So why on earth is it requried to keep those conditionals and cpuid()
muck around after init?

> +void __init tdx_early_init(void)
> +{
> +	if (!is_tdx_guest())
> +		return;
> +
> +	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
> +
> +	pr_info("Guest initialized\n");
> +}

What's wrong with:

static bool tdx_guest_detected __ro_after_init;

void __init tdx_early_init(void)
{
	u32 eax, sig[3];

	if (cpuid_eax(0) < TDX_CPUID_LEAF_ID)
        	return;

        cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2],  &sig[1]);

        if (memcmp("IntelTDX    ", sig, 12))
        	return;

        tdx_guest_detected = true;
	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);

	pr_info("Guest initialized\n");
}

bool is_tdx_guest(void)
{
        return tdx_guest_detected;
}

That's simple and obvious and discards all the detection gunk completely
after init and uses the proper data type, right?

Thanks,

        tglx
