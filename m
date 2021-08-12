Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648073EA1B3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 11:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbhHLJQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 05:16:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40053 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235744AbhHLJQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 05:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628759735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CGioJ+dEwrV1f/PBRvztKsgphzAhBarq1Kl4Gvot0Zo=;
        b=KCBtFMX9hSd9I9GmjCeHp0lb+0YwdKn3bmBdrWjGPCvTc3zqyohw+MUZXRORvpH5pdssXM
        rIZBQkcgoxbhCFcXJ3B75Jpn9DE23AYJTbpYfaQWKKTMqysCGsRjb3qnp/nuBfGf/JcUn5
        pl4ZFY23vxm4VSKtDOTrUnW97bGwSV8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-QgaHYS7dMeet9YZi3Gkalg-1; Thu, 12 Aug 2021 05:15:34 -0400
X-MC-Unique: QgaHYS7dMeet9YZi3Gkalg-1
Received: by mail-ej1-f71.google.com with SMTP id ne21-20020a1709077b95b029057eb61c6fdfso1559684ejc.22
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 02:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CGioJ+dEwrV1f/PBRvztKsgphzAhBarq1Kl4Gvot0Zo=;
        b=L8iiTBVoXYB8W84WuWpsGXtSil+Yb/XfzK17pZKk7n8jG2+ico0lMRZsNq/V4qvx9m
         dDfbTZW8vY7xyXVjKLgvIDxEDCPW2l/SGihaGzogKggWP+qs3GFfU09KRQ4gqmGzfb72
         Gpu6H0z0Iy4UwJPrRjEV7usNyn2nnE+StkUJW7Q3L2S9sp0rhfGS0fBwRIliOP71mdVC
         ti84dkWzqT89dHwGudeSztJzNseHDiG07WX3OYXbgW51FQCDnwSs9tkQBONpgxOsxUJI
         8LmJQ7kgTxdLcoUC8sEtripXPLmji1ZHVPBA6p6nWj7iWq9c8gGRDwWh6o7ny5Z9L9pS
         3iEw==
X-Gm-Message-State: AOAM531Lavec/9HugPlDxAIVo7kxt/VhQYgopcdJXLc1mj3ZbjhLKGGY
        zX25b0AOScXvpLTVoVlbT+u6RU2iFvMkXOOtAmijm1EZtPh5dneDbMNV6c0VI9OvTRSCSSyTGql
        j1IW4JnKolE8at/d8mRPqDQKC
X-Received: by 2002:a17:906:504:: with SMTP id j4mr2614968eja.245.1628759732871;
        Thu, 12 Aug 2021 02:15:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyxXzu+koWivjqR+GtlL3tlrkm4ADaA3XQuEeoSuNb6/hGd9H9XE2ON7BIl4vftbxLTGspTA==
X-Received: by 2002:a17:906:504:: with SMTP id j4mr2614948eja.245.1628759732640;
        Thu, 12 Aug 2021 02:15:32 -0700 (PDT)
Received: from krava ([83.240.61.5])
        by smtp.gmail.com with ESMTPSA id b11sm567835eja.104.2021.08.12.02.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 02:15:32 -0700 (PDT)
Date:   Thu, 12 Aug 2021 11:15:30 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stephane Eranian <eranian@google.com>,
        Jin Yao <yao.jin@linux.intel.com>
Subject: Re: [PATCH v3 1/2] perf tools: Allow to control synthesize during
 record
Message-ID: <YRTmshairdxxiFo2@krava>
References: <20210811044658.1313391-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811044658.1313391-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 09:46:57PM -0700, Namhyung Kim wrote:
> Depending on the use case, it might require some kind of synthesize
> and some not.  Make it controllable to turn off heavy operations like
> MMAP for all tasks.
> 
> Currently all users are converted to enable all the synthesis by
> default.  It'll be updated in the later patch.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

