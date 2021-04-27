Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B9136C6CF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbhD0NPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:15:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236959AbhD0NOw (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:14:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA753613D0;
        Tue, 27 Apr 2021 13:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619529249;
        bh=x6RKmLsto5X/verU2yL8j9BN2Rr9H32IO58Jepb9G80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mGySASVSQHGfN97jT36/oY4u49bOeSkTkParcoSb/xOfTrBpdDrpQ+MGjcP9jStIv
         rWfJyYaPhSBFv55tjEv11UYf+hHnMprdOty+Dnr6I6jF5gWhbyvjuTFnRl8ZRivAfD
         ZxNrGn7qsr+KKxXbQXBGIWksCanU3N09ySWASNaMQ5QEaqzJPoCR9lCdcFM6xeJ6n/
         TtBcyNQMtxZ+E82xFczr9r3uZOu9tl4si9FdTNe+/D19duJsikG0bFtsd1miE6kooV
         zWFJkvQmkYdIsWrIFg4gTczOKLsovSe3gsTmRqND02ZBCBKdciI5aWKq65Hm7OUDYD
         bm4f90lxM5+ZA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2D52540647; Tue, 27 Apr 2021 10:14:06 -0300 (-03)
Date:   Tue, 27 Apr 2021 10:14:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v6 00/26] perf tool: AlderLake hybrid support series 1
Message-ID: <YIgOHc1pnoyQASUJ@kernel.org>
References: <20210427070139.25256-1-yao.jin@linux.intel.com>
 <YIgIiZVxOWdYTwef@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIgIiZVxOWdYTwef@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 27, 2021 at 02:50:17PM +0200, Jiri Olsa escreveu:
> On Tue, Apr 27, 2021 at 03:01:13PM +0800, Jin Yao wrote:
> > AlderLake uses a hybrid architecture utilizing Golden Cove cores
> > (core cpu) and Gracemont cores (atom cpu). Each cpu has dedicated
> > event list. Some events are available on core cpu, some events
> > are available on atom cpu and some events can be available on both.
> > 
> > Kernel exports new pmus "cpu_core" and "cpu_atom" through sysfs:
> > /sys/devices/cpu_core
> > /sys/devices/cpu_atom
> > 
> > cat /sys/devices/cpu_core/cpus
> > 0-15
> > 
> > cat /sys/devices/cpu_atom/cpus
> > 16-23
> > 
> > In this example, core cpus are 0-15 and atom cpus are 16-23.
> > 
> > To enable a core only event or atom only event:
> > 
> >         cpu_core/<event name>/
> > or
> >         cpu_atom/<event name>/
> > 
> > Count the 'cycles' event on core cpus.
> > 
> >   # perf stat -e cpu_core/cycles/ -a -- sleep 1
> > 
> >    Performance counter stats for 'system wide':
> > 
> >       12,853,951,349      cpu_core/cycles/
> > 
> >          1.002581249 seconds time elapsed
> > 
> > If one event is available on both atom cpu and core cpu, two events
> > are created automatically.
> > 
> >   # perf stat -e cycles -a -- sleep 1
> > 
> >    Performance counter stats for 'system wide':
> > 
> >       12,856,467,438      cpu_core/cycles/
> >        6,404,634,785      cpu_atom/cycles/
> > 
> >          1.002453013 seconds time elapsed
> > 
> > Group is supported if the events are from same pmu, otherwise a warning
> > is displayed and disable grouping automatically.
> > 
> >   # perf stat -e '{cpu_core/cycles/,cpu_core/instructions/}' -a -- sleep 1
> > 
> >    Performance counter stats for 'system wide':
> > 
> >       12,863,866,968      cpu_core/cycles/
> >          554,795,017      cpu_core/instructions/
> > 
> >          1.002616117 seconds time elapsed
> > 
> >   # perf stat -e '{cpu_core/cycles/,cpu_atom/instructions/}' -a -- sleep 1
> >   WARNING: events in group from different hybrid PMUs!
> >   WARNING: grouped events cpus do not match, disabling group:
> >     anon group { cpu_core/cycles/, cpu_atom/instructions/ }
> > 
> >    Performance counter stats for 'system wide':
> > 
> >            6,283,970      cpu_core/cycles/
> >              765,635      cpu_atom/instructions/
> > 
> >          1.003959036 seconds time elapsed
> > 
> > Note that, since the whole patchset for AlderLake hybrid support is very
> > large (40+ patches). For simplicity, it's splitted into several patch
> > series.
> > 
> > The patch series 1 only supports the basic functionality. The advanced
> > supports for perf-c2c/perf-mem/topdown/metrics/topology header and others
> > will be added in follow-up patch series.
> > 
> > The perf tool codes can also be found at:
> > https://github.com/yaoj/perf.git
> 
> hi,
> did you update the branch for v6? I think I can't see
> the new update there

I'm putting it in my tmp.perf/core while I'm testing it and you
reviewing, I'll  do some reviewing as well, now it applied ok:

[acme@five perf]$        git am ./v6_20210427_yao_jin_perf_tool_alderlake_hybrid_support_series_1.mbx
Applying: tools headers uapi: Update tools's copy of linux/perf_event.h
Applying: perf jevents: Support unit value "cpu_core" and "cpu_atom"
Applying: perf pmu: Simplify arguments of __perf_pmu__new_alias
Applying: perf pmu: Save pmu name
Applying: perf pmu: Save detected hybrid pmus to a global pmu list
Applying: perf pmu: Add hybrid helper functions
Applying: perf stat: Uniquify hybrid event name
Applying: perf parse-events: Create two hybrid hardware events
Applying: perf parse-events: Create two hybrid cache events
Applying: perf parse-events: Create two hybrid raw events
Applying: perf parse-events: Compare with hybrid pmu name
Applying: perf parse-events: Support event inside hybrid pmu
Applying: perf record: Create two hybrid 'cycles' events by default
Applying: perf stat: Add default hybrid events
Applying: perf stat: Filter out unmatched aggregation for hybrid event
Applying: perf stat: Warn group events from different hybrid PMU
Applying: perf record: Uniquify hybrid event name
Applying: perf tests: Add hybrid cases for 'Parse event definition strings' test
Applying: perf tests: Add hybrid cases for 'Roundtrip evsel->name' test
Applying: perf tests: Skip 'Setup struct perf_event_attr' test for hybrid
Applying: perf tests: Support 'Track with sched_switch' test for hybrid
Applying: perf tests: Support 'Parse and process metrics' test for hybrid
Applying: perf tests: Support 'Session topology' test for hybrid
Applying: perf tests: Support 'Convert perf time to TSC' test for hybrid
Applying: perf tests: Skip 'perf stat metrics (shadow stat) test' for hybrid
Applying: perf Documentation: Document intel-hybrid support
[acme@five perf]$
