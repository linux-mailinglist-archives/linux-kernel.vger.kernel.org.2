Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EE43B0CAB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhFVSQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:16:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230146AbhFVSQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:16:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFE11611CE;
        Tue, 22 Jun 2021 18:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624385647;
        bh=676RC019GjS9XgxQ7vv06C7exyVcH75BlpJ3nHEJqBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yv2enXP5dGxiNmQ4MCoBz6W0NVZlvSi6wafUxU1yxJZxNEP+l5XuPpX+WwckKKH7i
         nDmj0U3oGjHZQfJz5MyS6m/3GmuBpA3m7+auMWpUv81dNyOX3RJugPpMpqdyyjErxw
         bMTaf0OSmwLF2imbORcbPQOLZ2mD8YwbBcF2t4ZP5UIT2gdmxjtvcZmVMrZJNsxpTm
         tg2DIKMKVIf3k8fCaXnYGvBhVpHB2gF1G1m/y2iVRjjNIelZ+k+YC4EVGCZ62QyLEo
         frpKZSgEpnkoNHm47EDWTPKyxs9eas78K9vrjxpHbFm0WjQpGHDbKWxu2LtvgVloj5
         Bcq+bS0i++zaQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5593140B1A; Tue, 22 Jun 2021 15:14:04 -0300 (-03)
Date:   Tue, 22 Jun 2021 15:14:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>, rickyman7@gmail.com
Subject: Re: [RFC 00/10] perf: Add build id parsing fault detection/fix
Message-ID: <YNIobHgfVbiiNscn@kernel.org>
References: <20210622153918.688500-1-jolsa@kernel.org>
 <YNIgXkH1xaF7H3Tr@kernel.org>
 <CAP-5=fU=AAJ0_s1orsF=OCO0=bSmr9BhAmtN251bU_pf0ZFJ6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU=AAJ0_s1orsF=OCO0=bSmr9BhAmtN251bU_pf0ZFJ6Q@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 22, 2021 at 10:47:54AM -0700, Ian Rogers escreveu:
> On Tue, Jun 22, 2021 at 10:39 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Tue, Jun 22, 2021 at 05:39:08PM +0200, Jiri Olsa escreveu:
> > > hi,
> > > this *RFC* patchset adds support to detect faults during
> > > mmap2's build id parsing and a way to fix such maps in
> > > generated perf.data.
> > >
> > > It adds support to record build id faults count for session
> > > and store it in perf.data and perf inject support to find
> > > these maps and reads build ids for them in user space.
> >
> > > It's probably best explained by the workflow:
> > >
> > >   Record data with --buildid-mmap option:
> > >
> > >     # perf record --buildid-mmap ...
> > >     ...
> > >     [ perf record: Woken up 1 times to write data ]
> > >     [ perf record: Failed to parse 4 build ids]
> > >     [ perf record: Captured and wrote 0.008 MB perf.data ]
> > >
> > >   Check if there's any build id fault reported:
> > >
> > >     # perf report --header-only
> > >     ...
> > >     # build id mmap stats: FAULTS 4, LOST 0, NOT FIXED
> > >
> > >   There is, check the stats:
> > >
> > >     # perf report --stat
> > >
> > >     Aggregated stats:
> > >              TOTAL events:        104
> > >                       ....
> > >            BUILD_ID fails:          4  (14.3%)
> > >
> > >   Yep, let's fix it:
> > >
> > >     # perf inject --buildid-mmap2 -i perf.data -o perf-fixed.data
> >
> > Can we make it possible to automate this with --fixup-buildids or a
> > perfconfig 'record' knob?
> >
> > This would entail requesting that build-ids that _fail_ be sent to the
> > side-band thread we have in 'perf record', this way we wouldn't have to
> > traverse the whole perf.data file, be it with 'perf-record' at the end
> > of a session with faulty build ids, or in a similar fashion using 'perf
> > inject' as you suggest.
> >
> > I even think that we can have all these modes and let the user to decide
> > how important is this for them and how convenient they want the whole
> > process to be.
> 
> Firstly thanks for the patches! To Arnaldo's sideband idea, I wonder
> if we have a thread doing sideband buildid generation whether the same
> thread or threads could also be doing the synthesis job. Perhaps such
> work could be postponed until when the session closes, like with tail

