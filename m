Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C05366292
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 01:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbhDTXmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 19:42:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:13817 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234290AbhDTXmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 19:42:35 -0400
IronPort-SDR: hrdikfZPrOdpHZ47lUe0bu+WSW2+0hYGassgOMCHItETWdE3tZdKsaBELerZJcy00JZw2ysrmx
 HWZvlBZ6zSNw==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="280942988"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="280942988"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 16:42:03 -0700
IronPort-SDR: NMOC0JUOSXJUQfRnRPZMJcLkgEkW+eHHs5fgYYGt1fFlgnNWngev5ksxa6z51Vy0XhP4IwmMHT
 EMSrRS0FLBHw==
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="617166732"
Received: from mskothar-cxt3.amr.corp.intel.com (HELO [10.212.198.224]) ([10.212.198.224])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 16:42:02 -0700
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
 <14332abf-c78c-3bc2-9a7c-ceacfa7a0661@intel.com>
 <596175e3-9d1e-6c9c-fadb-ad02c396e3ad@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <d99941db-6ee6-267e-dece-6220af0ea305@intel.com>
Date:   Tue, 20 Apr 2021 16:42:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <596175e3-9d1e-6c9c-fadb-ad02c396e3ad@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/21 4:12 PM, Kuppuswamy, Sathyanarayanan wrote:
> On 4/20/21 12:59 PM, Dave Hansen wrote:
>> On 4/20/21 12:20 PM, Kuppuswamy, Sathyanarayanan wrote:
>>>>> approach is, it adds a few extra instructions for every
>>>>> TDCALL use case when compared to distributed checks. Although
>>>>> it's a bit less efficient, it's worth it to make the code more
>>>>> readable.
>>>>
>>>> What's a "distributed check"?
>>>
>>> It should be "distributed TDVMCALL/TDCALL inline assembly calls"
>>
>> It's still not clear to what that refers.
> 
> I am just comparing the performance cost of using generic 
> TDCALL()/TDVMCALL() function implementation with "usage specific"
> (GetQuote,MapGPA, HLT,etc) custom TDCALL()/TDVMCALL() inline assembly
> implementation.

So, I actually had an idea what you were talking about, but I have
*ZERO* idea what "distributed" means in this context.

I think you are trying to say something along the lines of:

	Just like syscalls, not all TDVMCALL/TDCALLs use the same set
	of argument registers.  The implementation here picks the
	current worst-case scenario for TDCALL (4 registers).  For
	TDCALLs with fewer than 4 arguments, there will end up being
	a few superfluous (cheap) instructions.  But, this approach
	maximizes code reuse.


>>>> This also doesn't talk at all about why this approach was
>>>> chosen versus inline assembly.  You're going to be asked "why
>>>> not use inline asm?"
>>> "To make the core more readable and less error prone." I have
>>> added this info in above paragraph. Do you think we need more
>>> argument to justify our approach?
>> 
>> Yes, you need much more justification.  That's pretty generic and 
>> non-specific.
> readability is one of the main motivation for not choosing inline 

I'm curious.  Is there a reason you are not choosing to use
capitalization in your replies?  I personally use capitalization as a
visual clue for where a reply starts.

I'm not sure whether this indicates that your keyboard is not
functioning properly, or that these replies are simply not important
enough to warrant the use of the Shift key.  Or, is it simply an
oversight?  Or, maybe I'm just being overly picky because I've been
working on these exact things with my third-grader a bit too much lately.

Either way, I personally would appreciate your attention to detail in
crafting writing that is easy to parse, since I'm the one that's going
to have to parse it.  Details show that you care about the content you
produce.  Even if you don't mean it, a lack of attention to detail (even
capital letters) can be perceived to mean that you do not care about
what you write.  If you don't care about it, why should the reader?

> assembly. Since number of lines of instructions (with comments) are 
> over 70, using inline assembly made it hard to read. Another reason 
> is, since we
> are using many registers (R8-R15, R[A-D]X)) in TDVMCAL/TDCALL 
> operation, we are not sure whether some older compiler can follow
> our specified inline assembly constraints.

