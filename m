Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30822379CF0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 04:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhEKCbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 22:31:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:23183 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229684AbhEKCbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 22:31:02 -0400
IronPort-SDR: Y4ujkhTrdb82Fl3lcXq/dOlyTNO1maNwqKvAxVLKbcwRRa5mBYJGXVsGrdicsHipYx5Wqk+VGk
 m6LqjRYSdYSA==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="263267537"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="263267537"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 19:29:56 -0700
IronPort-SDR: JSiajLRu7fumkHuyPqtApzVDLYKtwJwjuqA9tAqgyCqqce0VhFGUmoMhAo5Y37lDyNgpqSU7C2
 bA1+1dfUjRQA==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="609321258"
Received: from kcmorris-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.213.165.53])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 19:29:55 -0700
Subject: Re: [RFC v2 14/32] x86/tdx: Handle port I/O
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
 <9f89a317-11fa-d784-87a8-37124891900c@linux.intel.com>
 <CAPcyv4hymb73WZ7QqNsDyKiPzsFdPJF63+MLnOTfJMsQBFvSDg@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <3059c7d3-8646-2e1a-3c9f-1de67f7ed382@linux.intel.com>
Date:   Mon, 10 May 2021 19:29:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hymb73WZ7QqNsDyKiPzsFdPJF63+MLnOTfJMsQBFvSDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/21 6:07 PM, Dan Williams wrote:
> On Mon, May 10, 2021 at 5:30 PM Kuppuswamy, Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> [..]
>> It is mainly used by functions like __tdx_hypercall(),__tdx_hypercall_vendor_kvm()
>> and tdx_in{b,w,l}.
>>
>> u64 __tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15,
>>                       struct tdx_hypercall_output *out);
>> u64 __tdx_hypercall_vendor_kvm(u64 fn, u64 r12, u64 r13, u64 r14,
>>                                  u64 r15, struct tdx_hypercall_output *out);
>>
>> struct tdx_hypercall_output {
>>           u64 r11;
>>           u64 r12;
>>           u64 r13;
>>           u64 r14;
>>           u64 r15;
>> };
> 
> Why is this by register name and not something like:
> 
> struct tdx_hypercall_payload {
>    u64 data[5];
> };
> 
> ...because the code in this patch is reading the payload out of a
> stack relative offset, not r11.

Since this patch allocates this memory in ASM code, we read it via
offset. If you see other use cases in tdx.c, you will notice the use
of register names.

static void tdg_handle_cpuid(struct pt_regs *regs)
{
         u64 ret;
         struct tdx_hypercall_output out = {0};

         ret = __tdx_hypercall(EXIT_REASON_CPUID, regs->ax,
                               regs->cx, 0, 0, &out);

         WARN_ON(ret);

         regs->ax = out.r12;
         regs->bx = out.r13;
         regs->cx = out.r14;
         regs->dx = out.r15;
}

static u64 tdg_read_msr_safe(unsigned int msr, int *err)
{
         u64 ret;
         struct tdx_hypercall_output out = {0};

         WARN_ON_ONCE(tdg_is_context_switched_msr(msr));

         /*
          * Since CSTAR MSR is not used by Intel CPUs as SYSCALL
          * instruction, just ignore it. Even raising TDVMCALL
          * will lead to same result.
          */
         if (msr == MSR_CSTAR)
                 return 0;

         ret = __tdx_hypercall(EXIT_REASON_MSR_READ, msr, 0, 0, 0, &out);

         *err = ret ? -EIO : 0;

         return out.r11;
}


> 
>>
>>
>> Functions like __tdx_hypercall() and __tdx_hypercall_vendor_kvm() are used
>> by TDX guest to request services (like RDMSR, WRMSR,GetQuote, etc) from VMM
>> using TDCALL instruction. do_tdx_hypercall() is the helper function (in
>> tdcall.S) which actually implements this ABI.
>>
>> As per current ABI, VMM will use registers R11-R15 to share the output
>> values with the guest.
> 
> Which ABI,

TDCALL ABI (see sections 3.1 to 3.12 and look for Output Operands in each TDVMCALL variant).

https://software.intel.com/content/dam/develop/external/us/en/documents/intel-tdx-guest-hypervisor-communication-interface.pdf

  __tdx_hypercall_vendor_kvm()? The code is putting the
> payload on the stack, so I'm not sure what ABI you are referring to?
> 
> 
>> So we have defined the structure
>> struct tdx_hypercall_output to group all output registers and make it easier
>> to share it with users of the TDCALLs. This is Linux defined structure.
>>
>> If there are any changes in TDCALL ABI for VMM, we might have to extend
>> this structure to accommodate new output register changes.  So if we
>> define TDVMCALL_OUTPUT_SIZE as 40, we will have modify this value for
>> any future struct tdx_hypercall_output changes. So to avoid it, we have
>> allocated double the size.
>>
>> May be I should define it as,
>>
>> #define TDVMCALL_OUTPUT_SIZE            sizeof(struct tdx_hypercall_output)
> 
> An arrangement like that seems more reasonable than a seemingly
> arbitrary number and an ominous warning about things that may happen
> in the future.

I will use the above format.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
