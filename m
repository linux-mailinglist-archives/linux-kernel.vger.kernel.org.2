Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171633B21AA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 22:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhFWUSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 16:18:14 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:43882 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWUSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 16:18:13 -0400
Received: by mail-lj1-f170.google.com with SMTP id f13so4610412ljp.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 13:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5RY3tWwIuihPcox2Au/c1e4a7Ggnf7W7JLrTgPdHZrU=;
        b=oRE9jXFZbVNjXcRaFiCT+iHjuo9QLGzGGbGMb63gCjMGyedX0c/ot3zAvLA28gWYGH
         Hz/QbWGyUQnOzGKkc93fiFmRfq2wLShZiYQyc8gGBwxqDHmNCajTz3mgysMTxIGtupI+
         lX1Hg+Q/2KkaphXVpvYGQE6WBLxDBoR6oR0Hy8gfmvK7gYyKzeXmPgJLUiuwiFFdnZdu
         +ItKEiOFBiyDHcBH+K8rcB8c3LJJRGEk5hvfSYgomWFH/SDA2BbmmY9qD+3RcCFMcnDs
         tjwUlvx5sLkE04845HpuQclZjAK9kjEyqmgdPBQgx8LBrlFdlhFs3eQEU/DjpHQuHgOD
         fpSA==
X-Gm-Message-State: AOAM5300mweplypPF9uDaMkyTYSo5bf5crxqfi8sGiZ1lt4I7kdocqUi
        WzTSb2uLFOMgWbeQogguLnJ0TuurJBqtxcQyBPU=
X-Google-Smtp-Source: ABdhPJwcFuhtg8Ova31f/UXrOfI4Xh8P6Y3oZV8+TJTYbzG41HKdECSAPE8ObFmmsPOxVIONhSr8q5/81w7a3U9KX3o=
X-Received: by 2002:a2e:9984:: with SMTP id w4mr1015410lji.393.1624479353243;
 Wed, 23 Jun 2021 13:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210622153918.688500-1-jolsa@kernel.org>
In-Reply-To: <20210622153918.688500-1-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 23 Jun 2021 13:15:41 -0700
Message-ID: <CAM9d7chf1skToXEkyPRRwm9Ak_QOVu3todZ3y4mGnAH1rrdaGw@mail.gmail.com>
Subject: Re: [RFC 00/10] perf: Add build id parsing fault detection/fix
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 8:39 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> hi,
> this *RFC* patchset adds support to detect faults during
> mmap2's build id parsing and a way to fix such maps in
> generated perf.data.
>
> It adds support to record build id faults count for session
> and store it in perf.data and perf inject support to find
> these maps and reads build ids for them in user space.
>
> It's probably best explained by the workflow:
>
>   Record data with --buildid-mmap option:
>
>     # perf record --buildid-mmap ...
>     ...
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Failed to parse 4 build ids]
>     [ perf record: Captured and wrote 0.008 MB perf.data ]
>
>   Check if there's any build id fault reported:
>
>     # perf report --header-only
>     ...
>     # build id mmap stats: FAULTS 4, LOST 0, NOT FIXED
>
>   There is, check the stats:
>
>     # perf report --stat
>
>     Aggregated stats:
>              TOTAL events:        104
>                       ....
>            BUILD_ID fails:          4  (14.3%)
>
>   Yep, let's fix it:

Depending on the failure, it might not need to be fixed.
Say, one process mmapped a file A and succeeded.
And then another process mmaped the same file A,
but it failed to get a build-id (mmap itself was ok).
And vice versa is fine too.

So even if it sees failures, we didn't lose anything.

>
>     # perf inject --buildid-mmap2 -i perf.data -o perf-fixed.data

Not sure this is really needed since `perf inject -j`
can add BUILD_ID records without fixing MMAP2.

>
>   And verify:
>
>     # perf report -i perf-fixed.data --stats
>
>     Aggregated stats:
>                TOTAL events:        104
>                         ....
>
>   Good, let's see how many we fixed:
>
>     # perf report --header-only -i perf-fixed.data
>     ...
>     # build id mmap stats: FAULTS 4, LOST 0, FIXED(4)
>
>
> I don't have a good way to test it, just by artificially
> adding the faults in kernel code, but Ian and Namhyung
> might have setup that could generate that.. would be great
> to have a perf test for this.
>
> Also available in here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/buildid_stats
>
> thoughts?
>
> thanks,
> jirka
>
>
> ---
> Jiri Olsa (10):
>       perf: Track build id faults for mmap2 event
>       perf: Move build_id_parse to check only regular files
>       perf: Add new read_format bit to read build id faults
>       perf: Add new read_format bit to read lost events
>       tools: Sync perf_event.h uapi
>       libperf: Do not allow PERF_FORMAT_GROUP in perf_evsel__read
>       perf record: Add support to read build id fails
>       perf record: Add new HEADER_BUILD_ID_MMAP feature
>       perf report: Display build id fails stats
>       perf inject: Add --buildid-mmap2 option to fix failed build ids
>
>  include/linux/perf_event.h                         |  2 ++
>  include/uapi/linux/perf_event.h                    | 20 +++++++++++++-------
>  kernel/events/core.c                               | 49 +++++++++++++++++++++++++++++++++++++++++++------
>  kernel/events/ring_buffer.c                        |  3 +++
>  tools/include/uapi/linux/perf_event.h              | 20 +++++++++++++-------
>  tools/lib/perf/evsel.c                             | 10 ++++++++++
>  tools/lib/perf/include/perf/evsel.h                | 11 ++++++++++-
>  tools/perf/Documentation/perf-inject.txt           |  3 +++
>  tools/perf/Documentation/perf.data-file-format.txt | 19 +++++++++++++++++++
>  tools/perf/builtin-inject.c                        | 45 +++++++++++++++++++++++++++++++++++++++++++--
>  tools/perf/builtin-record.c                        | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/builtin-report.c                        | 35 +++++++++++++++++++++++++++++++++++
>  tools/perf/util/env.h                              |  6 ++++++
>  tools/perf/util/evsel.c                            | 12 ++++++++++++
>  tools/perf/util/header.c                           | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/header.h                           |  1 +
>  tools/perf/util/map.h                              | 15 +++++++++++++++
>  tools/perf/util/perf_event_attr_fprintf.c          |  3 ++-
>  18 files changed, 407 insertions(+), 24 deletions(-)
>
