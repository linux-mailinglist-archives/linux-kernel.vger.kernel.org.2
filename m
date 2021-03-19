Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAE434238D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhCSRmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:42:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:44683 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230039AbhCSRmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:42:24 -0400
IronPort-SDR: YLzn8r9ZVepzy+zPzkNaHQNdmo3SXrieEcIrvm0LbEKMpJrk24xWO/Bjnp0S1cl1FgAt8QG9at
 MhSu85Y9LEkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="251289410"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="251289410"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 10:42:19 -0700
IronPort-SDR: sPHQPzxSrvOV3q6MWk8N1E/hcwYlWp2lC1NU7ufgKPxvGg5v6pk1A5hQImGYg/X5/vcTbOBjQL
 6dl4JdM/ASuw==
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="441400483"
Received: from hfritts-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.85.109])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 10:42:18 -0700
Subject: Re: [PATCH v1 1/1] x86/tdx: Add tdcall() and tdvmcall() helper
 functions
To:     Sean Christopherson <seanjc@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <0A886D87-1979-419C-86DE-EA2FABDFF3EB@amacapital.net>
 <20210318213053.203403-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YFTXdG+zZ32gVIPc@google.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <c72d9ca6-7a5c-b614-5d20-b86d2abebdee@linux.intel.com>
Date:   Fri, 19 Mar 2021 10:42:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YFTXdG+zZ32gVIPc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

Thanks for the review.

