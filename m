Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A37339B63
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 03:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhCMCsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 21:48:31 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:37304 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbhCMCsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 21:48:02 -0500
Received: by mail-lf1-f41.google.com with SMTP id n16so48437873lfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 18:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YX3RbIt5YnG1YAf8+WjG5K0mJd5hi9bl0zole+0mMuc=;
        b=BKH6dKKpzqqBFmf9mrgKTsNZ3U2DSi8YRDXLb9mcCrbKxXXADs6Z+MCt2bs2qNlJeH
         PrbTC5zQK6u5dYD2BcVKMsDiP6pIBn9mr+dTxyv17Xw/tB/3vsJI/DMqGHBzc4YPJKUQ
         /RBHay2yXd86i2RMiP1TgVGyns0zQ6J5czJpnTD3AmIRMdEAe+6CD8XgKQpA6ozmbrtZ
         kHnhXmsumQgLR+6UROTS7AXxpWFdqORHmawRqYXXcSY/uStVPLkSnCh2BZhiCEjznagN
         SnCvqlNVBOK/KqgtXbYaNDnd3rsUN0Uj/Nwi0LNPQzRhL146GLPJJ/IZYlrkTiCYC9/H
         DeJw==
X-Gm-Message-State: AOAM531kBc+KD/Hm16buTDsm136QtSwYRquVbomdEYzGnZPouicmS7Y5
        Jw+D4R4/rK+eWJCVDqBHzZUK4SxmJP79DJ8pa+yQcej3
X-Google-Smtp-Source: ABdhPJzIex04a3wUnBTIPhemzeNcqJ29L7mvR5wL+dMAN+uAH9tdDSHdYzUk9TD1ZZ41GEHgm3LxIU0qIzeP8WWmcjI=
X-Received: by 2002:a05:6512:12c1:: with SMTP id p1mr1422124lfg.374.1615603681203;
 Fri, 12 Mar 2021 18:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20210312020257.197137-1-songliubraving@fb.com>
 <CAM9d7che4Ott6F6SNj8aaXea+wgzDE8pVntkpGr1TCbnfWNXkw@mail.gmail.com> <4B3CF1B3-5EED-4882-BC99-AD676D4E3429@fb.com>
In-Reply-To: <4B3CF1B3-5EED-4882-BC99-AD676D4E3429@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 13 Mar 2021 11:47:51 +0900
Message-ID: <CAM9d7cg+HD3-vLXX_rUSg1kWSZ3MGeyrQwdJoa5CgbZjeD2+GA@mail.gmail.com>
Subject: Re: [PATCH] perf-stat: introduce bperf, share hardware PMCs with BPF
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 12:38 AM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Mar 12, 2021, at 12:36 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi,
> >
> > On Fri, Mar 12, 2021 at 11:03 AM Song Liu <songliubraving@fb.com> wrote:
> >>
> >> perf uses performance monitoring counters (PMCs) to monitor system
> >> performance. The PMCs are limited hardware resources. For example,
> >> Intel CPUs have 3x fixed PMCs and 4x programmable PMCs per cpu.
> >>
> >> Modern data center systems use these PMCs in many different ways:
> >> system level monitoring, (maybe nested) container level monitoring, per
> >> process monitoring, profiling (in sample mode), etc. In some cases,
> >> there are more active perf_events than available hardware PMCs. To allow
> >> all perf_events to have a chance to run, it is necessary to do expensive
> >> time multiplexing of events.
> >>
> >> On the other hand, many monitoring tools count the common metrics (cycles,
> >> instructions). It is a waste to have multiple tools create multiple
> >> perf_events of "cycles" and occupy multiple PMCs.
> >>
> >> bperf tries to reduce such wastes by allowing multiple perf_events of
> >> "cycles" or "instructions" (at different scopes) to share PMUs. Instead
> >> of having each perf-stat session to read its own perf_events, bperf uses
> >> BPF programs to read the perf_events and aggregate readings to BPF maps.
> >> Then, the perf-stat session(s) reads the values from these BPF maps.
> >>
> >> Please refer to the comment before the definition of bperf_ops for the
> >> description of bperf architecture.
> >
> > Interesting!  Actually I thought about something similar before,
> > but my BPF knowledge is outdated.  So I need to catch up but
> > failed to have some time for it so far. ;-)
> >
> >>
> >> bperf is off by default. To enable it, pass --use-bpf option to perf-stat.
> >> bperf uses a BPF hashmap to share information about BPF programs and maps
> >> used by bperf. This map is pinned to bpffs. The default address is
> >> /sys/fs/bpf/bperf_attr_map. The user could change the address with option
> >> --attr-map.
> >>
> >> ---
> >> Known limitations:
> >> 1. Do not support per cgroup events;
> >> 2. Do not support monitoring of BPF program (perf-stat -b);
> >> 3. Do not support event groups.
> >
> > In my case, per cgroup event counting is very important.
> > And I'd like to do that with lots of cpus and cgroups.
>
> We can easily extend this approach to support cgroups events. I didn't
> implement it to keep the first version simple.

OK.

>
> > So I'm working on an in-kernel solution (without BPF),
> > I hope to share it soon.
>
> This is interesting! I cannot wait to see how it looks like. I spent
> quite some time try to enable in kernel sharing (not just cgroup
> events), but finally decided to try BPF approach.

Well I found it hard to support generic event sharing that works
for all use cases.  So I'm focusing on the per cgroup case only.

>
> >
> > And for event groups, it seems the current implementation
> > cannot handle more than one event (not even in a group).
> > That could be a serious limitation..
>
> It supports multiple events. Multiple events are independent, i.e.,
> "cycles" and "instructions" would use two independent leader programs.

OK, then do you need multiple bperf_attr_maps?  Does it work
for an arbitrary number of events?

>
> >
> >>
> >> The following commands have been tested:
> >>
> >>   perf stat --use-bpf -e cycles -a
> >>   perf stat --use-bpf -e cycles -C 1,3,4
> >>   perf stat --use-bpf -e cycles -p 123
> >>   perf stat --use-bpf -e cycles -t 100,101
> >
> > Hmm... so it loads both leader and follower programs if needed, right?
> > Does it support multiple followers with different targets at the same time?
>
> Yes, the whole idea is to have one leader program and multiple follower
> programs. If we only run one of these commands at a time, it will load
> one leader and one follower. If we run multiple of them in parallel,
> they will share the same leader program and load multiple follower
> programs.
>
> I actually tested more than the commands above. The list actually means
> we support -a, -C -p, and -t.
>
> Currently, this works for multiple events, and different parallel
> perf-stat. The two commands below will work well in parallel:
>
>   perf stat --use-bpf -e ref-cycles,instructions -a
>   perf stat --use-bpf -e ref-cycles,cycles -C 1,3,5
>
> Note the use of ref-cycles, which can only use one counter on Intel CPUs.
> With this approach, the above two commands will not do time multiplexing
> on ref-cycles.

Awesome!

Thanks,
Namhyung
