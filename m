Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71886366260
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 01:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbhDTXNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 19:13:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:30686 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233964AbhDTXNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 19:13:02 -0400
IronPort-SDR: ma7k7HFne186rg/IgQyY52hVg7iGWIZH+qD4a0Ee+hlqlsSoGpQfxivBjNzenRAerUGwiZdePH
 GEnxa72X9xtw==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="182740946"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="182740946"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 16:12:29 -0700
IronPort-SDR: cMYr2kc8hiDuvhb4lHJOyxMMMT1gI2jN6yt7/wcJ8y2VkfWv7DK11C6nje/wpscs63OGy/PR26
 PmZgZ87wQZDQ==
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="427240482"
Received: from jjagger-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.197.239])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 16:12:29 -0700
Subject: Re: [PATCH v2 1/1] x86/tdx: Add __tdcall() and __tdvmcall() helper
 functions
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <8723950c-e07c-9a03-503a-ab232701d1e9@linux.intel.com>
 <c015093fdbc8e6a5aa9fc43f78fec8d9c38295c7.1616801167.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <77a13ae9-0220-030e-7ae4-fd26edd7b110@intel.com>
 <2a3f6b3d-cd80-0734-ce83-c067666c8326@linux.intel.com>
 <14332abf-c78c-3bc2-9a7c-ceacfa7a0661@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <596175e3-9d1e-6c9c-fadb-ad02c396e3ad@linux.intel.com>
Date:   Tue, 20 Apr 2021 16:12:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <14332abf-c78c-3bc2-9a7c-ceacfa7a0661@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/21 12:59 PM, Dave Hansen wrote:
> On 4/20/21 12:20 PM, Kuppuswamy, Sathyanarayanan wrote:
>>>> approach is, it adds a few extra instructions for every
>>>> TDCALL use case when compared to distributed checks. Although
>>>> it's a bit less efficient, it's worth it to make the code more
>>>> readable.
>>>
>>> What's a "distributed check"?
>>
>> It should be "distributed TDVMCALL/TDCALL inline assembly calls"
> 
> It's still not clear to what that refers.

