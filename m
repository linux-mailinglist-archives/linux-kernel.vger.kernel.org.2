Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4ED346E76
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 02:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbhCXBHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 21:07:11 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:44840 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhCXBG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 21:06:26 -0400
Received: by mail-lf1-f46.google.com with SMTP id b83so29439158lfd.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 18:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5XSDAa22R7YRjp9+bq7Pj6QAMt1XiGSSKEv0hk15Ip4=;
        b=fII2QtqS7ys/PSi0xQXu0FU3isjN5k3T8kKW7l1jrPkYbxiIVz4bhNZXq1oGAKMcXm
         zQpqrDBmisbo0uCRIi+p0KkwYNSmRJeeDzXXtTSTQlcQQkm/NNGki9GpBEIzTa8Nrsjd
         /6yVytkBu0O8WeZ9V14ZwdxfY6jRG632q6E5Yq3FW8y1R51wSKxcnibq3sGiNtNucdRX
         t1xtXFaWHxafgSs+hfHiLI+rdoFPxoY5H5NW4wl3vAQMc+AvzQ2x/Rlw3IVZL458xCal
         4PdEf7FZMZkiwOebJkLL4HgHiKhXbXW9uNECeiqr6moMN8FRfAQQ7UzoZ3+zhUKnMpN5
         Vc3w==
X-Gm-Message-State: AOAM532ZFwLebf1nN7bb5hB3DXdRdc/dUnsvz/bSda4DT+/06AXgjJ3P
        qttK/YyZ8fHM+7bMdVUDc1BhMhvziHXDw2Ls5rA=
X-Google-Smtp-Source: ABdhPJxGJE1i+teEPEihG8ix89eKgWlO5bMtQayDm6Z+jVOjyw0hjosIQHpqUYOupUDSExcYAlqTpjkHm9cYvBetqSs=
X-Received: by 2002:a19:430e:: with SMTP id q14mr459946lfa.374.1616547985051;
 Tue, 23 Mar 2021 18:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210323162156.1340260-1-namhyung@kernel.org> <20210323162156.1340260-2-namhyung@kernel.org>
 <67AE9319-D5E1-480D-ACF1-64CB7C595C40@fb.com>
In-Reply-To: <67AE9319-D5E1-480D-ACF1-64CB7C595C40@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 24 Mar 2021 10:06:13 +0900
Message-ID: <CAM9d7cjrrUkgdsrAOmWDJ0rTQpC5npnOYZzHx-3Pe-rfDB7uRg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf/core: Share an event with multiple cgroups
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
        Ian Rogers <irogers@google.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

On Wed, Mar 24, 2021 at 9:30 AM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Mar 23, 2021, at 9:21 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > As we can run many jobs (in container) on a big machine, we want to
> > measure each job's performance during the run.  To do that, the
> > perf_event can be associated to a cgroup to measure it only.
> >
> > However such cgroup events need to be opened separately and it causes
> > significant overhead in event multiplexing during the context switch
> > as well as resource consumption like in file descriptors and memory
> > footprint.
> >
> > As a cgroup event is basically a cpu event, we can share a single cpu
> > event for multiple cgroups.  All we need is a separate counter (and
> > two timing variables) for each cgroup.  I added a hash table to map
> > from cgroup id to the attached cgroups.
> >
> > With this change, the cpu event needs to calculate a delta of event
> > counter values when the cgroups of current and the next task are
> > different.  And it attributes the delta to the current task's cgroup.
> >
> > This patch adds two new ioctl commands to perf_event for light-weight
> > cgroup event counting (i.e. perf stat).
> >
> > * PERF_EVENT_IOC_ATTACH_CGROUP - it takes a buffer consists of a
> >     64-bit array to attach given cgroups.  The first element is a
> >     number of cgroups in the buffer, and the rest is a list of cgroup
> >     ids to add a cgroup info to the given event.
> >
> > * PERF_EVENT_IOC_READ_CGROUP - it takes a buffer consists of a 64-bit
> >     array to get the event counter values.  The first element is size
> >     of the array in byte, and the second element is a cgroup id to
> >     read.  The rest is to save the counter value and timings.
> >
> > This attaches all cgroups in a single syscall and I didn't add the
> > DETACH command deliberately to make the implementation simple.  The
> > attached cgroup nodes would be deleted when the file descriptor of the
> > perf_event is closed.
>
> This is very interesting idea!

Thanks!

>
> Could you please add some description of the relationship among
> perf_event and contexts? The code is a little confusing. For example,
> why do we need cgroup_ctx_list?

Sure, a perf_event belongs to an event context (hw or sw, mostly) which
takes care of multiplexing, timing, locking and so on.  So many of the
fields in the perf_event are protected by the context lock.  A context has
a list of perf_events and there are per-cpu contexts and per-task contexts.

The cgroup_ctx_list is to traverse contexts (in that cpu) only having
perf_events with attached cgroups.

Hope this makes it clear.  Please let me know if you need more. :)

Thanks,
Namhyung
