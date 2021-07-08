Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC463BF3A1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 03:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhGHBlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 21:41:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:38904 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230194AbhGHBlM (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 21:41:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10038"; a="270538753"
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="270538753"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 18:38:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="457708841"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga008.jf.intel.com with ESMTP; 07 Jul 2021 18:38:28 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 3/4] perf tests: Fix 'Roundtrip evsel->name' on core-only system
Date:   Thu,  8 Jul 2021 09:37:00 +0800
Message-Id: <20210708013701.20347-4-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210708013701.20347-1-yao.jin@linux.intel.com>
References: <20210708013701.20347-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the atom CPUs are offlined, the 'cpu_atom' is not valid.
Perf will not create two events for one hw event, so the
evsel->idx doesn't need to be divided by 2 before comparing.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/tests/evsel-roundtrip-name.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
index b74cf80d1f10..26c49dc3e01e 100644
--- a/tools/perf/tests/evsel-roundtrip-name.c
+++ b/tools/perf/tests/evsel-roundtrip-name.c
@@ -5,6 +5,7 @@
 #include "tests.h"
 #include "debug.h"
 #include "pmu.h"
+#include "pmu-hybrid.h"
 #include <errno.h>
 #include <linux/kernel.h>
 
@@ -102,7 +103,7 @@ int test__perf_evsel__roundtrip_name_test(struct test *test __maybe_unused, int
 {
 	int err = 0, ret = 0;
 
-	if (perf_pmu__has_hybrid())
+	if (perf_pmu__has_hybrid() && perf_pmu__hybrid_mounted("cpu_atom"))
 		return perf_evsel__name_array_test(evsel__hw_names, 2);
 
 	err = perf_evsel__name_array_test(evsel__hw_names, 1);
-- 
2.17.1

