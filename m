Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7C23BA0A9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbhGBMsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 08:48:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230359AbhGBMsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 08:48:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25E7C613E1;
        Fri,  2 Jul 2021 12:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625229971;
        bh=E4oEj+PbpdO3Eg5wJcPghg3wJkKA1lvkxfMQFbolpWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sWujkA5oT53blWuSaqrUxURxM5NcZTMeXxkXotymWiv6LvbAsQDleoitgyLeV189w
         mSBI5ox0MyI01/a3lJdaoyeJI5f9hJtIvqEoqFazjYuBkO4Q5Hqwx1O0G31RSseTcN
         LnhzHoYR4XlVbceRepYV7FLiiwwrMTlA/njzxS/uuGg5KR0xMrBDUyzC1fSsUaVkpE
         LPf4UAf0L/DcjoUScrexmc07uWVqIBO3OZnV0iHAT9CC9cwlw8AzhpoH3K5qqX3jFd
         iPBLUnHbFoDE7Mb5c/Yx4vhY2ZFbh1wHuWhk3SiqFyktiBC+0Ej/tjaPfldn5EJ2rO
         86/BExgZnx4Tg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8D03440B1A; Fri,  2 Jul 2021 09:46:08 -0300 (-03)
Date:   Fri, 2 Jul 2021 09:46:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, stable@kernel.org
Subject: Re: [PATCH] perf report: Fix --task and --stat with pipe input
Message-ID: <YN8KkP759PDZY6dQ@kernel.org>
References: <20210630043058.1131295-1-namhyung@kernel.org>
 <YN7skX0uRz5SrB0w@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YN7skX0uRz5SrB0w@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 02, 2021 at 12:38:09PM +0200, Jiri Olsa escreveu:
> On Tue, Jun 29, 2021 at 09:30:58PM -0700, Namhyung Kim wrote:
> > Current perf report fails to process a pipe input when --task
> > or --stat option is used.  This is because they reset all the
> > tool callbacks and failed to find a matching event for a sample.
> > 
> > When pipe input is used, the event info is passed via ATTR records
> > so it needs to handle that operation.  Otherwise the following error
> > occurred.  Note, -14 (= -EFAULT) comes from evlist__parse_sample():
> > 
> >   # perf record -a -o- sleep 1 | perf report -i- --stat
> >   Can't parse sample, err = -14
> >   0x271044 [0x38]: failed to process type: 9
> >   Error:
> >   failed to process sample
> > 
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Added this for the the benefit of stable@kernel.org:

Fixes: a4a4d0a7a2b20f78 ("perf report: Add --stats option to display quick data statistics")
 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/builtin-report.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > index bc5c393021dc..8639bbe0969d 100644
> > --- a/tools/perf/builtin-report.c
> > +++ b/tools/perf/builtin-report.c
> > @@ -729,9 +729,14 @@ static int count_sample_event(struct perf_tool *tool __maybe_unused,
> >  	return 0;
> >  }
> >  
> > +static int process_attr(struct perf_tool *tool __maybe_unused,
> > +			union perf_event *event,
> > +			struct evlist **pevlist);
> > +
> >  static void stats_setup(struct report *rep)
> >  {
> >  	memset(&rep->tool, 0, sizeof(rep->tool));
> > +	rep->tool.attr = process_attr;
> >  	rep->tool.sample = count_sample_event;
> >  	rep->tool.no_warn = true;
> >  }
> > @@ -753,6 +758,7 @@ static void tasks_setup(struct report *rep)
> >  		rep->tool.mmap = perf_event__process_mmap;
> >  		rep->tool.mmap2 = perf_event__process_mmap2;
> >  	}
> > +	rep->tool.attr = process_attr;
> >  	rep->tool.comm = perf_event__process_comm;
> >  	rep->tool.exit = perf_event__process_exit;
> >  	rep->tool.fork = perf_event__process_fork;
> > -- 
> > 2.32.0.93.g670b81a890-goog
> > 
> 

-- 

- Arnaldo
