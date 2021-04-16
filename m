Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BA73621CB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242332AbhDPOJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:09:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:23086 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236380AbhDPOJB (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:09:01 -0400
IronPort-SDR: 9bFlRo1Hxr9eKws2vXYQe7cn+XTxyaVz0HHjuFmG0/7IqJuR1DQKfx7QNcMUlNz0Oh4GUo4o7T
 Me59VcsNc45w==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="191854434"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="191854434"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 07:07:29 -0700
IronPort-SDR: ved0cnxq/YNsDtJStPEsAUjYm53kn7fGGGp03pp/dRIu0EH9l/xB5AerIGqS9q1h3CPyKeZmu/
 Gd7i3FwJ/AbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="612766978"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga006.fm.intel.com with ESMTP; 16 Apr 2021 07:07:26 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 23/25] perf tests: Support 'Session topology' test for hybrid
Date:   Fri, 16 Apr 2021 22:05:15 +0800
Message-Id: <20210416140517.18206-24-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210416140517.18206-1-yao.jin@linux.intel.com>
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
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

