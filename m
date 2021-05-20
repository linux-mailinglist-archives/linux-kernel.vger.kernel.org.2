Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636FB389FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhETIiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhETIiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:38:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6A6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 01:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O/a63xiqDeyYRC1yN3wYA+KEtbRNfD4omfciwzXuNaU=; b=qyAt3mcPYd7lfjzSKLoVi3seD2
        ZstdfrB7bqMAPPb/vM4r+rWJea6vkAKThMEqh7ULShsom4VNVB3qRfjveWeuf6kFibRjBQe/F7cvn
        jDAv7dvZkLtXCDB5eoph9o27l4DVzIAbNqrFdInbZcgjnXDEYHwU+Cpcx95BLAnBb7R94RpMhwJIr
        iN0GMJy2Q8ke3bympaPb76LgdjZoybK3iJCrQCAIaQYmH58SHRKdZbQZ6QsZ5Cfba45lTxfZtCpq9
        A7EuGyNTrMpAtCsPTXgY9Yj0EiB7HcHVI6yVKqCOqcOoDbveC5bT/YQQttpiL7y9KbyQwRyLHMCZG
        FDqN5JZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ljeAN-006FG0-Bl; Thu, 20 May 2021 08:36:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CFDE13001DB;
        Thu, 20 May 2021 10:36:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 938B72D8C28CB; Thu, 20 May 2021 10:36:25 +0200 (CEST)
Date:   Thu, 20 May 2021 10:36:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Optimize housekeeping_cpumask in for_each_cpu_and
Message-ID: <YKYfiY1/OyQYRG8m@hirez.programming.kicks-ass.net>
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
> 
> Signed-off-by: Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Thanks!
