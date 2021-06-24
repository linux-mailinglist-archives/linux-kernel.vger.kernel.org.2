Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC703B3922
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 00:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhFXWXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 18:23:49 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:46702 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhFXWXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 18:23:48 -0400
Received: by mail-lj1-f177.google.com with SMTP id q4so1451106ljp.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 15:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lh0L8yoPQW7cnKA8XRKrnLUN6V8Dx3IYxeqDJEPSWQA=;
        b=iAs3GO53wFQQ4EmlH139ZlI48Oxjm6G34hvhC086Vep8I0qy3UIT/S2U74xZnkApPo
         K+UPMAuev1dgaGIvmL3RzWrAUMSDpOC9F8HE+h61vG3TYJ/xd2OKA/xSPDhMPs8JO8Qz
         DK2NeQbKzfPUjdTx4P3wnMqSicCEjWH8kPyXWH94OcDG99FpCJfBSeX0+uO7kS+YYDUW
         Yvv7kivvFya08g8ASF2H14T2bRXqnZZKoKhBHpHjGEsdKsD/hI4V5ieC3m7dsRMc2Xh/
         Dzgd9bID55Gn0IIgeu/5joqt1P3ohl1H2JR1WyJz6MJxfE5ydbsrKl1ta/m7wT1tcA7F
         Jsvg==
X-Gm-Message-State: AOAM530KIEs20tXi2vkLfNp4uTv1/hMUE0M5WUCXIk+qUO6LP1mSq1aJ
        i59/s7fHsOai8kArKWB5sjsemsEUDODUzlk6w5Y=
X-Google-Smtp-Source: ABdhPJye11lFjT9dDjL8nqV/NsUvJuTP+k+G3ZwpSe2PX/AxUaJii0JYULs2cs2R2xUaQRoOsy5Qlph/ZEAGJwPOB2U=
X-Received: by 2002:a05:651c:324:: with SMTP id b4mr5632419ljp.166.1624573287522;
 Thu, 24 Jun 2021 15:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210622071221.128271-1-namhyung@kernel.org> <20210622071221.128271-4-namhyung@kernel.org>
 <C2ABEEDF-04AF-4AB5-BA6C-C8AC5E8579C6@fb.com> <CAM9d7ci3kS+=ObL_mfx1Qi2rQ7SYRjdLQLJ5+SVmRUsaUepj_w@mail.gmail.com>
 <D5859F92-8AB6-4327-9D5F-A67DB14CB493@fb.com> <CAM9d7cgw5ZtuvA2wwEdVU1rL6Hra2Cy4BTHx0rKsNE_ickjN+Q@mail.gmail.com>
 <A157287B-5DE5-4D8D-B8BE-FF18BFAAC16E@fb.com> <CAM9d7chvmH0r85Ezx6kTyDsTM5nWSUDoOjnkEgTkKjE2U5LrVA@mail.gmail.com>
 <84A29E44-7B29-43CE-B91C-8912CA09F939@fb.com>
In-Reply-To: <84A29E44-7B29-43CE-B91C-8912CA09F939@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 24 Jun 2021 15:21:16 -0700
Message-ID: <CAM9d7cjh8zLhx_3jzbQy5zCXpvbkniGUScH1eVntz4iNVCFkyg@mail.gmail.com>
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

On Thu, Jun 24, 2021 at 3:16 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Jun 24, 2021, at 3:06 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, Jun 24, 2021 at 2:41 PM Song Liu <songliubraving@fb.com> wrote:
> >>
> >>
> >>
> >>> On Jun 24, 2021, at 2:01 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> >>>
> >>> On Thu, Jun 24, 2021 at 9:20 AM Song Liu <songliubraving@fb.com> wrote:
> >>>>>>> +
> >>>>>>> +// single set of global perf events to measure
> >>>>>>> +struct {
> >>>>>>> +     __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> >>>>>>> +     __uint(key_size, sizeof(__u32));
> >>>>>>> +     __uint(value_size, sizeof(int));
> >>>>>>> +     __uint(max_entries, 1);
> >>>>>>> +} events SEC(".maps");
> >>>>>>> +
> >>>>>>> +// from logical cpu number to event index
> >>>>>>> +// useful when user wants to count subset of cpus
> >>>>>>> +struct {
> >>>>>>> +     __uint(type, BPF_MAP_TYPE_HASH);
> >>>>>>> +     __uint(key_size, sizeof(__u32));
> >>>>>>> +     __uint(value_size, sizeof(__u32));
> >>>>>>> +     __uint(max_entries, 1);
> >>>>>>> +} cpu_idx SEC(".maps");
> >>>>>>
> >>>>>> How about we make cpu_idx a percpu array and use 0,1 for
> >>>>>> disable/enable profiling on this cpu?
> >>>>>
> >>>>> No, it's to calculate an index to the cgrp_readings map which
> >>>>> has the event x cpu x cgroup number of elements.
> >>>>>
> >>>>> It controls enabling events with a global (bss) variable.
> >>>>
> >>>> If we make cgrp_idx a per cpu array, we probably don't need the
> >>>> cpu_idx map?
> >>>
> >>> Right.
> >
> > Maybe not.  Sometimes we want to profile a subset of cpus only.
> > In that case, cpu != idx then I think we still need this.
>
> We can only attach the bpf program on selected CPUs. Say, we want
> CPUs 1, 3, 5. We just do
>
>         for (i in [1, 3, 5]) {
>                 link = bpf_program__attach_perf_event(skel->progs.on_switch,
>                                                       FD(cgrp_switch, i));
>                 /* */
>         }
>
> The value arrays are still for all cpu, but they will just report zero
> for CPU 0, 2, 4, ....
>
> Would this work?

Yeah, that's exactly what I do, and I'd like to have a compact map
eliminating the unused entries (cpus).  But now I think that I can
keep it with a full cpus and just don't use them.


>
> >>>>> Maybe.  But I don't know how to access the elements
> >>>>> in a per-cpu map from userspace.
> >>>>
> >>>> Please refer to bperf__read() reading accum_readings. Basically, we read
> >>>> one index of all CPUs with one bpf_map_lookup_elem().
> >>>
> >>> Thanks!  So when I use a per-cpu array with 3 elements, I can access
> >>> to cpu/elem entries in a row like below, right?
> >>>
> >>> 0/0, 0/1, 0/2, 1/0, 1/1, 1/2, 2/0, 2/1, 2/2, 3/0, ...
> >>
> >> I am not sure I am following here.
> >>
> >> Say the system have 10 cpus, and the array has 3 elements. We can do:
> >>
> >>        __u32 values[10];  /* assuming both key and value are __u32 */
> >>        __u32 elem;
> >>        int cpu;
> >>
> >>        for (elem = 0; elem < 3; elem++) {
> >>                bpf_map_lookup_elem(map_fd, &elem, values);
> >>                for (cpu = 0; cpu < 10; cpu++)
> >>                        values[cpu] /* this is the value for cpu/elem */
> >>        }
> >
> > Thanks for the explanation, I didn't think that way.
> > I thought it like below:
> >
> >    __u32 elem, value;
> >
> >    for (elem = 0; elem < 3 * 10; elem++) {
> >        bpf_map_lookup_elem(map_fd, &elem, &value);
> >    }
> >
> > So in this case, the actual value size is like below, right?
> >
> >  value-size = map-value-size * number-of-cpu
>
> This is right (for user space).

Thanks for your clarification!

Namhyung
