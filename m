Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FC736C7C3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbhD0Oa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:30:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:46860 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236395AbhD0OaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:30:24 -0400
IronPort-SDR: oScW3M1e4YuW/k7PdhHyC+qvr6/3PetAjzJ4uQzIIpJTATKzbeO5h+tEJ2pN3QevySFgMETqEH
 NmED84wQiXYg==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="217228701"
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="217228701"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 07:29:40 -0700
IronPort-SDR: UeEHWzEzD5Dm+29IJJO61K43cEEHP6zvOpKH4GlFRqqsf8/GrefzH0EImNbOUrdauCHCNfjylE
 J0tvgZNdpO0g==
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="526105282"
Received: from westbren-mobl2.amr.corp.intel.com (HELO [10.254.36.49]) ([10.254.36.49])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 07:29:40 -0700
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
 <33af5bd4-7ada-8450-5a86-90023145d481@intel.com>
 <849d8039-b43c-0790-be1c-aaac8c06608a@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <2f26e352-99e4-8531-221a-eb9641c67ec0@intel.com>
Date:   Tue, 27 Apr 2021 07:29:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <849d8039-b43c-0790-be1c-aaac8c06608a@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/21 7:29 PM, Kuppuswamy, Sathyanarayanan wrote:
> On 4/26/21 4:17 PM, Dave Hansen wrote:
>> On 4/26/21 3:31 PM, Kuppuswamy, Sathyanarayanan wrote:
>>>>> +#define tdcall .byte 0x66,0x0f,0x01,0xcc
>>>>> +
>>>>> +/*
>>>>> + * __tdcall()  - Used to communicate with the TDX module
>>>>
>>>> Why is this function here?  What does it do?  Why do we need it?
>>>
>>> __tdcall() function is used to request services from the TDX Module.
>>> Example use cases are, TDREPORT, VEINFO, TDINFO, etc.
>>
>> I think there might be some misinterpretation of my question.  What you
>> are describing is what *TDCALL* does.  Why do we need a wrapper
>> function?  What purpose does this wrapper function serve?  Why do we
>> need this wrapper function?
>>
> How about following explanation?
> 
> Helper function for "tdcall" instruction, which can be used to request
> services from the TDX module (does not include VMM). Few examples of
> valid TDX module services are, "TDREPORT", "MEM PAGE ACCEPT", "VEINFO",
> etc.

Naming the services here is not useful.  If I want to know who calls
this, I'll just literally do that: look up the callers of this function.

> This function serves as a wrapper to move user call arguments to
> the correct registers as specified by "tdcall" ABI and shares it with
> the TDX module.  If the "tdcall" operation is successful and a
> valid "struct tdcall_out" pointer is available (in "out" argument),
> output from the TDX module (RCX, RDX, R8-R11) is saved to the memory
> specified in the "out" pointer. Also the status of the "tdcall"
> operation is returned back to the user as a function return value.

I tend to prefer function comments that talk high-level about what the
function does rather than waste space on the exact registers used in the
ABI.  I also tend not to talk about things that can be trivially grepped
for, like the callers of this function.

I'd trim the fat out of there, but it's generally OK, although too
rotund for my taste.

>>>>> +    /* Move TDCALL Leaf ID to RAX */
>>>>> +    mov %rdi, %rax
>>>>> +    /* Move output pointer to R12 */
>>>>> +    mov %r9, %r12
>>>>
>>>> I thought 'struct tdcall_output' was a purely software construct.  Why
>>>> are we passing a pointer to it into TDCALL?
>>>
>>> Its used to store the TDCALL result (RCX, RDX, R8-R11). As far as this
>>> function is concerned, its just a block of memory (accessed using
>>> base address + TDCALL_r* offsets).
>>
>> Is 'struct tdcall_output' a hardware architectural structure or a
>> software structure?
>>
>> If it's a software structure, then why are we passing a pointer to a
>> software structure into a hardware ABI?
>>
>> If it's a hardware architecture structure, where is the documentation
>> for it?
>>
> 
> I think there is a misunderstanding here. We don't share the tdcall_output
> pointer with the TDX module. Current use cases of TDCALL (other than
> TDVMCALL)
> do not use registers from R12-R15. Since the registers R12-R15 are free and
> available, we are using R12 as temporary storage to hold the tdcall_output
> pointer.

In other words, 'struct tdcall_output' is a purely software concept.
However, its pointer is manipulated literally next to all of the TDCALL
register arguments and it has an *IDENTICAL* comment to all of those
other moves.

Please make it clear that %r12 is not being used at all for the TDCALL
instruction itself.

But, the bigger point here is that the code needs to be structured in a
way that makes the function and interactions clear.  If I want to know
more about the "output pointer", where do I go?  Do I go looking at the
calling functions or the TDINFO instruction reference?

...
>> Please go look at some other assembly code in the kernel called from C.
>>   Do those functions do this?  Why?  Why not?  Do they care about
>> "passing stale values back up"?
> 
> Maybe I am being overly cautious here. Since TDX module is the trusted
> code, speculation attack is not a consideration here. I will remove this
> block of code.

Caution is OK.  Caution without explanation somewhere as to why it is
warranted is not.

> Do we need to rename the helper functions ?
> 
> tdvmcall(), tdvmcall_out_r11()

Yes.

> Also what about output structs?
> 
> struct tdcall_output
> struct tdvmcall_output

Yes, they need sane, straightforward names which are not confusing too.

>>>>> +/* Helper function for standard type of TDVMCALL */
>>>>> +SYM_FUNC_START(__tdvmcall)
>>>>> +    /* Set TDVMCALL type info (0 - Standard, > 0 - vendor) in R10 */
>>>>> +    xor %r10, %r10
>>>>> +    call do_tdvmcall
>>>>> +    retq
>>>>> +SYM_FUNC_END(__tdvmcall)
>>>>
>>>> Why do we need this helper?  Why does it need to be in assembly?
>>>
>>> Its simpler to do it in assembly. Also, grouping all register updates
>>> in the same file will make it easier for us to read or debug issues.
>>> Another
>>> reason is, we also call do_tdvmcall() from in/out instruction use case.
>>
>> Sathya, I seem to have to reverse-engineer what you are doing for all
>> this stuff.  Your answers to my questions are almost entirely orthogonal
>> to the things I really want to know.  I guess I need to be more precise
>> with the questions I'm asking.  But, this is yet another case where I
>> think the burden for this series continues to fall on the reviewer
>> rather than the submitter.  Not the way I think it is best.
> 
> I have assumed that you are aware of reason for the existence of
> do_tdvmcall() helper function. It is mainly created to hold common
> code between vendor specific and standard type of tdvmcall's.

No, I was not aware of that.  Remember, you're not doing this for *ME*.
 You're doing it for the hundred other people that are going to look
over the code and who won't have been aware of your reasoning.
