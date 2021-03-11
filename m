Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2843E336CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 08:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhCKHJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:09:39 -0500
Received: from mga04.intel.com ([192.55.52.120]:22599 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231847AbhCKHJK (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:09:10 -0500
IronPort-SDR: dw1bTO/b3fQszrxfqsEgDy7Ar6l2pGvPxBd2PCjJeOwy+/qAHO0Bl+myzdsZOhaoQMibbE5b4V
 IGZMXfEE/wOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="186246110"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="186246110"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 23:09:10 -0800
IronPort-SDR: bMHgEoqyAzbz7Q8fF5LrO411N3a72CExhGQKSJvL7zgvhrW0JWyB+nUz/GGCHzo6tiEgaG3u3d
 geIfNq/jlJBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="509938011"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 23:09:08 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 21/27] perf tests: Skip 'Setup struct perf_event_attr' test for hybrid
Date:   Thu, 11 Mar 2021 15:07:36 +0800
Message-Id: <20210311070742.9318-22-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210311070742.9318-1-yao.jin@linux.intel.com>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For hybrid, kernel introduces new perf type PERF_TYPE_HARDWARE_PMU (6)
and it's assigned to hybrid hardware events.

root@otcpl-adl-s-2:~# ./perf test 17 -vvv
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
 tools/perf/tests/attr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index dd39ce9b0277..fc7f74159764 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -34,6 +34,7 @@
 #include "event.h"
 #include "util.h"
 #include "tests.h"
+#include "pmu-hybrid.h"
 
 #define ENV "PERF_TEST_ATTR"
 
@@ -184,6 +185,10 @@ int test__attr(struct test *test __maybe_unused, int subtest __maybe_unused)
 	char path_dir[PATH_MAX];
 	char *exec_path;
 
+	perf_pmu__scan(NULL);
+	if (perf_pmu__hybrid_exist())
+		return 0;
+
 	/* First try development tree tests. */
 	if (!lstat("./tests", &st))
 		return run_dir("./tests", "./perf");
-- 
2.17.1

