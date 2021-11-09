Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1795444B23B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 18:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241449AbhKIR6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 12:58:16 -0500
Received: from foss.arm.com ([217.140.110.172]:36858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239360AbhKIR6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 12:58:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD0B4ED1;
        Tue,  9 Nov 2021 09:55:28 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.58.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0F003F7F5;
        Tue,  9 Nov 2021 09:55:26 -0800 (PST)
Date:   Tue, 9 Nov 2021 17:55:17 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v6 2/2] arm64: implement support for static call
 trampolines
Message-ID: <YYq1/a10XGBthteg@FVFF77S0Q05N>
References: <20211105145917.2828911-1-ardb@kernel.org>
 <20211105145917.2828911-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105145917.2828911-3-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Fri, Nov 05, 2021 at 03:59:17PM +0100, Ard Biesheuvel wrote:
> +static void *strip_cfi_jt(void *addr)
> +{
> +	if (IS_ENABLED(CONFIG_CFI_CLANG)) {
> +		void *p = addr;
> +		u32 insn;
> +
> +		/*
> +		 * Taking the address of a function produces the address of the
> +		 * jump table entry when Clang CFI is enabled. Such entries are
> +		 * ordinary jump instructions, preceded by a BTI C instruction
> +		 * if BTI is enabled for the kernel.
> +		 */
> +		if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL))
> +			p += 4;
> +
> +		insn = le32_to_cpup(p);
> +		if (aarch64_insn_is_b(insn))
> +			return p + aarch64_get_branch_offset(insn);
> +
> +		WARN_ON(1);
> +	}
> +	return addr;
> +}

I'm somewhat uncomfortable with this, because it seems like the compiler could
easily violate our expectations in future, and then we're in for a massive
headache. I assume clang doesn't provide any guarnatee as to the format of the
jump table entries (and e.g. I can see scope for branch padding breaking this).

In trying to sidestep that I ended up with:

  https://lore.kernel.org/linux-arm-kernel/20211109172408.49641-1-mark.rutland@arm.com/

... which I think is a good option for PREEMPT_DYNAMIC, but I don't know if
there were other places where we believe static calls would be critical for
performance rather than a nice-to-have, and whether we truly need static calls
on arm64. My mind is leaning towards "avoid if reasonable" at the moment (or at
least make that mutually exclusive with CFI so we can avoid that specific fun).

I see you had at least one other user in:

  https://lore.kernel.org/r/20211109120336.3561463-1-ardb@kernel.org

... what were your thoughts on the criticality of that?

FWIW other than the above this looks good to me. My major concern here is
fragility/maintenance, and secondly whether we're gaining much in practice. So
if you think we really need this, I'm not going to stand in the way.

Thanks
Mark.

> +void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
> +{
> +	/*
> +	 * -0x8	<literal>
> +	 *  0x0	bti c		<--- trampoline entry point
> +	 *  0x4	<branch or nop>
> +	 *  0x8	ldr x16, <literal>
> +	 *  0xc	cbz x16, 20
> +	 * 0x10	br x16
> +	 * 0x14	ret
> +	 */
> +	struct {
> +		u64	literal;
> +		__le32	insn[2];
> +	} insns;
> +	u32 insn;
> +	int ret;
> +
> +	insn = aarch64_insn_gen_hint(AARCH64_INSN_HINT_BTIC);
> +	insns.literal = (u64)func;
> +	insns.insn[0] = cpu_to_le32(insn);
> +
> +	if (!func) {
> +		insn = aarch64_insn_gen_branch_reg(AARCH64_INSN_REG_LR,
> +						   AARCH64_INSN_BRANCH_RETURN);
> +	} else {
> +		insn = aarch64_insn_gen_branch_imm((u64)tramp + 4,
> +						   (u64)strip_cfi_jt(func),
> +						   AARCH64_INSN_BRANCH_NOLINK);
> +
> +		/*
> +		 * Use a NOP if the branch target is out of range, and rely on
> +		 * the indirect call instead.
> +		 */
> +		if (insn == AARCH64_BREAK_FAULT)
> +			insn = aarch64_insn_gen_hint(AARCH64_INSN_HINT_NOP);
> +	}
> +	insns.insn[1] = cpu_to_le32(insn);
> +
> +	ret = __aarch64_insn_write(tramp - 8, &insns, sizeof(insns));
> +	if (!WARN_ON(ret))
> +		caches_clean_inval_pou((u64)tramp - 8, sizeof(insns));
>  }
>  
>  int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 50bab186c49b..e16860a14eaf 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -173,6 +173,7 @@ SECTIONS
>  			HIBERNATE_TEXT
>  			KEXEC_TEXT
>  			TRAMP_TEXT
> +			STATIC_CALL_TEXT
>  			*(.gnu.warning)
>  		. = ALIGN(16);
>  		*(.got)			/* Global offset table		*/
> -- 
> 2.30.2
> 
