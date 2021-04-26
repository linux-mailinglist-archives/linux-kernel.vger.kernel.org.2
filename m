Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65EFF36BC01
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 01:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbhDZXST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 19:18:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:9838 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232235AbhDZXSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 19:18:18 -0400
IronPort-SDR: AMfS1sm5vnP6TSyRTJOknLPwxD/r3G1ynKpBwAKpL483WXJCs777+TZfQ7fsdmQb84dxLf4DRX
 cTVyoAPSqatA==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="196479020"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="196479020"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 16:17:19 -0700
IronPort-SDR: 3Wz8IAI8xuvvxJ245VHhfv5mIGEQWrEij4iPUSzrLbWQVJI/gXkXt1Hjg9yS9Ss48uhVXRkqx6
 Jy5L77JKJRPw==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="429578355"
Received: from mjdelaro-mobl.amr.corp.intel.com (HELO [10.254.34.181]) ([10.254.34.181])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 16:17:18 -0700
Subject: Re: [RFC v2 05/32] x86/tdx: Add __tdcall() and __tdvmcall() helper
 functions
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <33af5bd4-7ada-8450-5a86-90023145d481@intel.com>
Date:   Mon, 26 Apr 2021 16:17:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f310c626-5fd9-7fd3-23fa-e319c0f2aa98@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/21 3:31 PM, Kuppuswamy, Sathyanarayanan wrote:
>>> +#define tdcall .byte 0x66,0x0f,0x01,0xcc
>>> +
>>> +/*
>>> + * __tdcall()  - Used to communicate with the TDX module
>>
>> Why is this function here?  What does it do?  Why do we need it?
> 
> __tdcall() function is used to request services from the TDX Module.
> Example use cases are, TDREPORT, VEINFO, TDINFO, etc.

I think there might be some misinterpretation of my question.  What you
are describing is what *TDCALL* does.  Why do we need a wrapper
function?  What purpose does this wrapper function serve?  Why do we
need this wrapper function?

>>> + * NOTE: This function should only used for non TDVMCALL
>>> + *       use cases
>>> + */
>>> +SYM_FUNC_START(__tdcall)
>>> +    FRAME_BEGIN
>>> +
>>> +    /* Save non-volatile GPRs that are exposed to the VMM. */
>>> +    push %r15
>>> +    push %r14
>>> +    push %r13
>>> +    push %r12
>>
>> Why do we have to save these?  Because they might be clobbered?  If so,
>> let's say *THAT* instead of just "exposed".  "Exposed" could mean "VMM
>> can read".
>>
>> Also, this just told me that this function can't be used to talk to the
>> VMM.  Why is this talking about exposure to the VMM?
> 
> Although __tdcall() is only used to communicate with the TDX module and the
> TDX module is not supposed to touch these registers, just to be on the safe
> side, I have tried to save the context of registers R12-R15. Anyway cycles
> used by instructions are less compared to tdcall.

Why are you talking about the VMM if this is a call to the SEAM module?

Let's say someone is reading the TDCALL architecture spec.  It will say
something like, "blah blah, in this case TDCALL will not modify
%r12->%r15".  Then someone goes and looks at this code that basically
says (or implies) "save these before the SEAM module modifies them".
What is a coder to do?

Please remove the ambiguity, either by removing this superfluous
(according to the spec) code, or documenting why it is not superfluous.

>>> +    /* Move TDCALL Leaf ID to RAX */
>>> +    mov %rdi, %rax
>>> +    /* Move output pointer to R12 */
>>> +    mov %r9, %r12
>>
>> I thought 'struct tdcall_output' was a purely software construct.  Why
>> are we passing a pointer to it into TDCALL?
> 
> Its used to store the TDCALL result (RCX, RDX, R8-R11). As far as this
> function is concerned, its just a block of memory (accessed using
> base address + TDCALL_r* offsets).

Is 'struct tdcall_output' a hardware architectural structure or a
software structure?

If it's a software structure, then why are we passing a pointer to a
software structure into a hardware ABI?

If it's a hardware architecture structure, where is the documentation
for it?

>>> +    tdcall
>>> +
>>> +    /* Check for TDCALL success: 0 - Successful, otherwise failed */
>>> +    test %rax, %rax
>>> +    jnz 1f
>>> +
>>> +    /* Check for a TDCALL output struct */
>>> +    test %r12, %r12
>>> +    jz 1f
>>
>> Does some universal status come back in r12?  Aren't we dealing with a
>> VMM/SEAM-controlled register here?  Isn't this dangerous?
> 
> R12 is the temporary register we have used to store the address of user
> passed output pointer. We just check for NULL condition here. R12 will
> not be used by the TDX module.

OK, so how do you know this?  Could you share your logic, please?

> If you prefer, we can just push the output pointer to stack and get it
> after we make the tdcall.

I prefer that the code be understandable and be written for a clear
purpose.  If you're using r12 for temporary storage, I expect to see at
least one reference *SOMEWHERE* to its use as temporary storage.  Right
now.... nothing.

