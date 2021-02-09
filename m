Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB33315739
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 20:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhBITwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 14:52:45 -0500
Received: from foss.arm.com ([217.140.110.172]:55200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233284AbhBISUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 13:20:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF8F6106F;
        Tue,  9 Feb 2021 10:19:46 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CBD63F73B;
        Tue,  9 Feb 2021 10:19:45 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 7/8] sched/fair: Attempt misfit active balance when migration_type != migrate_misfit
In-Reply-To: <CAKfTPtBSkg2tBH5U+GvRWHBe3qxCqdB3w6WPJsZPADDbVQCc0w@mail.gmail.com>
References: <20210128183141.28097-1-valentin.schneider@arm.com> <20210128183141.28097-8-valentin.schneider@arm.com> <CAKfTPtBSkg2tBH5U+GvRWHBe3qxCqdB3w6WPJsZPADDbVQCc0w@mail.gmail.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Tue, 09 Feb 2021 18:19:43 +0000
Message-ID: <jhjlfbxt874.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/21 09:58, Vincent Guittot wrote:
> On Thu, 28 Jan 2021 at 19:32, Valentin Schneider
>> Giving group_misfit_task a higher group_classify() priority than
>> group_imbalance doesn't seem like the right thing to do. Instead, make
>
> Could you explain why ?
>

Morten had intentionally placed it above (then) group_other but below
group_imbalanced:

  3b1baa6496e6 ("sched/fair: Add 'group_misfit_task' load-balance type")

The reasoning being misfit balance shouldn't take higher priority than
jarring imbalance issues. group_imbalanced is a mixed bag and difficult to
classify, but for sure group_overloaded takes priority as it ought to imply
you can move tasks around without doing an active balance (there's more
tasks than CPUs).

Then again, we do have issues where the busiest group is group_overloaded,
but we'd "want" this to be classified as misfit. This ties in with patch 8.

Take the CPU hog vs pcpu kworker example on a big.LITTLE platform:

  a,b,c,d are our CPU-hogging tasks
  k is a per-CPU kworker

        {CPU0 | a a a a k
  LITTLE{CPU1 | b b b b a
        ------|---------
        {CPU2 | c c c c .
  bigs  {CPU3 | d d d d ^
                        |
                        |
                  newidle pull

CPU2 finished its work and goes through a newidle balance. Ideally here it
would pull either 'a' or 'b' which are CPU-bound tasks running on LITTLE
CPUs. Unfortunately, a per-CPU kworker woke up on CPU0, so since we have:

  DIE [        ]
  MC  [   ][   ]
       0 1  2 3

the DIE (0-1) sched_group has 3 runnable tasks, two of which are CPU hogs:
it gets classified as group_overloaded. Only task 'a' can be pulled, and it
requires patch 8 to be migrated in this scenario.


I'm not sure how we could better classify this, even if admitting we
started tracking preempted misfit tasks. Perhaps not group classification
itself, but the migration_type? i.e. something like

  if (nr_running - sgs->group_weight <= nr_misfits)
  => all preempted tasks are misfit
  => migration_type = migrate_misfit
