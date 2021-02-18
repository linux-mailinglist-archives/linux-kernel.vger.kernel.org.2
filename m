Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17AE31EB01
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 15:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhBROgh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 18 Feb 2021 09:36:37 -0500
Received: from foss.arm.com ([217.140.110.172]:50768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232923AbhBRMmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:42:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3502B1FB;
        Thu, 18 Feb 2021 04:41:05 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A92E3F73D;
        Thu, 18 Feb 2021 04:41:02 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     "Song Bao Hua \(Barry Song\)" <song.bao.hua@hisilicon.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "vincent.guittot\@linaro.org" <vincent.guittot@linaro.org>,
        "mgorman\@suse.de" <mgorman@suse.de>,
        "mingo\@kernel.org" <mingo@kernel.org>,
        "dietmar.eggemann\@arm.com" <dietmar.eggemann@arm.com>,
        "morten.rasmussen\@arm.com" <morten.rasmussen@arm.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm\@openeuler.org" <linuxarm@openeuler.org>,
        "xuwei \(O\)" <xuwei5@huawei.com>,
        "Liguozhu \(Kenneth\)" <liguozhu@hisilicon.com>,
        "tiantao \(H\)" <tiantao6@hisilicon.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "guodong.xu\@linaro.org" <guodong.xu@linaro.org>,
        Meelis Roos <mroos@linux.ee>
Subject: RE: [Linuxarm]  Re: [PATCH v2] sched/topology: fix the issue groups don't span domain->span for NUMA diameter > 2
In-Reply-To: <ae3bf4dc465040a4b31e4010fd800408@hisilicon.com>
References: <20210203111201.20720-1-song.bao.hua@hisilicon.com> <YCKGVBnXzRsE6/Er@hirez.programming.kicks-ass.net> <4bdaa3e1a54f445fa8e629ea392e7bce@hisilicon.com> <YCPByAdQ+rZFzYWp@hirez.programming.kicks-ass.net> <jhjblcqtm5c.mognet@arm.com> <ae3bf4dc465040a4b31e4010fd800408@hisilicon.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Thu, 18 Feb 2021 12:40:53 +0000
Message-ID: <jhj7dn5sg4q.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Barry,

On 18/02/21 09:17, Song Bao Hua (Barry Song) wrote:
> Hi Valentin,
>
> I understand Peter's concern is that the local group has different
> size with remote groups. Is this patch resolving Peter's concern?
> To me, it seems not :-)
>

If you remove the '&& i != cpu' in build_overlap_sched_groups() you get
that, but then you also get some extra warnings :-)

Now yes, should_we_balance() only matters for the local group. However I'm
somewhat wary of messing with the local groups; for one it means you would
have more than one tl now accessing the same sgc->next_update, sgc->{min,
max}capacity, sgc->group_imbalance (as Vincent had pointed out).

By ensuring only remote (i.e. !local) groups are modified (which is what
your patch does), we absolve ourselves of this issue, which is why I prefer
this approach ATM.

> Though I don’t understand why different group sizes will be harmful
> since all groups are calculating avg_load and group_type based on
> their own capacities. Thus, for a smaller group, its capacity would
> be smaller.
>
> Is it because a bigger group has relatively less chance to pull, so
> load balancing will be completed more slowly while small groups have
> high load?
>

Peter's point is that, if at a given tl you have groups that look like

g0: 0-4, g1: 5-6, g2: 7-8

Then g0 is half as likely to pull tasks with load_balance() than g1 or g2
(due to the group size vs should_we_balance())


However, I suppose one "trick" to be aware of here is that since your patch
*doesn't* change the local group, we do have e.g. on CPU0:

[    0.374840]    domain-2: span=0-5 level=NUMA
[    0.375054]     groups: 0:{ span=0-3 cap=4003 }, 4:{ span=4-5 cap=1988 }

*but* on CPU4 we get:

[    0.387019]    domain-2: span=0-1,4-7 level=NUMA
[    0.387211]     groups: 4:{ span=4-7 cap=3984 }, 0:{ span=0-1 cap=2013 }

IOW, at a given tl, all *local* groups have /roughly/ the same size and thus
similar pull probability (it took me writing this mail to see it that
way). So perhaps this is all fine already? 
