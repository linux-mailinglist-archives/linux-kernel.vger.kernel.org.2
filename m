Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC15342292
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 17:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCSQzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 12:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhCSQzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 12:55:21 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABA4C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:55:21 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id l1so3236796plg.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3YoU8GSuickXCwcYWeTrJjJD36Ad2aKBZfO1AaLP3Ng=;
        b=iyuFK5DesZBYJJCilK6o0BGzNWVwLFo5/392zUn9S59QW+hDQbus2sNNGbah45tTka
         YRynZBBaIDhXk70JvrcjJxOiSLdgp+mEK1Ahpl8mcbZXWQ+2wYrYqdUSEleTID58UC7I
         ycFU8w0LEsTqlw6zl7TB4/1qCR6QoKODqO2MvB9GGPIQi14APWqI/rDKXNTo/UIpUm1+
         zugxcg41qxDO5pqnsrxuP0MxebSyHl6ta3UClwxzczeqcf2RClHp7ELIY9y7NZoV2Srn
         3odehSQy/A/JjMto6F++M37xGMY4VUu7zTE7uWsc6ABcdeyMqFr7PPHvljGrGHbzbEBc
         TB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3YoU8GSuickXCwcYWeTrJjJD36Ad2aKBZfO1AaLP3Ng=;
        b=Oqkj2XGri7gqG5+iB3KmmSCHnaf24Wx3srGBLajQseQNt4FhpHanhoP7EcwIjTsBJh
         /m00Pazbc96UAKAmjrepgwX1cFC1zoQX47lTbbxprDxZvZOJsxAXUVt/sc6SAMYu+NB+
         GDgrBQbTedatYnZfu4qrklphyjArW8OWBdqg9FwiwJYCa/D4On6bkGiQux4wlkP/JgsK
         viCA6EZg+59YKp1wERaidPrzNlCsB27SHDJu32cXqTb/wnukT4TwEiIXceDp7mPd9sCW
         2IFe16TVlJcm+K0wh/MuX+jq2RMETmMv2VrCuhuTEtmoOsnT5gZ6n0UR09LcRBy7NrPR
         9XXA==
X-Gm-Message-State: AOAM533NvIaPJ0Y8HakMqNAuOgWtUQ2OSzPHBMV7bsdyp3gJYO0yFOee
        UiHqfpSmB7fhzTm4InLmPp+8fw==
X-Google-Smtp-Source: ABdhPJxpciT3IWjh3LfA7frT3MBDPaci1J+HScDncb/3hOmi8LnyhQjUlHkxPnWOtuJ1Nj3SSF+3ng==
X-Received: by 2002:a17:90a:f28e:: with SMTP id fs14mr10488675pjb.100.1616172920983;
        Fri, 19 Mar 2021 09:55:20 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id iq6sm5779904pjb.31.2021.03.19.09.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 09:55:20 -0700 (PDT)
Date:   Fri, 19 Mar 2021 16:55:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] x86/tdx: Add tdcall() and tdvmcall() helper
 functions
