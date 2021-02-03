Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8840030E631
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 23:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbhBCWms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 17:42:48 -0500
Received: from mga09.intel.com ([134.134.136.24]:17747 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232366AbhBCWmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 17:42:47 -0500
IronPort-SDR: t53lsOkC9sj1ChBx4ht4N9NQbYDknvHup0vu6HhfgBCIgarVRyta0jCOG1QzmqOe8I6pgX3Nbm
 wkxE635xxf8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="181273267"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="181273267"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 14:40:59 -0800
IronPort-SDR: TtacJnWk72BvWYP2DAq1xKzUirP6z7z8Fo1El2bt+KEKb/YVL07kfuYhaM+k5LCNtIWmEsBSX8
 olp8VJbJzqDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="356923330"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 03 Feb 2021 14:40:58 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, eranian@google.com,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf evsel: Add a check in the error path for the auxiliary event
Date:   Wed,  3 Feb 2021 14:37:06 -0800
Message-Id: <1612391826-27714-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Current perf assumes that the ENODATA is a unique error code for the
auxiliary event on Sapphire Rapids. The assumption is good for now, but
this is fragile. In the future, someone may not remember that the
ENODATA is for the auxiliary event on Sapphire Rapids, and reuse it for
other purposes. The error message for the auxiliary event may be
mistakenly displayed.

Add a check to identify the auxiliary event case.

Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/evsel.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 844aebd..30b5452 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -48,6 +48,7 @@
 #include "util.h"
 #include "../perf-sys.h"
 #include "util/parse-branch-options.h"
+#include "pmu.h"
 #include <internal/xyarray.h>
 #include <internal/lib.h>
 
@@ -2735,8 +2736,10 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
 		break;
 	case ENODATA:
-		return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
-				 "Please add an auxiliary event in front of the load latency event.");
+		if (evsel->core.attr.sample_type & PERF_SAMPLE_DATA_SRC && pmu_have_event("cpu", "mem-loads-aux")) {
+			return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
+					 "Please add an auxiliary event in front of the load latency event.");
+		}
 	default:
 		break;
 	}
-- 
2.7.4

