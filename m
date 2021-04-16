Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE613621C3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbhDPOJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:09:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:23086 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241863AbhDPOIA (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:08:00 -0400
IronPort-SDR: y+3E1UpHv2dIVWuIYdImN5Z6/wEwv3CltVS86NOydi5vcU4kuTRyNU/COArnD/Fs+DaiQTFLB/
 cCpKoOgMa3Xg==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="191854397"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="191854397"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 07:07:19 -0700
IronPort-SDR: +VCllLRugaJPeZuWnSQohWdaqeQMcPLQA291tQCl59GrxjTt5q4+lfzdfJ6rSIfk7vjEpuKaZd
 z+Aa3Q+5jvfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="612766911"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga006.fm.intel.com with ESMTP; 16 Apr 2021 07:07:15 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 20/25] perf tests: Skip 'Setup struct perf_event_attr' test for hybrid
Date:   Fri, 16 Apr 2021 22:05:12 +0800
Message-Id: <20210416140517.18206-21-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210416140517.18206-1-yao.jin@linux.intel.com>
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For hybrid, the attr.type consists of pmu type id + original type.
There will be much changes for this test. Now we temporarily
skip this test case and TODO in future.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
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

