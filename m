Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FD243F36F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 01:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhJ1X1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 19:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhJ1X1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 19:27:48 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CE9C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 16:25:20 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id bl14so7576360qkb.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 16:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rBiiWNa3p59UclXi3y2/WqGDR5bPESvpDE52/45tevQ=;
        b=uXaadR9zViKfRg2SJgNwLjApdku+IzRMoVY0+E1N2Il4deyvpMzL4qF5ObxH3VUknA
         VZHPw6l52ycVeTfcglMz7QIuyjrDuCKAIpVCO20LLvN3LF+7ZObGKbYGCcCcvPkYlxQV
         TmFkfcEmX7a4PeW1bpzIbSbdf0B0k7mDfrWW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rBiiWNa3p59UclXi3y2/WqGDR5bPESvpDE52/45tevQ=;
        b=t43OFOu91/v1SDONC04rOsYjuwvRGW6DR/46oZpKKlUjEJ6ZG/0ZVDadF8aWxW1ttj
         VAT9888lRLYdfCr6OV4ww6KDXnekLK4Ub0dfxtOPvHGaeiiDfQ0ziERDo3/agxJpE/dx
         iXa8T0ydc92iYAwfriL2xNLlg5WrMemjk4l5/xwzfGp4puxLtlwvsrBoOHhac2ZQYUUo
         IbUhvsuidHgZPacH5yfCSxeZ7P+kZ1dbwqzkDlH3jc/8hyvHJz3V06HxxZG85e8UI5Lz
         /uJWYnFQaXyB1aj6WIodV5FJWVZ/UlAPeHuABuRQl9/Z3c+lQ+D8KHR242ZHRuIByZtb
         181Q==
X-Gm-Message-State: AOAM533J3xDLM95P6h6+B/O+MD64qk/w261BIHYxwqH3d6qaFz7Xr5lq
        +kIxZsHCpSoAtfSNwhKmePnI/g==
X-Google-Smtp-Source: ABdhPJz0TrDC+NSbBTekEDO37Fd437XYYesWTOj1cwdWFxB+PndSnYRz7EKlhG66fWQUQqmmwqOxQw==
X-Received: by 2002:a05:620a:24d1:: with SMTP id m17mr6170104qkn.316.1635463519460;
        Thu, 28 Oct 2021 16:25:19 -0700 (PDT)
Received: from localhost ([2620:15c:6:411:64bf:5857:794e:a32b])
        by smtp.gmail.com with ESMTPSA id bs33sm2961098qkb.130.2021.10.28.16.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 16:25:19 -0700 (PDT)
Date:   Thu, 28 Oct 2021 19:25:18 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com, joelaf@google.com, dianders@google.com,
        qais.yousef@arm.com, Chris.Redpath@arm.com
Subject: Re: [PATCH v3 0/5] Improve newidle lb cost tracking and early abort
Message-ID: <YXsxXqkLx+fKA1Ab@google.com>
References: <20211019123537.17146-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019123537.17146-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,  Vincent, Peter,

On Tue, Oct 19, 2021 at 02:35:32PM +0200, Vincent Guittot wrote:
> This patchset updates newidle lb cost tracking and early abort:
> 
> The time spent running update_blocked_averages is now accounted in the 1st
> sched_domain level. This time can be significant and move the cost of
> newidle lb above the avg_idle time.
> 
> The decay of max_newidle_lb_cost is modified to start only when the field
> has not been updated for a while. Recent update will not be decayed
> immediatlybut only after a while.
> 
> The condition of an avg_idle lower than sysctl_sched_migration_cost has
> been removed as the 500us value is quite large and prevent opportunity to
> pull task on the newly idle CPU for at least 1st domain levels.

It appears this series is not yet in upstream Linus's tree. What's the latest on it?

I see a lot of times on ARM64 devices that load balance is skipped due to the
high the sysctl_sched_migration_cost. I saw another thread as well where
someone complained the performance varies and the default might be too high:
https://lkml.org/lkml/2021/9/14/150

Any other thoughts? Happy to help on any progress on this series as well. Thanks,

 - Joel

> 
> Monitoring sd->max_newidle_lb_cost on cpu0 of a Arm64 system
> THX2 (2 nodes * 28 cores * 4 cpus) during the benchmarks gives the
> following results:
>        min    avg   max
> SMT:   1us   33us  273us - this one includes the update of blocked load
> MC:    7us   49us  398us
> NUMA: 10us   45us  158us
> 
> 
> Some results for hackbench -l $LOOPS -g $group :
> group      tip/sched/core     + this patchset
> 1           15.189(+/- 2%)       14.987(+/- 2%)  +1%
> 4            4.336(+/- 3%)        4.322(+/- 5%)  +0%
> 16           3.654(+/- 1%)        2.922(+/- 3%) +20%
> 32           3.209(+/- 1%)        2.919(+/- 3%)  +9%
> 64           2.965(+/- 1%)        2.826(+/- 1%)  +4%
> 128          2.954(+/- 1%)        2.993(+/- 8%)  -1%
> 256          2.951(+/- 1%)        2.894(+/- 1%)  +2%
> 
> tbench and reaim have not shown any difference
> 
> Change since v2:
> - Update and decay of sd->last_decay_max_lb_cost are gathered in
>   update_newidle_cost(). The behavior remains almost the same except that
>   the decay can happen during newidle_balance now.
> 
>   Tests results haven't shown any differences
>   
>   I haven't modified rq->max_idle_balance_cost. It acts as the max value
>   for avg_idle and prevents the latter to reach high value during long
>   idle phase. Moving on an IIR filter instead, could delay the convergence
>   of avg_idle to a reasonnable value that reflect current situation.
> 
> - Added a minor cleanup of newidle_balance
> 
> Change since v1:
> - account the time spent in update_blocked_averages() in the 1st domain
> 
> - reduce number of call of sched_clock_cpu() 
> 
> - change the way max_newidle_lb_cost is decayed. Peter suggested to use a
>   IIR but keeping a track of the current max value gave the best result
> 
> - removed the condition (this_rq->avg_idle < sysctl_sched_migration_cost)
>   as suggested by Peter
> 
> Vincent Guittot (5):
>   sched/fair: Account update_blocked_averages in newidle_balance cost
>   sched/fair: Skip update_blocked_averages if we are defering load
>     balance
>   sched/fair: Wait before decaying max_newidle_lb_cost
>   sched/fair: Remove sysctl_sched_migration_cost condition
>   sched/fair: cleanup newidle_balance
> 
>  include/linux/sched/topology.h |  2 +-
>  kernel/sched/fair.c            | 65 ++++++++++++++++++++++------------
>  kernel/sched/topology.c        |  2 +-
>  3 files changed, 45 insertions(+), 24 deletions(-)
> 
> -- 
> 2.17.1
> 
