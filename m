Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FF542D052
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 04:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhJNCXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 22:23:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:47432 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229837AbhJNCXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 22:23:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="214740311"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="214740311"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 19:21:27 -0700
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="487166779"
Received: from dravindr-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.11.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 19:21:26 -0700
Subject: Re: [PATCH v7 6/6] x86/split_lock: Fix the split lock #AC handling
 when running as guest
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211005230550.1819406-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005230550.1819406-7-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YWdB+rGPWDIVzuBY@google.com>
 <38a70cf2-1849-97fd-82a2-10ce64c6be8c@linux.intel.com>
 <71884ac9-6da3-e75d-af1e-f8f24a7562cb@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuwamy@linux.intel.com>
Message-ID: <c2f67bab-28a1-1340-3c15-919ec03375db@linux.intel.com>
Date:   Wed, 13 Oct 2021 19:21:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <71884ac9-6da3-e75d-af1e-f8f24a7562cb@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/13/21 6:24 PM, Xiaoyao Li wrote:
> On 10/14/2021 5:32 AM, Sathyanarayanan Kuppuswamy wrote:
>> + Xiaoyao
>>
>> On 10/13/21 1:30 PM, Sean Christopherson wrote:
>>> On Tue, Oct 05, 2021, Kuppuswamy Sathyanarayanan wrote:
>>>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>>>>
>>>> If running as guest and hypervisor enables
>>>> MSR_TEST_CTRL.SPLIT_LOCK_DETECT during its running, it can get split
>>>> lock #AC even though sld_state is sld_off.
>>> That's a hypervisor bug, no?  The hypervisor should never inject a 
>>> fault that
>>> the guest cannot reasonably expect.
>
> What if hypervisor doesn't intercept #AC and host enables 
> SPLIT_LOCK_DETECT during guest running? That's exactly the case TDX is 
> facing.
>
> (BTW, this patch is not complete that no matter what state sld_state 
> is, it should always treat it as fatal even sld_warn because sld_warn 
> doesn't guarantee SPLIT_LOCK_DETECT is available)
>
> Sathya, we need to drop this one. Andi has anther one to disable split 
> lock detection for SPR. That's a better direction.

Ok. I will fix this in next submission.

>
>>>> For kernel mode #AC, it always dies("split lock"), no more action
>>>> needed.
>>>>
>>>> For user mode #AC, it should treat sld_off (default state when feature
>>>> is not available) as fatal as well.
>>>>
>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>> Signed-off-by: Kuppuswamy Sathyanarayanan 
>>>> <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>> ---
>>>>   arch/x86/kernel/cpu/intel.c | 7 ++++++-
>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
>>>> index 01d7935feaed..47f0bc95ce2a 100644
>>>> --- a/arch/x86/kernel/cpu/intel.c
>>>> +++ b/arch/x86/kernel/cpu/intel.c
>>>> @@ -1190,7 +1190,12 @@ static void bus_lock_init(void)
>>>>   bool handle_user_split_lock(struct pt_regs *regs, long error_code)
>>>>   {
>>>> -    if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
>>>> +    /*
>>>> +     * In virtualization environment, it can get split lock #AC 
>>>> even when
>>>> +     * sld_off but hypervisor enables it.
>>>> +     * Thus only handles when sld_warn explicitly.
>>>> +     */
>>>> +    if ((regs->flags & X86_EFLAGS_AC) || sld_state != sld_warn)
>>>>           return false;
>>>>       split_lock_warn(regs->ip);
>>>>       return true;
>>>> -- 
>>>> 2.25.1
>>>>
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

