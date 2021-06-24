Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6DC3B3913
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 00:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbhFXWJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 18:09:24 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:37390 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhFXWJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 18:09:19 -0400
Received: by mail-lf1-f42.google.com with SMTP id p7so12907605lfg.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 15:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Os1/TN/h4NhhToWmiawIUoZc6hd9BmZaTjKdtDTLUhA=;
        b=bmd3LusqqI5gQEq88COlU8+sTyFbg+6Xw1lQpjAC0W5954nbzpU/MYCk+iUicgO8nN
         r6DxhW8Xcx5mChts3ChNsAD9KIGm7veAmL16u+bn8NP7fFHLg0F9ceI5kLPHdkxNeUyW
         e/YIb2w5ldbz53ENcIyEXT0cR6AvEjaEDsKoVkgRftdzyQtbpThVCz7XE9NYcX+yf/1q
         l6dGsL7suR3UEYz7iKiyKfrOgkOjS02DimkGDu/eIPLUHNG5ovrsVSG2RL9MaUq2YFM5
         lT/cbiFVcgwPuPRfdSp+lyu94xbswmkBPD58MSqQDLb2D/hGdI+k7YQ+jpwSD5cNN7y1
         nKkg==
X-Gm-Message-State: AOAM530yl1XtUP5bKUD4DMDV2odAlBFhYroHES3IL67sMovpvRqpvS2v
        3bM187ipmDR/a/l/u+hjhNbTcpnyEKMUwv61CQ0=
X-Google-Smtp-Source: ABdhPJymKmsDDUhrIXSdEHT7+UbwBC6+ZIdknvPo3pFQJOWJT9a/nSV08ZN4JtE/TJRdWJUrb9HI380IEG0mysM7pe0=
X-Received: by 2002:ac2:50da:: with SMTP id h26mr5263152lfm.635.1624572417501;
 Thu, 24 Jun 2021 15:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210622071221.128271-1-namhyung@kernel.org> <20210622071221.128271-4-namhyung@kernel.org>
 <C2ABEEDF-04AF-4AB5-BA6C-C8AC5E8579C6@fb.com> <CAM9d7ci3kS+=ObL_mfx1Qi2rQ7SYRjdLQLJ5+SVmRUsaUepj_w@mail.gmail.com>
 <D5859F92-8AB6-4327-9D5F-A67DB14CB493@fb.com> <CAM9d7cgw5ZtuvA2wwEdVU1rL6Hra2Cy4BTHx0rKsNE_ickjN+Q@mail.gmail.com>
 <A157287B-5DE5-4D8D-B8BE-FF18BFAAC16E@fb.com>
In-Reply-To: <A157287B-5DE5-4D8D-B8BE-FF18BFAAC16E@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 24 Jun 2021 15:06:46 -0700
Message-ID: <CAM9d7chvmH0r85Ezx6kTyDsTM5nWSUDoOjnkEgTkKjE2U5LrVA@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf stat: Enable BPF counter with --for-each-cgroup
To:     Song Liu <songliubraving@fb.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 2:41 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Jun 24, 2021, at 2:01 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, Jun 24, 2021 at 9:20 AM Song Liu <songliubraving@fb.com> wrote:
> >>>>> +
> >>>>> +// single set of global perf events to measure
> >>>>> +struct {
> >>>>> +     __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> >>>>> +     __uint(key_size, sizeof(__u32));
> >>>>> +     __uint(value_size, sizeof(int));
> >>>>> +     __uint(max_entries, 1);
> >>>>> +} events SEC(".maps");
> >>>>> +
> >>>>> +// from logical cpu number to event index
> >>>>> +// useful when user wants to count subset of cpus
> >>>>> +struct {
> >>>>> +     __uint(type, BPF_MAP_TYPE_HASH);
> >>>>> +     __uint(key_size, sizeof(__u32));
> >>>>> +     __uint(value_size, sizeof(__u32));
> >>>>> +     __uint(max_entries, 1);
> >>>>> +} cpu_idx SEC(".maps");
> >>>>
> >>>> How about we make cpu_idx a percpu array and use 0,1 for
> >>>> disable/enable profiling on this cpu?
> >>>
> >>> No, it's to calculate an index to the cgrp_readings map which
> >>> has the event x cpu x cgroup number of elements.
> >>>
> >>> It controls enabling events with a global (bss) variable.
> >>
> >> If we make cgrp_idx a per cpu array, we probably don't need the
> >> cpu_idx map?
> >
> > Right.

Maybe not.  Sometimes we want to profile a subset of cpus only.
In that case, cpu != idx then I think we still need this.


> >
> >>
> >>>
> >>>>
> >>>>> +
> >>>>> +// from cgroup id to event index
> >>>>> +struct {
> >>>>> +     __uint(type, BPF_MAP_TYPE_HASH);
> >>>>> +     __uint(key_size, sizeof(__u64));
> >>>>> +     __uint(value_size, sizeof(__u32));
> >>>>> +     __uint(max_entries, 1);
> >>>>> +} cgrp_idx SEC(".maps");
> >>>>> +
> >>>>> +// per-cpu event snapshots to calculate delta
> >>>>> +struct {
> >>>>> +     __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> >>>>> +     __uint(key_size, sizeof(__u32));
> >>>>> +     __uint(value_size, sizeof(struct bpf_perf_event_value));
> >>>>> +} prev_readings SEC(".maps");
> >>>>> +
> >>>>> +// aggregated event values for each cgroup
> >>>>> +// will be read from the user-space
> >>>>> +struct {
> >>>>> +     __uint(type, BPF_MAP_TYPE_ARRAY);
> >>>>> +     __uint(key_size, sizeof(__u32));
> >>>>> +     __uint(value_size, sizeof(struct bpf_perf_event_value));
> >>>>> +} cgrp_readings SEC(".maps");
> >>>>
> >>>> Maybe also make this a percpu array? This should make the BPF program
> >>>> faster.
> >>>
> >>> Maybe.  But I don't know how to access the elements
> >>> in a per-cpu map from userspace.
> >>
> >> Please refer to bperf__read() reading accum_readings. Basically, we read
> >> one index of all CPUs with one bpf_map_lookup_elem().
> >
> > Thanks!  So when I use a per-cpu array with 3 elements, I can access
> > to cpu/elem entries in a row like below, right?
> >
> >  0/0, 0/1, 0/2, 1/0, 1/1, 1/2, 2/0, 2/1, 2/2, 3/0, ...
>
> I am not sure I am following here.
>
> Say the system have 10 cpus, and the array has 3 elements. We can do:
>
>         __u32 values[10];  /* assuming both key and value are __u32 */
>         __u32 elem;
>         int cpu;
>
>         for (elem = 0; elem < 3; elem++) {
>                 bpf_map_lookup_elem(map_fd, &elem, values);
>                 for (cpu = 0; cpu < 10; cpu++)
>                         values[cpu] /* this is the value for cpu/elem */
>         }

Thanks for the explanation, I didn't think that way.
I thought it like below:

    __u32 elem, value;

    for (elem = 0; elem < 3 * 10; elem++) {
        bpf_map_lookup_elem(map_fd, &elem, &value);
    }

So in this case, the actual value size is like below, right?

  value-size = map-value-size * number-of-cpu

Thanks,
Namhyung
