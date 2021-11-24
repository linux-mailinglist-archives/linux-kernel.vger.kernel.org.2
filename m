Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA8345CAB2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 18:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349632AbhKXROt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 12:14:49 -0500
Received: from foss.arm.com ([217.140.110.172]:41276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236272AbhKXROp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 12:14:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FA2A1FB;
        Wed, 24 Nov 2021 09:11:35 -0800 (PST)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60C593F66F;
        Wed, 24 Nov 2021 09:11:34 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        dietmar.eggemann@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: Re: [PATCH] sched/fair: Fix per-CPU kthread and wakee stacking for asym CPU capacity
In-Reply-To: <20211124141435.3125147-1-vincent.donnefort@arm.com>
References: <20211124141435.3125147-1-vincent.donnefort@arm.com>
Date:   Wed, 24 Nov 2021 17:11:32 +0000
Message-ID: <87fsrlcwcb.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/21 14:14, Vincent Donnefort wrote:
> A shortcut has been introduced in select_idle_sibling() to return prev_cpu
> if the wakee is woken up by a per-CPU kthread. This is an issue for
> asymmetric CPU capacity systems where the wakee might not fit prev_cpu
> anymore. Evaluate asym_fits_capacity() for prev_cpu before using that
> shortcut.
>
> Fixes: 52262ee567ad ("sched/fair: Allow a per-CPU kthread waking a task to stack on the same CPU, to fix XFS performance regression")

Shouldn't that rather be

  b4c9c9f15649 ("sched/fair: Prefer prev cpu in asymmetric wakeup path")

? This is an ulterior commit to the one you point to, and before then
asymmetric CPU systems wouldn't use any of the sis() heuristics.

I reportedly reviewed said commit back then, and don't recall anything
specific about that conditional... The cover-letter for v2 states:

  https://lore.kernel.org/lkml/20201028174412.680-1-vincent.guittot@linaro.org/
  """
  don't check capacity for the per-cpu kthread UC because the assumption is
  that the wakee queued work for the per-cpu kthread that is now complete and
  the task was already on this cpu.
  """

So the assumption here is that current is gonna sleep right after waking up
p, so current's utilization doesn't matter, and p was already on prev, so
it should fit there...

I'm thinking things should actually be OK with your other patch that
excludes 'current == swapper' from this condition.

> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6291876a9d32..b90dc6fd86ca 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6410,7 +6410,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>        */
>       if (is_per_cpu_kthread(current) &&
>           prev == smp_processor_id() &&
> -	    this_rq()->nr_running <= 1) {
> +	    this_rq()->nr_running <= 1 &&
> +	    asym_fits_capacity(task_util, prev)) {
>               return prev;
>       }
>
> --
> 2.25.1
