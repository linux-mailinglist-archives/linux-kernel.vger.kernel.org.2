Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3592642E056
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 19:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbhJNRtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 13:49:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:55119 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229743AbhJNRtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 13:49:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="214910964"
X-IronPort-AV: E=Sophos;i="5.85,373,1624345200"; 
   d="scan'208";a="214910964"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 10:28:13 -0700
X-IronPort-AV: E=Sophos;i="5.85,373,1624345200"; 
   d="scan'208";a="660070847"
Received: from gmbaker-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.17.117])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 10:28:11 -0700
Subject: Re: [PATCH v10 03/11] x86/cpufeatures: Add TDX Guest CPU feature
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87ee8o8xje.ffs@tglx> <YWdKlG0AzmjpjJKW@zn.tnic> <877deg8vn4.ffs@tglx>
 <YWdRqAqedkhVA2lD@zn.tnic>
 <e4c0a191-ee26-9768-cbf5-c1d9782b1586@linux.intel.com> <87zgrc7clg.ffs@tglx>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuwamy@linux.intel.com>
Message-ID: <3f32856b-22b6-f6a4-b125-4921f6106e6f@linux.intel.com>
Date:   Thu, 14 Oct 2021 10:28:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87zgrc7clg.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/13/21 4:02 PM, Thomas Gleixner wrote:
> On Wed, Oct 13 2021 at 15:28, Sathyanarayanan Kuppuswamy wrote:
>> On 10/13/21 2:37 PM, Borislav Petkov wrote:
>>> On Wed, Oct 13, 2021 at 11:25:35PM +0200, Thomas Gleixner wrote:
>>>> So this ends up in doing:
>>>>
>>>>      use();
>>>>      init();
>>>>
>>>> Can you spot what's wrong with that?
>>>>
>>>> That's a clear violation of common sense and is simply not going to
>>>> happen. Why? If you think about deep defensive programming then use()
>>>> will look like this:
>>>>
>>>> use()
>>>> {
>>>>           assert(initialized);
>>>> }
>>>>
>>>> which is not something made up. It's a fundamental principle of
>>>> programming and some languages enforce that for very good reasons.
>>>>
>>>> Just because it can be done in C is no justification.
>>> Oh, I heartily agree.
>>>    
>>>> What's wrong with:
>>>>
>>>> x86_64_start_kernel()
>>>>
>>>>       tdx_early_init();
>>>>
>>>>       copy_bootdata();
>>>>       
>>>>       tdx_late_init();
>>>>
>>>> Absolutely nothing. It's clear, simple and well defined.
>>> I like simple more than anyone, so sure, I'd prefer that a lot more.
>>>
>>> And so the options parsing would need to happen early using, say,
>>> cmdline_find_option() or so, like sme_enable() does.
>> Since in tdx_early_init() all we are going to do is to initialize
>> "tdx_guest_detected" using cpuid call, shall we name it
>> tdx_guest_cpuid_init()? (similar to sme_enable call in AMD)
> How is that similar?
>
> Just chose a name which makes sense in the overall scheme. I surely care
> about naming convetions, but what I care more about is correctness.
>
> Whether it ends up being named
>
>          tdx_enable() - to match the SME muck
>
> or
>
>          tdx_detect()
>
> or whatever makes sense does not really matter. As long as it makes
> sense. That's bikeshed painting realm.
>
> Coming back to your suggestion 'tdx_guest_cpuid_init()'. Just sit back
> and think about what that name says:
>
>      tdx_guest_cpuid_init()
>
> For the uniformed reader this says:
>
>      If tdx guest then initialize CPUID
>
> which is obviously not what you want to express, right?
>
> So, naming matters but you are free to chose something which makes
> sense.

Makes sense. I agree tdx_guest_cpuid_init() name is bit confusing.
I will use tdx_detect as you have mentioned.

>
> Thanks,
>
>          tglx

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

