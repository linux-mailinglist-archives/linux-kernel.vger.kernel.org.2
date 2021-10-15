Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3E242F709
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 17:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240972AbhJOPjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 11:39:12 -0400
Received: from foss.arm.com ([217.140.110.172]:44972 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230146AbhJOPjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 11:39:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C10111D4;
        Fri, 15 Oct 2021 08:37:04 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D3F23F66F;
        Fri, 15 Oct 2021 08:37:03 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Nathan Lynch <nathanl@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc:     mpe@ellerman.id.au, srikar@linux.vnet.ibm.com,
        peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, clg@kaod.org
Subject: Re: [PATCH] powerpc/smp: do not decrement idle task preempt count in CPU offline
In-Reply-To: <20211015145548.2269836-1-nathanl@linux.ibm.com>
References: <20211015145548.2269836-1-nathanl@linux.ibm.com>
Date:   Fri, 15 Oct 2021 16:36:57 +0100
Message-ID: <87h7dijo4m.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/21 09:55, Nathan Lynch wrote:
> With PREEMPT_COUNT=y, when a CPU is offlined and then onlined again, we
> get:
>
> BUG: scheduling while atomic: swapper/1/0/0x00000000
> no locks held by swapper/1/0.
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.15.0-rc2+ #100
> Call Trace:
>  dump_stack_lvl+0xac/0x108
>  __schedule_bug+0xac/0xe0
>  __schedule+0xcf8/0x10d0
>  schedule_idle+0x3c/0x70
>  do_idle+0x2d8/0x4a0
>  cpu_startup_entry+0x38/0x40
>  start_secondary+0x2ec/0x3a0
>  start_secondary_prolog+0x10/0x14
>
> This is because powerpc's arch_cpu_idle_dead() decrements the idle task's
> preempt count, for reasons explained in commit a7c2bb8279d2 ("powerpc:
> Re-enable preemption before cpu_die()"), specifically "start_secondary()
> expects a preempt_count() of 0."
>
> However, since commit 2c669ef6979c ("powerpc/preempt: Don't touch the idle
> task's preempt_count during hotplug") and commit f1a0a376ca0c ("sched/core:
> Initialize the idle task with preemption disabled"), that justification no
> longer holds.
>
> The idle task isn't supposed to re-enable preemption, so remove the
> vestigial preempt_enable() from the CPU offline path.
>

Humph, I got confused because 2c669ef6979c explicitly mentions hotplug,
but that's the hotplug machinery which is already involved for bringing up
the secondaries at boot time.

IIUC your issue here is the preempt_count being messed up when
hot-unplugging a CPU, which leads to fireworks during hotplug (IOW I didn't
test my last patch against hotplug - my bad!)

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> Tested with pseries and powernv in qemu, and pseries on PowerVM.
>
> Fixes: 2c669ef6979c ("powerpc/preempt: Don't touch the idle task's preempt_count during hotplug")
> Fixes: f1a0a376ca0c ("sched/core: Initialize the idle task with preemption disabled")

I think only the first Fixes: is needed.

> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
> ---
>  arch/powerpc/kernel/smp.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 9cc7d3dbf439..605bab448f84 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1730,8 +1730,6 @@ void __cpu_die(unsigned int cpu)
>
>  void arch_cpu_idle_dead(void)
>  {
> -	sched_preempt_enable_no_resched();
> -
>       /*
>        * Disable on the down path. This will be re-enabled by
>        * start_secondary() via start_secondary_resume() below
> --
> 2.31.1
