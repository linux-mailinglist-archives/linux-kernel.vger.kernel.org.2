Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36C83B0BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 19:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbhFVRu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 13:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFVRuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:50:24 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77210C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:48:07 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e22so21104421wrc.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05bG8SWQuxCak3SCJ6NM8dRJhBIIzw5q3ep5bq2tGJA=;
        b=fDfwDIhmFbvP2QYI1zjyZhDXGkjVxHhmrfm5woOQWUCdBmXrz6ywxaFdRoOHr+U3a8
         CopBlmelS/YXqjnQxN5K7KeM7j2dnOIpf2/29o8k4EWg5gwh5AuymNBbTDOaS11Gdina
         I4WiLmIWz8KG2/d9lTrqBc71SOZ+Tx+XwPKrQxTnbNQkS3oXcSnwyYotW/3nHgEzMKWn
         N+ovTepHeE49i/UPLGsAHcp9kTJt6nclcQ1/vYBAMsgz9XvB30bvLSK/yj2tC0WxSq+3
         T4/PAWAnaERBdkPh55BuPJAK4TC/0ZfevIMHQO8iUbrHCQiHmFUyQOpxkGn0ppue8d4Q
         LhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05bG8SWQuxCak3SCJ6NM8dRJhBIIzw5q3ep5bq2tGJA=;
        b=QVvnQ22CakYPtv5pBtxLBL01B1Xdi6KFahMoWNIx5OTJht0aPcYGBMg8G2f1aPt+vM
         14XG2VvBDPfaQuzegS5DoTiJaJmjEFfWta55w4bLaIDtjs8ih42kERfqTRdup9XPY+Rg
         NNSr3hXHz+sklZwVtTWwFaB3Yo4CxQZR/a0Aw4/0EknQZzLXXV3Hav+1CDvzE0xF5t9/
         7oOwC/yWpd3C9JvNVSML64INNi0HktoXYdFWZgqU6bN1nGicwhNRWWSOaY57POgksPuD
         w1QGG1cDW9b/pY7CZQercUX2jY8LyAL99wM2ephdIcKPw/XMJKH4Wo8NlVzlhFTHXfAX
         DUuQ==
X-Gm-Message-State: AOAM533UF5xmY5rxitQ8ZJyRKtJKoXI1QLQa4KXdSmOyE+ahtPBPtKkW
        mXc36Hy29i9Knr7talA4o1IydtKTNZm3LmcfHC+g9A==
X-Google-Smtp-Source: ABdhPJyXhZHNOBnTZJ1DGqSV1fufYwWxYc9lv6F9wXAQB01Jjy/jINy8tPPnFP/Kyi4DVmn64lzKGHmryOAQ1jZnHVE=
X-Received: by 2002:adf:e2cf:: with SMTP id d15mr6278935wrj.48.1624384085973;
 Tue, 22 Jun 2021 10:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210622153918.688500-1-jolsa@kernel.org> <YNIgXkH1xaF7H3Tr@kernel.org>
In-Reply-To: <YNIgXkH1xaF7H3Tr@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 22 Jun 2021 10:47:54 -0700
Message-ID: <CAP-5=fU=AAJ0_s1orsF=OCO0=bSmr9BhAmtN251bU_pf0ZFJ6Q@mail.gmail.com>
Subject: Re: [RFC 00/10] perf: Add build id parsing fault detection/fix
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>, rickyman7@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 10:39 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Jun 22, 2021 at 05:39:08PM +0200, Jiri Olsa escreveu:
> > hi,
> > this *RFC* patchset adds support to detect faults during
> > mmap2's build id parsing and a way to fix such maps in
> > generated perf.data.
> >
> > It adds support to record build id faults count for session
> > and store it in perf.data and perf inject support to find
> > these maps and reads build ids for them in user space.
>
> > It's probably best explained by the workflow:
> >
> >   Record data with --buildid-mmap option:
> >
> >     # perf record --buildid-mmap ...
> >     ...
> >     [ perf record: Woken up 1 times to write data ]
> >     [ perf record: Failed to parse 4 build ids]
> >     [ perf record: Captured and wrote 0.008 MB perf.data ]
> >
> >   Check if there's any build id fault reported:
> >
> >     # perf report --header-only
> >     ...
> >     # build id mmap stats: FAULTS 4, LOST 0, NOT FIXED
> >
> >   There is, check the stats:
> >
> >     # perf report --stat
> >
> >     Aggregated stats:
> >              TOTAL events:        104
> >                       ....
> >            BUILD_ID fails:          4  (14.3%)
> >
> >   Yep, let's fix it:
> >
> >     # perf inject --buildid-mmap2 -i perf.data -o perf-fixed.data
>
> Can we make it possible to automate this with --fixup-buildids or a
> perfconfig 'record' knob?
>
> This would entail requesting that build-ids that _fail_ be sent to the
> side-band thread we have in 'perf record', this way we wouldn't have to
> traverse the whole perf.data file, be it with 'perf-record' at the end
> of a session with faulty build ids, or in a similar fashion using 'perf
> inject' as you suggest.
>
> I even think that we can have all these modes and let the user to decide
> how important is this for them and how convenient they want the whole
> process to be.

