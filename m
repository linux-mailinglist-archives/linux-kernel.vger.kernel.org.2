Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB7A31407C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbhBHU3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:29:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:35570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236031AbhBHTG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:06:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AF8264E75;
        Mon,  8 Feb 2021 19:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612811141;
        bh=PKmMPBSBILesutagQZp0npvjiNPBthqvu4YLaccPZ9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iZXW5Q7zwuOohgicsdBUxxaqoniUjYqCv+Acba4xP7gapetbhDFfXbrQglmcOoZ82
         WzESzUMMO4LOLwzYPuI+37zXUV8rdeGUBqcuPdxuSYlPgCVfoC33yrSevE8HhECxnL
         FJTw76hez62UdFQ80Xm3MyevTCBWsJnEpZOFLunLrNSHyWP1xxi6S/P/tk0cFybMSS
         eIhzJEC5Co8tuAG1+YOHETTmvIsoO4Usk6R4SsZF1C43G07t8d3cPrn+iNSKHQnw7p
         8iTAJ/E7rKNkh60e7KQlkD5iiaDtkPhG6GZWW9kLYHfYddipz6Ti5MvvKhaLS5R0Gx
         sXFak+k2vMAcw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7C97640513; Mon,  8 Feb 2021 16:05:38 -0300 (-03)
Date:   Mon, 8 Feb 2021 16:05:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com
Subject: Re: [PATCH 32/49] perf header: Support HYBRID_TOPOLOGY feature
Message-ID: <20210208190538.GM920417@kernel.org>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
 <1612797946-18784-33-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612797946-18784-33-git-send-email-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 08, 2021 at 07:25:29AM -0800, kan.liang@linux.intel.com escreveu:
> From: Jin Yao <yao.jin@linux.intel.com>
> 
> It would be useful to let user know the hybrid topology.
> For example, the HYBRID_TOPOLOGY feature in header indicates which
> cpus are core cpus, and which cpus are atom cpus.

Can you please update tools/perf/Documentation/perf.data-file-format.txt
?
 
> With this patch,

> On a hybrid platform:
> 
>   root@otcpl-adl-s-2:~# ./perf report --header-only -I
>   ...
>   # cpu_core cpu list : 0-15
>   # cpu_atom cpu list : 16-23
> 
> On a non-hybrid platform:
> 
>   root@kbl-ppc:~# ./perf report --header-only -I
>   ...
>   # missing features: TRACING_DATA BRANCH_STACK GROUP_DESC AUXTRACE STAT CLOCKID DIR_FORMAT COMPRESSED CLOCK_DATA HYBRID_TOPOLOGY
> 
> It just shows HYBRID_TOPOLOGY is missing feature.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/cputopo.c | 80 +++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/cputopo.h | 13 +++++++
>  tools/perf/util/env.c     |  6 ++++
>  tools/perf/util/env.h     |  7 ++++
>  tools/perf/util/header.c  | 92 +++++++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/header.h  |  1 +
>  tools/perf/util/pmu.c     |  1 -
>  tools/perf/util/pmu.h     |  1 +
>  8 files changed, 200 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
> index 1b52402..4a00fb8 100644
> --- a/tools/perf/util/cputopo.c
> +++ b/tools/perf/util/cputopo.c
> @@ -12,6 +12,7 @@
>  #include "cpumap.h"
>  #include "debug.h"
>  #include "env.h"
> +#include "pmu.h"
>  
>  #define CORE_SIB_FMT \
>  	"%s/devices/system/cpu/cpu%d/topology/core_siblings_list"
> @@ -351,3 +352,82 @@ void numa_topology__delete(struct numa_topology *tp)
>  
>  	free(tp);
>  }
> +
> +static int load_hybrid_node(struct hybrid_topology_node *node,
> +			    struct perf_pmu *pmu)
> +{
> +	const char *sysfs;
> +	char path[PATH_MAX];
> +	char *buf = NULL, *p;
> +	FILE *fp;
> +	size_t len = 0;
> +
> +	node->pmu_name = strdup(pmu->name);
> +	if (!node->pmu_name)
> +		return -1;
> +
> +	sysfs = sysfs__mountpoint();

Check for NULL

> +	snprintf(path, PATH_MAX, CPUS_TEMPLATE_CPU, sysfs, pmu->name);
> +
> +	fp = fopen(path, "r");
> +	if (!fp)
> +		goto err;
> +
> +	if (getline(&buf, &len, fp) <= 0) {
> +		fclose(fp);
> +		goto err;
> +	}
> +
> +	p = strchr(buf, '\n');
> +	if (p)
> +		*p = '\0';
> +
> +	fclose(fp);
> +	node->cpus = buf;
> +	return 0;
> +
> +err:
> +	zfree(&node->pmu_name);
> +	free(buf);
> +	return -1;
> +}
> +
> +struct hybrid_topology *hybrid_topology__new(void)
> +{
> +	struct perf_pmu *pmu;
> +	struct hybrid_topology *tp = NULL;
> +	u32 nr = 0, i = 0;
> +
> +	perf_pmu__for_each_hybrid_pmus(pmu)
> +		nr++;
> +
> +	if (nr == 0)
> +		return NULL;
> +
> +	tp = zalloc(sizeof(*tp) + sizeof(tp->nodes[0]) * nr);
> +	if (!tp)
> +		return NULL;
> +
> +	tp->nr = nr;
> +	perf_pmu__for_each_hybrid_pmus(pmu) {
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
> index 6201c37..d9af971 100644
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
> index 9130f6f..9e05eca 100644
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
> index ca249bf..9ca7633 100644
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
> index c4ed3dc..6bcd959 100644
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
> index 2aca717..3f12ec0 100644
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
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 9a6c973..ca2fc67 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -607,7 +607,6 @@ static struct perf_cpu_map *__pmu_cpumask(const char *path)
>   */
>  #define SYS_TEMPLATE_ID	"./bus/event_source/devices/%s/identifier"
>  #define CPUS_TEMPLATE_UNCORE	"%s/bus/event_source/devices/%s/cpumask"
> -#define CPUS_TEMPLATE_CPU	"%s/bus/event_source/devices/%s/cpus"
>  
>  static struct perf_cpu_map *pmu_cpumask(const char *name)
>  {
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 5b727cf..ccffc05 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -20,6 +20,7 @@ enum {
>  
>  #define PERF_PMU_FORMAT_BITS 64
>  #define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
> +#define CPUS_TEMPLATE_CPU	"%s/bus/event_source/devices/%s/cpus"
>  
>  struct perf_event_attr;
>  
> -- 
> 2.7.4
> 

-- 

- Arnaldo
