Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7AC3B86F0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 18:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhF3QTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 12:19:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhF3QTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 12:19:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 692AF61432;
        Wed, 30 Jun 2021 16:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625069836;
        bh=BeJiROVqlJwZCvSsZGvTEmxYuBXNeR/dJgCXjDEV6yw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XKk4i7lyKOxDkmBJWLZTY8mfwCGgSZjDV4zfVsV/12SJZkU88E048GqVwdzhnb3aw
         9jd8Gg3v77SyrYSTHAPEOuh7uBIKIOdENG/mxT4lBPZLvltM2bQ4QV9CFMMSxV+noL
         a5aUUIOPtoSaS6evDvUuC6ksym+zzh0zdmbTH9U+WOfgBXKBnJVyCMMgynRNTaaknb
         z4am/M8DjJs4ewK/o+ZCCNL4HCdTijKLVr3VLQj9qRQ1dy1uqFbtHzH06g8PQ1uaE2
         /INHPZV1ixzOVE75BuMxfc3CxHGtho11a5hMkBg76la57mBThb0D/elezLQ0RpNsHp
         pL+ysjRJWXEhA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2847D40B1A; Wed, 30 Jun 2021 13:17:13 -0300 (-03)
Date:   Wed, 30 Jun 2021 13:17:13 -0300
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
Subject: Re: [PATCH v8 01/22] perf record: Introduce thread affinity and mmap
 masks
Message-ID: <YNyZCZ92W39inSD2@kernel.org>
References: <cover.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <ab1e7917845cc175a9e1d7f149e07b000d24c881.1625065643.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab1e7917845cc175a9e1d7f149e07b000d24c881.1625065643.git.alexey.v.bayduraev@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 30, 2021 at 06:54:40PM +0300, Alexey Bayduraev escreveu:
> Introduce affinity and mmap thread masks. Thread affinity mask
> defines cpus that a thread is allowed to run on. Thread maps
> mask defines mmap data buffers the thread serves to stream
> profiling data from.

At this point we probably be better off renaming 'struct mmap_cpu_mask'
to 'struct cpumask' since it is not only for 'mmap's, right?

In fact probably would be better to adopt linux/cpumask.h from the
kernel sources, i.e.:

typedef struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;

some more comments below
 
