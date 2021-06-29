Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F753B798D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 22:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbhF2Uy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 16:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbhF2UyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 16:54:06 -0400
X-Greylist: delayed 351 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Jun 2021 13:51:27 PDT
Received: from forward105j.mail.yandex.net (forward105j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C789CC061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 13:51:27 -0700 (PDT)
Received: from sas1-16fb7bdf8acc.qloud-c.yandex.net (sas1-16fb7bdf8acc.qloud-c.yandex.net [IPv6:2a02:6b8:c14:1e07:0:640:16fb:7bdf])
        by forward105j.mail.yandex.net (Yandex) with ESMTP id 6907BB207DA;
        Tue, 29 Jun 2021 23:45:20 +0300 (MSK)
Received: from sas2-34ddad429748.qloud-c.yandex.net (sas2-34ddad429748.qloud-c.yandex.net [2a02:6b8:c08:b787:0:640:34dd:ad42])
        by sas1-16fb7bdf8acc.qloud-c.yandex.net (mxback/Yandex) with ESMTP id St7M9ug1nA-jJHOTJgW;
        Tue, 29 Jun 2021 23:45:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orca.pet; s=mail; t=1624999520;
        bh=QyVZCSKLCKosnWwSdcYu0WjssNofxGMBZVOKO0tuIE4=;
        h=In-Reply-To:From:Date:References:To:Subject:Message-ID:Cc;
        b=eJAfK9DNs6Zj7nqoytjRqjepkiYXZbH5Hqm7QHdMAkbXMwfNAYVKZ4BOENO+dgGIY
         +VG50jpUTBRisXlmOZeeuyYJ2ffMb9A/zMcTDTInY1KbZVspGXUDBV7UZG26TbcMSu
         8jWcHhhOo+MXMEFl9kNQsAX9IYfcvi/eS9iUGaV4=
Authentication-Results: sas1-16fb7bdf8acc.qloud-c.yandex.net; dkim=pass header.i=@orca.pet
Received: by sas2-34ddad429748.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id fbPyjNbkLi-jI2O21nn;
        Tue, 29 Jun 2021 23:45:18 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH v3] x86: add NOPL and CMOV emulation
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
References: <YNWAwVfzSdML/WhO@hirez.programming.kicks-ass.net>
 <20210626130313.1283485-1-marcos@orca.pet> <YNtLlcYasFR84rp5@zn.tnic>
From:   Marcos Del Sol Vives <marcos@orca.pet>
Message-ID: <b69e0c78-81eb-0d4d-dce5-076b5f239e28@orca.pet>
Date:   Tue, 29 Jun 2021 22:45:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNtLlcYasFR84rp5@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After some further testing I am not fully confident if this patch should 
be merged.

I spent yesterday night trying to debug why the Debian installation was 
behaving so erratically. It'd boot all the way to the commandline, ping 
successfully the internet, serve a website over HTTP, connect via SSH to 
remote machines and build stuff using GCC.

However, I could neither install new packages, nor have sshd running, 
nor properly execute "mv", which would actually move the file but then 
complain about running out of memory. All of this without a trace of an 
exception or any kind of error, neither on the program themselves nor on 
dmesg.

All the documentation I had previously read suggested that only CMOV and 
NOPL had been introduced with the i686, and hence these were the two 
instructions I emulated only. As stated previously this is also enough 
to boot Debian mostly flawless.

However, and contrary to what I thought, the i686 also saw the 
introduction of a handful of other x87 instructions (FCMOVB, FCMOVBE, 
FCMOVE, FCMOVNB, FCMOVNBE, FCMOVNE, FCMOVNU, FCMOVU, FCOMI, FCOMIP, 
FUCOMI, FUCOMIP)

Running the program below:

----

#include <stdio.h>
#include <stdint.h>

int main() {
	float val = 6.21;
	uint16_t status;
#ifdef __x86_64__
	uint64_t eflags;
#else
	uint32_t eflags;
#endif

	asm(
		/* Set EFLAGS to a known value */
		"xor %0, %0\n"
		"test %0, %0\n"

		/* Execute FUCOMI and get x87 FLAGS and x86 EFLAGS */
		"flds %2\n"
		"fucomi %%st(0), %%st(0)\n"
		"fnstsw %w0\n"
		"pushf\n"
		"pop %1\n"
		:"=a"(status),"=r"(eflags)
		:"m"(val)
	);

	printf("Float value: %f\n", val);
	printf("FPU status: %04X EFLAGS: %08X\n", status, (int) eflags);
	return 0;
}

---

On my modern i7 outputs:

Float value: 6.210000
FPU status: 3800 EFLAGS: 00000242

However on my i586 Vortex86MX I get:

Float value: nan
FPU status: 3800 EFLAGS: 00000246

