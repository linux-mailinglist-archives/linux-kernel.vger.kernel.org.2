Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778643C52F4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351111AbhGLHv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 03:51:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:47484 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243646AbhGLHQy (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 03:16:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="209751812"
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="209751812"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 00:14:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="464160936"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jul 2021 00:14:01 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 2/3] perf tools: Create hybrid flag in target
Date:   Mon, 12 Jul 2021 15:12:34 +0800
Message-Id: <20210712071235.28533-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210712071235.28533-1-yao.jin@linux.intel.com>
References: <20210712071235.28533-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User may count or collect only on a cpu list via '-C/--cpus' option.
Previously cpus for evsel was retrieved from pmu sysfs. But if the
target cpu list is defined, the retrieved cpus are not kept and the
target cpu list is used instead.

But for hybrid system, we can't directly use target cpu list. The
cpu list may not available on hybrid pmu (e.g. cpu_core or cpu_atom).
So we should not set 'has_user_cpus' flag for hybrid system.

The difficulity is that we can't call perf_pmu__has_hybrid() in evlist.c
to check hybrid system otherwise 'perf test python' would be failed
(undefined symbol for perf_pmu__has_hybrid). If we add pmu.c to
python-ext-sources, too many symbol dependencies are hard to resolve.

We use an alternative method by using a new 'hybrid' flag in target
for hybrid system checking.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v3:
 - No change.

v2:
 - New in v2.

 tools/perf/util/evlist.c | 2 +-
 tools/perf/util/target.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 47581a237c7a..06f8890816c3 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1002,7 +1002,7 @@ int evlist__create_maps(struct evlist *evlist, struct target *target)
 	if (!cpus)
 		goto out_delete_threads;
 
-	evlist->core.has_user_cpus = !!target->cpu_list;
+	evlist->core.has_user_cpus = !!target->cpu_list && !target->hybrid;
 
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
index 4ff56217f2a6..daec6cba500d 100644
--- a/tools/perf/util/target.h
+++ b/tools/perf/util/target.h
@@ -17,6 +17,7 @@ struct target {
 	bool	     default_per_cpu;
 	bool	     per_thread;
 	bool	     use_bpf;
+	bool	     hybrid;
 	const char   *attr_map;
 };
 
-- 
2.17.1

