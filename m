Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487B6366081
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 21:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbhDTT7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 15:59:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:62327 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233541AbhDTT7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 15:59:38 -0400
IronPort-SDR: V5m9LuWJik0KtMKoU04oBWiSJsKKsC0UWW9jsrUNf0BMmEUVAmcZN4Sc0G/SAcG1ideKtjb6Wg
 YIlTwoTVeoFA==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="280910288"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="280910288"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 12:59:01 -0700
IronPort-SDR: 8XVI6usVjIG+YzKhX5aAnekrwkfvggesNDt6UtIJqPXFPu9FZhwBCGhIB0Ntdg0NLw0pwiNuJc
 xoECHrV1xpZw==
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="427140159"
Received: from plrogers-mobl1.amr.corp.intel.com (HELO [10.209.80.254]) ([10.209.80.254])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 12:59:01 -0700
Subject: Re: [PATCH v2 1/1] x86/tdx: Add __tdcall() and __tdvmcall() helper
 functions
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <14332abf-c78c-3bc2-9a7c-ceacfa7a0661@intel.com>
Date:   Tue, 20 Apr 2021 12:59:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2a3f6b3d-cd80-0734-ce83-c067666c8326@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/21 12:20 PM, Kuppuswamy, Sathyanarayanan wrote:
>>> approach is, it adds a few extra instructions for every
>>> TDCALL use case when compared to distributed checks. Although
>>> it's a bit less efficient, it's worth it to make the code more
>>> readable.
>>
>> What's a "distributed check"?
> 
> It should be "distributed TDVMCALL/TDCALL inline assembly calls"

It's still not clear to what that refers.

>> This also doesn't talk at all about why this approach was chosen versus
>> inline assembly.  You're going to be asked "why not use inline asm?"
> "To make the core more readable and less error prone." I have added this
> info in above paragraph. Do you think we need more argument to
> justify our approach?

Yes, you need much more justification.  That's pretty generic and
non-specific.

>>> +    /*
>>> +     * Expose R10 - R15, i.e. all GPRs that may be used by TDVMCALLs
>>> +     * defined in the GHCI.  Note, RAX and RCX are consumed, but
>>> only by
>>> +     * TDX-Module and so don't need to be listed in the mask.
>>> +     */
>>
>> "GCHI" is out of the blue here.  So is "TDX-Module".  There needs to be
>> more context.
> ok. will add it. Do you want GHCI spec reference with section id here?

Absolutely not.  I dislike all of the section references as-is.  Doesn't
a comment like this say what you said above and also add context?

	Expose every register currently used in the
	guest-to-host communication interface (GHCI).

>>> +    movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
>>> +
>>> +    tdcall
>>> +
>>> +    /* Panic if TDCALL reports failure. */
>>> +    test %rax, %rax
>>> +    jnz 2f
>>
>> Why panic?
> As per spec, TDCALL should never fail. Note that it has nothing to do
> with TDVMCALL function specific failure (which is reported via R10).

You've introduced two concepts here, without differentiating them.  You
need to work to differentiate these two kinds of failure somewhere.  You
can't simply refer to both as "failure".

>> Also, do you *REALLY* need to do this from assembly?  Can't it be done
>> in the C wrapper?
> Its common for all use cases of TDVMCALL (vendor specific, in/out, etc).
> so added
> it here.

That's not a good reason.  You could just as easily have a C wrapper
which all uses of TDVMCALL go through.

>>> +    /* Propagate TDVMCALL success/failure to return value. */
>>> +    mov %r10, %rax
>>
>> You just said it panic's on failure.  How can this propagate failure?
> we use panic for TDCALL failure. But, R10 content used to identify
> whether given
> TDVMCALL function operation is successful or not.

As I said above, please endeavor to differentiate the two classes of
failures.

Also, if the spec is violated, do you *REALLY* want to blow up the whole
world with a panic?  I guess you can argue that it could have been
something security-related that failed.  But, either way, you owe a
description of why panic'ing is a good idea, not just blindly deferring
to "the spec says this can't happen".

>>> +    xor %r10d, %r10d
>>> +    xor %r11d, %r11d
>>> +    xor %r12d, %r12d
>>> +    xor %r13d, %r13d
>>> +    xor %r14d, %r14d
>>> +    xor %r15d, %r15d
>>> +
>>> +    pop %r12
>>> +    pop %r13
>>> +    pop %r14
>>> +    pop %r15
>>> +
>>> +    FRAME_END
>>> +    ret
>>> +2:
>>> +    ud2
>>> +.endm
>>> +
>>> +SYM_FUNC_START(__tdvmcall)
>>> +    xor %r10, %r10
>>> +    tdvmcall_core
>>> +SYM_FUNC_END(__tdvmcall)
>>> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
>>> index 0d00dd50a6ff..1147e7e765d6 100644
>>> --- a/arch/x86/kernel/tdx.c
>>> +++ b/arch/x86/kernel/tdx.c
>>> @@ -3,6 +3,36 @@
>>>     #include <asm/tdx.h>
>>>   +/*
>>> + * Wrapper for the common case with standard output value (R10).
>>> + */
>>
>> ... and oddly enough there is no explicit mention of R10 anywhere.  Why?
> For Guest to Host call -> R10 holds TDCALL function id (which is 0 for
> TDVMCALL). so
> we don't need special argument.
> After TDVMCALL execution, R10 value is returned via RAX.

OK... so this is how it works.  But why mention R10 in the comment?  Why
is *THAT* worth mentioning?

>>> +static inline u64 tdvmcall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
>>> +{
>>> +    u64 err;
>>> +
>>> +    err = __tdvmcall(fn, r12, r13, r14, r15, NULL);
>>> +
>>> +    WARN_ON(err);
>>> +
>>> +    return err;
>>> +}
>>
>> Are there really *ZERO* reasons for a TDVMCALL to return an error?
> No. Its useful for debugging TDVMCALL failures.
>> Won't this let a malicious VMM spew endless warnings into the guest
>> console?
> As per GHCI spec, R10 will hold error code details which can be used to
> determine
> the type of TDVMCALL failure.

I would encourage you to stop citing the GCCI spec.  In all of these
conversations, you seem to rely on it without considering the underlying
reasons.  The fact that R10 is the error code is 100% irrelevant for
this conversation.

It's also entirely possible that the host would have bugs, or forget to
clear a bit somewhere, even if the spec says, "don't do it".

> More warnings at-least show that we are working
> with malicious VMM.

That argument does not hold water for me.

You can argue that a counter can be kept, or that a WARN_ON_ONCE() is
appropriate, or that a printk_ratelimited() is nice.  But, allowing an
untrusted software component to write unlimited warnings to the kernel
console is utterly nonsensical.

By the same argument, any userspace exploit attempts could spew warnings
to the console also so that we can tell we are working with malicious
userspace.

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
>>> +    WARN_ON(err);
>>> +
>>> +    return out.r11;
>>> +}
>>> +
>>
>> But you introduced __tdvmcall and __tdcall assembly functions.  Why
>> aren't both of them used?
> This patch just adds helper functions. Its used by other patches in the
> series. __tdvmcall is used in this patch because we need to add more
> wrappers for it.

That needs to be mentioned in the changelog at least.
