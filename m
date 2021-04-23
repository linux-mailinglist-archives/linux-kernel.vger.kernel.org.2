Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56923368CC8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 07:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241046AbhDWFi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 01:38:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:9354 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240757AbhDWFiI (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 01:38:08 -0400
IronPort-SDR: hGP8g9RKrwBHZRSPLTwp93wXKh+11Khu9DkpwU0k8DP2R3xJ/r6Sm5f7S/LvjPRrSFKN4gYXtg
 NauWKUxbKlig==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="183501865"
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="183501865"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 22:37:32 -0700
IronPort-SDR: acXV4SP5K7sil1tKPf6rNhFT7oKUK/DQ2m+95S0OmkH2lGPGKK8l0Pz8AvPTNSpKABWBBbdva5
 8RQyzjVzp7XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="386293737"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga006.jf.intel.com with ESMTP; 22 Apr 2021 22:37:28 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 20/26] perf tests: Skip 'Setup struct perf_event_attr' test for hybrid
Date:   Fri, 23 Apr 2021 13:35:35 +0800
Message-Id: <20210423053541.12521-21-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423053541.12521-1-yao.jin@linux.intel.com>
References: <20210423053541.12521-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For hybrid, the attr.type consists of pmu type id + original type.
There will be much changes for this test. Now we temporarily
skip this test case and TODO in future.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v5:
 - Since it's skip the test case, return TEST_SKIP.

 tools/perf/tests/attr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index dd39ce9b0277..9b40a25376ae 100644
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
+		return TEST_SKIP;
+
 	/* First try development tree tests. */
 	if (!lstat("./tests", &st))
 		return run_dir("./tests", "./perf");
-- 
2.17.1

