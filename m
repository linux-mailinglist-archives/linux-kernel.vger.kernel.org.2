Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A4D3078A1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 15:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhA1Ou0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 09:50:26 -0500
Received: from foss.arm.com ([217.140.110.172]:33630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232412AbhA1OsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:48:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E28A31396;
        Thu, 28 Jan 2021 06:47:27 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6E463F7C3;
        Thu, 28 Jan 2021 06:47:26 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     "Song Bao Hua \(Barry Song\)" <song.bao.hua@hisilicon.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "mingo\@kernel.org" <mingo@kernel.org>,
        "peterz\@infradead.org" <peterz@infradead.org>,
        "vincent.guittot\@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann\@arm.com" <dietmar.eggemann@arm.com>,
        "morten.rasmussen\@arm.com" <morten.rasmussen@arm.com>,
        "mgorman\@suse.de" <mgorman@suse.de>
Subject: RE: [PATCH 1/1] sched/topology: Make sched_init_numa() use a set for the deduplicating sort
In-Reply-To: <ff1e47829eac4278a3489c46c39873c8@hisilicon.com>
References: <20210122123943.1217-1-valentin.schneider@arm.com> <20210122123943.1217-2-valentin.schneider@arm.com> <bfb703294b234e1e926a68fcb73dbee3@hisilicon.com> <jhj1re92wqm.mognet@arm.com> <jhjtur50xu2.mognet@arm.com> <ff1e47829eac4278a3489c46c39873c8@hisilicon.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Thu, 28 Jan 2021 14:47:21 +0000
Message-ID: <jhjo8h915l2.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/21 21:35, Song Bao Hua (Barry Song) wrote:
> I was using 5.11-rc1. One thing I'd like to mention is that:
>
> For the below topology:
> +-------+          +-----+
> | node1 |  20      |node2|
> |       +----------+     |
> +---+---+          +-----+
>     |                  |12
> 12  |                  |
> +---+---+          +---+-+
> |       |          |node3|
> | node0 |          |     |
> +-------+          +-----+
>
> with node0-node2 as 22, node0-node3 as 24, node1-node3 as 22.
>
> I will get the below sched_domains_numa_distance[]:
> 10, 12, 22, 24
> As you can see there is *no* 20. So the node1 and node2 will
> only get two-level numa sched_domain:
>


So that's

    -numa node,cpus=0-1,nodeid=0 -numa node,cpus=2-3,nodeid=1, \
    -numa node,cpus=4-5,nodeid=2, -numa node,cpus=6-7,nodeid=3, \
    -numa dist,src=0,dst=1,val=12, \
    -numa dist,src=0,dst=2,val=22, \
    -numa dist,src=0,dst=3,val=24, \
    -numa dist,src=1,dst=2,val=20, \
    -numa dist,src=1,dst=3,val=22, \
    -numa dist,src=2,dst=3,val=12

but running this still doesn't get me a splat. Debugging
sched_domains_numa_distance[] still gives me
{10, 12, 20, 22, 24}

>
> But for the below topology:
> +-------+          +-----+
> | node0 |  20      |node2|
> |       +----------+     |
> +---+---+          +-----+
>     |                  |12
> 12  |                  |
> +---+---+          +---+-+
> |       |          |node3|
> | node1 |          |     |
> +-------+          +-----+
>
> with node1-node2 as 22, node1-node3 as 24,node0-node3 as 22.
>
> I will get the below sched_domains_numa_distance[]:
> 10, 12, 20, 22, 24
>
> What I have seen is the performance will be better if we
> drop the 20 as we will get a sched_domain hierarchy with less
> levels, and two intermediate nodes won't have the group span
> issue.
>

That is another thing that's worth considering. Morten was arguing that if
the distance between two nodes is so tiny, it might not be worth
representing it at all in the scheduler topology.

> Thanks
> Barry
