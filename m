Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E399433B35A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 14:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhCONKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 09:10:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229807AbhCONKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 09:10:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA49A64E74;
        Mon, 15 Mar 2021 13:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615813817;
        bh=ICd/Atj2FZXZ0iL/M9SMQR97uK2V17AYDzyyz2GmxsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=acX2vCxhcUiwzCPU2wbxWQavkq6vI2lb8d8timNCAEOGqa8nGqSYqB77e7TeZwDBC
         zMm/WhnabaLO+X1UMMywJJaRLpIoXMgKvlWd34huPEGv7o49OBelCHQGQLvx7WZJjz
         S9/81127GYN3W4tEGz+eGLFvm3EC2OIxsB0qCltXr783Vh61OFIIKyF8FtB2XSZ/nW
         K79QEcMdjzjM1IRoVasGVIDZs4+WnDRsSXBHVSmaw1SFr8DBXu4Kzsx24Pa5/U4t8U
         yTn/uqoIOc1PID2WzWpMRf5/9yjFB/VXD9wvnhlyv28D2zF7oHDwYqtOp1z5G8aVMi
         pt8WQKrdEBpGA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 680E440647; Mon, 15 Mar 2021 10:10:14 -0300 (-03)
Date:   Mon, 15 Mar 2021 10:10:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>, Andi Kleen <andi@firstfloor.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-perf-users@ghostprotocols.net" 
        <linux-perf-users@ghostprotocols.net>
Subject: Re: [PATCH] perf-stat: introduce bperf, share hardware PMCs with BPF
Message-ID: <YE9ctk/sO/bokBjw@kernel.org>
References: <20210312020257.197137-1-songliubraving@fb.com>
 <YEt5o7pSTleymwy1@kernel.org>
 <F55800AC-73A5-46A4-9E08-1DD00691267C@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F55800AC-73A5-46A4-9E08-1DD00691267C@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 12, 2021 at 06:52:39PM +0000, Song Liu escreveu:
> > On Mar 12, 2021, at 6:24 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
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
> >> The following commands have been tested:
> >> 
> >>   perf stat --use-bpf -e cycles -a
> >>   perf stat --use-bpf -e cycles -C 1,3,4
> >>   perf stat --use-bpf -e cycles -p 123
> >>   perf stat --use-bpf -e cycles -t 100,101

<SNIP>

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
> 
> Actually, I am still debating whether we want the above change in a separate 
> patch. It is related to the following change. 
> 
> [...]
> 
> >> +	/*
> >> +	 * Attahcing the skeleton takes non-trivial time (0.2s+ on a kernel
> >> +	 * with some debug options enabled). This shows as a longer first
> >> +	 * interval:
> >> +	 *
> >> +	 * # perf stat -e cycles -a -I 1000
> >> +	 * #           time             counts unit events
> >> +	 *      1.267634674     26,259,166,523      cycles
> >> +	 *      2.271637827     22,550,822,286      cycles
> >> +	 *      3.275406553     22,852,583,744      cycles
> >> +	 *
> >> +	 * Fix this by zeroing accum_readings after attaching the program.
> >> +	 */
> >> +	bperf_sync_counters(evsel);
> >> +	entry_cnt = bpf_map__max_entries(skel->maps.accum_readings);
> >> +	memset(values, 0, sizeof(struct bpf_perf_event_value) * num_cpu_bpf);
> >> +
> >> +	for (i = 0; i < entry_cnt; i++) {
> >> +		bpf_map_update_elem(bpf_map__fd(skel->maps.accum_readings),
> >> +				    &i, values, BPF_ANY);
> >> +	}
> >> +	return 0;
> >> +}
> 
> Attaching the skeleton takes non-trivial time, so that we get a bigger first 
> interval (1.26s in the example above). To fix this, in __run_perf_stat(), we 
> get t0 and ref_time after enable_counters(). 
> 
> Maybe a comment in __run_perf_stat() is better than a separate patch?

I still think that there is value in taking those measurements after we
enable the counters, as, for instance, for interval mode we want
measurements with the counters enabled, whatever happens before the
counters are enabled is just startup time, etc. Jiri, Andi?

- Arnaldo
