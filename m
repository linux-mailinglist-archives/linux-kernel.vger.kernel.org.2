Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C481395325
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 00:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhE3WQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 18:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55634 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229847AbhE3WQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 18:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622412913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GQnT8bnjaGzcDkrzr8sel+XgsVEtNq0qUeLfMEz/0yI=;
        b=AVFBXsmUg0BolnRM4xDZV+z5QAlj2K9HmLkHqXHTbbbdxujAlSOa9Ue6np1pYNtM5GQ5/1
        owpVit+jDjB1NHkKI7bZqdJwWIV1UaaZfsnBST33C4ZkbSxMnWKuRlhbUzVzEafBUMPAFQ
        jGMsWHpS9DikDh7eRSa8s6/TmghhTXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-aVtQwBKJMq6At3cW0sjyCQ-1; Sun, 30 May 2021 18:15:09 -0400
X-MC-Unique: aVtQwBKJMq6At3cW0sjyCQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 219D6107ACCA;
        Sun, 30 May 2021 22:15:08 +0000 (UTC)
Received: from krava (unknown [10.40.192.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3197810016FE;
        Sun, 30 May 2021 22:15:06 +0000 (UTC)
Date:   Mon, 31 May 2021 00:15:05 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf tools: Move probing cgroup sampling support
Message-ID: <YLQOaeRwsbaFs4DX@krava>
References: <20210527182835.1634339-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527182835.1634339-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 11:28:35AM -0700, Namhyung Kim wrote:
> I found that checking cgroup sampling support using the missing
> features doesn't work on old kernels.  Because it added both
> attr.cgroup bit and PERF_SAMPLE_CGROUP bit, it needs to check
> whichever comes first (usually the actual event, not dummy).
> 
> But it only checks the attr.cgroup bit which is set only in the dummy
> event so cannot detect failtures due the sample bits.  Also we don't
> ignore the missing feature and retry, it'd be better checking it with
> the API probing logic.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/builtin-record.c      |  6 ++++++
>  tools/perf/util/evsel.c          |  6 +-----
>  tools/perf/util/evsel.h          |  1 -
>  tools/perf/util/perf_api_probe.c | 10 ++++++++++
>  tools/perf/util/perf_api_probe.h |  1 +
>  5 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index bc3dd379eb67..71efe6573ee7 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -2733,6 +2733,12 @@ int cmd_record(int argc, const char **argv)
>  		rec->no_buildid = true;
>  	}
>  
> +	if (rec->opts.record_cgroup && !perf_can_record_cgroup()) {
> +		pr_err("Kernel has no cgroup sampling support.\n");
> +		err = -EINVAL;
> +		goto out_opts;
> +	}
> +
>  	if (rec->opts.kcore)
>  		rec->data.is_dir = true;
>  
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 4a3cd1b5bb33..2462584d0ee5 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1217,7 +1217,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
>  		attr->namespaces  = track;
>  
>  	if (opts->record_cgroup) {
> -		attr->cgroup = track && !perf_missing_features.cgroup;
> +		attr->cgroup = track;
>  		evsel__set_sample_bit(evsel, CGROUP);
>  	}
>  
> @@ -1933,10 +1933,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  		perf_missing_features.data_page_size = true;
>  		pr_debug2_peo("Kernel has no PERF_SAMPLE_DATA_PAGE_SIZE support, bailing out\n");
>  		goto out_close;
> -	} else if (!perf_missing_features.cgroup && evsel->core.attr.cgroup) {
> -		perf_missing_features.cgroup = true;
> -		pr_debug2_peo("Kernel has no cgroup sampling support, bailing out\n");
> -		goto out_close;
>          } else if (!perf_missing_features.branch_hw_idx &&
>  	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX)) {
>  		perf_missing_features.branch_hw_idx = true;
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 75cf5dbfe208..fecf13c0e4da 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -168,7 +168,6 @@ struct perf_missing_features {
>  	bool bpf;
>  	bool aux_output;
>  	bool branch_hw_idx;
> -	bool cgroup;
>  	bool data_page_size;
>  	bool code_page_size;
>  	bool weight_struct;
> diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
> index 829af17a0867..020411682a3c 100644
> --- a/tools/perf/util/perf_api_probe.c
> +++ b/tools/perf/util/perf_api_probe.c
> @@ -103,6 +103,11 @@ static void perf_probe_build_id(struct evsel *evsel)
>  	evsel->core.attr.build_id = 1;
>  }
>  
> +static void perf_probe_cgroup(struct evsel *evsel)
> +{
> +	evsel->core.attr.cgroup = 1;
> +}
> +
>  bool perf_can_sample_identifier(void)
>  {
>  	return perf_probe_api(perf_probe_sample_identifier);
> @@ -182,3 +187,8 @@ bool perf_can_record_build_id(void)
>  {
>  	return perf_probe_api(perf_probe_build_id);
>  }
> +
> +bool perf_can_record_cgroup(void)
> +{
> +	return perf_probe_api(perf_probe_cgroup);
> +}
> diff --git a/tools/perf/util/perf_api_probe.h b/tools/perf/util/perf_api_probe.h
> index f12ca55f509a..b104168efb15 100644
> --- a/tools/perf/util/perf_api_probe.h
> +++ b/tools/perf/util/perf_api_probe.h
> @@ -12,5 +12,6 @@ bool perf_can_record_switch_events(void);
>  bool perf_can_record_text_poke_events(void);
>  bool perf_can_sample_identifier(void);
>  bool perf_can_record_build_id(void);
> +bool perf_can_record_cgroup(void);
>  
>  #endif // __PERF_API_PROBE_H
> -- 
> 2.32.0.rc0.204.g9fa02ecfa5-goog
> 