I am just comparing the performance cost of using generic TDCALL()/TDVMCALL()
function implementation with "usage specific" (GetQuote,MapGPA, HLT,etc) custom
TDCALL()/TDVMCALL() inline assembly implementation.
> 
>>> This also doesn't talk at all about why this approach was chosen versus
>>> inline assembly.  You're going to be asked "why not use inline asm?"
>> "To make the core more readable and less error prone." I have added this
>> info in above paragraph. Do you think we need more argument to
>> justify our approach?
> 
> Yes, you need much more justification.  That's pretty generic and
> non-specific.
readability is one of the main motivation for not choosing inline
assembly. Since number of lines of instructions (with comments) are over
70, using inline assembly made it hard to read. Another reason is, since we
are using many registers (R8-R15, R[A-D]X)) in TDVMCAL/TDCALL operation, we are
not sure whether some older compiler can follow our specified inline assembly
constraints.
> 
>>>> +    /*
>>>> +     * Expose R10 - R15, i.e. all GPRs that may be used by TDVMCALLs
>>>> +     * defined in the GHCI.  Note, RAX and RCX are consumed, but
>>>> only by
>>>> +     * TDX-Module and so don't need to be listed in the mask.
>>>> +     */
>>>
>>> "GCHI" is out of the blue here.  So is "TDX-Module".  There needs to be
>>> more context.
>> ok. will add it. Do you want GHCI spec reference with section id here?
> 
> Absolutely not.  I dislike all of the section references as-is.  Doesn't
> a comment like this say what you said above and also add context?
> 
> 	Expose every register currently used in the
> 	guest-to-host communication interface (GHCI).
ok.
> 
>>>> +    movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
>>>> +
>>>> +    tdcall
>>>> +
>>>> +    /* Panic if TDCALL reports failure. */
>>>> +    test %rax, %rax
>>>> +    jnz 2f
>>>
>>> Why panic?
>> As per spec, TDCALL should never fail. Note that it has nothing to do
>> with TDVMCALL function specific failure (which is reported via R10).
> 
> You've introduced two concepts here, without differentiating them.  You
> need to work to differentiate these two kinds of failure somewhere.  You
> can't simply refer to both as "failure".
will clarify it. I have assumed that once the user reads the spec, its easier
to understand.
> 
>>> Also, do you *REALLY* need to do this from assembly?  Can't it be done
>>> in the C wrapper?
>> Its common for all use cases of TDVMCALL (vendor specific, in/out, etc).
>> so added
>> it here.
> 
> That's not a good reason.  You could just as easily have a C wrapper
> which all uses of TDVMCALL go through.
Any reason for not preferring it in assembly code?
Also, using wrapper will add more complication for in/out instruction
substitution use case. please check the use case in following patch.
https://github.com/intel/tdx/commit/1b73f60aa5bb93554f3b15cd786a9b10b53c1543
> 
>>>> +    /* Propagate TDVMCALL success/failure to return value. */
>>>> +    mov %r10, %rax
>>>
>>> You just said it panic's on failure.  How can this propagate failure?
>> we use panic for TDCALL failure. But, R10 content used to identify
>> whether given
>> TDVMCALL function operation is successful or not.
> 
> As I said above, please endeavor to differentiate the two classes of
> failures.
> 
> Also, if the spec is violated, do you *REALLY* want to blow up the whole
> world with a panic?  I guess you can argue that it could have been
> something security-related that failed.  But, either way, you owe a
> description of why panic'ing is a good idea, not just blindly deferring
> to "the spec says this can't happen".
ok. will add some comments justifying our case.
> 
>>>> +    xor %r10d, %r10d
>>>> +    xor %r11d, %r11d
>>>> +    xor %r12d, %r12d
>>>> +    xor %r13d, %r13d
>>>> +    xor %r14d, %r14d
>>>> +    xor %r15d, %r15d
>>>> +
>>>> +    pop %r12
>>>> +    pop %r13
>>>> +    pop %r14
>>>> +    pop %r15
>>>> +
>>>> +    FRAME_END
>>>> +    ret
>>>> +2:
>>>> +    ud2
>>>> +.endm
>>>> +
>>>> +SYM_FUNC_START(__tdvmcall)
>>>> +    xor %r10, %r10
>>>> +    tdvmcall_core
>>>> +SYM_FUNC_END(__tdvmcall)
>>>> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
>>>> index 0d00dd50a6ff..1147e7e765d6 100644
>>>> --- a/arch/x86/kernel/tdx.c
>>>> +++ b/arch/x86/kernel/tdx.c
>>>> @@ -3,6 +3,36 @@
>>>>      #include <asm/tdx.h>
>>>>    +/*
>>>> + * Wrapper for the common case with standard output value (R10).
>>>> + */
>>>
>>> ... and oddly enough there is no explicit mention of R10 anywhere.  Why?
>> For Guest to Host call -> R10 holds TDCALL function id (which is 0 for
>> TDVMCALL). so
>> we don't need special argument.
>> After TDVMCALL execution, R10 value is returned via RAX.
> 
> OK... so this is how it works.  But why mention R10 in the comment?  Why
> is *THAT* worth mentioning?
its not needed. will remove it.
> 
>>>> +static inline u64 tdvmcall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
>>>> +{
>>>> +    u64 err;
>>>> +
>>>> +    err = __tdvmcall(fn, r12, r13, r14, r15, NULL);
>>>> +
>>>> +    WARN_ON(err);
>>>> +
>>>> +    return err;
>>>> +}
>>>
>>> Are there really *ZERO* reasons for a TDVMCALL to return an error?
>> No. Its useful for debugging TDVMCALL failures.
>>> Won't this let a malicious VMM spew endless warnings into the guest
>>> console?
>> As per GHCI spec, R10 will hold error code details which can be used to
>> determine
>> the type of TDVMCALL failure.
> 
> I would encourage you to stop citing the GCCI spec.  In all of these
> conversations, you seem to rely on it without considering the underlying
> reasons.  The fact that R10 is the error code is 100% irrelevant for
> this conversation.
> 
> It's also entirely possible that the host would have bugs, or forget to
> clear a bit somewhere, even if the spec says, "don't do it".
> 
>> More warnings at-least show that we are working
>> with malicious VMM.
> 
> That argument does not hold water for me.
> 
> You can argue that a counter can be kept, or that a WARN_ON_ONCE() is
> appropriate, or that a printk_ratelimited() is nice.  But, allowing an
> untrusted software component to write unlimited warnings to the kernel
> console is utterly nonsensical.
> 
> By the same argument, any userspace exploit attempts could spew warnings
> to the console also so that we can tell we are working with malicious
> userspace.
In our case, we will get WARN() output only if guest triggers TDCALL()/TDVMCALL()
right? So getting WARN() message for failure of guest triggered call is
justifiable right?
> 
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
>>>> +    WARN_ON(err);
>>>> +
>>>> +    return out.r11;
>>>> +}
>>>> +
>>>
>>> But you introduced __tdvmcall and __tdcall assembly functions.  Why
>>> aren't both of them used?
>> This patch just adds helper functions. Its used by other patches in the
>> series. __tdvmcall is used in this patch because we need to add more
>> wrappers for it.
> 
> That needs to be mentioned in the changelog at least.
ok will do it.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
