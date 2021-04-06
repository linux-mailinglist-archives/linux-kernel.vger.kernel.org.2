Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3A1355680
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 16:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345100AbhDFOWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 10:22:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29751 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237043AbhDFOWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617718914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jWG+3T4R82V+nNLoc/cnb3myLsmzT223wWW0Bef6Vg8=;
        b=Eb913nqgS8MvEA12Ap9/NBNEF3nSd2Cu+qu/DNddhePKnM7S8bmHy1DGn2nz8Kl9V4OBV1
        +tuK3hPtpdt5qm3DcOxvuULsJuYUIPstUBd8H1/8jvrAY8Fe8mVpFS0bmzXIldheZTztyA
        LyEIrTBo0avE4/ogHZhq0/jxZphFwoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-tCMy5Zx6NHq0ZvXSawL3Zw-1; Tue, 06 Apr 2021 10:21:51 -0400
X-MC-Unique: tCMy5Zx6NHq0ZvXSawL3Zw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2A7184B9A0;
        Tue,  6 Apr 2021 14:21:49 +0000 (UTC)
Received: from krava (unknown [10.40.195.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1576719C44;
        Tue,  6 Apr 2021 14:21:47 +0000 (UTC)
Date:   Tue, 6 Apr 2021 16:21:47 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, acme@kernel.org,
        acme@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        songliubraving@fb.com
Subject: Re: [PATCH 2/2] perf-stat: introduce config stat.bpf-counter-events
Message-ID: <YGxue1aHQUFj+UaG@krava>
References: <20210403002938.390878-1-song@kernel.org>
 <20210403002938.390878-2-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210403002938.390878-2-song@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 05:29:38PM -0700, Song Liu wrote:
> Currently, to use BPF to aggregate perf event counters, the user uses
> --bpf-counters option. Enable "use bpf by default" events with a config
> option, stat.bpf-counter-events. This is limited to hardware events in
> evsel__hw_names.
> 
> This also enables mixed BPF event and regular event in the same sesssion.
> For example:
> 
>    perf config stat.bpf-counter-events=instructions
>    perf stat -e instructions,cs

hum, so this will effectively allow to mix 'bpf-shared' counters
with normals ones.. I don't think we're ready for that ;-)

> 
> The second command will use BPF for "instructions" but not "cs".
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  tools/perf/Documentation/perf-stat.txt |  2 ++
>  tools/perf/builtin-stat.c              | 41 ++++++++++++++++----------
>  tools/perf/util/bpf_counter.c          | 11 +++++++
>  tools/perf/util/config.c               | 32 ++++++++++++++++++++
>  tools/perf/util/evsel.c                |  2 ++
>  tools/perf/util/evsel.h                |  1 +
>  tools/perf/util/target.h               |  5 ----
>  7 files changed, 74 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 744211fa8c186..6d4733eaac170 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -97,6 +97,8 @@ report::
>  	Use BPF programs to aggregate readings from perf_events.  This
>  	allows multiple perf-stat sessions that are counting the same metric (cycles,
>  	instructions, etc.) to share hardware counters.
> +	To use BPF programs on common hardware events by default, use
> +	"perf config stat.bpf-counter-events=<list_of_events>".
>  
>  --bpf-attr-map::
>  	With option "--bpf-counters", different perf-stat sessions share
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 4bb48c6b66980..5adfa708ffe68 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -423,17 +423,28 @@ static int read_affinity_counters(struct timespec *rs)
>  	return 0;
>  }
>  
> +/*
> + * Returns:
> + *     0   if all events use BPF;
> + *     1   if some events do NOT use BPF;
> + *     < 0 on errors;
> + */
>  static int read_bpf_map_counters(void)
>  {
> +	bool has_none_bpf_events = false;
>  	struct evsel *counter;
>  	int err;
>  
>  	evlist__for_each_entry(evsel_list, counter) {
> +		if (!counter->bpf_counter_ops) {
> +			has_none_bpf_events = true;
> +			continue;
> +		}
>  		err = bpf_counter__read(counter);
>  		if (err)
>  			return err;
>  	}
> -	return 0;
> +	return has_none_bpf_events ? 1 : 0;
>  }
>  
>  static void read_counters(struct timespec *rs)
> @@ -442,9 +453,10 @@ static void read_counters(struct timespec *rs)
>  	int err;
>  
>  	if (!stat_config.stop_read_counter) {
> -		if (target__has_bpf(&target))
> -			err = read_bpf_map_counters();
> -		else
> +		err = read_bpf_map_counters();
> +		if (err < 0)
> +			return;
> +		if (err)
>  			err = read_affinity_counters(rs);

so read_affinity_counters will read also 'bpf-shared' counters no?
as long as it was separated, I did not see a problem, now we have
counters that either have bpf ops set or have not

it'd be great to do some generic separation.. I was thinking to move
bpf_counter_ops into some generic counter ops and we would just fill
in the proper ops for the counter.. buuut the affinity readings are
not compatible with what we are doing in bperf_read and the profiler
bpf read

so I think the solution will be just to skip those events in
read_affinity_counters and all the other code, and have some
helper like:

   bool evsel__is_bpf(evsel)

so it's clear why it's skipped

thanks,
jirka

