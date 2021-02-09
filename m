Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D01314F92
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 13:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhBIM5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 07:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhBIM5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 07:57:03 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09A9C061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 04:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qMo2zzG12R0jprXXUVbuB3AdsfkG8WclBYk1eMYjOHg=; b=cYQeruhV1G3HXBPsODeVEnF9O6
        6/1H7jrbyLdd0LbkyiWluwK3vBui0b3Pk8jTdjtJS5Lpl0p49bTIm+hLBsTgga/ktzFZvZ9QqXtf/
        hRJbYvFjDZD4vOQRobHuf3eyr3RjESRBbPHn0oU/BJhxrLzBbPHDGum8BXzMi/II9AMd56+fijwSw
        XpXsuW8MmDQIhFVn3dkmdT57e6a+QRXdY6AWspJM2VyWNa8eMHGXqMKaf3ESDLzS5xeGsSKIBGsRA
        QZCqtHTuCVC43a0mvVjRW3KJ0up2uTh/7iicmzW4SUDheM5gAqopRjlcT4yqPy3HMh3LjNrj0xc04
        ofuhoS/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9SYZ-0003kU-Dp; Tue, 09 Feb 2021 12:55:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F21B6301324;
        Tue,  9 Feb 2021 13:55:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA2BA20568EA3; Tue,  9 Feb 2021 13:55:48 +0100 (CET)
Date:   Tue, 9 Feb 2021 13:55:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     valentin.schneider@arm.com, vincent.guittot@linaro.org,
        mgorman@suse.de, mingo@kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, linux-kernel@vger.kernel.org,
        linuxarm@openeuler.org, xuwei5@huawei.com, liguozhu@hisilicon.com,
        tiantao6@hisilicon.com, wanghuiqiang@huawei.com,
        prime.zeng@hisilicon.com, jonathan.cameron@huawei.com,
        guodong.xu@linaro.org, Meelis Roos <mroos@linux.ee>
Subject: Re: [PATCH v2] sched/topology: fix the issue groups don't span
 domain->span for NUMA diameter > 2
Message-ID: <YCKGVBnXzRsE6/Er@hirez.programming.kicks-ass.net>
References: <20210203111201.20720-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203111201.20720-1-song.bao.hua@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 12:12:01AM +1300, Barry Song wrote:
> As long as NUMA diameter > 2, building sched_domain by sibling's child
> domain will definitely create a sched_domain with sched_group which will
> span out of the sched_domain:
> 
>                +------+         +------+        +-------+       +------+
>                | node |  12     |node  | 20     | node  |  12   |node  |
>                |  0   +---------+1     +--------+ 2     +-------+3     |
>                +------+         +------+        +-------+       +------+
> 
> domain0        node0            node1            node2          node3
> 
> domain1        node0+1          node0+1          node2+3        node2+3
>                                                  +
> domain2        node0+1+2                         |
>              group: node0+1                      |
>                group:node2+3 <-------------------+
> 
> when node2 is added into the domain2 of node0, kernel is using the child
> domain of node2's domain2, which is domain1(node2+3). Node 3 is outside
> the span of the domain including node0+1+2.
> 
> This will make load_balance() run based on screwed avg_load and group_type
> in the sched_group spanning out of the sched_domain, and it also makes
> select_task_rq_fair() pick an idle CPU out of the sched_domain.
> 
> Real servers which suffer from this problem include Kunpeng920 and 8-node
> Sun Fire X4600-M2, at least.
> 
> Here we move to use the *child* domain of the *child* domain of node2's
> domain2 as the new added sched_group. At the same time, we re-use the
> lower level sgc directly.
> 
>                +------+         +------+        +-------+       +------+
>                | node |  12     |node  | 20     | node  |  12   |node  |
>                |  0   +---------+1     +--------+ 2     +-------+3     |
>                +------+         +------+        +-------+       +------+
> 
> domain0        node0            node1          +- node2          node3
>                                                |
> domain1        node0+1          node0+1        | node2+3        node2+3
>                                                |
> domain2        node0+1+2                       |
>              group: node0+1                    |
>                group:node2 <-------------------+
> 

I've finally had a moment to think about this, would it make sense to
also break up group: node0+1, such that we then end up with 3 groups of
equal size?

> w/ patch, we don't get "groups don't span domain->span" any more:
> [    1.486271] CPU0 attaching sched-domain(s):
> [    1.486820]  domain-0: span=0-1 level=MC
> [    1.500924]   groups: 0:{ span=0 cap=980 }, 1:{ span=1 cap=994 }
> [    1.515717]   domain-1: span=0-3 level=NUMA
> [    1.515903]    groups: 0:{ span=0-1 cap=1974 }, 2:{ span=2-3 cap=1989 }
> [    1.516989]    domain-2: span=0-5 level=NUMA
> [    1.517124]     groups: 0:{ span=0-3 cap=3963 }, 4:{ span=4-5 cap=1949 }

		     groups: 0:{ span=0-1 cap=1974 }, 2:{ span=2-3, cap=1989 }, 4:{ span=4-5, cap=1949 }

> [    1.517369]     domain-3: span=0-7 level=NUMA
> [    1.517423]      groups: 0:{ span=0-5 mask=0-1 cap=5912 }, 6:{ span=4-7 mask=6-7 cap=4054 }

Let me continue to think about this... it's been a while :/