Message-ID: <YFTXdG+zZ32gVIPc@google.com>
References: <0A886D87-1979-419C-86DE-EA2FABDFF3EB@amacapital.net>
 <20210318213053.203403-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318213053.203403-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021, Kuppuswamy Sathyanarayanan wrote:
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index e44e55d1e519..7ae1d25e272b 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -4,6 +4,58 @@
>  #include <asm/tdx.h>
>  #include <asm/cpufeature.h>
>  
> +void tdcall(u64 leafid, struct tdcall_regs *regs)
> +{
> +	asm volatile(
> +			/* RAX = leafid (TDCALL LEAF ID) */
> +			"  movq %0, %%rax;"
> +			/* Move regs->r[*] data to regs r[a-c]x,  r8-r5 */
> +			"  movq 8(%1), %%rcx;"

I am super duper opposed to using inline asm.  Large blocks are hard to read,
and even harder to maintain.  E.g. the %1 usage falls apart if an output
constraint is added; that can be avoided by defining a local const/imm (I forget
what they're called), but it doesn't help readability.

> +			"  movq 16(%1), %%rdx;"
> +			"  movq 24(%1), %%r8;"
> +			"  movq 32(%1), %%r9;"
> +			"  movq 40(%1), %%r10;"
> +			"  movq 48(%1), %%r11;"
> +			"  movq 56(%1), %%r12;"
> +			"  movq 64(%1), %%r13;"
> +			"  movq 72(%1), %%r14;"
> +			"  movq 80(%1), %%r15;"

This is extremely unsafe, and wasteful.  Putting the onus on the caller to zero
out unused registers, with no mechanism to enforce/encourage doing so, makes it
likely that the kernel will leak information to the VMM, e.g. in the form of
stack data due to a partially initialized "regs".

And although TDVMCALL is anything but speedy, requiring multiple memory
operations just to set a single register is unnecessary.  Not to mention
several of these registers are never used in the GHCI-defined TDVMCALLs.  And,
since the caller defines the mask (which I also dislike), it's possible/likely
that many of these memory operations are wasteful even for registers that are
used by _some_ TDVMCALLs.  Unnecessary accesses are inevitable if we want a
common helper, but this is too much.

> +			TDCALL ";"
> +			/* Save TDCALL success/failure to regs->rax */
> +			"  movq %%rax, (%1);"
> +			/* Save rcx and rdx contents to regs->r[c-d]x */
> +			"  movq %%rcx, 8(%1);"
> +			"  movq %%rdx, 16(%1);"
> +			/* Move content of registers R8-R15 regs->r[8-15] */
> +			"  movq %%r8, 24(%1);"
> +			"  movq %%r9, 32(%1);"
> +			"  movq %%r10, 40(%1);"
> +			"  movq %%r11, 48(%1);"
> +			"  movq %%r12, 56(%1);"
> +			"  movq %%r13, 64(%1);"
> +			"  movq %%r14, 72(%1);"
> +			"  movq %%r15, 80(%1);"
> +
> +		:
> +		: "r" (leafid), "r" (regs)
> +		: "memory", "rax", "rbx", "rcx", "rdx", "r8",
> +		  "r9", "r10", "r11", "r12", "r13", "r14", "r15"

All these clobbers mean even more memory operations...

> +		);
> +
> +}
> +
> +void tdvmcall(u64 subid, struct tdcall_regs *regs)
> +{
> +	/* Expose GPRs R8-R15 to VMM */
> +	regs->rcx = 0xff00;
> +	/* R10 = 0 (standard TDVMCALL) */
> +	regs->r10 = TDVMCALL_STANDARD;
> +	/* Save subid to r11 register */
> +	regs->r11 = subid;
> +
> +	tdcall(TDVMCALL, regs);

This implies the caller is responsible for _all_ error checking.  The base
TDCALL should never fail; if it does, something is horribly wrong with TDX-Module
and panicking is absolutely the best option.

The users of this are going to be difficult to read as well since the parameters
are stuff into a struct instead of being passed to a function.

IMO, throwing the bulk of the code in a proper asm subroutine and handling only
the GHCI-defined TDVMCALLs is the way to go.  If/when a VMM comes along that
wants to enlighten Linux guests to work with non-GCHI TDVMCALLs, enhancing this
madness can be their problem.

Completely untested...

struct tdvmcall_output {
	u64 r12;
	u64 r13;
	u64 r14;
	u64 r15;
}

u64 __tdvmcall(u64 fn, u64 p0, u64 p1, u64 p2, u64 p3,
	       struct tdvmcall_output *out);

	/* Offset for fields in tdvmcall_output */
	OFFSET(TDVMCALL_r12, tdvmcall_output, r13);
	OFFSET(TDVMCALL_r13, tdvmcall_output, r13);
	OFFSET(TDVMCALL_r14, tdvmcall_output, r14);
	OFFSET(TDVMCALL_r15, tdvmcall_output, r15);

SYM_FUNC_START(__tdvmcall)
	FRAME_BEGIN

	/* Save/restore non-volatile GPRs that are exposed to the VMM. */
        push %r15
        push %r14
        push %r13
        push %r12

	/*
	 * 0    => RAX = TDCALL leaf
	 * 0    => R10 = standard vs. vendor
	 * RDI  => R11 = TDVMCALL function, e.g. exit reason
	 * RSI  => R12 = input param 0
	 * RDX  => R13 = input param 1
	 * RCX  => R14 = input param 2
	 * R8   => R15 = input param 3
	 * MASK => RCX = TDVMCALL register behavior
	 * R9   => N/A = output struct
	 */
	xor %eax, %eax
        xor %r10d, %r10d
	mov %rdi, %r11
	mov %rsi, %r12
	mov %rdx, %r13
	mov %rcx, %r14
	mov %r8,  %r15

        /*
	 * Expose R10 - R15, i.e. all GPRs that may be used by TDVMCALLs
	 * defined in the GHCI.  Note, RAX and RCX are consumed, but only by
	 * TDX-Module and so don't need to be listed in the mask.
	 */
        movl $0xfc00, %ecx

	tdcall

	/* Panic if TDCALL reports failure. */
	test %rax, %rax
	jnz 2f

	/* Propagate TDVMCALL success/failure to return value. */
	mov %r10, %rax

	/*
	 * On success, propagate TDVMCALL outputs values to the output struct,
	 * if an output struct is provided.
	 */
	test %rax, %rax
	jnz 1f
	test %r9, %r9
	jz 1f

	movq %r12, $TDVMCALL_r12(%r9)
	movq %r13, $TDVMCALL_r13(%r9)
	movq %r14, $TDVMCALL_r14(%r9)
	movq %r15, $TDVMCALL_r15(%r9)
1:
	/*
	 * Zero out registers exposed to the VMM to avoid speculative execution
	 * with VMM-controlled values.
	 */
        xor %r10d, %r10d
        xor %r11d, %r11d
        xor %r12d, %r12d
        xor %r13d, %r13d
        xor %r14d, %r14d
        xor %r15d, %r15d

	pop %r12
        pop %r13
        pop %r14
        pop %r15

	FRAME_END
	ret
2:
	ud2
SYM_FUNC_END(__tdvmcall)

/*
 * Wrapper for the semi-common case where errors are fatal and there is a
 * single output value.
 */
static inline u64 tdvmcall(u64 fn, u64 p0, u64 p1, u64 p2, u64 p3,
			   struct tdvmcall_output *out)
{
	struct tdvmcall_output out;
	u64 err;

	err = __tdvmcall(fn, p0, p1, p2, p3, &out);
	BUG_ON(err);

	return out.r11;
}

static void tdx_handle_cpuid(struct pt_regs *regs)
{
	struct tdvmcall_output out;
	u64 err;

	err = __tdvmcall(EXIT_REASON_CPUID, regs->ax, regs->cx, 0, 0, &out);
	BUG_ON(err);

        regs->ax = out.r11;
        regs->bx = out.r12;
        regs->cx = out.r13;
        regs->dx = out.r14;
}

#define REG_MASK(size) ((1ULL << ((size) * 8)) - 1)

static void tdx_handle_io(struct pt_regs *regs, u32 exit_qual)
{
        u8 out = (exit_qual & 8) ? 0 : 1;
        u8 size = (exit_qual & 7) + 1;
        u16 port = exit_qual >> 16;
        u64 val;

        /* I/O strings ops are unrolled at build time. */
        BUG_ON(exit_qual & 0x10);

	if (!tdx_allowed_port(port))
		return;

        if (out)
                val = regs->ax & REG_MASK(size);
        else
                val = 0;

        val = tdvmcall(EXIT_REASON_IO_INSTRUCTION, port, size, out, val);
        if (!out) {
                /* The upper bits of *AX are preserved for 2 and 1 byte I/O. */
                if (size < 4)
                        val |= (regs->ax & ~REG_MASK(size));
                regs->ax = val;
        }4
}

static u64 tdx_read_msr_safe(unsigned int msr, int *ret)
{
	struct tdvmcall_output out;
	u64 err;

	WARN_ON_ONCE(tdx_is_context_switched_msr(msr));

	if (msr == MSR_CSTAR) {
		*ret = 0;
		return 0;
	}

	err = __tdvmcall(EXIT_REASON_MSR_READ, regs->ax, regs->cx, 0, 0, &out);
	if (err) {
		*ret -EIO;
		return 0;
	}
	return out.r11;
}

