Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A70368CCB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 07:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241103AbhDWFig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 01:38:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:9365 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240701AbhDWFiQ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 01:38:16 -0400
IronPort-SDR: XCuklM3OGLPIL2in2k9+YXo5691rN3Y7vRRwwxlnHZ5NdakMJwDYmi919tXPoQQxocxsAZVG65
 cq5hgcUL3E3A==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="183501880"
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="183501880"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 22:37:40 -0700
IronPort-SDR: E8iAdK22usFOjA5zPG150ntWRbmz+8N/P9ne3eD3VMBPBagqlHDFKzGEYjYmZD0iIOBQuAHyD2
 zbMyn+PmitnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="386293771"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga006.jf.intel.com with ESMTP; 22 Apr 2021 22:37:38 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 23/26] perf tests: Support 'Session topology' test for hybrid
Date:   Fri, 23 Apr 2021 13:35:38 +0800
Message-Id: <20210423053541.12521-24-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423053541.12521-1-yao.jin@linux.intel.com>
References: <20210423053541.12521-1-yao.jin@linux.intel.com>
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
v5:
 - Add "TEST_ASSERT_VAL session->evlist".

 tools/perf/tests/topology.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 050489807a47..ec4e3b21b831 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -8,6 +8,7 @@
 #include "session.h"
 #include "evlist.h"
 #include "debug.h"
+#include "pmu.h"
 #include <linux/err.h>
 
 #define TEMPL "/tmp/perf-test-XXXXXX"
@@ -40,8 +41,16 @@ static int session_write_header(char *path)
 	session = perf_session__new(&data, false, NULL);
 	TEST_ASSERT_VAL("can't get session", !IS_ERR(session));
 
-	session->evlist = evlist__new_default();
-	TEST_ASSERT_VAL("can't get evlist", session->evlist);
+	if (!perf_pmu__has_hybrid()) {
+		session->evlist = evlist__new_default();
+		TEST_ASSERT_VAL("can't get evlist", session->evlist);
+	} else {
+		struct parse_events_error err;
+
+		session->evlist = evlist__new();
+		TEST_ASSERT_VAL("can't get evlist", session->evlist);
+		parse_events(session->evlist, "cpu_core/cycles/", &err);
+	}
 
 	perf_header__set_feat(&session->header, HEADER_CPU_TOPOLOGY);
 	perf_header__set_feat(&session->header, HEADER_NRCPUS);
-- 
2.17.1

