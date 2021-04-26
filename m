Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3358636BACB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 22:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbhDZUmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 16:42:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233971AbhDZUmT (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 16:42:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03CC060FEE;
        Mon, 26 Apr 2021 20:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619469697;
        bh=hqZJVjP+9T+KgDCyTRyONgZzqpoLOcaOujLd7OB4g5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Srid0k0jPWeN4lVzqU29h3TUgGMSYMXHzfwpW6helK0ftz0Sp8JUL55fIECAvlkJH
         SjwnJ3DaayKlYbJMVCoSixM2HM0gR7uCOTGhwSqdry0aq+2ZLnGH4dI6VoE7vyE/ww
         jRwJUAQtzpw+N3Kb5WOutMPkI9d4rwmIY3AJKttYGEJH/WbcFpoH5TD9wju6vxFerN
         E7IY4xP9uyCljmAxyO0XIF3Qy8nMFgXPeuMTicWCJI0p9Ga0EZJZV9m4qTGFQF/Qwa
         iGcs/KeYjFARc5GI15kK3o8EemK4Lp8J3/Sf+ZMZgmw8Rm4EMFY6ZJAvxKdApBFHuO
         TH1XHZD1X1KOw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9D37D40647; Mon, 26 Apr 2021 17:41:34 -0300 (-03)
Date:   Mon, 26 Apr 2021 17:41:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v5 00/26] perf tool: AlderLake hybrid support series 1
Message-ID: <YIclfrZzqt388xBP@kernel.org>
References: <20210423053541.12521-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423053541.12521-1-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 23, 2021 at 01:35:15PM +0800, Jin Yao escreveu:
> AlderLake uses a hybrid architecture utilizing Golden Cove cores
> (core cpu) and Gracemont cores (atom cpu). Each cpu has dedicated
> event list. Some events are available on core cpu, some events
> are available on atom cpu and some events can be available on both.
> 
> Kernel exports new pmus "cpu_core" and "cpu_atom" through sysfs:
> /sys/devices/cpu_core
> /sys/devices/cpu_atom

[acme@five perf]$ b4 am -t -s -l --cc-trailers 20210423053541.12521-1-yao.jin@linux.intel.com
Looking up https://lore.kernel.org/r/20210423053541.12521-1-yao.jin%40linux.intel.com
Grabbing thread from lore.kernel.org/lkml
Analyzing 29 messages in the thread
---
Writing ./v5_20210423_yao_jin_perf_tool_alderlake_hybrid_support_series_1.mbx
  [PATCH v5 01/26] tools headers uapi: Update tools's copy of linux/perf_event.h
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    + Link: https://lore.kernel.org/r/20210423053541.12521-2-yao.jin@linux.intel.com
    + Cc: peterz@infradead.org
    + Cc: kan.liang@intel.com
    + Cc: yao.jin@intel.com
    + Cc: acme@kernel.org
    + Cc: jolsa@kernel.org
    + Cc: ak@linux.intel.com
    + Cc: alexander.shishkin@linux.intel.com
    + Cc: mingo@redhat.com
    + Cc: Linux-kernel@vger.kernel.org
<SNIP>
---
Total patches: 26
---
Cover: ./v5_20210423_yao_jin_perf_tool_alderlake_hybrid_support_series_1.cover
 Link: https://lore.kernel.org/r/20210423053541.12521-1-yao.jin@linux.intel.com
 Base: not found
       git am ./v5_20210423_yao_jin_perf_tool_alderlake_hybrid_support_series_1.mbx
[acme@five perf]$        git am ./v5_20210423_yao_jin_perf_tool_alderlake_hybrid_support_series_1.mbx
Applying: tools headers uapi: Update tools's copy of linux/perf_event.h
Applying: perf jevents: Support unit value "cpu_core" and "cpu_atom"
Applying: perf pmu: Simplify arguments of __perf_pmu__new_alias
Applying: perf pmu: Save pmu name
Applying: perf pmu: Save detected hybrid pmus to a global pmu list
Applying: perf pmu: Add hybrid helper functions
Applying: perf stat: Uniquify hybrid event name
error: patch failed: tools/perf/builtin-stat.c:68
error: tools/perf/builtin-stat.c: patch does not apply
error: patch failed: tools/perf/util/stat-display.c:17
error: tools/perf/util/stat-display.c: patch does not apply
Patch failed at 0007 perf stat: Uniquify hybrid event name
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
[acme@five perf]$

[acme@five perf]$ git am --show-current-patch=diff | patch -p1
patching file tools/perf/builtin-stat.c
Hunk #1 FAILED at 68.
Hunk #2 succeeded at 2402 (offset 24 lines).
1 out of 2 hunks FAILED -- saving rejects to file tools/perf/builtin-stat.c.rej
patching file tools/perf/util/evsel.h
Hunk #1 succeeded at 116 (offset 1 line).
patching file tools/perf/util/parse-events.c
patching file tools/perf/util/stat-display.c
Hunk #1 FAILED at 17.
Hunk #2 succeeded at 538 (offset 6 lines).
Hunk #3 succeeded at 553 (offset 6 lines).
1 out of 3 hunks FAILED -- saving rejects to file tools/perf/util/stat-display.c.rej
[acme@five perf]$ vim tools/perf/builtin-stat.c.rej
[acme@five perf]$ cat tools/perf/builtin-stat.c.rej
--- tools/perf/builtin-stat.c
+++ tools/perf/builtin-stat.c
@@ -68,6 +68,7 @@
 #include "util/affinity.h"
 #include "util/pfm.h"
 #include "util/bpf_counter.h"
+#include "util/pmu-hybrid.h"
 #include "asm/bug.h"

 #include <linux/time64.h>
[acme@five perf]$ cat tools/perf/util/stat-display.c.rej
--- tools/perf/util/stat-display.c
+++ tools/perf/util/stat-display.c
@@ -17,6 +17,7 @@
 #include "cgroup.h"
 #include <api/fs/fs.h>
 #include "util.h"
+#include "pmu-hybrid.h"

 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
[acme@five perf]$


Its clashing with some BPF changes by Song that are still under review
but I have in my tmp.perf/core branch so that I can test build it while
I wait for Jiri to say if Song addressed all his comments.

So after you address the new round of comments for v5 you can please
rebase on tmp.perf/core or, at that point, perf/core.

- Arnaldo
