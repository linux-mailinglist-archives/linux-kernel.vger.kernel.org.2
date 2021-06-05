Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CE239CAD4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 22:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhFEUKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 16:10:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:36192 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhFEUKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 16:10:44 -0400
IronPort-SDR: 35YwPVilTRE/1KGrAXkB/m5XRU/+5FYjMnKAtNYnKJeADPzZhnu0TzuWizoL+SYM691+p62ykB
 EH5gahk7A3Gw==
X-IronPort-AV: E=McAfee;i="6200,9189,10006"; a="290085259"
X-IronPort-AV: E=Sophos;i="5.83,251,1616482800"; 
   d="scan'208";a="290085259"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 13:08:53 -0700
IronPort-SDR: ZaR4HwTiWtdK9M06M2c4kmEkqJnsdW5fLUiTWQkAA3jttUMtMCfVamoHmai6bCoZu0Fyt+0IIl
 9evj1q2iTALw==
X-IronPort-AV: E=Sophos;i="5.83,251,1616482800"; 
   d="scan'208";a="448647130"
Received: from eawilkin-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.213.172.148])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 13:08:52 -0700
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
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <ca836226-46e1-389c-e5c8-c5f1c91130ea@linux.intel.com>
Date:   Sat, 5 Jun 2021 13:08:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jRCZwoJoKGP4v3e8V6u4Y+1VZo_k=umQuh-rrAoMKg4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/21 11:52 AM, Dan Williams wrote:
> On Wed, May 26, 2021 at 9:24 PM Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>
>> TDX hypervisors cannot emulate instructions directly. This
>> includes port IO which is normally emulated in the hypervisor.
>> All port IO instructions inside TDX trigger the #VE exception
>> in the guest and would be normally emulated there.
>>
>> For the really early code in the decompressor, #VE cannot be
>> used because the IDT needed for handling the exception is not
>> set-up, and some other infrastructure needed by the handler
>> is missing. So to support port IO in decompressor code, add
>> support for paravirt based I/O port virtualization.
>>
>> Also string I/O is not supported in TDX guest. So, unroll the
>> string I/O operation into a loop operating on one element at
>> a time. This method is similar to AMD SEV, so just extend the
>> support for TDX guest platform.
> 
> Given early port IO is broken out in its own previous I think it makes
> sense to break out the decompressor port IO enabling from final
> runtime port IO support.

Patch titled "x86/tdx: Handle early IO operations" mainly adds
IO #VE support in early exception handler. Decompression code IO
support does not have dependency on it. You still think it is
better to move it that patch?

> 
> The argument in the previous patch about using #VE emulation in the
> early code was collisions with trace and printk support in the "fully
> featured" #VE handler later in the series. My interpretation of that
> collision was due to the possibility of the #VE handler going into
> infinite recursion if a printk in the handler triggered port IO. It

No. AFAIK, It has nothing to do with infinite recursion. We are just
highlighting the fact that when kernel uses early exception handler
support, we cannot use code path that enables tracing support. So we
use simplest way to trigger IO hypercalls.

if (early #VE exception path)
     handle_io_ve()
         __tdx_hypercall

if (normal #VE path)
     handle_io_ve()
         __tdx_hypercall (current version)
	// Later on when adding tracing support, we will replace it
	// with trace hypercalls.
	__trace_tdx_hypercall

As you can see in above design flow, later on when adding tracing
support we will have split the early #IO handling code from
normal IO handling code. So instead of using common code now and
refactor it later on, we just use different code path for both
of them.

> seems I do not have the right picture of the constraints. Given the
> runtime kernel can direct replace in/out macros I would expect a
> statement of the tradeoff with #VE emulation and why the post
> decompressor code is still using emulation.

Currently decompression code cannot use #VE based IO emulation. It does
not know how to handle #VE exceptions. Also, It is much easier to replace
IO calls with TDX hypercalls in decompression code when compared with
teaching how to handle #VE exceptions in decompression code.

> 
>>
>> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> ---
>>   arch/x86/boot/compressed/Makefile |  1 +
>>   arch/x86/boot/compressed/tdcall.S |  3 ++
>>   arch/x86/boot/compressed/tdx.c    | 28 ++++++++++++++++++
>>   arch/x86/include/asm/io.h         |  7 +++--
>>   arch/x86/include/asm/tdx.h        | 47 ++++++++++++++++++++++++++++++-
>>   arch/x86/kernel/tdx.c             | 39 +++++++++++++++++++++++++
>>   6 files changed, 122 insertions(+), 3 deletions(-)
>>   create mode 100644 arch/x86/boot/compressed/tdcall.S
>>
>> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
>> index a2554621cefe..a944a2038797 100644
>> --- a/arch/x86/boot/compressed/Makefile
>> +++ b/arch/x86/boot/compressed/Makefile
>> @@ -97,6 +97,7 @@ endif
>>

>>   static int __ro_after_init tdx_guest = -1;
>>
>> @@ -30,3 +32,29 @@ bool is_tdx_guest(void)
>>          return !!tdx_guest;
>>   }
>>
>> +/*
>> + * Helper function used for making hypercall for "out"
>> + * instruction. It will be called from __out IO
>> + * macro (in tdx.h).
>> + */
>> +void tdg_out(int size, int port, unsigned int value)
>> +{
>> +       __tdx_hypercall(EXIT_REASON_IO_INSTRUCTION, size, 1,
>> +                       port, value, NULL);
>> +}
>> +
>> +/*
>> + * Helper function used for making hypercall for "in"
>> + * instruction. It will be called from __in IO macro
>> + * (in tdx.h). If IO is failed, it will return all 1s.
>> + */
>> +unsigned int tdg_in(int size, int port)
>> +{
>> +       struct tdx_hypercall_output out = {0};
>> +       int err;
>> +
>> +       err = __tdx_hypercall(EXIT_REASON_IO_INSTRUCTION, size, 0,
>> +                             port, 0, &out);
>> +
>> +       return err ? UINT_MAX : out.r11;
>> +}
> 
> The previous patch open coded tdg_{in,out} and this one provides
> helpers. I think at a minimum they should be consistent and pick one
> style.

As I have mentioned above, early IO #VE handler is a special case. we
don't want to complicate its code path with debug or tracing support.
So it is not a good comparison target.

In this case, the reason for adding helper function is to make it easier
for calling it from tdx.h.

> 
>> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
>> index ef7a686a55a9..daa75c8eef5d 100644
>> --- a/arch/x86/include/asm/io.h
>> +++ b/arch/x86/include/asm/io.h
>> @@ -40,6 +40,7 @@
>>

snip

>> +
>> +/* Helper function for converting {b,w,l} to byte size */
>> +static inline int tdx_get_iosize(char *str)
>> +{
>> +       if (str[0] == 'w')
>> +               return 2;
>> +       else if (str[0] == 'l')
>> +               return 4;
>> +
>> +       return 1;
>> +}
> 
> This seems like an unnecessary novelty. The BUILDIO() macro in
> arch/x86/include/asm/io.h takes a type argument, why can't the size be
> explicitly specified rather than inferred from string parsing?

I don't want to make changes to generic macros in io.h if it can be
avoided. It follows similar argument/type in all arch/* code. Also, it
is easier to handle TDX as a special case here.


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
