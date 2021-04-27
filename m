Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DB436BFB5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237193AbhD0HFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:05:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:54937 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237188AbhD0HEx (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:04:53 -0400
IronPort-SDR: 66eA6xzqxs350hf5mta4Zn+y27XE5TZJSL+hUAqiHcbWUuJMp5uzV0ha538xWX32srXV5fl1v6
 vCAxpbZJxL9A==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="196573075"
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="196573075"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 00:04:10 -0700
IronPort-SDR: Ahtv7fVmqJ6YAtAU2xW8T+/8l6hc8bR7uZMwjIP4CzISGK9+aWuMI35NyilXhi5mRuYwgDmQUh
 B6e9hP15E8eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="447507028"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2021 00:04:08 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 23/26] perf tests: Support 'Session topology' test for hybrid
Date:   Tue, 27 Apr 2021 15:01:36 +0800
Message-Id: <20210427070139.25256-24-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427070139.25256-1-yao.jin@linux.intel.com>
References: <20210427070139.25256-1-yao.jin@linux.intel.com>
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
v6:
 - No change.

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

