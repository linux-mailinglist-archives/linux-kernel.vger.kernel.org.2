Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173F04502BD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237615AbhKOKrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 05:47:20 -0500
Received: from foss.arm.com ([217.140.110.172]:53698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237490AbhKOKrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:47:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 365081FB;
        Mon, 15 Nov 2021 02:44:20 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.56.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2E473F70D;
        Mon, 15 Nov 2021 02:44:18 -0800 (PST)
Date:   Mon, 15 Nov 2021 10:44:11 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Qian Cai <quic_qiancai@quicinc.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: KASAN + CPU soft-hotplug = stack-out-of-bounds at
 cpuinfo_store_cpu
Message-ID: <YZI5+83nxZzo00Dy@FVFF77S0Q05N>
References: <YY9ECKyPtDbD9q8q@qian-HP-Z2-SFF-G5-Workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YY9ECKyPtDbD9q8q@qian-HP-Z2-SFF-G5-Workstation>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 12, 2021 at 11:50:16PM -0500, Qian Cai wrote:
> FYI, running CPU soft-hotplug with KASAN on arm64 defconfig will
> always trigger a stack-out-of-bounds below. I am not right sure where
> exactly KASAN pointed at, so I am just doing the brute-force
> bisect. The progress so far:

From below it looks like this is on linux-next; I can reproduce this on
v5.16-rc1 using your config, when hotplugging CPU0 back in.

We used to have issues with stale poison being left on the stack across a
hotplug, and we fixed that with commit:

  e1b77c92981a5222 ("sched/kasan: remove stale KASAN poison after hotplug")

... but it looks like we no longer call init_idle() for each hotplug since commit:

  f1a0a376ca0c4ef1 ("sched/core: Initialize the idle task with preemption disabled")

... and so don't get the kasan_unpoison_task_stack() call which we want when
bringing up a CPU, which we used to get by way of idle_thread_get() calling init_idle().

Adding a call to kasan_unpoison_task_stack(idle) within bringup_cpu() gets rid
of that, and I reckon we want that explciitly *somewhere* on the CPU bringup
path.

Thanks,
Mark.

> # git bisect log
> git bisect start
> # bad: [e73f0f0ee7541171d89f2e2491130c7771ba58d3] Linux 5.14-rc1
> git bisect bad e73f0f0ee7541171d89f2e2491130c7771ba58d3
> # good: [62fb9874f5da54fdb243003b386128037319b219] Linux 5.13
> git bisect good 62fb9874f5da54fdb243003b386128037319b219
> # bad: [e058a84bfddc42ba356a2316f2cf1141974625c9] Merge tag 'drm-next-2021-07-01' of git://anongit.freedesktop.org/drm/drm
> git bisect bad e058a84bfddc42ba356a2316f2cf1141974625c9
> # bad: [a6eaf3850cb171c328a8b0db6d3c79286a1eba9d] Merge tag 'sched-urgent-2021-06-30' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad a6eaf3850cb171c328a8b0db6d3c79286a1eba9d
> # bad: [31e798fd6f0ff0acdc49c1a358b581730936a09a] Merge tag 'media/v5.14-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
> git bisect bad 31e798fd6f0ff0acdc49c1a358b581730936a09a
> 
> I am going to test the "arm64-upstream" merge request next which has
> some interesting arm64/cpuinfo patches.
> 
>  BUG: KASAN: stack-out-of-bounds in vsnprintf
>  Read of size 8 at addr ffff800016297db8 by task swapper/0/0

> 
>  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15.0-next-20211110 #157
>  Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
>  Call trace:
>   dump_backtrace
>   show_stack
>   dump_stack_lvl
>   print_address_description.constprop.0
>   kasan_report
>   __asan_report_load8_noabort
>   vsnprintf
>   vsnprintf at /root/linux-next/lib/vsprintf.c:2807
>   vprintk_store
>   vprintk_store at /root/linux-next/kernel/printk/printk.c:2138 (discriminator 5)
>   vprintk_emit
>   vprintk_emit at /root/linux-next/kernel/printk/printk.c:2232
>   vprintk_default
>   vprintk_default at /root/linux-next/kernel/printk/printk.c:2260
>   vprintk
>   vprintk at /root/linux-next/kernel/printk/printk_safe.c:50
>   _printk
>   printk at /root/linux-next/kernel/printk/printk.c:2264
>   __cpuinfo_store_cpu
>   __cpuinfo_store_cpu at /root/linux-next/arch/arm64/kernel/cpuinfo.c:412
>   cpuinfo_store_cpu
>   cpuinfo_store_cpu at /root/linux-next/arch/arm64/kernel/cpuinfo.c:418
>   secondary_start_kernel
>   secondary_start_kernel at /root/linux-next/arch/arm64/kernel/smp.c:241
>   __secondary_switched
> 
> 
>  addr ffff800016297db8 is located in stack of task swapper/0/0 at offset 136 in frame:
>   _printk
> 
>  this frame has 1 object:
>   [32, 64) 'args'
> 
>  Memory state around the buggy address:
>   ffff800016297c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   ffff800016297d00: 00 00 00 00 00 00 f1 f1 f1 f1 00 00 00 00 f3 f3
>  >ffff800016297d80: f3 f3 00 00 00 00 f3 f3 00 00 00 00 00 00 00 00
>                                          ^
>   ffff800016297e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   ffff800016297e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
