Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E6C379B91
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhEKAbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:31:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:40461 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231324AbhEKAbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:31:32 -0400
IronPort-SDR: XGAw3WXK+yJHYLPGRw6JY/UVn11qJfccCw2E3EEdo4etOB44WFr1RRg8HRa62TSQH877/wpNau
 QrFBt/+ECF8w==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="263250284"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="263250284"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 17:30:23 -0700
IronPort-SDR: 8cRZghJdbc+IxerH2JDRMseth8ezo5Yl9kjKpTZ76VqkEa7VkZhFCobXDKtjmXmJDXTwlsB4gK
 YD0D/PvxBGWQ==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="609289248"
Received: from kcmorris-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.213.165.53])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 17:30:22 -0700
Subject: Re: [RFC v2 14/32] x86/tdx: Handle port I/O
To:     Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <0e7e94d1ee4bae49dfd0dd441dc4f2ab6df76668.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jPLGs6p0PNZQB6yKB3QDtEcGb234zcgCbJutXxZZEGnA@mail.gmail.com>
 <e8ac31bc-e307-f277-f928-24ebba4cbca7@linux.intel.com>
 <CAPcyv4iuRdXooQvCzEWd9babzPij4nXpM-z5fai9+SGaeFYswQ@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <9f89a317-11fa-d784-87a8-37124891900c@linux.intel.com>
Date:   Mon, 10 May 2021 17:30:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iuRdXooQvCzEWd9babzPij4nXpM-z5fai9+SGaeFYswQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/21 4:34 PM, Dan Williams wrote:
> On Mon, May 10, 2021 at 4:08 PM Andi Kleen <ak@linux.intel.com> wrote:
>>
>>
>> On 5/10/2021 2:57 PM, Dan Williams wrote:
>>>
>>> There is a mix of direct-TDVMCALL usage and handling #VE when and why
>>> is either approached used?
>>
>> For the really early code in the decompressor or the main kernel we
>> can't use #VE because the IDT needed for handling the exception is not
>> set up, and some other infrastructure needed by the handler is missing.
>> The early code needs to do port IO to be able to write the early serial
>> console. To keep it all common it ended up that all port IO is paravirt.
>> Actually for most the main kernel port IO calls we could just use #VE
>> and it would result in smaller binaries, but then we would need to
>> annotate all early portio with some special name. That's why port IO is
>> all TDCALL.
> 
> Thanks Andi. Sathya, please include the above in the next posting.

Will include it.

