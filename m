Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A354440819C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 22:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbhILUqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 16:46:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38136 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236347AbhILUq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 16:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631479509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jUMZAOL9vpqvSDLN12Jx/811Pq8KAvJKJiMzednfbIU=;
        b=ZZOEvy+UEa6AOIPcnsNh2YHSnp5Cquf4mllsLLRZyzdOLnJNTOic1BG5l3DIg65L3k4jSr
        fcBuH+hxscn1fMz0gBFMQzf/vw7YpKG5wQfC5RJPz/DBKIV6vBuKHkn+qe2c/2IBWmW8EA
        bl1Eu567bYNH4/t1+gWs68UtkJbYUto=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-tt82dgjCPHmEeX66UXEsAg-1; Sun, 12 Sep 2021 16:45:08 -0400
X-MC-Unique: tt82dgjCPHmEeX66UXEsAg-1
Received: by mail-ed1-f69.google.com with SMTP id w24-20020a056402071800b003cfc05329f8so3864592edx.19
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 13:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jUMZAOL9vpqvSDLN12Jx/811Pq8KAvJKJiMzednfbIU=;
        b=hWTp8iFI9q8rrH4u02X5Sd/b5nGck7om3GJRO9VSpYYde3RMi7HkBBtTKLRAlYI0rE
         bX9Un3p81lidOGqRshhoBbw3m8mdGvwOtYAuUps5ucZQeHfxfQaNq16WxXf/oNpeHDVq
         YzuvS4jg5m/kvMI67jb8T203cERX38ZVRElyH7Q1YebAL6XEQ0s4JF9Mw0mf/OVEaFpO
         XA+47OlCAQX6ADvgsVL0s9UlkR6QcwkJYm0Rk0zUCrhBDSaMGXWr9QsLyRCKGrXOtv9X
         WfUoKoJswVyPV860KbYDoklkKdEQqqp6j9Z/RYUUjA0B6GWdtEb8ei8R60D/vs4QrSj1
         pCCw==
X-Gm-Message-State: AOAM531qd5jIJiLy7pSAcasyeAAp8VKSIhn7Zfc8MpGO2wR2ffX1wSFV
        XUFroDeyYHYq+N/AABHg835IMgWdm2QdYoBaKqGRp2CiEhBirz5fXK5ZKeCXMyTtbvVZmeNCSf2
        eWf9nBEHjwvq6sJlCzJWyLjMm
X-Received: by 2002:a50:c90b:: with SMTP id o11mr9596869edh.216.1631479506763;
        Sun, 12 Sep 2021 13:45:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5ezqEFxjZVH4EmYlFVsemkYl+cpEnKSOAwoC+nJlHTZkd63K/1QLLgpG3k6uoJsmwt+Y0Qg==
X-Received: by 2002:a50:c90b:: with SMTP id o11mr9596844edh.216.1631479506503;
        Sun, 12 Sep 2021 13:45:06 -0700 (PDT)
Received: from krava ([83.240.60.52])
        by smtp.gmail.com with ESMTPSA id k12sm2805892edo.9.2021.09.12.13.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:45:06 -0700 (PDT)
Date:   Sun, 12 Sep 2021 22:45:04 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH v10 05/24] perf record: Introduce thread local variable
Message-ID: <YT5m0Av1r0tXvO9C@krava>
References: <cover.1626072008.git.alexey.v.bayduraev@linux.intel.com>
 <afa31d66f692558e0c9c06ea2f83a62ac394097f.1626072009.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afa31d66f692558e0c9c06ea2f83a62ac394097f.1626072009.git.alexey.v.bayduraev@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 09:46:05AM +0300, Alexey Bayduraev wrote:
