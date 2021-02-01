Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F67D30A723
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhBAMEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:04:39 -0500
Received: from foss.arm.com ([217.140.110.172]:57876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229495AbhBAMEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:04:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1377AED1;
        Mon,  1 Feb 2021 04:03:52 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA9443F718;
        Mon,  1 Feb 2021 04:03:50 -0800 (PST)
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
In-Reply-To: <e12ec4f50c6c41db84f601038d3ee39c@hisilicon.com>
References: <20210122123943.1217-1-valentin.schneider@arm.com> <20210122123943.1217-2-valentin.schneider@arm.com> <bfb703294b234e1e926a68fcb73dbee3@hisilicon.com> <jhj1re92wqm.mognet@arm.com> <jhjtur50xu2.mognet@arm.com> <ff1e47829eac4278a3489c46c39873c8@hisilicon.com> <jhjo8h915l2.mognet@arm.com> <e12ec4f50c6c41db84f601038d3ee39c@hisilicon.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Mon, 01 Feb 2021 12:03:48 +0000
Message-ID: <jhjy2g8yoyj.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/01/21 02:02, Song Bao Hua (Barry Song) wrote:
>> -----Original Message-----
>> From: Valentin Schneider [mailto:valentin.schneider@arm.com]
>> That is another thing that's worth considering. Morten was arguing that if
>> the distance between two nodes is so tiny, it might not be worth
>> representing it at all in the scheduler topology.
>
> Yes. I agree it is a different thing. Anyway, I saw your patch has been
> in sched tree. One side effect your patch is the one more sched_domain
> level is imported for this topology:
>
>                             24
>                       X X XXX X X  X X X X XXX
>              XX XX X                          XXXXX
>          XXX                                        X
>        XX                                             XXX
>      XX                                 22              XXX
>      X                           XXXXXXX                   XX
>     X                        XXXXX      XXXXXXXXX           XXXX
>    XX                      XXX                    XX X XX X    XX
> +--------+           +---------+          +---------+      XX+---------+
> | 0      |   12      | 1       | 20       | 2       |   12   |3        |
> |        +-----------+         +----------+         +--------+         |
> +---X----+           +---------+          +--X------+        +---------+
>     X                                        X
>     XX                                      X
>      X                                     XX
>       XX                                  XX
>        XX                                X
>         X XXX                         XXX
>              X XXXXXX XX XX X X X XXXX
>                        22
> Without the patch, Linux will use 10,12,22,24 to build sched_domain;
> With your patch, Linux will use 10,12,20,22,24 to build sched_domain.
>
> So one more layer is added. What I have seen is that:
>
> For node0 sched_domain <=12 and sched_domain <=20 span the same range
> (node0, node1). So one of them is redundant. then in cpu_attach_domain,
> the redundant one is dropped due to "remove the sched domains which
> do not contribute to scheduling".
>
> For node1&2, the origin code had no "20", thus built one less sched_domain
> level.
>

Right, that domain degeneration should get you to the same result. We do
want to make sure we're handling every distance value in the table; the
gist is to "stupidly" build every domain / level we can, and if some are
redundant we can remove them after the fact.

> What is really interesting is that removing 20 actually gives better
> benchmark in speccpu :-)
>
>
>>
>> > Thanks
>> > Barry
>
> Thanks
> Barry
