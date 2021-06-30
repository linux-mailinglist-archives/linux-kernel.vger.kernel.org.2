Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0A53B8792
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 19:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhF3RVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 13:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhF3RVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 13:21:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5BAA61490;
        Wed, 30 Jun 2021 17:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625073520;
        bh=ohBF5doleQ88UekCrryE/LgkJIOu0E7nVTeOcvrcJJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZFJXcFAQEgF47F4PS4whtBRe6vbk/1YJnUQ6VGEbQDEpD0q1vnOMiuKyKZ3O3CtDm
         tjShohuMFh62Yqb2FINWLcEQStnTrvwD/qpDvJUWJbT9yFQmC8gacE2vTw2UF6jeJ7
         nRpMlMPNwHpZBULMaPxEGxUgdqcUMlVMJcKssEobEHNmjH13cjlwnjAd3idjPtpnlg
         Mj0dypMFGdRoq8E6LrsYiVYRYkNG2k4pGFmr3KiK5ddYcVfVQRdTL3GOxODcXcDfVP
         ICQNLs1YqPPl82sMgjC7tlESt8R4obqQrajyIRUhZL/IwU3Dn4admuK5n6/AUlyLqT
         WLDSIBZcb3L4Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3CB1C40B1A; Wed, 30 Jun 2021 14:18:37 -0300 (-03)
Date:   Wed, 30 Jun 2021 14:18:37 -0300
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
Subject: Re: [PATCH v8 02/22] perf record: Introduce thread specific data
 array
