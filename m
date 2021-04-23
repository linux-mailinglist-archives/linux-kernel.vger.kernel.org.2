Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F2E368A36
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 03:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbhDWBKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 21:10:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:4978 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229888AbhDWBKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 21:10:17 -0400
IronPort-SDR: 1f49P4dai298kdqBEHZtdiKLMh/QDwhK1ezPS/EuLwT6cUKur5I6Q41u8iB7y5GffYza9skv17
 +AZuVcfOnYxg==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="193883141"
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="193883141"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 18:09:42 -0700
IronPort-SDR: +H6Ny4mp+Si4UvBypVH6ZLLJZSMA5srf+U0rh+f7YB11hKlDLG3ce83kchirydrBUAXYc1zBzg
 g4iCxUXtfLBg==
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="402029304"
Received: from eassadia-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.4.68])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 18:09:41 -0700
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
 <596175e3-9d1e-6c9c-fadb-ad02c396e3ad@linux.intel.com>
 <d99941db-6ee6-267e-dece-6220af0ea305@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <9161efc0-fd25-d239-32b7-5d2c726579b0@linux.intel.com>
Date:   Thu, 22 Apr 2021 18:09:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d99941db-6ee6-267e-dece-6220af0ea305@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/21 4:42 PM, Dave Hansen wrote:
> On 4/20/21 4:12 PM, Kuppuswamy, Sathyanarayanan wrote:
>> On 4/20/21 12:59 PM, Dave Hansen wrote:
>>> On 4/20/21 12:20 PM, Kuppuswamy, Sathyanarayanan wrote:
>>>>>> approach is, it adds a few extra instructions for every
>>>>>> TDCALL use case when compared to distributed checks. Although
>>>>>> it's a bit less efficient, it's worth it to make the code more
>>>>>> readable.
>>>>>
>>>>> What's a "distributed check"?
>>>>
>>>> It should be "distributed TDVMCALL/TDCALL inline assembly calls"
>>>
>>> It's still not clear to what that refers.
>>
>> I am just comparing the performance cost of using generic
>> TDCALL()/TDVMCALL() function implementation with "usage specific"
>> (GetQuote,MapGPA, HLT,etc) custom TDCALL()/TDVMCALL() inline assembly
>> implementation.
> 
> So, I actually had an idea what you were talking about, but I have
> *ZERO* idea what "distributed" means in this context.
> 
> I think you are trying to say something along the lines of:
> 
> 	Just like syscalls, not all TDVMCALL/TDCALLs use the same set
> 	of argument registers.  The implementation here picks the
> 	current worst-case scenario for TDCALL (4 registers).  For
> 	TDCALLs with fewer than 4 arguments, there will end up being
> 	a few superfluous (cheap) instructions.  But, this approach
> 	maximizes code reuse.
> 

Yes, you are correct. I will word it better in my next version.

> 
>>>>> This also doesn't talk at all about why this approach was
>>>>> chosen versus inline assembly.  You're going to be asked "why
>>>>> not use inline asm?"
>>>> "To make the core more readable and less error prone." I have
>>>> added this info in above paragraph. Do you think we need more
>>>> argument to justify our approach?
>>>
>>> Yes, you need much more justification.  That's pretty generic and
>>> non-specific.
>> readability is one of the main motivation for not choosing inline
> 
> I'm curious.  Is there a reason you are not choosing to use
> capitalization in your replies?  I personally use capitalization as a
> visual clue for where a reply starts.
> 
> I'm not sure whether this indicates that your keyboard is not
> functioning properly, or that these replies are simply not important
> enough to warrant the use of the Shift key.  Or, is it simply an
> oversight?  Or, maybe I'm just being overly picky because I've been
> working on these exact things with my third-grader a bit too much lately.
> 
> Either way, I personally would appreciate your attention to detail in
> crafting writing that is easy to parse, since I'm the one that's going
> to have to parse it.  Details show that you care about the content you
> produce.  Even if you don't mean it, a lack of attention to detail (even
> capital letters) can be perceived to mean that you do not care about
> what you write.  If you don't care about it, why should the reader?
> 
>> assembly. Since number of lines of instructions (with comments) are
>> over 70, using inline assembly made it hard to read. Another reason
>> is, since we
>> are using many registers (R8-R15, R[A-D]X)) in TDVMCAL/TDCALL
>> operation, we are not sure whether some older compiler can follow
>> our specified inline assembly constraints.
> 
> As for the justification, that's much improved.  Please include that,
> along with some careful review of the grammar.

It's an oversight from my end. I will keep it in mind in my future
replies.


