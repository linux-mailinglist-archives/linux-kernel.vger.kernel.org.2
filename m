Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427A7338FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhCLOYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:24:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231512AbhCLOYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:24:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA65E64FB2;
        Fri, 12 Mar 2021 14:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615559079;
        bh=U9Mdik6MJZiAJm1+WFYyugBpevqEpCJ/z6c2wW4GCVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=czZ0WEVP5QqaFTXdcFpeROdqFty1WkuWKl2lG3rcFdTvS/EidIzFRsItF1ZRxOKkD
         DD+wtYT+jCfWKvgIhwsg7quKmnfPlZ9HCaZuCn44aqqC4neAlPbG6aLj3VaKogKehb
         6VvNbCdXmGoLX2cza1h0wFTjM9IKpk2U+2iAaCdnY55C4QU4tfff9yLXPUbSzLQ226
         49RIyLIlOnkCbHtnKp2aqNNbmGj2gkrweTAMNyVgJiupiBDIvXNyR6XuOtqKsq6l4U
         DQ/0XelIlO0UIC/jOlc+l208M1VuwDCxx5XE2cGjQhR3FGvUXBKSnyjXrj/VugwJYk
         ItXUMW42NsBGw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5883C40647; Fri, 12 Mar 2021 11:24:35 -0300 (-03)
Date:   Fri, 12 Mar 2021 11:24:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, acme@redhat.com,
        namhyung@kernel.org, jolsa@kernel.org,
        linux-perf-users@ghostprotocols.net
Subject: Re: [PATCH] perf-stat: introduce bperf, share hardware PMCs with BPF
Message-ID: <YEt5o7pSTleymwy1@kernel.org>
References: <20210312020257.197137-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312020257.197137-1-songliubraving@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 11, 2021 at 06:02:57PM -0800, Song Liu escreveu:
> perf uses performance monitoring counters (PMCs) to monitor system
> performance. The PMCs are limited hardware resources. For example,
> Intel CPUs have 3x fixed PMCs and 4x programmable PMCs per cpu.
> 
> Modern data center systems use these PMCs in many different ways:
> system level monitoring, (maybe nested) container level monitoring, per
> process monitoring, profiling (in sample mode), etc. In some cases,
> there are more active perf_events than available hardware PMCs. To allow
> all perf_events to have a chance to run, it is necessary to do expensive
> time multiplexing of events.
> 
> On the other hand, many monitoring tools count the common metrics (cycles,
> instructions). It is a waste to have multiple tools create multiple
> perf_events of "cycles" and occupy multiple PMCs.
> 
> bperf tries to reduce such wastes by allowing multiple perf_events of
> "cycles" or "instructions" (at different scopes) to share PMUs. Instead
> of having each perf-stat session to read its own perf_events, bperf uses
> BPF programs to read the perf_events and aggregate readings to BPF maps.
> Then, the perf-stat session(s) reads the values from these BPF maps.
> 
> Please refer to the comment before the definition of bperf_ops for the
> description of bperf architecture.
> 
> bperf is off by default. To enable it, pass --use-bpf option to perf-stat.
> bperf uses a BPF hashmap to share information about BPF programs and maps
> used by bperf. This map is pinned to bpffs. The default address is
> /sys/fs/bpf/bperf_attr_map. The user could change the address with option
> --attr-map.
> 
> ---
> Known limitations:
> 1. Do not support per cgroup events;
> 2. Do not support monitoring of BPF program (perf-stat -b);
> 3. Do not support event groups.

Cool stuff, but I think you can break this up into more self contained
patches, see below.

Apart from that, some suggestions/requests:

We need a shell 'perf test' that uses some synthetic workload so that we
can count events with/without --use-bpf (--bpf-counters is my
alternative name, see below), and then compare if the difference is
under some acceptable range.

As a followup patch we could have something like:

 perf config stat.bpf-counters=yes

That would make 'perf stat' use BPF counters for what it can, using the
default method for the non-supported targets, emitting some 'perf stat
-v' visible warning (i.e. a debug message), i.e. make it opt-in that the
user wants to use BPF counters for all that is possible at that point in
time.o

Thanks for working on this,

- Arnaldo
 
