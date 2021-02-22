Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56B0321EA7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 18:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhBVR7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 12:59:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230398AbhBVR7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 12:59:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D238064E15;
        Mon, 22 Feb 2021 17:58:28 +0000 (UTC)
Date:   Mon, 22 Feb 2021 17:58:26 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v13 4/7] arm64: mte: Enable TCO in functions that can
 read beyond buffer limits
Message-ID: <20210222175825.GE19604@arm.com>
References: <20210211153353.29094-1-vincenzo.frascino@arm.com>
 <20210211153353.29094-5-vincenzo.frascino@arm.com>
 <20210212172128.GE7718@arm.com>
 <c3d565da-c446-dea2-266e-ef35edabca9c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3d565da-c446-dea2-266e-ef35edabca9c@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 12:08:07PM +0000, Vincenzo Frascino wrote:
> On 2/12/21 5:21 PM, Catalin Marinas wrote:
> >> +
> >> +	/*
> >> +	 * This function is called on each active smp core at boot
> >> +	 * time, hence we do not need to take cpu_hotplug_lock again.
> >> +	 */
> >> +	static_branch_enable_cpuslocked(&mte_async_mode);
> >>  }
> > Sorry, I missed the cpuslocked aspect before. Is there any reason you
> > need to use this API here? I suggested to add it to the
> > mte_enable_kernel_sync() because kasan may at some point do this
> > dynamically at run-time, so the boot-time argument doesn't hold. But
> > it's also incorrect as this function will be called for hot-plugged
> > CPUs as well after boot.
> > 
> > The only reason for static_branch_*_cpuslocked() is if it's called from
> > a region that already invoked cpus_read_lock() which I don't think is
> > the case here.
> 
> I agree with your analysis on why static_branch_*_cpuslocked() is needed, in
> fact cpus_read_lock() takes cpu_hotplug_lock as per comment on top of the line
> of code.
> 
> If I try to take that lock when enabling the secondary cores I end up in the
> situation below:
> 
> [    0.283402] smp: Bringing up secondary CPUs ...
> ....
> [    5.890963] Call trace:
> [    5.891050]  dump_backtrace+0x0/0x19c
> [    5.891212]  show_stack+0x18/0x70
> [    5.891373]  dump_stack+0xd0/0x12c
> [    5.891531]  dequeue_task_idle+0x28/0x40
> [    5.891686]  __schedule+0x45c/0x6c0
> [    5.891851]  schedule+0x70/0x104
> [    5.892010]  percpu_rwsem_wait+0xe8/0x104
> [    5.892174]  __percpu_down_read+0x5c/0x90
> [    5.892332]  percpu_down_read.constprop.0+0xbc/0xd4
> [    5.892497]  cpus_read_lock+0x10/0x1c
> [    5.892660]  static_key_enable+0x18/0x3c
> [    5.892823]  mte_enable_kernel_async+0x40/0x70
> [    5.892988]  kasan_init_hw_tags_cpu+0x50/0x60
> [    5.893144]  cpu_enable_mte+0x24/0x70
> [    5.893304]  verify_local_cpu_caps+0x58/0x120
> [    5.893465]  check_local_cpu_capabilities+0x18/0x1f0
> [    5.893626]  secondary_start_kernel+0xe0/0x190
> [    5.893790]  0x0
> [    5.893975] bad: scheduling from the idle thread!
> [    5.894065] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W
> 5.11.0-rc7-10587-g22cd50bcfcf-dirty #6
> 
> and the kernel panics.

That's because cpu_hotplug_lock is not a spinlock but a semaphore which
implies sleeping. I don't think avoiding taking this semaphore
altogether (as in the *_cpuslocked functions) is the correct workaround.

The mte_enable_kernel_async() function is called on each secondary CPU
but we don't really need to attempt to toggle the static key on each of
them as they all have the same configuration. Maybe do something like:

	if (!static_branch_unlikely(&mte_async_mode)))
		static_branch_enable(&mte_async_mode);

so that it's only set on the boot CPU.

The alternative is to use a per-CPU mask/variable instead of static
branches but it's probably too expensive for those functions that were
meant to improve performance.

We'll still have an issue with dynamically switching the async/sync mode
at run-time. Luckily kasan doesn't do this now. The problem is that
until the last CPU have been switched from async to sync, we can't
toggle the static label. When switching from sync to async, we need
to do it on the first CPU being switched.

So, I think currently we can set the mte_async_mode label to true in
mte_enable_kernel_async(), with the 'if' check above. For
mte_enable_kernel_sync(), don't bother with setting the key to false but
place a WARN_ONCE if the mte_async_mode is true. We can revisit it if
kasan ever gains this run-time switch mode.

-- 
Catalin