> 
>>>>>> +    movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx


>>>
>>> You've introduced two concepts here, without differentiating them.  You
>>> need to work to differentiate these two kinds of failure somewhere.  You
>>> can't simply refer to both as "failure".
>> will clarify it. I have assumed that once the user reads the spec, its
>> easier
>> to understand.
> 
> Your code should be 100% self-supporting without the spec.  The spec can
> be there in a supportive role to help resolve ambiguity or add fine
> detail.  But, I think this is a major, repeated problem with this patch
> set: it relies too much on reviewers spending quality time with the spec.
> 

I will review the patch set again and add necessary comments to fix this gap.

>>>>> Also, do you *REALLY* need to do this from assembly?  Can't it be done
>>>>> in the C wrapper?
>>>> Its common for all use cases of TDVMCALL (vendor specific, in/out, etc).
>>>> so added
>>>> it here.
>>>
>>> That's not a good reason.  You could just as easily have a C wrapper
>>> which all uses of TDVMCALL go through.
>> Any reason for not preferring it in assembly code?
> 
> Assembly is a last resort.  It should only be used for things that
> simply can't be written in C or are horrific to understand and manage
> when written in C.  A single statement like:
> 
> 	BUG_ON(something);
> 
> does not qualify in my book as something that's horrific to write in C.
> 
>> Also, using wrapper will add more complication for in/out instruction
>> substitution use case. please check the use case in following patch.
>> https://github.com/intel/tdx/commit/1b73f60aa5bb93554f3b15cd786a9b10b53c1543
> 
> I'm seeing a repeated theme here.  The approach in this patch series,
> and in this email thread in general appears to be one where the patch
> submitter is doing as little work as possible and trying to make the
> reviewer do as much work as possible.
> 
> This is a 300-line diff with all kinds of stuff going on in it.  I'm not
> sure to what you are referring.  You haven't made it easy to figure out.

I have pointed that patch to give reference to how in/out instructions
are substituted with tdvmcalls(). Specific implementation is spread across
multiple lines/files in that patch. So I did not include specific line
numbers.

But let me try to explain it here. What I meant by complication is,
for in/out instruction, we use alternative_io() to substitute in/out
instructions with tdg_in()/tdg_out() assembly calls. So we have to ensure
that we don't corrupt registers or stack from the substituted instructions

If you check the implementation of tdg_in()/tdg_out(), you will notice
that we have added code to preserve the caller registers. So, if we use
C wrapper for this use case, there is a chance that it might mess
the caller registers or stack.

	alternative_io("in" #bwl " %w2, %" #bw "0",			\
			"call tdg_in" #bwl, X86_FEATURE_TDX_GUEST,	\
			"=a"(value), "d"(port))

> 
> It would make it a lot easier if you pointed to a specific line, or
> copied-and-pasted the code to which you refer.  I would really encourage
> you to try to make your content easier for reviewers to digest:
> Capitalize the start of sentences.  Make unambiguous references to code.
>   Don't blindly cite the spec.  Fully express your thoughts.
> 
> You'll end up with happier reviewers instead of grumpy ones.

Got it. I will try to keep your suggestion in mind for future
communications.

> 
> ...
>>>> More warnings at-least show that we are working
>>>> with malicious VMM.
>>>

>> In our case, we will get WARN() output only if guest triggers
>> TDCALL()/TDVMCALL()
>> right? So getting WARN() message for failure of guest triggered call is
>> justifiable right?
> 
> The output of these calls and thus the error code comes from another
> piece of software, either the SEAM module or the VMM.
> 
> The error can be from one of several reasons:
>   1. Guest error/bug where the guest provides a bad value.  This is
>      probably the most likely scenario.  But, it's impossible to
>      differentiate from the other cases because it's a guest bug.
>   2. SEAM error/bug.  If the spec says "SEAM will not do this", then you
>      can probably justify a WARN_ON_ONCE().  If the call is security-
>      sensitve, like part of attestation, then you can't meaningfully
>      recover from it and it probably deserves a BUG_ON().
>   3. VMM error/bug/malice.  Again, you might be able to justify a
>      WARN_ON_ONCE().  We do that for userspace that might be attacking
>      the kernel.  These are *NEVER* fatal and should be rate-limited.
> 
> I don't see *ANYWHERE* in this list where an unbounded, unratelimited
> WARN() is appropriate.  But, that's just my $0.02.

WARN_ON_ONCE() will not work for our use case. Since tdvmcall()/tdcall()
can be triggered for multiple use cases. So we can't print errors only
once.

I will go with pr_warn_ratelimited() for this use case.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
