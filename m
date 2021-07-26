Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFBF3D5A26
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 15:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhGZMfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 08:35:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48641 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233362AbhGZMfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627305350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3BckGZrpnYgzo6JT4RVHB96+71K0n/cul1nqRDu5Z6o=;
        b=dQl6VQ14WTKAJmJLi+k5S6eRv92iKkHf8dxd7SYYZS0cMw6LH6IqAJppx1ydAbXf0iOGMB
        x57aqNp07UbCNxhW4nG5bAo/0jNZOtIw6d8J8OvSknGd7QiGEg3Z0m0/2YLhu5o4x2b47I
        ODyib0ZxQLEwhFgQIELFi80c5YDXgio=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-ta0YKTvoPnesETgODTCIPg-1; Mon, 26 Jul 2021 09:15:49 -0400
X-MC-Unique: ta0YKTvoPnesETgODTCIPg-1
Received: by mail-wm1-f72.google.com with SMTP id k4-20020a05600c1c84b0290210c73f067aso666933wms.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 06:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3BckGZrpnYgzo6JT4RVHB96+71K0n/cul1nqRDu5Z6o=;
        b=VCvBlGduWtJ7rtWbVqqc4+7X9rFypNe5yQXeJRXe6Zg31jwTXCCED9/ytw5AsWvzj0
         C7mDsmPFnbAftlyh/PD3w0+8RlMSP+4W9osmaawotrKtVcxNPLKziSnW52X4eE820r9c
         JNFjHnOVr6jQJr2EDFCCBIJTPfPCnbCJkk8Q30MBP6BKVcYiIC+J+gyVCf+WjfriHIcc
         DKDbbWtcV6BMzuMcBqpH7FMjqCM1FYm2t6Wyz3xDzU32kYOJhgtZmTfjC7Ndgj6fxs62
         lcOeE/v4TIu2EwGYtsYruiL//z1hR5xhVt+swyiExrVbVI4l/czcZXuiFwQZljf5UhoC
         Fd0w==
X-Gm-Message-State: AOAM531+b7xgVo+kJ9eg/8yJPtiMsZ032LSxQXcmWx2DZFSPNiRNdn7u
        PL9U7GEqJzCm41uIiMJCrRkG0c4N8mwJyfCqpewpdxJKuWWb58SAcJWFoXQxdiMW9QhS4XxDmnZ
        6FjlKWYcZ/oTaShkT0GOSQDnV
X-Received: by 2002:a5d:4251:: with SMTP id s17mr4097208wrr.154.1627305347664;
        Mon, 26 Jul 2021 06:15:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrecVIR24oOyszJQyrZMvu9wQHp84x89yy+ssvfhf36fjb4l6w2vRBicG5C2NWmk68TqOBiQ==
X-Received: by 2002:a5d:4251:: with SMTP id s17mr4097167wrr.154.1627305347395;
        Mon, 26 Jul 2021 06:15:47 -0700 (PDT)
Received: from krava ([83.240.61.166])
        by smtp.gmail.com with ESMTPSA id 129sm36451944wmz.26.2021.07.26.06.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 06:15:46 -0700 (PDT)
Date:   Mon, 26 Jul 2021 15:15:44 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>
Subject: Re: [PATCH v2 2/2] perf record: Add --synth option
Message-ID: <YP61gJD91GwvfzwT@krava>
References: <20210724040129.2268452-1-namhyung@kernel.org>
 <20210724040129.2268452-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210724040129.2268452-2-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 09:01:29PM -0700, Namhyung Kim wrote:
> Add an option to control synthesize behavior.
> 
>     --synth <no|all|task|mmap|cgroup>
>                       Fine-tune event synthesis: default=all
> 
> This can be useful when we know it doesn't need some synthesis like
> in a specific usecase and/or when using pipe:
> 
>   $ perf record -a --all-cgroups --synth cgroup -o- sleep 1 | \
>   > perf report -i- -s cgroup
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-record.txt |  9 +++++
>  tools/perf/builtin-record.c              | 48 +++++++++++++++++++-----
>  tools/perf/util/record.h                 |  1 +
>  tools/perf/util/synthetic-events.c       | 28 ++++++++++++++
>  tools/perf/util/synthetic-events.h       | 12 ++++++
>  5 files changed, 89 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index d71bac847936..03a41bec0583 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -596,6 +596,15 @@ options.
>  'perf record --dry-run -e' can act as a BPF script compiler if llvm.dump-obj
>  in config file is set to true.
>  
> +--synth=TYPE::
> +Collect and synthesize given type of events (comma separated).
> +Available types are:
> +  'task'    - synthesize FORK and COMM events for each task
> +  'mmap'    - synthesize MMAP events for each process (implies 'task')
> +  'cgroup'  - synthesize CGROUP events for each cgroup
> +  'all'     - synthesize all events (default)
> +  'no'      - do not synthesize any of the above events

this only affects events we take from proc right?

should we perhaps mention it, because you'll get mmap
events from kernel even if you specify --synth=task

jirka


