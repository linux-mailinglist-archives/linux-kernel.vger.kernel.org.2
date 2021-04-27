Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C998B36BD55
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 04:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbhD0Cab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 22:30:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:42793 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231450AbhD0Caa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 22:30:30 -0400
IronPort-SDR: FTYzi75SH6/XF8JV41r794KzpiDC8BoTpViFYTOcYzjV/xqmxL6/UnyBJxnxXeEAkuDqKvll44
 ZYCVijesmuBQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="281767946"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="281767946"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 19:29:48 -0700
IronPort-SDR: OpKQQIrYFfzS64RTHKrOfGI72F+rh+z4dmjaR76W5vW5M9E3cazkEi8Lqn4jaodqvkiggBhuOX
 WpPrG7JRIsSw==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="465322084"
Received: from ssumanpx-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.34.197])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 19:29:46 -0700
Subject: Re: [RFC v2 05/32] x86/tdx: Add __tdcall() and __tdvmcall() helper
 functions
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <2f81f67efdf8c68838cdfbb2314e98747cf70120.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <c2edea0c-8de7-3bd3-1dbe-66b585d78e03@intel.com>
 <f310c626-5fd9-7fd3-23fa-e319c0f2aa98@linux.intel.com>
 <33af5bd4-7ada-8450-5a86-90023145d481@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <849d8039-b43c-0790-be1c-aaac8c06608a@linux.intel.com>
Date:   Mon, 26 Apr 2021 19:29:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <33af5bd4-7ada-8450-5a86-90023145d481@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/21 4:17 PM, Dave Hansen wrote:
> On 4/26/21 3:31 PM, Kuppuswamy, Sathyanarayanan wrote:
>>>> +#define tdcall .byte 0x66,0x0f,0x01,0xcc
>>>> +
>>>> +/*
>>>> + * __tdcall()  - Used to communicate with the TDX module
>>>
>>> Why is this function here?  What does it do?  Why do we need it?
>>
>> __tdcall() function is used to request services from the TDX Module.
>> Example use cases are, TDREPORT, VEINFO, TDINFO, etc.
> 
> I think there might be some misinterpretation of my question.  What you
> are describing is what *TDCALL* does.  Why do we need a wrapper
> function?  What purpose does this wrapper function serve?  Why do we
> need this wrapper function?
> 

How about following explanation?

Helper function for "tdcall" instruction, which can be used to request
services from the TDX module (does not include VMM). Few examples of
valid TDX module services are, "TDREPORT", "MEM PAGE ACCEPT", "VEINFO",
etc.

This function serves as a wrapper to move user call arguments to
the correct registers as specified by "tdcall" ABI and shares it with
the TDX module.  If the "tdcall" operation is successful and a
valid "struct tdcall_out" pointer is available (in "out" argument),
output from the TDX module (RCX, RDX, R8-R11) is saved to the memory
specified in the "out" pointer. Also the status of the "tdcall"
operation is returned back to the user as a function return value.

>>> Why do we have to save these?  Because they might be clobbered?  If so,
>>> let's say *THAT* instead of just "exposed".  "Exposed" could mean "VMM
>>> can read".
>>>
>>> Also, this just told me that this function can't be used to talk to the
>>> VMM.  Why is this talking about exposure to the VMM?
>>
>> Although __tdcall() is only used to communicate with the TDX module and the
>> TDX module is not supposed to touch these registers, just to be on the safe
>> side, I have tried to save the context of registers R12-R15. Anyway cycles
>> used by instructions are less compared to tdcall.
> 
> Why are you talking about the VMM if this is a call to the SEAM module?
> 
> Let's say someone is reading the TDCALL architecture spec.  It will say
> something like, "blah blah, in this case TDCALL will not modify
> %r12->%r15".  Then someone goes and looks at this code that basically
> says (or implies) "save these before the SEAM module modifies them".
> What is a coder to do?
> 
> Please remove the ambiguity, either by removing this superfluous
> (according to the spec) code, or documenting why it is not superfluous.

Agree. I will remove the save/restore context code.

> 
>>>> +    /* Move TDCALL Leaf ID to RAX */
>>>> +    mov %rdi, %rax
>>>> +    /* Move output pointer to R12 */
>>>> +    mov %r9, %r12
>>>
>>> I thought 'struct tdcall_output' was a purely software construct.  Why
>>> are we passing a pointer to it into TDCALL?
>>
>> Its used to store the TDCALL result (RCX, RDX, R8-R11). As far as this
>> function is concerned, its just a block of memory (accessed using
>> base address + TDCALL_r* offsets).
> 
> Is 'struct tdcall_output' a hardware architectural structure or a
> software structure?
> 
> If it's a software structure, then why are we passing a pointer to a
> software structure into a hardware ABI?
> 
> If it's a hardware architecture structure, where is the documentation
> for it?
> 

