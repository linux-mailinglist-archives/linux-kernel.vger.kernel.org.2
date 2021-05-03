Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD263717B6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 17:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhECPTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:19:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:32848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230122AbhECPTf (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:19:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D88F611CE;
        Mon,  3 May 2021 15:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620055122;
        bh=ax1ph6eZmAz8QZmbBX0g7nXcbo/34X+upCrmIIZnZ7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CceCZZQU74oERZwwUJFVuy1d2k2aIBizQGaEFPXoOJlTGRvZl95mIrycCq/yVh98l
         msiHwKIHl0+jYbDXy7GceW6oxUvw7o0/tl/SUGENf3GR6o7Itlxc43SUb8BSywkds7
         dK0yGnFavLNEC6GQlfOMyx6XpewXgYCSmzTEjv1J+cnhRWOtnqIKEEDeAN58GTjCNE
         s77mwVSTC4klTISJqAMG/kp+M2x2v5QhEmxC1xFW7dhuJ/44kUA7bXnFy4GpXIghW0
         7yn3JeKCDhNKhoa29gOi6IvkBc8DCa6sGYhjLMFZ+T2cilkSs+L/yF8jdjTyVPX/ie
         /JabyqAsn8ZRA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5474241084; Mon,  3 May 2021 12:18:39 -0300 (-03)
Date:   Mon, 3 May 2021 12:18:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 1/2] perf header: Support HYBRID_TOPOLOGY feature
Message-ID: <YJAUTxgXCCcFOMTe@kernel.org>
References: <20210430074602.3028-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430074602.3028-1-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 30, 2021 at 03:46:01PM +0800, Jin Yao escreveu:
> +struct hybrid_topology *hybrid_topology__new(void)
> +{
> +	struct perf_pmu *pmu;
> +	struct hybrid_topology *tp = NULL;
> +	u32 nr = 0, i = 0;
> +
> +	nr = perf_pmu__hybrid_pmu_num();

Initialize it to zero and right away overwrite it with a function
return?

> +	u32 nr = 0, i = 0;

	u32 nr = perf_pmu__hybrid_pmu_num(), i;

> +	if (nr == 0)
> +		return NULL;
> +
> +	tp = zalloc(sizeof(*tp) + sizeof(tp->nodes[0]) * nr);
> +	if (!tp)
> +		return NULL;
> +
> +	tp->nr = nr;

	i = 0;

Please fix these and add an entry to
tools/perf/Documentation/perf.data-file-format.txt for this new feature,
then submit v2.

And on 2/2 please update the CPU_PMU_CAPS entry in
tools/perf/Documentation/perf.data-file-format.txt.

Thanks,

- Arnaldo


> +	perf_pmu__for_each_hybrid_pmu(pmu) {
> +		if (load_hybrid_node(&tp->nodes[i], pmu)) {
> +			hybrid_topology__delete(tp);
> +			return NULL;
> +		}
> +		i++;
> +	}
> +
> +	return tp;
> +}
> +
> +void hybrid_topology__delete(struct hybrid_topology *tp)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < tp->nr; i++) {
> +		zfree(&tp->nodes[i].pmu_name);
> +		zfree(&tp->nodes[i].cpus);
> +	}
> +
> +	free(tp);
> +}
> diff --git a/tools/perf/util/cputopo.h b/tools/perf/util/cputopo.h
> index 6201c3790d86..d9af97177068 100644
> --- a/tools/perf/util/cputopo.h
> +++ b/tools/perf/util/cputopo.h
> @@ -25,10 +25,23 @@ struct numa_topology {
>  	struct numa_topology_node	nodes[];
>  };
>  
> +struct hybrid_topology_node {
> +	char		*pmu_name;
> +	char		*cpus;
> +};
> +
> +struct hybrid_topology {
> +	u32				nr;
> +	struct hybrid_topology_node	nodes[];
> +};
> +
>  struct cpu_topology *cpu_topology__new(void);
>  void cpu_topology__delete(struct cpu_topology *tp);
>  
>  struct numa_topology *numa_topology__new(void);
>  void numa_topology__delete(struct numa_topology *tp);
>  
> +struct hybrid_topology *hybrid_topology__new(void);
> +void hybrid_topology__delete(struct hybrid_topology *tp);
> +
>  #endif /* __PERF_CPUTOPO_H */
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 9130f6fad8d5..9e05eca324a1 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -202,6 +202,12 @@ void perf_env__exit(struct perf_env *env)
>  	for (i = 0; i < env->nr_memory_nodes; i++)
>  		zfree(&env->memory_nodes[i].set);
>  	zfree(&env->memory_nodes);
> +
> +	for (i = 0; i < env->nr_hybrid_nodes; i++) {
> +		perf_cpu_map__put(env->hybrid_nodes[i].map);
> +		zfree(&env->hybrid_nodes[i].pmu_name);
> +	}
> +	zfree(&env->hybrid_nodes);
>  }
>  
>  void perf_env__init(struct perf_env *env __maybe_unused)
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index ca249bf5e984..9ca7633787e1 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -37,6 +37,11 @@ struct memory_node {
>  	unsigned long	*set;
>  };
>  
> +struct hybrid_node {
> +	char	*pmu_name;
> +	struct perf_cpu_map	*map;
> +};
> +
>  struct perf_env {
>  	char			*hostname;
>  	char			*os_release;
> @@ -59,6 +64,7 @@ struct perf_env {
>  	int			nr_pmu_mappings;
>  	int			nr_groups;
>  	int			nr_cpu_pmu_caps;
> +	int			nr_hybrid_nodes;
>  	char			*cmdline;
>  	const char		**cmdline_argv;
>  	char			*sibling_cores;
> @@ -77,6 +83,7 @@ struct perf_env {
>  	struct numa_node	*numa_nodes;
>  	struct memory_node	*memory_nodes;
>  	unsigned long long	 memory_bsize;
> +	struct hybrid_node	*hybrid_nodes;
>  #ifdef HAVE_LIBBPF_SUPPORT
>  	/*
>  	 * bpf_info_lock protects bpf rbtrees. This is needed because the
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index aa1e42518d37..dff89c0be79c 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -932,6 +932,40 @@ static int write_clock_data(struct feat_fd *ff,
>  	return do_write(ff, data64, sizeof(*data64));
>  }
>  
> +static int write_hybrid_topology(struct feat_fd *ff,
> +				 struct evlist *evlist __maybe_unused)
> +{
> +	struct hybrid_topology *tp;
> +	int ret;
> +	u32 i;
> +
> +	tp = hybrid_topology__new();
> +	if (!tp)
> +		return -1;
> +
> +	ret = do_write(ff, &tp->nr, sizeof(u32));
> +	if (ret < 0)
> +		goto err;
> +
> +	for (i = 0; i < tp->nr; i++) {
> +		struct hybrid_topology_node *n = &tp->nodes[i];
> +
> +		ret = do_write_string(ff, n->pmu_name);
> +		if (ret < 0)
> +			goto err;
> +
> +		ret = do_write_string(ff, n->cpus);
> +		if (ret < 0)
> +			goto err;
> +	}
> +
> +	ret = 0;
> +
> +err:
> +	hybrid_topology__delete(tp);
> +	return ret;
> +}
> +
>  static int write_dir_format(struct feat_fd *ff,
>  			    struct evlist *evlist __maybe_unused)
>  {
> @@ -1623,6 +1657,19 @@ static void print_clock_data(struct feat_fd *ff, FILE *fp)
>  		    clockid_name(clockid));
>  }
>  
> +static void print_hybrid_topology(struct feat_fd *ff, FILE *fp)
> +{
> +	int i;
> +	struct hybrid_node *n;
> +
> +	for (i = 0; i < ff->ph->env.nr_hybrid_nodes; i++) {
> +		n = &ff->ph->env.hybrid_nodes[i];
> +
> +		fprintf(fp, "# %s cpu list : ", n->pmu_name);
> +		cpu_map__fprintf(n->map, fp);
> +	}
> +}
> +
>  static void print_dir_format(struct feat_fd *ff, FILE *fp)
>  {
>  	struct perf_session *session;
> @@ -2849,6 +2896,50 @@ static int process_clock_data(struct feat_fd *ff,
>  	return 0;
>  }
>  
> +static int process_hybrid_topology(struct feat_fd *ff,
> +				   void *data __maybe_unused)
> +{
> +	struct hybrid_node *nodes, *n;
> +	u32 nr, i;
> +	char *str;
> +
> +	/* nr nodes */
> +	if (do_read_u32(ff, &nr))
> +		return -1;
> +
> +	nodes = zalloc(sizeof(*nodes) * nr);
> +	if (!nodes)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < nr; i++) {
> +		n = &nodes[i];
> +
> +		n->pmu_name = do_read_string(ff);
> +		if (!n->pmu_name)
> +			goto error;
> +
> +		str = do_read_string(ff);
> +		if (!str)
> +			goto error;
> +
> +		n->map = perf_cpu_map__new(str);
> +		free(str);
> +		if (!n->map)
> +			goto error;
> +	}
> +
> +	ff->ph->env.nr_hybrid_nodes = nr;
> +	ff->ph->env.hybrid_nodes = nodes;
> +	return 0;
> +
> +error:
> +	for (i = 0; i < nr; i++)
> +		free(nodes[i].pmu_name);
> +
> +	free(nodes);
> +	return -1;
> +}
> +
>  static int process_dir_format(struct feat_fd *ff,
>  			      void *_data __maybe_unused)
>  {
> @@ -3117,6 +3208,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
>  	FEAT_OPR(COMPRESSED,	compressed,	false),
>  	FEAT_OPR(CPU_PMU_CAPS,	cpu_pmu_caps,	false),
>  	FEAT_OPR(CLOCK_DATA,	clock_data,	false),
> +	FEAT_OPN(HYBRID_TOPOLOGY,	hybrid_topology,	true),
>  };
>  
>  struct header_print_data {
> diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
> index 2aca71763ecf..3f12ec0eb84e 100644
> --- a/tools/perf/util/header.h
> +++ b/tools/perf/util/header.h
> @@ -45,6 +45,7 @@ enum {
>  	HEADER_COMPRESSED,
>  	HEADER_CPU_PMU_CAPS,
>  	HEADER_CLOCK_DATA,
> +	HEADER_HYBRID_TOPOLOGY,
>  	HEADER_LAST_FEATURE,
>  	HEADER_FEAT_BITS	= 256,
>  };
> diff --git a/tools/perf/util/pmu-hybrid.h b/tools/perf/util/pmu-hybrid.h
> index d0fa7bc50a76..2b186c26a43e 100644
> --- a/tools/perf/util/pmu-hybrid.h
> +++ b/tools/perf/util/pmu-hybrid.h
> @@ -19,4 +19,15 @@ struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name);
>  bool perf_pmu__is_hybrid(const char *name);
>  char *perf_pmu__hybrid_type_to_pmu(const char *type);
>  
> +static inline int perf_pmu__hybrid_pmu_num(void)
> +{
> +	struct perf_pmu *pmu;
> +	int num = 0;
> +
> +	perf_pmu__for_each_hybrid_pmu(pmu)
> +		num++;
> +
> +	return num;
> +}
> +
>  #endif /* __PMU_HYBRID_H */
> -- 
> 2.17.1
> 

-- 

- Arnaldo
