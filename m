Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E27339529
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhCLRh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:37:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:58242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231789AbhCLRhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:37:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 997E564E01;
        Fri, 12 Mar 2021 17:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615570671;
        bh=sVTX2nXtf8bLCJH9pO0QU7Jzi8Q87k/N92xZaSSuqFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QF2Mmd6i9vD2ZiN4jA1w8Qs9W2FEvb3PFnK3jUlNSqVonkAFSZnuM4o6GjeYfR0uv
         P4mkU3FdZeWed/ckfPxoIn82hNmnCyQX5Zb87Pls0etrx6NPoteN3x1kudi0zYjlrq
         CAkTvXMftpexg+1BpxcubHx/XUgy/EIbc7phX2I7Tr7fIxcLO167imAGTjb5xwA8gK
         RsUBKytNyXNpkOGINW5JC/z7ahnyBirhdOococYcMq98m2wVuND7WSqalrrHFMCrk7
         9hSLf+sXJZ5OweQpV3ceZP6YnWIlia+JUap/AviQ8tevf79W+2DzA7g9J8Tg42P+1C
         S++g9avDTwgsQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 78B6640647; Fri, 12 Mar 2021 14:37:47 -0300 (-03)
Date:   Fri, 12 Mar 2021 14:37:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@redhat.com" <acme@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "linux-perf-users@ghostprotocols.net" 
        <linux-perf-users@ghostprotocols.net>
Subject: Re: [PATCH] perf-stat: introduce bperf, share hardware PMCs with BPF
Message-ID: <YEum6/fNYIbPnun4@kernel.org>
References: <20210312020257.197137-1-songliubraving@fb.com>
 <YEt5o7pSTleymwy1@kernel.org>
 <C8208C48-2EFE-4186-865D-3E90E4BFCB30@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C8208C48-2EFE-4186-865D-3E90E4BFCB30@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 12, 2021 at 04:07:42PM +0000, Song Liu escreveu:
> 
> 
> > On Mar 12, 2021, at 6:24 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > Em Thu, Mar 11, 2021 at 06:02:57PM -0800, Song Liu escreveu:
> >> perf uses performance monitoring counters (PMCs) to monitor system
> >> performance. The PMCs are limited hardware resources. For example,
> >> Intel CPUs have 3x fixed PMCs and 4x programmable PMCs per cpu.
> >> 
> >> Modern data center systems use these PMCs in many different ways:
> >> system level monitoring, (maybe nested) container level monitoring, per
> >> process monitoring, profiling (in sample mode), etc. In some cases,
> >> there are more active perf_events than available hardware PMCs. To allow
> >> all perf_events to have a chance to run, it is necessary to do expensive
> >> time multiplexing of events.
> >> 
> >> On the other hand, many monitoring tools count the common metrics (cycles,
> >> instructions). It is a waste to have multiple tools create multiple
> >> perf_events of "cycles" and occupy multiple PMCs.
> >> 
> >> bperf tries to reduce such wastes by allowing multiple perf_events of
> >> "cycles" or "instructions" (at different scopes) to share PMUs. Instead
> >> of having each perf-stat session to read its own perf_events, bperf uses
> >> BPF programs to read the perf_events and aggregate readings to BPF maps.
> >> Then, the perf-stat session(s) reads the values from these BPF maps.
> >> 
> >> Please refer to the comment before the definition of bperf_ops for the
> >> description of bperf architecture.
> >> 
> >> bperf is off by default. To enable it, pass --use-bpf option to perf-stat.
> >> bperf uses a BPF hashmap to share information about BPF programs and maps
> >> used by bperf. This map is pinned to bpffs. The default address is
> >> /sys/fs/bpf/bperf_attr_map. The user could change the address with option
> >> --attr-map.
> >> 
> >> ---
> >> Known limitations:
> >> 1. Do not support per cgroup events;
> >> 2. Do not support monitoring of BPF program (perf-stat -b);
> >> 3. Do not support event groups.
> > 
> > Cool stuff, but I think you can break this up into more self contained
> > patches, see below.
> > 
> > Apart from that, some suggestions/requests:
> > 
> > We need a shell 'perf test' that uses some synthetic workload so that we
> > can count events with/without --use-bpf (--bpf-counters is my
> > alternative name, see below), and then compare if the difference is
> > under some acceptable range.
> 
> Yes, "perf test" makes sense. Would this be the extension of current 
> perf-test command? Or a new set of tests?