> The following commands have been tested:
> 
>    perf stat --use-bpf -e cycles -a
>    perf stat --use-bpf -e cycles -C 1,3,4
>    perf stat --use-bpf -e cycles -p 123
>    perf stat --use-bpf -e cycles -t 100,101
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/perf/Makefile.perf                      |   1 +
>  tools/perf/builtin-stat.c                     |  20 +-
>  tools/perf/util/bpf_counter.c                 | 552 +++++++++++++++++-
>  tools/perf/util/bpf_skel/bperf.h              |  14 +
>  tools/perf/util/bpf_skel/bperf_follower.bpf.c |  65 +++
>  tools/perf/util/bpf_skel/bperf_leader.bpf.c   |  46 ++
>  tools/perf/util/evsel.h                       |  20 +-
>  tools/perf/util/target.h                      |   4 +-
>  8 files changed, 712 insertions(+), 10 deletions(-)
>  create mode 100644 tools/perf/util/bpf_skel/bperf.h
>  create mode 100644 tools/perf/util/bpf_skel/bperf_follower.bpf.c
>  create mode 100644 tools/perf/util/bpf_skel/bperf_leader.bpf.c
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index f6e609673de2b..ca9aa08e85a1f 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1007,6 +1007,7 @@ python-clean:
>  SKEL_OUT := $(abspath $(OUTPUT)util/bpf_skel)
>  SKEL_TMP_OUT := $(abspath $(SKEL_OUT)/.tmp)
>  SKELETONS := $(SKEL_OUT)/bpf_prog_profiler.skel.h
> +SKELETONS += $(SKEL_OUT)/bperf_leader.skel.h $(SKEL_OUT)/bperf_follower.skel.h
>  
>  ifdef BUILD_BPF_SKEL
>  BPFTOOL := $(SKEL_TMP_OUT)/bootstrap/bpftool
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 2e2e4a8345ea2..34df713a8eea9 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -792,6 +792,12 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  	}
>  
>  	evlist__for_each_cpu (evsel_list, i, cpu) {
> +		/*
> +		 * bperf calls evsel__open_per_cpu() in bperf__load(), so
> +		 * no need to call it again here.
> +		 */
> +		if (target.use_bpf)
> +			break;
>  		affinity__set(&affinity, cpu);
>  
>  		evlist__for_each_entry(evsel_list, counter) {
> @@ -925,15 +931,15 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  	/*
>  	 * Enable counters and exec the command:
>  	 */
> -	t0 = rdclock();
> -	clock_gettime(CLOCK_MONOTONIC, &ref_time);
> -
>  	if (forks) {
>  		evlist__start_workload(evsel_list);
>  		err = enable_counters();
>  		if (err)
>  			return -1;
>  
> +		t0 = rdclock();
> +		clock_gettime(CLOCK_MONOTONIC, &ref_time);
> +
>  		if (interval || timeout || evlist__ctlfd_initialized(evsel_list))
>  			status = dispatch_events(forks, timeout, interval, &times);
>  		if (child_pid != -1) {
> @@ -954,6 +960,10 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  		err = enable_counters();
>  		if (err)
>  			return -1;
> +
> +		t0 = rdclock();
> +		clock_gettime(CLOCK_MONOTONIC, &ref_time);
> +
>  		status = dispatch_events(forks, timeout, interval, &times);
>  	}
>  

The above two hunks seems out of place, i.e. can they go to a different
patch and with an explanation about why this is needed?

> @@ -1146,6 +1156,10 @@ static struct option stat_options[] = {
>  #ifdef HAVE_BPF_SKEL
>  	OPT_STRING('b', "bpf-prog", &target.bpf_str, "bpf-prog-id",
>  		   "stat events on existing bpf program id"),
> +	OPT_BOOLEAN(0, "use-bpf", &target.use_bpf,
> +		    "use bpf program to count events"),
> +	OPT_STRING(0, "attr-map", &target.attr_map, "attr-map-path",
> +		   "path to perf_event_attr map"),

These need to be documented in tools/perf/Documentation/perf-stat.txt

Also please rename it to:

  --bpf-counters
  --bpf-attr-map

Andrii suggested prefixing with --bpf BPF related options in pahole, I
think this applies here as well.

>  #endif
>  	OPT_BOOLEAN('a', "all-cpus", &target.system_wide,
>  		    "system-wide collection from all CPUs"),
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> index 04f89120b3232..d232011ec8f26 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -5,6 +5,7 @@
>  #include <assert.h>
>  #include <limits.h>
>  #include <unistd.h>
> +#include <sys/file.h>
>  #include <sys/time.h>
>  #include <sys/resource.h>
>  #include <linux/err.h>
> @@ -18,8 +19,37 @@
>  #include "debug.h"
>  #include "evsel.h"
>  #include "target.h"
> +#include "cpumap.h"
> +#include "thread_map.h"
>  
>  #include "bpf_skel/bpf_prog_profiler.skel.h"
> +#include "bpf_skel/bperf_u.h"
> +#include "bpf_skel/bperf_leader.skel.h"
> +#include "bpf_skel/bperf_follower.skel.h"
> +
> +/*
> + * bperf uses a hashmap, the attr_map, to track all the leader programs.
> + * The hashmap is pinned in bpffs. flock() on this file is used to ensure
> + * no concurrent access to the attr_map.  The key of attr_map is struct
> + * perf_event_attr, and the value is struct bperf_attr_map_entry.
> + *
> + * struct bperf_attr_map_entry contains two __u32 IDs, bpf_link of the
> + * leader prog, and the diff_map. Each perf-stat session holds a reference
> + * to the bpf_link to make sure the leader prog is attached to sched_switch
> + * tracepoint.
> + *
> + * Since the hashmap only contains IDs of the bpf_link and diff_map, it
> + * does not hold any references to the leader program. Once all perf-stat
> + * sessions of these events exit, the leader prog, its maps, and the
> + * perf_events will be freed.
> + */
> +struct bperf_attr_map_entry {
> +	__u32 link_id;
> +	__u32 diff_map_id;
> +};
> +
> +#define DEFAULT_ATTR_MAP_PATH "/sys/fs/bpf/bperf_attr_map"

Humm bpf is already in the parent directory, perhaps we can have it as
just /sys/fs/bpf/perf_attr_map? Here 'counter' isn't applicable, I
guess, eventually we may want to use this for other purposes? ;-)

> +#define ATTR_MAP_SIZE 16
>  
>  static inline void *u64_to_ptr(__u64 ptr)
>  {
> @@ -274,17 +304,529 @@ struct bpf_counter_ops bpf_program_profiler_ops = {
>  	.install_pe = bpf_program_profiler__install_pe,
>  };
>  
> +static __u32 bpf_link_get_id(int fd)
> +{
> +	struct bpf_link_info link_info;
> +	__u32 link_info_len;
> +
> +	link_info_len = sizeof(link_info);

Can you combine declaration with attribution to make the code more
compact? i.e.:

	__u32 link_info_len = sizeof(link_info);


> +	memset(&link_info, 0, link_info_len);
> +	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
> +	return link_info.id;
> +}
> +
> +static __u32 bpf_link_get_prog_id(int fd)
> +{
> +	struct bpf_link_info link_info;
> +	__u32 link_info_len;
> +
> +	link_info_len = sizeof(link_info);

Ditto

> +	memset(&link_info, 0, link_info_len);
> +	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
> +	return link_info.prog_id;
> +}
> +
> +static __u32 bpf_map_get_id(int fd)
> +{
> +	struct bpf_map_info map_info;
> +	__u32 map_info_len;

Ditto.

> +	map_info_len = sizeof(map_info);
> +	memset(&map_info, 0, map_info_len);
> +	bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
> +	return map_info.id;
> +}
> +
> +static int bperf_lock_attr_map(struct target *target)
> +{
> +	const char *path = target->attr_map ? : DEFAULT_ATTR_MAP_PATH;
> +	int map_fd, err;
> +
> +	if (access(path, F_OK)) {
> +		map_fd = bpf_create_map(BPF_MAP_TYPE_HASH,
> +					sizeof(struct perf_event_attr),
> +					sizeof(struct bperf_attr_map_entry),

Also naming it as perf_event_attr_map_entry should make the equivalence
more explicit if albeit a bit longer, i.e.:

+		map_fd = bpf_create_map(BPF_MAP_TYPE_HASH,
+					sizeof(struct perf_event_attr),
+					sizeof(struct perf_event_attr_map_entry),

> +					ATTR_MAP_SIZE, 0);
> +		if (map_fd < 0)
> +			return -1;
> +
> +		err = bpf_obj_pin(map_fd, path);
> +		if (err) {
> +			/* someone pinned the map in parallel? */
> +			close(map_fd);
> +			map_fd = bpf_obj_get(path);
> +			if (map_fd < 0)
> +				return -1;
> +		}
> +	} else {
> +		map_fd = bpf_obj_get(path);
> +		if (map_fd < 0)
> +			return -1;
> +	}
> +
> +	err = flock(map_fd, LOCK_EX);
> +	if (err) {
> +		close(map_fd);
> +		return -1;
> +	}
> +	return map_fd;
> +}
> +
> +/* trigger the leader program on a cpu */
> +static int bperf_trigger_reading(int prog_fd, int cpu)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
> +			    .ctx_in = NULL,
> +			    .ctx_size_in = 0,
> +			    .flags = BPF_F_TEST_RUN_ON_CPU,
> +			    .cpu = cpu,
> +			    .retval = 0,
> +		);
> +
> +	return bpf_prog_test_run_opts(prog_fd, &opts);
> +}
> +
> +static int bperf_check_target(struct evsel *evsel,
> +			      struct target *target,
> +			      enum bperf_filter_type *filter_type,
> +			      __u32 *filter_entry_cnt)
> +{
> +	if (evsel->leader->core.nr_members > 1) {
> +		pr_err("bpf managed perf events do not yet support groups.\n");
> +		return -1;
> +	}
> +
> +	/* determine filter type based on target */
> +	if (target->system_wide) {
> +		*filter_type = BPERF_FILTER_GLOBAL;
> +		*filter_entry_cnt = 1;
> +	} else if (target->cpu_list) {
> +		*filter_type = BPERF_FILTER_CPU;
> +		*filter_entry_cnt = perf_cpu_map__nr(evsel__cpus(evsel));
> +	} else if (target->tid) {
> +		*filter_type = BPERF_FILTER_PID;
> +		*filter_entry_cnt = perf_thread_map__nr(evsel->core.threads);
> +	} else if (target->pid) {
> +		*filter_type = BPERF_FILTER_TGID;
> +		*filter_entry_cnt = perf_thread_map__nr(evsel->core.threads);
> +	} else {
> +		pr_err("bpf managed perf events do not yet support these targets.\n");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
> +				       struct bperf_attr_map_entry *entry)
> +{
> +	struct bperf_leader_bpf *skel = NULL;

Init it to NULL to then right away set it to the return of
bperf_leader_bpf__open?

see below

> +	struct perf_cpu_map *all_cpus;
> +	int link_fd, diff_map_fd, err;
> +	struct bpf_link *link = NULL;
> +
> +	skel = bperf_leader_bpf__open();

	struct bperf_leader_bpf *skel = bperf_leader_bpf__open();

> +	if (!skel) {
> +		pr_err("Failed to open leader skeleton\n");
> +		return -1;
> +	}
> +
> +	bpf_map__resize(skel->maps.events, libbpf_num_possible_cpus());
> +	err = bperf_leader_bpf__load(skel);
> +	if (err) {
> +		pr_err("Failed to load leader skeleton\n");
> +		goto out;
> +	}
> +
> +	err = -1;
> +	link = bpf_program__attach(skel->progs.on_switch);
> +	if (!link) {
> +		pr_err("Failed to attach leader program\n");
> +		goto out;
> +	}
> +
> +	all_cpus = perf_cpu_map__new(NULL);
> +	if (!all_cpus) {
> +		pr_err("Failed to open cpu_map for all cpus\n");
> +		goto out;
> +	}

If you reorder things maybe you can determine the number of possible
cpus from all_cpus?

> +
> +	link_fd = bpf_link__fd(link);
> +	diff_map_fd = bpf_map__fd(skel->maps.diff_readings);
> +	entry->link_id = bpf_link_get_id(link_fd);
> +	entry->diff_map_id = bpf_map_get_id(diff_map_fd);
> +	err = bpf_map_update_elem(attr_map_fd, &evsel->core.attr, entry, BPF_ANY);
> +	assert(err == 0);
> +
> +	evsel->bperf_leader_link_fd = bpf_link_get_fd_by_id(entry->link_id);
> +	assert(evsel->bperf_leader_link_fd >= 0);
> +
> +	/* save leader_skel for install_pe */
> +	evsel->leader_skel = skel;
> +	evsel__open_per_cpu(evsel, all_cpus, -1);
> +	perf_cpu_map__put(all_cpus);
> +
> +out:
> +	bperf_leader_bpf__destroy(skel);
> +	bpf_link__destroy(link);
> +	return err;
> +}
> +
> +static int bperf__load(struct evsel *evsel, struct target *target)
> +{
> +	struct bperf_attr_map_entry entry = {0xffffffff, 0xffffffff};
> +	int attr_map_fd, diff_map_fd = -1, err;
> +	enum bperf_filter_type filter_type;
> +	__u32 filter_entry_cnt, i;
> +
> +	if (bperf_check_target(evsel, target, &filter_type, &filter_entry_cnt))
> +		return -1;
> +
> +	evsel->bperf_leader_prog_fd = -1;
> +	evsel->bperf_leader_link_fd = -1;
> +
> +	/*
> +	 * Step 1: hold a fd on the leader program and the bpf_link, if
> +	 * the program is not already gone, reload the program.
> +	 * Use flock() to ensure exclusive access to the perf_event_attr
> +	 * map.
> +	 */
> +	attr_map_fd = bperf_lock_attr_map(target);
> +	if (attr_map_fd < 0) {
> +		pr_err("Failed to lock perf_event_attr map\n");
> +		return -1;
> +	}
> +
> +	err = bpf_map_lookup_elem(attr_map_fd, &evsel->core.attr, &entry);
> +	if (err) {
> +		err = bpf_map_update_elem(attr_map_fd, &evsel->core.attr, &entry, BPF_ANY);
> +		if (err)
> +			goto out;
> +	}
> +
> +	evsel->bperf_leader_link_fd = bpf_link_get_fd_by_id(entry.link_id);
> +	if (evsel->bperf_leader_link_fd < 0 &&
> +	    bperf_reload_leader_program(evsel, attr_map_fd, &entry))
> +		goto out;
> +
> +	/*
> +	 * The bpf_link holds reference to the leader program, and the
> +	 * leader program holds reference to the maps. Therefore, if
> +	 * link_id is valid, diff_map_id should also be valid.
> +	 */
> +	evsel->bperf_leader_prog_fd = bpf_prog_get_fd_by_id(
> +		bpf_link_get_prog_id(evsel->bperf_leader_link_fd));
> +	assert(evsel->bperf_leader_prog_fd >= 0);
> +
> +	diff_map_fd = bpf_map_get_fd_by_id(entry.diff_map_id);
> +	assert(diff_map_fd >= 0);
> +
> +	/*
> +	 * bperf uses BPF_PROG_TEST_RUN to get accurate reading. Check
> +	 * whether the kernel support it
> +	 */
> +	err = bperf_trigger_reading(evsel->bperf_leader_prog_fd, 0);
> +	if (err) {
> +		pr_err("The kernel does not support test_run for raw_tp BPF programs.\n"
> +		       "Therefore, --use-bpf might show inaccurate readings\n");
> +		goto out;
> +	}
> +
> +	/* Step 2: load the follower skeleton */
> +	evsel->follower_skel = bperf_follower_bpf__open();
> +	if (!evsel->follower_skel) {
> +		pr_err("Failed to open follower skeleton\n");
> +		goto out;
> +	}
> +
> +	/* attach fexit program to the leader program */
> +	bpf_program__set_attach_target(evsel->follower_skel->progs.fexit_XXX,
> +				       evsel->bperf_leader_prog_fd, "on_switch");
> +
> +	/* connect to leader diff_reading map */
> +	bpf_map__reuse_fd(evsel->follower_skel->maps.diff_readings, diff_map_fd);
> +
> +	/* set up reading map */
> +	bpf_map__set_max_entries(evsel->follower_skel->maps.accum_readings,
> +				 filter_entry_cnt);
> +	/* set up follower filter based on target */
> +	bpf_map__set_max_entries(evsel->follower_skel->maps.filter,
> +				 filter_entry_cnt);
> +	err = bperf_follower_bpf__load(evsel->follower_skel);
> +	if (err) {
> +		pr_err("Failed to load follower skeleton\n");
> +		bperf_follower_bpf__destroy(evsel->follower_skel);
> +		evsel->follower_skel = NULL;
> +		goto out;
> +	}
> +
> +	for (i = 0; i < filter_entry_cnt; i++) {
> +		int filter_map_fd;
> +		__u32 key;
> +
> +		if (filter_type == BPERF_FILTER_PID ||
> +		    filter_type == BPERF_FILTER_TGID)
> +			key = evsel->core.threads->map[i].pid;
> +		else if (filter_type == BPERF_FILTER_CPU)
> +			key = evsel->core.cpus->map[i];
> +		else
> +			break;
> +
> +		filter_map_fd = bpf_map__fd(evsel->follower_skel->maps.filter);
> +		bpf_map_update_elem(filter_map_fd, &key, &i, BPF_ANY);
> +	}
> +
> +	evsel->follower_skel->bss->type = filter_type;
> +
> +out:
> +	if (err && evsel->bperf_leader_link_fd >= 0)
> +		close(evsel->bperf_leader_link_fd);
> +	if (err && evsel->bperf_leader_prog_fd >= 0)
> +		close(evsel->bperf_leader_prog_fd);
> +	if (diff_map_fd >= 0)
> +		close(diff_map_fd);
> +
> +	flock(attr_map_fd, LOCK_UN);
> +	close(attr_map_fd);
> +
> +	return err;
> +}
> +
> +static int bperf__install_pe(struct evsel *evsel, int cpu, int fd)
> +{
> +	struct bperf_leader_bpf *skel = evsel->leader_skel;
> +
> +	return bpf_map_update_elem(bpf_map__fd(skel->maps.events),
> +				   &cpu, &fd, BPF_ANY);
> +}
> +
> +/*
> + * trigger the leader prog on each cpu, so the accum_reading map could get
> + * the latest readings.
> + */
> +static int bperf_sync_counters(struct evsel *evsel)
> +{
> +	struct perf_cpu_map *all_cpus = perf_cpu_map__new(NULL);
> +	int num_cpu, i, cpu;
> +
> +	if (!all_cpus)
> +		return -1;
> +
> +	num_cpu = all_cpus->nr;
> +	for (i = 0; i < num_cpu; i++) {
> +		cpu = all_cpus->map[i];
> +		bperf_trigger_reading(evsel->bperf_leader_prog_fd, cpu);
> +	}
> +	return 0;
> +}
> +
> +static int bperf__enable(struct evsel *evsel)
> +{
> +	struct bperf_follower_bpf *skel = evsel->follower_skel;
> +	__u32 num_cpu_bpf = libbpf_num_possible_cpus();
> +	struct bpf_perf_event_value values[num_cpu_bpf];
> +	int err, i, entry_cnt;
> +
> +	err = bperf_follower_bpf__attach(evsel->follower_skel);
> +	if (err)
> +		return -1;
> +
> +	/*
> +	 * Attahcing the skeleton takes non-trivial time (0.2s+ on a kernel

Attaching

> +	 * with some debug options enabled). This shows as a longer first
> +	 * interval:
> +	 *
> +	 * # perf stat -e cycles -a -I 1000
> +	 * #           time             counts unit events
> +	 *      1.267634674     26,259,166,523      cycles
> +	 *      2.271637827     22,550,822,286      cycles
> +	 *      3.275406553     22,852,583,744      cycles
> +	 *
> +	 * Fix this by zeroing accum_readings after attaching the program.
> +	 */
> +	bperf_sync_counters(evsel);
> +	entry_cnt = bpf_map__max_entries(skel->maps.accum_readings);
> +	memset(values, 0, sizeof(struct bpf_perf_event_value) * num_cpu_bpf);
> +
> +	for (i = 0; i < entry_cnt; i++) {
> +		bpf_map_update_elem(bpf_map__fd(skel->maps.accum_readings),
> +				    &i, values, BPF_ANY);
> +	}
> +	return 0;
> +}
> +
> +static int bperf__read(struct evsel *evsel)
> +{
> +	struct bperf_follower_bpf *skel = evsel->follower_skel;
> +	__u32 num_cpu_bpf = libbpf_num_possible_cpus();
> +	struct bpf_perf_event_value values[num_cpu_bpf];
> +	static struct perf_cpu_map *all_cpus;
> +	int reading_map_fd, err = 0;
> +	__u32 i, j, num_cpu;
> +
> +	if (!all_cpus) {
> +		all_cpus = perf_cpu_map__new(NULL);
> +		if (!all_cpus)
> +			return -1;
> +	}
> +
> +	bperf_sync_counters(evsel);
> +	reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
> +
> +	for (i = 0; i < bpf_map__max_entries(skel->maps.accum_readings); i++) {
> +		__u32 cpu;
> +
> +		err = bpf_map_lookup_elem(reading_map_fd, &i, values);
> +		if (err)
> +			goto out;
> +		switch (evsel->follower_skel->bss->type) {
> +		case BPERF_FILTER_GLOBAL:
> +			assert(i == 0);
> +
> +			num_cpu = all_cpus->nr;
> +			for (j = 0; j < num_cpu; j++) {
> +				cpu = all_cpus->map[j];
> +				perf_counts(evsel->counts, cpu, 0)->val = values[cpu].counter;
> +				perf_counts(evsel->counts, cpu, 0)->ena = values[cpu].enabled;
> +				perf_counts(evsel->counts, cpu, 0)->run = values[cpu].running;
> +			}
> +			break;
> +		case BPERF_FILTER_CPU:
> +			cpu = evsel->core.cpus->map[i];
> +			perf_counts(evsel->counts, i, 0)->val = values[cpu].counter;
> +			perf_counts(evsel->counts, i, 0)->ena = values[cpu].enabled;
> +			perf_counts(evsel->counts, i, 0)->run = values[cpu].running;
> +			break;
> +		case BPERF_FILTER_PID:
> +		case BPERF_FILTER_TGID:
> +			perf_counts(evsel->counts, 0, i)->val = 0;
> +			perf_counts(evsel->counts, 0, i)->ena = 0;
> +			perf_counts(evsel->counts, 0, i)->run = 0;
> +
> +			for (cpu = 0; cpu < num_cpu_bpf; cpu++) {
> +				perf_counts(evsel->counts, 0, i)->val += values[cpu].counter;
> +				perf_counts(evsel->counts, 0, i)->ena += values[cpu].enabled;
> +				perf_counts(evsel->counts, 0, i)->run += values[cpu].running;
> +			}
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +out:
> +	return err;
> +}
> +
> +static int bperf__destroy(struct evsel *evsel)
> +{
> +	bperf_follower_bpf__destroy(evsel->follower_skel);
> +	close(evsel->bperf_leader_prog_fd);
> +	close(evsel->bperf_leader_link_fd);
> +	return 0;
> +}
> +
> +/*
> + * bperf: share hardware PMCs with BPF
> + *
> + * perf uses performance monitoring counters (PMC) to monitor system
> + * performance. The PMCs are limited hardware resources. For example,
> + * Intel CPUs have 3x fixed PMCs and 4x programmable PMCs per cpu.
> + *
> + * Modern data center systems use these PMCs in many different ways:
> + * system level monitoring, (maybe nested) container level monitoring, per
> + * process monitoring, profiling (in sample mode), etc. In some cases,
> + * there are more active perf_events than available hardware PMCs. To allow
> + * all perf_events to have a chance to run, it is necessary to do expensive
> + * time multiplexing of events.
> + *
> + * On the other hand, many monitoring tools count the common metrics
> + * (cycles, instructions). It is a waste to have multiple tools create
> + * multiple perf_events of "cycles" and occupy multiple PMCs.
> + *
> + * bperf tries to reduce such wastes by allowing multiple perf_events of
> + * "cycles" or "instructions" (at different scopes) to share PMUs. Instead
> + * of having each perf-stat session to read its own perf_events, bperf uses
> + * BPF programs to read the perf_events and aggregate readings to BPF maps.
> + * Then, the perf-stat session(s) reads the values from these BPF maps.
> + *
> + *                                ||
> + *       shared progs and maps <- || -> per session progs and maps
> + *                                ||
> + *   ---------------              ||
> + *   | perf_events |              ||
> + *   ---------------       fexit  ||      -----------------
> + *          |             --------||----> | follower prog |
> + *       --------------- /        || ---  -----------------
> + * cs -> | leader prog |/         ||/        |         |
> + *   --> ---------------         /||  --------------  ------------------
> + *  /       |         |         / ||  | filter map |  | accum_readings |
> + * /  ------------  ------------  ||  --------------  ------------------
> + * |  | prev map |  | diff map |  ||                        |
> + * |  ------------  ------------  ||                        |
> + *  \                             ||                        |
> + * = \ ==================================================== | ============
> + *    \                                                    /   user space
> + *     \                                                  /
> + *      \                                                /
> + *    BPF_PROG_TEST_RUN                    BPF_MAP_LOOKUP_ELEM
> + *        \                                            /
> + *         \                                          /
> + *          \------  perf-stat ----------------------/
> + *
> + * The figure above shows the architecture of bperf. Note that the figure
> + * is divided into 3 regions: shared progs and maps (top left), per session
> + * progs and maps (top right), and user space (bottom).
> + *
> + * The leader prog is triggered on each context switch (cs). The leader
> + * prog reads perf_events and stores the difference (current_reading -
> + * previous_reading) to the diff map. For the same metric, e.g. "cycles",
> + * multiple perf-stat sessions share the same leader prog.
> + *
> + * Each perf-stat session creates a follower prog as fexit program to the
> + * leader prog. It is possible to attach up to BPF_MAX_TRAMP_PROGS (38)
> + * follower progs to the same leader prog. The follower prog checks current
> + * task and processor ID to decide whether to add the value from the diff
> + * map to its accumulated reading map (accum_readings).
> + *
> + * Finally, perf-stat user space reads the value from accum_reading map.
> + *
> + * Besides context switch, it is also necessary to trigger the leader prog
> + * before perf-stat reads the value. Otherwise, the accum_reading map may
> + * not have the latest reading from the perf_events. This is achieved by
> + * triggering the event via sys_bpf(BPF_PROG_TEST_RUN) to each CPU.
> + *
> + * Comment before the definition of struct bperf_attr_map_entry describes
> + * how different sessions of perf-stat share information about the leader
> + * prog.
> + */
> +
> +struct bpf_counter_ops bperf_ops = {
> +	.load       = bperf__load,
> +	.enable     = bperf__enable,
> +	.read       = bperf__read,
> +	.install_pe = bperf__install_pe,
> +	.destroy    = bperf__destroy,
> +};
> +
> +static inline bool bpf_counter_skip(struct evsel *evsel)
> +{
> +	return list_empty(&evsel->bpf_counter_list) &&
> +		evsel->follower_skel == NULL;
> +}
> +
>  int bpf_counter__install_pe(struct evsel *evsel, int cpu, int fd)
>  {
> -	if (list_empty(&evsel->bpf_counter_list))
> +	if (bpf_counter_skip(evsel))
>  		return 0;
>  	return evsel->bpf_counter_ops->install_pe(evsel, cpu, fd);
>  }
>  
>  int bpf_counter__load(struct evsel *evsel, struct target *target)
>  {
> -	if (target__has_bpf(target))
> +	if (target->bpf_str)
>  		evsel->bpf_counter_ops = &bpf_program_profiler_ops;
> +	else if (target->use_bpf)
> +		evsel->bpf_counter_ops = &bperf_ops;
>  
>  	if (evsel->bpf_counter_ops)
>  		return evsel->bpf_counter_ops->load(evsel, target);
> @@ -293,21 +835,21 @@ int bpf_counter__load(struct evsel *evsel, struct target *target)
>  
>  int bpf_counter__enable(struct evsel *evsel)
>  {
> -	if (list_empty(&evsel->bpf_counter_list))
> +	if (bpf_counter_skip(evsel))
>  		return 0;
>  	return evsel->bpf_counter_ops->enable(evsel);
>  }
>  
>  int bpf_counter__read(struct evsel *evsel)
>  {
> -	if (list_empty(&evsel->bpf_counter_list))
> +	if (bpf_counter_skip(evsel))
>  		return -EAGAIN;
>  	return evsel->bpf_counter_ops->read(evsel);
>  }
>  
>  void bpf_counter__destroy(struct evsel *evsel)
>  {
> -	if (list_empty(&evsel->bpf_counter_list))
> +	if (bpf_counter_skip(evsel))
>  		return;
>  	evsel->bpf_counter_ops->destroy(evsel);
>  	evsel->bpf_counter_ops = NULL;
> diff --git a/tools/perf/util/bpf_skel/bperf.h b/tools/perf/util/bpf_skel/bperf.h
> new file mode 100644
> index 0000000000000..186a5551ddb9d
> --- /dev/null
> +++ b/tools/perf/util/bpf_skel/bperf.h
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +// Copyright (c) 2021 Facebook
> +
> +#ifndef __BPERF_STAT_H
> +#define __BPERF_STAT_H
> +
> +typedef struct {
> +	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(struct bpf_perf_event_value));
> +	__uint(max_entries, 1);
> +} reading_map;
> +
> +#endif /* __BPERF_STAT_H */
> diff --git a/tools/perf/util/bpf_skel/bperf_follower.bpf.c b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
> new file mode 100644
> index 0000000000000..7535d9557ab9a
> --- /dev/null
> +++ b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +// Copyright (c) 2021 Facebook
> +#include <linux/bpf.h>
> +#include <linux/perf_event.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bperf.h"
> +#include "bperf_u.h"
> +
> +reading_map diff_readings SEC(".maps");
> +reading_map accum_readings SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(__u32));
> +} filter SEC(".maps");
> +
> +enum bperf_filter_type type = 0;
> +
> +SEC("fexit/XXX")
> +int BPF_PROG(fexit_XXX)
> +{
> +	struct bpf_perf_event_value *diff_val, *accum_val;
> +	__u32 filter_key, zero = 0;
> +	__u32 *accum_key;
> +
> +	switch (type) {
> +	case BPERF_FILTER_GLOBAL:
> +		accum_key = &zero;
> +		goto do_add;
> +	case BPERF_FILTER_CPU:
> +		filter_key = bpf_get_smp_processor_id();
> +		break;
> +	case BPERF_FILTER_PID:
> +		filter_key = bpf_get_current_pid_tgid() & 0xffffffff;
> +		break;
> +	case BPERF_FILTER_TGID:
> +		filter_key = bpf_get_current_pid_tgid() >> 32;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	accum_key = bpf_map_lookup_elem(&filter, &filter_key);
> +	if (!accum_key)
> +		return 0;
> +
> +do_add:
> +	diff_val = bpf_map_lookup_elem(&diff_readings, &zero);
> +	if (!diff_val)
> +		return 0;
> +
> +	accum_val = bpf_map_lookup_elem(&accum_readings, accum_key);
> +	if (!accum_val)
> +		return 0;
> +
> +	accum_val->counter += diff_val->counter;
> +	accum_val->enabled += diff_val->enabled;
> +	accum_val->running += diff_val->running;
> +
> +	return 0;
> +}
> +
> +char LICENSE[] SEC("license") = "Dual BSD/GPL";
> diff --git a/tools/perf/util/bpf_skel/bperf_leader.bpf.c b/tools/perf/util/bpf_skel/bperf_leader.bpf.c
> new file mode 100644
> index 0000000000000..4f70d1459e86c
> --- /dev/null
> +++ b/tools/perf/util/bpf_skel/bperf_leader.bpf.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +// Copyright (c) 2021 Facebook
> +#include <linux/bpf.h>
> +#include <linux/perf_event.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bperf.h"
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(int));
> +	__uint(map_flags, BPF_F_PRESERVE_ELEMS);
> +} events SEC(".maps");
> +
> +reading_map prev_readings SEC(".maps");
> +reading_map diff_readings SEC(".maps");
> +
> +SEC("raw_tp/sched_switch")
> +int BPF_PROG(on_switch)
> +{
> +	struct bpf_perf_event_value val, *prev_val, *diff_val;
> +	__u32 key = bpf_get_smp_processor_id();
> +	__u32 zero = 0;
> +	long err;
> +
> +	prev_val = bpf_map_lookup_elem(&prev_readings, &zero);
> +	if (!prev_val)
> +		return 0;
> +
> +	diff_val = bpf_map_lookup_elem(&diff_readings, &zero);
> +	if (!diff_val)
> +		return 0;
> +
> +	err = bpf_perf_event_read_value(&events, key, &val, sizeof(val));
> +	if (err)
> +		return 0;
> +
> +	diff_val->counter = val.counter - prev_val->counter;
> +	diff_val->enabled = val.enabled - prev_val->enabled;
> +	diff_val->running = val.running - prev_val->running;
> +	*prev_val = val;
> +	return 0;
> +}
> +
> +char LICENSE[] SEC("license") = "Dual BSD/GPL";
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 6026487353dd8..dd4f56f9cfdf5 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -20,6 +20,8 @@ union perf_event;
>  struct bpf_counter_ops;
>  struct target;
>  struct hashmap;
> +struct bperf_leader_bpf;
> +struct bperf_follower_bpf;
>  
>  typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
>  
> @@ -130,8 +132,24 @@ struct evsel {
>  	 * See also evsel__has_callchain().
>  	 */
>  	__u64			synth_sample_type;
> -	struct list_head	bpf_counter_list;
> +
> +	/*
> +	 * bpf_counter_ops serves two use cases:
> +	 *   1. perf-stat -b          counting events used byBPF programs
> +	 *   2. perf-stat --use-bpf   use BPF programs to aggregate counts
> +	 */
>  	struct bpf_counter_ops	*bpf_counter_ops;
> +
> +	/* for perf-stat -b */
> +	struct list_head	bpf_counter_list;
> +
> +	/* for perf-stat --use-bpf */
> +	int			bperf_leader_prog_fd;
> +	int			bperf_leader_link_fd;
> +	union {
> +		struct bperf_leader_bpf *leader_skel;
> +		struct bperf_follower_bpf *follower_skel;
> +	};
>  };
>  
>  struct perf_missing_features {
> diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
> index f132c6c2eef81..1bce3eb28ef25 100644
> --- a/tools/perf/util/target.h
> +++ b/tools/perf/util/target.h
> @@ -16,6 +16,8 @@ struct target {
>  	bool	     uses_mmap;
>  	bool	     default_per_cpu;
>  	bool	     per_thread;
> +	bool	     use_bpf;
> +	const char   *attr_map;
>  };
>  
>  enum target_errno {
> @@ -66,7 +68,7 @@ static inline bool target__has_cpu(struct target *target)
>  
>  static inline bool target__has_bpf(struct target *target)
>  {
> -	return target->bpf_str;
> +	return target->bpf_str || target->use_bpf;
>  }
>  
>  static inline bool target__none(struct target *target)
> -- 
> 2.24.1
> 

-- 

- Arnaldo
