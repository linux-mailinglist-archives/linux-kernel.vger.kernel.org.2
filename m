Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E5E336CDC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 08:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhCKHJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:09:45 -0500
Received: from mga04.intel.com ([192.55.52.120]:22599 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231862AbhCKHJU (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:09:20 -0500
IronPort-SDR: 4tbRy+i8a1jhl87wYXFoTPbnebqxuzry0BVFXT5teX1wEcQjkIQ31G6VxNZKU3F5uoAGNDk74+
 7ml5jxAZI3ZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="186246127"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="186246127"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 23:09:20 -0800
IronPort-SDR: kRP1gcyWKMIklg9pYh+zhA0T4A7/3W5TkdfBicbcF/kUseaQDuV2WAxUPAEvLU3QfPrJ+SyKoO
 KGa5waO38nGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="509938039"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 23:09:18 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 25/27] perf tests: Support 'Convert perf time to TSC' test for hybrid
Date:   Thu, 11 Mar 2021 15:07:40 +0800
Message-Id: <20210311070742.9318-26-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210311070742.9318-1-yao.jin@linux.intel.com>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since for "cycles:u' on hybrid platform, it creates two "cycles".
So the second evsel in evlist also needs initialization.

With this patch,

root@otcpl-adl-s-2:~# ./perf test 71
71: Convert perf time to TSC                                        : Ok

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/tests/perf-time-to-tsc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index 680c3cffb128..b472205ec8e3 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -66,6 +66,11 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	u64 test_tsc, comm1_tsc, comm2_tsc;
 	u64 test_time, comm1_time = 0, comm2_time = 0;
 	struct mmap *md;
+	bool hybrid = false;
+
+	perf_pmu__scan(NULL);
+	if (perf_pmu__hybrid_exist())
+		hybrid = true;
 
 	threads = thread_map__new(-1, getpid(), UINT_MAX);
 	CHECK_NOT_NULL__(threads);
@@ -88,6 +93,17 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	evsel->core.attr.disabled = 1;
 	evsel->core.attr.enable_on_exec = 0;
 
+	/*
+	 * For hybrid "cycles:u", it creates two events.
+	 * Init the second evsel here.
+	 */
+	if (hybrid) {
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

