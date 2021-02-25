Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5923255D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhBYSvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:51:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232761AbhBYSug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:50:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A2A364F03;
        Thu, 25 Feb 2021 18:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614278988;
        bh=cO1A90HJq5WC7AsP6oBY98abtjEqjFUpdJIRMSAFquI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bhkLo7QzYgN6k0KQnzQkPNh/7XjzE2OsSGQEkTBJw69F16drZ6aCyTEo+tEzCDOl0
         p76aMYurXAwzRD+cDC6zfS2aQCpMudMz3v/rUnNtNU78PV69Hnxd3eT9Ni8VS7k7PB
         7+GUblb0+SoUglA/PoeW6ZAxkCsX5GSVZn19omuswc0y0iwMFr8KYqLyjrntV/IiMV
         KP1zvb5Km/vKEbFX8HIV4emRREOxVC6+VDPafIF/Kvojil6kQs+ToqxIk8vqy8Kw6O
         8VX+x+e8tln5UUYJfeBCnooowTAkKurzCPp7vUVY+ki1Srt42U4plJqPFHapig8gJL
         y2V9Lgn5wbVWg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2325540CD9; Thu, 25 Feb 2021 15:49:45 -0300 (-03)
Date:   Thu, 25 Feb 2021 15:49:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Pierre.Gondois@arm.com, linux-kernel@vger.kernel.org,
        douglas.raillard@arm.com, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: Re: [PATCH v1] perf: cast (struct timeval).tv_sec when printing
Message-ID: <YDfxSXAwDBps7TEW@kernel.org>
References: <20210224182410.5366-1-Pierre.Gondois@arm.com>
 <YDfRbnZxBLdStPb9@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDfRbnZxBLdStPb9@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 25, 2021 at 05:33:50PM +0100, Jiri Olsa escreveu:
> On Wed, Feb 24, 2021 at 06:24:10PM +0000, Pierre.Gondois@arm.com wrote:
> > From: Pierre Gondois <Pierre.Gondois@arm.com>
> > 
> > The musl-libc [1] defines (struct timeval).tv_sec as a
> > 'long long' for arm and other architectures. The default
> > build having a '-Wformat' flag, not casting the field
> > when printing prevents from building perf.
> > 
> > This patch casts the (struct timeval).tv_sec fields to the
> > expected format.
> > 
> > [1] git://git.musl-libc.org/musl
> > 
> > Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo


> thanks,
> jirka
> 
> > ---
> >  tools/perf/bench/sched-messaging.c | 4 ++--
> >  tools/perf/bench/sched-pipe.c      | 4 ++--
> >  tools/perf/bench/syscall.c         | 4 ++--
> >  tools/perf/util/header.c           | 4 ++--
> >  tools/perf/util/stat-display.c     | 2 +-
> >  5 files changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
> > index cecce93ccc63..488f6e6ba1a5 100644
> > --- a/tools/perf/bench/sched-messaging.c
> > +++ b/tools/perf/bench/sched-messaging.c
> > @@ -309,11 +309,11 @@ int bench_sched_messaging(int argc, const char **argv)
> >  		       num_groups, num_groups * 2 * num_fds,
> >  		       thread_mode ? "threads" : "processes");
> >  		printf(" %14s: %lu.%03lu [sec]\n", "Total time",
> > -		       diff.tv_sec,
> > +		       (unsigned long) diff.tv_sec,
> >  		       (unsigned long) (diff.tv_usec / USEC_PER_MSEC));
> >  		break;
> >  	case BENCH_FORMAT_SIMPLE:
> > -		printf("%lu.%03lu\n", diff.tv_sec,
> > +		printf("%lu.%03lu\n", (unsigned long) diff.tv_sec,
> >  		       (unsigned long) (diff.tv_usec / USEC_PER_MSEC));
> >  		break;
> >  	default:
> > diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
> > index 3c88d1f201f1..a960e7a93aec 100644
> > --- a/tools/perf/bench/sched-pipe.c
> > +++ b/tools/perf/bench/sched-pipe.c
> > @@ -156,7 +156,7 @@ int bench_sched_pipe(int argc, const char **argv)
> >  		result_usec += diff.tv_usec;
> >  
> >  		printf(" %14s: %lu.%03lu [sec]\n\n", "Total time",
> > -		       diff.tv_sec,
> > +		       (unsigned long) diff.tv_sec,
> >  		       (unsigned long) (diff.tv_usec / USEC_PER_MSEC));
> >  
> >  		printf(" %14lf usecs/op\n",
> > @@ -168,7 +168,7 @@ int bench_sched_pipe(int argc, const char **argv)
> >  
> >  	case BENCH_FORMAT_SIMPLE:
> >  		printf("%lu.%03lu\n",
> > -		       diff.tv_sec,
> > +		       (unsigned long) diff.tv_sec,
> >  		       (unsigned long) (diff.tv_usec / USEC_PER_MSEC));
> >  		break;
> >  
> > diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
> > index 5fe621cff8e9..9b751016f4b6 100644
> > --- a/tools/perf/bench/syscall.c
> > +++ b/tools/perf/bench/syscall.c
> > @@ -54,7 +54,7 @@ int bench_syscall_basic(int argc, const char **argv)
> >  		result_usec += diff.tv_usec;
> >  
> >  		printf(" %14s: %lu.%03lu [sec]\n\n", "Total time",
> > -		       diff.tv_sec,
> > +		       (unsigned long) diff.tv_sec,
> >  		       (unsigned long) (diff.tv_usec/1000));
> >  
> >  		printf(" %14lf usecs/op\n",
> > @@ -66,7 +66,7 @@ int bench_syscall_basic(int argc, const char **argv)
> >  
> >  	case BENCH_FORMAT_SIMPLE:
> >  		printf("%lu.%03lu\n",
> > -		       diff.tv_sec,
> > +		       (unsigned long) diff.tv_sec,
> >  		       (unsigned long) (diff.tv_usec / 1000));
> >  		break;
> >  
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index 4fe9e2a54346..20effdff76ce 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -1618,8 +1618,8 @@ static void print_clock_data(struct feat_fd *ff, FILE *fp)
> >  
> >  	fprintf(fp, "# clockid: %s (%u)\n", clockid_name(clockid), clockid);
> >  	fprintf(fp, "# reference time: %s = %ld.%06d (TOD) = %ld.%09ld (%s)\n",
> > -		    tstr, tod_ns.tv_sec, (int) tod_ns.tv_usec,
> > -		    clockid_ns.tv_sec, clockid_ns.tv_nsec,
> > +		    tstr, (long) tod_ns.tv_sec, (int) tod_ns.tv_usec,
> > +		    (long) clockid_ns.tv_sec, clockid_ns.tv_nsec,
> >  		    clockid_name(clockid));
> >  }
> >  
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index cce7a76d6473..7f09cdaf5b60 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -983,7 +983,7 @@ static void print_interval(struct perf_stat_config *config,
> >  	if (config->interval_clear)
> >  		puts(CONSOLE_CLEAR);
> >  
> > -	sprintf(prefix, "%6lu.%09lu%s", ts->tv_sec, ts->tv_nsec, config->csv_sep);
> > +	sprintf(prefix, "%6lu.%09lu%s", (unsigned long) ts->tv_sec, ts->tv_nsec, config->csv_sep);
> >  
> >  	if ((num_print_interval == 0 && !config->csv_output) || config->interval_clear) {
> >  		switch (config->aggr_mode) {
> > -- 
> > 2.17.1
> > 
> 

-- 

- Arnaldo
