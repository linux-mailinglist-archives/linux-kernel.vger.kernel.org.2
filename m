Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF52C342694
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 20:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhCST6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 15:58:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:15100 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230523AbhCST6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 15:58:10 -0400
IronPort-SDR: q02BkzS95sezgZxtTPYy5pkqATD20NEwQ29Qwe6g6FPisIjn7jQcmhoekMDqFgvIa+HS9Q8Vji
 Q5FTCXSSHlSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="177544161"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="177544161"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 12:58:09 -0700
IronPort-SDR: k5ux9otdjllAOHt3wOkxrzkaxGqrre7EC7a4zqxrTBtCk3tB2V06WAiDLQhyFZZh9wlHKzO9i6
 CJR7OHCnyh7g==
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="441432977"
Received: from hfritts-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.85.109])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 12:58:09 -0700
Subject: Re: [PATCH v1 1/1] x86/tdx: Add tdcall() and tdvmcall() helper
 functions
To:     Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <0A886D87-1979-419C-86DE-EA2FABDFF3EB@amacapital.net>
 <20210318213053.203403-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YFTXdG+zZ32gVIPc@google.com>
 <c72d9ca6-7a5c-b614-5d20-b86d2abebdee@linux.intel.com>
 <5485f0ac-da86-4f68-d277-9f0bba5c4ef5@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <8723950c-e07c-9a03-503a-ab232701d1e9@linux.intel.com>
Date:   Fri, 19 Mar 2021 12:58:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5485f0ac-da86-4f68-d277-9f0bba5c4ef5@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/21 11:22 AM, Dave Hansen wrote:
> On 3/19/21 10:42 AM, Kuppuswamy, Sathyanarayanan wrote:
>>>> @@ -4,6 +4,58 @@
>>>>    #include <asm/tdx.h>
>>>>    #include <asm/cpufeature.h>
>>>>    +void tdcall(u64 leafid, struct tdcall_regs *regs)
>>>> +{
>>>> +    asm volatile(
>>>> +            /* RAX = leafid (TDCALL LEAF ID) */
>>>> +            "  movq %0, %%rax;"
>>>> +            /* Move regs->r[*] data to regs r[a-c]x,  r8-r5 */
>>>> +            "  movq 8(%1), %%rcx;"
>>>
>>> I am super duper opposed to using inline asm.  Large blocks are
>>> hard to read,
>> I think this point is arguable. Based on the review comments I
>> received so far, people prefer inline assembly compared to asm sub
>> functions.
> 
> It's arguable, but Sean makes a pretty compelling case.
> 
> I actually think inline assembly is a monstrosity.  It's insanely arcane
> and, as I hope you have noted, does not scale nicely beyond one or two
> instructions.
> 
>>> and even harder to maintain.  E.g. the %1 usage falls apart if an
>>> output constraint is added; that can be avoided by defining a local
>>> const/imm (I forget what they're called), but it doesn't help
>>> readability.
>> we can use OFFSET() calls to improve the readability and avoid this
>> issue. Also IMO, any one adding constraints should know how this
>> would affect the asm code.
> 
> This is about *maintainability*.  How _easily_ can someone change this
> code in the future?  Sean's arguing that it's *hard* to correctly add a
> constraint.  Unfortunately, our supply of omnipotent kernel developers
> is a bit short.
> 
>>>> +            "  movq 16(%1), %%rdx;"
>>>> +            "  movq 24(%1), %%r8;"
>>>> +            "  movq 32(%1), %%r9;"
>>>> +            "  movq 40(%1), %%r10;"
>>>> +            "  movq 48(%1), %%r11;"
>>>> +            "  movq 56(%1), %%r12;"
>>>> +            "  movq 64(%1), %%r13;"
>>>> +            "  movq 72(%1), %%r14;"
>>>> +            "  movq 80(%1), %%r15;"
>>>
>>> This is extremely unsafe, and wasteful.  Putting the onus on the
>>> caller to zero out unused registers, with no mechanism to
>>> enforce/encourage doing so,
>> For encouragement, we can add a comment to this function about
>> callers responsibility. makes it
>>> likely that the kernel will leak information to the VMM, e.g. in
>>> the form of stack data due to a partially initialized "regs".
>> Unless you create sub-functions for each use cases, callers cannot
>> avoid this responsibility.
> 
> I don't think we're quite at the point where we throw up our hands.
> 
> It would be pretty simple to have an initializer that zeros the
> registers out, or looks at the argument mask and does it more precisely.
>   Surely we can do *something*.
> 
>>>      /* Offset for fields in tdvmcall_output */
>>>      OFFSET(TDVMCALL_r12, tdvmcall_output, r13);
>>>      OFFSET(TDVMCALL_r13, tdvmcall_output, r13);
>>>      OFFSET(TDVMCALL_r14, tdvmcall_output, r14);
>>>      OFFSET(TDVMCALL_r15, tdvmcall_output, r15);
>>>
>>> SYM_FUNC_START(__tdvmcall)
>>>      FRAME_BEGIN
>>>
>>>      /* Save/restore non-volatile GPRs that are exposed to the VMM. */
>>>           push %r15
>>>           push %r14
>>>           push %r13
>>>           push %r12
> 
> I might have some tweaks for the assembly once someone puts a real patch
> together.  But, that looks a lot more sane than the inline assembly to me.
Ok. Let me use Sean's proposal and submit tested version of this patch.

Also, any thoughts on whether you want to use single function for
tdcall and tdvmcall?
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
