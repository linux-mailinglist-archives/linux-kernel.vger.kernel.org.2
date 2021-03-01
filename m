Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E7932809A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhCAOVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:21:38 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:46985 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbhCAOVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:21:02 -0500
Received: by mail-lf1-f54.google.com with SMTP id v5so25721532lft.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 06:20:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PLomIlgN9oc1eWGT2ytxEDeEjLwxxXHqBa099Tbuy7c=;
        b=VvhwoKCbEM/JLvPQzy3kC4Qs3Lmal/tvL6bosyfLOe12FDv1TSSPqLqq44KnzJEnBx
         a6BfnLvIid4jwdoDUhj52A2kYzQlDxSZ2BfNnNpEELfpRbkGjuox44OGqsbH/1su4BaG
         OxzIfkTJsYVCPNEZzUesTwla3hweOwYon3tGO23B9zAAP3WkIPSnNwcDjMRmNdcRZyFr
         Rh5/zEKFXfv5XQSXMOMMWhLee8RVA0q+8Oo+6qhssnKNoKNggTaUeP40iTitvXfIOz2n
         4UdDQLtZ6uxEwLbqgqcDuWC8f1bZrhaAS6RCUdF7Uw2MJ6pJ/T4MoPGCvTSJA70ozoY1
         e5lQ==
X-Gm-Message-State: AOAM532613sUtjUV18ww9UdshishQ7u4RpyN8BVYiplJQPqyFHh5paxT
        Tl4abQYs8WXLGjAfdlGgQsc5iNdu+Udt8/W7O9E=
X-Google-Smtp-Source: ABdhPJwixk1GuRDYwdPPfghr06e9MwzDrAp3EkLz6hpyiTJhBG63Qu9JHmk8y/9GrAG/eV+fnqC2KvCTBpuOzZcWwRE=
X-Received: by 2002:a05:6512:12c1:: with SMTP id p1mr10233112lfg.374.1614608419865;
 Mon, 01 Mar 2021 06:20:19 -0800 (PST)
MIME-Version: 1.0
References: <7d197a2d-56e2-896d-bf96-6de0a4db1fb8@linux.intel.com>
 <ad205903-41a6-5041-f4f3-6f57d83cbd3a@linux.intel.com> <20201120104942.GF94830@google.com>
 <64b0859f-aad3-43fa-4e4c-81614d0c75e4@linux.intel.com> <CAM9d7chw-i7Vx+eOPDAdyh2MPQpW=t9ueGFqUH=UcyfsNi7dUg@mail.gmail.com>
 <a0e7af89-416f-1aab-32e5-70adeb80a721@linux.intel.com>
In-Reply-To: <a0e7af89-416f-1aab-32e5-70adeb80a721@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 1 Mar 2021 23:20:08 +0900
Message-ID: <CAM9d7cixP+28ifLT4sd1Q-eXsqOrGi=kbOx5tDBZ3uCu2KZHgw@mail.gmail.com>
Subject: Re: [PATCH v3 07/12] perf record: init data file at mmap buffer object
To:     "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Cc:     Alexei Budankov <abudankov@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 10:33 PM Bayduraev, Alexey V
<alexey.v.bayduraev@linux.intel.com> wrote:
>
> On 01.03.2021 14:44, Namhyung Kim wrote:
> > Hello,
> >
> > On Mon, Mar 1, 2021 at 8:16 PM Bayduraev, Alexey V
> > <alexey.v.bayduraev@linux.intel.com> wrote:
> >>
> >> Hi,
> >>
> >> On 20.11.2020 13:49, Namhyung Kim wrote:
> >>> On Mon, Nov 16, 2020 at 03:19:41PM +0300, Alexey Budankov wrote:
> >>
> >> <SNIP>
> >>
> >>>>
> >>>> @@ -1400,8 +1417,12 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
> >>>>      /*
> >>>>       * Mark the round finished in case we wrote
> >>>>       * at least one event.
> >>>> +     *
> >>>> +     * No need for round events in directory mode,
> >>>> +     * because per-cpu maps and files have data
> >>>> +     * sorted by kernel.
> >>>
> >>> But it's not just for single cpu since task can migrate so we need to
> >>> look at other cpu's data too.  Thus we use the ordered events queue
> >>> and round events help to determine when to flush the data.  Without
> >>> the round events, it'd consume huge amount of memory during report.
> >>>
> >>> If we separate tracking records and process them first, we should be
> >>> able to process samples immediately without sorting them in the
> >>> ordered event queue.  This will save both cpu cycles and memory
> >>> footprint significantly IMHO.
> >>>
> >>> Thanks,
> >>> Namhyung
> >>>
> >>
> >> As far as I understand, to split tracing records (FORK/MMAP/COMM) into
> >> a separate file, we need to implement a runtime trace decoder on the
> >> perf-record side to recognize such tracing records coming from the kernel.
> >> Is that what you mean?
> >
> > No, I meant separating the mmap buffers so that the record process
> > can save the data without decoding.
> >
>
> Thanks,
>
> Do you think this can be implemented only on the user side by creating a dummy
> event and manipulating by mmap/comm/task flags of struct perf_event_attr?
> Or some changes on the kernel side are necessary?

It's only user space changes but it can be large.  Actually I worked
on parallelizing
perf report several years ago (not finished, but I don't have time for
it now).  At the
time, perf record didn't support directory output so I made it have indexes to
different data parts. But you can get the idea from the code in

  https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git/log/?h=perf/threaded-v5

Thanks,
Namhyung
