Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6D73A33C9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 21:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhFJTSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 15:18:23 -0400
Received: from mail-qv1-f52.google.com ([209.85.219.52]:41650 "EHLO
        mail-qv1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhFJTSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 15:18:22 -0400
Received: by mail-qv1-f52.google.com with SMTP id x2so14629491qvo.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 12:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oEUq6PRtk2+KwPWA8PsdACW/flkPVXr2oIuLoBeXcIA=;
        b=dJmaDHFNcTY9Iu2JChRODk288p22hR3sXhCHjHxMjLhPtEbWPQyJ9vmXKJPA57RuYw
         i8D37pv3aqM/VZ4hso039QmU3ZMbpioO+K0f2fV6ofjoDzA6OQm2QsLIa+qnKKyPg0K/
         3007zurkBZnZY2JL1US8aiix2dQyuqODk4+BtUNU9spDwFAxVVraKo+ag13YVNN82B29
         aGYozSBbnFD/h6cVuHLrx5X9ngi1h0rcn5BM6PUihLR/CFAdDv/tI34bhhOcMrLR/js+
         a0gT/gajJpUPLF2ugnZiYWeEypUI7DF8rrt2s00dsVYFFihZga4yAotjBbuqBlpFC9VS
         pxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oEUq6PRtk2+KwPWA8PsdACW/flkPVXr2oIuLoBeXcIA=;
        b=ivH4LZadQPFXFlYHSZlq0kU3yCcHaeoUL7on4vBXOsgRML+p8H97dsucKvfQytotg3
         +PpKrvyB6CbKLQxHmiY662aFrVMz89RPSA1h2Yk1Uvgj6NMgp2lDar22aw3t/cYRgCcu
         8bkR+XF2vmmvzhnlCIAQIwtdY2QCplDzOyaKPm0fURd7pWjTUj0J8zGgoUfoFJwafB3i
         tr7YhT357rmjBT1kIDHK8Hm+JD4Cr2FpzJ3IS1nKjYRNVo1wUemufQqY75579ctMHLK4
         TeTK6oIiKCGzyBV/AU+mcRaSosPH91SYg6J4k0U739KSXH7sRkAYWrw8Ts5NxLiuKqKH
         z/ug==
X-Gm-Message-State: AOAM533qYrCJcjPiRDpzL29wVPN+DEOgHO9abB73J3agGkREWqK7XMjd
        oKhkT17GGpYJ05X3mHssxCrzypQz5x3n1u/vTeml9w==
X-Google-Smtp-Source: ABdhPJzAVKz/mIvy6XgYB/nG0FmvToBVD01LGEZHGu6mfM32iUahtd0gtE+dhxwph0VaBSjJ6FY89cIWjuRaKBFq7l4=
X-Received: by 2002:ad4:5d67:: with SMTP id fn7mr1178435qvb.1.1623352508999;
 Thu, 10 Jun 2021 12:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210608231132.32012-1-joshdon@google.com> <e3fc3338-c469-0c0c-ada2-a0bbc9f969fe@arm.com>
In-Reply-To: <e3fc3338-c469-0c0c-ada2-a0bbc9f969fe@arm.com>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 10 Jun 2021 12:14:57 -0700
Message-ID: <CABk29Nu=mxz3tugjhDV9xCF7DRsMi9U747H+BqubviEva36RUw@mail.gmail.com>
Subject: Re: [PATCH] sched: cgroup SCHED_IDLE support
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Dietmar,

On Thu, Jun 10, 2021 at 5:53 AM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> Any reason why this should only work on cgroup-v2?

My (perhaps incorrect) assumption that new development should not
extend v1. I'd actually prefer making this work on v1 as well; I'll
add that support.

> struct cftype cpu_legacy_files[] vs. cpu_files[]
>
> [...]
>
> > @@ -11340,10 +11408,14 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
> >
> >  static DEFINE_MUTEX(shares_mutex);
> >
> > -int sched_group_set_shares(struct task_group *tg, unsigned long shares)
> > +#define IDLE_WEIGHT sched_prio_to_weight[ARRAY_SIZE(sched_prio_to_weight) - 1]
>
> Why not 3 ? Like for tasks (WEIGHT_IDLEPRIO)?
>
> [...]

Went back and forth on this; on second look, I do think it makes sense
to use the IDLEPRIO weight of 3 here. This gets converted to a 0,
rather than a 1 for display of cpu.weight, which is also actually a
nice property.
