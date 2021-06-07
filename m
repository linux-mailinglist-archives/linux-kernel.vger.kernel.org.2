Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4E739E42E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 18:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbhFGQcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 12:32:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:28910 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235047AbhFGQaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 12:30:23 -0400
IronPort-SDR: Uazi1gBQF9VProAwN5YlmR+5pD36teF9v1zVt0p9ZjksmRSpEpiao4lKLZsVYwX/m4FHsekOZZ
 F7JpFuSdW/6A==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="185026032"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="185026032"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 09:24:59 -0700
IronPort-SDR: oZdKh5WZKjjkl4Pd56k808F/E/eVFoM6S3sj4BVi4vcCnW8tT66EdP0SD83xbI4t97HlBV1ads
 yDLZknw127zQ==
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="618995807"
Received: from ssanje1x-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.251.153.170])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 09:24:57 -0700
Subject: Re: [RFC v2-fix-v1 3/3] x86/tdx: Handle port I/O
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAPcyv4gBNqDFQEYjWqYTckPg-yy=LrvMw_FNY+tUuEwD35CfyA@mail.gmail.com>
 <20210527042356.3983284-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210527042356.3983284-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jRCZwoJoKGP4v3e8V6u4Y+1VZo_k=umQuh-rrAoMKg4Q@mail.gmail.com>
 <ca836226-46e1-389c-e5c8-c5f1c91130ea@linux.intel.com>
 <CAPcyv4gmokd5YTbL0X8w3KKV6EEO0xraaB-OEFJyncjaHQUUuw@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <2aba694b-ec36-d57f-06e0-a269f9953bb3@linux.intel.com>
Date:   Mon, 7 Jun 2021 09:24:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gmokd5YTbL0X8w3KKV6EEO0xraaB-OEFJyncjaHQUUuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/21 2:08 PM, Dan Williams wrote:
> On Sat, Jun 5, 2021 at 1:08 PM Kuppuswamy, Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>>
>>
>> On 6/5/21 11:52 AM, Dan Williams wrote:
>>> On Wed, May 26, 2021 at 9:24 PM Kuppuswamy Sathyanarayanan
>>> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>>>
>>>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>>>
>>>> TDX hypervisors cannot emulate instructions directly. This
>>>> includes port IO which is normally emulated in the hypervisor.
>>>> All port IO instructions inside TDX trigger the #VE exception
>>>> in the guest and would be normally emulated there.
>>>>
>>>> For the really early code in the decompressor, #VE cannot be
>>>> used because the IDT needed for handling the exception is not
>>>> set-up, and some other infrastructure needed by the handler
>>>> is missing. So to support port IO in decompressor code, add
>>>> support for paravirt based I/O port virtualization.
>>>>
>>>> Also string I/O is not supported in TDX guest. So, unroll the
>>>> string I/O operation into a loop operating on one element at
>>>> a time. This method is similar to AMD SEV, so just extend the
>>>> support for TDX guest platform.
>>>
>>> Given early port IO is broken out in its own previous I think it makes
>>> sense to break out the decompressor port IO enabling from final
>>> runtime port IO support.
>>
>> Patch titled "x86/tdx: Handle early IO operations" mainly adds
>> IO #VE support in early exception handler. Decompression code IO
>> support does not have dependency on it. You still think it is
>> better to move it that patch?
>>
> 
> No, I was suggesting three patches instead of 2:

Ok. I will move it to separate patch.

> 

snip

>>
>> Currently decompression code cannot use #VE based IO emulation. It does
>> not know how to handle #VE exceptions. Also, It is much easier to replace
>> IO calls with TDX hypercalls in decompression code when compared with
>> teaching how to handle #VE exceptions in decompression code.
> 
> Ok, but that does not answer the background behind the decision to use
> emulation rather than direct replacement of port IO instructions in
> the final kernel runtime image.

The reason for using #VE based emulation is,

1. It does not require changes to all usages of emulated instructions in
    all the drivers.
2. Directly replacing instructions with TDX hypercalls will lead to bloated
    image. So we cannot universally adapt this approach.

Reason for not adapting to use #VE approach for decompression code is,

1. #VE handler support does not exist for de-compressor code.
2. Adding such support is more complex and in-efficient (just for
    single use case of handling IO instructions).

So we have replaced IO instructions with TDX hypercalls in decompression code.

Did it answer your query?

> 
> This patch mixes those 2 concerns and I think it deserves to be broken
> out and explained.
> 



