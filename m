Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CE0383981
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238374AbhEQQSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:18:12 -0400
Received: from foss.arm.com ([217.140.110.172]:57298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344287AbhEQQP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 12:15:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70F02106F;
        Mon, 17 May 2021 09:14:37 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58ADE3F73D;
        Mon, 17 May 2021 09:14:35 -0700 (PDT)
Date:   Mon, 17 May 2021 17:14:33 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Dietmar Eggeman <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: Re: [PATCH] sched/fair: Rate limit calls to
 update_blocked_averages() for NOHZ
Message-ID: <20210517161433.k4oeq5antaqwlbus@e107158-lin.cambridge.arm.com>
References: <fc0efe4e-0a81-03b8-08cb-029468c57782@linux.intel.com>
 <CAKfTPtCKavGWja42NdTmb+95ppG-WxYzoTJMmtgkCQcA-btfBw@mail.gmail.com>
 <4aa674d9-db49-83d5-356f-a20f9e2a7935@linux.intel.com>
 <CAKfTPtDJaTr_HR2t=9CQ-9x6keu-qzx6okci92AdW5cJG8J9zg@mail.gmail.com>
 <2d2294ce-f1d1-f827-754b-4541c1b43be8@linux.intel.com>
 <ade18978-cd67-6215-28f0-4857c66a99fb@linux.intel.com>
 <CAKfTPtA8nr-fgt4Nw6XqQyT_TEx4uL3nK-ba0xGfkONO+BPG3Q@mail.gmail.com>
 <577b0aae-0111-97aa-0c99-c2a2fcfb5e2e@linux.intel.com>
 <20210512135955.suzvxxfilvwg33y2@e107158-lin.cambridge.arm.com>
 <5366ec7a-8546-9a32-53f5-5f5a98117355@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5366ec7a-8546-9a32-53f5-5f5a98117355@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/13/21 11:45, Tim Chen wrote:
> 
> 
> On 5/12/21 6:59 AM, Qais Yousef wrote:
> > On 05/11/21 10:25, Tim Chen wrote:
> >>> update_next_balance() is only used in newidle_balance() so we could
> >>> modify it to  have:
> >>>
> >>> next = max(jiffies+1, next = sd->last_balance + interval)
> >>
> >> Is the extra assignment "next = sd->last_balance + interval" needed?
> >> This seems more straight forward:
> >>
> >> next = max(jiffies+1, sd->last_balance + interval)
> > 
> > I haven't been following the whole conversation closely, but it's always
> > interesting when manipulating time in non time_*() functions.
> > 
> > Is this max() safe against wrapping?
> 
> Looking at the definition, seems like max doesn't take care of wrapping.
> #define max(a, b) \
>         ({ \
>                 typeof(a) __a = (a); \
>                 typeof(b) __b = (b); \
>                 MINMAX_ASSERT_COMPATIBLE(typeof(__a), typeof(__b)); \
>                 __a > __b ? __a : __b; \
>         })
> 
> 
> Probably need to do
> next = time_after(jiffies+1, sd->last_balance + interval) ? jiffies+1 : sd->last_balance + interval;

Yep, that's what I thought it should look like. There's a small chance jiffies
would have changed between the 2 reads though. I can't see how this would cause
a problem, so we should be fine.

Would it be more useful (and readable) to have time_min()/time_max() wrappers?
This type of usage is rare but it'll help to have a common way to handle this
scenario.

Naming might get controversial though :-); time_earliest()/time_latest() could
be another option.

The wrapper is nice to have for me, so feel free to ignore the suggestion.

Thanks

--
Qais Yousef
