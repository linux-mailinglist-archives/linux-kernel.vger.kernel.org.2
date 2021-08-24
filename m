Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFE63F5673
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 05:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbhHXDIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 23:08:12 -0400
Received: from out0.migadu.com ([94.23.1.103]:28277 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233971AbhHXDB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 23:01:56 -0400
Date:   Tue, 24 Aug 2021 11:01:50 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1629774058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TNl6fhGOST2/fJOT5KEyUhanXPoPPIsfVeF9RTPm3f8=;
        b=M1FedzS7dQXLVds3lnVYJWxcBJ1+V8R/nEnRHhP1Xgg0e9N1DH/ncbGJPPjxOZMt8YedDp
        uRQvfFI5hMbYogoHY+lKFi8i0TD/SdTqd+22aVQ09qPYvf7OE7D0qCyMS1BlsdwrLEOSHu
        bd3vyV5/kFdwd83pyRM0titMuhDArt4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineethrp@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, tao.zhou@linux.dev
Subject: Re: [PATCH] sched/core: fix pick_next_task 'max' tracking
Message-ID: <YSRhHvxhWBDvpucV@geo.homenetwork>
References: <20210818005615.138527-1-joshdon@google.com>
 <YSODqN9G7VuV+kNR@hirez.programming.kicks-ass.net>
 <CABk29Ns-aiSjf8WTWL5U0ggKr32NKC3Q6ANJ8MheDP5P-k_JuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Ns-aiSjf8WTWL5U0ggKr32NKC3Q6ANJ8MheDP5P-k_JuA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

On Mon, Aug 23, 2021 at 04:24:26PM -0700, Josh Don wrote:
> Hi Peter,
> 
> On Mon, Aug 23, 2021 at 4:17 AM Peter Zijlstra <peterz@infradead.org> wrote:
> [snip]
> > +       for_each_cpu(i, smt_mask) {
> > +               rq_i = cpu_rq(i);
> > +               p = rq_i->core_temp;
> >
> > -                       /*
> > -                        * If this sibling doesn't yet have a suitable task to
> > -                        * run; ask for the most eligible task, given the
> > -                        * highest priority task already selected for this
> > -                        * core.
> > -                        */
> > -                       p = pick_task(rq_i, class, max, fi_before);
> > +               if (!cookie_equals(p, cookie)) {
> > +                       p = NULL;
> > +                       if (cookie)
> > +                               p = sched_core_find(rq_i, cookie);
> 
> In the case that 'max' has a zero cookie, shouldn't we search for a

In the original pick_task(), when cookie is zero, we choose class pick
task or force idle task.

> match on this cpu if the original class pick ('p') had a non-zero
> cookie? We don't enqueue tasks with zero cookie in the core_tree, so I
> forget if there was some other reasoning here.

So, no need to search the core_tree when cookie is zero.

But I'm not sure that force idle pick condition(in pick_task())
is also covered by this clause in the first filter max loop in
the rewrite..
  
  '
  if (!max || prio_less(max, p, fi_before))
		max = p;
  '

I just thought there are three(one add by Josh) places that can return
max;

1, !cookie condition and class_pick > max
2, cookie equal condition and class_pick > max(add by Josh)
3, cookie not equal condition and class_pick > max.

The rewrite change a little with the class pick, it loops all class to
find the max first(finally will get one task and not be possible return
NULL). This is not the same with the original.

It is very possible that I'm getting wrong, then please shout to me.

> >                         if (!p)
> > -                               continue;
> > +                               p = idle_sched_class.pick_task(rq_i);
> > +               }



Thanks,
Tao
