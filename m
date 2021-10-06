Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C5D42414B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239200AbhJFP2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:28:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55542 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231671AbhJFP2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:28:31 -0400
Received: from zn.tnic (p200300ec2f0d3600bdb6aa8687ce684e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:3600:bdb6:aa86:87ce:684e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 769691EC0409;
        Wed,  6 Oct 2021 17:26:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633533997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aNd7PoUhak/3a48Mf+gIve1v0CrGJRlpCPmC8oGfq5o=;
        b=UjEVimTo/HVnt6sg3Pq2epKgy04bCmL8r+mloo7FtgZcph1HrHVP8FyYySdc6qgQCiT4n6
        Mp2lFnB4DcsffwPXRpZrMGHrCup3QHU3Q3wg9i5pariyRsUZ5Y8NuZRRN+rkrulByv2GhP
        b5QKBtNLVwW4MzuKzlvEb8ykP9W73ko=
Date:   Wed, 6 Oct 2021 17:26:33 +0200
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
Subject: Re: [PATCH v8 03/11] x86/cpufeatures: Add TDX Guest CPU feature
Message-ID: <YV3AKekdJU0vsbaN@zn.tnic>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-4-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211005025205.1784480-4-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 07:51:57PM -0700, Kuppuswamy Sathyanarayanan wrote:
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> new file mode 100644
> index 000000000000..ad3ff5925153
> --- /dev/null
> +++ b/arch/x86/kernel/tdx.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2020 Intel Corporation */
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt)     "tdx: " fmt
> +
> +#include <asm/tdx.h>
> +
> +/*
> + * Allocate it in the data region to avoid zeroing it during
> + * BSS initialization. It is mainly used in cc_platform_has()
> + * call during early boot call.
> + */
> +u64 __section(".data") is_tdx_guest = 0;
> +
> +static void __init is_tdx_guest_init(void)
> +{
> +	u32 eax, sig[3];
> +
> +	if (cpuid_eax(0) < TDX_CPUID_LEAF_ID) {
> +		is_tdx_guest = 0;
> +		return;
> +	}
> +
> +	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2], &sig[1]);
> +
> +	is_tdx_guest = !memcmp("IntelTDX    ", sig, 12);
> +}
> +
> +void __init tdx_early_init(void)
> +{
> +	is_tdx_guest_init();
> +
> +	if (!is_tdx_guest)
> +		return;
> +
> +	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
> +
> +	pr_info("Guest initialized\n");
> +}
> -- 

What I meant was this (untested of course).

is_tdx_guest() is the accessor external code queries and you cache the
detected value in tdx_guest so that the one after the first one is
cheap.

/*
 * Allocate it in the data region to avoid zeroing it during
 * BSS initialization. It is mainly used in cc_platform_has()
 * call during early boot call.
 *
 * States whether the kernel is running as a TDX guest.
 */
static int tdx_guest __ro_after_init = -1;

bool is_tdx_guest(void)
{
	u32 eax, sig[3];

	if (tdx_guest >= 0)
		return tdx_guest;

	if (cpuid_eax(0) < TDX_CPUID_LEAF_ID) {
		tdx_guest = 0;
		return false;
	}

	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2], &sig[1]);

	tdx_guest = !memcmp("IntelTDX    ", sig, 12);

	return tdx_guest;
}

void __init tdx_early_init(void)
{
	if (!is_tdx_guest())
		return;

	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);

	pr_info("Guest initialized\n");
}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