I think there is a misunderstanding here. We don't share the tdcall_output
pointer with the TDX module. Current use cases of TDCALL (other than TDVMCALL)
do not use registers from R12-R15. Since the registers R12-R15 are free and
available, we are using R12 as temporary storage to hold the tdcall_output
pointer.

I will include some comment about using it as temporary storage.


> 
> I prefer that the code be understandable and be written for a clear
> purpose.  If you're using r12 for temporary storage, I expect to see at
> least one reference *SOMEWHERE* to its use as temporary storage.  Right
> now.... nothing.
> 

I will include some reference to it.

>>>> +    /* Copy TDCALL result registers to output struct: */
>>>> +    movq %rcx, TDCALL_rcx(%r12)
>>>> +    movq %rdx, TDCALL_rdx(%r12)
>>>> +    movq %r8,  TDCALL_r8(%r12)
>>>> +    movq %r9,  TDCALL_r9(%r12)
>>>> +    movq %r10, TDCALL_r10(%r12)
>>>> +    movq %r11, TDCALL_r11(%r12)
>>>> +1:
>>>> +    /* Zero out registers exposed to the TDX Module. */
>>>> +    xor %rcx,  %rcx
>>>> +    xor %rdx,  %rdx
>>>> +    xor %r8d,  %r8d
>>>> +    xor %r9d,  %r9d
>>>> +    xor %r10d, %r10d
>>>> +    xor %r11d, %r11d
>>>
>>> ... why?
>>
>> These registers are used by the TDX Module. Why pass the stale values
>> back to the user? So we clear them here.
> 
> Please go look at some other assembly code in the kernel called from C.
>   Do those functions do this?  Why?  Why not?  Do they care about
> "passing stale values back up"?
> 

Maybe I am being overly cautious here. Since TDX module is the trusted
code, speculation attack is not a consideration here. I will remove this
block of code.

>>>> +SYM_CODE_START_LOCAL(do_tdvmcall)
>>>> +    FRAME_BEGIN
>>>> +
>>>> +    /* Save non-volatile GPRs that are exposed to the VMM. */
>>>> +    push %r15
>>>> +    push %r14
>>>> +    push %r13
>>>> +    push %r12
>>>> +
>>>> +    /* Set TDCALL leaf ID to TDVMCALL (0) in RAX */
>>>
>>> I think there needs to be some discussion of what TDCALL and TDVMCALL
>>> are.  They are named too similarly not to do so.
>>
>> TDVMCALL is the sub function of TDCALL (selected by setting RAX register
>> to 0). TDVMCALL is used to request services from VMM.
> 
> Actually, I think these functions are horribly misnamed.
> 
> I think we should make them
> 
> 	__tdx_seam_call()
> or	__tdx_module_call()
> 
> and
> 
> 	__tdx_hypercall()
> 
> 
> 	__tdcall()
> and
> 	__tdvmcall()
> 
> are really nonsensical in this context, especially since TDVMCALL is
> implemented with the TDCALL instruction, but not the __tdcall() function.
> 

TDVMCALL is a short form of "TDG.VP.VMCALL". This term usage came from
GHCI document. We can read it as "Trusted Domain VMCALL". Maybe
because we are used to GHCI spec, we don't find it confusing. I agree
that if you consider the "tdcall" instruction usage, it is confusing.

But if it's confusing for new readers and rename is preferred,

Do we need to rename the helper functions ?

tdvmcall(), tdvmcall_out_r11()

Also what about output structs?

struct tdcall_output
struct tdvmcall_output

