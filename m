Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFA8425026
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 11:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240694AbhJGJgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 05:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbhJGJf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 05:35:58 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E068C061746
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 02:34:05 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0cc9002e15c3e32d435b8a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:c900:2e15:c3e3:2d43:5b8a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 408E71EC04B9;
        Thu,  7 Oct 2021 11:34:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633599243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RW40Hv5VFmiMJlybhaNrdjyvzkHSsnIr8Xa3EbVzVdU=;
        b=OwRD+DYBlSMHPjmDFTh3jXE8N0/sHV/AC2hVhqWqfylbRPOpIbPkQzNoMLXw3he50/Sp7v
        rLZ5FAEADcYQHxzIyrbEPqbBvPqddq9UFgtyZ1q6qXu7d5IQmyBk9U7hf3bRAqxYGZ27e6
        5RTo1z1VzZSGSGG500uHqASRgJV0nKM=
Date:   Thu, 7 Oct 2021 11:33:58 +0200
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
Subject: Re: [PATCH v8 05/11] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Message-ID: <YV6/Bg9D67sbq6Ap@zn.tnic>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-6-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211005025205.1784480-6-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 07:51:59PM -0700, Kuppuswamy Sathyanarayanan wrote:
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index ad3ff5925153..d5fc2904facf 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -27,6 +27,29 @@ static void __init is_tdx_guest_init(void)
>  	is_tdx_guest = !memcmp("IntelTDX    ", sig, 12);
>  }
>  
> +/*
> + * Wrapper for standard use of __tdx_hypercall with BUG_ON() check
> + * for TDCALL error.
> + */
> +static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14,
> +				 u64 r15, struct tdx_hypercall_output *out)
> +{
> +	struct tdx_hypercall_output outl = {0};

Why do you need to clear this when, if used, it will get completely
overwritten in __tdx_hypercall()?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