As for the justification, that's much improved.  Please include that,
along with some careful review of the grammar.

>>>>> +    movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
>>>>> +
>>>>> +    tdcall
>>>>> +
>>>>> +    /* Panic if TDCALL reports failure. */
>>>>> +    test %rax, %rax
>>>>> +    jnz 2f
>>>>
>>>> Why panic?
>>> As per spec, TDCALL should never fail. Note that it has nothing to do
>>> with TDVMCALL function specific failure (which is reported via R10).
>>
>> You've introduced two concepts here, without differentiating them.  You
>> need to work to differentiate these two kinds of failure somewhere.  You
>> can't simply refer to both as "failure".
> will clarify it. I have assumed that once the user reads the spec, its
> easier
> to understand.

Your code should be 100% self-supporting without the spec.  The spec can
be there in a supportive role to help resolve ambiguity or add fine
detail.  But, I think this is a major, repeated problem with this patch
set: it relies too much on reviewers spending quality time with the spec.

>>>> Also, do you *REALLY* need to do this from assembly?  Can't it be done
>>>> in the C wrapper?
>>> Its common for all use cases of TDVMCALL (vendor specific, in/out, etc).
>>> so added
>>> it here.
>>
>> That's not a good reason.  You could just as easily have a C wrapper
>> which all uses of TDVMCALL go through.
> Any reason for not preferring it in assembly code?

Assembly is a last resort.  It should only be used for things that
simply can't be written in C or are horrific to understand and manage
when written in C.  A single statement like:

	BUG_ON(something);

does not qualify in my book as something that's horrific to write in C.

> Also, using wrapper will add more complication for in/out instruction
> substitution use case. please check the use case in following patch.
> https://github.com/intel/tdx/commit/1b73f60aa5bb93554f3b15cd786a9b10b53c1543

I'm seeing a repeated theme here.  The approach in this patch series,
and in this email thread in general appears to be one where the patch
submitter is doing as little work as possible and trying to make the
reviewer do as much work as possible.

This is a 300-line diff with all kinds of stuff going on in it.  I'm not
sure to what you are referring.  You haven't made it easy to figure out.

It would make it a lot easier if you pointed to a specific line, or
copied-and-pasted the code to which you refer.  I would really encourage
you to try to make your content easier for reviewers to digest:
Capitalize the start of sentences.  Make unambiguous references to code.
 Don't blindly cite the spec.  Fully express your thoughts.

You'll end up with happier reviewers instead of grumpy ones.

...
>>> More warnings at-least show that we are working
>>> with malicious VMM.
>>
>> That argument does not hold water for me.
>>
>> You can argue that a counter can be kept, or that a WARN_ON_ONCE() is
>> appropriate, or that a printk_ratelimited() is nice.  But, allowing an
>> untrusted software component to write unlimited warnings to the kernel
>> console is utterly nonsensical.
>>
>> By the same argument, any userspace exploit attempts could spew warnings
>> to the console also so that we can tell we are working with malicious
>> userspace.
> In our case, we will get WARN() output only if guest triggers
> TDCALL()/TDVMCALL()
> right? So getting WARN() message for failure of guest triggered call is
> justifiable right?

The output of these calls and thus the error code comes from another
piece of software, either the SEAM module or the VMM.

The error can be from one of several reasons:
 1. Guest error/bug where the guest provides a bad value.  This is
    probably the most likely scenario.  But, it's impossible to
    differentiate from the other cases because it's a guest bug.
 2. SEAM error/bug.  If the spec says "SEAM will not do this", then you
    can probably justify a WARN_ON_ONCE().  If the call is security-
    sensitve, like part of attestation, then you can't meaningfully
    recover from it and it probably deserves a BUG_ON().
 3. VMM error/bug/malice.  Again, you might be able to justify a
    WARN_ON_ONCE().  We do that for userspace that might be attacking
    the kernel.  These are *NEVER* fatal and should be rate-limited.

I don't see *ANYWHERE* in this list where an unbounded, unratelimited
WARN() is appropriate.  But, that's just my $0.02.
