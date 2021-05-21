Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91AEE38C8EA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 16:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbhEUOHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 10:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbhEUOHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 10:07:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3960CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0C8kHu6rCxUOo/sP2SQuP8zUTcbxUJXcA/lLgQJqHSs=; b=aZv1ciUFNyv5BlpaH3ZnnN0GBs
        4T/4gC2blFQTJkjHDFLHM1BFE33//d3c3uTHFaXY4exXKRcKV422KPtfr9NvZrOkj/Cc0n0AC5Qq9
        COP7QKmg+oJPT4zvp0gRbkvwTJQ99QO9vevSN9EmuC+welodRoJDw3QZVAq+yXtXWFnoNvv+3MblU
        Kxqn/6+7WWQ8OLlkXuXT2JfhoqnUiKi6nl/H/r0yJ6axnz1AVtJgdg+dRCOr1/gm8ULiJVSVYn4Fc
        164otQkuF6MqMmHcxXv0GPnFMTLCtbVACD22fu4iFSMeOqUsfDSMe00Oz7o4BmVhU4+2PGARqfEzr
        YwGnGoVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lk5mL-005i8j-1G; Fri, 21 May 2021 14:05:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 51ECD3001D0;
        Fri, 21 May 2021 16:05:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 35FB930D63CA9; Fri, 21 May 2021 16:05:19 +0200 (CEST)
Date:   Fri, 21 May 2021 16:05:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Odin Ugedal <odin@uged.al>
Cc:     Huaixin Chang <changhuaixin@linux.alibaba.com>,
        Benjamin Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dtcccc@linux.alibaba.com, Juri Lelli <juri.lelli@redhat.com>,
        khlebnikov@yandex-team.ru,
        open list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        pauld@redhead.com, Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        shanpeic@linux.alibaba.com, Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xiyou.wangcong@gmail.com
Subject: Re: [PATCH v5 2/3] sched/fair: Add cfs bandwidth burst statistics
Message-ID: <YKe+H4F5I/L/+K8M@hirez.programming.kicks-ass.net>
References: <20210520123419.8039-1-changhuaixin@linux.alibaba.com>
 <20210520123419.8039-3-changhuaixin@linux.alibaba.com>
 <CAFpoUr1GZspG1yKHf3D=+BZKfufWNNdu2Ccuj+YBo8EaJYRi8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFpoUr1GZspG1yKHf3D=+BZKfufWNNdu2Ccuj+YBo8EaJYRi8w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 04:11:52PM +0200, Odin Ugedal wrote:
> I am a bit sceptical about both the nr_burst and burst_time as they are now.
> 
> As an example; a control group using "99.9%" of the quota each period
> and that is never throttled. Such group would with this patch with a burst of X
> still get nr_throttled = 0 (as before), but it would get a nr_burst
> and burst_time that
> will keep increasing.
> 
> I think there is a big difference between runtime moved/taken from
> cfs_b->runtime to cfs_rq->runtime_remaining and the actual runtime used
> in the period. Currently, cfs bw can only supply info the first one, and
> not the latter.
> 
> I think that if people see nr_burst increasing, that they think they _have_
> to use cfs burst in order to avoid being throttled, even though that might
> not be the case. It is probably fine as is, as long as it is explicitly stated
> what the values mean and imply, and what they do not. I cannot see another
> way to calculate it as it is now, but maybe someone else has some thoughts.

You can always trace the system. I don't think we have nice tracepoints
for any of this, but much can be inferred from the scheduler and hrtimer
tracepoints. Also kprobe might be empoloyed to stick in more appropriate
thingies I suppose.

You can also run the workload without bandwidth controls and measure
it's job execution times, and from that compute the bandwidth settings,
all without tracepoints.
