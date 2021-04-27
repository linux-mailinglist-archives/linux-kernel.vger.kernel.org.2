Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FFD36BFB1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237309AbhD0HFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:05:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:54964 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236782AbhD0HEq (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:04:46 -0400
IronPort-SDR: whyr3Jvwy9r+W+Io1ECAfH7ZpfCem+2eblQe8UTDfXby6tl/Tvs9ZN+9KxQjlw74JpDaSvScjH
 cm8DhdHOoOMA==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="196573060"
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="196573060"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 00:04:03 -0700
IronPort-SDR: bRgyqKXAHtpO/2zjFJ247xtc/tO4HixXVtM61zwzVP2bVLmcqs+6jfq2boLW6WiDe+KU7ERWfC
 vChUWYt28qBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="447506992"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2021 00:04:00 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 20/26] perf tests: Skip 'Setup struct perf_event_attr' test for hybrid
Date:   Tue, 27 Apr 2021 15:01:33 +0800
Message-Id: <20210427070139.25256-21-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427070139.25256-1-yao.jin@linux.intel.com>
References: <20210427070139.25256-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For hybrid, the attr.type consists of pmu type id + original type.
There will be much changes for this test. Now we temporarily
skip this test case and TODO in future.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v6:
 - No change.

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

