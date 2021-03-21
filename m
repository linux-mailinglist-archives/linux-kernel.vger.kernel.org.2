Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725ED343448
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 20:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhCUTGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 15:06:31 -0400
Received: from foss.arm.com ([217.140.110.172]:43054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230064AbhCUTGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 15:06:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 961FEED1;
        Sun, 21 Mar 2021 12:06:15 -0700 (PDT)
Received: from e107158-lin (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C1C33F718;
        Sun, 21 Mar 2021 12:06:14 -0700 (PDT)
Date:   Sun, 21 Mar 2021 19:06:11 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v7 2/2] ARM: ftrace: Add MODULE_PLTS support
Message-ID: <20210321190611.d6a3hbqabts3qq5v@e107158-lin>
References: <20210127110944.41813-3-alexander.sverdlin@nokia.com>
 <20210307172650.uztx3sk5abybbp3f@e107158-lin.cambridge.arm.com>
 <0c122390-6e76-f773-86e9-8c085f4384f2@nokia.com>
 <20210309174201.n53za7mw33dqyleh@e107158-lin.cambridge.arm.com>
 <3eecf51d-b189-9e8b-f19d-a49d0764aae5@nokia.com>
 <05608bc8-f44d-5f91-15ab-af00c59b53e6@gmail.com>
 <e726be33-bc03-0515-f430-c5a34ebc3619@nokia.com>
 <20210312172401.36awjh4hmj4cs6ot@e107158-lin.cambridge.arm.com>
 <134e1a2c-daac-7b00-c170-bcca434d08df@gmail.com>
 <20210314220217.4mexdide7sqjfved@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210314220217.4mexdide7sqjfved@e107158-lin>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander

On 03/14/21 22:02, Qais Yousef wrote:
> I fixed Ard's email as it kept bouncing back.
> 
> +CC Linus Walleij
> 
> On 03/12/21 10:35, Florian Fainelli wrote:
> > On 3/12/21 9:24 AM, Qais Yousef wrote:
> > > Hi Alexander
> > > 
> > > On 03/10/21 18:17, Alexander Sverdlin wrote:
> > >> Hi!
> > >>
> > >> On 10/03/2021 17:14, Florian Fainelli wrote:
> > >>>>>>> I tried on 5.12-rc2 and 5.11 but couldn't reproduce the problem using your
> > >>>>> I still can't reproduce on 5.12-rc2.
> > >>>>>
> > >>>>> I do have CONFIG_ARM_MODULE_PLTS=y. Do you need to do something else after
> > >>>>> loading the module? I tried starting ftrace, but maybe there's a particular
> > >>>>> combination required?
> > >>>> You need to load a BIG module, so big that it has no place in the modules area
> > >>>> any more and goes to vmalloc area.
> > >>> You absolutely need a very big module maybe more than one. When I tested
> > >>> this, I could use the two proprietary modules (*sigh*) that I needed to
> > >>> exercise against and loading one but not the other was not enough to
> > >>> make the second module loading spill into vmalloc space.
> > >>
> > >> Here is what I use instead of these real world "proprietary" modules (which of course
> > >> were the real trigger for the patch):
> > >>
> > >> https://www.spinics.net/lists/arm-kernel/msg878599.html
> > > 
> > > I am testing with your module. I can't reproduce the problem you describe with
> > > it as I stated.
> > > 
> > > I will try to spend more time on it on the weekend.
> > 
> > Alexander, do you load one or multiple instances of that fat module?
> > 
> > The test module does a 6 * 1024 * 1024 / 2 = 3 million repetitions of
> > the "nop" instruction which should be 32-bits wide in ARM mode and
> > 16-bits wide in Thumb mode, right?
> > 
> > In ARM mode we have a 14MB module space, so 3 * 1024 * 1024 * 4 = 12MB,
> > which should still fit within if you have no module loaded, however a
> > second instance of the module should make us spill into vmalloc space.
> > 
> > In Thumb mode, we have a 6MB module space, so 3 * 1024 * 1024 * 2 = 6MB
> > so we may spill, but maybe not.
> > 
> > I was not able to reproduce the warning with just one module, but with
> > two (cannot have the same name BTW), it kicked in.
> 
> Thanks Florian. With 2 modules I can indeed reproduce the issue. Though for
> thumb I still hit the other problem so I couldn't properly test it.
> 
> I have come up with an alternative solution (hacky patch at the end) which seem
> to fix both problems for me. That is
> 
> 	* sed -i 's/=m/=y/ .config' which causes a lot of veneers to be
> 	  generated is handled correctly now AFAICT
> 	* Loading a fat module works the same.
> 
> I have tested it in both arm and thumb modes. Running
> 
> 	trace-cmd start -p function
> 
> executes successfully and I can see functions being traced.
> 
> The solution makes a lot of assumptions that I yet to verify though, but I hope
> it could form the basis for a proper one that fixes both issues. It's faster
> too. I'm just not sure if I need to take this handling one layer above or it's
> okay to be done at __arm_gen_branch(). Also I had a version that was more
> strict about verifying the veneer @pc points to @addr before using the veneer
> address but that fails for modules. The logic didn't work to verify for module,
> but we do get the correct veneer function as returned by get_module_plt().
> 
> Since for ftrace we really care about mcount, I considered reading the plt once
> at load time to get the address and save it in rec->arch and use that later
> instead of continuously reading it + having to store the plt. We could revisit
> that if the below has a fundamental flaw.
> 
> Alexander, have you considered these options before? I could have easily missed
> something :-)

