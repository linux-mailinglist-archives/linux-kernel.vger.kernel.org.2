Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA9A32A4D7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838662AbhCBLSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 06:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1838652AbhCBK5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:57:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659B3C06178C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 02:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2eshro0EBJZzpkPKK7nfRXtPRAYkSjHS/ySnSYAHp50=; b=urHH3W5/bTO9iADelvx1Y72tEG
        dJFApZyeIEx1PMFBS+mVXLS524rjrXxDrj3J0wNPiPHpCKx45/Fmyyxocu57hgUQuEWb9jpEAGpMG
        NjZhEZo0xYIHwLBi6RL9gMa8AmpwsFByVOJpnd26tWc8Cf3YSR2M8EZ8qIq9y8zylP25XhbVYH13x
        ZwZB6eDq2OZyEaNJoVUj5r5tP8XHbfbjNeGILKQHFblOquOQ48uQCLkyK0T26ZEsyV7eDN8oT4TcN
        mqSn0OxRHwxBhsLXkqbM/s6erUtpKv3umrseK+uxfzyIKqyIFnY2jiRYAJNosnjfvOUYUvAgclLKn
        gQsl5GXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lH2hT-00GyQB-W9; Tue, 02 Mar 2021 10:56:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1B9893003E1;
        Tue,  2 Mar 2021 11:56:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ECB5C234E17DB; Tue,  2 Mar 2021 11:56:20 +0100 (CET)
Date:   Tue, 2 Mar 2021 11:56:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     valentin.schneider@arm.com, vincent.guittot@linaro.org,
        mgorman@suse.de, mingo@kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, linux-kernel@vger.kernel.org,
        linuxarm@openeuler.org, xuwei5@huawei.com, liguozhu@hisilicon.com,
        tiantao6@hisilicon.com, wanghuiqiang@huawei.com,
        prime.zeng@hisilicon.com, jonathan.cameron@huawei.com,
        guodong.xu@linaro.org, yangyicong@huawei.com,
        Meelis Roos <mroos@linux.ee>
Subject: Re: [PATCH v4] sched/topology: fix the issue groups don't span
 domain->span for NUMA diameter > 2
Message-ID: <YD4Z1K6Vb0+u0JQz@hirez.programming.kicks-ass.net>
References: <20210224030944.15232-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224030944.15232-1-song.bao.hua@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 04:09:44PM +1300, Barry Song wrote:
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
> select_task_rq_fair() pick an idle CPU outside the sched_domain.
> 
> Real servers which suffer from this problem include Kunpeng920 and 8-node
> Sun Fire X4600-M2, at least.
> 
> Here we move to use the *child* domain of the *child* domain of node2's
> domain2 as the new added sched_group. At the same, we re-use the lower
> level sgc directly.
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
> While the lower level sgc is re-used, this patch only changes the remote
> sched_groups for those sched_domains playing grandchild trick, therefore,
> sgc->next_update is still safe since it's only touched by CPUs that have
> the group span as local group. And sgc->imbalance is also safe because
> sd_parent remains the same in load_balance and LB only tries other CPUs
> from the local group.
> Moreover, since local groups are not touched, they are still getting
> roughly equal size in a TL. And should_we_balance() only matters with
> local groups, so the pull probability of those groups are still roughly
> equal.
> 

> Reported-by: Valentin Schneider <valentin.schneider@arm.com>
> Tested-by: Meelis Roos <mroos@linux.ee>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>

Thanks!