On 3/19/21 9:55 AM, Sean Christopherson wrote:
> On Thu, Mar 18, 2021, Kuppuswamy Sathyanarayanan wrote:
>> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
>> index e44e55d1e519..7ae1d25e272b 100644
>> --- a/arch/x86/kernel/tdx.c
>> +++ b/arch/x86/kernel/tdx.c
>> @@ -4,6 +4,58 @@
>>   #include <asm/tdx.h>
>>   #include <asm/cpufeature.h>
>>   
>> +void tdcall(u64 leafid, struct tdcall_regs *regs)
>> +{
>> +	asm volatile(
>> +			/* RAX = leafid (TDCALL LEAF ID) */
>> +			"  movq %0, %%rax;"
>> +			/* Move regs->r[*] data to regs r[a-c]x,  r8-r5 */
>> +			"  movq 8(%1), %%rcx;"
> 
> I am super duper opposed to using inline asm.  Large blocks are hard to read,
I think this point is arguable. Based on the review comments I received so far,
people prefer inline assembly compared to asm sub functions.
> and even harder to maintain.  E.g. the %1 usage falls apart if an output
> constraint is added; that can be avoided by defining a local const/imm (I forget
> what they're called), but it doesn't help readability.
we can use OFFSET() calls to improve the readability and avoid this issue. Also IMO,
any one adding constraints should know how this would affect the asm code.
> 
>> +			"  movq 16(%1), %%rdx;"
>> +			"  movq 24(%1), %%r8;"
>> +			"  movq 32(%1), %%r9;"
>> +			"  movq 40(%1), %%r10;"
>> +			"  movq 48(%1), %%r11;"
>> +			"  movq 56(%1), %%r12;"
>> +			"  movq 64(%1), %%r13;"
>> +			"  movq 72(%1), %%r14;"
>> +			"  movq 80(%1), %%r15;"
> 
> This is extremely unsafe, and wasteful.  Putting the onus on the caller to zero
> out unused registers, with no mechanism to enforce/encourage doing so,
For encouragement, we can add a comment to this function about callers responsibility.
  makes it
> likely that the kernel will leak information to the VMM, e.g. in the form of
> stack data due to a partially initialized "regs".
Unless you create sub-functions for each use cases, callers cannot avoid this
responsibility.
> 
> And although TDVMCALL is anything but speedy, requiring multiple memory
> operations just to set a single register is unnecessary.  Not to mention
> several of these registers are never used in the GHCI-defined TDVMCALLs. 
This function is common between TDCALL and TDVMCALL. Extra registers you
mentioned are related to other TDCALL usecases.
  And,
> since the caller defines the mask (which I also dislike), it's possible/likely
> that many of these memory operations are wasteful even for registers that are
> used by _some_ TDVMCALLs.  Unnecessary accesses are inevitable if we want a
> common helper, but this is too much.
using single function makes it easy to maintain, readable and less error prone.
But I agree there are many unnecessary accesses for many users.
> 
>> +			TDCALL ";"
>> +			/* Save TDCALL success/failure to regs->rax */
>> +			"  movq %%rax, (%1);"
>> +			/* Save rcx and rdx contents to regs->r[c-d]x */
>> +			"  movq %%rcx, 8(%1);"
>> +			"  movq %%rdx, 16(%1);"
>> +			/* Move content of registers R8-R15 regs->r[8-15] */
>> +			"  movq %%r8, 24(%1);"
>> +			"  movq %%r9, 32(%1);"
>> +			"  movq %%r10, 40(%1);"
>> +			"  movq %%r11, 48(%1);"
>> +			"  movq %%r12, 56(%1);"
>> +			"  movq %%r13, 64(%1);"
>> +			"  movq %%r14, 72(%1);"
>> +			"  movq %%r15, 80(%1);"
>> +
>> +		:
>> +		: "r" (leafid), "r" (regs)
>> +		: "memory", "rax", "rbx", "rcx", "rdx", "r8",
>> +		  "r9", "r10", "r11", "r12", "r13", "r14", "r15"
> 
> All these clobbers mean even more memory operations...
> 
>> +		);
>> +
>> +}
>> +
>> +void tdvmcall(u64 subid, struct tdcall_regs *regs)
>> +{
>> +	/* Expose GPRs R8-R15 to VMM */
>> +	regs->rcx = 0xff00;
>> +	/* R10 = 0 (standard TDVMCALL) */
>> +	regs->r10 = TDVMCALL_STANDARD;
>> +	/* Save subid to r11 register */
>> +	regs->r11 = subid;
>> +
>> +	tdcall(TDVMCALL, regs);
> 
> This implies the caller is responsible for _all_ error checking.  The base
> TDCALL should never fail; if it does, something is horribly wrong with TDX-Module
> and panicking is absolutely the best option.
I haven't added error checking to common function because some use cases like
MSR and IO access does not need to panic with TDVMCALL failures.

To improve this, may be we can create sub-functions (similar to your code) like,
1. tdvmcall() //with BUG_ON(regs.rax)
2. _tdvmcall() // without error checks
> 
> The users of this are going to be difficult to read as well since the parameters
> are stuff into a struct instead of being passed to a function.
I think regs.rx = xx code format is more easier to read compared to passing
parameters to the function.
> 
> IMO, throwing the bulk of the code in a proper asm subroutine and handling only
> the GHCI-defined TDVMCALLs is the way to go.  If/when a VMM comes along that
> wants to enlighten Linux guests to work with non-GCHI TDVMCALLs, enhancing this
> madness can be their problem.
> 
> Completely untested...
> 
> struct tdvmcall_output {
> 	u64 r12;
> 	u64 r13;
> 	u64 r14;
> 	u64 r15;
> }
> 
> u64 __tdvmcall(u64 fn, u64 p0, u64 p1, u64 p2, u64 p3,
> 	       struct tdvmcall_output *out);
This function is only for tdvmcall. If you want to create
common function for all tdcall use cases, you would end
up using struct for input as well.
> 
> 	/* Offset for fields in tdvmcall_output */
> 	OFFSET(TDVMCALL_r12, tdvmcall_output, r13);
> 	OFFSET(TDVMCALL_r13, tdvmcall_output, r13);
> 	OFFSET(TDVMCALL_r14, tdvmcall_output, r14);
> 	OFFSET(TDVMCALL_r15, tdvmcall_output, r15);
> 
> SYM_FUNC_START(__tdvmcall)
> 	FRAME_BEGIN
> 
> 	/* Save/restore non-volatile GPRs that are exposed to the VMM. */
>          push %r15
>          push %r14
>          push %r13
>          push %r12
> 
> 	/*
> 	 * 0    => RAX = TDCALL leaf
> 	 * 0    => R10 = standard vs. vendor
> 	 * RDI  => R11 = TDVMCALL function, e.g. exit reason
> 	 * RSI  => R12 = input param 0
> 	 * RDX  => R13 = input param 1
> 	 * RCX  => R14 = input param 2
> 	 * R8   => R15 = input param 3
> 	 * MASK => RCX = TDVMCALL register behavior
> 	 * R9   => N/A = output struct
> 	 */
> 	xor %eax, %eax
>          xor %r10d, %r10d
> 	mov %rdi, %r11
> 	mov %rsi, %r12
> 	mov %rdx, %r13
> 	mov %rcx, %r14
> 	mov %r8,  %r15
> 
>          /*
> 	 * Expose R10 - R15, i.e. all GPRs that may be used by TDVMCALLs
> 	 * defined in the GHCI.  Note, RAX and RCX are consumed, but only by
> 	 * TDX-Module and so don't need to be listed in the mask.
> 	 */
>          movl $0xfc00, %ecx
> 
> 	tdcall
> 
> 	/* Panic if TDCALL reports failure. */
> 	test %rax, %rax
> 	jnz 2f
> 
> 	/* Propagate TDVMCALL success/failure to return value. */
> 	mov %r10, %rax
> 
> 	/*
> 	 * On success, propagate TDVMCALL outputs values to the output struct,
> 	 * if an output struct is provided.
> 	 */
> 	test %rax, %rax
> 	jnz 1f
> 	test %r9, %r9
> 	jz 1f
> 
> 	movq %r12, $TDVMCALL_r12(%r9)
> 	movq %r13, $TDVMCALL_r13(%r9)
> 	movq %r14, $TDVMCALL_r14(%r9)
> 	movq %r15, $TDVMCALL_r15(%r9)
> 1:
> 	/*
> 	 * Zero out registers exposed to the VMM to avoid speculative execution
> 	 * with VMM-controlled values.
> 	 */
>          xor %r10d, %r10d
>          xor %r11d, %r11d
>          xor %r12d, %r12d
>          xor %r13d, %r13d
>          xor %r14d, %r14d
>          xor %r15d, %r15d
> 
> 	pop %r12
>          pop %r13
>          pop %r14
>          pop %r15
> 
> 	FRAME_END
> 	ret
> 2:
> 	ud2
> SYM_FUNC_END(__tdvmcall)
> 
> /*
>   * Wrapper for the semi-common case where errors are fatal and there is a
>   * single output value.
>   */
> static inline u64 tdvmcall(u64 fn, u64 p0, u64 p1, u64 p2, u64 p3,
> 			   struct tdvmcall_output *out)
> {
> 	struct tdvmcall_output out;
> 	u64 err;
> 
> 	err = __tdvmcall(fn, p0, p1, p2, p3, &out);
> 	BUG_ON(err);
> 
> 	return out.r11;
> }
> 
> static void tdx_handle_cpuid(struct pt_regs *regs)
> {
> 	struct tdvmcall_output out;
> 	u64 err;
> 
> 	err = __tdvmcall(EXIT_REASON_CPUID, regs->ax, regs->cx, 0, 0, &out);
> 	BUG_ON(err);
> 
>          regs->ax = out.r11;
>          regs->bx = out.r12;
>          regs->cx = out.r13;
>          regs->dx = out.r14;
> }
> 
> #define REG_MASK(size) ((1ULL << ((size) * 8)) - 1)
> 
> static void tdx_handle_io(struct pt_regs *regs, u32 exit_qual)
> {
>          u8 out = (exit_qual & 8) ? 0 : 1;
>          u8 size = (exit_qual & 7) + 1;
>          u16 port = exit_qual >> 16;
>          u64 val;
> 
>          /* I/O strings ops are unrolled at build time. */
>          BUG_ON(exit_qual & 0x10);
> 
> 	if (!tdx_allowed_port(port))
> 		return;
> 
>          if (out)
>                  val = regs->ax & REG_MASK(size);
>          else
>                  val = 0;
> 
>          val = tdvmcall(EXIT_REASON_IO_INSTRUCTION, port, size, out, val);
>          if (!out) {
>                  /* The upper bits of *AX are preserved for 2 and 1 byte I/O. */
>                  if (size < 4)
>                          val |= (regs->ax & ~REG_MASK(size));
>                  regs->ax = val;
>          }4
> }
> 
> static u64 tdx_read_msr_safe(unsigned int msr, int *ret)
> {
> 	struct tdvmcall_output out;
> 	u64 err;
> 
> 	WARN_ON_ONCE(tdx_is_context_switched_msr(msr));
> 
> 	if (msr == MSR_CSTAR) {
> 		*ret = 0;
> 		return 0;
> 	}
> 
> 	err = __tdvmcall(EXIT_REASON_MSR_READ, regs->ax, regs->cx, 0, 0, &out);
> 	if (err) {
> 		*ret -EIO;
> 		return 0;
> 	}
> 	return out.r11;
> }
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
