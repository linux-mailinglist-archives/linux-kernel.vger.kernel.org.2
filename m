Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE0039885A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhFBL26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232694AbhFBL2i (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:28:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2622B60720;
        Wed,  2 Jun 2021 11:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622633215;
        bh=7Agf2EdAUzSAI0j5KHIzo68pAwuY3m8FkBuizTOy9QQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aUjZJ45rfxpll/L3WD67S1xjlrn3erFFpSYYrYFk6P7RJ5a1ns1ctd/vvL2H626es
         gQFk+YtQAlNAfrJfkem70Zh6HYRFR6kYMG2Z3z7OFxOZEYrySOxm+zhBMMehGg6kUL
         GVgMizz05F0nIHxUT7dX33OK5ILxVUWW3CQnEQkvrg7PgvWfjtbfXkaQg9b8RJ6WKD
         h1eAHM5wR9sDOLhNQMT2hO3riKvdegNwECwcQz5GPVgHD3VuIL2cz++R+y/a8NIka9
         MIMfh3+aitBuqUfWxOexitrp1nxP5ZyCmaoWeNgHa4SuazmX/zlULhZs1iem1vfbkv
         tnMi8NbyEON9g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1B5F84011C; Wed,  2 Jun 2021 08:26:52 -0300 (-03)
Date:   Wed, 2 Jun 2021 08:26:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>, "Jin, Yao" <yao.jin@intel.com>
Subject: Re: [PATCH 1/4] perf vendor events: Add core event list for Icelake
 Server
Message-ID: <YLdq/H8CXYgHWzCL@kernel.org>
References: <20210510012438.6293-1-yao.jin@linux.intel.com>
 <20210510012438.6293-2-yao.jin@linux.intel.com>
 <CAP-5=fUPbc0T9283MxxPhqdu+zvxNKvJsY5R5CuyS2K4SPtiJg@mail.gmail.com>
 <YKgMz52O9mVjPH3K@kernel.org>
 <c0f27643-bebb-2912-56ed-f7abec7dbde3@linux.intel.com>
 <YKzwzyM8YSsxRBJ8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YKzwzyM8YSsxRBJ8@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 25, 2021 at 09:42:55AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, May 24, 2021 at 09:08:12AM +0800, Jin, Yao escreveu:
> > Could you pull the top 4 patches from "https://github.com/yaoj/icx-events.git"?

> > perf vendor events: Update event list for Icelake Client
> > perf vendor events: Add metrics for Icelake Server
> > perf vendor events: Add uncore event list for Icelake Server

> > The patch is too big and it's possibly corrupted by mailing system.
 
> Thanks, applied.

So, this is failing 'perf test 10', see details below, please run 'perf
test' before pushing patches upstream.

Triple checking:

⬢[acme@toolbox perf]$ git cherry-pick 8f74f0f4dbf6361f0a5d21c5da260fbbf7597286
Removing tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
[perf/core 6971d24f4d04ccfa] Revert "perf vendor events intel: Add metrics for Icelake Server"
 Date: Wed Jun 2 08:16:20 2021 -0300
 1 file changed, 327 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
⬢[acme@toolbox perf]$ git log --oneline -1
6971d24f4d04ccfa (HEAD -> perf/core) Revert "perf vendor events intel: Add metrics for Icelake Server"
⬢[acme@toolbox perf]$ (rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf ; make -k CORESIGHT=1 BUILD_BPF_SKEL=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin) > /dev/null 2>&1 ; perf test 10
10: PMU events                                                      :
10.1: PMU event table sanity                                        : Ok
10.2: PMU event map aliases                                         : Ok
10.3: Parsing of PMU event table metrics                            : Ok
10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
⬢[acme@toolbox perf]$ git reset --hard HEAD~
HEAD is now at 0ab8009b3e8dd6ba Merge remote-tracking branch 'torvalds/master' into perf/core
⬢[acme@toolbox perf]$ (rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf ; make -k CORESIGHT=1 BUILD_BPF_SKEL=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin) > /dev/null 2>&1 ; perf test 10
10: PMU events                                                      :
10.1: PMU event table sanity                                        : Ok
10.2: PMU event map aliases                                         : Ok
10.3: Parsing of PMU event table metrics                            : Ok
10.4: Parsing of PMU event table metrics with fake PMUs             : FAILED!
⬢[acme@toolbox perf]$

- Arnaldo

⬢[acme@toolbox perf]$ git bisect bad
d89bf9cab1f613e4496f929d89477b2baaad1ea9 is the first bad commit
commit d89bf9cab1f613e4496f929d89477b2baaad1ea9
Author: Jin Yao <yao.jin@linux.intel.com>
Date:   Sat May 8 13:06:20 2021 +0800

    perf vendor events intel: Add metrics for Icelake Server

    Add JSON metrics for Icelake Server to perf.

    Based on TMA metrics 4.21 at 01.org.:

      https://download.01.org/perfmon/

    Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
    Reviewed-by: Andi Kleen <ak@linux.intel.com>
    Acked-by: Ian Rogers <irogers@google.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Andi Kleen <ak@linux.intel.com>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Kan Liang <kan.liang@intel.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Link: http://lore.kernel.org/lkml/c0f27643-bebb-2912-56ed-f7abec7dbde3@linux.intel.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

 .../pmu-events/arch/x86/icelakex/icx-metrics.json  | 327 +++++++++++++++++++++
 1 file changed, 327 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
⬢[acme@toolbox perf]$


⬢[acme@toolbox perf]$ perf test -v 10 |& tail -40
parsing 'inst_retired.any / cpu_clk_unhalted.distributed'
parsing '( 1 * ( fp_arith_inst_retired.scalar_single + fp_arith_inst_retired.scalar_double ) + 2 * fp_arith_inst_retired.128b_packed_double + 4 * ( fp_arith_inst_retired.128b_packed_single + fp_arith_inst_retired.256b_packed_double ) + 8 * ( fp_arith_inst_retired.256b_packed_single + fp_arith_inst_retired.512b_packed_double ) + 16 * fp_arith_inst_retired.512b_packed_single ) / cpu_clk_unhalted.distributed'
parsing 'uops_executed.thread / ( uops_executed.core_cycles_ge_1 / 2 )'
parsing 'cpu_clk_unhalted.distributed'
parsing 'inst_retired.any / mem_inst_retired.all_loads'
parsing 'inst_retired.any / mem_inst_retired.all_stores'
parsing 'inst_retired.any / br_inst_retired.all_branches'
parsing 'inst_retired.any / br_inst_retired.near_call'
parsing 'br_inst_retired.all_branches / br_inst_retired.near_taken'
parsing 'inst_retired.any / ( 1 * ( fp_arith_inst_retired.scalar_single + fp_arith_inst_retired.scalar_double ) + 2 * fp_arith_inst_retired.128b_packed_double + 4 * ( fp_arith_inst_retired.128b_packed_single + fp_arith_inst_retired.256b_packed_double ) + 8 * ( fp_arith_inst_retired.256b_packed_single + fp_arith_inst_retired.512b_packed_double ) + 16 * fp_arith_inst_retired.512b_packed_single )'
parsing 'inst_retired.any'
parsing 'lsd.uops / (idq.dsb_uops + lsd.uops + idq.mite_uops + idq.ms_uops)'
parsing 'idq.dsb_uops / (idq.dsb_uops + lsd.uops + idq.mite_uops + idq.ms_uops)'
parsing 'l1d_pend_miss.pending / ( mem_load_retired.l1_miss + mem_load_retired.fb_hit )'
parsing 'l1d_pend_miss.pending / l1d_pend_miss.pending_cycles'
parsing '( itlb_misses.walk_pending + dtlb_load_misses.walk_pending + dtlb_store_misses.walk_pending ) / ( 2 * cpu_clk_unhalted.distributed )'
parsing '64 * l1d.replacement / 1000000000 / duration_time'
parsing '64 * l2_lines_in.all / 1000000000 / duration_time'
parsing '64 * longest_lat_cache.miss / 1000000000 / duration_time'
parsing '64 * offcore_requests.all_requests / 1000000000 / duration_time'
parsing '1000 * mem_load_retired.l1_miss / inst_retired.any'
parsing '1000 * mem_load_retired.l2_miss / inst_retired.any'
parsing '1000 * ( ( offcore_requests.all_data_rd - offcore_requests.demand_data_rd ) + l2_rqsts.all_demand_miss + l2_rqsts.swpf_miss ) / inst_retired.any'
parsing '1000 * mem_load_retired.l3_miss / inst_retired.any'
parsing '1000 * l2_lines_out.silent / inst_retired.any'
parsing '1000 * l2_lines_out.non_silent / inst_retired.any'
parsing 'cpu_clk_unhalted.ref_tsc / msr@tsc@'
parsing '(cpu_clk_unhalted.thread / cpu_clk_unhalted.ref_tsc) * msr@tsc@ / 1000000000 / duration_time'
parsing '( ( 1 * ( fp_arith_inst_retired.scalar_single + fp_arith_inst_retired.scalar_double ) + 2 * fp_arith_inst_retired.128b_packed_double + 4 * ( fp_arith_inst_retired.128b_packed_single + fp_arith_inst_retired.256b_packed_double ) + 8 * ( fp_arith_inst_retired.256b_packed_single + fp_arith_inst_retired.512b_packed_double ) + 16 * fp_arith_inst_retired.512b_packed_single ) / 1000000000 ) / duration_time'
parsing 'cpu_clk_unhalted.thread / cpu_clk_unhalted.ref_tsc'
parsing '1 - cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_distributed'
parsing 'cpu_clk_unhalted.thread:k / cpu_clk_unhalted.thread'
parsing '( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time'
parsing '1000000000 * ( cha@event\=0x36\,umask\=0x21\,config\=0x40433@ / cha@event\=0x35\,umask\=0x21\,config\=0x40433@ ) / ( cha_0@event\=0x0@ / duration_time )'
parsing 'cha@event\=0x36\,umask\=0x21\,config\=0x40433@ / cha@event\=0x36\,umask\=0x21\,config\=0x40433\,thresh\=1@'
parsing '( 1000000000 * ( cha@event\=0x36\,umask\=0x21\,config\=0x40433@_pmm / cha@event\=0x35\,umask\=0x21\,config\=0x40433@_pmm ) / cha_0@event\=0x0@ )'
check_parse_fake failed
test child finished with -1
---- end ----
PMU events subtest 4: FAILED!
⬢[acme@toolbox perf]$
