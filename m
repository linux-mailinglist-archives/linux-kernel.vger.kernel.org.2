Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E88332D78
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 18:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhCIRmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 12:42:21 -0500
Received: from foss.arm.com ([217.140.110.172]:57278 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231835AbhCIRmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 12:42:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAAA71FB;
        Tue,  9 Mar 2021 09:42:04 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69AE93F73C;
        Tue,  9 Mar 2021 09:42:03 -0800 (PST)
Date:   Tue, 9 Mar 2021 17:42:01 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v7 2/2] ARM: ftrace: Add MODULE_PLTS support
Message-ID: <20210309174201.n53za7mw33dqyleh@e107158-lin.cambridge.arm.com>
References: <20210127110944.41813-1-alexander.sverdlin@nokia.com>
 <20210127110944.41813-3-alexander.sverdlin@nokia.com>
 <20210307172650.uztx3sk5abybbp3f@e107158-lin.cambridge.arm.com>
 <0c122390-6e76-f773-86e9-8c085f4384f2@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0c122390-6e76-f773-86e9-8c085f4384f2@nokia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/21 08:58, Alexander Sverdlin wrote:
> Hi!
> 
> On 07/03/2021 18:26, Qais Yousef wrote:
> > I tried on 5.12-rc2 and 5.11 but couldn't reproduce the problem using your

I still can't reproduce on 5.12-rc2.

I do have CONFIG_ARM_MODULE_PLTS=y. Do you need to do something else after
loading the module? I tried starting ftrace, but maybe there's a particular
combination required?

> > instructions on the other email. But most likely because I'm hitting another
> > problem that could be masking it. I'm not sure it is related or just randomly
> > happened to hit it.
> > 
> > Did you see something similar?
> 
> [...]
> 
> > 	[    0.000000] [<c1b01a38>] (ftrace_bug) from [<c046316c>] (ftrace_process_locs+0x2b0/0x518)
> > 	[    0.000000]  r7:c3817ac4 r6:c38040c0 r5:00000a3c r4:000134e4
> > 	[    0.000000] [<c0462ebc>] (ftrace_process_locs) from [<c2b25240>] (ftrace_init+0xc8/0x174)
> > 	[    0.000000]  r10:c2ffa000 r9:c2be8a78 r8:c2c5d1fc r7:c2c0c208 r6:00000001 r5:c2d0908c
> > 	[    0.000000]  r4:c362f518
> > 	[    0.000000] [<c2b25178>] (ftrace_init) from [<c2b00e14>] (start_kernel+0x2f4/0x5b8)
> > 	[    0.000000]  r9:c2be8a78 r8:dbfffec0 r7:00000000 r6:c36385cc r5:c2d08f00 r4:c2ffa000
> > 	[    0.000000] [<c2b00b20>] (start_kernel) from [<00000000>] (0x0)
> 
> This means, FTRACE has more problems with your kernel/compiler/platform, I've addressed similar issue
> in the past, but my patch should be long merged:
> 
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1817963.html
> 
> Could it be the same problem as here:
> https://www.spinics.net/lists/arm-kernel/msg854022.html
> 
> Seems that the size check deserves something line BUILD_BUG_ON() with FTRACE...

So I only see this when I convert all modules to be built-in

	sed -i 's/=m/=y/' .config

FWIW, I see the problem with your patch applied too. Trying to dig more into
it..

> 
> >> diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
> >> index 9a79ef6..fa867a5 100644
> >> --- a/arch/arm/kernel/ftrace.c
> >> +++ b/arch/arm/kernel/ftrace.c
> >> @@ -70,6 +70,19 @@ int ftrace_arch_code_modify_post_process(void)
> >>  
> >>  static unsigned long ftrace_call_replace(unsigned long pc, unsigned long addr)
> >>  {
> >> +	s32 offset = addr - pc;
> >> +	s32 blim = 0xfe000008;
> >> +	s32 flim = 0x02000004;
> > 
> > This look like magic numbers to me..
> 
> These magic numbers are most probably the reason for your FTRACE to resign...
> Those are backward- and forward-branch limits. I didn't find the matching DEFINEs
> in the kernel, but I would be happy to learn them. I can also put some comments,
> but I actually thought the purpose would be obvious from the code...

So I did dig more into it. The range is asymmetrical indeed. And the strange
offset is to cater for the pc being incremented by +8 (+4 for thumb2).

You're duplicating the checks in __arm_gen_branch_{thumb2, arm}(). As you noted
__arm_gen_branch() which is called by arm_gen_branch_link() will end up doing
the exact same check and return 0. So why do you need to duplicate the check
here? We can do something about the WARN_ON_ONCE(1).

[...]

> >> +
> >>  	return arm_gen_branch_link(pc, addr);
> >>  }
> >>  
> >> @@ -124,10 +137,22 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
> >>  {
> >>  	unsigned long new, old;
> >>  	unsigned long ip = rec->ip;
> >> +	unsigned long aaddr = adjust_address(rec, addr);
> >>  
> >>  	old = ftrace_nop_replace(rec);
> >>  
> >> -	new = ftrace_call_replace(ip, adjust_address(rec, addr));
> >> +	new = ftrace_call_replace(ip, aaddr);
> >> +
> >> +#ifdef CONFIG_ARM_MODULE_PLTS
> >> +	if (!new) {
> >> +		struct module *mod = rec->arch.mod;
> >> +
> >> +		if (mod) {
> > 
> > What would happen if !new and !mod?
> 
> I believe, that's exactly what happens in the dump you experience with your kernel.
> This is not covered by this patch, this patch covers the issue with modules in vmalloc area.
> 
> >> +			aaddr = get_module_plt(mod, ip, aaddr);
> >> +			new = ftrace_call_replace(ip, aaddr);
> > 
> > I assume we're guaranteed to have a sensible value returned in 'new' here?
> 
> Otherwise you'd see the dump you see :)
> It relies on the already existing error handling.

I understand from this there are still loose ends to be handled in this area of
the code.

I admit I need to spend more time to understand why I get the failure above and
how this overlaps with your proposal. But as it stands it seems there's more
work to be done here.

Thanks

--
Qais Yousef
