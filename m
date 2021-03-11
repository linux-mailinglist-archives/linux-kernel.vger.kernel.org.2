Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD877336CD7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 08:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhCKHJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:09:38 -0500
Received: from mga04.intel.com ([192.55.52.120]:22599 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231829AbhCKHJI (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:09:08 -0500
IronPort-SDR: HZSJ+iEltRpQ3QNExiAlevjpLCmBDiyLu1SmCops5Uud8AASfUhKNhUgSAsWf6LImZmm8wPZOJ
 D5ITLV/ApCvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="186246102"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="186246102"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 23:09:08 -0800
IronPort-SDR: sLoevnPg5xJ/bvNY7y2MYsSF4uPxn9NdVXLyd+U+3Ca8EIMaRixw/MFaQ0UaQL0Jg0nH1ZgrG1
 NKbBa61YoThQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="509938000"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 23:09:05 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 20/27] perf tests: Add hybrid cases for 'Roundtrip evsel->name' test
Date:   Thu, 11 Mar 2021 15:07:35 +0800
Message-Id: <20210311070742.9318-21-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210311070742.9318-1-yao.jin@linux.intel.com>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since for one hw event, two hybrid events are created.

For example,

evsel->idx	evsel__name(evsel)
0		cycles
1		cycles
2		instructions
3		instructions
...

So for comparing the evsel name on hybrid, the evsel->idx
needs to be divided by 2.

root@otcpl-adl-s-2:~# ./perf test 14
14: Roundtrip evsel->name                                           : Ok

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/tests/evsel-roundtrip-name.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
index f7f3e5b4c180..2b938a15901e 100644
--- a/tools/perf/tests/evsel-roundtrip-name.c
+++ b/tools/perf/tests/evsel-roundtrip-name.c
@@ -62,7 +62,8 @@ static int perf_evsel__roundtrip_cache_name_test(void)
 	return ret;
 }
 
-static int __perf_evsel__name_array_test(const char *names[], int nr_names)
+static int __perf_evsel__name_array_test(const char *names[], int nr_names,
+					 int distance)
 {
 	int i, err;
 	struct evsel *evsel;
@@ -82,9 +83,9 @@ static int __perf_evsel__name_array_test(const char *names[], int nr_names)
 
 	err = 0;
 	evlist__for_each_entry(evlist, evsel) {
-		if (strcmp(evsel__name(evsel), names[evsel->idx])) {
+		if (strcmp(evsel__name(evsel), names[evsel->idx / distance])) {
 			--err;
-			pr_debug("%s != %s\n", evsel__name(evsel), names[evsel->idx]);
+			pr_debug("%s != %s\n", evsel__name(evsel), names[evsel->idx / distance]);
 		}
 	}
 
@@ -93,18 +94,22 @@ static int __perf_evsel__name_array_test(const char *names[], int nr_names)
 	return err;
 }
 
-#define perf_evsel__name_array_test(names) \
-	__perf_evsel__name_array_test(names, ARRAY_SIZE(names))
+#define perf_evsel__name_array_test(names, distance) \
+	__perf_evsel__name_array_test(names, ARRAY_SIZE(names), distance)
 
 int test__perf_evsel__roundtrip_name_test(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	int err = 0, ret = 0;
 
-	err = perf_evsel__name_array_test(evsel__hw_names);
+	perf_pmu__scan(NULL);
+	if (perf_pmu__hybrid_exist())
+		return perf_evsel__name_array_test(evsel__hw_names, 2);
+
+	err = perf_evsel__name_array_test(evsel__hw_names, 1);
 	if (err)
 		ret = err;
 
-	err = __perf_evsel__name_array_test(evsel__sw_names, PERF_COUNT_SW_DUMMY + 1);
+	err = __perf_evsel__name_array_test(evsel__sw_names, PERF_COUNT_SW_DUMMY + 1, 1);
 	if (err)
 		ret = err;
 
-- 
2.17.1

