Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B824336CDB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 08:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhCKHJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:09:43 -0500
Received: from mga04.intel.com ([192.55.52.120]:22599 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231623AbhCKHJS (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:09:18 -0500
IronPort-SDR: L7+Q7Y0zSjrwNFpj5HBOolp0ccvO9/L6FqnH7Lt6tazIBcv2mQwMFzzdkApUyQqTTK/0trPnoc
 KwoOmGjm9snQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="186246124"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="186246124"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 23:09:17 -0800
IronPort-SDR: ZWK/Dq2in1eswEAc5H2weDhwrrV/iHeAk8Y/mMZh1z8NRL6E7zL4EZWY1BzSE700M3R6yMVOlY
 fS211KI5u8Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="509938028"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 23:09:15 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 24/27] perf tests: Support 'Session topology' test for hybrid
Date:   Thu, 11 Mar 2021 15:07:39 +0800
Message-Id: <20210311070742.9318-25-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210311070742.9318-1-yao.jin@linux.intel.com>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Force to create one event "cpu_core/cycles/" by default,
otherwise in evlist__valid_sample_type, the checking of
'if (evlist->core.nr_entries == 1)' would be failed.

root@otcpl-adl-s-2:~# ./perf test 41
41: Session topology                                                : Ok

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/tests/topology.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 74748ed75b2c..0f6e73baab2d 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -40,7 +40,15 @@ static int session_write_header(char *path)
 	session = perf_session__new(&data, false, NULL);
 	TEST_ASSERT_VAL("can't get session", !IS_ERR(session));
 
-	session->evlist = evlist__new_default();
+	perf_pmu__scan(NULL);
+	if (!perf_pmu__hybrid_exist()) {
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

