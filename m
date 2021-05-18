Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997A0387BDC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 17:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343792AbhERPCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 11:02:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:34813 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234596AbhERPCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 11:02:21 -0400
IronPort-SDR: 90RHBSceeNXW+QMbswM0vnVVxaHxQv6imPmHeKpyG2Gt4w1pX2hshtW3YowdPi99aZkAa+N+eH
 9GLsfs2kVB5A==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="286264504"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="286264504"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 08:00:46 -0700
IronPort-SDR: +oH2yivhKZGC1Br9ZmdVdpngNo5Qeui2LRL1ckqY+04qmULqTlHtwhupsfy5/olasx+b+4GtY+
 kl9ESiB9elpQ==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="393983149"
Received: from szzhu-mobl2.amr.corp.intel.com (HELO [10.212.180.32]) ([10.212.180.32])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 08:00:46 -0700
Subject: Re: [RFC v2-fix 1/1] x86/tdx: Handle in-kernel MMIO
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <3e9a26c3-8eee-88f5-f8e2-8a2dd2c028ea@intel.com>
 <20210518004807.258503-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <36cd2665-6d8b-9c0b-eec1-25152dcca2a3@intel.com>
Date:   Tue, 18 May 2021 08:00:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210518004807.258503-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/21 5:48 PM, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> In traditional VMs, MMIO tends to be implemented by giving a
> guest access to a mapping which will cause a VMEXIT on access.
> That's not possible in TDX guest.

Why is it not possible?

> So use #VE to implement MMIO support. In TDX guest, MMIO triggers #VE
> with EPT_VIOLATION exit reason.

What does the #VE handler do to resolve the exception?

> For now we only handle a subset of instructions that the kernel
> uses for MMIO operations. User-space access triggers SIGBUS.

How do you know which instructions the kernel uses?  How do you know
that the compiler won't change them?

I guess the kernel won't boot far if this happens, but this still sounds
like trial-and-error programming.

> Also, reasons for supporting #VE based MMIO in TDX guest are,
> 
> * MMIO is widely used and we'll have more drivers in the future.

OK, but you've also made a big deal about having to go explicitly audit
these drivers.  I would imagine converting these over to stop using MMIO
would be _relatively_ minor compared to a big security audit and new
fuzzing infrastructure.

> * We don't want to annotate every TDX specific MMIO readl/writel etc.

				    ^ TDX-specific

> * If we didn't annotate we would need to add an alternative to every
>   MMIO access in the kernel (even though 99.9% will never be used on
>   TDX) which would be a complete waste and incredible binary bloat
>   for nothing.

That sounds like something objective we can measure.  Does this cost 1
byte of extra text per readl/writel?  10?  100?

You're also being rather indirect about what solutions you ruled out.
Why not just say: we considered doing ____, but ruled that out because
it would have required ____.  Above you just tell us what the solution
required without mentioning the solution.

> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index b9e3010987e0..9330c7a9ad69 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -5,6 +5,8 @@
>  
>  #include <asm/tdx.h>
>  #include <asm/vmx.h>
> +#include <asm/insn.h>
> +#include <linux/sched/signal.h> /* force_sig_fault() */
>  
>  #include <linux/cpu.h>
>  #include <linux/protected_guest.h>
> @@ -209,6 +211,101 @@ static void tdg_handle_io(struct pt_regs *regs, u32 exit_qual)
>  	}
>  }
>  
> +static unsigned long tdg_mmio(int size, bool write, unsigned long addr,
> +		unsigned long val)
> +{
> +	return tdx_hypercall_out_r11(EXIT_REASON_EPT_VIOLATION, size,
> +				     write, addr, val);
> +}
> +
> +static inline void *get_reg_ptr(struct pt_regs *regs, struct insn *insn)
> +{
> +	static const int regoff[] = {
> +		offsetof(struct pt_regs, ax),
> +		offsetof(struct pt_regs, cx),
> +		offsetof(struct pt_regs, dx),
> +		offsetof(struct pt_regs, bx),
> +		offsetof(struct pt_regs, sp),
> +		offsetof(struct pt_regs, bp),
> +		offsetof(struct pt_regs, si),
> +		offsetof(struct pt_regs, di),
> +		offsetof(struct pt_regs, r8),
> +		offsetof(struct pt_regs, r9),
> +		offsetof(struct pt_regs, r10),
> +		offsetof(struct pt_regs, r11),
> +		offsetof(struct pt_regs, r12),
> +		offsetof(struct pt_regs, r13),
> +		offsetof(struct pt_regs, r14),
> +		offsetof(struct pt_regs, r15),
> +	};
> +	int regno;
> +
> +	regno = X86_MODRM_REG(insn->modrm.value);
> +	if (X86_REX_R(insn->rex_prefix.value))
> +		regno += 8;
> +
> +	return (void *)regs + regoff[regno];
> +}

