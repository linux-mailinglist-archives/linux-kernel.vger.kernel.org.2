Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0333983B5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 09:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhFBIAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhFBIAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:00:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16944C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 00:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FSxhpltvmZUTu0Q80dDCZFqBou+xoj7Cbq//rVihrFw=; b=Z8CZU2z3rMbHlDVoHzniuKhqbB
        XClHVc0BQE2FZ+wh5qNigOuVD93BZN5AW0eEjHnuUZk/6t1iQJmixBIfUiilShY3LShQMMpfGtgNW
        SOw+sVVHtF3wR/cSNJ0atgQuFyPJlI+TNQ3WwbJ+1PEPmqzxZ8n7v6qTcW+0L2D2xowKw6YtlKCSB
        VZoQLsaSff3iXsSWA+NE15uFz+rQpFsKriqnYfrMAxdjQB2TA+auf3I7q9FWgcFNh5pZXGSypHJ6b
        zDPWNTru7XDqnqyXJu2EpN7j1gjX2fSB71aZVDArpTfTAZ4baT8yXo5cyNE83zcZsMGUn0aDc+yKb
        a1HwCSHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1loLkm-00ArhO-Qm; Wed, 02 Jun 2021 07:57:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 28A72300269;
        Wed,  2 Jun 2021 09:57:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C393820126D07; Wed,  2 Jun 2021 09:57:26 +0200 (CEST)
Date:   Wed, 2 Jun 2021 09:57:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Optimize housekeeping_cpumask in for_each_cpu_and
Message-ID: <YLc55msU53ogA7n3@hirez.programming.kicks-ass.net>
References: <1622599432-8175-1-git-send-email-yuanzhaoxiong@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622599432-8175-1-git-send-email-yuanzhaoxiong@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 10:03:52AM +0800, Yuan ZhaoXiong wrote:
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

This is still not a valid SoB chain. Please refer to
Documentation/process/submitting-patches.rst.

The first SoB should match the Author, which if missing is From, the
last SoB should match the Sender which is From. Since there is only one
From but two SoBs this cannot be right.
