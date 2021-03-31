Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39B334C47E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhC2HDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:03:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:20002 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231354AbhC2HCc (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:02:32 -0400
IronPort-SDR: VkbhS/opidxIbiKoTSd/5gAS1wSWmK5qXNeRk6KWTrgVbh/SWBtoyXJuQCJYHElum7OPMwwgob
 u3pd5D+IiSJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="190956293"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="190956293"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:02:32 -0700
IronPort-SDR: ThGfwo6cGGsrVB/NNWTbjmVBhmKus+xJgkaPVXKaWOHGWdM7lWpG4hTKVe1p8GfAhww06urAqL
 lQeHq4Tq+SzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="444677576"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2021 00:02:29 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 19/27] perf tests: Add hybrid cases for 'Parse event definition strings' test
Date:   Mon, 29 Mar 2021 15:00:38 +0800
Message-Id: <20210329070046.8815-20-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329070046.8815-1-yao.jin@linux.intel.com>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic hybrid test cases for 'Parse event definition strings' test.

  # ./perf test 6
   6: Parse event definition strings                                  : Ok

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v3:
 - Use PERF_TYPE_RAW for cpu_core/cycles/

 tools/perf/tests/parse-events.c | 170 ++++++++++++++++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 026c54743311..1cd1d2778172 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1512,6 +1512,123 @@ static int test__all_tracepoints(struct evlist *evlist)
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
+static int test__hybrid_hw_event(struct evlist *evlist)
+{
+	struct evsel *evsel1 = evlist__first(evlist);
+	struct evsel *evsel2 = evlist__last(evlist);
+
+	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE_PMU == evsel1->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", 0x400000000 == evsel1->core.attr.config);
+	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE_PMU == evsel2->core.attr.type);
+	TEST_ASSERT_VAL("wrong config", 0xa00000000 == evsel2->core.attr.config);
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
 struct evlist_test {
 	const char *name;
 	__u32 type;
@@ -1868,6 +1985,54 @@ static struct terms_test test__terms[] = {
 	},
 };
 
+static struct evlist_test test__hybrid_events[] = {
+	{
+		.name  = "cpu_core/cpu-cycles/",
+		.check = test__hybrid_hw_event_with_pmu,
+		.id    = 0,
+	},
+	{
+		.name  = "cycles",
+		.check = test__hybrid_hw_event,
+		.id    = 1,
+	},
+	{
+		.name  = "{cpu_core/cycles/,cpu_core/instructions/}",
+		.check = test__hybrid_hw_group_event,
+		.id    = 2,
+	},
+	{
+		.name  = "{cpu-clock,cpu_core/cycles/}",
+		.check = test__hybrid_sw_hw_group_event,
+		.id    = 3,
+	},
+	{
+		.name  = "{cpu_core/cycles/,cpu-clock}",
+		.check = test__hybrid_hw_sw_group_event,
+		.id    = 4,
+	},
+	{
+		.name  = "{cpu_core/cycles/k,cpu_core/instructions/u}",
+		.check = test__hybrid_group_modifier1,
+		.id    = 5,
+	},
+	{
+		.name  = "r1a",
+		.check = test__hybrid_raw1,
+		.id    = 6,
+	},
+	{
+		.name  = "cpu_core/r1a/",
+		.check = test__hybrid_raw2,
+		.id    = 7,
+	},
+	{
+		.name  = "cpu_core/config=10,config1,config2=3,period=1000/u",
+		.check = test__checkevent_pmu,
+		.id    = 0,
+	},
+};
+
 static int test_event(struct evlist_test *e)
 {
 	struct parse_events_error err;
@@ -2035,6 +2200,11 @@ do {							\
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

