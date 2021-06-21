Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12953AEB77
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 16:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhFUOgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 10:36:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:59087 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230347AbhFUOgs (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:36:48 -0400
IronPort-SDR: ILF7bH29yYZaYGEStbdi5vxlrMwt8qSCPMzh9v+SrDXF+uU89UoWbLQnaxfRXWVuo1JhYvVV1J
 yVmnWpkEBfmQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="228402742"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="228402742"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 07:34:34 -0700
IronPort-SDR: 7qT2bgy1yI7niUnQjwl/RPzG9U5YFzktM7EPGENhL0Zsn6ksHO1ky//Q9Jr1kIM8T9TO1CE5YZ
 uPzFfnVDRblQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="641339498"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jun 2021 07:34:32 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 2/3] perf tools: Create hybrid flag in target
Date:   Mon, 21 Jun 2021 22:33:20 +0800
Message-Id: <20210621143321.27451-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210621143321.27451-1-yao.jin@linux.intel.com>
References: <20210621143321.27451-1-yao.jin@linux.intel.com>
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
 tools/perf/util/evlist.c | 2 +-
 tools/perf/util/target.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 6ba9664089bd..4422275d286b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1021,7 +1021,7 @@ int evlist__create_maps(struct evlist *evlist, struct target *target)
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

