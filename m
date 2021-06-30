Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38E53B8786
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 19:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhF3RTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 13:19:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhF3RTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 13:19:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2863761483;
        Wed, 30 Jun 2021 17:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625073423;
        bh=kB06cxHRy06W3xa1X7niiGkQoDZFD/GjQXzFM2J8lx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BsiPCnK/EvV39QRtbfx/xBj9XUV2m0WO7VH6keEg1IDfZrzApFOOKjIy/M7x87QAh
         arMV7OdE/Lt3SepQRy18A9pdPfIUqTwMYhVeVWTJ25GxrXz7bPyrCb91WD/HXQH8ve
         pqaAz/RIREVhFH7oxqygOSR4CxFa81Z0LdHHt8s0aJj6Rldn1DZSOd88hHL/7zJa6p
         TIwPexsay77MZmwKohKUTy4tfD87etTdD228ZeNw6UJU6S0ubAKELA1NAttHp3fBPW
         qGFCfXfbM2hAO8oHKDJVNe/Op8DqW10GPODiBCRL1h3xYXqq6YGKrfDWqcpAhAUNjU
         F/HPzI12o0qIA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 758AF40B1A; Wed, 30 Jun 2021 14:16:57 -0300 (-03)
Date:   Wed, 30 Jun 2021 14:16:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH v8 03/22] perf record: Introduce thread local variable
Message-ID: <YNynCbUE/yjkUxcN@kernel.org>
References: <cover.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <15e08085a9040209bf13b26239b81b4b52b02d6d.1625065643.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15e08085a9040209bf13b26239b81b4b52b02d6d.1625065643.git.alexey.v.bayduraev@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 30, 2021 at 06:54:42PM +0300, Alexey Bayduraev escreveu:
> Introduce thread local variable and use it for threaded trace streaming.
> Use thread affinity mask instead or record affinity mask in affinity
> modes.
> Introduce and use evlist__ctlfd_update() function to propagate external
> control commands to global evlist object.
> 
> Acked-by: Andi Kleen <ak@linux.intel.com>
> Acked-by: Namhyung Kim <namhyung@gmail.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 135 ++++++++++++++++++++++++------------
>  tools/perf/util/evlist.c    |  16 +++++
>  tools/perf/util/evlist.h    |   1 +
>  3 files changed, 107 insertions(+), 45 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 11ce64b23db4..3935c0fabe01 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -110,6 +110,8 @@ struct thread_data {
>  	unsigned long		waking;
>  };
>  
> +static __thread struct thread_data *thread;
> +
>  struct record {
>  	struct perf_tool	tool;
>  	struct record_opts	opts;
> @@ -132,7 +134,6 @@ struct record {
>  	bool			timestamp_boundary;
>  	struct switch_output	switch_output;
>  	unsigned long long	samples;
> -	struct mmap_cpu_mask	affinity_mask;
>  	unsigned long		output_max_size;	/* = 0: unlimited */
>  	struct thread_mask	*thread_masks;
>  	struct thread_data	*thread_data;
> @@ -567,7 +568,7 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
>  		bf   = map->data;
>  	}
>  
> -	rec->samples++;
> +	thread->samples++;
>  	return record__write(rec, map, bf, size);
>  }
>  
> @@ -1260,16 +1261,24 @@ static struct perf_event_header finished_round_event = {
>  
>  static void record__adjust_affinity(struct record *rec, struct mmap *map)
>  {
> +	int ret = 0;

Why you set this to zero here if it is going to be used only insde the
if block?

> +
>  	if (rec->opts.affinity != PERF_AFFINITY_SYS &&
> -	    !bitmap_equal(rec->affinity_mask.bits, map->affinity_mask.bits,
> -			  rec->affinity_mask.nbits)) {
> -		bitmap_zero(rec->affinity_mask.bits, rec->affinity_mask.nbits);
> -		bitmap_or(rec->affinity_mask.bits, rec->affinity_mask.bits,
> -			  map->affinity_mask.bits, rec->affinity_mask.nbits);
> -		sched_setaffinity(0, MMAP_CPU_MASK_BYTES(&rec->affinity_mask),
> -				  (cpu_set_t *)rec->affinity_mask.bits);
> -		if (verbose == 2)
> -			mmap_cpu_mask__scnprintf(&rec->affinity_mask, "thread");
> +	    !bitmap_equal(thread->mask->affinity.bits, map->affinity_mask.bits,
> +			  thread->mask->affinity.nbits)) {
> +		bitmap_zero(thread->mask->affinity.bits, thread->mask->affinity.nbits);
> +		bitmap_or(thread->mask->affinity.bits, thread->mask->affinity.bits,
> +			  map->affinity_mask.bits, thread->mask->affinity.nbits);
> +		ret = sched_setaffinity(0, MMAP_CPU_MASK_BYTES(&thread->mask->affinity),
> +					(cpu_set_t *)thread->mask->affinity.bits);
> +		if (ret)
> +			pr_err("threads[%d]: sched_setaffinity() call failed: %s\n",
> +			       thread->tid, strerror(errno));

Also, if record__adjust_affinity() fails by means of sched_setaffinity
not working, shouldn't we propagate this error?

> +		if (verbose == 2) {
> +			pr_debug("threads[%d]: addr=", thread->tid);
> +			mmap_cpu_mask__scnprintf(&thread->mask->affinity, "thread");
> +			pr_debug("threads[%d]: on cpu=%d\n", thread->tid, sched_getcpu());
> +		}
>  	}
>  }
>  
> @@ -1310,14 +1319,17 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
>  	u64 bytes_written = rec->bytes_written;
>  	int i;
>  	int rc = 0;
> -	struct mmap *maps;
> +	int nr_mmaps;
> +	struct mmap **maps;
>  	int trace_fd = rec->data.file.fd;
>  	off_t off = 0;
>  
>  	if (!evlist)
>  		return 0;
>  
> -	maps = overwrite ? evlist->overwrite_mmap : evlist->mmap;
> +	nr_mmaps = thread->nr_mmaps;
> +	maps = overwrite ? thread->overwrite_maps : thread->maps;
> +
>  	if (!maps)
>  		return 0;
>  
> @@ -1327,9 +1339,9 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
>  	if (record__aio_enabled(rec))
>  		off = record__aio_get_pos(trace_fd);
>  
> -	for (i = 0; i < evlist->core.nr_mmaps; i++) {
> +	for (i = 0; i < nr_mmaps; i++) {
>  		u64 flush = 0;
> -		struct mmap *map = &maps[i];
> +		struct mmap *map = maps[i];
>  
>  		if (map->core.base) {
>  			record__adjust_affinity(rec, map);
> @@ -1392,6 +1404,15 @@ static int record__mmap_read_all(struct record *rec, bool synch)
>  	return record__mmap_read_evlist(rec, rec->evlist, true, synch);
>  }
>  
> +static void record__thread_munmap_filtered(struct fdarray *fda, int fd,
> +					   void *arg __maybe_unused)
> +{
> +	struct perf_mmap *map = fda->priv[fd].ptr;
> +
> +	if (map)
> +		perf_mmap__put(map);
> +}
> +
>  static void record__init_features(struct record *rec)
>  {
>  	struct perf_session *session = rec->session;
> @@ -1836,6 +1857,33 @@ static void record__uniquify_name(struct record *rec)
>  	}
>  }
>  
> +static int record__start_threads(struct record *rec)
> +{
> +	struct thread_data *thread_data = rec->thread_data;
> +
> +	thread = &thread_data[0];
> +
> +	pr_debug("threads[%d]: started on cpu=%d\n", thread->tid, sched_getcpu());
> +
> +	return 0;
> +}
> +
> +static int record__stop_threads(struct record *rec, unsigned long *waking)
> +{
> +	int t;
> +	struct thread_data *thread_data = rec->thread_data;
> +
> +	for (t = 0; t < rec->nr_threads; t++) {
> +		rec->samples += thread_data[t].samples;
> +		*waking += thread_data[t].waking;
> +		pr_debug("threads[%d]: samples=%lld, wakes=%ld, trasferred=%ld, compressed=%ld\n",
> +			 thread_data[t].tid, thread_data[t].samples, thread_data[t].waking,
> +			 rec->session->bytes_transferred, rec->session->bytes_compressed);
> +	}
> +
> +	return 0;
> +}
> +
>  static int __cmd_record(struct record *rec, int argc, const char **argv)
>  {
>  	int err;
> @@ -1944,7 +1992,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  
>  	if (record__open(rec) != 0) {
>  		err = -1;
> -		goto out_child;
> +		goto out_free_threads;
>  	}
>  	session->header.env.comp_mmap_len = session->evlist->core.mmap_len;
>  
> @@ -1952,7 +2000,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		err = record__kcore_copy(&session->machines.host, data);
>  		if (err) {
>  			pr_err("ERROR: Failed to copy kcore\n");
> -			goto out_child;
> +			goto out_free_threads;
>  		}
>  	}
>  
> @@ -1963,7 +2011,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		bpf__strerror_apply_obj_config(err, errbuf, sizeof(errbuf));
>  		pr_err("ERROR: Apply config to BPF failed: %s\n",
>  			 errbuf);
> -		goto out_child;
> +		goto out_free_threads;
>  	}
>  
>  	/*
> @@ -1981,11 +2029,11 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  	if (data->is_pipe) {
>  		err = perf_header__write_pipe(fd);
>  		if (err < 0)
> -			goto out_child;
> +			goto out_free_threads;
>  	} else {
>  		err = perf_session__write_header(session, rec->evlist, fd, false);
>  		if (err < 0)
> -			goto out_child;
> +			goto out_free_threads;
>  	}
>  
>  	err = -1;
> @@ -1993,16 +2041,16 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  	    && !perf_header__has_feat(&session->header, HEADER_BUILD_ID)) {
>  		pr_err("Couldn't generate buildids. "
>  		       "Use --no-buildid to profile anyway.\n");
> -		goto out_child;
> +		goto out_free_threads;
>  	}
>  
>  	err = record__setup_sb_evlist(rec);
>  	if (err)
> -		goto out_child;
> +		goto out_free_threads;
>  
>  	err = record__synthesize(rec, false);
>  	if (err < 0)
> -		goto out_child;
> +		goto out_free_threads;
>  
>  	if (rec->realtime_prio) {
>  		struct sched_param param;
> @@ -2011,10 +2059,13 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		if (sched_setscheduler(0, SCHED_FIFO, &param)) {
>  			pr_err("Could not set realtime priority.\n");
>  			err = -1;
> -			goto out_child;
> +			goto out_free_threads;
>  		}
>  	}
>  
> +	if (record__start_threads(rec))
> +		goto out_free_threads;
> +
>  	/*
>  	 * When perf is starting the traced process, all the events
>  	 * (apart from group members) have enable_on_exec=1 set,
> @@ -2085,7 +2136,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  	trigger_ready(&switch_output_trigger);
>  	perf_hooks__invoke_record_start();
>  	for (;;) {
> -		unsigned long long hits = rec->samples;
> +		unsigned long long hits = thread->samples;
>  
>  		/*
>  		 * rec->evlist->bkw_mmap_state is possible to be
> @@ -2154,20 +2205,24 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  				alarm(rec->switch_output.time);
>  		}
>  
> -		if (hits == rec->samples) {
> +		if (hits == thread->samples) {
>  			if (done || draining)
>  				break;
> -			err = evlist__poll(rec->evlist, -1);
> +			err = fdarray__poll(&thread->pollfd, -1);
>  			/*
>  			 * Propagate error, only if there's any. Ignore positive
>  			 * number of returned events and interrupt error.
>  			 */
>  			if (err > 0 || (err < 0 && errno == EINTR))
>  				err = 0;
> -			waking++;
> +			thread->waking++;
>  
> -			if (evlist__filter_pollfd(rec->evlist, POLLERR | POLLHUP) == 0)
> +			if (fdarray__filter(&thread->pollfd, POLLERR | POLLHUP,
> +					    record__thread_munmap_filtered, NULL) == 0)
>  				draining = true;
> +
> +			evlist__ctlfd_update(rec->evlist,
> +				&thread->pollfd.entries[thread->ctlfd_pos]);
>  		}
>  
>  		if (evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
> @@ -2220,18 +2275,20 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		goto out_child;
>  	}
>  
> -	if (!quiet)
> -		fprintf(stderr, "[ perf record: Woken up %ld times to write data ]\n", waking);
> -
>  	if (target__none(&rec->opts.target))
>  		record__synthesize_workload(rec, true);
>  
>  out_child:
> -	evlist__finalize_ctlfd(rec->evlist);
> +	record__stop_threads(rec, &waking);
>  	record__mmap_read_all(rec, true);
> +out_free_threads:
>  	record__free_thread_data(rec);
> +	evlist__finalize_ctlfd(rec->evlist);
>  	record__aio_mmap_read_sync(rec);
>  
> +	if (!quiet)
> +		fprintf(stderr, "[ perf record: Woken up %ld times to write data ]\n", waking);
> +
>  	if (rec->session->bytes_transferred && rec->session->bytes_compressed) {
>  		ratio = (float)rec->session->bytes_transferred/(float)rec->session->bytes_compressed;
>  		session->header.env.comp_ratio = ratio + 0.5;
> @@ -3093,17 +3150,6 @@ int cmd_record(int argc, const char **argv)
>  
>  	symbol__init(NULL);
>  
> -	if (rec->opts.affinity != PERF_AFFINITY_SYS) {
> -		rec->affinity_mask.nbits = cpu__max_cpu();
> -		rec->affinity_mask.bits = bitmap_alloc(rec->affinity_mask.nbits);
> -		if (!rec->affinity_mask.bits) {
> -			pr_err("Failed to allocate thread mask for %zd cpus\n", rec->affinity_mask.nbits);
> -			err = -ENOMEM;
> -			goto out_opts;
> -		}
> -		pr_debug2("thread mask[%zd]: empty\n", rec->affinity_mask.nbits);
> -	}
> -
>  	err = record__auxtrace_init(rec);
>  	if (err)
>  		goto out;
> @@ -3241,7 +3287,6 @@ int cmd_record(int argc, const char **argv)
>  
>  	err = __cmd_record(&record, argc, argv);
>  out:
> -	bitmap_free(rec->affinity_mask.bits);
>  	evlist__delete(rec->evlist);
>  	symbol__exit();
>  	auxtrace_record__free(rec->itr);


Can the following be moved to a separate patch?

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 6ba9664089bd..3d555a98c037 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -2132,6 +2132,22 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
>  	return err;
>  }
>  
> +int evlist__ctlfd_update(struct evlist *evlist, struct pollfd *update)
> +{
> +	int ctlfd_pos = evlist->ctl_fd.pos;
> +	struct pollfd *entries = evlist->core.pollfd.entries;
> +
> +	if (!evlist__ctlfd_initialized(evlist))
> +		return 0;
> +
> +	if (entries[ctlfd_pos].fd != update->fd ||
> +	    entries[ctlfd_pos].events != update->events)
> +		return -1;
> +
> +	entries[ctlfd_pos].revents = update->revents;
> +	return 0;
> +}
> +
>  struct evsel *evlist__find_evsel(struct evlist *evlist, int idx)
>  {
>  	struct evsel *evsel;
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 2073cfa79f79..b7aa719c638d 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -358,6 +358,7 @@ void evlist__close_control(int ctl_fd, int ctl_fd_ack, bool *ctl_fd_close);
>  int evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack);
>  int evlist__finalize_ctlfd(struct evlist *evlist);
>  bool evlist__ctlfd_initialized(struct evlist *evlist);
> +int evlist__ctlfd_update(struct evlist *evlist, struct pollfd *update);
>  int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd);
>  int evlist__ctlfd_ack(struct evlist *evlist);
>  
> -- 
> 2.19.0
> 

-- 

- Arnaldo