Message-ID: <YNynbdAMeq5xHUFF@kernel.org>
References: <cover.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <54085f942fb8deedc617732b4716cb85a5c6ebfb.1625065643.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54085f942fb8deedc617732b4716cb85a5c6ebfb.1625065643.git.alexey.v.bayduraev@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 30, 2021 at 06:54:41PM +0300, Alexey Bayduraev escreveu:
> Introduce thread specific data object and array of such objects
> to store and manage thread local data. Implement functions to
> allocate, initialize, finalize and release thread specific data.
> 
> Thread local maps and overwrite_maps arrays keep pointers to
> mmap buffer objects to serve according to maps thread mask.
> Thread local pollfd array keeps event fds connected to mmaps
> buffers according to maps thread mask.
> 
> Thread control commands are delivered via thread local comm pipes
> and ctlfd_pos fd. External control commands (--control option)
> are delivered via evlist ctlfd_pos fd and handled by the main
> tool thread.
> 
> Acked-by: Namhyung Kim <namhyung@gmail.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/lib/api/fd/array.c    |  17 ++++
>  tools/lib/api/fd/array.h    |   1 +
>  tools/perf/builtin-record.c | 196 +++++++++++++++++++++++++++++++++++-
>  3 files changed, 211 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
> index 5e6cb9debe37..de8bcbaea3f1 100644
> --- a/tools/lib/api/fd/array.c
> +++ b/tools/lib/api/fd/array.c
> @@ -88,6 +88,23 @@ int fdarray__add(struct fdarray *fda, int fd, short revents, enum fdarray_flags
>  	return pos;
>  }
>  
> +int fdarray__clone(struct fdarray *fda, int pos, struct fdarray *base)
> +{
> +	struct pollfd *entry;
> +	int npos;
> +
> +	if (pos >= base->nr)
> +		return -EINVAL;
> +
> +	entry = &base->entries[pos];
> +
> +	npos = fdarray__add(fda, entry->fd, entry->events, base->priv[pos].flags);
> +	if (npos >= 0)
> +		fda->priv[npos] = base->priv[pos];
> +
> +	return npos;
> +}
> +
>  int fdarray__filter(struct fdarray *fda, short revents,
>  		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
>  		    void *arg)
> diff --git a/tools/lib/api/fd/array.h b/tools/lib/api/fd/array.h
> index 7fcf21a33c0c..4a03da7f1fc1 100644
> --- a/tools/lib/api/fd/array.h
> +++ b/tools/lib/api/fd/array.h
> @@ -42,6 +42,7 @@ struct fdarray *fdarray__new(int nr_alloc, int nr_autogrow);
>  void fdarray__delete(struct fdarray *fda);
>  
>  int fdarray__add(struct fdarray *fda, int fd, short revents, enum fdarray_flags flags);
> +int fdarray__clone(struct fdarray *fda, int pos, struct fdarray *base);
>  int fdarray__poll(struct fdarray *fda, int timeout);
>  int fdarray__filter(struct fdarray *fda, short revents,
>  		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 31b3a515abc1..11ce64b23db4 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -58,6 +58,7 @@
>  #include <poll.h>
>  #include <pthread.h>
>  #include <unistd.h>
> +#include <sys/syscall.h>
>  #include <sched.h>
>  #include <signal.h>
>  #ifdef HAVE_EVENTFD_SUPPORT
> @@ -92,6 +93,23 @@ struct thread_mask {
>  	struct mmap_cpu_mask	affinity;
>  };
>  
> +struct thread_data {

Please rename this to 'struct record_thread', 'data' is way too generic.

> +	pid_t			tid;
> +	struct thread_mask	*mask;
> +	struct {
> +		int		msg[2];
> +		int		ack[2];
> +	} pipes;
> +	struct fdarray		pollfd;
> +	int			ctlfd_pos;
> +	struct mmap		**maps;
> +	struct mmap		**overwrite_maps;
> +	int			nr_mmaps;
> +	struct record		*rec;
> +	unsigned long long	samples;
> +	unsigned long		waking;
> +};
> +
>  struct record {
>  	struct perf_tool	tool;
>  	struct record_opts	opts;
> @@ -117,6 +135,7 @@ struct record {
>  	struct mmap_cpu_mask	affinity_mask;
>  	unsigned long		output_max_size;	/* = 0: unlimited */
>  	struct thread_mask	*thread_masks;
> +	struct thread_data	*thread_data;
>  	int			nr_threads;
>  };
>  
> @@ -847,9 +866,174 @@ static int record__kcore_copy(struct machine *machine, struct perf_data *data)
>  	return kcore_copy(from_dir, kcore_dir);
>  }
>  
> +static int record__thread_data_init_pipes(struct thread_data *thread_data)
> +{
> +	if (pipe(thread_data->pipes.msg) || pipe(thread_data->pipes.ack)) {
> +		pr_err("Failed to create thread communication pipes: %s\n", strerror(errno));
> +		return -ENOMEM;
> +	}
> +
> +	pr_debug2("thread_data[%p]: msg=[%d,%d], ack=[%d,%d]\n", thread_data,
> +		 thread_data->pipes.msg[0], thread_data->pipes.msg[1],
> +		 thread_data->pipes.ack[0], thread_data->pipes.ack[1]);
> +
> +	return 0;
> +}
> +
> +static int record__thread_data_init_maps(struct thread_data *thread_data, struct evlist *evlist)
> +{
> +	int m, tm, nr_mmaps = evlist->core.nr_mmaps;
> +	struct mmap *mmap = evlist->mmap;
> +	struct mmap *overwrite_mmap = evlist->overwrite_mmap;
> +	struct perf_cpu_map *cpus = evlist->core.cpus;
> +
> +	thread_data->nr_mmaps = bitmap_weight(thread_data->mask->maps.bits,
> +					      thread_data->mask->maps.nbits);
> +	if (mmap) {
> +		thread_data->maps = zalloc(thread_data->nr_mmaps * sizeof(struct mmap *));
> +		if (!thread_data->maps) {
> +			pr_err("Failed to allocate maps thread data\n");
> +			return -ENOMEM;
> +		}
> +	}
> +	if (overwrite_mmap) {
> +		thread_data->overwrite_maps = zalloc(thread_data->nr_mmaps * sizeof(struct mmap *));
> +		if (!thread_data->overwrite_maps) {
> +			pr_err("Failed to allocate overwrite maps thread data\n");
> +			return -ENOMEM;
> +		}
> +	}
> +	pr_debug2("thread_data[%p]: nr_mmaps=%d, maps=%p, ow_maps=%p\n", thread_data,
> +		 thread_data->nr_mmaps, thread_data->maps, thread_data->overwrite_maps);
> +
> +	for (m = 0, tm = 0; m < nr_mmaps && tm < thread_data->nr_mmaps; m++) {
> +		if (test_bit(cpus->map[m], thread_data->mask->maps.bits)) {
> +			if (thread_data->maps) {
> +				thread_data->maps[tm] = &mmap[m];
> +				pr_debug2("thread_data[%p]: maps[%d] -> mmap[%d], cpus[%d]\n",
> +					  thread_data, tm, m, cpus->map[m]);
> +			}
> +			if (thread_data->overwrite_maps) {
> +				thread_data->overwrite_maps[tm] = &overwrite_mmap[m];
> +				pr_debug2("thread_data[%p]: ow_maps[%d] -> ow_mmap[%d], cpus[%d]\n",
> +					  thread_data, tm, m, cpus->map[m]);
> +			}
> +			tm++;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int record__thread_data_init_pollfd(struct thread_data *thread_data, struct evlist *evlist)
> +{
> +	int f, tm, pos;
> +	struct mmap *map, *overwrite_map;
> +
> +	fdarray__init(&thread_data->pollfd, 64);
> +
> +	for (tm = 0; tm < thread_data->nr_mmaps; tm++) {
> +		map = thread_data->maps ? thread_data->maps[tm] : NULL;
> +		overwrite_map = thread_data->overwrite_maps ?
> +				thread_data->overwrite_maps[tm] : NULL;
> +
> +		for (f = 0; f < evlist->core.pollfd.nr; f++) {
> +			void *ptr = evlist->core.pollfd.priv[f].ptr;
> +
> +			if ((map && ptr == map) || (overwrite_map && ptr == overwrite_map)) {
> +				pos = fdarray__clone(&thread_data->pollfd, f, &evlist->core.pollfd);
> +				if (pos < 0)
> +					return pos;
> +				pr_debug2("thread_data[%p]: pollfd[%d] <- event_fd=%d\n",
> +					 thread_data, pos, evlist->core.pollfd.entries[f].fd);
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int record__alloc_thread_data(struct record *rec, struct evlist *evlist)
> +{
> +	int t, ret;
> +	struct thread_data *thread_data;
> +
> +	rec->thread_data = zalloc(rec->nr_threads * sizeof(*(rec->thread_data)));
> +	if (!rec->thread_data) {
> +		pr_err("Failed to allocate thread data\n");
> +		return -ENOMEM;
> +	}
> +	thread_data = rec->thread_data;
> +
> +	for (t = 0; t < rec->nr_threads; t++) {
> +		thread_data[t].rec = rec;
> +		thread_data[t].mask = &rec->thread_masks[t];
> +		ret = record__thread_data_init_maps(&thread_data[t], evlist);
> +		if (ret)
> +			return ret;
> +		ret = record__thread_data_init_pollfd(&thread_data[t], evlist);
> +		if (ret)
> +			return ret;
> +		if (t) {
> +			thread_data[t].tid = -1;
> +			ret = record__thread_data_init_pipes(&thread_data[t]);
> +			if (ret)
> +				return ret;
> +			thread_data[t].ctlfd_pos = fdarray__add(&thread_data[t].pollfd,
> +								thread_data[t].pipes.msg[0],
> +								POLLIN | POLLERR | POLLHUP,
> +								fdarray_flag__nonfilterable);
> +			if (thread_data[t].ctlfd_pos < 0)
> +				return -ENOMEM;
> +			pr_debug2("thread_data[%p]: pollfd[%d] <- ctl_fd=%d\n",
> +				 thread_data, thread_data[t].ctlfd_pos,
> +				 thread_data[t].pipes.msg[0]);
> +		} else {
> +			thread_data[t].tid = syscall(SYS_gettid);
> +			if (evlist->ctl_fd.pos == -1)
> +				continue;
> +			thread_data[t].ctlfd_pos = fdarray__clone(&thread_data[t].pollfd,
> +								  evlist->ctl_fd.pos,
> +								  &evlist->core.pollfd);
> +			if (thread_data[t].ctlfd_pos < 0)
> +				return -ENOMEM;
> +			pr_debug2("thread_data[%p]: pollfd[%d] <- ctl_fd=%d\n",
> +				 thread_data, thread_data[t].ctlfd_pos,
> +				 evlist->core.pollfd.entries[evlist->ctl_fd.pos].fd);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void record__free_thread_data(struct record *rec)
> +{
> +	int t;
> +
> +	if (rec->thread_data == NULL)
> +		return;
> +
> +	for (t = 0; t < rec->nr_threads; t++) {
> +		if (rec->thread_data[t].pipes.msg[0])
> +			close(rec->thread_data[t].pipes.msg[0]);
> +		if (rec->thread_data[t].pipes.msg[1])
> +			close(rec->thread_data[t].pipes.msg[1]);
> +		if (rec->thread_data[t].pipes.ack[0])
> +			close(rec->thread_data[t].pipes.ack[0]);
> +		if (rec->thread_data[t].pipes.ack[1])
> +			close(rec->thread_data[t].pipes.ack[1]);
> +		zfree(&rec->thread_data[t].maps);
> +		zfree(&rec->thread_data[t].overwrite_maps);
> +		fdarray__exit(&rec->thread_data[t].pollfd);
> +	}
> +
> +	zfree(&rec->thread_data);
> +}
> +
>  static int record__mmap_evlist(struct record *rec,
>  			       struct evlist *evlist)
>  {
> +	int ret;
>  	struct record_opts *opts = &rec->opts;
>  	bool auxtrace_overwrite = opts->auxtrace_snapshot_mode ||
>  				  opts->auxtrace_sample_mode;
> @@ -880,6 +1064,14 @@ static int record__mmap_evlist(struct record *rec,
>  				return -EINVAL;
>  		}
>  	}
> +
> +	if (evlist__initialize_ctlfd(evlist, opts->ctl_fd, opts->ctl_fd_ack))
> +		return -1;
> +
> +	ret = record__alloc_thread_data(rec, evlist);
> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  }
>  
> @@ -1880,9 +2072,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		evlist__start_workload(rec->evlist);
>  	}
>  
> -	if (evlist__initialize_ctlfd(rec->evlist, opts->ctl_fd, opts->ctl_fd_ack))
> -		goto out_child;
> -
>  	if (opts->initial_delay) {
>  		pr_info(EVLIST_DISABLED_MSG);
>  		if (opts->initial_delay > 0) {
> @@ -2040,6 +2229,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  out_child:
>  	evlist__finalize_ctlfd(rec->evlist);
>  	record__mmap_read_all(rec, true);
> +	record__free_thread_data(rec);
>  	record__aio_mmap_read_sync(rec);
>  
>  	if (rec->session->bytes_transferred && rec->session->bytes_compressed) {
> -- 
> 2.19.0
> 

-- 

- Arnaldo
