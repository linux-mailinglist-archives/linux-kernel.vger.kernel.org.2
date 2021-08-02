Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449543DD6BB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 15:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbhHBNQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 09:16:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233764AbhHBNQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 09:16:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BE5D60F6D;
        Mon,  2 Aug 2021 13:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627910190;
        bh=1Ex0+3uTcYZ6jvFeDk088gY4QbGXw0sF3nCd8f5WDt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l3vUA9I2Jv/CJhN9WkDO95RjcFbaoJO8T05X0i4RuuBqzMVBTma4bZgizE7xnF5gA
         lBcGXFdITRWDjvxecXOkXNnQrFCqPPOhEPVE9jfReArFKChwl7c4r2IFzbeWcra8l2
         eiweUhr9vGbbdzq85322CNcaZSg8mSNdaNtdGjjlZHyzx/TJdS1z/9nR0jqLA7wB4G
         +fELEpfqYXXdPMr2kwGz3dX2v5AOCc1V+0060JqK1aV/5fL7v0+xvuYZBEGIMlkSFf
         zMWIIw9Mdg7Gj+dpPGCn8HMIKKlRl0wbtqIgU8NVKjg9/Co7BPouCB0OEbx85vEkJs
         GgsKBi3EVPxzQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4A0EB403F2; Mon,  2 Aug 2021 10:16:28 -0300 (-03)
Date:   Mon, 2 Aug 2021 10:16:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCHSET v3 0/5] perf inject: Fix broken data with mixed
 input/output
Message-ID: <YQfwLP4Ebsc3Wzb2@kernel.org>
References: <20210719223153.1618812-1-namhyung@kernel.org>
 <YPaQ94VCtYWSXYnh@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPaQ94VCtYWSXYnh@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 20, 2021 at 11:01:43AM +0200, Jiri Olsa escreveu:
> On Mon, Jul 19, 2021 at 03:31:48PM -0700, Namhyung Kim wrote:
> > The perf inject processes the input data and produces an output with
> > injected data according to the given options.  During the work, it
> > assumes the input and output files have the same format - either a
> > regular file or a pipe.  This works for the obvious cases, but
> > sometimes makes a trouble when input and output have different
> > formats (like for debugging).

> >  * changes in v3
> >   - use task-clock:u in the pipe-test.sh
 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

Had to do some adjustments due to minor conflicts, can you please check
tmp.perf/core?

- Arnaldo
 
> thanks,
> jirka
> 
> > 
> >  * changes in v2
> >   - factor out perf_event__synthesize_for_pipe
> >   - add a shell test for pipe operations
> > 
> > 
> > For example, this patchset fixed the following cases
> > 
> >  1. input: pipe, output: file
> > 
> >   # perf record -a -o - sleep 1 | perf inject -b -o perf-pipe.data
> >   # perf report -i perf-pipe.data
> > 
> >  2. input: file, output: pipe
> > 
> >   # perf record -a -B sleep 1
> >   # perf inject -b -i perf.data | perf report -i -
> > 
> > 
> > Thanks,
> > Namhyung
> > 
> > 
> > Namhyung Kim (5):
> >   perf tools: Remove repipe argument from perf_session__new()
> >   perf tools: Pass a fd to perf_file_header__read_pipe()
> >   perf inject: Fix output from a pipe to a file
> >   perf inject: Fix output from a file to a pipe
> >   perf tools: Add pipe_test.sh to verify pipe operations
> > 
> >  tools/perf/bench/synthesize.c       |  4 +-
> >  tools/perf/builtin-annotate.c       |  2 +-
> >  tools/perf/builtin-buildid-cache.c  |  2 +-
> >  tools/perf/builtin-buildid-list.c   |  2 +-
> >  tools/perf/builtin-c2c.c            |  2 +-
> >  tools/perf/builtin-diff.c           |  4 +-
> >  tools/perf/builtin-evlist.c         |  2 +-
> >  tools/perf/builtin-inject.c         | 38 ++++++++++++++--
> >  tools/perf/builtin-kmem.c           |  2 +-
> >  tools/perf/builtin-kvm.c            |  4 +-
> >  tools/perf/builtin-lock.c           |  2 +-
> >  tools/perf/builtin-mem.c            |  3 +-
> >  tools/perf/builtin-record.c         | 40 +++--------------
> >  tools/perf/builtin-report.c         |  2 +-
> >  tools/perf/builtin-sched.c          |  4 +-
> >  tools/perf/builtin-script.c         |  4 +-
> >  tools/perf/builtin-stat.c           |  4 +-
> >  tools/perf/builtin-timechart.c      |  3 +-
> >  tools/perf/builtin-top.c            |  2 +-
> >  tools/perf/builtin-trace.c          |  2 +-
> >  tools/perf/tests/shell/pipe_test.sh | 69 +++++++++++++++++++++++++++++
> >  tools/perf/tests/topology.c         |  4 +-
> >  tools/perf/util/data-convert-bt.c   |  2 +-
> >  tools/perf/util/data-convert-json.c |  2 +-
> >  tools/perf/util/header.c            | 12 ++---
> >  tools/perf/util/header.h            |  2 +-
> >  tools/perf/util/session.c           | 11 ++---
> >  tools/perf/util/session.h           | 12 ++++-
> >  tools/perf/util/synthetic-events.c  | 53 +++++++++++++++++++++-
> >  tools/perf/util/synthetic-events.h  |  6 +++
> >  30 files changed, 217 insertions(+), 84 deletions(-)
> >  create mode 100755 tools/perf/tests/shell/pipe_test.sh
> > 
> > -- 
> > 2.32.0.402.g57bb445576-goog
> > 
> 

-- 

- Arnaldo
