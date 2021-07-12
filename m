Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3697C3C52F0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350886AbhGLHvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 03:51:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:47480 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243592AbhGLHQs (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 03:16:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="209751801"
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="209751801"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 00:13:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="464160909"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jul 2021 00:13:56 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 0/3] perf tool: Enable cpu list for hybrid
Date:   Mon, 12 Jul 2021 15:12:32 +0800
Message-Id: <20210712071235.28533-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf-record and perf-stat have supported the option '-C/--cpus'
to count or collect only on the list of CPUs provided. This option
needs to be supported for hybrid as well.

v3:
---
Rebase to latest perf/core branch.

v2:
---
Automatically map to hybrid pmu.

For example,

If cpu0-7 are 'cpu_core' and cpu9-11 are 'cpu_atom',

  # perf stat -e cycles -C0,11 -- sleep 1
  WARNING: use 0 in 'cpu_core' for 'cycles', skip other cpus in list.
  WARNING: use 11 in 'cpu_atom' for 'cycles', skip other cpus in list.

   Performance counter stats for 'CPU(s) 0,11':

           1,914,704      cpu_core/cycles/
           2,036,983      cpu_atom/cycles/

         1.005815641 seconds time elapsed

It automatically selects cpu0 for cpu_core/cycles/, selects cpu11 for
cpu_atom/cycles/, also with some warnings output.

Jin Yao (3):
  libperf: Add perf_cpu_map__default_new()
  perf tools: Create hybrid flag in target
  perf tools: Enable on a list of CPUs for hybrid

 tools/lib/perf/cpumap.c              |  5 +++
 tools/lib/perf/include/perf/cpumap.h |  1 +
 tools/perf/builtin-record.c          |  7 +++
 tools/perf/builtin-stat.c            |  6 +++
 tools/perf/util/evlist-hybrid.c      | 65 ++++++++++++++++++++++++++++
 tools/perf/util/evlist-hybrid.h      |  1 +
 tools/perf/util/evlist.c             |  3 +-
 tools/perf/util/pmu.c                | 35 +++++++++++++++
 tools/perf/util/pmu.h                |  4 ++
 tools/perf/util/target.h             |  1 +
 10 files changed, 127 insertions(+), 1 deletion(-)

-- 
2.17.1