The reason why it display 6.21 as "nan" is that libc is using FUCOMI 
(floating point unsorted comparison) to test for NaNs by comparing the 
number to print against itself, as a comparison involving NaNs is an 
invalid operation.

If the floating value was either a normal number or infinity, this works 
and EFLAGS are updated according to the value.

If the value is NaN however, the FPU sets a couple flags (PF, CF at 
least, I think OF too) to 1 to signal that an illegal operation 
happened, which is checked by using a JP (jump if parity set) to branch 
to the code path that displays "nan" instead of the value.

This i586 (not sure if specific to this processor in particular, or it's 
standard within all i586) is that it __always__ sets the parity bit on a 
FUCOMI (bit 2 of EFLAGS), so all numbers are displayed as "nan", 
regardless of their value.

The worst part of all is that these unsupported instructions seem not to 
raise the illegal opcode exception, so it might not be possible to 
emulate them at all, making this patch completely pointless. There 
doesn't seem to be any flag on the FPU's status signaling an error has 
happened either.

El 29/06/2021 a las 18:34, Borislav Petkov escribió:
> On Sat, Jun 26, 2021 at 03:03:14PM +0200, Marcos Del Sol Vives wrote:
>> +config X86_INSN_EMU
>> +	bool "Instruction emulation"
>> +	help
>> +	  Linux can be compiled to emulate some instructions transparently to
>> +	  an application, allowing older processors to run modern software
>> +	  without recompilation, albeit with a significant performance hit.
>> +
>> +	  Currently supported instructions are:
>> +	   - CMOVxx (conditional moves).
>> +	   - NOPL (long NOPs).
>> +
>> +	  Emulating these two instructions allow i686 binaries to run
>> +	  unmodified on devices that only support i586 (Intel Pentium 1,
>> +	  AMD Geode GX1, Cyrix III, Vortex86SX/MX/DX, WinChips), or are i686
>> +	  but miss some of the instructions (Transmeta Crusoe/Efficeon,
>> +	  AMD Geode LX)
>> +
>> +	  This emulation is only used if the processor is unable execute said
> 
> "... unable to execute..."
> 
>> +	  instructions, and will not be used if supported natively.
> 
> And this is making me wonder whether this needs to be a Kconfig option
> at all or not simply enabled by default. Or is there a reason not to
> emulate instructions?

I added that option because enabling this features on i686/i786 machines 
will just increase code bloat for no reason.

Also, I am not an expert in cryptography but I think CMOV instructions 
with their fixed duration are widely used for executing algorithms in 
constant time and avoiding timing leaks.

Thus given emulating them would throw that fixed timing out of the 
window, I preferred to leave this emulation disabled by default, so only 
someone who understands the security implications this might carry would 
enable it.

