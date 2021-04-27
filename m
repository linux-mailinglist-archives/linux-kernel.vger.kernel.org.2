Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A86336BFB6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbhD0HFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:05:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:54973 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237254AbhD0HE4 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:04:56 -0400
IronPort-SDR: U0Iq8NbckeX6tobgF1ILq7wfdk7n6D2z6aGL2o+6FMyaSKUYRi0XXQX6I0MyopJXcMAL8+97Ce
 3zyrmy1fjT6Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="196573085"
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="196573085"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 00:04:13 -0700
IronPort-SDR: UXJqBme/7NwARZ3MAI36rc1M5Tz4mHU6nbdDsqB6FuVwrPbFH7g4HlotW4FGs9Vr6AkekziLES
 yhL9Fb1o7cKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="447507039"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2021 00:04:10 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 24/26] perf tests: Support 'Convert perf time to TSC' test for hybrid
Date:   Tue, 27 Apr 2021 15:01:37 +0800
Message-Id: <20210427070139.25256-25-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427070139.25256-1-yao.jin@linux.intel.com>
References: <20210427070139.25256-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since for "cycles:u' on hybrid platform, it creates two "cycles".
So the second evsel in evlist also needs initialization.

With this patch,

  # ./perf test 71
  71: Convert perf time to TSC                                        : Ok

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v6:
 - No change.

v5:
 - Drop the variable 'hybrid' and use 'if (perf_pmu__has_hybrid())'.

 tools/perf/tests/perf-time-to-tsc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index 680c3cffb128..85d75b9b25a1 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -20,6 +20,7 @@
 #include "tsc.h"
 #include "mmap.h"
 #include "tests.h"
+#include "pmu.h"
 
 #define CHECK__(x) {				\
 	while ((x) < 0) {			\
@@ -88,6 +89,17 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	evsel->core.attr.disabled = 1;
 	evsel->core.attr.enable_on_exec = 0;
 
+	/*
+	 * For hybrid "cycles:u", it creates two events.
+	 * Init the second evsel here.
+	 */
+	if (perf_pmu__has_hybrid()) {
+		evsel = evsel__next(evsel);
+		evsel->core.attr.comm = 1;
+		evsel->core.attr.disabled = 1;
+		evsel->core.attr.enable_on_exec = 0;
+	}
+
 	CHECK__(evlist__open(evlist));
 
 	CHECK__(evlist__mmap(evlist, UINT_MAX));
-- 
2.17.1