>>>> +/* Helper function for standard type of TDVMCALL */
>>>> +SYM_FUNC_START(__tdvmcall)
>>>> +    /* Set TDVMCALL type info (0 - Standard, > 0 - vendor) in R10 */
>>>> +    xor %r10, %r10
>>>> +    call do_tdvmcall
>>>> +    retq
>>>> +SYM_FUNC_END(__tdvmcall)
>>>
>>> Why do we need this helper?  Why does it need to be in assembly?
>>
>> Its simpler to do it in assembly. Also, grouping all register updates
>> in the same file will make it easier for us to read or debug issues.
>> Another
>> reason is, we also call do_tdvmcall() from in/out instruction use case.
> 
> Sathya, I seem to have to reverse-engineer what you are doing for all
> this stuff.  Your answers to my questions are almost entirely orthogonal
> to the things I really want to know.  I guess I need to be more precise
> with the questions I'm asking.  But, this is yet another case where I
> think the burden for this series continues to fall on the reviewer
> rather than the submitter.  Not the way I think it is best.

I have assumed that you are aware of reason for the existence of
do_tdvmcall() helper function. It is mainly created to hold common
code between vendor specific and standard type of tdvmcall's.

But it is a mistake from my end. I will try to be elaborate in my
future replies.

> 
> So, trying to reverse-engineer what you are doing here... it seems that
> you can't *practically* call do_tdvmcall() directly because %r10 would
> be garbage.  That makes this (or a wrapper like it) required for every
> practical call to do_tdvmcall().
> 
> But, even if that's the case, you need to *DOCUMENT* that up in
> do_tdvmcall(): Hey, this function is worthless without something that
> sets up %r10 before calling it.

Agree. This needs to be documented. I will add it in next version.

> 
> I'm also not *SURE* this is simpler to do in assembly.
> 
>>>> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
>>>> index 6a7193fead08..29c52128b9c0 100644
>>>> --- a/arch/x86/kernel/tdx.c
>>>> +++ b/arch/x86/kernel/tdx.c
>>>> @@ -1,8 +1,44 @@
>>>>    // SPDX-License-Identifier: GPL-2.0
>>>>    /* Copyright (C) 2020 Intel Corporation */
>>>>    +#define pr_fmt(fmt) "TDX: " fmt
>>>> +
>>>>    #include <asm/tdx.h>
>>>>    +/*
>>>> + * Wrapper for use case that checks for error code and print warning
>>>> message.
>>>> + */
>>>
>>> This comment isn't very useful.  I can see the error check and warning
>>> by reading the code.
>>
>> Its just a helper function that covers common case of checking for error
>> and print the warning message. If this comment is superfluous, I can remove
>> it.
> 
> I'd prefer that you actually write a comment about what the function is
> doing, maybe:
> 
> /*
>   * Wrapper for simple hypercalls that only return a success/error code.
>   */
> 
> ... or *SOMETHING* that tells what its purpose in life is.

I will fix it in next version.

> 
>>>> +static inline u64 tdvmcall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
>>>> +{
>>>> +    u64 err;
>>>> +
>>>> +    err = __tdvmcall(fn, r12, r13, r14, r15, NULL);
>>>> +
>>>> +    if (err)
>>>> +        pr_warn_ratelimited("TDVMCALL fn:%llx failed with err:%llx\n",
>>>> +                    fn, err);
>>>> +
>>>> +    return err;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Wrapper for the semi-common case where we need single output
>>>> value (R11).
>>>> + */
>>>> +static inline u64 tdvmcall_out_r11(u64 fn, u64 r12, u64 r13, u64
>>>> r14, u64 r15)
>>>> +{
>>>> +
>>>> +    struct tdvmcall_output out = {0};
>>>> +    u64 err;
>>>> +
>>>> +    err = __tdvmcall(fn, r12, r13, r14, r15, &out);
>>>> +
>>>> +    if (err)
>>>> +        pr_warn_ratelimited("TDVMCALL fn:%llx failed with err:%llx\n",
>>>> +                    fn, err);
>>>> +
>>>> +    return out.r11;
>>>> +}
>>>
>>> How do callers check for errors?  Is the error value superfluously
>>> returned in r11 and another output register?
>>
>> We already check for error in this helper function. User of this function
>> only cares about output value (R11). Mainly for in/out use case.
> 
> That's pretty valuable information.

I will include this note in the function comment.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