> 
> We could do a
> 
> 	pr_info_once("Emulating x86 instructions... ");
> 
> or so to let people know that we're not running natively in unexpected
> configurations. For example
> 
> 	if (cpu_feature_enabled(X86_FEATURE_CMOV))
> 		pr_warn_once("Emulating x86 CMOV even if CPU claims it supports it!");
> 
> and other sanity-checks like that.
> 
> Which would allow us to support any mode - not only protected but also
> long mode, in case we need that emulation there too for whatever reason.
> 
> And I'm trying to think of some sort of a test case for this because
> we'd need something like that but the only thing I can think of is
> something like:
> 
> 	UD2
> 	CMOV...
> 
> in userspace and then in the #UD handler - since we will have a
> soft86_execute() call there - you could advance the rIP by 2 bytes (UD2
> is 0f 0b), i.e., do regs->ip += 2 and then land rIP at the CMOV and then
> try to emulate it.
> 
> And have that testing controllable by a cmdline param or so so that it
> is not enabled by default.
> 
> And then stick the test program in tools/testing/selftests/x86/
> 
> Something like that, at least.
> 
>> +static bool cmov_check_condition(struct insn *insn, struct pt_regs *regs)
>> +{
>> +	bool result, invert;
>> +	int condition, flags;
>> +
>> +	/*
>> +	 * Bits 3-1 of the second opcode byte specify the condition.
>> +	 *
>> +	 * Bit 0 of the second opcode byte is a flag - if set, the result must
>> +	 * be inverted.
>> +	 */
> 
> This comment goes over the function. Along with documenting what that
> function returns.
> 
>> +static bool cmov_do_move(struct insn *insn, struct pt_regs *regs)
> 
> So this function could use some explanation what it is doing -
> basically, shuffling data between pt_regs members to simulate the
> register moves.
> 
> Along with an explicit
> 
> "CMOV: Conditionally moves from first operand (mem/reg) into second
> operand (reg)."
> 
> to explain the direction of the movement so that people don't have to
> decipher this function each time.
> 
>> +{
>> +	int reg_off, rm_off;
>> +	void __user *src;
>> +	unsigned char *reg_bytes;
>> +
>> +	reg_bytes = (unsigned char *)regs;
>> +
>> +	/* Destination, from the REG part of the ModRM */
>> +	reg_off = insn_get_modrm_reg_off(insn, regs);
>> +	if (reg_off < 0)
>> +		return false;
>> +
>> +	/* Register to register move */
>> +	if (X86_MODRM_MOD(insn->modrm.value) == 3) {
>> +		rm_off = insn_get_modrm_rm_off(insn, regs);
>> +		if (rm_off < 0)
>> +			return false;
>> +
>> +		memcpy(reg_bytes + reg_off, reg_bytes + rm_off,
>> +		       insn->addr_bytes);
>> +	} else {
>> +		/* Source from the RM part of the ModRM */
>> +		src = insn_get_addr_ref(insn, regs);
>> +		if (src == (void __user *)-1L)
>> +			return false;
>> +
>> +		if (copy_from_user(reg_bytes + reg_off, src,
>> +				   insn->addr_bytes) != 0)
>> +			return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +static bool cmov_execute(struct insn *insn, struct pt_regs *regs)
>> +{
>> +	/* CMOV is only supported for 16 and 32-bit registers */
> 
> I don't understand this one: addr_bytes are either 4 or 8 AFAICT.

Based on experimental testing (so it might be wrong indeed) by encoding 
multiple different CMOVs using GCC with both 16 and 32 bits as 
destination and pr_info'ing the fields of the insn structure, addr_bytes 
seemed to contain the length of the data to copy, hence why I did this.

Again, it might be wrong.

> 
>> +	if (insn->addr_bytes != 2 && insn->addr_bytes != 4)
>> +		return false;
>> +
>> +	/* If condition is met, execute the move */
>> +	if (cmov_check_condition(insn, regs)) {
> 
> Just like with the rest of the flow, do the same here:
> 
> 	if (!cmov_check_condition(insn, regs))
> 		return false;
> 
> 	if (!cmov_do_move...
> 
>> +		/* Return false if the operands were invalid */
>> +		if (!cmov_do_move(insn, regs))
>> +			return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +bool soft86_execute(struct pt_regs *regs)
>> +{
>> +	int nr_copied;
>> +	unsigned char buf[MAX_INSN_SIZE];
>> +	struct insn insn;
>> +	bool ret;
> 
> The tip-tree preferred ordering of variable declarations at the
> beginning of a function is reverse fir tree order::
> 
> 	struct long_struct_name *descriptive_name;
> 	unsigned long foo, bar;
> 	unsigned int tmp;
> 	int ret;
> 
> The above is faster to parse than the reverse ordering::
> 
> 	int ret;
> 	unsigned int tmp;
> 	unsigned long foo, bar;
> 	struct long_struct_name *descriptive_name;
> 
> And even more so than random ordering::
> 
> 	unsigned long foo, bar;
> 	int ret;
> 	struct long_struct_name *descriptive_name;
> 	unsigned int tmp;
> 
> Please fix all your functions.
> 
>> +	/* Read from userspace */
>> +	nr_copied = insn_fetch_from_user(regs, buf);
>> +	if (!nr_copied)
>> +		return false;
>> +
>> +	/* Attempt to decode it */
>> +	if (!insn_decode_from_regs(&insn, regs, buf, nr_copied))
>> +		return false;
>> +
>> +	/* 0x0F is the two byte opcode escape */
>> +	if (insn.opcode.bytes[0] != 0x0F)
>> +		return false;
> 
> That function is a generic one but you start looking at bytes. What you
> should do instead is something like:
> 
> 	ret = emulate_nopl(insn);
> 	if (!ret)
> 		goto done;
> 
> 	ret = emulate_cmov(insn);
> 	if (!ret)
> 		goto done;
> 
> 	...
> 
> done:
> 	regs->ip += insn.length;
> 
> and move all the opcode checking in the respective functions. This way
> each function does one thing and one thing only and is self-contained.
> 

That's how the V1 patch mostly worked - way more modular, using an array 
of different isolated functions and iterating through them until either 
succeeded, but Peter Zijlstra asked me to change it to this approach as 
it would be faster.

> Also, the logic should be flipped: the functions should return 0 on
> success and !0 on failure so the first function which returned 0, would
> mean it has detected and emulated the insn properly.
> 
> If none of them manage to succeed, you return false at the end.
> 

But I am using "bool"s not ints as return values. It doesn't make sense 
to return a "true" (non-zero) if the operation failed.

> All in all, fun stuff!
> 
> Thx.
> 
