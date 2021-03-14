Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C332633A8A6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 23:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCNWss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 18:48:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20015 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229518AbhCNWsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 18:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615762107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=doF31vnHavlwglGxMdqxeyGDqAXgeWXIcTPVFrzO8uo=;
        b=Y7+LmrMrK9jD9L+CmnJltwUAthHeR8xbTg6KOJYGDaN9JOImmtQoxnHPIqbugApqxozRKP
        Te0sZhfPx0Hy+wE8G9ZEaXujDFm/Z2NVzjFwWQf4zkFDOplmRaakuDHDMxZ13CRNCmHM5h
        TG5M2ZObLjk7b5l/8vjOKBXaTpZqOJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-lA5cYC-NODGNKDjj96A2hw-1; Sun, 14 Mar 2021 18:48:15 -0400
X-MC-Unique: lA5cYC-NODGNKDjj96A2hw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4541F8189C6;
        Sun, 14 Mar 2021 22:48:14 +0000 (UTC)
Received: from krava (unknown [10.40.192.102])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8F52D6E519;
        Sun, 14 Mar 2021 22:48:12 +0000 (UTC)
Date:   Sun, 14 Mar 2021 23:48:11 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, acme@kernel.org,
        acme@redhat.com, namhyung@kernel.org, jolsa@kernel.org
Subject: Re: [PATCH] perf-stat: introduce bperf, share hardware PMCs with BPF
Message-ID: <YE6Sq78CRmr/JsHl@krava>
References: <20210312020257.197137-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312020257.197137-1-songliubraving@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 06:02:57PM -0800, Song Liu wrote:
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

isn't that another filter via bpf_get_current_cgroup_id ?

> 2. Do not support monitoring of BPF program (perf-stat -b);

we'd need to call the leadr on fentry/fexit of the monitored bpf
program, right?

> 3. Do not support event groups.

I guess for group support you'll need to load 'leaders' for each group member

> 
> The following commands have been tested:
> 
>    perf stat --use-bpf -e cycles -a
>    perf stat --use-bpf -e cycles -C 1,3,4
>    perf stat --use-bpf -e cycles -p 123
>    perf stat --use-bpf -e cycles -t 100,101

works good with that file you sent.. I'll check/test more,
so far some quick comments below

thanks,
jirka



SNIP

> @@ -1146,6 +1156,10 @@ static struct option stat_options[] = {
>  #ifdef HAVE_BPF_SKEL
>  	OPT_STRING('b', "bpf-prog", &target.bpf_str, "bpf-prog-id",
>  		   "stat events on existing bpf program id"),
> +	OPT_BOOLEAN(0, "use-bpf", &target.use_bpf,
> +		    "use bpf program to count events"),
> +	OPT_STRING(0, "attr-map", &target.attr_map, "attr-map-path",
> +		   "path to perf_event_attr map"),

what's the point of allowing another name? just debug purpose?

SNIP

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

we should make that with sysfs__mountpoint

SNIP

> +static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
> +				       struct bperf_attr_map_entry *entry)
> +{
> +	struct bperf_leader_bpf *skel = NULL;
> +	struct perf_cpu_map *all_cpus;
> +	int link_fd, diff_map_fd, err;
> +	struct bpf_link *link = NULL;
> +
> +	skel = bperf_leader_bpf__open();
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

please add to the comment: ', which is called within following evsel__open_per_cpu call'
or something like that.. 

SNIP

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

we have cpu__max_cpu for that

> +	struct bpf_perf_event_value values[num_cpu_bpf];
> +	int err, i, entry_cnt;
> +
> +	err = bperf_follower_bpf__attach(evsel->follower_skel);
> +	if (err)
> +		return -1;

could we attach it in load callback and have the some map
value be checked in follower program and 'if value != 0'
it would let the program to continue.. I used/saw this
in few bcc programs

> +
> +	/*
> +	 * Attahcing the skeleton takes non-trivial time (0.2s+ on a kernel
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

