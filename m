Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A0F33A86A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 23:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhCNWCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 18:02:37 -0400
Received: from foss.arm.com ([217.140.110.172]:46954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhCNWCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 18:02:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E6681FB;
        Sun, 14 Mar 2021 15:02:21 -0700 (PDT)
Received: from e107158-lin (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07E8D3F718;
        Sun, 14 Mar 2021 15:02:19 -0700 (PDT)
Date:   Sun, 14 Mar 2021 22:02:17 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v7 2/2] ARM: ftrace: Add MODULE_PLTS support
Message-ID: <20210314220217.4mexdide7sqjfved@e107158-lin>
References: <20210127110944.41813-1-alexander.sverdlin@nokia.com>
 <20210127110944.41813-3-alexander.sverdlin@nokia.com>
 <20210307172650.uztx3sk5abybbp3f@e107158-lin.cambridge.arm.com>
 <0c122390-6e76-f773-86e9-8c085f4384f2@nokia.com>
 <20210309174201.n53za7mw33dqyleh@e107158-lin.cambridge.arm.com>
 <3eecf51d-b189-9e8b-f19d-a49d0764aae5@nokia.com>
 <05608bc8-f44d-5f91-15ab-af00c59b53e6@gmail.com>
 <e726be33-bc03-0515-f430-c5a34ebc3619@nokia.com>
 <20210312172401.36awjh4hmj4cs6ot@e107158-lin.cambridge.arm.com>
 <134e1a2c-daac-7b00-c170-bcca434d08df@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <134e1a2c-daac-7b00-c170-bcca434d08df@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I fixed Ard's email as it kept bouncing back.

+CC Linus Walleij

On 03/12/21 10:35, Florian Fainelli wrote:
> On 3/12/21 9:24 AM, Qais Yousef wrote:
> > Hi Alexander
> > 
> > On 03/10/21 18:17, Alexander Sverdlin wrote:
> >> Hi!
> >>
> >> On 10/03/2021 17:14, Florian Fainelli wrote:
> >>>>>>> I tried on 5.12-rc2 and 5.11 but couldn't reproduce the problem using your
> >>>>> I still can't reproduce on 5.12-rc2.
> >>>>>
> >>>>> I do have CONFIG_ARM_MODULE_PLTS=y. Do you need to do something else after
> >>>>> loading the module? I tried starting ftrace, but maybe there's a particular
> >>>>> combination required?
> >>>> You need to load a BIG module, so big that it has no place in the modules area
> >>>> any more and goes to vmalloc area.
> >>> You absolutely need a very big module maybe more than one. When I tested
> >>> this, I could use the two proprietary modules (*sigh*) that I needed to
> >>> exercise against and loading one but not the other was not enough to
> >>> make the second module loading spill into vmalloc space.
> >>
> >> Here is what I use instead of these real world "proprietary" modules (which of course
> >> were the real trigger for the patch):
> >>
> >> https://www.spinics.net/lists/arm-kernel/msg878599.html
> > 
> > I am testing with your module. I can't reproduce the problem you describe with
> > it as I stated.
> > 
> > I will try to spend more time on it on the weekend.
> 
> Alexander, do you load one or multiple instances of that fat module?
> 
> The test module does a 6 * 1024 * 1024 / 2 = 3 million repetitions of
> the "nop" instruction which should be 32-bits wide in ARM mode and
> 16-bits wide in Thumb mode, right?
> 
> In ARM mode we have a 14MB module space, so 3 * 1024 * 1024 * 4 = 12MB,
> which should still fit within if you have no module loaded, however a
> second instance of the module should make us spill into vmalloc space.
> 
> In Thumb mode, we have a 6MB module space, so 3 * 1024 * 1024 * 2 = 6MB
> so we may spill, but maybe not.
> 
> I was not able to reproduce the warning with just one module, but with
> two (cannot have the same name BTW), it kicked in.

Thanks Florian. With 2 modules I can indeed reproduce the issue. Though for
thumb I still hit the other problem so I couldn't properly test it.

I have come up with an alternative solution (hacky patch at the end) which seem
to fix both problems for me. That is

	* sed -i 's/=m/=y/ .config' which causes a lot of veneers to be
	  generated is handled correctly now AFAICT
	* Loading a fat module works the same.

I have tested it in both arm and thumb modes. Running

	trace-cmd start -p function

executes successfully and I can see functions being traced.

The solution makes a lot of assumptions that I yet to verify though, but I hope
it could form the basis for a proper one that fixes both issues. It's faster
too. I'm just not sure if I need to take this handling one layer above or it's
okay to be done at __arm_gen_branch(). Also I had a version that was more
strict about verifying the veneer @pc points to @addr before using the veneer
address but that fails for modules. The logic didn't work to verify for module,
but we do get the correct veneer function as returned by get_module_plt().

Since for ftrace we really care about mcount, I considered reading the plt once
at load time to get the address and save it in rec->arch and use that later
instead of continuously reading it + having to store the plt. We could revisit
that if the below has a fundamental flaw.

Alexander, have you considered these options before? I could have easily missed
something :-)

Thanks

--
Qais Yousef


------->8---------


diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index 9a79ef6b1876..70f6e197c306 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -157,6 +157,9 @@ int ftrace_make_nop(struct module *mod,
 	unsigned long new;
 	int ret;
 
+	if (mod)
+		pr_info("VENEER_DBG: mcount_veneedr_addr = 0x%x\n", get_module_plt(mod, ip, addr));
+
 	old = ftrace_call_replace(ip, adjust_address(rec, addr));
 	new = ftrace_nop_replace(rec);
 	ret = ftrace_modify_code(ip, old, new, true);
diff --git a/arch/arm/kernel/insn.c b/arch/arm/kernel/insn.c
index 2e844b70386b..0d6abf8d726f 100644
--- a/arch/arm/kernel/insn.c
+++ b/arch/arm/kernel/insn.c
@@ -3,17 +3,53 @@
 #include <linux/kernel.h>
 #include <asm/opcodes.h>
 
+/*
+ *  Checks if a @pc points to a veneer to @addr
+ *
+ *  Returns addr to veneer if true, 0 otherwise.
+ */
+static unsigned long
+ __arm_addr_is_veneer_thumb2(unsigned long pc, unsigned long addr, bool *exchange)
+{
+	unsigned long insn = __mem_to_opcode_thumb32(*(unsigned long *)pc);
+
+	unsigned long s = insn >> 26 & 0x1;
+	unsigned long j1 = insn >> 13 & 0x1;
+	unsigned long j2 = insn >> 11 & 0x1;
+	unsigned long i1 = !(j1 ^ s);
+	unsigned long i2 = !(j2 ^ s);
+	unsigned long imm10 = insn >> 16 & 0x3ff;
+	unsigned long imm11 = (insn & 0x7ff) + 1;
+
+	long offset = ((s ? 0xff : s) << 24) | (i1 << 23) |
+			(i2 << 22) | (imm10 << 12) | (imm11 << 1);
+
+	unsigned long veneer_fn = pc + 2 + offset;
+	long voffset = *(long *)(veneer_fn + 4 + 4 + 4);
+	unsigned long veneer_addr = (long)veneer_fn + 4 + 4 + 4 + voffset;
+
+	*exchange = !(insn & 1 << 12);
+
+	pr_info("VENEER_DBG: insn=0x%lx, offset=0x%lx\n", insn, offset);
+	pr_info("VENEER_DBG: pc=0x%lx, addr=0x%lx\n", pc, addr);
+	pr_info("VENEER_DBG: veneer_fn=0x%lx, veneer_addr=0x%lx\n", veneer_fn, veneer_addr);
+
+	return veneer_fn;
+
+}
+
 static unsigned long
 __arm_gen_branch_thumb2(unsigned long pc, unsigned long addr, bool link)
 {
 	unsigned long s, j1, j2, i1, i2, imm10, imm11;
 	unsigned long first, second;
+	bool exchange = false;
 	long offset;
 
 	offset = (long)addr - (long)(pc + 4);
 	if (offset < -16777216 || offset > 16777214) {
-		WARN_ON_ONCE(1);
-		return 0;
+		unsigned long vaddr = __arm_addr_is_veneer_thumb2(pc, addr, &exchange);
+		offset = (long)vaddr - (long)(pc + 4);
 	}
 
 	s	= (offset >> 24) & 0x1;
@@ -30,9 +66,34 @@ __arm_gen_branch_thumb2(unsigned long pc, unsigned long addr, bool link)
 	if (link)
 		second |= 1 << 14;
 
+	if (exchange)
+		second &= ~(1 << 12);
+
+	//pr_info("VENEER_DBG: thumb32 opcode = 0x%x\n", __opcode_thumb32_compose(first, second));
 	return __opcode_thumb32_compose(first, second);
 }
 
+/*
+ *  Checks if a @pc points to a veneer to @addr
+ *
+ *  Returns addr to veneer if true, 0 otherwise.
+ */
+static unsigned long
+ __arm_addr_is_veneer_arm(unsigned long pc, unsigned long addr)
+{
+	unsigned long insn = __mem_to_opcode_arm(*(unsigned long *)pc);
+	long offset = (insn & 0xffffff) << 2;
+	unsigned long veneer_fn = pc + 8 + offset;
+	long voffset = 0; //*(long *)(veneer_fn + 8);
+	unsigned long veneer_addr = (long)veneer_fn + 4 + 8 + voffset;
+
+	pr_info("VENEER_DBG: insn=0x%lx, offset=0x%lx\n", insn, offset);
+	pr_info("VENEER_DBG: pc=0x%lx, addr=0x%lx\n", pc, addr);
+	pr_info("VENEER_DBG: veneer_fn=0x%lx, veneer_addr=0x%lx\n", veneer_fn, veneer_addr);
+
+	return veneer_fn;
+}
+
 static unsigned long
 __arm_gen_branch_arm(unsigned long pc, unsigned long addr, bool link)
 {
@@ -44,8 +105,8 @@ __arm_gen_branch_arm(unsigned long pc, unsigned long addr, bool link)
 
 	offset = (long)addr - (long)(pc + 8);
 	if (unlikely(offset < -33554432 || offset > 33554428)) {
-		WARN_ON_ONCE(1);
-		return 0;
+		unsigned long vaddr = __arm_addr_is_veneer_arm(pc, addr);
+		offset = (long)vaddr - (long)(pc + 8);
 	}
 
 	offset = (offset >> 2) & 0x00ffffff;