>>>> +/*
>>>> + * Helper function used for making hypercall for "out"
>>>> + * instruction. It will be called from __out IO
>>>> + * macro (in tdx.h).
>>>> + */
>>>> +void tdg_out(int size, int port, unsigned int value)
>>>> +{
>>>> +       __tdx_hypercall(EXIT_REASON_IO_INSTRUCTION, size, 1,
>>>> +                       port, value, NULL);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Helper function used for making hypercall for "in"
>>>> + * instruction. It will be called from __in IO macro
>>>> + * (in tdx.h). If IO is failed, it will return all 1s.
>>>> + */
>>>> +unsigned int tdg_in(int size, int port)
>>>> +{
>>>> +       struct tdx_hypercall_output out = {0};
>>>> +       int err;
>>>> +
>>>> +       err = __tdx_hypercall(EXIT_REASON_IO_INSTRUCTION, size, 0,
>>>> +                             port, 0, &out);
>>>> +
>>>> +       return err ? UINT_MAX : out.r11;
>>>> +}
>>>
>>> The previous patch open coded tdg_{in,out} and this one provides
>>> helpers. I think at a minimum they should be consistent and pick one
>>> style.
>>
>> As I have mentioned above, early IO #VE handler is a special case. we
>> don't want to complicate its code path with debug or tracing support.
>> So it is not a good comparison target.
> 
> This patch and the last do the same thing in 2 different ways. One of
> them should match the other even if the helpers are not directly
> reused.

I am not sure whether I understand your question. But if the question is
about different implementation, the difference is due to where it is
being called.

In early IO support patch, tdx_early_io() is called from #VE handler.
So there is extra buffer code to extract exception information from
struct ve_info.

In this case, the caller is __in/__out macros. So there is no need
for above mentioned buffer code.

Actual hypercall usage is similar in both cases.

> 
>> In this case, the reason for adding helper function is to make it easier
>> for calling it from tdx.h.
>>>
>>>> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
>>>> index ef7a686a55a9..daa75c8eef5d 100644
>>>> --- a/arch/x86/include/asm/io.h
>>>> +++ b/arch/x86/include/asm/io.h
>>>> @@ -40,6 +40,7 @@
>>>>
>>
>> snip
>>
>>>> +
>>>> +/* Helper function for converting {b,w,l} to byte size */
>>>> +static inline int tdx_get_iosize(char *str)
>>>> +{
>>>> +       if (str[0] == 'w')
>>>> +               return 2;
>>>> +       else if (str[0] == 'l')
>>>> +               return 4;
>>>> +
>>>> +       return 1;
>>>> +}
>>>
>>> This seems like an unnecessary novelty. The BUILDIO() macro in
>>> arch/x86/include/asm/io.h takes a type argument, why can't the size be
>>> explicitly specified rather than inferred from string parsing?
>>
>> I don't want to make changes to generic macros in io.h if it can be
>> avoided. It follows similar argument/type in all arch/* code. Also, it
>> is easier to handle TDX as a special case here.
>>
> 
> What changes are you talking about to the generic macros? The BUILDIO
> macro passes in a size parameter explicitly rather than inferring the
> size from the string name of an argument. BUILDIO does not need to
> change, it's backend just needs to do the right thing in the TDX case.
> 
> Otherwise, "I don't want to" is not a sufficient justification for
> avoiding needlessly new design patterns.

I hope this is what you meant?

--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -273,25 +273,25 @@ static inline bool sev_key_active(void) { return false; }
  #endif /* CONFIG_AMD_MEM_ENCRYPT */

  #ifndef __out
-#define __out(bwl, bw)                                                 \
+#define __out(bwl, bw, sz)                                             \
         asm volatile("out" #bwl " %" #bw "0, %w1" : : "a"(value), "Nd"(port))
  #endif

  #ifndef __in
-#define __in(bwl, bw)                                                  \
+#define __in(bwl, bw, sz)                                              \
         asm volatile("in" #bwl " %w1, %" #bw "0" : "=a"(value) : "Nd"(port))
  #endif

  #define BUILDIO(bwl, bw, type)                                         \
  static inline void out##bwl(unsigned type value, int port)             \
  {                                                                      \
-       __out(bwl, bw);                                                 \
+       __out(bwl, bw, sizeof(type));                                                   \
  }                                                                      \
                                                                         \
  static inline unsigned type in##bwl(int port)                          \
  {                                                                      \
         unsigned type value;                                            \
-       __in(bwl, bw);                                                  \
+       __in(bwl, bw, sizeof(type));                                                    \
         return value;                                                   \
  }

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
