Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD6E36BFB0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbhD0HEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:04:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:54937 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236422AbhD0HEk (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:04:40 -0400
IronPort-SDR: owBosdtkTYlsZrc9I7+LuxKEjmGersf+VehVNJC5zpp8GVC8nJDDo8gJGuJc/MOIvPbxQs/zMp
 PPr908Ui66mQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="196573041"
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="196573041"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 00:03:58 -0700
IronPort-SDR: 33NPnq49KFqaVHJ7ZR42UXSIVwAwS9V4VaYi9d6NrrjuVGwFqMTVXjfxQ1L/5jV2k1104mc+Qv
 c8+UMikR+JlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="447506970"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2021 00:03:55 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 18/26] perf tests: Add hybrid cases for 'Parse event definition strings' test
Date:   Tue, 27 Apr 2021 15:01:31 +0800
Message-Id: <20210427070139.25256-19-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427070139.25256-1-yao.jin@linux.intel.com>
References: <20210427070139.25256-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic hybrid test cases for 'Parse event definition strings' test.

  # perf test 6
   6: Parse event definition strings                                  : Ok

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v6:
 - Add test case for parsing cache events with pmu prefix.

v5:
 - No change.

 tools/perf/tests/parse-events.c | 171 ++++++++++++++++++++++++++++++++
 1 file changed, 171 insertions(+)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 026c54743311..0f113b2b36a3 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1512,6 +1512,124 @@ static int test__all_tracepoints(struct evlist *evlist)
 	return test__checkevent_tracepoint_multi(evlist);
 }
 
+static int test__hybrid_hw_event_with_pmu(struct evlist *evlist)
+{
+	struct evsel *evsel = evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", 0x3c == evsel->core.attr.config);
+	return 0;
+}
+
+static int test__hybrid_hw_group_event(struct evlist *evlist)
+{
+	struct evsel *evsel, *leader;
+
+	evsel = leader = evlist__first(evlist);
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", 0x3c == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+
+	evsel = evsel__next(evsel);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", 0xc0 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	return 0;
+}
+
+static int test__hybrid_sw_hw_group_event(struct evlist *evlist)
+{
+	struct evsel *evsel, *leader;
+
+	evsel = leader = evlist__first(evlist);
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+
+	evsel = evsel__next(evsel);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", 0x3c == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	return 0;
+}
+
+static int test__hybrid_hw_sw_group_event(struct evlist *evlist)
+{
+	struct evsel *evsel, *leader;
+
+	evsel = leader = evlist__first(evlist);
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", 0x3c == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+
+	evsel = evsel__next(evsel);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	return 0;
+}
+
+static int test__hybrid_group_modifier1(struct evlist *evlist)
+{
+	struct evsel *evsel, *leader;
+
+	evsel = leader = evlist__first(evlist);
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", 0x3c == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
+	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
+
+	evsel = evsel__next(evsel);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", 0xc0 == evsel->core.attr.config);
+	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
+	return 0;
+}
+
+static int test__hybrid_raw1(struct evlist *evlist)
+{
+	struct evsel *evsel = evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
+
+	/* The type of second event is randome value */
+	evsel = evsel__next(evsel);
+	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
+	return 0;
+}
+
+static int test__hybrid_raw2(struct evlist *evlist)
+{
+	struct evsel *evsel = evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", 0x1a == evsel->core.attr.config);
+	return 0;
+}
+
+static int test__hybrid_cache_event(struct evlist *evlist)
+{
+	struct evsel *evsel = evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HW_CACHE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", 0x2 == (evsel->core.attr.config & 0xffffffff));
+
+	evsel = evsel__next(evsel);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HW_CACHE == evsel->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", 0x10002 == (evsel->core.attr.config & 0xffffffff));
+	return 0;
+}
+
 struct evlist_test {
 	const char *name;
 	__u32 type;
@@ -1868,6 +1986,54 @@ static struct terms_test test__terms[] = {
 	},
 };
 
+static struct evlist_test test__hybrid_events[] = {
+	{
+		.name  = "cpu_core/cpu-cycles/",
+		.check = test__hybrid_hw_event_with_pmu,
+		.id    = 0,
+	},
+	{
+		.name  = "{cpu_core/cpu-cycles/,cpu_core/instructions/}",
+		.check = test__hybrid_hw_group_event,
+		.id    = 1,
+	},
+	{
+		.name  = "{cpu-clock,cpu_core/cpu-cycles/}",
+		.check = test__hybrid_sw_hw_group_event,
+		.id    = 2,
+	},
+	{
+		.name  = "{cpu_core/cpu-cycles/,cpu-clock}",
+		.check = test__hybrid_hw_sw_group_event,
+		.id    = 3,
+	},
+	{
+		.name  = "{cpu_core/cpu-cycles/k,cpu_core/instructions/u}",
+		.check = test__hybrid_group_modifier1,
+		.id    = 4,
+	},
+	{
+		.name  = "r1a",
+		.check = test__hybrid_raw1,
+		.id    = 5,
+	},
+	{
+		.name  = "cpu_core/r1a/",
+		.check = test__hybrid_raw2,
+		.id    = 6,
+	},
+	{
+		.name  = "cpu_core/config=10,config1,config2=3,period=1000/u",
+		.check = test__checkevent_pmu,
+		.id    = 7,
+	},
+	{
+		.name  = "cpu_core/LLC-loads/,cpu_atom/LLC-load-misses/",
+		.check = test__hybrid_cache_event,
+		.id    = 8,
+	},
+};
+
 static int test_event(struct evlist_test *e)
 {
 	struct parse_events_error err;
@@ -2035,6 +2201,11 @@ do {							\
 		ret2 = ret1;				\
 } while (0)
 
+	if (perf_pmu__has_hybrid()) {
+		TEST_EVENTS(test__hybrid_events);
+		return ret2;
+	}
+
 	TEST_EVENTS(test__events);
 
 	if (test_pmu())
-- 
2.17.1

