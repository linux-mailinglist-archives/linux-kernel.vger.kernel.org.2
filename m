Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B743BF3A2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 03:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhGHBlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 21:41:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:38904 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230249AbhGHBlO (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 21:41:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10038"; a="270538760"
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="270538760"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 18:38:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="457708849"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga008.jf.intel.com with ESMTP; 07 Jul 2021 18:38:31 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 4/4] perf tests: Fix 'Convert perf time to TSC' on core-only system
Date:   Thu,  8 Jul 2021 09:37:01 +0800
Message-Id: <20210708013701.20347-5-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210708013701.20347-1-yao.jin@linux.intel.com>
References: <20210708013701.20347-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the atom CPUs are offlined, the 'cpu_atom' is not valid.
We don't need the test case for 'cpu_atom'.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/tests/perf-time-to-tsc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index 85d75b9b25a1..7c56bc1f4cff 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -21,6 +21,7 @@
 #include "mmap.h"
 #include "tests.h"
 #include "pmu.h"
+#include "pmu-hybrid.h"
 
 #define CHECK__(x) {				\
 	while ((x) < 0) {			\
@@ -93,7 +94,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	 * For hybrid "cycles:u", it creates two events.
 	 * Init the second evsel here.
 	 */
-	if (perf_pmu__has_hybrid()) {
+	if (perf_pmu__has_hybrid() && perf_pmu__hybrid_mounted("cpu_atom")) {
 		evsel = evsel__next(evsel);
 		evsel->core.attr.comm = 1;
 		evsel->core.attr.disabled = 1;
-- 
2.17.1