So the answer is no, that wouldn't have worked.

After spending more time on this your approach looks goot to me now.  If you
send v8 addressing my comment about removing the range check from
ftrace_call_repalce() as it is rendundant to what arm_gen_branch_link() is
already doing I'd be happy to give this series my reviewed-and-tested-by.
You'd need to ensure the warning is not triggered when we expect the call to
fail.

FWIW, I do have this to address that range check issue and reduce the ifdefery
too if it helps

------>8---------


diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
index a4dbac07e4ef..ee2707c613bf 100644
--- a/arch/arm/include/asm/ftrace.h
+++ b/arch/arm/include/asm/ftrace.h
@@ -15,9 +15,7 @@ extern void __gnu_mcount_nc(void);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 struct dyn_arch_ftrace {
-#ifdef CONFIG_ARM_MODULE_PLTS
 	struct module *mod;
-#endif
 };
 
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
diff --git a/arch/arm/include/asm/insn.h b/arch/arm/include/asm/insn.h
index f20e08ac85ae..71c3edefe629 100644
--- a/arch/arm/include/asm/insn.h
+++ b/arch/arm/include/asm/insn.h
@@ -13,18 +13,24 @@ arm_gen_nop(void)
 }
 
 unsigned long
-__arm_gen_branch(unsigned long pc, unsigned long addr, bool link);
+__arm_gen_branch(unsigned long pc, unsigned long addr, bool link, bool check);
 
 static inline unsigned long
 arm_gen_branch(unsigned long pc, unsigned long addr)
 {
-	return __arm_gen_branch(pc, addr, false);
+	return __arm_gen_branch(pc, addr, false, true);
 }
 
 static inline unsigned long
 arm_gen_branch_link(unsigned long pc, unsigned long addr)
 {
-	return __arm_gen_branch(pc, addr, true);
+	return __arm_gen_branch(pc, addr, true, true);
+}
+
+static inline unsigned long
+arm_gen_branch_link_nocheck(unsigned long pc, unsigned long addr)
+{
+	return __arm_gen_branch(pc, addr, true, false);
 }
 
 #endif
diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index fa867a57100f..a30b1a8e5908 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -70,20 +70,28 @@ int ftrace_arch_code_modify_post_process(void)
 
 static unsigned long ftrace_call_replace(unsigned long pc, unsigned long addr)
 {
-	s32 offset = addr - pc;
-	s32 blim = 0xfe000008;
-	s32 flim = 0x02000004;
+	return arm_gen_branch_link(pc, addr);
+}
 
-	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
-		blim = 0xff000004;
-		flim = 0x01000002;
-	}
+static unsigned long
+ftrace_call_replace_mod(struct module *mod, unsigned long pc, unsigned long addr)
+{
+#ifdef CONFIG_ARM_MODULE_PLTS
+	unsigned long new;
 
-	if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS) &&
-	    (offset < blim || offset > flim))
-		return 0;
+	if (likely(!mod))
+		return arm_gen_branch_link(pc, addr);
 
+	new = arm_gen_branch_link_nocheck(pc, addr);
+	if (!new) {
+		addr = get_module_plt(mod, pc, addr);
+		new = arm_gen_branch_link(pc, addr);
+	}
+
+	return new;
+#else
 	return arm_gen_branch_link(pc, addr);
