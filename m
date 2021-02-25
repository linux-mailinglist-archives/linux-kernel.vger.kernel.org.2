Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B1E3253A2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 17:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhBYQga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 11:36:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33060 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231950AbhBYQf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 11:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614270840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Et7igBqbnPMWOABfF5S6RbAtusEqg/cELYr9FlbLbFw=;
        b=Y+Pn699TnYywHWPCqlM+r7iD4tiYKehyVn+FYrs7uCRSoo0fHCdlmT1By0q/BiSshgFhcM
        meSH/pokgu8Wj69FlwB+h1DLyyibnjGeZLapwAqOOiYCGNC/CIWL+tpmz/10a7TGTk61K2
        b/voj5h5L+QJQO5IMfSt9LKB/p9Cccw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-CQWFyTm8Psib3Y3-dugJCg-1; Thu, 25 Feb 2021 11:33:55 -0500
X-MC-Unique: CQWFyTm8Psib3Y3-dugJCg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BE56107ACC7;
        Thu, 25 Feb 2021 16:33:53 +0000 (UTC)
Received: from krava (unknown [10.40.194.234])
        by smtp.corp.redhat.com (Postfix) with SMTP id 54EDD10013D6;
        Thu, 25 Feb 2021 16:33:51 +0000 (UTC)
Date:   Thu, 25 Feb 2021 17:33:50 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Pierre.Gondois@arm.com
Cc:     linux-kernel@vger.kernel.org, douglas.raillard@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: Re: [PATCH v1] perf: cast (struct timeval).tv_sec when printing
Message-ID: <YDfRbnZxBLdStPb9@krava>
References: <20210224182410.5366-1-Pierre.Gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224182410.5366-1-Pierre.Gondois@arm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 06:24:10PM +0000, Pierre.Gondois@arm.com wrote:
> From: Pierre Gondois <Pierre.Gondois@arm.com>
> 
> The musl-libc [1] defines (struct timeval).tv_sec as a
> 'long long' for arm and other architectures. The default
> build having a '-Wformat' flag, not casting the field
> when printing prevents from building perf.
> 
> This patch casts the (struct timeval).tv_sec fields to the
> expected format.
> 
> [1] git://git.musl-libc.org/musl
> 
> Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/bench/sched-messaging.c | 4 ++--
>  tools/perf/bench/sched-pipe.c      | 4 ++--
>  tools/perf/bench/syscall.c         | 4 ++--
>  tools/perf/util/header.c           | 4 ++--
>  tools/perf/util/stat-display.c     | 2 +-
>  5 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
> index cecce93ccc63..488f6e6ba1a5 100644
> --- a/tools/perf/bench/sched-messaging.c
> +++ b/tools/perf/bench/sched-messaging.c
> @@ -309,11 +309,11 @@ int bench_sched_messaging(int argc, const char **argv)
>  		       num_groups, num_groups * 2 * num_fds,
>  		       thread_mode ? "threads" : "processes");
>  		printf(" %14s: %lu.%03lu [sec]\n", "Total time",
> -		       diff.tv_sec,
> +		       (unsigned long) diff.tv_sec,
>  		       (unsigned long) (diff.tv_usec / USEC_PER_MSEC));
>  		break;
>  	case BENCH_FORMAT_SIMPLE:
> -		printf("%lu.%03lu\n", diff.tv_sec,
> +		printf("%lu.%03lu\n", (unsigned long) diff.tv_sec,
>  		       (unsigned long) (diff.tv_usec / USEC_PER_MSEC));
>  		break;
>  	default:
> diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
> index 3c88d1f201f1..a960e7a93aec 100644
> --- a/tools/perf/bench/sched-pipe.c
> +++ b/tools/perf/bench/sched-pipe.c
> @@ -156,7 +156,7 @@ int bench_sched_pipe(int argc, const char **argv)
>  		result_usec += diff.tv_usec;
>  
>  		printf(" %14s: %lu.%03lu [sec]\n\n", "Total time",
> -		       diff.tv_sec,
> +		       (unsigned long) diff.tv_sec,
>  		       (unsigned long) (diff.tv_usec / USEC_PER_MSEC));
>  
>  		printf(" %14lf usecs/op\n",
> @@ -168,7 +168,7 @@ int bench_sched_pipe(int argc, const char **argv)
>  
>  	case BENCH_FORMAT_SIMPLE:
>  		printf("%lu.%03lu\n",
> -		       diff.tv_sec,
> +		       (unsigned long) diff.tv_sec,
>  		       (unsigned long) (diff.tv_usec / USEC_PER_MSEC));
>  		break;
>  
> diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
> index 5fe621cff8e9..9b751016f4b6 100644
> --- a/tools/perf/bench/syscall.c
> +++ b/tools/perf/bench/syscall.c
> @@ -54,7 +54,7 @@ int bench_syscall_basic(int argc, const char **argv)
>  		result_usec += diff.tv_usec;
>  
>  		printf(" %14s: %lu.%03lu [sec]\n\n", "Total time",
> -		       diff.tv_sec,
> +		       (unsigned long) diff.tv_sec,
>  		       (unsigned long) (diff.tv_usec/1000));
>  
>  		printf(" %14lf usecs/op\n",
> @@ -66,7 +66,7 @@ int bench_syscall_basic(int argc, const char **argv)
>  
>  	case BENCH_FORMAT_SIMPLE:
>  		printf("%lu.%03lu\n",
> -		       diff.tv_sec,
> +		       (unsigned long) diff.tv_sec,
>  		       (unsigned long) (diff.tv_usec / 1000));
>  		break;
>  
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 4fe9e2a54346..20effdff76ce 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1618,8 +1618,8 @@ static void print_clock_data(struct feat_fd *ff, FILE *fp)
>  
>  	fprintf(fp, "# clockid: %s (%u)\n", clockid_name(clockid), clockid);
>  	fprintf(fp, "# reference time: %s = %ld.%06d (TOD) = %ld.%09ld (%s)\n",
> -		    tstr, tod_ns.tv_sec, (int) tod_ns.tv_usec,
> -		    clockid_ns.tv_sec, clockid_ns.tv_nsec,
> +		    tstr, (long) tod_ns.tv_sec, (int) tod_ns.tv_usec,
> +		    (long) clockid_ns.tv_sec, clockid_ns.tv_nsec,
>  		    clockid_name(clockid));
>  }
>  
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index cce7a76d6473..7f09cdaf5b60 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -983,7 +983,7 @@ static void print_interval(struct perf_stat_config *config,
>  	if (config->interval_clear)
>  		puts(CONSOLE_CLEAR);
>  
> -	sprintf(prefix, "%6lu.%09lu%s", ts->tv_sec, ts->tv_nsec, config->csv_sep);
> +	sprintf(prefix, "%6lu.%09lu%s", (unsigned long) ts->tv_sec, ts->tv_nsec, config->csv_sep);
>  
>  	if ((num_print_interval == 0 && !config->csv_output) || config->interval_clear) {
>  		switch (config->aggr_mode) {
> -- 
> 2.17.1
> 

