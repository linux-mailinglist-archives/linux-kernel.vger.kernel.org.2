Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A8C330352
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 18:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhCGR04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 12:26:56 -0500
Received: from foss.arm.com ([217.140.110.172]:54282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229711AbhCGR0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 12:26:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8D8431B;
        Sun,  7 Mar 2021 09:26:53 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC6363F73C;
        Sun,  7 Mar 2021 09:26:52 -0800 (PST)
Date:   Sun, 7 Mar 2021 17:26:50 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Alexander A Sverdlin <alexander.sverdlin@nokia.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v7 2/2] ARM: ftrace: Add MODULE_PLTS support
Message-ID: <20210307172650.uztx3sk5abybbp3f@e107158-lin.cambridge.arm.com>
References: <20210127110944.41813-1-alexander.sverdlin@nokia.com>
 <20210127110944.41813-3-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210127110944.41813-3-alexander.sverdlin@nokia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander

Sorry if I'm butting in out of the blue. I got curious so decided to have a go
at reproducing the issue :-)

On 01/27/21 12:09, Alexander A Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> Teach ftrace_make_call() and ftrace_make_nop() about PLTs.
> Teach PLT code about FTRACE and all its callbacks.
> Otherwise the following might happen:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 14 PID: 2265 at .../arch/arm/kernel/insn.c:14 __arm_gen_branch+0x83/0x8c()
> ...
> Hardware name: LSI Axxia AXM55XX
> [<c0314a49>] (unwind_backtrace) from [<c03115e9>] (show_stack+0x11/0x14)
> [<c03115e9>] (show_stack) from [<c0519f51>] (dump_stack+0x81/0xa8)
> [<c0519f51>] (dump_stack) from [<c032185d>] (warn_slowpath_common+0x69/0x90)
> [<c032185d>] (warn_slowpath_common) from [<c03218f3>] (warn_slowpath_null+0x17/0x1c)
> [<c03218f3>] (warn_slowpath_null) from [<c03143cf>] (__arm_gen_branch+0x83/0x8c)
> [<c03143cf>] (__arm_gen_branch) from [<c0314337>] (ftrace_make_nop+0xf/0x24)
> [<c0314337>] (ftrace_make_nop) from [<c038ebcb>] (ftrace_process_locs+0x27b/0x3e8)
> [<c038ebcb>] (ftrace_process_locs) from [<c0378d79>] (load_module+0x11e9/0x1a44)
> [<c0378d79>] (load_module) from [<c037974d>] (SyS_finit_module+0x59/0x84)
> [<c037974d>] (SyS_finit_module) from [<c030e981>] (ret_fast_syscall+0x1/0x18)
> ---[ end trace e1b64ced7a89adcc ]---
> ------------[ cut here ]------------
> WARNING: CPU: 14 PID: 2265 at .../kernel/trace/ftrace.c:1979 ftrace_bug+0x1b1/0x234()
> ...
> Hardware name: LSI Axxia AXM55XX
> [<c0314a49>] (unwind_backtrace) from [<c03115e9>] (show_stack+0x11/0x14)
> [<c03115e9>] (show_stack) from [<c0519f51>] (dump_stack+0x81/0xa8)
> [<c0519f51>] (dump_stack) from [<c032185d>] (warn_slowpath_common+0x69/0x90)
> [<c032185d>] (warn_slowpath_common) from [<c03218f3>] (warn_slowpath_null+0x17/0x1c)
> [<c03218f3>] (warn_slowpath_null) from [<c038e87d>] (ftrace_bug+0x1b1/0x234)
> [<c038e87d>] (ftrace_bug) from [<c038ebd5>] (ftrace_process_locs+0x285/0x3e8)
> [<c038ebd5>] (ftrace_process_locs) from [<c0378d79>] (load_module+0x11e9/0x1a44)
> [<c0378d79>] (load_module) from [<c037974d>] (SyS_finit_module+0x59/0x84)
> [<c037974d>] (SyS_finit_module) from [<c030e981>] (ret_fast_syscall+0x1/0x18)
> ---[ end trace e1b64ced7a89adcd ]---
> ftrace failed to modify [<e9ef7006>] 0xe9ef7006
> actual: 02:f0:3b:fa
> ftrace record flags: 0
> (0) expected tramp: c0314265
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

I tried on 5.12-rc2 and 5.11 but couldn't reproduce the problem using your
instructions on the other email. But most likely because I'm hitting another
problem that could be masking it. I'm not sure it is related or just randomly
happened to hit it.