> Acked-by: Andi Kleen <ak@linux.intel.com>
> Acked-by: Namhyung Kim <namhyung@gmail.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 127 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 127 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 71efe6573ee7..31b3a515abc1 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -87,6 +87,11 @@ struct switch_output {
>  	int		 cur_file;
>  };
>  
> +struct thread_mask {
> +	struct mmap_cpu_mask	maps;
> +	struct mmap_cpu_mask	affinity;
> +};
> +
>  struct record {
>  	struct perf_tool	tool;
>  	struct record_opts	opts;
> @@ -111,6 +116,8 @@ struct record {
>  	unsigned long long	samples;
>  	struct mmap_cpu_mask	affinity_mask;
>  	unsigned long		output_max_size;	/* = 0: unlimited */
> +	struct thread_mask	*thread_masks;
> +	int			nr_threads;

can you move 'nr_threads' to before 'thread_masks'?

>  };
>  
>  static volatile int done;
> @@ -2216,6 +2223,55 @@ static int record__parse_affinity(const struct option *opt, const char *str, int
>  	return 0;
>  }
>  
> +static int record__mmap_cpu_mask_alloc(struct mmap_cpu_mask *mask, int nr_bits)
> +{
> +	mask->nbits = nr_bits;
> +	mask->bits = bitmap_alloc(mask->nbits);
> +	if (!mask->bits) {
> +		pr_err("Failed to allocate mmap_cpu mask\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static void record__mmap_cpu_mask_free(struct mmap_cpu_mask *mask)
> +{
> +	bitmap_free(mask->bits);
> +	mask->nbits = 0;

Plese use NULL, as 'mask->nbits' is a pointer.

> +}
> +
> +static void record__thread_mask_clear(struct thread_mask *mask)
> +{
> +	bitmap_zero(mask->maps.bits, mask->maps.nbits);
> +	bitmap_zero(mask->affinity.bits, mask->affinity.nbits);
> +}
> +
> +static int record__thread_mask_alloc(struct thread_mask *mask, int nr_bits)
> +{
> +	int ret;
> +
> +	ret = record__mmap_cpu_mask_alloc(&mask->maps, nr_bits);


please combine such decl + assign into one line, i.e.:

	int ret = record__mmap_cpu_mask_alloc(&mask->maps, nr_bits);

> +	if (ret) {
> +		mask->affinity.bits = NULL;
> +		return ret;
> +	}
> +
> +	ret = record__mmap_cpu_mask_alloc(&mask->affinity, nr_bits);
> +	if (ret) {
> +		record__mmap_cpu_mask_free(&mask->maps);
> +		mask->maps.bits = NULL;
> +	}
> +
> +	return ret;
> +}
> +
> +static void record__thread_mask_free(struct thread_mask *mask)
> +{
> +	record__mmap_cpu_mask_free(&mask->maps);
> +	record__mmap_cpu_mask_free(&mask->affinity);
> +}
> +
>  static int parse_output_max_size(const struct option *opt,
>  				 const char *str, int unset)
>  {
> @@ -2664,6 +2720,70 @@ static struct option __record_options[] = {
>  
>  struct option *record_options = __record_options;
>  
> +static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_cpu_map *cpus)
> +{
> +	int c;
> +
> +	for (c = 0; c < cpus->nr; c++)
> +		set_bit(cpus->map[c], mask->bits);
> +}
> +
> +static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr_bits)
> +{
> +	int t, ret;
> +
> +	rec->thread_masks = zalloc(nr_threads * sizeof(*(rec->thread_masks)));
> +	if (!rec->thread_masks) {
> +		pr_err("Failed to allocate thread masks\n");
> +		return -ENOMEM;
> +	}
> +
> +	for (t = 0; t < nr_threads; t++) {
> +		ret = record__thread_mask_alloc(&rec->thread_masks[t], nr_bits);

Usually when we don't manage to allocate all that we need we go on and
free the partially allocated resources.

> +		if (ret)
> +			return ret;
> +		record__thread_mask_clear(&rec->thread_masks[t]);
> +	}
> +
> +	return 0;
> +}
> +static int record__init_thread_default_masks(struct record *rec, struct perf_cpu_map *cpus)
> +{
> +	int ret;
> +
> +	ret = record__alloc_thread_masks(rec, 1, cpu__max_cpu());

ditto

> +	if (ret)
> +		return ret;
> +
> +	record__mmap_cpu_mask_init(&rec->thread_masks->maps, cpus);
> +
> +	rec->nr_threads = 1;
> +
> +	return 0;
> +}
> +
> +static int record__init_thread_masks(struct record *rec)
> +{
> +	struct perf_cpu_map *cpus = rec->evlist->core.cpus;
> +
> +	return record__init_thread_default_masks(rec, cpus);
> +}
> +
> +static int record__fini_thread_masks(struct record *rec)
> +{
> +	int t;
> +
> +	if (rec->thread_masks)
> +		for (t = 0; t < rec->nr_threads; t++)
> +			record__thread_mask_free(&rec->thread_masks[t]);
> +
> +	zfree(&rec->thread_masks);
> +
> +	rec->nr_threads = 0;
> +
> +	return 0;
> +}
> +
>  int cmd_record(int argc, const char **argv)
>  {
>  	int err;
> @@ -2912,6 +3032,12 @@ int cmd_record(int argc, const char **argv)
>  		goto out;
>  	}
>  
> +	err = record__init_thread_masks(rec);
> +	if (err) {
> +		pr_err("record__init_thread_masks failed, error %d\n", err);
> +		goto out;
> +	}
> +
>  	if (rec->opts.nr_cblocks > nr_cblocks_max)
>  		rec->opts.nr_cblocks = nr_cblocks_max;
>  	pr_debug("nr_cblocks: %d\n", rec->opts.nr_cblocks);
> @@ -2930,6 +3056,7 @@ int cmd_record(int argc, const char **argv)
>  	symbol__exit();
>  	auxtrace_record__free(rec->itr);
>  out_opts:
> +	record__fini_thread_masks(rec);
>  	evlist__close_control(rec->opts.ctl_fd, rec->opts.ctl_fd_ack, &rec->opts.ctl_fd_close);
>  	return err;
>  }
> -- 
> 2.19.0
> 

-- 

- Arnaldo
