Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CDA3AB604
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhFQOby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232366AbhFQObx (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:31:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3138613CB;
        Thu, 17 Jun 2021 14:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623940185;
        bh=y/+3VzGkclZ1MJ1v02VCdwPaNOmt5Dpu3nHtV81m1J0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eFa997J5SaBb0zTn4atD51zNsSJugC3U469cTkJGLafqRliGhs98lUaCOOJ0yGZHl
         eKy1Ii6uKTY65EeIjAoM4nHiz1G6lrQCMzOttemNP8QRX1LFtJh/L5xNkACNibX94v
         r+0cF2Q99W/W4KBNo1PHl8MEEarM1KJ1nVPEmWcJZ/+T82u9Q7n9QaX63cTu1nShw+
         SoXq4zquPDCbNOLlAtgS03t1sMp/CTC6VmPZrN9uevRP7wa873p+A5zX1Qe5huDiCT
         wDuZtGQnK8zWPDwx4flTiMOR3HNdKgQDwUKd5ju+AuWnjroXnmLbmkjuC6tW1j0WNZ
         9NQ7VoH7RoWZw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 16D0C40B1A; Thu, 17 Jun 2021 11:29:42 -0300 (-03)
Date:   Thu, 17 Jun 2021 11:29:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf tools: Enable on a list of CPUs for hybrid
Message-ID: <YMtcVkEyb8h/dzCb@kernel.org>
References: <20210617070026.14475-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617070026.14475-1-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 17, 2021 at 03:00:26PM +0800, Jin Yao escreveu:
> The perf-record and perf-stat have supported the option '-C/--cpus'
> to count or collect only on the list of CPUs provided. This option
> needs to be supported for hybrid as well.
> 
> For hybrid support, it needs to check that the CPUs are available on
> hybrid PMU. On AlderLake, for example, 'cpu_core' has CPU0-CPU15,
> and 'cpu_atom' has CPU16-CPU23.
> 
> Before:
> 
>   # perf stat -e cpu_core/cycles/ -C16 true
> 
>    Performance counter stats for 'CPU(s) 16':
> 
>      <not supported>      cpu_core/cycles/
> 
> The perf-stat silently returned "<not supported>" without any helpful
> information. It should error out that CPU16 was not available on
> 'cpu_core'.
> 
> After:
> 
>   # perf stat -e cpu_core/cycles/ -C16 true
>   'cpu_core' doesn't have cpu 16
>   failed to use cpu list 16

The above is sensible, as the user specified a specific CPU type
(cpu_core) and asked for a CPU list that is of another type (cpu_atom).
Perhaps the message can be improved a bit by checking if the CPU list
specified is valid for the other cpu type (cpu_atom) and print:

   # perf stat -e cpu_core/cycles/ -C16 true
   CPU 16 isn't a 'cpu_core', please use 'cpu_atom/cycles/' or use a CPU list in the 'cpu_core' range (0-15).
   failed to use cpu list 16
 
> It also supports to count only on a given CPU.
 
>   # perf stat -e cpu_core/cycles/ -C15 -vv true

Humm, what if I want to count events on some cpu_core CPUs plus on some
cpu_atom ones?

I.e. if I do:

	perf stat -e cycles -C16

probably it should map to cpu_atom/cycles/, right? And if I do:

	perf stat -e cycles -C15,16

This should map to cpu_core/cycles/ on CPU 15 and to cpu_atom/cycles/ on
CPU 16?

Or perhaps we should make the CPU list a evsel term? I.e.:

	perf stat -e cpu_core/cycles,cpus=15/,cpu_atom/cycles,cpus=16/

Or perhaps both?

- Arnaldo

 
>   ------------------------------------------------------------
>   perf_event_attr:
>     size                             128
>     config                           0x400000000
>     sample_type                      IDENTIFIER
>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>     disabled                         1
>     inherit                          1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 15  group_fd -1  flags 0x8 = 3
>   cycles: 0: 103287 569776 569776
>   cycles: 103287 569776 569776
> 
>    Performance counter stats for 'CPU(s) 15':
> 
>              103,287      cpu_core/cycles/
> 
>          0.000566813 seconds time elapsed
> 
> Collect the counts of 'cycles' on CPU15 (CPU15 is in 'cpu_core').
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/builtin-record.c     |  6 +++++
>  tools/perf/builtin-stat.c       |  5 ++++
>  tools/perf/util/evlist-hybrid.c | 43 +++++++++++++++++++++++++++++++++
>  tools/perf/util/evlist-hybrid.h |  1 +
>  tools/perf/util/evlist.c        |  1 +
>  tools/perf/util/pmu.c           | 23 ++++++++++++++++++
>  tools/perf/util/pmu.h           |  3 +++
>  7 files changed, 82 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index bc3dd379eb67..bd39d4260549 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -2877,6 +2877,12 @@ int cmd_record(int argc, const char **argv)
>  	/* Enable ignoring missing threads when -u/-p option is defined. */
>  	rec->opts.ignore_missing_thread = rec->opts.target.uid != UINT_MAX || rec->opts.target.pid;
>  
> +	if (evlist__use_cpu_list(rec->evlist, rec->opts.target.cpu_list)) {
> +		pr_err("failed to use cpu list %s\n",
> +		       rec->opts.target.cpu_list);
> +		goto out;
> +	}
> +
>  	err = -ENOMEM;
>  	if (evlist__create_maps(rec->evlist, &rec->opts.target) < 0)
>  		usage_with_options(record_usage, record_options);
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index f9f74a514315..9c27c90d069f 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2427,6 +2427,11 @@ int cmd_stat(int argc, const char **argv)
>  	if ((stat_config.aggr_mode == AGGR_THREAD) && (target.system_wide))
>  		target.per_thread = true;
>  
> +	if (evlist__use_cpu_list(evsel_list, target.cpu_list)) {
> +		pr_err("failed to use cpu list %s\n", target.cpu_list);
> +		goto out;
> +	}
> +
>  	if (evlist__create_maps(evsel_list, &target) < 0) {
>  		if (target__has_task(&target)) {
>  			pr_err("Problems finding threads of monitor\n");
> diff --git a/tools/perf/util/evlist-hybrid.c b/tools/perf/util/evlist-hybrid.c
> index db3f5fbdebe1..e8fdd98aed3f 100644
> --- a/tools/perf/util/evlist-hybrid.c
> +++ b/tools/perf/util/evlist-hybrid.c
> @@ -86,3 +86,46 @@ bool evlist__has_hybrid(struct evlist *evlist)
>  
>  	return false;
>  }
> +
> +int evlist__use_cpu_list(struct evlist *evlist, const char *cpu_list)
> +{
> +	struct perf_cpu_map *cpus;
> +	struct evsel *evsel;
> +	struct perf_pmu *pmu;
> +	int ret;
> +
> +	if (!perf_pmu__has_hybrid() || !cpu_list)
> +		return 0;
> +
> +	cpus = perf_cpu_map__new(cpu_list);
> +	if (!cpus)
> +		return -1;
> +
> +	evlist__for_each_entry(evlist, evsel) {
> +		bool exact_match;
> +
> +		pmu = perf_pmu__find_hybrid_pmu(evsel->pmu_name);
> +		if (!pmu)
> +			continue;
> +
> +		if (!perf_pmu__cpus_matched(pmu, cpus, &exact_match)) {
> +			ret = -1;
> +			goto out;
> +		}
> +
> +		if (!exact_match) {
> +			/*
> +			 * Use the cpus in cpu_list.
> +			 */
> +			perf_cpu_map__put(evsel->core.cpus);
> +			perf_cpu_map__put(evsel->core.own_cpus);
> +			evsel->core.cpus = perf_cpu_map__get(cpus);
> +			evsel->core.own_cpus = perf_cpu_map__get(cpus);
> +		}
> +	}
> +
> +	ret = 0;
> +out:
> +	perf_cpu_map__put(cpus);
> +	return ret;
> +}
> diff --git a/tools/perf/util/evlist-hybrid.h b/tools/perf/util/evlist-hybrid.h
> index 19f74b4c340a..f33a4e8443a1 100644
> --- a/tools/perf/util/evlist-hybrid.h
> +++ b/tools/perf/util/evlist-hybrid.h
> @@ -10,5 +10,6 @@
>  int evlist__add_default_hybrid(struct evlist *evlist, bool precise);
>  void evlist__warn_hybrid_group(struct evlist *evlist);
>  bool evlist__has_hybrid(struct evlist *evlist);
> +int evlist__use_cpu_list(struct evlist *evlist, const char *cpu_list);
>  
>  #endif /* __PERF_EVLIST_HYBRID_H */
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 6ba9664089bd..e8a0f95f7f47 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -27,6 +27,7 @@
>  #include "util/perf_api_probe.h"
>  #include "util/evsel_fprintf.h"
>  #include "util/evlist-hybrid.h"
> +#include "util/pmu.h"
>  #include <signal.h>
>  #include <unistd.h>
>  #include <sched.h>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 88c8ecdc60b0..0e3a19a6736d 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1872,3 +1872,26 @@ bool perf_pmu__has_hybrid(void)
>  
>  	return !list_empty(&perf_pmu__hybrid_pmus);
>  }
> +
> +bool perf_pmu__cpus_matched(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
> +			    bool *exact_match)
> +{
> +	struct perf_cpu_map *pmu_cpus = pmu->cpus;
> +	int cpu;
> +
> +	*exact_match = false;
> +
> +	for (int i = 0; i < cpus->nr; i++) {
> +		cpu = perf_cpu_map__idx(pmu_cpus, cpus->map[i]);
> +		if (cpu == -1) {
> +			pr_err("'%s' doesn't have cpu %d\n",
> +			       pmu->name, cpus->map[i]);
> +			return false;
> +		}
> +	}
> +
> +	if (cpus->nr == pmu_cpus->nr)
> +		*exact_match = true;
> +
> +	return true;
> +}
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index a790ef758171..1cca48e02b5d 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -11,6 +11,7 @@
>  #include "pmu-events/pmu-events.h"
>  
>  struct evsel_config_term;
> +struct perf_cpu_map;
>  
>  enum {
>  	PERF_PMU_FORMAT_VALUE_CONFIG,
> @@ -133,5 +134,7 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
>  				   char *name);
>  
>  bool perf_pmu__has_hybrid(void);
> +bool perf_pmu__cpus_matched(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
> +			    bool *exact_match);
>  
>  #endif /* __PMU_H */
> -- 
> 2.17.1
> 

-- 

- Arnaldo
