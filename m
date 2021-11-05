Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A21B446778
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbhKERDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:03:14 -0400
Received: from foss.arm.com ([217.140.110.172]:33648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234142AbhKERDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:03:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E6AA2F;
        Fri,  5 Nov 2021 10:00:30 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6A103F7F5;
        Fri,  5 Nov 2021 10:00:28 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Yafang Shao <laoar.shao@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [RFC PATCH 0/4] sched: Introduce cfs_migration
In-Reply-To: <20211104145713.4419-1-laoar.shao@gmail.com>
References: <20211104145713.4419-1-laoar.shao@gmail.com>
Date:   Fri, 05 Nov 2021 17:00:22 +0000
Message-ID: <87cznetu55.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 04/11/21 14:57, Yafang Shao wrote:
> The active load balance has a known issue[1][2] that there is a race
> window between waking up the migration thread on the busiest CPU and it
> begins to preempt the current running CFS task. This race window may cause
> unexpected behavior that the current running CFS task may be preempted
> by a RT task first, and then the RT task will be preempted by this
> waked migration thread. Per our tracing, the latency caused by this
> preemption can be greater than 1ms, which is not a small latency for the
> RT tasks.
>
> We'd better set a proper priority to this balance work so that it can
> preempt CFS task only. A new per-cpu thread cfs_migration is introduced
> for this purpose. The cfs_migration thread has a priority FIFO-1,
> which means it can preempt any cfs tasks but can't preempt other FIFO
> tasks.
>
> Besides the active load balance work, the numa balance work also applies
> to CFS tasks only. So we'd better assign cfs_migraion to numa balance
> work as well.
>
> [1]. https://lore.kernel.org/lkml/CAKfTPtBygNcVewbb0GQOP5xxO96am3YeTZNP5dK9BxKHJJAL-g@mail.gmail.com/
> [2]. https://lore.kernel.org/lkml/20210615121551.31138-1-laoar.shao@gmail.com/
>

So overall I quite like the idea, but am not entirely convinced by the
implementation. See comments in rest of the thread - in any case, thanks
for taking a jab at that!

> Yafang Shao (4):
>   stop_machine: Move cpu_stop_done into stop_machine.h
>   sched/fair: Introduce cfs_migration
>   sched/fair: Do active load balance in cfs_migration
>   sched/core: Do numa balance in cfs_migration
>
>  include/linux/stop_machine.h |  12 +++
>  kernel/sched/core.c          |   2 +-
>  kernel/sched/fair.c          | 143 ++++++++++++++++++++++++++++++++++-
>  kernel/sched/sched.h         |   2 +
>  kernel/stop_machine.c        |  14 +---
>  5 files changed, 158 insertions(+), 15 deletions(-)
>
> --
> 2.17.1
