Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D096334CF32
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 13:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhC2Lgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 07:36:47 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:45763 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbhC2LgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 07:36:18 -0400
Received: by mail-lf1-f50.google.com with SMTP id g8so17893875lfv.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 04:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bu4Nyj0ob4cbzjgzDMDApmQMSmzS0WCqRPLdHYz7dU4=;
        b=Zz2FiN+XgOaXVodCyZ/Z2m5OmKL9S/MIztrKWYOV+P90TZehECHnCr80zd2qievNzi
         UJ32jhGwk7Sh1Y5xIyWqxaHX1LZmFjpu3CHZKzLH6bvZ45fyh7FABE6s2kAOu4IrvIH9
         gPhCUBdbj8Jx5F4w2nahRGRNDliBT1RpgP3nOnKOR8q2iTZB9CUPyUEML8qdl1pyt9aq
         RW+mmq1cw6ar4o0j3mlaCNkazVHivE4GZxTijcE1K5kVxNJAEvHKQR//S88x3fChB69W
         HLpU1QmJP5COmFpa686ZbbOtYehwuPA77/vPLY26IwCkIJMtav3KJPNuN70lflYRtIzu
         y/Cw==
X-Gm-Message-State: AOAM531JW8pcLm6ltMeMjwnrRvQjtLdb+o6etmXG/Yy/B7VaQh+80+ZL
        +o6dGnUrm7SEwvcKl9dYhx7mnc11At+vZ/1Pvxg=
X-Google-Smtp-Source: ABdhPJwVsJ9zXfroqWRHBWeJ5ocdrhjGw+nbSFE5qJJBIpRp4CuM670Tkf/SVUaqgH+Kp9jBlyhQ9xSl9Vi+j4++aqw=
X-Received: by 2002:a05:6512:36c8:: with SMTP id e8mr15510382lfs.635.1617017777328;
 Mon, 29 Mar 2021 04:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210323162156.1340260-1-namhyung@kernel.org> <20210323162156.1340260-3-namhyung@kernel.org>
 <E7B865AC-5160-40B1-9C06-0E790EEEB6EC@fb.com>
In-Reply-To: <E7B865AC-5160-40B1-9C06-0E790EEEB6EC@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 29 Mar 2021 20:36:06 +0900
Message-ID: <CAM9d7cjqPrASpnVsE-cmG1ZxM4mim=aop4k2dUGNKrcNzzK6-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf/core: Support reading group events with shared cgroups
To:     Song Liu <songliubraving@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 2:32 AM Song Liu <songliubraving@fb.com> wrote:
> > On Mar 23, 2021, at 9:21 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > This enables reading event group's counter values together with a
> > PERF_EVENT_IOC_READ_CGROUP command like we do in the regular read().
> > Users should give a correct size of buffer to be read.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> > kernel/events/core.c | 119 +++++++++++++++++++++++++++++++++++++++++--
> > 1 file changed, 116 insertions(+), 3 deletions(-)
> >
>
> [...]
>
> > +}
> > +
> > +static int perf_event_read_cgrp_node_group(struct perf_event *event, u64 cgrp_id,
> > +                                        char __user *buf)
> > +{
> > +     struct perf_cgroup_node *cgrp;
> > +     struct perf_event_context *ctx = event->ctx;
> > +     struct perf_event *sibling;
> > +     u64 read_format = event->attr.read_format;
> > +     unsigned long flags;
> > +     u64 *values;
> > +     int n = 1;
> > +     int ret;
> > +
> > +     values = kzalloc(event->read_size, GFP_KERNEL);
> > +     if (!values)
> > +             return -ENOMEM;
> > +
> > +     values[0] = 1 + event->nr_siblings;
> > +
> > +     /* update event count and times (possibly run on other cpu) */
> > +     (void)perf_event_read(event, true);
> > +
> > +     raw_spin_lock_irqsave(&ctx->lock, flags);
> > +
> > +     cgrp = find_cgroup_node(event, cgrp_id);
> > +     if (cgrp == NULL) {
> > +             raw_spin_unlock_irqrestore(&ctx->lock, flags);
> > +             kfree(values);
> > +             return -ENOENT;
> > +     }
> > +
> > +     if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
> > +             values[n++] = cgrp->time_enabled;
> > +     if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
> > +             values[n++] = cgrp->time_running;
> > +
> > +     values[n++] = cgrp->count;
> > +     if (read_format & PERF_FORMAT_ID)
> > +             values[n++] = primary_event_id(event);
> > +
> > +     for_each_sibling_event(sibling, event) {
> > +             n += perf_event_read_cgrp_node_sibling(sibling, read_format,
> > +                                                    cgrp_id, &values[n]);
> > +     }
> > +
> > +     raw_spin_unlock_irqrestore(&ctx->lock, flags);
> > +
> > +     ret = copy_to_user(buf, values, n * sizeof(u64));
> > +     kfree(values);
> > +     if (ret)
> > +             return -EFAULT;
> > +
> > +     return n * sizeof(u64);
> > +}
> > +
> > +static int perf_event_read_cgroup_node(struct perf_event *event, u64 read_size,
> > +                                    u64 cgrp_id, char __user *buf)
> > +{
> > +     u64 read_format = event->attr.read_format;
> > +
> > +     if (read_size < event->read_size + 2 * sizeof(u64))
>
> Why do we need read_size + 2 u64 here?

I should've repeated the following description in the patch 1.

 * PERF_EVENT_IOC_READ_CGROUP - it takes a buffer consists of a 64-bit
     array to get the event counter values.  The first element is size
     of the array in byte, and the second element is a cgroup id to
     read.  The rest is to save the counter value and timings.

Thanks,
Namhyung
