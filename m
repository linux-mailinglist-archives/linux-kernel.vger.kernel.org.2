Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8663B879F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 19:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhF3RYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 13:24:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbhF3RYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 13:24:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E48361483;
        Wed, 30 Jun 2021 17:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625073702;
        bh=mO5YhRPSHGp1rxCs19fJ4Q/IyCwUx8Q0ixTdiOdspcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hYTj74hZsMlkQZaWujFrfpztW8M/fVT0DSspYZYQdV1jK2oO4uH2WiOFy3XRcY+u9
         lunjes2yEC9pSXRzeycziHCsa74rn8TSPx3DNnDztkET6mPpvdyC3nIdzvFdEzfHx5
         BkPSCUmLvsNNsUV1nPvNyWb3F6jKDwligeK0r3LJ3z5gCLNoSIyPpJUNzhCOJX3q9/
         UGMIvPXnlP+hOzIJ5OdnzoiZ5S5iy7+iJi53y4oT4vvC2a9lKfEN9bx/UIbGL4JNNB
         5orn9ueftCk0XKry0YfpPneRcKqegPMJF7O4Fn5WJgQmO1p1a6MYNDhcgB9JaR4FCx
         iIfCgrjZoyroA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 08FD340B1A; Wed, 30 Jun 2021 14:21:40 -0300 (-03)
Date:   Wed, 30 Jun 2021 14:21:39 -0300
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
Subject: Re: [PATCH v8 05/22] perf record: Start threads in the beginning of
 trace streaming
