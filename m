Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655FA450608
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhKONy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 08:54:28 -0500
Received: from foss.arm.com ([217.140.110.172]:55546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231926AbhKONxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 08:53:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 203806D;
        Mon, 15 Nov 2021 05:50:46 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.26.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E57CD3F766;
        Mon, 15 Nov 2021 05:50:44 -0800 (PST)
Date:   Mon, 15 Nov 2021 13:50:39 +0000
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
Message-ID: <YZJlr50XQExl7NUg@FVFF77S0Q05N.cambridge.arm.com>
References: <YY9ECKyPtDbD9q8q@qian-HP-Z2-SFF-G5-Workstation>
 <YZI5+83nxZzo00Dy@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZI5+83nxZzo00Dy@FVFF77S0Q05N>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 10:44:11AM +0000, Mark Rutland wrote:
> Hi,
> 
> On Fri, Nov 12, 2021 at 11:50:16PM -0500, Qian Cai wrote:
> > FYI, running CPU soft-hotplug with KASAN on arm64 defconfig will
> > always trigger a stack-out-of-bounds below. I am not right sure where
> > exactly KASAN pointed at, so I am just doing the brute-force
> > bisect. The progress so far:
> 
> From below it looks like this is on linux-next; I can reproduce this on
> v5.16-rc1 using your config, when hotplugging CPU0 back in.
> 
> We used to have issues with stale poison being left on the stack across a
> hotplug, and we fixed that with commit:
> 
>   e1b77c92981a5222 ("sched/kasan: remove stale KASAN poison after hotplug")
> 
> ... but it looks like we no longer call init_idle() for each hotplug since commit:
> 
>   f1a0a376ca0c4ef1 ("sched/core: Initialize the idle task with preemption disabled")
> 
> ... and so don't get the kasan_unpoison_task_stack() call which we want when
> bringing up a CPU, which we used to get by way of idle_thread_get() calling init_idle().
> 
> Adding a call to kasan_unpoison_task_stack(idle) within bringup_cpu() gets rid
> of that, and I reckon we want that explciitly *somewhere* on the CPU bringup
> path.

FWIW I sent that out as a patch:

https://lore.kernel.org/linux-arm-kernel/20211115113310.35693-1-mark.rutland@arm.com/

Thanks,
Mark.
