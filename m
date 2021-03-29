Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E9234C483
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhC2HDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:03:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:20002 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231382AbhC2HCq (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:02:46 -0400
IronPort-SDR: ExefGAyQnw/PJCa6ASB8M1bQ4fsMQCNb2poCXr3/0Ul9b6TODWHk13ai392X9PzmgovM3BBx5d
 JC5uDEDC4gxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="190956324"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="190956324"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:02:46 -0700
IronPort-SDR: trnCpWIHh7jU2I5vjunfrRm3NrzdCUQPjBZpAsF+GfT8brtqWoZv6jPeJZojc8NuNdCUPukKuz
 9jAtRmrmy1Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="444677656"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2021 00:02:44 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 24/27] perf tests: Support 'Session topology' test for hybrid
Date:   Mon, 29 Mar 2021 15:00:43 +0800
Message-Id: <20210329070046.8815-25-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329070046.8815-1-yao.jin@linux.intel.com>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Force to create one event "cpu_core/cycles/" by default,
otherwise in evlist__valid_sample_type, the checking of
'if (evlist->core.nr_entries == 1)' would be failed.

  # ./perf test 41
  41: Session topology                                                : Ok

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v3:
 - No functional change.

 tools/perf/tests/topology.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 050489807a47..30b4acb08d35 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -8,6 +8,7 @@
 #include "session.h"
 #include "evlist.h"
 #include "debug.h"
+#include "pmu.h"
 #include <linux/err.h>
 
 #define TEMPL "/tmp/perf-test-XXXXXX"
@@ -40,7 +41,14 @@ static int session_write_header(char *path)
 	session = perf_session__new(&data, false, NULL);
 	TEST_ASSERT_VAL("can't get session", !IS_ERR(session));
 
-	session->evlist = evlist__new_default();
+	if (!perf_pmu__has_hybrid()) {
+		session->evlist = evlist__new_default();
+	} else {
+		struct parse_events_error err;
+
+		session->evlist = evlist__new();
+		parse_events(session->evlist, "cpu_core/cycles/", &err);
+	}
 	TEST_ASSERT_VAL("can't get evlist", session->evlist);
 
 	perf_header__set_feat(&session->header, HEADER_CPU_TOPOLOGY);
-- 
2.17.1

