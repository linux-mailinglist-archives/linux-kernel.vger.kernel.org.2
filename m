Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90100368CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 07:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241062AbhDWFii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 01:38:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:9365 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240936AbhDWFiT (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 01:38:19 -0400
IronPort-SDR: 2uqcJ0NdC93oQrG9vo95xYzFN5PWMOUDtqgfOFOJWTo83X/0Pk0xPQoX0JErRqWP1/aK0VuKSb
 6bx5jSJxg6GQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="183501886"
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="183501886"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 22:37:43 -0700
IronPort-SDR: q/FA4cQDX4LQN56HB8vX3762t+y9e831N8Srs0FZ8K0jp7YYTDRRaqdfXd9VX86ppKtCDobyss
 xvNxwW0QjDyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="386293779"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga006.jf.intel.com with ESMTP; 22 Apr 2021 22:37:41 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 24/26] perf tests: Support 'Convert perf time to TSC' test for hybrid
Date:   Fri, 23 Apr 2021 13:35:39 +0800
Message-Id: <20210423053541.12521-25-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423053541.12521-1-yao.jin@linux.intel.com>
References: <20210423053541.12521-1-yao.jin@linux.intel.com>
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