>>> +    /* Copy TDCALL result registers to output struct: */
>>> +    movq %rcx, TDCALL_rcx(%r12)
>>> +    movq %rdx, TDCALL_rdx(%r12)
>>> +    movq %r8,  TDCALL_r8(%r12)
>>> +    movq %r9,  TDCALL_r9(%r12)
>>> +    movq %r10, TDCALL_r10(%r12)
>>> +    movq %r11, TDCALL_r11(%r12)
>>> +1:
>>> +    /* Zero out registers exposed to the TDX Module. */
>>> +    xor %rcx,  %rcx
>>> +    xor %rdx,  %rdx
>>> +    xor %r8d,  %r8d
>>> +    xor %r9d,  %r9d
>>> +    xor %r10d, %r10d
>>> +    xor %r11d, %r11d
>>
>> ... why?
> 
> These registers are used by the TDX Module. Why pass the stale values
> back to the user? So we clear them here.

Please go look at some other assembly code in the kernel called from C.
 Do those functions do this?  Why?  Why not?  Do they care about
"passing stale values back up"?

>>> +SYM_CODE_START_LOCAL(do_tdvmcall)
>>> +    FRAME_BEGIN
>>> +
>>> +    /* Save non-volatile GPRs that are exposed to the VMM. */
>>> +    push %r15
>>> +    push %r14
>>> +    push %r13
>>> +    push %r12
>>> +
>>> +    /* Set TDCALL leaf ID to TDVMCALL (0) in RAX */
>>
>> I think there needs to be some discussion of what TDCALL and TDVMCALL
>> are.  They are named too similarly not to do so.
> 
> TDVMCALL is the sub function of TDCALL (selected by setting RAX register
> to 0). TDVMCALL is used to request services from VMM.

Actually, I think these functions are horribly misnamed.

I think we should make them

	__tdx_seam_call()
or	__tdx_module_call()

and

	__tdx_hypercall()


	__tdcall()
and
	__tdvmcall()

are really nonsensical in this context, especially since TDVMCALL is
implemented with the TDCALL instruction, but not the __tdcall() function.

>>> +/* Helper function for standard type of TDVMCALL */
>>> +SYM_FUNC_START(__tdvmcall)
>>> +    /* Set TDVMCALL type info (0 - Standard, > 0 - vendor) in R10 */
>>> +    xor %r10, %r10
>>> +    call do_tdvmcall
>>> +    retq
>>> +SYM_FUNC_END(__tdvmcall)
>>
>> Why do we need this helper?  Why does it need to be in assembly?
> 
> Its simpler to do it in assembly. Also, grouping all register updates
> in the same file will make it easier for us to read or debug issues.
> Another
> reason is, we also call do_tdvmcall() from in/out instruction use case.

Sathya, I seem to have to reverse-engineer what you are doing for all
this stuff.  Your answers to my questions are almost entirely orthogonal
to the things I really want to know.  I guess I need to be more precise
with the questions I'm asking.  But, this is yet another case where I
think the burden for this series continues to fall on the reviewer
rather than the submitter.  Not the way I think it is best.

So, trying to reverse-engineer what you are doing here... it seems that
you can't *practically* call do_tdvmcall() directly because %r10 would
be garbage.  That makes this (or a wrapper like it) required for every
practical call to do_tdvmcall().

But, even if that's the case, you need to *DOCUMENT* that up in
do_tdvmcall(): Hey, this function is worthless without something that
sets up %r10 before calling it.

I'm also not *SURE* this is simpler to do in assembly.

>>> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
>>> index 6a7193fead08..29c52128b9c0 100644
>>> --- a/arch/x86/kernel/tdx.c
>>> +++ b/arch/x86/kernel/tdx.c
>>> @@ -1,8 +1,44 @@
>>>   // SPDX-License-Identifier: GPL-2.0
>>>   /* Copyright (C) 2020 Intel Corporation */
>>>   +#define pr_fmt(fmt) "TDX: " fmt
>>> +
>>>   #include <asm/tdx.h>
>>>   +/*
>>> + * Wrapper for use case that checks for error code and print warning
>>> message.
>>> + */
>>
>> This comment isn't very useful.  I can see the error check and warning
>> by reading the code.
> 
> Its just a helper function that covers common case of checking for error
> and print the warning message. If this comment is superfluous, I can remove
> it.

I'd prefer that you actually write a comment about what the function is
doing, maybe:

/*
 * Wrapper for simple hypercalls that only return a success/error code.
 */

... or *SOMETHING* that tells what its purpose in life is.

>>> +static inline u64 tdvmcall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
>>> +{
>>> +    u64 err;
>>> +
>>> +    err = __tdvmcall(fn, r12, r13, r14, r15, NULL);
>>> +
>>> +    if (err)
>>> +        pr_warn_ratelimited("TDVMCALL fn:%llx failed with err:%llx\n",
>>> +                    fn, err);
>>> +
>>> +    return err;
>>> +}
>>> +
>>> +/*
>>> + * Wrapper for the semi-common case where we need single output
>>> value (R11).
>>> + */
>>> +static inline u64 tdvmcall_out_r11(u64 fn, u64 r12, u64 r13, u64
>>> r14, u64 r15)
>>> +{
>>> +
>>> +    struct tdvmcall_output out = {0};
>>> +    u64 err;
>>> +
>>> +    err = __tdvmcall(fn, r12, r13, r14, r15, &out);
>>> +
>>> +    if (err)
>>> +        pr_warn_ratelimited("TDVMCALL fn:%llx failed with err:%llx\n",
>>> +                    fn, err);
>>> +
>>> +    return out.r11;
>>> +}
>>
>> How do callers check for errors?  Is the error value superfluously
>> returned in r11 and another output register?
> 
> We already check for error in this helper function. User of this function
> only cares about output value (R11). Mainly for in/out use case.

That's pretty valuable information.
