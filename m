Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89E240F6F3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 13:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242369AbhIQMAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234705AbhIQMAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:00:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B59AF611C8;
        Fri, 17 Sep 2021 11:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631879921;
        bh=SETD1yvffx2s4O/bYFD6C3Ii+gVj8guIkKjh5yb7eyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bHyA6l5jKCy+r66Etq4yLv2ZhYlwr2OWLN4yxjoNxWMZOlH1q6ANODyU8RmN3fGB/
         trQ0HhVh+G5ZxWC9VGc2ZTGNvfFvtm98OOnHe7gqpTSAtyTgcaULLnGdLgZ19RugxG
         9zWcVHvSrlR3oiAsnrKECIPT9xcpcLGzivIsELlVEraQtJ+XnhPpoYFQesNNUUtR5E
         us1NmhfpS4H2+cq9g5SxIEgYvpPVTM1sCcWZuLAr2yEl9maEx0qHtwRlrSeuRo5DFP
         oq9tF696JpQMS8mmof/qA//0Y6FB6iKKlBSdtExCk7XGYoxny9vFfb2slBhii7rP2f
         xokY5j5OKkiTg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2ACD14038F; Fri, 17 Sep 2021 08:58:38 -0300 (-03)
Date:   Fri, 17 Sep 2021 08:58:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stephane Eranian <eranian@google.com>,
        Jin Yao <yao.jin@linux.intel.com>
Subject: Re: [PATCH v3 2/2] perf record: Add --synth option
Message-ID: <YUSC7pQON42d2kwi@kernel.org>
References: <20210811044658.1313391-1-namhyung@kernel.org>
 <20210811044658.1313391-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811044658.1313391-2-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 10, 2021 at 09:46:58PM -0700, Namhyung Kim escreveu:
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

I added this note to your patch, to clarify what is being synthesized as
threads started after the record session will also have entries in /proc.

- Arnaldo

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 50d7d9d5d70addf0..2d7df8703cf2077d 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -599,7 +599,9 @@ in config file is set to true.
 --synth=TYPE::
 Collect and synthesize given type of events (comma separated).  Note that
 this option controls the synthesis from the /proc filesystem which represent
-task status.  Kernel (and some other) events are recorded regardless of the
+task status for pre-existing threads.
+
+Kernel (and some other) events are recorded regardless of the
 choice in this option.  For example, --synth=no would have MMAP events for
 kernel and modules.
 
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-record.txt | 14 +++++++
>  tools/perf/builtin-record.c              | 48 +++++++++++++++++++-----
>  tools/perf/util/record.h                 |  1 +
>  tools/perf/util/synthetic-events.c       | 28 ++++++++++++++
>  tools/perf/util/synthetic-events.h       | 12 ++++++
>  5 files changed, 94 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index d71bac847936..ffa110488431 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -596,6 +596,20 @@ options.
>  'perf record --dry-run -e' can act as a BPF script compiler if llvm.dump-obj
>  in config file is set to true.
>  
> +--synth=TYPE::
> +Collect and synthesize given type of events (comma separated).  Note that
> +this option controls the synthesis from the /proc filesystem which represent
> +task status.  Kernel (and some other) events are recorded regardless of the
> +choice in this option.  For example, --synth=no would have MMAP events for
> +kernel and modules.
> +
> +Available types are:
> +  'task'    - synthesize FORK and COMM events for each task
> +  'mmap'    - synthesize MMAP events for each process (implies 'task')
> +  'cgroup'  - synthesize CGROUP events for each cgroup
> +  'all'     - synthesize all events (default)
> +  'no'      - do not synthesize any of the above events
> +
>  --tail-synthesize::
>  Instead of collecting non-sample events (for example, fork, comm, mmap) at
>  the beginning of record, collect them during finalizing an output file.
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 764e391e89f8..46ea7bd09fb1 100644
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
> @@ -1470,20 +1471,26 @@ static int record__synthesize(struct record *rec, bool tail)
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
> @@ -2392,6 +2399,26 @@ static int process_timestamp_boundary(struct perf_tool *tool,
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
> @@ -2417,6 +2444,7 @@ static struct record record = {
>  		.nr_threads_synthesize = 1,
>  		.ctl_fd              = -1,
>  		.ctl_fd_ack          = -1,
> +		.synth               = PERF_SYNTH_ALL,
>  	},
>  	.tool = {
>  		.sample		= process_sample_event,
> @@ -2632,6 +2660,8 @@ static struct option __record_options[] = {
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
> index a7a2825356d6..198982109f0f 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -2237,3 +2237,31 @@ int perf_event__synthesize_for_pipe(struct perf_tool *tool,
>  
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
> index 44f72d56ca4d..c931433bacbf 100644
> --- a/tools/perf/util/synthetic-events.h
> +++ b/tools/perf/util/synthetic-events.h
> @@ -27,6 +27,18 @@ struct target;
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
> 2.32.0.605.g8dce9f2422-goog
> 

-- 

- Arnaldo
