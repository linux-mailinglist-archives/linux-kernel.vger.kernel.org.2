Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070113A9680
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbhFPJvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbhFPJvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:51:52 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29A4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:49:46 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id l64so2348719ioa.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LxB+IQLZR5N9B2nYLXOs5+gY2uv3PsGPWHonZYoGyjw=;
        b=cMKC6YOTPQ94fzluTZjiJqxq7SN4G1zuF/UVrC4wvkLIs0NVMCuBHa5lotpxbx2KIa
         VakGWAap42UJ0lY4UUZjhJGjH62hhio7YJa6AVE/kiyvRJHHZJJN+Rqd9p21qfk+f8la
         KWnelqD3xRxgapocrqY6vvSS3Nh1DAl9cDXRe2L2VSQqIxaqTMm2ZomIp+H9NJzBIX/J
         tL6R++pS7JDSqFmlqqr1YtEvE0ItrimmiIDUIqFZKumhzlgKrhNxQoMgYB7A640nSzlv
         IlUhRZ9KHajMBEgHen1FMad1GFE3AeFzI/0qlrRm3pWlOZuQEDtf+ZCwTObpvG4yQW+o
         KTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LxB+IQLZR5N9B2nYLXOs5+gY2uv3PsGPWHonZYoGyjw=;
        b=G1VJAY/XWZUlYGqu+oFec5HaRzw5vvabO9DuzE2nqNKt2SMUBlWW8eA5DvZxwFV0y3
         nAHXPWJxAXIVgwBlmksacaqJys9a1Z3uqcqgN9f1Kkjhl2VYEruJiahkCncVrbhcsovl
         NXwCcLLwoxWpCcjqM8uckexLHh/FRQZhe0BYYAQguscPF2W8MJRDGWh2I4Vx4eKc3Tua
         lgUEQvWrKrWNtDUHN6lTweNrprIvMyjmKklc6+W7Oe8kEhodg1GQ2I3KfRbH7YMlmZ1E
         rRUXxO8saoQSvz3DfMXim5laRgDYI1n6QZlG0+rpi0XRn2ao4zFpw4KfieqgeghPTtha
         PDLg==
X-Gm-Message-State: AOAM531ar22KMzXz7uzSfrKC94WOpywjjAW/d+BuQqnDtucr6wTjQa1H
        pYr8BR8nXcqF0BpUKhFCYQnUpiiMM3GtMOsTlIM=
X-Google-Smtp-Source: ABdhPJwXL6SYKzNM7RxGYo7SY/DtbHynxedN3lQBC0xMKKPI6GceOuGnViy9QUvFx+Krvgjy1p6ZBR5UVQ8/wJBVUhY=
X-Received: by 2002:a02:6f5e:: with SMTP id b30mr3421548jae.94.1623836986120;
 Wed, 16 Jun 2021 02:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210615121551.31138-1-laoar.shao@gmail.com> <20210615203534.GA4272@worktop.programming.kicks-ass.net>
 <CALOAHbBuZJaK+fEg7toRUHJNP8rJKDoADeAUxorUuNU17kdTOA@mail.gmail.com>
 <YMmlAP/QhE6SWhCF@hirez.programming.kicks-ass.net> <CAKfTPtAh3eOtzZUPqmhkw6FAOjOietZrB_qMOfOprp0oWO+CvA@mail.gmail.com>
 <YMm2bWq9XfaPeSka@hirez.programming.kicks-ass.net>
In-Reply-To: <YMm2bWq9XfaPeSka@hirez.programming.kicks-ass.net>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 16 Jun 2021 17:49:10 +0800
Message-ID: <CALOAHbAJNu_2ZbSsuNB0DkjWQkfxxbMj5TuFo+cK8QKoHLEUZQ@mail.gmail.com>
Subject: Re: [PATCH] sched, fair: try to prevent migration thread from
 preempting non-cfs task
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 4:29 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jun 16, 2021 at 09:29:55AM +0200, Vincent Guittot wrote:
> > On Wed, 16 Jun 2021 at 09:15, Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > The suggestion was adding a cfs_migration thread, specifically for
> > > active balance (and maybe numa). Just not sure the cost of carrying yet
> > > another per-cpu kernel thread is worth the benefit.
> >
> > Also, this will not completely remove the problem but only further
> > reduce the race window because the rq is locked and the irq disable in
> > active_load_balance_cpu_stop().
>
> It removes the problem of active migration interfering with this
> worklaod, because the FIFO1 task will never run until that is done
> (assuming he manages to not have his workload at FIFO1).
>

Right, the workload should have a higher priority than FIFO1 then.

I'm wondering why not just setting some flags to the running CFS and
then when the CFS task scheds out the CPU we migrate it to the new
idle CPU in active LB. Then we don't need to preempt any task.

-- 
Thanks
Yafang
