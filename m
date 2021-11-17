Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8795B454601
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 12:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbhKQLzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 06:55:39 -0500
Received: from foss.arm.com ([217.140.110.172]:55764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237051AbhKQLzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 06:55:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B860ED1;
        Wed, 17 Nov 2021 03:52:38 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.46.245])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88A5A3F70D;
        Wed, 17 Nov 2021 03:52:36 -0800 (PST)
Date:   Wed, 17 Nov 2021 11:52:34 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, dvyukov@google.com, peterz@infradead.org,
        valentin.schneider@arm.com, will@kernel.org, woodylin@google.com
Subject: Re: [PATCH] Reset task stack state in bringup_cpu()
Message-ID: <20211117115234.GB41542@C02TD0UTHF1T.local>
References: <20211115113310.35693-1-mark.rutland@arm.com>
 <YZPc7MLxwmd47YYw@qian-HP-Z2-SFF-G5-Workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZPc7MLxwmd47YYw@qian-HP-Z2-SFF-G5-Workstation>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 11:31:40AM -0500, Qian Cai wrote:
> On Mon, Nov 15, 2021 at 11:33:10AM +0000, Mark Rutland wrote:
> > To hot unplug a CPU, the idle task on that CPU calls a few layers of C
> > code before finally leaving the kernel. When KASAN is in use, poisoned
> > shadow is left around for each of the active stack frames, and when
> > shadow call stacks are in use. When shadow call stacks are in use the
> > task's SCS SP is left pointing at an arbitrary point within the task's
> > shadow call stack.
> > 
> > When an offlines CPU is hotlpugged back into the kernel, this stale
> > state can adversely affect the newly onlined CPU. Stale KASAN shadow can
> > alias new stackframes and result in bogus KASAN warnings. A stale SCS SP
> > is effectively a memory leak, and prevents a portion of the shadow call
> > stack being used. Across a number of hotplug cycles the task's entire
> > shadow call stack can become unusable.
> > 
> > We previously fixed the KASAN issue in commit:
> > 
> >   e1b77c92981a5222 ("sched/kasan: remove stale KASAN poison after hotplug")
> > 
> > In commit:
> > 
> >   f1a0a376ca0c4ef1 ("sched/core: Initialize the idle task with preemption disabled")
> > 
> > ... we broke both KASAN and SCS, with SCS being fixed up in commit:
> > 
> >   63acd42c0d4942f7 ("sched/scs: Reset the shadow stack when idle_task_exit")
> > 
> > ... but as this runs in the context of the idle task being offlines it's
> > potentially fragile.
> > 
> > Fix both of these consistently and more robustly by resetting the SCS SP
> > and KASAN shadow immediately before we online a CPU. This ensures the
> > idle task always has a consistent state, and removes the need to do so
> > when initializing an idle task or when unplugging an idle task.
> > 
> > I've tested this with both GCC and clang, with reelvant options enabled,
> > offlining and online CPUs with:
> > 
> > | while true; do
> > |   for C in /sys/devices/system/cpu/cpu*/online; do
> > |     echo 0 > $C;
> > |     echo 1 > $C;
> > |   done
> > | done
> > 
> > Link: https://lore.kernel.org/lkml/20211012083521.973587-1-woodylin@google.com/
> > Link: https://lore.kernel.org/linux-arm-kernel/YY9ECKyPtDbD9q8q@qian-HP-Z2-SFF-G5-Workstation/
> > Fixes: 1a0a376ca0c4ef1 ("sched/core: Initialize the idle task with preemption disabled")
> > Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> 
> Thanks for fixing this quickly, Mark. Triggering an user-after-free in
> user namespace but don't think it is related. I'll investigate that
> first since it is blocking the rest of regression testing.

Cool; are you happy to provide a Tested-by tag for this patch? :)

Thanks,
Mark.
