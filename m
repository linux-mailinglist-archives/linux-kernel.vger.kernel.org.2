Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FC9392AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbhE0Jme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbhE0Jmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:42:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F56BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 02:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JOYkp/+FD5Ez5i2M5cbnRA0jtQkQK4Z5hNl22YGZ+MI=; b=rIOkWRK5QHd2OLkDOC/bEGL0BD
        DU3zcQ6GUxpfuH0CVQKJd5ZaKVSlCUmGCUtrJe/IcZaa6k4NazNo30KcNfj3h5GDT+0hmWiYEWeKD
        ODDI0f5R2LOTXTtG6FOLe37UPOhDbbM88NMCEZAnmuZ2PXZAGAjD1KCLG9A6zpLwQ+902LY0RNwQS
        jMGmN7QEWfh4+wLeLYB4eQWGOMc1Hc+URCttVbeice7x4RumT4FWI2mNJV1U2ldDq2h9TPRVQdTki
        PiulRGY7dKDn8WJM2rrDN8C7VFf2OjGeT2qak8ZIn4q6xxsu8pC1a6PTlrea3GTz8i3t/+RX5tjxr
        r3xF9Dgw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lmCVI-000yEf-L3; Thu, 27 May 2021 09:40:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 78D8E300268;
        Thu, 27 May 2021 11:40:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A74F2C6D319A; Thu, 27 May 2021 11:40:42 +0200 (CEST)
Date:   Thu, 27 May 2021 11:40:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Optimize housekeeping_cpumask in for_each_cpu_and
Message-ID: <YK9pGoOxA7gVi1S2@hirez.programming.kicks-ass.net>
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

Just noticed, this SoB chain isn't valid. What do I do with Li's entry?