Message-ID: <YNyoI3sT8z7rrdM4@kernel.org>
References: <cover.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <d592768896213a55dd035a1aa4c2eb5c6f8b3b4d.1625065643.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d592768896213a55dd035a1aa4c2eb5c6f8b3b4d.1625065643.git.alexey.v.bayduraev@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 30, 2021 at 06:54:44PM +0300, Alexey Bayduraev escreveu:
> Start thread in detached state because its management is implemented
> via messaging to avoid any scaling issues. Block signals prior thread
> start so only main tool thread would be notified on external async
> signals during data collection. Thread affinity mask is used to assign
> eligible cpus for the thread to run. Wait and sync on thread start using
> thread ack pipe.
> 
> Acked-by: Namhyung Kim <namhyung@gmail.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 108 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 107 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 82a21da2af16..cead2b3c56d7 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1423,6 +1423,66 @@ static void record__thread_munmap_filtered(struct fdarray *fda, int fd,
>  		perf_mmap__put(map);
>  }
>  
> +static void *record__thread(void *arg)
> +{
> +	enum thread_msg msg = THREAD_MSG__READY;
> +	bool terminate = false;
> +	struct fdarray *pollfd;
> +	int err, ctlfd_pos;
> +
> +	thread = arg;
> +	thread->tid = syscall(SYS_gettid);

We have 'gettid()' in tools/perf, its not in a nice place but we have
tools/build/feature/test-gettid.c to test if gettid() is available in
system headers and if not, then:

tools/perf/jvmti/jvmti_agent.c

#ifndef HAVE_GETTID
static inline pid_t gettid(void)
{
        return (pid_t)syscall(__NR_gettid);
}
#endif

I'll move it to a more suitable place so that you can use it here.


> +	err = write(thread->pipes.ack[1], &msg, sizeof(msg));
> +	if (err == -1)
> +		pr_err("threads[%d]: failed to notify on start: %s", thread->tid, strerror(errno));
> +
> +	pr_debug("threads[%d]: started on cpu=%d\n", thread->tid, sched_getcpu());
> +
> +	pollfd = &thread->pollfd;
> +	ctlfd_pos = thread->ctlfd_pos;
> +
> +	for (;;) {
> +		unsigned long long hits = thread->samples;
> +
> +		if (record__mmap_read_all(thread->rec, false) < 0 || terminate)
> +			break;
> +
> +		if (hits == thread->samples) {
> +
> +			err = fdarray__poll(pollfd, -1);
> +			/*
> +			 * Propagate error, only if there's any. Ignore positive
> +			 * number of returned events and interrupt error.
> +			 */
> +			if (err > 0 || (err < 0 && errno == EINTR))
> +				err = 0;
> +			thread->waking++;
> +
> +			if (fdarray__filter(pollfd, POLLERR | POLLHUP,
> +					    record__thread_munmap_filtered, NULL) == 0)
> +				break;
> +		}
> +
> +		if (pollfd->entries[ctlfd_pos].revents & POLLHUP) {
> +			terminate = true;
> +			close(thread->pipes.msg[0]);
> +			pollfd->entries[ctlfd_pos].fd = -1;
> +			pollfd->entries[ctlfd_pos].events = 0;
> +		}
> +
> +		pollfd->entries[ctlfd_pos].revents = 0;
> +	}
> +	record__mmap_read_all(thread->rec, true);
> +
> +	err = write(thread->pipes.ack[1], &msg, sizeof(msg));
> +	if (err == -1)
> +		pr_err("threads[%d]: failed to notify on termination: %s",
> +		       thread->tid, strerror(errno));
> +
> +	return NULL;
> +}
> +
>  static void record__init_features(struct record *rec)
>  {
>  	struct perf_session *session = rec->session;
> @@ -1886,13 +1946,59 @@ static int record__terminate_thread(struct thread_data *thread_data)
>  
>  static int record__start_threads(struct record *rec)
>  {
> +	int t, tt, ret = 0, nr_threads = rec->nr_threads;
>  	struct thread_data *thread_data = rec->thread_data;
> +	sigset_t full, mask;
> +	pthread_t handle;
> +	pthread_attr_t attrs;
> +
> +	sigfillset(&full);
> +	if (sigprocmask(SIG_SETMASK, &full, &mask)) {
> +		pr_err("Failed to block signals on threads start: %s\n", strerror(errno));
> +		return -1;
> +	}
> +
> +	pthread_attr_init(&attrs);
> +	pthread_attr_setdetachstate(&attrs, PTHREAD_CREATE_DETACHED);
> +
> +	for (t = 1; t < nr_threads; t++) {
> +		enum thread_msg msg = THREAD_MSG__UNDEFINED;
> +
> +		pthread_attr_setaffinity_np(&attrs,
> +					    MMAP_CPU_MASK_BYTES(&(thread_data[t].mask->affinity)),
> +					    (cpu_set_t *)(thread_data[t].mask->affinity.bits));
> +
> +		if (pthread_create(&handle, &attrs, record__thread, &thread_data[t])) {
> +			for (tt = 1; tt < t; tt++)
> +				record__terminate_thread(&thread_data[t]);
> +			pr_err("Failed to start threads: %s\n", strerror(errno));
> +			ret = -1;
> +			goto out_err;
> +		}
> +
> +		if (read(thread_data[t].pipes.ack[0], &msg, sizeof(msg)) > 0)
> +			pr_debug2("threads[%d]: sent %s\n", rec->thread_data[t].tid,
> +				 thread_msg_tags[msg]);
> +	}
> +
> +	if (nr_threads > 1) {
> +		sched_setaffinity(0, MMAP_CPU_MASK_BYTES(&thread_data[0].mask->affinity),
> +				  (cpu_set_t *)thread_data[0].mask->affinity.bits);
> +	}
>  
>  	thread = &thread_data[0];
>  
>  	pr_debug("threads[%d]: started on cpu=%d\n", thread->tid, sched_getcpu());
>  
> -	return 0;
> +out_err:
> +	pthread_attr_destroy(&attrs);
> +
> +	if (sigprocmask(SIG_SETMASK, &mask, NULL)) {
> +		pr_err("Failed to unblock signals on threads start: %s\n", strerror(errno));
> +		ret = -1;
> +	}
> +
> +	return ret;
>  }
>  
>  static int record__stop_threads(struct record *rec, unsigned long *waking)
> -- 
> 2.19.0
> 

-- 

- Arnaldo
