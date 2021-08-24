Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812B53F68F7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 20:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhHXSTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 14:19:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:17853 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhHXSTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:19:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="204570173"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="204570173"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 11:18:51 -0700
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="597672338"
Received: from ydevadig-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.137.104])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 11:18:50 -0700
Subject: Re: [PATCH v5 08/12] x86/tdx: Add HLT support for TDX guest
To:     Sean Christopherson <seanjc@google.com>,
        Borislav Petkov <bp@alien8.de>
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
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-9-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YSUaAQPiBUqubBHM@zn.tnic> <YSUnDQUrGYc8aY9j@google.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <bab4b049-f659-1a63-a0ce-8398589073d7@linux.intel.com>
Date:   Tue, 24 Aug 2021 11:18:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSUnDQUrGYc8aY9j@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/21 10:06 AM, Sean Christopherson wrote:
> On Tue, Aug 24, 2021, Borislav Petkov wrote:
>> On Wed, Aug 04, 2021 at 11:13:25AM -0700, Kuppuswamy Sathyanarayanan wrote:
>>> +static __cpuidle void tdg_safe_halt(void)
>>> +{
>>> +	u64 ret;
>>> +
>>> +	/*
>>> +	 * Enable interrupts next to the TDVMCALL to avoid
>>> +	 * performance degradation.
>>
>> That comment needs some more love to say exactly what the problem is.
> 
> LOL, I guess hanging the vCPU counts as degraded performance.  But this comment
> can and should go away entirely...
> 
>>> +	 */
>>> +	local_irq_enable();
> 
> ...because this is broken.  It's also disturbing because it suggests that these
> patches are not being tested.

Sorry, some how we missed this issue before our submission.

We do usual boot test before submission. Since this fix does not block the
boot process, it did not get caught. But we already found this in full functional
testing and also fixed it in github tree.

I will remove this in next submission.

> 
> The STI _must_ immediately precede TDCALL, and it _must_ execute with interrupts
> disabled.  The whole point of the STI blocking shadow is to ensure interrupts are
> blocked until _after_ the HLT completes so that a wake event is not recongized
> before the HLT, in which case the vCPU will get stuck in HLT because its wake
> event alreadyfired.  Enabling IRQs well before the TDCALL defeats the purpose of
> the STI dance in __tdx_hypercall().
> 
> There's even a massive comment in __tdx_hypercall() explaining all this...
> 
>>> +
>>> +	/* IRQ is enabled, So set R12 as 0 */
> 
> It would be helpful to use local variables to document what's up, e.g.
> 
>   	const bool irqs_enabled = true;
> 	const bool do_sti = true;
> 
> 	ret = _tdx_hypercall(EXIT_REASON_HLT, irqs_enabled0, 0, 0, do_sti, NULL);

Ok. I can follow your suggestion in next submission.

> 	
>>> +	ret = _tdx_hypercall(EXIT_REASON_HLT, 0, 0, 0, 1, NULL);
>>> +
>>> +	/* It should never fail */
>>> +	BUG_ON(ret);
>>> +}
>>
>> -- 
>> Regards/Gruss,
>>      Boris.
>>
>> https://people.kernel.org/tglx/notes-about-netiquette

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