I didn't suggest synthesizing the failed build-ids in the sideband
thread, just receiving the MMAP2 records for the build-ids that
faulted.

It may be interesting to do it right away, to avoid building up a
potentially large number of entries to do at the end, but if this is
something uncommon, with just a few entries, then leaving it for after
the workload finishes may be a good idea.

Or perhaps this needs to be a knob, since for long running sessions such
as with 'perf daemon' the "workload" may never end, so we better flush
these things as the files where we'll get it from may go away.

> synthesis. It's a particular shame with tail synthesis that we
> synthesize mmap events for processes with no samples.

Sure, but it is also very costly to process a potentially large
perf.data file for looking at what MMAPs have samples. That is the
raison d'être for PERF_RECORD_MMAP2 to carry build-ids :-)

I.e. there are pros and cons for tail synthesis, for looking at all
samples to generate only build-ids for MMAPs with hits, for synthesizing
it in the sideband thread immediately, for leaving this generation to
be done at the end by traversing the list of MMAP records without
build-ids, etc.

- Arnaldo
 
> Thanks,
> Ian
> 
> > - Arnaldo
> >
> > >   And verify:
> > >
> > >     # perf report -i perf-fixed.data --stats
> > >
> > >     Aggregated stats:
> > >                TOTAL events:        104
> > >                         ....
> > >
> > >   Good, let's see how many we fixed:
> > >
> > >     # perf report --header-only -i perf-fixed.data
> > >     ...
> > >     # build id mmap stats: FAULTS 4, LOST 0, FIXED(4)
> > >
> > >
> > > I don't have a good way to test it, just by artificially
> > > adding the faults in kernel code, but Ian and Namhyung
> > > might have setup that could generate that.. would be great
> > > to have a perf test for this.
> > >
> > > Also available in here:
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> > >   perf/buildid_stats
> > >
> > > thoughts?
> > >
> > > thanks,
> > > jirka
> > >
> > >
> > > ---
> > > Jiri Olsa (10):
> > >       perf: Track build id faults for mmap2 event
> > >       perf: Move build_id_parse to check only regular files
> > >       perf: Add new read_format bit to read build id faults
> > >       perf: Add new read_format bit to read lost events
> > >       tools: Sync perf_event.h uapi
> > >       libperf: Do not allow PERF_FORMAT_GROUP in perf_evsel__read
> > >       perf record: Add support to read build id fails
> > >       perf record: Add new HEADER_BUILD_ID_MMAP feature
> > >       perf report: Display build id fails stats
> > >       perf inject: Add --buildid-mmap2 option to fix failed build ids
> > >
> > >  include/linux/perf_event.h                         |  2 ++
> > >  include/uapi/linux/perf_event.h                    | 20 +++++++++++++-------
> > >  kernel/events/core.c                               | 49 +++++++++++++++++++++++++++++++++++++++++++------
> > >  kernel/events/ring_buffer.c                        |  3 +++
> > >  tools/include/uapi/linux/perf_event.h              | 20 +++++++++++++-------
> > >  tools/lib/perf/evsel.c                             | 10 ++++++++++
> > >  tools/lib/perf/include/perf/evsel.h                | 11 ++++++++++-
> > >  tools/perf/Documentation/perf-inject.txt           |  3 +++
> > >  tools/perf/Documentation/perf.data-file-format.txt | 19 +++++++++++++++++++
> > >  tools/perf/builtin-inject.c                        | 45 +++++++++++++++++++++++++++++++++++++++++++--
> > >  tools/perf/builtin-record.c                        | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  tools/perf/builtin-report.c                        | 35 +++++++++++++++++++++++++++++++++++
> > >  tools/perf/util/env.h                              |  6 ++++++
> > >  tools/perf/util/evsel.c                            | 12 ++++++++++++
> > >  tools/perf/util/header.c                           | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  tools/perf/util/header.h                           |  1 +
> > >  tools/perf/util/map.h                              | 15 +++++++++++++++
> > >  tools/perf/util/perf_event_attr_fprintf.c          |  3 ++-
> > >  18 files changed, 407 insertions(+), 24 deletions(-)
> > >
> >
> > --
> >
> > - Arnaldo

-- 

- Arnaldo