Extension, please look at:

tools/perf/tests/shell/

Those are shell script based tests, that will be run by 'perf test'
right after the other, C based ones.
 
> > As a followup patch we could have something like:
> > 
> > perf config stat.bpf-counters=yes
> > 
> > That would make 'perf stat' use BPF counters for what it can, using the
> > default method for the non-supported targets, emitting some 'perf stat
> > -v' visible warning (i.e. a debug message), i.e. make it opt-in that the
> > user wants to use BPF counters for all that is possible at that point in
> > time.o
 
> Yes, the fallback mechanism will be very helpful. I also have ideas on
> setting a list for "common events", and only use BPF for the common 
> events. Not common events should just use the original method. 

Yeah, transition period, as the need arises, more can be done, with the
pre-existing method being the fallback or better than any BPF based
mechanism already.
 
> > Thanks for working on this,
> > 
> >> The following commands have been tested:
> >> 
> >>   perf stat --use-bpf -e cycles -a
> >>   perf stat --use-bpf -e cycles -C 1,3,4
> >>   perf stat --use-bpf -e cycles -p 123
> >>   perf stat --use-bpf -e cycles -t 100,101
> >> 
> >> Signed-off-by: Song Liu <songliubraving@fb.com>
> >> ---
> >> tools/perf/Makefile.perf                      |   1 +
> >> tools/perf/builtin-stat.c                     |  20 +-
> >> tools/perf/util/bpf_counter.c                 | 552 +++++++++++++++++-
> >> tools/perf/util/bpf_skel/bperf.h              |  14 +
> >> tools/perf/util/bpf_skel/bperf_follower.bpf.c |  65 +++
> >> tools/perf/util/bpf_skel/bperf_leader.bpf.c   |  46 ++
> >> tools/perf/util/evsel.h                       |  20 +-
> >> tools/perf/util/target.h                      |   4 +-
> >> 8 files changed, 712 insertions(+), 10 deletions(-)
> >> create mode 100644 tools/perf/util/bpf_skel/bperf.h
> >> create mode 100644 tools/perf/util/bpf_skel/bperf_follower.bpf.c
> >> create mode 100644 tools/perf/util/bpf_skel/bperf_leader.bpf.c
> >> 
> >> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> >> index f6e609673de2b..ca9aa08e85a1f 100644
> >> --- a/tools/perf/Makefile.perf
> >> +++ b/tools/perf/Makefile.perf
> >> @@ -1007,6 +1007,7 @@ python-clean:
> >> SKEL_OUT := $(abspath $(OUTPUT)util/bpf_skel)
> >> SKEL_TMP_OUT := $(abspath $(SKEL_OUT)/.tmp)
> >> SKELETONS := $(SKEL_OUT)/bpf_prog_profiler.skel.h
> >> +SKELETONS += $(SKEL_OUT)/bperf_leader.skel.h $(SKEL_OUT)/bperf_follower.skel.h
> >> 
> >> ifdef BUILD_BPF_SKEL
> >> BPFTOOL := $(SKEL_TMP_OUT)/bootstrap/bpftool
> >> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> >> index 2e2e4a8345ea2..34df713a8eea9 100644
> >> --- a/tools/perf/builtin-stat.c
> >> +++ b/tools/perf/builtin-stat.c
> >> @@ -792,6 +792,12 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> >> 	}
> >> 
> >> 	evlist__for_each_cpu (evsel_list, i, cpu) {
> >> +		/*
> >> +		 * bperf calls evsel__open_per_cpu() in bperf__load(), so
> >> +		 * no need to call it again here.
> >> +		 */
> >> +		if (target.use_bpf)
> >> +			break;
> >> 		affinity__set(&affinity, cpu);
> >> 
> >> 		evlist__for_each_entry(evsel_list, counter) {
> >> @@ -925,15 +931,15 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> >> 	/*
> >> 	 * Enable counters and exec the command:
> >> 	 */
> >> -	t0 = rdclock();
> >> -	clock_gettime(CLOCK_MONOTONIC, &ref_time);
> >> -
> >> 	if (forks) {
> >> 		evlist__start_workload(evsel_list);
> >> 		err = enable_counters();
> >> 		if (err)
> >> 			return -1;
> >> 
> >> +		t0 = rdclock();
> >> +		clock_gettime(CLOCK_MONOTONIC, &ref_time);
> >> +
> >> 		if (interval || timeout || evlist__ctlfd_initialized(evsel_list))
> >> 			status = dispatch_events(forks, timeout, interval, &times);
> >> 		if (child_pid != -1) {
> >> @@ -954,6 +960,10 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> >> 		err = enable_counters();
> >> 		if (err)
> >> 			return -1;
> >> +
> >> +		t0 = rdclock();
> >> +		clock_gettime(CLOCK_MONOTONIC, &ref_time);
> >> +
> >> 		status = dispatch_events(forks, timeout, interval, &times);
> >> 	}
> >> 
> > 
> > The above two hunks seems out of place, i.e. can they go to a different
> > patch and with an explanation about why this is needed?
 
> Yeah, make sense. I will split them to a separate patch. 

Ok
 
> >> @@ -1146,6 +1156,10 @@ static struct option stat_options[] = {
> >> #ifdef HAVE_BPF_SKEL
> >> 	OPT_STRING('b', "bpf-prog", &target.bpf_str, "bpf-prog-id",
> >> 		   "stat events on existing bpf program id"),
> >> +	OPT_BOOLEAN(0, "use-bpf", &target.use_bpf,
> >> +		    "use bpf program to count events"),
> >> +	OPT_STRING(0, "attr-map", &target.attr_map, "attr-map-path",
> >> +		   "path to perf_event_attr map"),
> > 
> > These need to be documented in tools/perf/Documentation/perf-stat.txt
> > 
> > Also please rename it to:
> > 
> >  --bpf-counters
> >  --bpf-attr-map
> > 
> > Andrii suggested prefixing with --bpf BPF related options in pahole, I
> > think this applies here as well.
> 
> Will change it in v2. 
 
Ok

> >> #endif
> >> 	OPT_BOOLEAN('a', "all-cpus", &target.system_wide,
> >> 		    "system-wide collection from all CPUs"),
> >> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> >> index 04f89120b3232..d232011ec8f26 100644
> >> --- a/tools/perf/util/bpf_counter.c
> >> +++ b/tools/perf/util/bpf_counter.c
> >> @@ -5,6 +5,7 @@
> >> #include <assert.h>
> >> #include <limits.h>
> >> #include <unistd.h>
> >> +#include <sys/file.h>
> >> #include <sys/time.h>
> >> #include <sys/resource.h>
> >> #include <linux/err.h>
> >> @@ -18,8 +19,37 @@
> >> #include "debug.h"
> >> #include "evsel.h"
> >> #include "target.h"
> >> +#include "cpumap.h"
> >> +#include "thread_map.h"
> >> 
> >> #include "bpf_skel/bpf_prog_profiler.skel.h"
> >> +#include "bpf_skel/bperf_u.h"
> >> +#include "bpf_skel/bperf_leader.skel.h"
> >> +#include "bpf_skel/bperf_follower.skel.h"
> >> +
> >> +/*
> >> + * bperf uses a hashmap, the attr_map, to track all the leader programs.
> >> + * The hashmap is pinned in bpffs. flock() on this file is used to ensure
> >> + * no concurrent access to the attr_map.  The key of attr_map is struct
> >> + * perf_event_attr, and the value is struct bperf_attr_map_entry.
> >> + *
> >> + * struct bperf_attr_map_entry contains two __u32 IDs, bpf_link of the
> >> + * leader prog, and the diff_map. Each perf-stat session holds a reference
> >> + * to the bpf_link to make sure the leader prog is attached to sched_switch
> >> + * tracepoint.
> >> + *
> >> + * Since the hashmap only contains IDs of the bpf_link and diff_map, it
> >> + * does not hold any references to the leader program. Once all perf-stat
> >> + * sessions of these events exit, the leader prog, its maps, and the
> >> + * perf_events will be freed.
> >> + */
> >> +struct bperf_attr_map_entry {
> >> +	__u32 link_id;
> >> +	__u32 diff_map_id;
> >> +};
> >> +
> >> +#define DEFAULT_ATTR_MAP_PATH "/sys/fs/bpf/bperf_attr_map"
> > 
> > Humm bpf is already in the parent directory, perhaps we can have it as
> > just /sys/fs/bpf/perf_attr_map? Here 'counter' isn't applicable, I
> > guess, eventually we may want to use this for other purposes? ;-)
> 
> Do you mean sharing PMCs with sampling events? Well, I do have it on my
> list for 2022. ;-)

Right, its just a little joke about how everything will end up being a
BPF program attached at the right place :-)
 
> > 
> >> +#define ATTR_MAP_SIZE 16
> >> 
> >> static inline void *u64_to_ptr(__u64 ptr)
> >> {
> >> @@ -274,17 +304,529 @@ struct bpf_counter_ops bpf_program_profiler_ops = {
> >> 	.install_pe = bpf_program_profiler__install_pe,
> >> };
> >> 
> >> +static __u32 bpf_link_get_id(int fd)
> >> +{
> >> +	struct bpf_link_info link_info;
> >> +	__u32 link_info_len;
> >> +
> >> +	link_info_len = sizeof(link_info);
> > 
> > Can you combine declaration with attribution to make the code more
> > compact? i.e.:
> > 
> > 	__u32 link_info_len = sizeof(link_info);
> > 
> > 
> >> +	memset(&link_info, 0, link_info_len);
> >> +	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
> >> +	return link_info.id;
> >> +}
> >> +
> >> +static __u32 bpf_link_get_prog_id(int fd)
> >> +{
> >> +	struct bpf_link_info link_info;
> >> +	__u32 link_info_len;
> >> +
> >> +	link_info_len = sizeof(link_info);
> > 
> > Ditto
> > 
> >> +	memset(&link_info, 0, link_info_len);
> >> +	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
> >> +	return link_info.prog_id;
> >> +}
> >> +
> >> +static __u32 bpf_map_get_id(int fd)
> >> +{
> >> +	struct bpf_map_info map_info;
> >> +	__u32 map_info_len;
> > 
> > Ditto.
> > 
> >> +	map_info_len = sizeof(map_info);
> >> +	memset(&map_info, 0, map_info_len);
> >> +	bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
> >> +	return map_info.id;
> >> +}
> >> +
> >> +static int bperf_lock_attr_map(struct target *target)
> >> +{
> >> +	const char *path = target->attr_map ? : DEFAULT_ATTR_MAP_PATH;
> >> +	int map_fd, err;
> >> +
> >> +	if (access(path, F_OK)) {
> >> +		map_fd = bpf_create_map(BPF_MAP_TYPE_HASH,
> >> +					sizeof(struct perf_event_attr),
> >> +					sizeof(struct bperf_attr_map_entry),
> > 
> > Also naming it as perf_event_attr_map_entry should make the equivalence
> > more explicit if albeit a bit longer, i.e.:
> > 
> > +		map_fd = bpf_create_map(BPF_MAP_TYPE_HASH,
> > +					sizeof(struct perf_event_attr),
> > +					sizeof(struct perf_event_attr_map_entry),
> > 
> >> +					ATTR_MAP_SIZE, 0);
> >> +		if (map_fd < 0)
> >> +			return -1;
> >> +
> >> +		err = bpf_obj_pin(map_fd, path);
> >> +		if (err) {
> >> +			/* someone pinned the map in parallel? */
> >> +			close(map_fd);
> >> +			map_fd = bpf_obj_get(path);
> >> +			if (map_fd < 0)
> >> +				return -1;
> >> +		}
> >> +	} else {
> >> +		map_fd = bpf_obj_get(path);
> >> +		if (map_fd < 0)
> >> +			return -1;
> >> +	}
> >> +
> >> +	err = flock(map_fd, LOCK_EX);
> >> +	if (err) {
> >> +		close(map_fd);
> >> +		return -1;
> >> +	}
> >> +	return map_fd;
> >> +}
> >> +
> >> +/* trigger the leader program on a cpu */
> >> +static int bperf_trigger_reading(int prog_fd, int cpu)
> >> +{
> >> +	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
> >> +			    .ctx_in = NULL,
> >> +			    .ctx_size_in = 0,
> >> +			    .flags = BPF_F_TEST_RUN_ON_CPU,
> >> +			    .cpu = cpu,
> >> +			    .retval = 0,
> >> +		);
> >> +
> >> +	return bpf_prog_test_run_opts(prog_fd, &opts);
> >> +}
> >> +
> >> +static int bperf_check_target(struct evsel *evsel,
> >> +			      struct target *target,
> >> +			      enum bperf_filter_type *filter_type,
> >> +			      __u32 *filter_entry_cnt)
> >> +{
> >> +	if (evsel->leader->core.nr_members > 1) {
> >> +		pr_err("bpf managed perf events do not yet support groups.\n");
> >> +		return -1;
> >> +	}
> >> +
> >> +	/* determine filter type based on target */
> >> +	if (target->system_wide) {
> >> +		*filter_type = BPERF_FILTER_GLOBAL;
> >> +		*filter_entry_cnt = 1;
> >> +	} else if (target->cpu_list) {
> >> +		*filter_type = BPERF_FILTER_CPU;
> >> +		*filter_entry_cnt = perf_cpu_map__nr(evsel__cpus(evsel));
> >> +	} else if (target->tid) {
> >> +		*filter_type = BPERF_FILTER_PID;
> >> +		*filter_entry_cnt = perf_thread_map__nr(evsel->core.threads);
> >> +	} else if (target->pid) {
> >> +		*filter_type = BPERF_FILTER_TGID;
> >> +		*filter_entry_cnt = perf_thread_map__nr(evsel->core.threads);
> >> +	} else {
> >> +		pr_err("bpf managed perf events do not yet support these targets.\n");
> >> +		return -1;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
> >> +				       struct bperf_attr_map_entry *entry)
> >> +{
> >> +	struct bperf_leader_bpf *skel = NULL;
> > 
> > Init it to NULL to then right away set it to the return of
> > bperf_leader_bpf__open?
> > 
> > see below
> > 
> >> +	struct perf_cpu_map *all_cpus;
> >> +	int link_fd, diff_map_fd, err;
> >> +	struct bpf_link *link = NULL;
> >> +
> >> +	skel = bperf_leader_bpf__open();
> > 
> > 	struct bperf_leader_bpf *skel = bperf_leader_bpf__open();
> > 
> >> +	if (!skel) {
> >> +		pr_err("Failed to open leader skeleton\n");
> >> +		return -1;
> >> +	}
> >> +
> >> +	bpf_map__resize(skel->maps.events, libbpf_num_possible_cpus());
> >> +	err = bperf_leader_bpf__load(skel);
> >> +	if (err) {
> >> +		pr_err("Failed to load leader skeleton\n");
> >> +		goto out;
> >> +	}
> >> +
> >> +	err = -1;
> >> +	link = bpf_program__attach(skel->progs.on_switch);
> >> +	if (!link) {
> >> +		pr_err("Failed to attach leader program\n");
> >> +		goto out;
> >> +	}
> >> +
> >> +	all_cpus = perf_cpu_map__new(NULL);
> >> +	if (!all_cpus) {
> >> +		pr_err("Failed to open cpu_map for all cpus\n");
> >> +		goto out;
> >> +	}
> > 
> > If you reorder things maybe you can determine the number of possible
> > cpus from all_cpus?
> 
> I tried to optimize the use of "all_cpus". But it we still call
> perf_cpu_map__new(NULL) on each interval. Maybe we should just save 
> num_possible_cpu to evsel? 

Yeah, or do it at perf tool start, as this is an invariant and use it
everywhere? online cpus vary, but possible? I guess this is a hard
limit, right, one that the tool can get at system start.

> I will address the other feedbacks in v2. 

Thanks a lot!

- Arnaldo
