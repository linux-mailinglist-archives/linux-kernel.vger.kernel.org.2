Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0E836A80E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 17:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhDYPu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 11:50:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230288AbhDYPu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 11:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619365814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SpOAzQZIq10Nwe26WkJZs4EOWy5T6jlT3LYy+FshtrY=;
        b=FHMh9elIq63+jQ5jfTF8O7zzkG7xwDs+6gZtEQgsg0V43n5YWINtf7NdJpxDepsrLgYYgA
        TOz0z5BNSdkOVZAxFJjBm9XuWDwowJLf3pBzaWWfUFE/YmaW78PS/j2BmR3GRVkTLg9g/E
        Ej4d55meXG2AESa20SubrcpWrxOwlaU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-jVGq0KGBOD2T7JvR945wng-1; Sun, 25 Apr 2021 11:50:12 -0400
X-MC-Unique: jVGq0KGBOD2T7JvR945wng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64812343A4;
        Sun, 25 Apr 2021 15:50:10 +0000 (UTC)
Received: from krava (unknown [10.40.192.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id DA3685D9CC;
        Sun, 25 Apr 2021 15:50:07 +0000 (UTC)
Date:   Sun, 25 Apr 2021 17:50:07 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>
Subject: Re: [PATCH] perf stat: Use aggregated counts directly
Message-ID: <YIWPr5LFOAmQ0fg7@krava>
References: <20210423023833.1430520-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423023833.1430520-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 07:38:33PM -0700, Namhyung Kim wrote:
> The ps->res_stats is for repeated runs, so the interval code should
> not touch it.  Actually the aggregated counts are available in the
> counter->counts->aggr, so we can (and should) use it directly IMHO.
> 
> No functional change intended.

it looks ok, but it should fix the noise output then, right?

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/stat-display.c |  8 ++++----
>  tools/perf/util/stat.c         | 12 ------------
>  2 files changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index d3137bc17065..a38fa6527586 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -807,11 +807,11 @@ static void counter_aggr_cb(struct perf_stat_config *config __maybe_unused,
>  			    bool first __maybe_unused)
>  {
>  	struct caggr_data *cd = data;
> -	struct perf_stat_evsel *ps = counter->stats;
> +	struct perf_counts_values *aggr = &counter->counts->aggr;
>  
> -	cd->avg += avg_stats(&ps->res_stats[0]);
> -	cd->avg_enabled += avg_stats(&ps->res_stats[1]);
> -	cd->avg_running += avg_stats(&ps->res_stats[2]);
> +	cd->avg += aggr->val;
> +	cd->avg_enabled += aggr->ena;
> +	cd->avg_running += aggr->run;
>  }
>  
>  /*
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 2db46b9bebd0..d3ec2624e036 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -437,18 +437,6 @@ int perf_stat_process_counter(struct perf_stat_config *config,
>  
>  	aggr->val = aggr->ena = aggr->run = 0;
>  
> -	/*
> -	 * We calculate counter's data every interval,
> -	 * and the display code shows ps->res_stats
> -	 * avg value. We need to zero the stats for
> -	 * interval mode, otherwise overall avg running
> -	 * averages will be shown for each interval.
> -	 */
> -	if (config->interval || config->summary) {
> -		for (i = 0; i < 3; i++)
> -			init_stats(&ps->res_stats[i]);
> -	}
> -
>  	if (counter->per_pkg)
>  		evsel__zero_per_pkg(counter);
>  
> -- 
> 2.31.1.498.g6c1eba8ee3d-goog
> 

