Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773E530D90A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbhBCLnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:43:43 -0500
Received: from foss.arm.com ([217.140.110.172]:38472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234467AbhBCLnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:43:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A8E613D5;
        Wed,  3 Feb 2021 03:42:24 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AC203F719;
        Wed,  3 Feb 2021 03:42:21 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     "Song Bao Hua \(Barry Song\)" <song.bao.hua@hisilicon.com>,
        "vincent.guittot\@linaro.org" <vincent.guittot@linaro.org>,
        "mgorman\@suse.de" <mgorman@suse.de>,
        "mingo\@kernel.org" <mingo@kernel.org>,
        "peterz\@infradead.org" <peterz@infradead.org>,
        "dietmar.eggemann\@arm.com" <dietmar.eggemann@arm.com>,
        "morten.rasmussen\@arm.com" <morten.rasmussen@arm.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linuxarm\@openeuler.org" <linuxarm@openeuler.org>,
        "xuwei \(O\)" <xuwei5@huawei.com>,
        "Liguozhu \(Kenneth\)" <liguozhu@hisilicon.com>,
        "tiantao \(H\)" <tiantao6@hisilicon.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "guodong.xu\@linaro.org" <guodong.xu@linaro.org>,
        Meelis Roos <mroos@linux.ee>
Subject: RE: [PATCH] sched/topology: fix the issue groups don't span domain->span for NUMA diameter > 2
In-Reply-To: <64209fc8849447e6bcd2d36e74a48fc3@hisilicon.com>
References: <20210201033830.15040-1-song.bao.hua@hisilicon.com> <jhj4kiu4hz8.mognet@arm.com> <64209fc8849447e6bcd2d36e74a48fc3@hisilicon.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Wed, 03 Feb 2021 11:42:15 +0000
Message-ID: <jhjy2g52x9k.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/21 10:23, Song Bao Hua (Barry Song) wrote:
>> -----Original Message-----
>> From: Valentin Schneider [mailto:valentin.schneider@arm.com]
>> Thoughts?
>
> I guess the original purpose of overlapping groups is creating as few groups
> as possible. If we totally remove overlapping groups, it seems we will create
> much more groups?
> For example, while node0 begins to build sched_domain for distance 20, it will
> add node2, since the distance between node2 and node3 is 15, so while node2 is
> added, node3 is also added as node2's lower domain has covered node3. So we need
> two groups only for node0's sched_domain of distance level 20.
> +-------+                  +--------+
>  |       |      15          |        |
>  |  node0+----------------+ | node1  |
>  |       |                  |        |
>  +----+--+                XXX--------+
>       |                 XXX
>       |                XX
> 20    |         15   XX
>       |            XXX
>       |       X XXX
>  +----+----XXX               +-------+
>  |         |     15          |  node3|
>  | node2   +-----------------+       |
>  |         |                 +-------+
>  +---------+
>
> If we remove overlapping group, we will add a group for node2, another
> group for node3. Then we get three groups.
>
> I am not sure if it is always positive for performance.
>

Neither am I! At the same time our strategy for generating groups is pretty
much flawed for anything with distance > 2, so I'd like to have a saner
setup that doesn't involve fixing groups "after the fact".

I have a sort-of-working hack, I'll make this into a patch and toss it out
for discussion.
