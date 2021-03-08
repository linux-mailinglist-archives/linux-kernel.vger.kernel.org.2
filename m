Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6D9330947
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 09:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhCHISW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 03:18:22 -0500
Received: from foss.arm.com ([217.140.110.172]:33774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231592AbhCHISN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:18:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0282D31B;
        Mon,  8 Mar 2021 00:18:13 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51CAC3F70D;
        Mon,  8 Mar 2021 00:18:11 -0800 (PST)
Subject: Re: [RFC PATCH] sched: Simplify leaf_cfs_rq_list maintenance
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20210225162757.48858-1-mkoutny@suse.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <09e6a72d-5bdf-abab-b45d-cad733e93100@arm.com>
Date:   Mon, 8 Mar 2021 09:18:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210225162757.48858-1-mkoutny@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On 25/02/2021 17:27, Michal Koutný wrote:
> leaf_cfs_rq_list should contain cfs_rqs that have runnable entities in
> them.  When we're operating under a throttled hierarchy we always update
> the leaf_cfs_rq_list in order no to break list_add_leaf_cfs_rq invariant
> of adding complete branches.

So this patch replaces in enqueue_entity() the unconditional
list_add_leaf_cfs_rq(cfs_rq) in case cfs->nr_running > 1
(parent had been throttled) 

- if (cfs_rq->nr_running == 1 || cfs_bandwidth_used())
                              ^^^^^^^^^^^^^^^^^^^^^^^
with

+ if (cfs_rq->nr_running == 1 && !throttled_hierarchy(cfs_rq))
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

and removes the leaf_cfs_rq_list maintenance code after the
xxx_throttle label in enqueue_task_fair() and unthrottle_cfs_rq
from commit f6783319737f ("sched/fair: Fix insertion in
rq->leaf_cfs_rq_list") and fe61468b2cb ("sched/fair: Fix
enqueue_task_fair warning").

> This caused troubles when an entity became runnable (enqueue_entity)
> under a throttled hierarchy (see commit b34cb07dde7c ("sched/fair: Fix
> enqueue_task_fair() warning some more")). While it proved well, this
> new change ignores updating leaf_cfs_rq_list when we're operating under
> the throttled hierarchy and defers the leaf_cfs_rq_list update to the
> point when whole hiearchy is unthrottled (tg_unthrottle_up).

IMHO, f6783319737f gives the explanation why throttled cfs_rq's have to
be added to rq->leaf_cfs_rq_list.

IIRC, fe61468b2cb was fixing a use case in which a cfs-rq with
on_list=0 and nr_running > 1 within the cgroup hierarchy wasn't
added back to rq->leaf_cfs_rq_list:

https://lkml.kernel.org/r/15252de5-9a2d-19ae-607a-594ee88d1ba1@de.ibm.com

In enqueue_task_fair() just before the assert_list_leaf_cfs_rq(rq),
Iterate through the se heriarchy of p=[CPU 2/KVM 2662] in case the
assert will hit:

...
CPU23 path=/machine.slice/machine-test.slice/machine-qemu\x2d18\x2dtest10.scope/vcpuX on_list=1 nr_running=1 throttled=0 p=[CPU 2/KVM 2662]
CPU23 path=/machine.slice/machine-test.slice/machine-qemu\x2d18\x2dtest10.scope       on_list=0 nr_running=3 throttled=0 p=[CPU 2/KVM 2662]
                                                                                      ^^^^^^^^^ ^^^^^^^^^^^^
CPU23 path=/machine.slice/machine-test.slice                                          on_list=1 nr_running=1 throttled=1 p=[CPU 2/KVM 2662]
CPU23 path=/machine.slice                                                             on_list=1 nr_running=0 throttled=0 p=[CPU 2/KVM 2662]
CPU23 path=/                                                                          on_list=1 nr_running=1 throttled=0 p=[CPU 2/KVM 2662]
...

> The code is now simpler and leaf_cfs_rq_list contains only cfs_rqs that
> are truly runnable.
> 
> Why is this RFC?
> - Primarily, I'm not sure I interpreted the purpose of leaf_cfs_rq_list
>   right. The removal of throttled cfs_rqs from it would exclude them
>   from __update_blocked_fair() calculation and I can't see past it now.

The leaf_cfs_rq_list should contain all cfs_rqs with
cfs_rq->avg.load/runnable/util_avg != 0 so that in case there are no
runnable entities on them anymore this (blocked) load 
cfs_rq->avg.xxx_avg can be decayed. IMHO. the "leaf_" is misleading
here since it can also contain non-leaf cfs_rqs.

>   If it's wrong assumption, I'd like this to help clarify what the
>   proper definition of leaf_cfs_rq_list would be.
> - Additionally, I didn't check thoroughly for corner cases when
>   se->on_rq => cfs_rq_of(se)->on_list wouldn't hold, so the patch
>   certainly isn't finished.

[...]