> +
>  --tail-synthesize::
>  Instead of collecting non-sample events (for example, fork, comm, mmap) at
>  the beginning of record, collect them during finalizing an output file.
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 535da4dfd8d3..caaada3594ce 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1254,6 +1254,7 @@ static int record__synthesize_workload(struct record *rec, bool tail)
>  {
>  	int err;
>  	struct perf_thread_map *thread_map;
> +	bool needs_mmap = rec->opts.synth & PERF_SYNTH_MMAP;
>  
>  	if (rec->opts.tail_synthesize != tail)
>  		return 0;
> @@ -1265,7 +1266,7 @@ static int record__synthesize_workload(struct record *rec, bool tail)
>  	err = perf_event__synthesize_thread_map(&rec->tool, thread_map,
>  						 process_synthesized_event,
>  						 &rec->session->machines.host,
> -						 true,
> +						 needs_mmap,
>  						 rec->opts.sample_address);
>  	perf_thread_map__put(thread_map);
>  	return err;
> @@ -1500,20 +1501,26 @@ static int record__synthesize(struct record *rec, bool tail)
>  	if (err < 0)
>  		pr_warning("Couldn't synthesize bpf events.\n");
>  
> -	err = perf_event__synthesize_cgroups(tool, process_synthesized_event,
> -					     machine);
> -	if (err < 0)
> -		pr_warning("Couldn't synthesize cgroup events.\n");
> +	if (rec->opts.synth & PERF_SYNTH_CGROUP) {
> +		err = perf_event__synthesize_cgroups(tool, process_synthesized_event,
> +						     machine);
> +		if (err < 0)
> +			pr_warning("Couldn't synthesize cgroup events.\n");
> +	}
>  
>  	if (rec->opts.nr_threads_synthesize > 1) {
>  		perf_set_multithreaded();
>  		f = process_locked_synthesized_event;
>  	}
>  
> -	err = __machine__synthesize_threads(machine, tool, &opts->target,
> -					    rec->evlist->core.threads,
> -					    f, true, opts->sample_address,
> -					    rec->opts.nr_threads_synthesize);
> +	if (rec->opts.synth & PERF_SYNTH_TASK) {
> +		bool needs_mmap = rec->opts.synth & PERF_SYNTH_MMAP;
> +
> +		err = __machine__synthesize_threads(machine, tool, &opts->target,
> +						    rec->evlist->core.threads,
> +						    f, needs_mmap, opts->sample_address,
> +						    rec->opts.nr_threads_synthesize);
> +	}
>  
>  	if (rec->opts.nr_threads_synthesize > 1)
>  		perf_set_singlethreaded();
> @@ -2422,6 +2429,26 @@ static int process_timestamp_boundary(struct perf_tool *tool,
>  	return 0;
>  }
>  
> +static int parse_record_synth_option(const struct option *opt,
> +				     const char *str,
> +				     int unset __maybe_unused)
> +{
> +	struct record_opts *opts = opt->value;
> +	char *p = strdup(str);
> +
> +	if (p == NULL)
> +		return -1;
> +
> +	opts->synth = parse_synth_opt(p);
> +	free(p);
> +
> +	if (opts->synth < 0) {
> +		pr_err("Invalid synth option: %s\n", str);
> +		return -1;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * XXX Ideally would be local to cmd_record() and passed to a record__new
>   * because we need to have access to it in record__exit, that is called
> @@ -2447,6 +2474,7 @@ static struct record record = {
>  		.nr_threads_synthesize = 1,
>  		.ctl_fd              = -1,
>  		.ctl_fd_ack          = -1,
> +		.synth               = PERF_SYNTH_ALL,
>  	},
>  	.tool = {
>  		.sample		= process_sample_event,
> @@ -2662,6 +2690,8 @@ static struct option __record_options[] = {
>  		     "\t\t\t  Optionally send control command completion ('ack\\n') to ack-fd descriptor.\n"
>  		     "\t\t\t  Alternatively, ctl-fifo / ack-fifo will be opened and used as ctl-fd / ack-fd.",
>  		      parse_control_option),
> +	OPT_CALLBACK(0, "synth", &record.opts, "no|all|task|mmap|cgroup",
> +		     "Fine-tune event synthesis: default=all", parse_record_synth_option),
>  	OPT_END()
>  };
>  
> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> index 68f471d9a88b..ef6c2715fdd9 100644
> --- a/tools/perf/util/record.h
> +++ b/tools/perf/util/record.h
> @@ -77,6 +77,7 @@ struct record_opts {
>  	int	      ctl_fd;
>  	int	      ctl_fd_ack;
>  	bool	      ctl_fd_close;
> +	int	      synth;
>  };
>  
>  extern const char * const *record_usage;
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 566e0859fcfb..9485d0532b9c 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -2186,3 +2186,31 @@ int perf_event__synthesize_features(struct perf_tool *tool, struct perf_session
>  	free(ff.buf);
>  	return ret;
>  }
> +
> +int parse_synth_opt(char *synth)
> +{
> +	char *p, *q;
> +	int ret = 0;
> +
> +	if (synth == NULL)
> +		return -1;
> +
> +	for (q = synth; (p = strsep(&q, ",")); p = q) {
> +		if (!strcasecmp(p, "no") || !strcasecmp(p, "none"))
> +			return 0;
> +
> +		if (!strcasecmp(p, "all"))
> +			return PERF_SYNTH_ALL;
> +
> +		if (!strcasecmp(p, "task"))
> +			ret |= PERF_SYNTH_TASK;
> +		else if (!strcasecmp(p, "mmap"))
> +			ret |= PERF_SYNTH_TASK | PERF_SYNTH_MMAP;
> +		else if (!strcasecmp(p, "cgroup"))
> +			ret |= PERF_SYNTH_CGROUP;
> +		else
> +			return -1;
> +	}
> +
> +	return ret;
> +}
> diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
> index 61bbdb3b64df..913803506345 100644
> --- a/tools/perf/util/synthetic-events.h
> +++ b/tools/perf/util/synthetic-events.h
> @@ -26,6 +26,18 @@ struct target;
>  
>  union perf_event;
>  
> +enum perf_record_synth {
> +	PERF_SYNTH_TASK		= 1 << 0,
> +	PERF_SYNTH_MMAP		= 1 << 1,
> +	PERF_SYNTH_CGROUP	= 1 << 2,
> +
> +	/* last element */
> +	PERF_SYNTH_MAX		= 1 << 3,
> +};
> +#define PERF_SYNTH_ALL  (PERF_SYNTH_MAX - 1)
> +
> +int parse_synth_opt(char *str);
> +
>  typedef int (*perf_event__handler_t)(struct perf_tool *tool, union perf_event *event,
>  				     struct perf_sample *sample, struct machine *machine);
>  
> -- 
> 2.32.0.432.gabb21c7263-goog
> 