Firstly thanks for the patches! To Arnaldo's sideband idea, I wonder
if we have a thread doing sideband buildid generation whether the same
thread or threads could also be doing the synthesis job. Perhaps such
work could be postponed until when the session closes, like with tail
synthesis. It's a particular shame with tail synthesis that we
synthesize mmap events for processes with no samples.

Thanks,
Ian

> - Arnaldo
>
> >   And verify:
> >
> >     # perf report -i perf-fixed.data --stats
> >
> >     Aggregated stats:
> >                TOTAL events:        104
> >                         ....
> >
> >   Good, let's see how many we fixed:
> >
> >     # perf report --header-only -i perf-fixed.data
> >     ...
> >     # build id mmap stats: FAULTS 4, LOST 0, FIXED(4)
> >
> >
> > I don't have a good way to test it, just by artificially
> > adding the faults in kernel code, but Ian and Namhyung
> > might have setup that could generate that.. would be great
> > to have a perf test for this.
> >
> > Also available in here:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   perf/buildid_stats
> >
> > thoughts?
> >
> > thanks,
> > jirka
> >
> >
> > ---
> > Jiri Olsa (10):
> >       perf: Track build id faults for mmap2 event
> >       perf: Move build_id_parse to check only regular files
> >       perf: Add new read_format bit to read build id faults
> >       perf: Add new read_format bit to read lost events
> >       tools: Sync perf_event.h uapi
> >       libperf: Do not allow PERF_FORMAT_GROUP in perf_evsel__read
> >       perf record: Add support to read build id fails
> >       perf record: Add new HEADER_BUILD_ID_MMAP feature
> >       perf report: Display build id fails stats
> >       perf inject: Add --buildid-mmap2 option to fix failed build ids
> >
> >  include/linux/perf_event.h                         |  2 ++
> >  include/uapi/linux/perf_event.h                    | 20 +++++++++++++-------
> >  kernel/events/core.c                               | 49 +++++++++++++++++++++++++++++++++++++++++++------
> >  kernel/events/ring_buffer.c                        |  3 +++
> >  tools/include/uapi/linux/perf_event.h              | 20 +++++++++++++-------
> >  tools/lib/perf/evsel.c                             | 10 ++++++++++
> >  tools/lib/perf/include/perf/evsel.h                | 11 ++++++++++-
> >  tools/perf/Documentation/perf-inject.txt           |  3 +++
> >  tools/perf/Documentation/perf.data-file-format.txt | 19 +++++++++++++++++++
> >  tools/perf/builtin-inject.c                        | 45 +++++++++++++++++++++++++++++++++++++++++++--
> >  tools/perf/builtin-record.c                        | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tools/perf/builtin-report.c                        | 35 +++++++++++++++++++++++++++++++++++
> >  tools/perf/util/env.h                              |  6 ++++++
> >  tools/perf/util/evsel.c                            | 12 ++++++++++++
> >  tools/perf/util/header.c                           | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/header.h                           |  1 +
> >  tools/perf/util/map.h                              | 15 +++++++++++++++
> >  tools/perf/util/perf_event_attr_fprintf.c          |  3 ++-
> >  18 files changed, 407 insertions(+), 24 deletions(-)
> >
>
> --
>
> - Arnaldo
