Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3203A3B3845
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 23:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhFXVDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 17:03:53 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:44927 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbhFXVDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 17:03:50 -0400
Received: by mail-lf1-f43.google.com with SMTP id a11so12526059lfg.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 14:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h/Bp2DliPtf8XYSAsJMUD0UUuyfxa9Clsvcb4YJwCwk=;
        b=MkD1GA3C3fwwnLFLoagax6dFf6csgBdVUlyZbAyL4luJwYWpVt+qM370e6nYW3nM9p
         Ut3XvGjuMT7HjMbQl9lHy6Gs0B4lUTbmKSYbCUzdeRYlNNsCQmu4AEUYcw60uFg1Dvda
         m+k8Dzka49NtnLI+Qna9+O4kZvNd8tkTg+oE7u4goRrvoU0tygJ9hXZWmJueL87Z2RU+
         m7W9U4wKtS+viAyxQBdGmbL1rkrjo3uVXqVudQqdhkVvbrtU+Ik1N8vyQswRlZoomjH5
         dVweHvRoGZQi70FanpFvWkpdxOyh5n3ge0YiIETCnF3XQYoNaKKhPNT/3kPKUmFYPgnN
         3Rcg==
X-Gm-Message-State: AOAM533oi4XHTJQ2Zny5OmF/29Wbvc0Hk4Rd52g4YPlAdDVGY+daaV26
        D5hAeyjRMluvJuYK5cVwrOQX1KUDjXha2uSW+e8=
X-Google-Smtp-Source: ABdhPJxZrPKwPZDKxboBUad/Rzy0WtGSNShiSfwcnJD9rQ3VzOUQcKbuhbf6QpA3HD/w32wvYRlXgltwWicsmlYpyVA=
X-Received: by 2002:ac2:50da:: with SMTP id h26mr5086437lfm.635.1624568489742;
 Thu, 24 Jun 2021 14:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210622071221.128271-1-namhyung@kernel.org> <20210622071221.128271-4-namhyung@kernel.org>
 <C2ABEEDF-04AF-4AB5-BA6C-C8AC5E8579C6@fb.com> <CAM9d7ci3kS+=ObL_mfx1Qi2rQ7SYRjdLQLJ5+SVmRUsaUepj_w@mail.gmail.com>
 <D5859F92-8AB6-4327-9D5F-A67DB14CB493@fb.com>
In-Reply-To: <D5859F92-8AB6-4327-9D5F-A67DB14CB493@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 24 Jun 2021 14:01:18 -0700
Message-ID: <CAM9d7cgw5ZtuvA2wwEdVU1rL6Hra2Cy4BTHx0rKsNE_ickjN+Q@mail.gmail.com>
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

On Thu, Jun 24, 2021 at 9:20 AM Song Liu <songliubraving@fb.com> wrote:
> >>> +
> >>> +// single set of global perf events to measure
> >>> +struct {
> >>> +     __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> >>> +     __uint(key_size, sizeof(__u32));
> >>> +     __uint(value_size, sizeof(int));
> >>> +     __uint(max_entries, 1);
> >>> +} events SEC(".maps");
> >>> +
> >>> +// from logical cpu number to event index
> >>> +// useful when user wants to count subset of cpus
> >>> +struct {
> >>> +     __uint(type, BPF_MAP_TYPE_HASH);
> >>> +     __uint(key_size, sizeof(__u32));
> >>> +     __uint(value_size, sizeof(__u32));
> >>> +     __uint(max_entries, 1);
> >>> +} cpu_idx SEC(".maps");
> >>
> >> How about we make cpu_idx a percpu array and use 0,1 for
> >> disable/enable profiling on this cpu?
> >
> > No, it's to calculate an index to the cgrp_readings map which
> > has the event x cpu x cgroup number of elements.
> >
> > It controls enabling events with a global (bss) variable.
>
> If we make cgrp_idx a per cpu array, we probably don't need the
> cpu_idx map?

Right.

>
> >
> >>
> >>> +
> >>> +// from cgroup id to event index
> >>> +struct {
> >>> +     __uint(type, BPF_MAP_TYPE_HASH);
> >>> +     __uint(key_size, sizeof(__u64));
> >>> +     __uint(value_size, sizeof(__u32));
> >>> +     __uint(max_entries, 1);
> >>> +} cgrp_idx SEC(".maps");
> >>> +
> >>> +// per-cpu event snapshots to calculate delta
> >>> +struct {
> >>> +     __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> >>> +     __uint(key_size, sizeof(__u32));
> >>> +     __uint(value_size, sizeof(struct bpf_perf_event_value));
> >>> +} prev_readings SEC(".maps");
> >>> +
> >>> +// aggregated event values for each cgroup
> >>> +// will be read from the user-space
> >>> +struct {
> >>> +     __uint(type, BPF_MAP_TYPE_ARRAY);
> >>> +     __uint(key_size, sizeof(__u32));
> >>> +     __uint(value_size, sizeof(struct bpf_perf_event_value));
> >>> +} cgrp_readings SEC(".maps");
> >>
> >> Maybe also make this a percpu array? This should make the BPF program
> >> faster.
> >
> > Maybe.  But I don't know how to access the elements
> > in a per-cpu map from userspace.
>
> Please refer to bperf__read() reading accum_readings. Basically, we read
> one index of all CPUs with one bpf_map_lookup_elem().

Thanks!  So when I use a per-cpu array with 3 elements, I can access
to cpu/elem entries in a row like below, right?

  0/0, 0/1, 0/2, 1/0, 1/1, 1/2, 2/0, 2/1, 2/2, 3/0, ...

Thanks,
Namhyung
