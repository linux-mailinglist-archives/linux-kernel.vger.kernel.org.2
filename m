Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853CB41C89D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 17:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345328AbhI2Pok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 11:44:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:27517 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345157AbhI2Poi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:44:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="205117292"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="205117292"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 08:42:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="617567209"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga001.fm.intel.com with ESMTP; 29 Sep 2021 08:42:57 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, jmario@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/2] perf script: Fix PERF_SAMPLE_WEIGHT_STRUCT support
Date:   Wed, 29 Sep 2021 08:38:13 -0700
Message-Id: <1632929894-102778-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

-F weight in perf script is broken.

  # ./perf mem record
  # ./perf script -F weight
  Samples for 'dummy:HG' event do not have WEIGHT attribute set. Cannot
print 'weight' field.

The sample type, PERF_SAMPLE_WEIGHT_STRUCT, is an alternative of the
PERF_SAMPLE_WEIGHT sample type. They share the same space, weight. The
lower 32 bits are exactly the same for both sample type. The higher 32
bits may be different for different architecture. For a new kernel on
x86, the PERF_SAMPLE_WEIGHT_STRUCT is used. For an old kernel or other
ARCHs, the PERF_SAMPLE_WEIGHT is used.

With -F weight, current perf script will only check the input string
"weight" with the PERF_SAMPLE_WEIGHT sample type. Because the commit
ea8d0ed6eae3 ("perf tools: Support PERF_SAMPLE_WEIGHT_STRUCT") didn't
update the PERF_SAMPLE_WEIGHT_STRUCT sample type for perf script. For a
new kernel on x86, the check fails.

Use PERF_SAMPLE_WEIGHT_TYPE, which supports both sample types, to
replace PERF_SAMPLE_WEIGHT.

Reported-by: Joe Mario <jmario@redhat.com>
Fixes: ea8d0ed6eae3 ("perf tools: Support PERF_SAMPLE_WEIGHT_STRUCT")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 6211d0b..9f62ac6 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -459,7 +459,7 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 		return -EINVAL;
 
 	if (PRINT_FIELD(WEIGHT) &&
-	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT, "WEIGHT", PERF_OUTPUT_WEIGHT))
+	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT_TYPE, "WEIGHT", PERF_OUTPUT_WEIGHT))
 		return -EINVAL;
 
 	if (PRINT_FIELD(SYM) &&
-- 
2.7.4

