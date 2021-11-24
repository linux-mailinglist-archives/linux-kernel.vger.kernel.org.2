Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DC245BA29
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 13:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242283AbhKXMIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 07:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242339AbhKXMGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 07:06:17 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF6BC061746
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 04:02:13 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id r25so9261504edq.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 04:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NNp4cNdsSBxEhYMArNtagpqcYNtTdbkpoBR3SS9L4Yk=;
        b=hme5ntJ7ScZ4oKsEQrrngSo71MkD7Qe1XKvxk+0YIhazvBSi/1eJOxKfTIZ8Abjt2H
         rPaVqKJHvrIDecNLuJiZ5RIBT+mMMwe7sjZlH4Nq/2SrwJ9BAmit7GHwKdMqiG7KwVsL
         6wp1dzLaWhZSYVWJKyYWwEH5FI7EOHrrCNWxdNQqkhCqm7sICmPp+iMd34sd3oIn4prS
         dqAQsw99Dm/KwL5qgw/6+55dNVEp4RWGnlZwDm7SbqrajSjC1Ayw0tKlkMwLGdrcEzgs
         6Fr6H41nOzTph9BBAmiWj0w92y+8e0NVD8crXKw0zbiMwVSlIF+DAWpBBlmOQlerp9zc
         zU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NNp4cNdsSBxEhYMArNtagpqcYNtTdbkpoBR3SS9L4Yk=;
        b=j+bh5EqqI6Z+PKuLIasAfr3KQHphUnsgPpA+TEwId4Gcg0te8963aX7MleIgIlknfc
         3v03gPtvMGHEzaYjbHh3SX8DkUq8aAjefPFl9Zoyh3+XrbrfqIxZP0R+I54kNIuuVJlG
         ObsNPVoIfcW1qNjAVv76zFo/T7ax+f6wdjHgxksMAWQoR9n9SO0sfXNTydm/yQixlL8m
         qoiX24Fu6gLt4h4EQ/2TB5Vy8/9oA+1gN6ErNkOT7uvCI6m/l+8X3+dmmAQimNIWsTph
         QZ7IH70A29akoDaJbkq2oA4xbD+54Dlxd6lDJ+6I+dr821BECfMgOlfMcu7V8IpWxNnr
         ieow==
X-Gm-Message-State: AOAM5320Wfoja4n2tLvBgqiJWx0/FF0GgzjnCyT+AV1JAZObM8JuRV6+
        JIAPa3wnj5lqiFNjfEzRzFwcLDoBKlqjM8iImus=
X-Google-Smtp-Source: ABdhPJxX/6OfJdK5+DPFqCpBAnY+GCcZ3/tBhZwaRYC6Zh3rxHOT/wscsZkRS7q0abdm9O8pIGSWqZEAw/KwRl0r1N0=
X-Received: by 2002:a17:907:3f18:: with SMTP id hq24mr19364132ejc.506.1637755331581;
 Wed, 24 Nov 2021 04:02:11 -0800 (PST)
MIME-Version: 1.0
References: <20211124091546.5072-1-21cnbao@gmail.com> <YZ4eWHarf7QDONLB@hirez.programming.kicks-ass.net>
 <CAGsJ_4xpqvhBW0G5UfCjRD8BfR4m4EUv4B_cxoOtYTO5+iRsCQ@mail.gmail.com> <CAGsJ_4yHToqZZ9R59jd0391mE0tAzxDFSvhSV24gx9c5JNvO4w@mail.gmail.com>
In-Reply-To: <CAGsJ_4yHToqZZ9R59jd0391mE0tAzxDFSvhSV24gx9c5JNvO4w@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 25 Nov 2021 01:02:00 +1300
Message-ID: <CAGsJ_4zpN98_J2aRHyqz4XvSzP+0ngVu2k=ufn9JQNMwe7zZjw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Remove the cost of a redundant
 cpumask_next_wrap in select_idle_cpu
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 12:57 AM Barry Song <21cnbao@gmail.com> wrote:
>
> On Thu, Nov 25, 2021 at 12:49 AM Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Thu, Nov 25, 2021 at 12:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Nov 24, 2021 at 05:15:46PM +0800, Barry Song wrote:
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 6e476f6..8cd23f1 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -6278,6 +6278,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> > > >               time = cpu_clock(this);
> > > >       }
> > > >
> > > > +     --nr;
> > > >       for_each_cpu_wrap(cpu, cpus, target + 1) {
> > > >               if (has_idle_core) {
> > > >                       i = select_idle_core(p, cpu, cpus, &idle_cpu);
> > > > @@ -6285,11 +6286,11 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> > > >                               return i;
> > > >
> > > >               } else {
> > > > -                     if (!--nr)
> > > > -                             return -1;
> > > >                       idle_cpu = __select_idle_cpu(cpu, p);
> > > >                       if ((unsigned int)idle_cpu < nr_cpumask_bits)
> > > >                               break;
> > > > +                     if (!--nr)
> > > > +                             return -1;
> > > >               }
> > > >       }
> > >
> > > This way nr can never be 1 for a single iteration -- it current isn't,
> > > but that's besides the point.
> >
> > Yep. nr=1 seems to be a corner case.
> > if nr=1, the original code will return -1 directly without scanning
> > any cpu. but the new code will scan
> > one  time because I haven't checked if(!--nr)  and return before
> > for_each_cpu_wrap(). so this changes
> > the behaviour for this corner case.
> >
> > but if i change "--nr" to "nr--", this new code will scan nr  times
> > rather than nr-1, this changes the behaviour
> > for all cases besides nr!=1. The original code was looping nr times
> > but scanning nr-1 times only.
> >
> > so you prefer here the codes should scan nr times and change the
> > scanning amount from nr-1
> > to nr?
>
> Let me make it clearer. if nr=5, the original code will  loop 5 times,
> but in the 5th loop, it returns directly, so  __select_idle_cpu is
> only done 4 times.
>
> if nr=1, the original code will  loop 1 time, but in the 1st loop,
> it returns directly, so  __select_idle_cpu is  done 0 times.

this is also why in the first version of patch, i did this:
                span_avg = sd->span_weight * avg_idle;
                if (span_avg > 4*avg_cost)
-                       nr = div_u64(span_avg, avg_cost);
+                       nr = div_u64(span_avg, avg_cost) - 1;
                else
-                       nr = 4;
+                       nr = 3;

because we are actually scanning 3 times or div_u64(span_avg, avg_cost) - 1
times but not 4 times or div_u64(span_avg, avg_cost) times.

this is not confusing at all. the only thing which is confusing is the original
code.

>
> if i change the code to if(!nr--), while nr=5, the new code will
> do  __select_idle_cpu() 5 times rather than 4 times in the
> original code.
>
> but of course the new code changes the  __select_idle_cpu
> from zero to one time for the corner case nr==1.
> >
> > Thanks
> > Barry
