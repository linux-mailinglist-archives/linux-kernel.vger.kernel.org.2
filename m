Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F40A424375
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239420AbhJFQ5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 12:57:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:33944 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231484AbhJFQ5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:57:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="226356774"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="226356774"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 09:52:08 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="589828248"
Received: from ptcotton-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.211.164])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 09:52:07 -0700
Subject: Re: [PATCH v8 05/11] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211006055359.svcqk36btq7zg3td@treble>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <2c434ea2-2956-11b2-d407-44c1a3fffb69@linux.intel.com>
Date:   Wed, 6 Oct 2021 09:52:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211006055359.svcqk36btq7zg3td@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/21 10:53 PM, Josh Poimboeuf wrote:
> On Mon, Oct 04, 2021 at 07:51:59PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> Guests communicate with VMMs with hypercalls. Historically, these
>> are implemented using instructions that are known to cause VMEXITs
>> like VMCALL, VMLAUNCH, etc. However, with TDX, VMEXITs no longer
>> expose guest state to the host.  This prevents the old hypercall
>> mechanisms from working. So to communicate with VMM, TDX
>> specification defines a new instruction called TDCALL.
>>
>> In a TDX based VM, since VMM is an untrusted entity, a intermediary
>> layer (TDX module) exists between host and guest to facilitate
>> secure communication. TDX guests communicate with the TDX module
>> using TDCALL instruction.
> 
> Most of the information in the second paragraph was already provided in
> the first paragraph.

Second paragraph talks about TDX module where as first one talks about VMM.

> 
>> +#ifdef CONFIG_FRAME_POINTER
>> +/* Frame offset + 8 (for arg1) */
>> +#define ARG7_SP_OFFSET		(FRAME_OFFSET + 0x08)
>> +#else
>> +#define ARG7_SP_OFFSET		(0x08)
>> +#endif
> 
> No need for the #ifdef here, FRAME_OFFSET is already zero for
> !FRAME_POINTER.  So it can just be unconditional:
> 
> #define ARG7_SP_OFFSET		(FRAME_OFFSET + 0x08)

Right. I will remove the #ifdef in next version.

> 
>> + * __tdx_hypercall()  - Helper function used by TDX guests to request
>> + * services from the VMM. All requests are made via the TDX module
>> + * using TDCALL instruction.
>> + *
>> + * This function serves as a wrapper to move user call arguments to the
>> + * correct registers as specified by TDCALL ABI and share it with VMM
>> + * via the TDX module. After TDCALL operation, output from the VMM is
>> + * saved to the memory specified in the "out" (struct tdx_hypercall_output)
>> + * pointer.
>> + *
>> + *-------------------------------------------------------------------------
>> + * TD VMCALL ABI:
>> + *-------------------------------------------------------------------------
>> + *
>> + * Input Registers:
>> + *
>> + * RAX                 - TDCALL instruction leaf number (0 - TDG.VP.VMCALL)
>> + * RCX                 - BITMAP which controls which part of TD Guest GPR
>> + *                       is passed as-is to VMM and back.
>> + * R10                 - Set 0 to indicate TDCALL follows standard TDX ABI
>> + *                       specification. Non zero value indicates vendor
>> + *                       specific ABI.
>> + * R11                 - VMCALL sub function number
>> + * RBX, RBP, RDI, RSI  - Used to pass VMCALL sub function specific arguments.
>> + * R8-R9, R12–R15      - Same as above.
>> + *
>> + * Output Registers:
>> + *
>> + * RAX                 - TDCALL instruction status (Not related to hypercall
>> + *                        output).
>> + * R10                 - Hypercall output error code.
>> + * R11-R15             - Hypercall sub function specific output values.
>> + *
>> + *-------------------------------------------------------------------------
>> + *
>> + * __tdx_hypercall() function ABI:
>> + *
>> + * @type  (RDI)        - TD VMCALL type, moved to R10
>> + * @fn    (RSI)        - TD VMCALL sub function, moved to R11
>> + * @r12   (RDX)        - Input parameter 1, moved to R12
>> + * @r13   (RCX)        - Input parameter 2, moved to R13
>> + * @r14   (R8)         - Input parameter 3, moved to R14
>> + * @r15   (R9)         - Input parameter 4, moved to R15
>> + *
>> + * @out   (stack)      - struct tdx_hypercall_output pointer (cannot be NULL)
>> + *
>> + * On successful completion, return TDCALL status or -EINVAL for invalid
>> + * inputs.
>> + */
> 
> The documentation and comments for all the asm code are excellent!  If
> only all kernel asm code were this readable!
> 
> I'm especially thankful that it's not all crammed into inline asm :-)

Thanks. But major credit should go to Dave Hansen (detailed comments are
due to his recommendation in his review).

> 
>> +SYM_FUNC_START(__tdx_hypercall)
>> +	FRAME_BEGIN
>> +
>> +	/* Move argument 7 from caller stack to RAX */
>> +	movq ARG7_SP_OFFSET(%rsp), %rax
>> +
>> +	/* Check if caller provided an output struct */
>> +	test %rax, %rax
>> +	/* If out pointer is NULL, return -EINVAL */
>> +	jz 1f
>> +
>> +	/* Save callee-saved GPRs as mandated by the x86_64 ABI */
>> +	push %r15
>> +	push %r14
>> +	push %r13
>> +	push %r12
>> +
>> +	/*
>> +	 * Save R9 and output pointer (rax) in stack, it will be used
>> +	 * again when storing the output registers after TDCALL
>> +	 * operation.
>> +	 */
>> +	push %r9
>> +	push %rax
> 
> r9 is callee-clobbered, so we shouldn't need to push it here or pop it
> ("Restore state of R9 register" below) before returning.

Make sense. I will remove push/pop for r9 register.

> 
>> +/*
>> + * Wrapper for standard use of __tdx_hypercall with BUG_ON() check
>> + * for TDCALL error.
>> + */
>> +static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14,
>> +				 u64 r15, struct tdx_hypercall_output *out)
> 
> Instead of calling the args r12-r15, I'm thinking it would be clearer to
> call them arg1-arg4.  It's not the C code's job to worry about the
> argument-to-register ABI mappings.
> 
> Same comment for the function declaration in the header file.

Using register names as argument makes it easier when implementing
the hypercall based on TDX ABI spec (specifies which registers are to be
used).

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