Did you see something similar?


	[    0.000000] ftrace: allocating 82941 entries in 244 pages
	[    0.000000] ------------[ ftrace bug ]------------
	[    0.000000] ftrace failed to modify
	[    0.000000] [<c2b00350>] set_reset_devices+0x10/0x28
	[    0.000000]  actual:   0e:28:03:eb
	[    0.000000] Initializing ftrace call sites
	[    0.000000] ftrace record flags: 0
	[    0.000000]  (0)
	[    0.000000]  expected tramp: c0312eb8
	[    0.000000] ------------[ cut here ]------------
	[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/trace/ftrace.c:2066 ftrace_bug+0x240/0x268
	[    0.000000] Modules linked in:
	[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.12.0-rc2-00002-gcb8fe87aa3fa-dirty #12
	[    0.000000] Hardware name: Generic DT based system
	[    0.000000] Backtrace:
	[    0.000000] [<c1afd8c4>] (dump_backtrace) from [<c1afdca4>] (show_stack+0x20/0x24)
	[    0.000000]  r7:c2e13c1c r6:600000d3 r5:00000000 r4:c2e13c1c
	[    0.000000] [<c1afdc84>] (show_stack) from [<c1b04c94>] (dump_stack+0xf4/0x124)
	[    0.000000] [<c1b04ba0>] (dump_stack) from [<c035f33c>] (__warn+0xfc/0x128)
	[    0.000000]  r10:c2d0908c r9:00000000 r8:00000009 r7:00000812 r6:00000009 r5:c1b01c78
	[    0.000000]  r4:c27d0f70 r3:c2d08f50
	[    0.000000] [<c035f240>] (__warn) from [<c1afee14>] (warn_slowpath_fmt+0x74/0xd0)
	[    0.000000]  r7:c1b01c78 r6:00000812 r5:c27d0f70 r4:00000000
	[    0.000000] [<c1afeda4>] (warn_slowpath_fmt) from [<c1b01c78>] (ftrace_bug+0x240/0x268)
	[    0.000000]  r8:c0312eac r7:c362f518 r6:ffffffea r5:c2b00350 r4:c3817ac4
	[    0.000000] [<c1b01a38>] (ftrace_bug) from [<c046316c>] (ftrace_process_locs+0x2b0/0x518)
	[    0.000000]  r7:c3817ac4 r6:c38040c0 r5:00000a3c r4:000134e4
	[    0.000000] [<c0462ebc>] (ftrace_process_locs) from [<c2b25240>] (ftrace_init+0xc8/0x174)
	[    0.000000]  r10:c2ffa000 r9:c2be8a78 r8:c2c5d1fc r7:c2c0c208 r6:00000001 r5:c2d0908c
	[    0.000000]  r4:c362f518
	[    0.000000] [<c2b25178>] (ftrace_init) from [<c2b00e14>] (start_kernel+0x2f4/0x5b8)
	[    0.000000]  r9:c2be8a78 r8:dbfffec0 r7:00000000 r6:c36385cc r5:c2d08f00 r4:c2ffa000
	[    0.000000] [<c2b00b20>] (start_kernel) from [<00000000>] (0x0)
	[    0.000000]  r10:10c5387d r9:412fc0f1 r8:48000000 r7:ffffffff r6:10c0387d r5:00000051
	[    0.000000]  r4:c2b00330
	[    0.000000] irq event stamp: 0
	[    0.000000] hardirqs last  enabled at (0): [<00000000>] 0x0
	[    0.000000] hardirqs last disabled at (0): [<00000000>] 0x0
	[    0.000000] softirqs last  enabled at (0): [<00000000>] 0x0
	[    0.000000] softirqs last disabled at (0): [<00000000>] 0x0
	[    0.000000] random: get_random_bytes called from print_oops_end_marker+0x34/0xa0 with crng_init=0
	[    0.000000] ---[ end trace 0000000000000000 ]---
	[    0.000000] ftrace: allocated 243 pages with 6 groups


> diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
> index 9a79ef6..fa867a5 100644
> --- a/arch/arm/kernel/ftrace.c
> +++ b/arch/arm/kernel/ftrace.c
> @@ -70,6 +70,19 @@ int ftrace_arch_code_modify_post_process(void)
>  
>  static unsigned long ftrace_call_replace(unsigned long pc, unsigned long addr)
>  {
> +	s32 offset = addr - pc;
> +	s32 blim = 0xfe000008;
> +	s32 flim = 0x02000004;

This look like magic numbers to me..

> +
> +	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
> +		blim = 0xff000004;
> +		flim = 0x01000002;

.. ditto ..

> +	}
> +
> +	if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS) &&
> +	    (offset < blim || offset > flim))
> +		return 0;

.. I could have missed something, but wouldn't something like below be clearer?
Only compile tested. I think abs() will do the right thing here given the
passed types. I admit I don't understand why you have the '4' and '8' at the
lowest nibble..

	diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
	index fa867a57100f..b44aee87c53a 100644
	--- a/arch/arm/kernel/ftrace.c
	+++ b/arch/arm/kernel/ftrace.c
	@@ -70,17 +70,13 @@ int ftrace_arch_code_modify_post_process(void)

	 static unsigned long ftrace_call_replace(unsigned long pc, unsigned long addr)
	 {
	-       s32 offset = addr - pc;
	-       s32 blim = 0xfe000008;
	-       s32 flim = 0x02000004;
	+       u32 offset = abs(addr - pc);
	+       u32 range = 0x02000000; /* +-32MiB */

	-       if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
	-               blim = 0xff000004;
	-               flim = 0x01000002;
	-       }
	+       if (IS_ENABLED(CONFIG_THUMB2_KERNEL))
	+               range = 0x01000000; /* +-16MiB */

	-       if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS) &&
	-           (offset < blim || offset > flim))
	+       if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS) && offset > range)
			return 0;

		return arm_gen_branch_link(pc, addr);

In case CONFIG_ARM_MODULE_PLTS is not enabled what would happen? Is it
impossible to hit this corner case or we could fail one way or another? IOW,
should this check be always compiled in?

> +
>  	return arm_gen_branch_link(pc, addr);
>  }
>  
> @@ -124,10 +137,22 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>  {
>  	unsigned long new, old;
>  	unsigned long ip = rec->ip;
> +	unsigned long aaddr = adjust_address(rec, addr);
>  
>  	old = ftrace_nop_replace(rec);
>  
> -	new = ftrace_call_replace(ip, adjust_address(rec, addr));
> +	new = ftrace_call_replace(ip, aaddr);
> +
> +#ifdef CONFIG_ARM_MODULE_PLTS
> +	if (!new) {
> +		struct module *mod = rec->arch.mod;
> +
> +		if (mod) {

What would happen if !new and !mod?

> +			aaddr = get_module_plt(mod, ip, aaddr);
> +			new = ftrace_call_replace(ip, aaddr);

I assume we're guaranteed to have a sensible value returned in 'new' here?

Thanks

--
Qais Yousef

> +		}
> +	}
> +#endif
