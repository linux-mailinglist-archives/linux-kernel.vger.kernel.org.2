Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5726C314D85
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhBIKvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:51:36 -0500
Received: from foss.arm.com ([217.140.110.172]:49444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231217AbhBIKnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:43:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76EBF101E;
        Tue,  9 Feb 2021 02:41:57 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02DB23F73B;
        Tue,  9 Feb 2021 02:41:54 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     "Song Bao Hua \(Barry Song\)" <song.bao.hua@hisilicon.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "vincent.guittot\@linaro.org" <vincent.guittot@linaro.org>,
        "mgorman\@suse.de" <mgorman@suse.de>,
        "mingo\@kernel.org" <mingo@kernel.org>,
        "peterz\@infradead.org" <peterz@infradead.org>,
        "dietmar.eggemann\@arm.com" <dietmar.eggemann@arm.com>,
        "morten.rasmussen\@arm.com" <morten.rasmussen@arm.com>,
        "linuxarm\@openeuler.org" <linuxarm@openeuler.org>,
        "xuwei \(O\)" <xuwei5@huawei.com>,
        "Liguozhu \(Kenneth\)" <liguozhu@hisilicon.com>,
        "tiantao \(H\)" <tiantao6@hisilicon.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "guodong.xu\@linaro.org" <guodong.xu@linaro.org>,
        Meelis Roos <mroos@linux.ee>
Subject: RE: [RFC PATCH 1/2] sched/topology: Get rid of NUMA overlapping groups
In-Reply-To: <9619692afa1d4571b59c8a1da5d1076a@hisilicon.com>
References: <20210203155432.10293-1-valentin.schneider@arm.com> <20210203155432.10293-2-valentin.schneider@arm.com> <26e70a3275b14f248520d7a5e66e5a74@hisilicon.com> <jhjpn1a232z.mognet@arm.com> <9619692afa1d4571b59c8a1da5d1076a@hisilicon.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Tue, 09 Feb 2021 10:41:45 +0000
Message-ID: <jhj5z31v7yu.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/21 00:12, Song Bao Hua (Barry Song) wrote:
>> -----Original Message-----
>> From: Valentin Schneider [mailto:valentin.schneider@arm.com]
>>
>> Yes; let's take your topology for instance:
>>
>> node   0   1   2   3
>>     0:  10  12  20  22
>>     1:  12  10  22  24
>>     2:  20  22  10  12
>>     3:  22  24  12  10
>>
>>       2       10      2
>>   0 <---> 1 <---> 2 <---> 3
>
> Guess you actually mean
>        2       10      2
>    1 <---> 0 <---> 2 <---> 3
>

Yeah, you're right, sorry about that!

>>
>>
>> Domains for node1 will look like (before any fixes are applied):
>>
>> NUMA<=10: span=1   groups=(1)
>> NUMA<=12: span=0-1 groups=(1)->(0)
>> NUMA<=20: span=0-1 groups=(0,1)
>> NUMA<=22: span=0-2 groups=(0,1)->(0,2-3)
>> NUMA<=24: span=0-3 groups=(0-2)->(0,2-3)
>>
>> As you can see, the domain representing distance <= 20 will be degenerated
>> (it has a single group). If we were to e.g. add some more nodes to the left
>> of node0, then we would trigger the "grandchildren logic" for node1 and
>> would end up creating a reference to node1 NUMA<=20's sgc, which is a
>> mistake: that domain will be degenerated, and that sgc will never be
>> updated. The right thing to do here would be reference node1 NUMA<=12's
>> sgc, which the above snippet does.
>
> Guess I got your point even though the diagram is not correct :-)
>

Good!

> If the topology is as below(add a node left to node1 rather than
> node0):
>
>     9       2       10      2
> A <---> 1 <---> 0 <---> 2 <---> 3
>
> For nodeA,
> NUMA<=10: span=A   groups=(A)
> NUMA<=12: span= A groups= (A)
> NUMA<=19: span=A-1 groups=(A),(1)
> NUMA<=20: span=A-1 groups=(A,1)
> *1 NUMA<=21: span=A-1-0 groups=(A,1), node1's numa<=20
>
> For node0,
> NUMA<=10: span=9   groups=(0)
> #3 NUMA<=12: span=0-1 groups=(0)->(1)
> #2 NUMA<=19: span=0-1 groups=(0,1)
> #1 NUMA<=20: span=0-1-2 groups=(0,1),....
>
> *1 will firstly try #1, and it finds 2 is outside the A-1-0,
> then it will try #2. Finally #2 will be degenerated, so we
> should actually use #3. Amazing!
>

Bingo!

>>
>> >> +
>> >> +	return parent;
>> >> +}
>> >> +
>
> Thanks
> Barry
