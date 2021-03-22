Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0075A343D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 11:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhCVKQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:16:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:43860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230125AbhCVKQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:16:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 50B9BAD38;
        Mon, 22 Mar 2021 10:16:00 +0000 (UTC)
Date:   Mon, 22 Mar 2021 10:15:57 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     vincent.guittot@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com,
        valentin.schneider@arm.com, aubrey.li@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xuwei5@huawei.com, prime.zeng@hisilicon.com, guodong.xu@linaro.org,
        yangyicong@huawei.com, liguozhu@hisilicon.com,
        linuxarm@openeuler.org
Subject: Re: [PATCH] sched/fair: remove redundant test_idle_cores for non-smt
Message-ID: <20210322101556.GK15768@suse.de>
References: <20210320221432.924-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210320221432.924-1-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2021 at 11:14:32AM +1300, Barry Song wrote:
> update_idle_core() is only done for the case of sched_smt_present.
> but test_idle_cores() is done for all machines even those without
> smt.
> this could contribute to up 8%+ hackbench performance loss on a
> machine like kunpeng 920 which has no smt. this patch removes the
> redundant test_idle_cores() for non-smt machines.
> 
> we run the below hackbench with different -g parameter from 2 to
> 14, for each different g, we run the command 10 times and get the
> average time:
> $ numactl -N 0 hackbench -p -T -l 20000 -g $1
> 
> hackbench will report the time which is needed to complete a certain
> number of messages transmissions between a certain number of tasks,
> for example:
> $ numactl -N 0 hackbench -p -T -l 20000 -g 10
> Running in threaded mode with 10 groups using 40 file descriptors each
> (== 400 tasks)
> Each sender will pass 20000 messages of 100 bytes
> 
> The below is the result of hackbench w/ and w/o this patch:
> g=    2      4     6       8      10     12      14
> w/o: 1.8151 3.8499 5.5142 7.2491 9.0340 10.7345 12.0929
> w/ : 1.8428 3.7436 5.4501 6.9522 8.2882  9.9535 11.3367
>                           +4.1%  +8.3%  +7.3%   +6.3%
> 
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>

Acked-by: Mel Gorman <mgorman@suse.de>

That said, the numa_idle_core() function then becomes slightly
redundant.  A possible follow up is to move the "idle_core >= 0" check
in numa_idle_core() to its caller in update_numa_stats() and then remove
the redundant check in !static_branch_likely(&sched_smt_present) check
in numa_idle_core.

-- 
Mel Gorman
SUSE Labs
