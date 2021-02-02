Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A8230CCF6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 21:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbhBBUWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 15:22:52 -0500
Received: from mga14.intel.com ([192.55.52.115]:60285 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232982AbhBBUUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:20:22 -0500
IronPort-SDR: 7xwQqtVbPLlwNrU0+MSvWme4+mPZwK6gaeECGJPXSrdd9a7lO84T/HnX8Ae8HavM0uwuJlnFpD
 abjd+seX5kzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="180148817"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="180148817"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 12:14:13 -0800
IronPort-SDR: kn+B8uYgzOz8/wCQwjNbJzpwPiRV8zwRXVuPB58LK2uC13ymoGNhprgA+kBYea8xzozLeOBwqD
 P5s1BXQ6+n7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="356442515"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 02 Feb 2021 12:14:13 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, eranian@google.com, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        maddy@linux.vnet.ibm.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 7/9] perf test: Support PERF_SAMPLE_WEIGHT_STRUCT
Date:   Tue,  2 Feb 2021 12:09:11 -0800
Message-Id: <1612296553-21962-8-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Support the new sample type for sample-parsing test case.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/sample-parsing.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 2393916..c5739cc 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -129,6 +129,9 @@ static bool samples_same(const struct perf_sample *s1,
 	if (type & PERF_SAMPLE_WEIGHT)
 		COMP(weight);
 
+	if (type & PERF_SAMPLE_WEIGHT_STRUCT)
+		COMP(ins_lat);
+
 	if (type & PERF_SAMPLE_DATA_SRC)
 		COMP(data_src);
 
@@ -238,6 +241,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 		.phys_addr	= 113,
 		.cgroup		= 114,
 		.data_page_size = 115,
+		.ins_lat	= 116,
 		.aux_sample	= {
 			.size	= sizeof(aux_data),
 			.data	= (void *)aux_data,
@@ -344,7 +348,7 @@ int test__sample_parsing(struct test *test __maybe_unused, int subtest __maybe_u
 	 * were added.  Please actually update the test rather than just change
 	 * the condition below.
 	 */
-	if (PERF_SAMPLE_MAX > PERF_SAMPLE_CODE_PAGE_SIZE << 1) {
+	if (PERF_SAMPLE_MAX > PERF_SAMPLE_WEIGHT_STRUCT << 1) {
 		pr_debug("sample format has changed, some new PERF_SAMPLE_ bit was introduced - test needs updating\n");
 		return -1;
 	}
@@ -374,8 +378,12 @@ int test__sample_parsing(struct test *test __maybe_unused, int subtest __maybe_u
 			return err;
 	}
 
-	/* Test all sample format bits together */
-	sample_type = PERF_SAMPLE_MAX - 1;
+	/*
+	 * Test all sample format bits together
+	 * Note: PERF_SAMPLE_WEIGHT and PERF_SAMPLE_WEIGHT_STRUCT cannot
+	 *       be set simultaneously.
+	 */
+	sample_type = (PERF_SAMPLE_MAX - 1) & ~PERF_SAMPLE_WEIGHT;
 	sample_regs = 0x3fff; /* shared yb intr and user regs */
 	for (i = 0; i < ARRAY_SIZE(rf); i++) {
 		err = do_test(sample_type, sample_regs, rf[i]);
-- 
2.7.4

