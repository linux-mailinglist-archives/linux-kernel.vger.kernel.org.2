Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFF134EBA5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbhC3PMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:12:07 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:37550 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbhC3PLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:11:36 -0400
Received: by mail-qt1-f173.google.com with SMTP id f12so12156445qtq.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 08:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sN38KkgCNcmdeEx0hWyTndI7OZ0yRzoYxkxTlQJjOqE=;
        b=lY/N+iq2LfY5FvRUN4lT91ufx1Vngp5ossYvV+YhZJZc5Poa0BOZHG4Mgn6j1OvXAv
         KtwW812jHioNfNZeTK5vJyYqA+Uf7Hb/pL+q9m9smlMygAEw0fH4nWeNdTjHLX0pML0P
         +2mjV6+AslZ+19f8KKk9yEnzJD13v43ZatrXrKh4FmTbxlWVUiIfibzXDgEy/WbF2i0k
         QwEKBVYoVxXsonAisEyXU8FkxSl0LGhFWfa132kzcEmHtRK83rG/uXD1XhwVLyjtfNSc
         sxrzhQLO+huEEDs/o4wG3e/untSRpGUsJLQ+LSaRRq9SD981ESC3/0pf/rBQl8AD4i9Q
         PMoA==
X-Gm-Message-State: AOAM531kx5OUn7leof+DeUlcfzvlLb6/m0Oa/H4/oylq2DF6ldAeuxeT
        QRUUV8RH/+K510kQ9hn+HVOB2FWGbU/txWgeYUs=
X-Google-Smtp-Source: ABdhPJw1qgjZ9s7OsJILzxW8Aje4M0GGMNj9V/RZLGeePRrM00yzkgwSne6QvyphWQyCA1+ftbCxmt8z8w0+vvWfrxA=
X-Received: by 2002:a05:622a:454:: with SMTP id o20mr27422110qtx.292.1617117095928;
 Tue, 30 Mar 2021 08:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210323162156.1340260-1-namhyung@kernel.org> <20210323162156.1340260-2-namhyung@kernel.org>
 <180E871A-7C5E-4DB2-80F4-643237A7FA69@fb.com> <CAM9d7cg6-D2G7ii0sEJoEynvvmXUz=QsqjXG5K7j947DL1PymQ@mail.gmail.com>
 <8B2062CE-9BD5-4F17-B831-38C9274A1509@fb.com>
In-Reply-To: <8B2062CE-9BD5-4F17-B831-38C9274A1509@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 31 Mar 2021 00:11:24 +0900
Message-ID: <CAM9d7chtYw0v49Q5ue6B=D_8kV6ZyMvT7p10_jxsHMc+H309tA@mail.gmail.com>
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

On Tue, Mar 30, 2021 at 3:33 PM Song Liu <songliubraving@fb.com> wrote:
> > On Mar 29, 2021, at 4:33 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Mar 29, 2021 at 2:17 AM Song Liu <songliubraving@fb.com> wrote:
> >>> On Mar 23, 2021, at 9:21 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> >>>
> >>> As we can run many jobs (in container) on a big machine, we want to
> >>> measure each job's performance during the run.  To do that, the
> >>> perf_event can be associated to a cgroup to measure it only.
> >>>
>
> [...]
>
> >>> +     return 0;
> >>> +}
> >>
> >> Could you please explain why we need this logic in can_attach?
> >
> > IIUC the ss->attach() is called after a task's cgroup membership
> > is changed.  But we want to collect the performance numbers for
> > the old cgroup just before the change.  As the logic merely checks
> > the current task's cgroup, it should be done in the can_attach()
> > which is called before the cgroup change.
>
> Thanks for the explanations.
>
> Overall, I really like the core idea, especially that the overhead on
> context switch is bounded (by the depth of cgroup tree).

Thanks!

>
> Is it possible to make PERF_EVENT_IOC_ATTACH_CGROUP more flexible?
> Specifically, if we can have
>
>   PERF_EVENT_IOC_ADD_CGROUP     add a cgroup to the list
>   PERF_EVENT_IOC_EL_CGROUP      delete a cgroup from the list
>
> we can probably share these events among multiple processes, and
> these processes don't need to know others' cgroup list. I think
> this will be useful for users to build customized monitoring in
> its own container.
>
> Does this make sense?

Maybe we can add ADD/DEL interface for more flexible monitoring
but I'm not sure which use cases it'll be used actually.

For your multi-process sharing case, the original events' file
descriptors should be shared first.  Also adding and deleting
(or just reading) arbitrary cgroups from a container can be a
security concern IMHO.

So I just focused on the single-process multi-cgroup case which is
already used (perf stat --for-each-cgroup) and very important in my
company's setup.  In this case we have a list of interested cgroups
from the beginning so it's more efficient to create a properly sized
hash table and all the nodes at once.

Thanks,
Namhyung
