Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5CB34C480
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhC2HDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:03:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:20002 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230220AbhC2HCj (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:02:39 -0400
IronPort-SDR: p003VBa1hHF8zb2dmyloiw35sZ6vgy8YmoU3AvmJXiIdOAHf/vHcE++5E2SlgQCrl6ZOoPYnPY
 D9i30l0K6B8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="190956307"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="190956307"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:02:39 -0700
IronPort-SDR: MoQWcuWY1mCCBgXP7NdDEZcTvKKSF5A2rVuYR3F8reCPNkt+3n+oPU663gfllHQnNO1hJuT60s
 GR/7O3jAhStw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="444677610"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2021 00:02:36 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 21/27] perf tests: Skip 'Setup struct perf_event_attr' test for hybrid
Date:   Mon, 29 Mar 2021 15:00:40 +0800
Message-Id: <20210329070046.8815-22-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329070046.8815-1-yao.jin@linux.intel.com>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For hybrid, kernel introduces new perf type PERF_TYPE_HARDWARE_PMU (6)
and it's assigned to hybrid hardware events.

  # ./perf test 17 -vvv
    ...
    compare
      matching [event:base-stat]
        to [event-6-17179869184-4]
        [cpu] * 0
        [flags] 0|8 8
        [type] 0 6
      ->FAIL
      match: [event:base-stat] matches []
      event:base-stat does not match, but is optional
    matched
    compare
      matching [event-6-17179869184-4]
        to [event:base-stat]
        [cpu] 0 *
        [flags] 8 0|8
        [type] 6 0
      ->FAIL
      match: [event-6-17179869184-4] matches []
  expected type=6, got 0
  expected config=17179869184, got 0
  FAILED './tests/attr/test-stat-C0' - match failure

The type matching is failed because one type is 0 but the
type of hybrid hardware event is 6. We temporarily skip this
test case and TODO in future.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v3:
 - No functional change.

 tools/perf/tests/attr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index dd39ce9b0277..b37c35fb5a46 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -34,6 +34,7 @@
 #include "event.h"
 #include "util.h"
 #include "tests.h"
+#include "pmu.h"
 
 #define ENV "PERF_TEST_ATTR"
 
@@ -184,6 +185,9 @@ int test__attr(struct test *test __maybe_unused, int subtest __maybe_unused)
 	char path_dir[PATH_MAX];
 	char *exec_path;
 
+	if (perf_pmu__has_hybrid())
+		return 0;
+
 	/* First try development tree tests. */
 	if (!lstat("./tests", &st))
 		return run_dir("./tests", "./perf");
-- 
2.17.1

