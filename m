Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6B13AEB74
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 16:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhFUOgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 10:36:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:59087 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230263AbhFUOgq (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:36:46 -0400
IronPort-SDR: 5Drgx41BqKZk8eou0q/ge+w6eyPcmg0wFk6Iq21miWP/e9/fTtcFlb6RH6Q6LP30eoJzR1Q34r
 Ms4VkpyG/D6w==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="228402735"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="228402735"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 07:34:31 -0700
IronPort-SDR: hcasAgX/2ESsy7gKRA0GCYF5+UkevKxcIkuLu6BU7EYaot6mCsjtESPqDMgY4hDDV0bPq44FJ3
 82inY1dvaBXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="641339485"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jun 2021 07:34:29 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 1/3] libperf: Add perf_cpu_map__default_new()
Date:   Mon, 21 Jun 2021 22:33:19 +0800
Message-Id: <20210621143321.27451-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The libperf already has a static function 'cpu_map__default_new()'.
Add a new API perf_cpu_map__default_new() to export the function.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/lib/perf/cpumap.c              | 5 +++++
 tools/lib/perf/include/perf/cpumap.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index ca0215047c32..51b6553912e0 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -68,6 +68,11 @@ static struct perf_cpu_map *cpu_map__default_new(void)
 	return cpus;
 }
 
+struct perf_cpu_map *perf_cpu_map__default_new(void)
+{
+	return cpu_map__default_new();
+}
+
 static int cmp_int(const void *a, const void *b)
 {
 	return *(const int *)a - *(const int*)b;
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 6a17ad730cbc..7c27766ea0bf 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -9,6 +9,7 @@
 struct perf_cpu_map;
 
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
+LIBPERF_API struct perf_cpu_map *perf_cpu_map__default_new(void);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
-- 
2.17.1

