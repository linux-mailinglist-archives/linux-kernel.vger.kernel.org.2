Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B59242E52C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 02:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbhJOAWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 20:22:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:1619 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229743AbhJOAWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 20:22:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="251260416"
X-IronPort-AV: E=Sophos;i="5.85,374,1624345200"; 
   d="scan'208";a="251260416"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 17:19:58 -0700
X-IronPort-AV: E=Sophos;i="5.85,374,1624345200"; 
   d="scan'208";a="571588334"
Received: from anmone-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.15.192])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 17:19:55 -0700
Subject: Re: [PATCH v10 05/11] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
To:     Thomas Gleixner <tglx@linutronix.de>,
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
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87r1co6p5y.ffs@tglx>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <d2928fc1-206d-3c9b-c204-2f1783772b13@linux.intel.com>
Date:   Thu, 14 Oct 2021 17:19:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87r1co6p5y.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/14/21 12:28 AM, Thomas Gleixner wrote:
> On Fri, Oct 08 2021 at 22:37, Kuppuswamy Sathyanarayanan wrote:
>>   
>> +#ifdef CONFIG_INTEL_TDX_GUEST
>> +#include <asm/tdx.h>
>> +#endif
> Please get rid of the #ifdef and make sure that tdx.h can be included unconditionally.


It can be included unconditionally. I will remove it in next version.

>
>> +	/* Restore callee-saved GPRs as mandated by the x86_64 ABI */
>> +	pop %r12
>> +	pop %r13
>> +	pop %r14
>> +	pop %r15
>> +
>> +	jmp 2f
>> +1:
> ASM supports named labels.

I will use a meaningful label instead of 1 or 2. I will fix this in next 
version.

>
>> +       movq $(-EINVAL), %rax
>> +2:
>> +       FRAME_END
>> +
>> +       retq
>> +SYM_FUNC_END(__tdx_hypercall)
>
>> +/*
>> + * Wrapper for standard use of __tdx_hypercall with BUG_ON() check
>> + * for TDCALL error.
>> + */
>> +static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14,
>> +				 u64 r15, struct tdx_hypercall_output *out)
>> +{
>> +	struct tdx_hypercall_output outl;
>> +	u64 err;
>> +
>> +	/* __tdx_hypercall() does not accept NULL output pointer */
>> +	if (!out)
>> +		out = &outl;
>> +
>> +	err = __tdx_hypercall(TDX_HYPERCALL_STANDARD, fn, r12, r13, r14,
>> +			      r15, out);
>> +
>> +	/* Non zero return value indicates buggy TDX module, so panic */
>> +	BUG_ON(err);
> BUG() does not necessarily panic. If you want to panic in then invoke
> the function which does that, i.e. panic().


Yes, we want to panic here. I will use panic() in next version.


>
> Thanks,
>
>          tglx

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

