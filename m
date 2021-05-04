Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3FF372A3A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 14:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhEDMju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 08:39:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230187AbhEDMjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 08:39:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1D9E61042;
        Tue,  4 May 2021 12:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620131935;
        bh=73D1+qDg0O7XhF7VTUJU57xQXFlfHVHsKSq9e5vR6Ns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dNKoY/30h7FJa7hvsHUgrX31ay6r5O6+IOJs0gcI1RmjEG35TiagEVs0p6WS5y3Vg
         lEWQvfffXJi5uvLYQ47IpXGuB0DPLmEIX4ya4yyZDorC/cXW/15au0JRcdQ1BW5tjp
         HzZlKixXvasGONjY2QAj5Id9soYXUkTUVEP65DKaIaitXwaADx16TimeSg9Cjuiv7A
         63cvUCLRr6xQzo5mrSKJlEP3XnA/KCiVeA1DNfOW2TZfct+0u9lori3wlfhQq3mMbG
         KQD5PytCApuKNESL68JfDumV3dPq1pLC7IdK/WiThdTN257/ubkKCBLu5A6xzKVBCF
         SkD4U0TIfjJSg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 70C764034C; Tue,  4 May 2021 09:38:52 -0300 (-03)
Date:   Tue, 4 May 2021 09:38:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf record: Disallow -c and -F option at the same time
Message-ID: <YJFAXIgIT+rNKQ7h@kernel.org>
References: <20210402094020.28164-1-namhyung@kernel.org>
 <YGcd/vz3KyOUReOh@kernel.org>
 <CANtFmmo6Wq_u=D89hkfmS8yMtKhk+6pm_4YawpO-6MvS_4noaw@mail.gmail.com>
 <YGiiNDzHIm5oxT9n@kernel.org>
 <CANtFmmqeBPW7XHAvphw9YpGy74b3T-jfzg1op+9ZyU=YLDLjDg@mail.gmail.com>
 <CAM9d7chSn8E3w21b3ASDt-pzhqBD8_Pm6DH4sgtOJKde7=qXPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chSn8E3w21b3ASDt-pzhqBD8_Pm6DH4sgtOJKde7=qXPQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 03, 2021 at 02:32:32PM -0700, Namhyung Kim escreveu:
> Hi Arnaldo,
> 
> (Adjusting thetop-post)
> 
> On Sat, Apr 3, 2021 at 10:35 AM Alexey Alexandrov <aalexand@google.com> wrote:
> > On Sat, Apr 3, 2021, 10:13 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >>
> >> Em Fri, Apr 02, 2021 at 08:25:30PM -0700, Alexey Alexandrov escreveu:
> >> > A warning can be missed when the tool is run by some kind of automation.
> >> > Backward compatibility aside, I think conflicting flags should result in an
> >> > early exit to avoid later surprises.
> >>
> >> Sure, I agree with you in principle, but having erred out in the past,
> >> i.e. in making this be accepted, now making this out of the blue finally
> >> be considered what it always should have been considered, an error,
> >> feels like an error.
> >>
> >> I sent this message after merging the change, but before pushing it out
> >> publicly I felt some (more) discussion would be in order.
> >>
> >> Are you sure that potentially breaking existing scripts is ok in this
> >> case?
> >>
> >> Up to you, frankly.
> >
> > I personally think it's ok to break the existing conflicting usages of these flags because the owners of those invocations need to review and fix them to know what they are doing.
> >
> > At the same time, this can be a two-step movement: maybe first let's make it an error message that imperatively states the problem and makes it clear that the invocation needs to be fixed, then (after X months) make it an exiting error.
> 
> So what do you think?  I can make some changes if you want.
> But as it's rare and should be fixed anyway, I think we're good now.

Fair enough, I'm applying it as-is,

- Arnaldo
 
> Thanks,
> Namhyung
> 
> >
> >> > wrote:
> >> >
> >> > > Em Fri, Apr 02, 2021 at 06:40:20PM +0900, Namhyung Kim escreveu:
> >> > > > It's confusing which one is effective when the both options are given.
> >> > > > The current code happens to use -c in this case but users might not be
> >> > > > aware of it.  We can change it to complain about that instead of
> >> > > > relying on the implicit priority.
> >> > > >
> >> > > > Before:
> >> > > >   $ perf record -c 111111 -F 99 true
> >> > > >   [ perf record: Woken up 1 times to write data ]
> >> > > >   [ perf record: Captured and wrote 0.031 MB perf.data (8 samples) ]
> >> > > >
> >> > > >   $ perf evlist -F
> >> > > >   cycles: sample_period=111111
> >> > > >
> >> > > > After:
> >> > > >   $ perf record -c 111111 -F 99 true
> >> > > >   cannot set frequency and period at the same time
> >> > > >
> >> > > > So this change can break existing usages, but I think it's rare to
> >> > > > have both options and it'd be better changing them.
> >> > >
> >> > > Humm, perhaps we can just make that an warning stating that -c is used
> >> > > if both are specified?
> >> > >
> >> > > $ perf record -c 111111 -F 99 true
> >> > > Frequency and period can't be used the same time, -c 11111 will be used.
> >> > >
> >> > > - Arnaldo
> >> > >
> >> > > > Suggested-by: Alexey Alexandrov <aalexand@google.com>
> >> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >> > > > ---
> >> > > >  tools/perf/util/record.c | 8 +++++++-
> >> > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> >> > > >
> >> > > > diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
> >> > > > index f99852d54b14..43e5b563dee8 100644
> >> > > > --- a/tools/perf/util/record.c
> >> > > > +++ b/tools/perf/util/record.c
> >> > > > @@ -157,9 +157,15 @@ static int get_max_rate(unsigned int *rate)
> >> > > >  static int record_opts__config_freq(struct record_opts *opts)
> >> > > >  {
> >> > > >       bool user_freq = opts->user_freq != UINT_MAX;
> >> > > > +     bool user_interval = opts->user_interval != ULLONG_MAX;
> >> > > >       unsigned int max_rate;
> >> > > >
> >> > > > -     if (opts->user_interval != ULLONG_MAX)
> >> > > > +     if (user_interval && user_freq) {
> >> > > > +             pr_err("cannot set frequency and period at the same
> >> > > time\n");
> >> > > > +             return -1;
> >> > > > +     }
> >> > > > +
> >> > > > +     if (user_interval)
> >> > > >               opts->default_interval = opts->user_interval;
> >> > > >       if (user_freq)
> >> > > >               opts->freq = opts->user_freq;
> >> > > > --
> >> > > > 2.31.0.208.g409f899ff0-goog
> >> > > >
> >> > >
> >> > > --
> >> > >
> >> > > - Arnaldo
> >> > >
> >>
> >> --
> >>
> >> - Arnaldo

-- 

- Arnaldo
