Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFCA3AFAAD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 03:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhFVBp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 21:45:58 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:37800 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhFVBp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 21:45:57 -0400
Received: by mail-lf1-f46.google.com with SMTP id p7so33112175lfg.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 18:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TXDqLolP621pCqjqM6Wu4NTyyMVGI6nrVZk8yNegMN8=;
        b=LvN/YkCzJ9kZbsDy6BxLeb9dTFVkBqYpoax+Y6U+IIAs5ZCM+zj1c0YL+iBoVviXqm
         85BkB1wfrRVqllACFv4XSGmNHADro+ld4HGUQn6nPDq077kby2/h2DY7sJDUsTPnzwfK
         Q7W1DHOchmhVbtyFasVyWlkB0ASP9HrNOZvjMzJCXyXe6qmncmvgQ1s5KI5UhXS7U7uf
         WPA47p0goccF+eR6KW07yos1It5g52BOiDfVHAZezgBSpqVJnKNTDalTyqBwBQN3oikC
         pr1eFbvZUkoa7PenQyAUeXz0G4rkoOEGugeywEZM5YV5lDGpH5YhFyGmU00RNQL3sBu0
         KBgQ==
X-Gm-Message-State: AOAM5311y0anLQJ56v4+o6nji9Hp9ABSmmMXY3nSv7JOkwzZIOBBMblF
        zK84S4/5lVk0aygfiJcttcK/b+Xwhp87iAfAHAI=
X-Google-Smtp-Source: ABdhPJwmBsVQ/H5BTNqDMDSz+5SCuBH4TL7EiBjtv1beHiPPkXInI/6UkPCV4WucpbJDcp2kGbai8Uwd/S89Li1YE/w=
X-Received: by 2002:a19:7b1c:: with SMTP id w28mr876566lfc.509.1624326220592;
 Mon, 21 Jun 2021 18:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210615011724.672612-1-namhyung@kernel.org> <YMoVOp4+TIUViBb7@hirez.programming.kicks-ass.net>
 <CAM9d7cj2UhQsd2vx8_C8C_CEW2QQbzs741jCn7f7g-e0i9OiOg@mail.gmail.com>
 <20210616223212.GE4272@worktop.programming.kicks-ass.net> <55A8ECB0-0299-4A07-B285-E9F0D611E822@fb.com>
In-Reply-To: <55A8ECB0-0299-4A07-B285-E9F0D611E822@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 21 Jun 2021 18:43:29 -0700
Message-ID: <CAM9d7cibDFdua2=SXBL2yNBFD7dYGs0H+ZOL_rhEzzjrP5ReLQ@mail.gmail.com>
Subject: Re: [PATCHSET v2 0/3] perf stat: Enable BPF counters with --for-each-cgroup
To:     Song Liu <songliubraving@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

On Wed, Jun 16, 2021 at 11:33 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Jun 16, 2021, at 3:32 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Jun 16, 2021 at 09:33:42AM -0700, Namhyung Kim wrote:
> >
> >>> That seems unfortunate; there's no bpf helper to iterate cgroup
> >>> hierarchy?
> >>
> >> I couldn't find one..
> >
> > Song, is that something that would make sense to have?
>
> I think we can solve this with bpf_get_current_ancestor_cgroup_id and
> a bounded loop. Like:
>
>         /* get diff_reading, which is reading - prev_reading */
>
>         for (i = 0; i < 10 /* at most 10 levels */; i++) {
>                 __u64 cgroup_id = bpf_get_current_ancestor_cgroup_id(i);
>                 if (!cgroup_id)
>                         break;
>                 /* add diff_reading to cgroup_id */
>         }

OK, but I'm not sure 0 id is guaranteed.

>
> >
> >>>> * there's no reliable way to trigger running the BPF program
> >>>
> >>> You can't attach to the PERF_COUNT_SW_CGROUP_SWITCHES event?
> >>
> >> I did it.  But the BPF test run seems not to work with perf_event.
> >> So it needs to trigger a cgroup switch manually..
> >
> > AFAICT it should be possible to set a bpf prog on a software event.
> > perf_event_set_bpf_prog() will take the first branch
> > (!perf_event_is_tracing()) and call perf_event_set_bpf_handler().
> >
> > That should then result in running the bpf program every time the event
> > would generate a sample.
> >
> > So if you configure the event to sample on every single event, it should
> > then run your program every time.
> >
> > This is all from looking at the code, because I really can't operate any
> > of that for real. I suspect Song can help out.
> >
> > The alternative is to attach a BPF program to the sched_switch
> > tracepoint and do the cgroup filter in BPF.
>
> We can create a raw_tp BPF program just for BPF_PROG_TEST_RUN (now also called
> BPF_PROG_RUN). The program should be the same as current on_switch program.
> We don't have to attach the program, just use BPF_PROG_RUN to trigger it.
>
> Would something like this work?

Oh, I think it'd work.  Thanks for the suggestion!

Thanks,
Namhyung