Was there a reason you copied and pasted this from get_reg_offset()
instead of refactoring?  This looks like almost entirely a subset of
get_reg_offset().

> +static int tdg_handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> +{
> +	int size;
> +	bool write;
> +	unsigned long *reg;
> +	struct insn insn;
> +	unsigned long val = 0;
> +
> +	/*
> +	 * User mode would mean the kernel exposed a device directly
> +	 * to ring3, which shouldn't happen except for things like
> +	 * DPDK.
> +	 */

Uhh....

	https://www.kernel.org/doc/html/v4.14/driver-api/uio-howto.html

I thought there were more than a few ways that userspace could get
access to MMIO mappings.

Also, do most people know what DPDK is?  Should we even be talking about
silly out-of-tree kernel bypass schemes in kernel comments?

> +	if (user_mode(regs)) {
> +		pr_err("Unexpected user-mode MMIO access.\n");
> +		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *) ve->gla);

						       extra space ^

Is a non-ratelimited pr_err() appropriate here?  I guess there shouldn't
be any MMIO passthrough to userspace on these systems.

> +		return 0;
> +	}
> +
> +	kernel_insn_init(&insn, (void *) regs->ip, MAX_INSN_SIZE);
> +	insn_get_length(&insn);
> +	insn_get_opcode(&insn);
> +
> +	write = ve->exit_qual & 0x2;
> +
> +	size = insn.opnd_bytes;
> +	switch (insn.opcode.bytes[0]) {
> +	/* MOV r/m8	r8	*/
> +	case 0x88:
> +	/* MOV r8	r/m8	*/
> +	case 0x8A:
> +	/* MOV r/m8	imm8	*/
> +	case 0xC6:

FWIW, I find that *REALLY* hard to read.

Check out is_string_insn() for a more readable example.

Oh, and I misread that.  I read it as "these are all the opcodes we care
about".  When, in fact, I _think_ it's all the opcodes that don't have a
size in insn.opnd_bytes.

Could you spell that out, please?

> +		size = 1;
> +		break;
> +	}
> +
> +	if (inat_has_immediate(insn.attr)) {
> +		BUG_ON(!write);
> +		val = insn.immediate.value;

This is pretty interesting.  This won't work with implicit accesses.  I
guess the limited opcodes above limit how much imprecision will result.
 But, it would still be nice to hear something about that.

For instance, if someone pointed a mid-level page table to MMIO, we'd
get a va->gpa that had zero to do with the instruction.  Granted, that's
only going to happen if something bonkers is going on, but maybe I'm
missing some simpler cases of implicit accesses.

> +		tdg_mmio(size, write, ve->gpa, val);

What happens if this is an MMIO operation that *partially* touches MMIO
and partially touches normal memory?  Let's say I wrote two bytes
(0x1234), starting at the last byte of a RAM page that ran over into an
MMIO page.  The fault would occur trying to write 0x34 to the MMIO, but
the instruction cracking would result in trying to write 0x1234 into the
MMIO.

It doesn't seem *that* outlandish that an MMIO might cross a page
boundary.  Would this work for a two-byte MMIO that crosses a page?

> +		return insn.length;
> +	}
> +
> +	BUG_ON(!inat_has_modrm(insn.attr));

A comment would be nice here about the BUG_ON().

It would also be nice to give a high-level view of what's going on and
what we know about the instruction at this point.

> +	reg = get_reg_ptr(regs, &insn);
> +
> +	if (write) {
> +		memcpy(&val, reg, size);
> +		tdg_mmio(size, write, ve->gpa, val);
> +	} else {
> +		val = tdg_mmio(size, write, ve->gpa, val);
> +		memset(reg, 0, size);
> +		memcpy(reg, &val, size);
> +	}
> +	return insn.length;
> +}
> +
>  unsigned long tdg_get_ve_info(struct ve_info *ve)
>  {
>  	u64 ret;
> @@ -258,6 +355,9 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
>  	case EXIT_REASON_IO_INSTRUCTION:
>  		tdg_handle_io(regs, ve->exit_qual);
>  		break;
> +	case EXIT_REASON_EPT_VIOLATION:
> +		ve->instr_len = tdg_handle_mmio(regs, ve);
> +		break;
>  	default:
>  		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
>  		return -EFAULT;
> 

