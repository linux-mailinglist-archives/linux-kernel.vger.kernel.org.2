Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC233365F87
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 20:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbhDTSh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 14:37:57 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:41644 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbhDTSh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 14:37:56 -0400
Received: by mail-lf1-f44.google.com with SMTP id q22so522358lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 11:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lStF9MK/8yS06upemmH0HWNt9F0SraomB6Sr+wgIJH8=;
        b=fcycPbNul/XOWSjyDY3MdGKW8LDAIzRgNIHoKGt2ZE43jTuPvh4luhcy0/u+ERs5nZ
         NH7DVF6zn/kMg+mFcRSdoaty6hLvxAkNlHd9+DdbSOcK9NVujIC2f3RQoxKIb1KClwkQ
         epNUGGXaPlqaiP7mJHhefAK/I7gd/4yDgxjANWb2H1GeO3z8mJ2wJ9312BA88FDaxHlQ
         dlmSTlCIGYmnMBwEXEvY6nYI4C5y0ta43y+2ZyGB6cCj1+0EkcgzgXh4/MFIUyjiLLbu
         whe4IA27q0KQZrJjuOPLzViDW1jaEhyVwsI/Q4RPW9LYfZ6ttvViAW05KQ409GIP3U79
         cUXQ==
X-Gm-Message-State: AOAM530FlKo+lWoa/mQJC5rvsiQ7nAqxfPvqKnZxDT5vPlvtL2sE8+il
        eIFs+9DxhPWp8RwcdkfiizV4b3f4YRUaO5JFKeM=
X-Google-Smtp-Source: ABdhPJxT/5fiPG0yRBp2L0EUMC9wQt3revYf/jMHnh7YFSnnrHj1QAH9x72y98OSUnkRq6qmakmPT9TnWSuedcxF0iE=
X-Received: by 2002:a19:9106:: with SMTP id t6mr13839417lfd.300.1618943843573;
 Tue, 20 Apr 2021 11:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210413155337.644993-1-namhyung@kernel.org> <20210413155337.644993-2-namhyung@kernel.org>
 <YHhS6kjeA8AvcFgz@hirez.programming.kicks-ass.net> <CAM9d7civd59i4hquyxExQALcxOeDxk_ODpJwCRr-Rm3iMeahxQ@mail.gmail.com>
 <YH6s3P/3hQxI21eO@hirez.programming.kicks-ass.net>
In-Reply-To: <YH6s3P/3hQxI21eO@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 21 Apr 2021 03:37:11 +0900
Message-ID: <CAM9d7chaxr4o3iY1Y+Z9W0C5rZ7gazvUA2U+Uq_L6CHaHsFqGA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] perf/core: Share an event with multiple cgroups
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Tejun Heo <tj@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, Apr 20, 2021 at 7:28 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Apr 16, 2021 at 06:49:09PM +0900, Namhyung Kim wrote:
> > On Thu, Apr 15, 2021 at 11:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > +static void perf_update_cgroup_node(struct perf_event *event, struct cgroup *cgrp)
> > > > +{
> > > > +     u64 delta_count, delta_time_enabled, delta_time_running;
> > > > +     int i;
> > > > +
> > > > +     if (event->cgrp_node_count == 0)
> > > > +             goto out;
> > > > +
> > > > +     delta_count = local64_read(&event->count) - event->cgrp_node_count;
>
> From here...
>
> > > > +     delta_time_enabled = event->total_time_enabled - event->cgrp_node_time_enabled;
> > > > +     delta_time_running = event->total_time_running - event->cgrp_node_time_running;
> > > > +
> > > > +     /* account delta to all ancestor cgroups */
> > > > +     for (i = 0; i <= cgrp->level; i++) {
> > > > +             struct perf_cgroup_node *node;
> > > > +
> > > > +             node = find_cgroup_node(event, cgrp->ancestor_ids[i]);
> > > > +             if (node) {
> > > > +                     node->count += delta_count;
> > > > +                     node->time_enabled += delta_time_enabled;
> > > > +                     node->time_running += delta_time_running;
> > > > +             }
> > > > +     }
>
> ... till here, NMI could hit and increment event->count, which then
> means that:
>
> > > > +
> > > > +out:
> > > > +     event->cgrp_node_count = local64_read(&event->count);
>
> This load doesn't match the delta_count load and events will go missing.
>
> Obviously correct solution is:
>
>         event->cgrp_node_count += delta_count;
>
>
> > > > +     event->cgrp_node_time_enabled = event->total_time_enabled;
> > > > +     event->cgrp_node_time_running = event->total_time_running;
>
> And while total_time doesn't have that problem, consistency would then
> have you do:
>
>         event->cgrp_node_time_foo += delta_time_foo;
>
> > >
> > > This is wrong; there's no guarantee these are the same values you read
> > > at the begin, IOW you could be loosing events.
> >
> > Could you please elaborate?
>
> You forgot NMI.

Thanks for your explanation.  Maybe I'm missing something but
this event is basically for counting and doesn't allow sampling.
Do you say it's affected by other sampling events?  Note that
it's not reading from the PMU here, what it reads is a snapshot
of last pmu->read(event) afaik.

Thanks,
Namhyung
