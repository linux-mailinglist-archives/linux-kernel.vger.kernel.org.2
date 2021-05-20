Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FFF38A0BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 11:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhETJWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 05:22:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:43494 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230483AbhETJWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 05:22:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CC6A3AD4B;
        Thu, 20 May 2021 09:21:11 +0000 (UTC)
Date:   Thu, 20 May 2021 11:21:04 +0200
From:   Borislav Petkov <bp@suse.de>
To:     James Feeney <james@nurealm.net>
Cc:     linux-smp@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: linux 5.12 - fails to boot - soft lockup - CPU#0 stuck for 23s!
 - RIP smp_call_function_single
Message-ID: <YKYqABhSTTUG8cgV@zn.tnic>
References: <8a9599b2-f4fe-af9b-90f5-af39c315ec2f@nurealm.net>
 <YKIqDdFNaXYd39wz@zn.tnic>
 <1876afbe-a167-2be5-3690-846700eeb76c@nurealm.net>
 <YKTygvN0QNlExEQP@zn.tnic>
 <984ee4ab-6e6b-cb0e-a4f1-ce2951994b1d@nurealm.net>
 <YKWAt1zLM2vfv4Sp@zn.tnic>
 <e7701de5-35f3-da9d-7339-df2de6d8b3cf@nurealm.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7701de5-35f3-da9d-7339-df2de6d8b3cf@nurealm.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 09:12:04PM -0600, James Feeney wrote:

> $ diff .config .config.old
> 4983c4983,4984
> < # CONFIG_X86_THERMAL_VECTOR is not set
> ---
> > CONFIG_X86_THERMAL_VECTOR=y
> > CONFIG_X86_PKG_TEMP_THERMAL=m
>
> No joy. Still have the same soft lockups and full boots - the full
> boots interrupted by some mystery delay.

Which means, even with therm_throt disabled, it still locks up. Which
can't be caused by my patch.

> I don't know about these patches, modifying and moving the location of
> therm_throt.c, so I'm not in a position to draw any conclusion from
> these results.

They're just moving the thermal interrupt functionality from the
MCE code where they don't belong to the thermal code where they do.
Otherwise there should be no change.

> build 5.11? There are lots of 5.11 kernels from the Arch distribution
> that I have run. Are you looking for a dmesg log from 5.11?

Take the .config you're normally using, make sure it has

CONFIG_X86_THERMAL_VECTOR=y

and build with it plain 5.11 kernel. No patches ontop, no nothing.

Then add

debug ignore_loglevel log_buf_len=16M no_console_suspend systemd.log_target=null console=ttyS0,115200 console=tty0

to its kernel command line and send me full dmesg again pls.

Looking how it sometimes boots and sometimes it locks up, try that a
couple of times.

> So far, something looks quirky - somewhere. Timing related failures
> can be a pain. Is there no useful information being provided by the
> Call Trace in the dmesg log?

What I'm seeing is that *sometimes* - not always - your CPU0 is not
responding to the TLB flush IPI. Which is really weird. Have you had
those always or did they start appearing with 5.12?

That's why I'm still scratching my head over how my patch would cause
CPU0 not responding to IPIs.

Well, *maybe* there's a little difference which my patch did: it does
that APIC_LVTTHMR only on the BSP. And *maybe* there's a problem there,
who knows with those old CPUs.

So here's two more things to try:

1. On plain 5.12, with the same kernel cmdline params add also

"idle=nomwait"

to the kernel command line and boot with it a couple of times to see
whether it still locks up.

2. On plain 5.12, with the same kernel cmdline params apply this hunk
ontop:

---
diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index f8e882592ba5..42db48cd4666 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -630,9 +630,8 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
 	if (!intel_thermal_supported(c))
 		return;
 
-	/* On the BSP? */
-	if (c == &boot_cpu_data)
-		lvtthmr_init = apic_read(APIC_LVTTHMR);
+	lvtthmr_init = apic_read(APIC_LVTTHMR);
+	pr_info("%s: CPU%d, lvtthmr_init: 0x%x\n", __func__, cpu, lvtthmr_init);
 
 	/*
 	 * First check if its enabled already, in which case there might
---

That'll tell us the thermal sensor LVT on both CPUs.

Also do that a couple of times - it'll be interesting to see what those
values are *when* the box locks up.

As always, catch full dmesg each time pls.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
