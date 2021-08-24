Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF963F6859
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241726AbhHXRrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:47:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:20523 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241444AbhHXRqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:46:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="197609725"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="197609725"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 10:35:33 -0700
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="597659443"
Received: from ydevadig-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.137.104])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 10:35:33 -0700
Subject: Re: [PATCH v5 08/12] x86/tdx: Add HLT support for TDX guest
To:     Borislav Petkov <bp@alien8.de>
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
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-9-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YSUaAQPiBUqubBHM@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <a3f0731c-c27f-8c20-19f9-0aa609d36288@linux.intel.com>
Date:   Tue, 24 Aug 2021 10:35:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSUaAQPiBUqubBHM@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/21 9:10 AM, Borislav Petkov wrote:
> On Wed, Aug 04, 2021 at 11:13:25AM -0700, Kuppuswamy Sathyanarayanan wrote:
>> @@ -240,6 +243,32 @@ SYM_FUNC_START(__tdx_hypercall)
>>   
>>   	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
>>   
>> +	/*
>> +	 * For the idle loop STI needs to be called directly before
>> +	 * the TDCALL that enters idle (EXIT_REASON_HLT case). STI
>> +	 * enables interrupts only one instruction later. If there
>> +	 * are any instructions between the STI and the TDCALL for
>> +	 * HLT then an interrupt could happen in that time, but the
>> +	 * code would go back to sleep afterwards, which can cause
>> +	 * longer delays.
> 
> <-- newline in the comment here for better readability.

Ok. I will add it in next version.

> 
>> There leads to significant difference in
> 
> "There leads..." ?

Will fix this in next version. "This leads"

> 
>> +	 * network performance benchmarks. So add a special case for
>> +	 * EXIT_REASON_HLT to trigger sti before TDCALL. But this
>> +	 * change is not required for all HLT cases. So use R15
>> +	 * register value to identify the case which needs sti. So,
> 
> s/sti/STI/g

will fix this in next version.

> 
>> +	 * if R11 is EXIT_REASON_HLT and R15 is 1, then call sti
>> +	 * before TDCALL instruction. Note that R15 register is not
>> +	 * required by TDCALL ABI when triggering the hypercall for
>> +	 * EXIT_REASON_HLT case. So use it in software to select the
>> +	 * sti case.
>> +	 */
>> +	cmpl $EXIT_REASON_HLT, %r11d
>> +	jne skip_sti
>> +	cmpl $1, %r15d
>> +	jne skip_sti
>> +	/* Set R15 register to 0, it is unused in EXIT_REASON_HLT case */
>> +	xor %r15, %r15
>> +	sti
>> +skip_sti:
>>   	tdcall
> 
> ...
> 
>> +static __cpuidle void tdg_safe_halt(void)
>> +{
>> +	u64 ret;
>> +
>> +	/*
>> +	 * Enable interrupts next to the TDVMCALL to avoid
>> +	 * performance degradation.
> 
> That comment needs some more love to say exactly what the problem is.

It is a bug in this submission. After adding STI fix, this local_irq_enable()
had to be removed. Somehow I have missed to do it. I will fix this
in next version.

> 
>> +	 */
>> +	local_irq_enable();
>> +
>> +	/* IRQ is enabled, So set R12 as 0 */
>> +	ret = _tdx_hypercall(EXIT_REASON_HLT, 0, 0, 0, 1, NULL);
>> +
>> +	/* It should never fail */
>> +	BUG_ON(ret);
>> +}
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