for both patches

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/bench/synthesize.c         |  4 +--
>  tools/perf/builtin-kvm.c              |  2 +-
>  tools/perf/builtin-record.c           |  6 ++--
>  tools/perf/builtin-top.c              |  2 +-
>  tools/perf/builtin-trace.c            |  4 +--
>  tools/perf/tests/code-reading.c       |  3 +-
>  tools/perf/tests/mmap-thread-lookup.c |  4 +--
>  tools/perf/util/synthetic-events.c    | 45 ++++++++++++++++-----------
>  tools/perf/util/synthetic-events.h    |  8 ++---
>  9 files changed, 44 insertions(+), 34 deletions(-)
> 
> diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
> index 05f7c923c745..7401ebbac100 100644
> --- a/tools/perf/bench/synthesize.c
> +++ b/tools/perf/bench/synthesize.c
> @@ -80,7 +80,7 @@ static int do_run_single_threaded(struct perf_session *session,
>  						NULL,
>  						target, threads,
>  						process_synthesized_event,
> -						data_mmap,
> +						true, data_mmap,
>  						nr_threads_synthesize);
>  		if (err)
>  			return err;
> @@ -171,7 +171,7 @@ static int do_run_multi_threaded(struct target *target,
>  						NULL,
>  						target, NULL,
>  						process_synthesized_event,
> -						false,
> +						true, false,
>  						nr_threads_synthesize);
>  		if (err) {
>  			perf_session__delete(session);
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index aa1b127ffb5b..c6f352ee57e6 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -1456,7 +1456,7 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
>  	perf_session__set_id_hdr_size(kvm->session);
>  	ordered_events__set_copy_on_queue(&kvm->session->ordered_events, true);
>  	machine__synthesize_threads(&kvm->session->machines.host, &kvm->opts.target,
> -				    kvm->evlist->core.threads, false, 1);
> +				    kvm->evlist->core.threads, true, false, 1);
>  	err = kvm_live_open_events(kvm);
>  	if (err)
>  		goto out;
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 548c1dbde6c5..764e391e89f8 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1265,6 +1265,7 @@ static int record__synthesize_workload(struct record *rec, bool tail)
>  	err = perf_event__synthesize_thread_map(&rec->tool, thread_map,
>  						 process_synthesized_event,
>  						 &rec->session->machines.host,
> +						 true,
>  						 rec->opts.sample_address);
>  	perf_thread_map__put(thread_map);
>  	return err;
> @@ -1479,8 +1480,9 @@ static int record__synthesize(struct record *rec, bool tail)
>  		f = process_locked_synthesized_event;
>  	}
>  
> -	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->core.threads,
> -					    f, opts->sample_address,
> +	err = __machine__synthesize_threads(machine, tool, &opts->target,
> +					    rec->evlist->core.threads,
> +					    f, true, opts->sample_address,
>  					    rec->opts.nr_threads_synthesize);
>  
>  	if (rec->opts.nr_threads_synthesize > 1)
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index a3ae9176a83e..020c4f110c10 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1271,7 +1271,7 @@ static int __cmd_top(struct perf_top *top)
>  		pr_debug("Couldn't synthesize cgroup events.\n");
>  
>  	machine__synthesize_threads(&top->session->machines.host, &opts->target,
> -				    top->evlist->core.threads, false,
> +				    top->evlist->core.threads, true, false,
>  				    top->nr_threads_synthesize);
>  
>  	if (top->nr_threads_synthesize > 1)
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 2bf21194c7b3..2f1d20553a0a 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1628,8 +1628,8 @@ static int trace__symbols_init(struct trace *trace, struct evlist *evlist)
>  		goto out;
>  
>  	err = __machine__synthesize_threads(trace->host, &trace->tool, &trace->opts.target,
> -					    evlist->core.threads, trace__tool_process, false,
> -					    1);
> +					    evlist->core.threads, trace__tool_process,
> +					    true, false, 1);
>  out:
>  	if (err)
>  		symbol__exit();
> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
> index 9866cddebf23..3a4d932e7ffc 100644
> --- a/tools/perf/tests/code-reading.c
> +++ b/tools/perf/tests/code-reading.c
> @@ -606,7 +606,8 @@ static int do_test_code_reading(bool try_kcore)
>  	}
>  
>  	ret = perf_event__synthesize_thread_map(NULL, threads,
> -						perf_event__process, machine, false);
> +						perf_event__process, machine,
> +						true, false);
>  	if (ret < 0) {
>  		pr_debug("perf_event__synthesize_thread_map failed\n");
>  		goto out_err;
> diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
> index 8d9d4cbff76d..6f2da7a72f67 100644
> --- a/tools/perf/tests/mmap-thread-lookup.c
> +++ b/tools/perf/tests/mmap-thread-lookup.c
> @@ -135,7 +135,7 @@ static int synth_all(struct machine *machine)
>  {
>  	return perf_event__synthesize_threads(NULL,
>  					      perf_event__process,
> -					      machine, 0, 1);
> +					      machine, 1, 0, 1);
>  }
>  
>  static int synth_process(struct machine *machine)
> @@ -147,7 +147,7 @@ static int synth_process(struct machine *machine)
>  
>  	err = perf_event__synthesize_thread_map(NULL, map,
>  						perf_event__process,
> -						machine, 0);
> +						machine, 1, 0);
>  
>  	perf_thread_map__put(map);
>  	return err;
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index a7e981b2d7de..a7a2825356d6 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -715,7 +715,8 @@ static int __event__synthesize_thread(union perf_event *comm_event,
>  				      union perf_event *fork_event,
>  				      union perf_event *namespaces_event,
>  				      pid_t pid, int full, perf_event__handler_t process,
> -				      struct perf_tool *tool, struct machine *machine, bool mmap_data)
> +				      struct perf_tool *tool, struct machine *machine,
> +				      bool needs_mmap, bool mmap_data)
>  {
>  	char filename[PATH_MAX];
>  	struct dirent **dirent;
> @@ -739,7 +740,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
>  		 * send mmap only for thread group leader
>  		 * see thread__init_maps()
>  		 */
> -		if (pid == tgid &&
> +		if (pid == tgid && needs_mmap &&
>  		    perf_event__synthesize_mmap_events(tool, mmap_event, pid, tgid,
>  						       process, machine, mmap_data))
>  			return -1;
> @@ -786,7 +787,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
>  			break;
>  
>  		rc = 0;
> -		if (_pid == pid && !kernel_thread) {
> +		if (_pid == pid && !kernel_thread && needs_mmap) {
>  			/* process the parent's maps too */
>  			rc = perf_event__synthesize_mmap_events(tool, mmap_event, pid, tgid,
>  						process, machine, mmap_data);
> @@ -806,7 +807,7 @@ int perf_event__synthesize_thread_map(struct perf_tool *tool,
>  				      struct perf_thread_map *threads,
>  				      perf_event__handler_t process,
>  				      struct machine *machine,
> -				      bool mmap_data)
> +				      bool needs_mmap, bool mmap_data)
>  {
>  	union perf_event *comm_event, *mmap_event, *fork_event;
>  	union perf_event *namespaces_event;
> @@ -836,7 +837,7 @@ int perf_event__synthesize_thread_map(struct perf_tool *tool,
>  					       fork_event, namespaces_event,
>  					       perf_thread_map__pid(threads, thread), 0,
>  					       process, tool, machine,
> -					       mmap_data)) {
> +					       needs_mmap, mmap_data)) {
>  			err = -1;
>  			break;
>  		}
> @@ -862,7 +863,7 @@ int perf_event__synthesize_thread_map(struct perf_tool *tool,
>  						       fork_event, namespaces_event,
>  						       comm_event->comm.pid, 0,
>  						       process, tool, machine,
> -						       mmap_data)) {
> +						       needs_mmap, mmap_data)) {
>  				err = -1;
>  				break;
>  			}
> @@ -882,6 +883,7 @@ int perf_event__synthesize_thread_map(struct perf_tool *tool,
>  static int __perf_event__synthesize_threads(struct perf_tool *tool,
>  					    perf_event__handler_t process,
>  					    struct machine *machine,
> +					    bool needs_mmap,
>  					    bool mmap_data,
>  					    struct dirent **dirent,
>  					    int start,
> @@ -926,7 +928,7 @@ static int __perf_event__synthesize_threads(struct perf_tool *tool,
>  		 */
>  		__event__synthesize_thread(comm_event, mmap_event, fork_event,
>  					   namespaces_event, pid, 1, process,
> -					   tool, machine, mmap_data);
> +					   tool, machine, needs_mmap, mmap_data);
>  	}
>  	err = 0;
>  
> @@ -945,6 +947,7 @@ struct synthesize_threads_arg {
>  	struct perf_tool *tool;
>  	perf_event__handler_t process;
>  	struct machine *machine;
> +	bool needs_mmap;
>  	bool mmap_data;
>  	struct dirent **dirent;
>  	int num;
> @@ -956,7 +959,8 @@ static void *synthesize_threads_worker(void *arg)
>  	struct synthesize_threads_arg *args = arg;
>  
>  	__perf_event__synthesize_threads(args->tool, args->process,
> -					 args->machine, args->mmap_data,
> +					 args->machine,
> +					 args->needs_mmap, args->mmap_data,
>  					 args->dirent,
>  					 args->start, args->num);
>  	return NULL;
> @@ -965,7 +969,7 @@ static void *synthesize_threads_worker(void *arg)
>  int perf_event__synthesize_threads(struct perf_tool *tool,
>  				   perf_event__handler_t process,
>  				   struct machine *machine,
> -				   bool mmap_data,
> +				   bool needs_mmap, bool mmap_data,
>  				   unsigned int nr_threads_synthesize)
>  {
>  	struct synthesize_threads_arg *args = NULL;
> @@ -994,7 +998,8 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
>  
>  	if (thread_nr <= 1) {
>  		err = __perf_event__synthesize_threads(tool, process,
> -						       machine, mmap_data,
> +						       machine,
> +						       needs_mmap, mmap_data,
>  						       dirent, base, n);
>  		goto free_dirent;
>  	}
> @@ -1015,6 +1020,7 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
>  		args[i].tool = tool;
>  		args[i].process = process;
>  		args[i].machine = machine;
> +		args[i].needs_mmap = needs_mmap;
>  		args[i].mmap_data = mmap_data;
>  		args[i].dirent = dirent;
>  	}
> @@ -1775,26 +1781,27 @@ int perf_event__synthesize_id_index(struct perf_tool *tool, perf_event__handler_
>  
>  int __machine__synthesize_threads(struct machine *machine, struct perf_tool *tool,
>  				  struct target *target, struct perf_thread_map *threads,
> -				  perf_event__handler_t process, bool data_mmap,
> -				  unsigned int nr_threads_synthesize)
> +				  perf_event__handler_t process, bool needs_mmap,
> +				  bool data_mmap, unsigned int nr_threads_synthesize)
>  {
>  	if (target__has_task(target))
> -		return perf_event__synthesize_thread_map(tool, threads, process, machine, data_mmap);
> +		return perf_event__synthesize_thread_map(tool, threads, process, machine,
> +							 needs_mmap, data_mmap);
>  	else if (target__has_cpu(target))
> -		return perf_event__synthesize_threads(tool, process,
> -						      machine, data_mmap,
> +		return perf_event__synthesize_threads(tool, process, machine,
> +						      needs_mmap, data_mmap,
>  						      nr_threads_synthesize);
>  	/* command specified */
>  	return 0;
>  }
>  
>  int machine__synthesize_threads(struct machine *machine, struct target *target,
> -				struct perf_thread_map *threads, bool data_mmap,
> -				unsigned int nr_threads_synthesize)
> +				struct perf_thread_map *threads, bool needs_mmap,
> +				bool data_mmap, unsigned int nr_threads_synthesize)
>  {
>  	return __machine__synthesize_threads(machine, NULL, target, threads,
> -					     perf_event__process, data_mmap,
> -					     nr_threads_synthesize);
> +					     perf_event__process, needs_mmap,
> +					     data_mmap, nr_threads_synthesize);
>  }
>  
>  static struct perf_record_event_update *event_update_event__new(size_t size, u64 type, u64 id)
> diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
> index c845e2b9b444..44f72d56ca4d 100644
> --- a/tools/perf/util/synthetic-events.h
> +++ b/tools/perf/util/synthetic-events.h
> @@ -53,8 +53,8 @@ int perf_event__synthesize_stat_events(struct perf_stat_config *config, struct p
>  int perf_event__synthesize_stat_round(struct perf_tool *tool, u64 time, u64 type, perf_event__handler_t process, struct machine *machine);
>  int perf_event__synthesize_stat(struct perf_tool *tool, u32 cpu, u32 thread, u64 id, struct perf_counts_values *count, perf_event__handler_t process, struct machine *machine);
>  int perf_event__synthesize_thread_map2(struct perf_tool *tool, struct perf_thread_map *threads, perf_event__handler_t process, struct machine *machine);
> -int perf_event__synthesize_thread_map(struct perf_tool *tool, struct perf_thread_map *threads, perf_event__handler_t process, struct machine *machine, bool mmap_data);
> -int perf_event__synthesize_threads(struct perf_tool *tool, perf_event__handler_t process, struct machine *machine, bool mmap_data, unsigned int nr_threads_synthesize);
> +int perf_event__synthesize_thread_map(struct perf_tool *tool, struct perf_thread_map *threads, perf_event__handler_t process, struct machine *machine, bool needs_mmap, bool mmap_data);
> +int perf_event__synthesize_threads(struct perf_tool *tool, perf_event__handler_t process, struct machine *machine, bool needs_mmap, bool mmap_data, unsigned int nr_threads_synthesize);
>  int perf_event__synthesize_tracing_data(struct perf_tool *tool, int fd, struct evlist *evlist, perf_event__handler_t process);
>  int perf_event__synth_time_conv(const struct perf_event_mmap_page *pc, struct perf_tool *tool, perf_event__handler_t process, struct machine *machine);
>  pid_t perf_event__synthesize_comm(struct perf_tool *tool, union perf_event *event, pid_t pid, perf_event__handler_t process, struct machine *machine);
> @@ -65,10 +65,10 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
>  
>  int __machine__synthesize_threads(struct machine *machine, struct perf_tool *tool,
>  				  struct target *target, struct perf_thread_map *threads,
> -				  perf_event__handler_t process, bool data_mmap,
> +				  perf_event__handler_t process, bool needs_mmap, bool data_mmap,
>  				  unsigned int nr_threads_synthesize);
>  int machine__synthesize_threads(struct machine *machine, struct target *target,
> -				struct perf_thread_map *threads, bool data_mmap,
> +				struct perf_thread_map *threads, bool needs_mmap, bool data_mmap,
>  				unsigned int nr_threads_synthesize);
>  
>  #ifdef HAVE_AUXTRACE_SUPPORT
> -- 
> 2.32.0.605.g8dce9f2422-goog
> 

