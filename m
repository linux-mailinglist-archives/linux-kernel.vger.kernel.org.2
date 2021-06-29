Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763FA3B7683
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 18:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhF2QhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 12:37:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39762 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230052AbhF2QhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 12:37:04 -0400
Received: from zn.tnic (p200300ec2f0ee800492cc8b1ab6a6624.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:e800:492c:c8b1:ab6a:6624])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C4581EC0258;
        Tue, 29 Jun 2021 18:34:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1624984475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ryI1VQaeDhrh8AajILjboFGKNOP9c8l5eGMxltp64Rw=;
        b=Lcu0U4yj75ROyJqF+WM6dUlpOJudkFW4ZGSrmsLrb1GOudREPBLZhxywqYZkUByLX3pNGe
        SN1+AvHhqzl31P1/tOuLcPJ+jgRzjdkm9gS44ZjvjxsFvf4iFi+RxdS3miYYSV+BlZItGz
        BSRja63CR+3Aeu8ghAIUFFVbMVhmBPA=
Date:   Tue, 29 Jun 2021 18:34:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Marcos Del Sol Vives <marcos@orca.pet>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86: add NOPL and CMOV emulation
Message-ID: <YNtLlcYasFR84rp5@zn.tnic>
References: <YNWAwVfzSdML/WhO@hirez.programming.kicks-ass.net>
 <20210626130313.1283485-1-marcos@orca.pet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210626130313.1283485-1-marcos@orca.pet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2021 at 03:03:14PM +0200, Marcos Del Sol Vives wrote:
> +config X86_INSN_EMU
> +	bool "Instruction emulation"
> +	help
> +	  Linux can be compiled to emulate some instructions transparently to
> +	  an application, allowing older processors to run modern software
> +	  without recompilation, albeit with a significant performance hit.
> +
> +	  Currently supported instructions are:
> +	   - CMOVxx (conditional moves).
> +	   - NOPL (long NOPs).
> +
> +	  Emulating these two instructions allow i686 binaries to run
> +	  unmodified on devices that only support i586 (Intel Pentium 1,
> +	  AMD Geode GX1, Cyrix III, Vortex86SX/MX/DX, WinChips), or are i686
> +	  but miss some of the instructions (Transmeta Crusoe/Efficeon,
> +	  AMD Geode LX)
> +
> +	  This emulation is only used if the processor is unable execute said

"... unable to execute... "

> +	  instructions, and will not be used if supported natively.

And this is making me wonder whether this needs to be a Kconfig option
at all or not simply enabled by default. Or is there a reason not to
emulate instructions?

We could do a

	pr_info_once("Emulating x86 instructions... ");

or so to let people know that we're not running natively in unexpected
configurations. For example

	if (cpu_feature_enabled(X86_FEATURE_CMOV))
		pr_warn_once("Emulating x86 CMOV even if CPU claims it supports it!");

and other sanity-checks like that.

Which would allow us to support any mode - not only protected but also
long mode, in case we need that emulation there too for whatever reason.

And I'm trying to think of some sort of a test case for this because
we'd need something like that but the only thing I can think of is
something like:

	UD2
	CMOV...

in userspace and then in the #UD handler - since we will have a
soft86_execute() call there - you could advance the rIP by 2 bytes (UD2
is 0f 0b), i.e., do regs->ip += 2 and then land rIP at the CMOV and then
try to emulate it.

And have that testing controllable by a cmdline param or so so that it
is not enabled by default.

And then stick the test program in tools/testing/selftests/x86/

Something like that, at least.