> Introduce thread local variable and use it for threaded trace streaming.
> Use thread affinity mask instead or record affinity mask in affinity
> modes.
> 
> Acked-by: Andi Kleen <ak@linux.intel.com>
> Acked-by: Namhyung Kim <namhyung@gmail.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 139 ++++++++++++++++++++++++------------
>  1 file changed, 93 insertions(+), 46 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index a25b23affc43..dfc5db24e037 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -110,6 +110,8 @@ struct record_thread {
>  	unsigned long		waking;
>  };
>  
> +static __thread struct record_thread *thread;
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
>  	int			nr_threads;
>  	struct thread_mask	*thread_masks;
> @@ -574,7 +575,7 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
>  		bf   = map->data;
>  	}
>  
> -	rec->samples++;
> +	thread->samples++;
>  	return record__write(rec, map, bf, size);
>  }
>  
> @@ -1317,19 +1318,29 @@ static struct perf_event_header finished_round_event = {
>  	.type = PERF_RECORD_FINISHED_ROUND,
>  };
>  
> -static void record__adjust_affinity(struct record *rec, struct mmap *map)
> +static int record__adjust_affinity(struct record *rec, struct mmap *map)
>  {
> +	int ret = 0;
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
> +		if (verbose == 2) {
> +			pr_debug("threads[%d]: addr=", thread->tid);
> +			mmap_cpu_mask__scnprintf(&thread->mask->affinity, "thread");
> +			pr_debug("threads[%d]: on cpu=%d\n", thread->tid, sched_getcpu());
> +		}
>  	}
> +
> +	return ret;
>  }
>  
>  static size_t process_comp_header(void *record, size_t increment)
> @@ -1369,14 +1380,17 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
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
> @@ -1386,9 +1400,9 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
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
> @@ -1451,6 +1465,15 @@ static int record__mmap_read_all(struct record *rec, bool synch)
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
> @@ -1895,6 +1918,33 @@ static void record__uniquify_name(struct record *rec)
>  	}
>  }
>  
> +static int record__start_threads(struct record *rec)
> +{
> +	struct record_thread *thread_data = rec->thread_data;
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
> +	struct record_thread *thread_data = rec->thread_data;
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
> @@ -2003,7 +2053,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  
>  	if (record__open(rec) != 0) {
>  		err = -1;
> -		goto out_child;
> +		goto out_free_threads;
>  	}
>  	session->header.env.comp_mmap_len = session->evlist->core.mmap_len;
>  
> @@ -2011,7 +2061,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		err = record__kcore_copy(&session->machines.host, data);
>  		if (err) {
>  			pr_err("ERROR: Failed to copy kcore\n");
> -			goto out_child;
> +			goto out_free_threads;
>  		}
>  	}
>  
> @@ -2022,7 +2072,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		bpf__strerror_apply_obj_config(err, errbuf, sizeof(errbuf));
>  		pr_err("ERROR: Apply config to BPF failed: %s\n",
>  			 errbuf);
> -		goto out_child;
> +		goto out_free_threads;
>  	}
>  
>  	/*
> @@ -2040,11 +2090,11 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
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
> @@ -2052,16 +2102,16 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
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
> @@ -2070,10 +2120,13 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
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
> @@ -2144,7 +2197,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  	trigger_ready(&switch_output_trigger);
>  	perf_hooks__invoke_record_start();
>  	for (;;) {
> -		unsigned long long hits = rec->samples;
> +		unsigned long long hits = thread->samples;
>  
>  		/*
>  		 * rec->evlist->bkw_mmap_state is possible to be
> @@ -2213,20 +2266,24 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
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
> @@ -2279,18 +2336,20 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
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

we now display this even when there's error, which we did not do before

jirka

> +
>  	if (rec->session->bytes_transferred && rec->session->bytes_compressed) {
>  		ratio = (float)rec->session->bytes_transferred/(float)rec->session->bytes_compressed;
>  		session->header.env.comp_ratio = ratio + 0.5;
> @@ -3160,17 +3219,6 @@ int cmd_record(int argc, const char **argv)
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
> @@ -3308,7 +3356,6 @@ int cmd_record(int argc, const char **argv)
>  
>  	err = __cmd_record(&record, argc, argv);
>  out:
> -	bitmap_free(rec->affinity_mask.bits);
>  	evlist__delete(rec->evlist);
>  	symbol__exit();
>  	auxtrace_record__free(rec->itr);
> -- 
> 2.19.0
> 

