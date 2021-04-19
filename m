Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37BF363F40
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 11:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237367AbhDSJ6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 05:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhDSJ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:58:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC9AC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 02:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FlVO0HsxJfPGYtBK9wYBR/ACrk9EWw2KvWlRpjKbsTo=; b=lXi+4oz8+J9lEErNx6vqxgfW0m
        rb9nEdqMEnYT60Y6KSZnAb20UBjKStkKxR89eTZ8Yy81buVd+rnQrbDvKcAvBM1qYSByPzi8XOhgw
        xCc9QVT2mn4KB0edM0VmEDMqKnyDXLZU5pnWxOR/6j58+M8CK1U6vZ6ZkuBTvyCmcuy6GqG0VIHVk
        EGcxURhHqk96b173ZtBppb9luCnJV75CG461xF9UQi+bdS1+qymkc6gTBmE2rzq8bDyoI1lkRaK1x
        5tenBgkzKKKdwdnptytbP54ORObCPTAeTGvtA6FzW6h9peS1gEmcyPLi+bNkQ8RHWgt3i+JIoPc7y
        Kzx957xg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYQe2-00DYx5-RZ; Mon, 19 Apr 2021 09:56:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8EA2C30021C;
        Mon, 19 Apr 2021 11:56:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 55750201946E6; Mon, 19 Apr 2021 11:56:41 +0200 (CEST)
Date:   Mon, 19 Apr 2021 11:56:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Optimize housekeeping_cpumask in for_each_cpu_and
Message-ID: <YH1T2f96IWlR7aOi@hirez.programming.kicks-ass.net>
References: <1618671697-26098-1-git-send-email-yuanzhaoxiong@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618671697-26098-1-git-send-email-yuanzhaoxiong@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 11:01:37PM +0800, Yuan ZhaoXiong wrote:
> On a 128 cores AMD machine, there are 8 cores in nohz_full mode, and
> the others are used for housekeeping. When many housekeeping cpus are
> in idle state, we can observe huge time burn in the loop for searching
> nearest busy housekeeper cpu by ftrace.
> 
>    9)               |              get_nohz_timer_target() {
>    9)               |                housekeeping_test_cpu() {
>    9)   0.390 us    |                  housekeeping_get_mask.part.1();
>    9)   0.561 us    |                }
>    9)   0.090 us    |                __rcu_read_lock();
>    9)   0.090 us    |                housekeeping_cpumask();
>    9)   0.521 us    |                housekeeping_cpumask();
>    9)   0.140 us    |                housekeeping_cpumask();
> 
>    ...
> 
>    9)   0.500 us    |                housekeeping_cpumask();
>    9)               |                housekeeping_any_cpu() {
>    9)   0.090 us    |                  housekeeping_get_mask.part.1();
>    9)   0.100 us    |                  sched_numa_find_closest();
>    9)   0.491 us    |                }
>    9)   0.100 us    |                __rcu_read_unlock();
>    9) + 76.163 us   |              }
> 
> for_each_cpu_and() is a micro function, so in get_nohz_timer_target()
> function the
>         for_each_cpu_and(i, sched_domain_span(sd),
>                 housekeeping_cpumask(HK_FLAG_TIMER))
> equals to below:
>         for (i = -1; i = cpumask_next_and(i, sched_domain_span(sd),
>                 housekeeping_cpumask(HK_FLAG_TIMER)), i < nr_cpu_ids;)
> That will cause that housekeeping_cpumask() will be invoked many times.
> The housekeeping_cpumask() function returns a const value, so it is
> unnecessary to invoke it every time. This patch can minimize the worst
> searching time from ~76us to ~16us in my testing.
> 
> Similarly, the find_new_ilb() function has the same problem.

Would it not make sense to mark housekeeping_cpumask() __pure instead?
