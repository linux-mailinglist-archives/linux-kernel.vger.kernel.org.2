Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A716455157
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 00:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241727AbhKRAAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 19:00:49 -0500
Received: from mga03.intel.com ([134.134.136.65]:22562 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241721AbhKRAAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 19:00:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="234023778"
X-IronPort-AV: E=Sophos;i="5.87,243,1631602800"; 
   d="scan'208";a="234023778"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 15:57:11 -0800
X-IronPort-AV: E=Sophos;i="5.87,243,1631602800"; 
   d="scan'208";a="454834492"
Received: from rsyep-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.140.227])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 15:57:10 -0800
Subject: Re: [PATCH] x86/paravirt: Fix build PARAVIRT_XXL=y without XEN_PV
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
References: <20211117181439.4368-1-kirill.shutemov@linux.intel.com>
 <YZVLVfd5E6d6YQig@hirez.programming.kicks-ass.net>
 <20211117184225.6e257nfpdd2qhrj4@box.shutemov.name>
 <4824bf30-851e-c927-a50f-87fa2a429b2a@linux.intel.com>
 <YZVOfGtHyiZg1pIP@zn.tnic>
 <980ceab6-6686-c8f3-72b8-5743ca517bdf@linux.intel.com>
 <0f0b9784-1902-1526-2796-7d1a7ab17fb6@intel.com>
 <21f1325d-d97e-1bb7-ea87-d84e44089ab4@linux.intel.com>
 <YZVvdyHhPTzzZbiu@zn.tnic>
 <d826f932-a6a4-de7d-b0ea-f8e1f9bfe012@linux.intel.com>
 <20211117232329.GD174703@worktop.programming.kicks-ass.net>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <ea41adcc-aeb4-136a-c723-077454ae2390@linux.intel.com>
Date:   Wed, 17 Nov 2021 15:57:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211117232329.GD174703@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/21 3:23 PM, Peter Zijlstra wrote:
> On Wed, Nov 17, 2021 at 03:04:11PM -0800, Sathyanarayanan Kuppuswamy wrote:
> 
>> We need PV support to handle halt() and safe_halt() cases.
>>
>> HLT instruction is generally used in cases like reboot, idle and
>> exception fixup handlers.
> 
> Which exception calls hlt? Because idle and reboot can easily be done.

It is called in early_fixup_exception().

> 
>> In TDX guest, to support HLT instruction, it has to be emulated using
>> a hypercall (aka TDVMCALL).
>>
>> We have the following three ways to emulate the HLT instruction:
>>
>> 1. Directly substitute TDVMCALLs in places where we require emulation.
>> 2. Use #VE exception handler to emulate it (In TDX guest, executing HLT
>>     will lead to #VE exception).
>> 3. Emulate it using pv_ops
>>
>> Since option#1 is not a scalable approach, it can be ignored. Option #2
>> is also not preferred because, we cannot differentiate between safe
>> halt and normal halt use cases in the exception handler.
> 
> Would not regs->flags & IF provide clue? I know STI normally has a
> shadow, but wouldn't a trap in that shadow still get the flag straight?
> I'm sure there's fun bugs around this, but surely TDX is new and doesn't
> have these bugs.

We have attempted this approach, but it failed some performance tests.

Yes, if we use option # 2, for safe_halt() use case, STI will leave the
interrupts in the desired state. But, between the STI instruction and
the actual emulation of the HLT instruction, interrupts will be left in
the enabled state. So any interrupt that happen in that window will
delay the HLT operation for a long time.

With above consideration, we thought PV ops is error free and a simpler
solution.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
