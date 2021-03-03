Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8151A32C07B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578741AbhCCSRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:17:53 -0500
Received: from mga03.intel.com ([134.134.136.65]:18609 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1384654AbhCCQIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:08:43 -0500
IronPort-SDR: ekuC5blGtxUiSPih6vEZiN1K1HVuJpKg9DIll+iY36nF9SU0Odq/NureelBoo1s3Uc09sDgXmQ
 wHzlKJNJT75A==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="187282233"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="187282233"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 08:06:36 -0800
IronPort-SDR: AwgQGyN9/FlgWf3sHqxenoBncNTn5kPzapCE7T5pHyYWYWkS0pJCvZLwMARJwvabxl9QrJQapv
 3X4jV75TY5eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="586398885"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga005.jf.intel.com with ESMTP; 03 Mar 2021 08:06:36 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, linux-kernel@vger.kernel.org
Cc:     tmricht@linux.ibm.com, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/2] perf test: Fix sample-parsing fails on non-x86 platforms
Date:   Wed,  3 Mar 2021 08:01:24 -0800
Message-Id: <1614787285-104151-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Executing perf test 27 fails on s390:
 [root@t35lp46 perf]# ./perf test -Fv 27
 27: Sample parsing
 --- start ---
 ---- end ----
 Sample parsing: FAILED!
 [root@t35lp46 perf]#

The commit fbefe9c2f87f ("perf tools: Support arch specific
PERF_SAMPLE_WEIGHT_STRUCT processing") changes the ins_lat to a
model-specific variable only for X86, but perf test still verify the
variable in the generic test.

Remove the ins_lat check in the generic test. The following patch will
add it in the X86 specific test.

Fixes: fbefe9c2f87f ("perf tools: Support arch specific PERF_SAMPLE_WEIGHT_STRUCT processing")
Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/sample-parsing.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 0dbe3aa..8fd8a4e 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -129,9 +129,6 @@ static bool samples_same(const struct perf_sample *s1,
 	if (type & PERF_SAMPLE_WEIGHT)
 		COMP(weight);
 
-	if (type & PERF_SAMPLE_WEIGHT_STRUCT)
-		COMP(ins_lat);
-
 	if (type & PERF_SAMPLE_DATA_SRC)
 		COMP(data_src);
 
@@ -245,7 +242,6 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 		.cgroup		= 114,
 		.data_page_size = 115,
 		.code_page_size = 116,
-		.ins_lat        = 117,
 		.aux_sample	= {
 			.size	= sizeof(aux_data),
 			.data	= (void *)aux_data,
-- 
2.7.4