+#endif
 }
 
 static int ftrace_modify_code(unsigned long pc, unsigned long old,
@@ -141,18 +149,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 
 	old = ftrace_nop_replace(rec);
 
-	new = ftrace_call_replace(ip, aaddr);
-
-#ifdef CONFIG_ARM_MODULE_PLTS
-	if (!new) {
-		struct module *mod = rec->arch.mod;
-
-		if (mod) {
-			aaddr = get_module_plt(mod, ip, aaddr);
-			new = ftrace_call_replace(ip, aaddr);
-		}
-	}
-#endif
+	new = ftrace_call_replace_mod(rec->arch.mod, ip, aaddr);
 
 	return ftrace_modify_code(rec->ip, old, new, true);
 }
@@ -183,23 +180,11 @@ int ftrace_make_nop(struct module *mod,
 	unsigned long new;
 	int ret;
 
-#ifdef CONFIG_ARM_MODULE_PLTS
 	/* mod is only supplied during module loading */
-	if (!mod)
-		mod = rec->arch.mod;
-	else
+	if (mod)
 		rec->arch.mod = mod;
-#endif
-
-	old = ftrace_call_replace(ip, aaddr);
-
-#ifdef CONFIG_ARM_MODULE_PLTS
-	if (!old && mod) {
-		aaddr = get_module_plt(mod, ip, aaddr);
-		old = ftrace_call_replace(ip, aaddr);
-	}
-#endif
 
+	old = ftrace_call_replace_mod(rec->arch.mod, ip, aaddr);
 	new = ftrace_nop_replace(rec);
 	ret = ftrace_modify_code(ip, old, new, true);
 
diff --git a/arch/arm/kernel/insn.c b/arch/arm/kernel/insn.c
index 2e844b70386b..37ec5734309e 100644
--- a/arch/arm/kernel/insn.c
+++ b/arch/arm/kernel/insn.c
@@ -4,7 +4,7 @@
 #include <asm/opcodes.h>
 
 static unsigned long
-__arm_gen_branch_thumb2(unsigned long pc, unsigned long addr, bool link)
+__arm_gen_branch_thumb2(unsigned long pc, unsigned long addr, bool link, bool check)
 {
 	unsigned long s, j1, j2, i1, i2, imm10, imm11;
 	unsigned long first, second;
@@ -12,7 +12,7 @@ __arm_gen_branch_thumb2(unsigned long pc, unsigned long addr, bool link)
 
 	offset = (long)addr - (long)(pc + 4);
 	if (offset < -16777216 || offset > 16777214) {
-		WARN_ON_ONCE(1);
+		WARN_ON_ONCE(check);
 		return 0;
 	}
 
@@ -34,7 +34,7 @@ __arm_gen_branch_thumb2(unsigned long pc, unsigned long addr, bool link)
 }
 
 static unsigned long
-__arm_gen_branch_arm(unsigned long pc, unsigned long addr, bool link)
+__arm_gen_branch_arm(unsigned long pc, unsigned long addr, bool link, bool check)
 {
 	unsigned long opcode = 0xea000000;
 	long offset;
@@ -44,7 +44,7 @@ __arm_gen_branch_arm(unsigned long pc, unsigned long addr, bool link)
 
 	offset = (long)addr - (long)(pc + 8);
 	if (unlikely(offset < -33554432 || offset > 33554428)) {
-		WARN_ON_ONCE(1);
+		WARN_ON_ONCE(check);
 		return 0;
 	}
 
@@ -54,10 +54,10 @@ __arm_gen_branch_arm(unsigned long pc, unsigned long addr, bool link)
 }
 
 unsigned long
-__arm_gen_branch(unsigned long pc, unsigned long addr, bool link)
+__arm_gen_branch(unsigned long pc, unsigned long addr, bool link, bool check)
 {
 	if (IS_ENABLED(CONFIG_THUMB2_KERNEL))
-		return __arm_gen_branch_thumb2(pc, addr, link);
+		return __arm_gen_branch_thumb2(pc, addr, link, check);
 	else
-		return __arm_gen_branch_arm(pc, addr, link);
+		return __arm_gen_branch_arm(pc, addr, link, check);
 }

------>8---------


Thanks

--
Qais Yousef
