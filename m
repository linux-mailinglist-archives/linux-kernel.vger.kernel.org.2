Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955853534D7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 19:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbhDCRNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 13:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236724AbhDCRNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 13:13:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FD1861003;
        Sat,  3 Apr 2021 17:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617470006;
        bh=Nd6uTIGhCXcJKk8v6p+Bb0Q/Jf5ZPkK6R1hzVemWUAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tNt9ucV3xJHIuOWyaSAkF4Le0iaUBjP286O/50x1qFcyDUA0AV4ZOl5eI5GSo5xV1
         D7Y++MVmBBtLT0NUBTILDpZNuHr/SXxFIkxiNo7ZWWJKm0Fk16dwBgA4Ew+zXR87na
         hT7DQ3C27NxxUy4nQf6iibLA1TDXUmbStqK+rS4x/y9itzoXpNArR1afTKIiHt4Z31
         U+5bgsJcKcOwoUyZvNu/jKcxH5hvp+eWRm5aYl9PjJTFCVRp/mXvXVzc43/sdQGFit
         TTpO9ZtwvfSk0oWewO16DhBD25PNSv0U038NXo88Wzztg2D6c3V81vB1VB9OdnQW4q
         hnQrkQT8rfMZw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AAECB40647; Sat,  3 Apr 2021 14:13:24 -0300 (-03)
Date:   Sat, 3 Apr 2021 14:13:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Alexandrov <aalexand@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf record: Disallow -c and -F option at the same time
Message-ID: <YGiiNDzHIm5oxT9n@kernel.org>
References: <20210402094020.28164-1-namhyung@kernel.org>
 <YGcd/vz3KyOUReOh@kernel.org>
 <CANtFmmo6Wq_u=D89hkfmS8yMtKhk+6pm_4YawpO-6MvS_4noaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANtFmmo6Wq_u=D89hkfmS8yMtKhk+6pm_4YawpO-6MvS_4noaw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 02, 2021 at 08:25:30PM -0700, Alexey Alexandrov escreveu:
> A warning can be missed when the tool is run by some kind of automation.
> Backward compatibility aside, I think conflicting flags should result in an
> early exit to avoid later surprises.

Sure, I agree with you in principle, but having erred out in the past,
i.e. in making this be accepted, now making this out of the blue finally
be considered what it always should have been considered, an error,
feels like an error.

I sent this message after merging the change, but before pushing it out
publicly I felt some (more) discussion would be in order.

Are you sure that potentially breaking existing scripts is ok in this
case?

Up to you, frankly.

- Arnaldo
 
> On Fri, Apr 2, 2021 at 6:37 AM Arnaldo Carvalho de Melo <acme@kernel.org>
> wrote:
> 
> > Em Fri, Apr 02, 2021 at 06:40:20PM +0900, Namhyung Kim escreveu:
> > > It's confusing which one is effective when the both options are given.
> > > The current code happens to use -c in this case but users might not be
> > > aware of it.  We can change it to complain about that instead of
> > > relying on the implicit priority.
> > >
> > > Before:
> > >   $ perf record -c 111111 -F 99 true
> > >   [ perf record: Woken up 1 times to write data ]
> > >   [ perf record: Captured and wrote 0.031 MB perf.data (8 samples) ]
> > >
> > >   $ perf evlist -F
> > >   cycles: sample_period=111111
> > >
> > > After:
> > >   $ perf record -c 111111 -F 99 true
> > >   cannot set frequency and period at the same time
> > >
> > > So this change can break existing usages, but I think it's rare to
> > > have both options and it'd be better changing them.
> >
> > Humm, perhaps we can just make that an warning stating that -c is used
> > if both are specified?
> >
> > $ perf record -c 111111 -F 99 true
> > Frequency and period can't be used the same time, -c 11111 will be used.
> >
> > - Arnaldo
> >
> > > Suggested-by: Alexey Alexandrov <aalexand@google.com>
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/record.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
> > > index f99852d54b14..43e5b563dee8 100644
> > > --- a/tools/perf/util/record.c
> > > +++ b/tools/perf/util/record.c
> > > @@ -157,9 +157,15 @@ static int get_max_rate(unsigned int *rate)
> > >  static int record_opts__config_freq(struct record_opts *opts)
> > >  {
> > >       bool user_freq = opts->user_freq != UINT_MAX;
> > > +     bool user_interval = opts->user_interval != ULLONG_MAX;
> > >       unsigned int max_rate;
> > >
> > > -     if (opts->user_interval != ULLONG_MAX)
> > > +     if (user_interval && user_freq) {
> > > +             pr_err("cannot set frequency and period at the same
> > time\n");
> > > +             return -1;
> > > +     }
> > > +
> > > +     if (user_interval)
> > >               opts->default_interval = opts->user_interval;
> > >       if (user_freq)
> > >               opts->freq = opts->user_freq;
> > > --
> > > 2.31.0.208.g409f899ff0-goog
> > >
> >
> > --
> >
> > - Arnaldo
> >

-- 

- Arnaldo