> 
>>
>> For some others the only thing that really has to be #VE is MMIO because
>> we don't want to annotate every MMIO read*/write* with an alternative
>> (which would result in incredible binary bloat) For the others they have
>> mostly become now direct calls.
>>
>>
>>>
>>>> Decompression code uses port IO for earlyprintk. We must use
>>>> paravirt calls there too if we want to allow earlyprintk.
>>> What is the tradeoff between teaching the decompression code to handle
>>> #VE (the implied assumption) vs teaching it to avoid #VE with direct
>>> TDVMCALLs (the chosen direction)?
>>
>> The decompression code only really needs it to output something. But you
>> couldn't debug anything until #VE is set up. Also the decompression code
>> has a very basic environment that doesn't supply most kernel services,
>> and the #VE handler is relatively complicated. It would probably need to
>> be duplicated and the instruction decoder be ported to work in this
>> environment. It would be all a lot of work, just to make the debug
>> output work.
>>
>>>
>>>> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>>>> ---
>>>>    arch/x86/boot/compressed/Makefile |   1 +
>>>>    arch/x86/boot/compressed/tdcall.S |   9 ++
>>>>    arch/x86/include/asm/io.h         |   5 +-
>>>>    arch/x86/include/asm/tdx.h        |  46 ++++++++-
>>>>    arch/x86/kernel/tdcall.S          | 154 ++++++++++++++++++++++++++++++
>>> Why is this named "tdcall" when it is implementing tdvmcalls? I must
>>> say those names don't really help me understand what they do. Can we
>>> have Linux names that don't mandate keeping the spec terminology in my
>>> brain's translation cache?
>>
>> The instruction is called TDCALL. It's always the same instruction
>>
>> TDVMCALL is the variant when the host processes it (as opposed to the
>> TDX module), but it's just a different name space in the call number.
>>
>>
> 
> Ok.
> 
>>               \
>>
>>> Is there a unified Linux name these can be given to stop the
>>> proliferation of poor vendor names for similar concepts?
>>
>> We could use protected_guest()
> 
> Looks good.
> 
>>
>>
>>>
>>> Does it also not know how to handle #VE to keep it aligned with the
>>> runtime code?
>>
>>
>> Not sure I understand the question, but the decompression code supports
>> neither alternatives nor #VE. It's a very limited environment.
> 
> Yes, that addresses the question.
> 
>>
>>>
>>> Outside the boot decompression code isn't this branch of the "ifdef
>>> BOOT_COMPRESSED_MISC_H"  handled by #VE? I also don't see any usage of
>>> __{in,out}() in this patch.
>>
>> I thought it was all alternative after decompression, so the #VE code
>> shouldn't be called. We still have it for some reason though.
> 
> Right, I'm struggling to understand where these spurious in/out
> instructions are coming from that are not replaced by the
> alternative's code? Shouldn't those be dropped on the floor and warned
> about rather than handled? I.e. shouldn't port-io instruction escapes
> that would cause #VE be precluded at build-time?
> 
>>
>>
>>>
>>> Perhaps "PAYLOAD_SIZE" since it is used for both input and output?
>>>
>>> If the ABI does not include the size of the payload then how would
>>> code detect if even 80 bytes was violated in the future?
>>
>>
>> The payload in memory is just a Linux concept. At the TDCALL level it's
>> only registers.
>>
> 
> If it's only a Linux concept why does this code need to "prepare for
> the future"?

It is the software only structure. It is created to group all the output
registers used by VMM. You can find more details about it in patch titled
# "[RFC v2 05/32] x86/tdx: Add __tdcall() and __tdvmcall() helper functions"

It is mainly used by functions like __tdx_hypercall(),__tdx_hypercall_vendor_kvm()
and tdx_in{b,w,l}.

u64 __tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15,
                     struct tdx_hypercall_output *out);
u64 __tdx_hypercall_vendor_kvm(u64 fn, u64 r12, u64 r13, u64 r14,
                                u64 r15, struct tdx_hypercall_output *out);

struct tdx_hypercall_output {
         u64 r11;
         u64 r12;
         u64 r13;
         u64 r14;
         u64 r15;
};


Functions like __tdx_hypercall() and __tdx_hypercall_vendor_kvm() are used
by TDX guest to request services (like RDMSR, WRMSR,GetQuote, etc) from VMM
using TDCALL instruction. do_tdx_hypercall() is the helper function (in
tdcall.S) which actually implements this ABI.

As per current ABI, VMM will use registers R11-R15 to share the output
values with the guest. So we have defined the structure
struct tdx_hypercall_output to group all output registers and make it easier
to share it with users of the TDCALLs. This is Linux defined structure.

If there are any changes in TDCALL ABI for VMM, we might have to extend
this structure to accommodate new output register changes.  So if we
define TDVMCALL_OUTPUT_SIZE as 40, we will have modify this value for
any future struct tdx_hypercall_output changes. So to avoid it, we have
allocated double the size.

May be I should define it as,

#define TDVMCALL_OUTPUT_SIZE            sizeof(struct tdx_hypercall_output)

But currently we don't include the asm/tdx.h (which defines
struct tdx_hypercall_output) in tdcall.S. So I have defined the size as
constant value.

> 
> 
>>>
>>> 5
>>> Surely there's an existing macro for this pattern? Would
>>> PUSH_AND_CLEAR_REGS + POP_REGS be suitable? Besides code sharing it
>>> would eliminate clearing of %r8.
>>
>>
>> There used to be SAVE_ALL/SAVE_REGS, but they have been all removed in
>> some past refactorings.
> 
> Not a huge deal, but at a minimum it seems a generic construct that
> deserves to be declared centrally rather than tdx-guest-port-io local.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