> +static bool cmov_check_condition(struct insn *insn, struct pt_regs *regs)
> +{
> +	bool result, invert;
> +	int condition, flags;
> +
> +	/*
> +	 * Bits 3-1 of the second opcode byte specify the condition.
> +	 *
> +	 * Bit 0 of the second opcode byte is a flag - if set, the result must
> +	 * be inverted.
> +	 */

This comment goes over the function. Along with documenting what that
function returns.

> +static bool cmov_do_move(struct insn *insn, struct pt_regs *regs)

So this function could use some explanation what it is doing -
basically, shuffling data between pt_regs members to simulate the
register moves.

Along with an explicit

"CMOV: Conditionally moves from first operand (mem/reg) into second
operand (reg)."

to explain the direction of the movement so that people don't have to
decipher this function each time.

> +{
> +	int reg_off, rm_off;
> +	void __user *src;
> +	unsigned char *reg_bytes;
> +
> +	reg_bytes = (unsigned char *)regs;
> +
> +	/* Destination, from the REG part of the ModRM */
> +	reg_off = insn_get_modrm_reg_off(insn, regs);
> +	if (reg_off < 0)
> +		return false;
> +
> +	/* Register to register move */
> +	if (X86_MODRM_MOD(insn->modrm.value) == 3) {
> +		rm_off = insn_get_modrm_rm_off(insn, regs);
> +		if (rm_off < 0)
> +			return false;
> +
> +		memcpy(reg_bytes + reg_off, reg_bytes + rm_off,
> +		       insn->addr_bytes);
> +	} else {
> +		/* Source from the RM part of the ModRM */
> +		src = insn_get_addr_ref(insn, regs);
> +		if (src == (void __user *)-1L)
> +			return false;
> +
> +		if (copy_from_user(reg_bytes + reg_off, src,
> +				   insn->addr_bytes) != 0)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +static bool cmov_execute(struct insn *insn, struct pt_regs *regs)
> +{
> +	/* CMOV is only supported for 16 and 32-bit registers */

I don't understand this one: addr_bytes are either 4 or 8 AFAICT.

> +	if (insn->addr_bytes != 2 && insn->addr_bytes != 4)
> +		return false;
> +
> +	/* If condition is met, execute the move */
> +	if (cmov_check_condition(insn, regs)) {

Just like with the rest of the flow, do the same here:

	if (!cmov_check_condition(insn, regs))
		return false;

	if (!cmov_do_move...

> +		/* Return false if the operands were invalid */
> +		if (!cmov_do_move(insn, regs))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +bool soft86_execute(struct pt_regs *regs)
> +{
> +	int nr_copied;
> +	unsigned char buf[MAX_INSN_SIZE];
> +	struct insn insn;
> +	bool ret;

The tip-tree preferred ordering of variable declarations at the
beginning of a function is reverse fir tree order::

	struct long_struct_name *descriptive_name;
	unsigned long foo, bar;
	unsigned int tmp;
	int ret;

The above is faster to parse than the reverse ordering::

	int ret;
	unsigned int tmp;
	unsigned long foo, bar;
	struct long_struct_name *descriptive_name;

And even more so than random ordering::

	unsigned long foo, bar;
	int ret;
	struct long_struct_name *descriptive_name;
	unsigned int tmp;

Please fix all your functions.

> +	/* Read from userspace */
> +	nr_copied = insn_fetch_from_user(regs, buf);
> +	if (!nr_copied)
> +		return false;
> +
> +	/* Attempt to decode it */
> +	if (!insn_decode_from_regs(&insn, regs, buf, nr_copied))
> +		return false;
> +
> +	/* 0x0F is the two byte opcode escape */
> +	if (insn.opcode.bytes[0] != 0x0F)
> +		return false;

That function is a generic one but you start looking at bytes. What you
should do instead is something like:

	ret = emulate_nopl(insn);
	if (!ret)
		goto done;

	ret = emulate_cmov(insn);
	if (!ret)
		goto done;

	...

done:
	regs->ip += insn.length;

and move all the opcode checking in the respective functions. This way
each function does one thing and one thing only and is self-contained.

Also, the logic should be flipped: the functions should return 0 on
success and !0 on failure so the first function which returned 0, would
mean it has detected and emulated the insn properly.

If none of them manage to succeed, you return false at the end.

All in all, fun stuff!

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

