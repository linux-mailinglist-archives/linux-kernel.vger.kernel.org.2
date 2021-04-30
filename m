Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A85A36F621
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhD3HEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:04:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:34063 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231127AbhD3HD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:03:57 -0400
IronPort-SDR: woZVhaDu2dwUO6HwSkeUO1np1M6YmTCo3ykk8EDIK45zRVYs8gkqivnl/b8OG49xIoc+CKWR8o
 3gURwnBcK9Tw==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="197312451"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="197312451"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 00:03:10 -0700
IronPort-SDR: IOqqwZIkDckspoDR/nu0VJYKXs14WFl/DThdRKS0M/YtCGX5LbMKB+kWF3VzvMQy4PiLS3O/z3
 6BEGEnKJGmfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="404492347"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 30 Apr 2021 00:03:08 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH V2 10/12] perf intel-pt: Better 7-byte timestamp wraparound logic
Date:   Fri, 30 Apr 2021 10:03:07 +0300
Message-Id: <20210430070309.17624-11-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210430070309.17624-1-adrian.hunter@intel.com>
References: <20210430070309.17624-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A timestamp should not go backwards. If it does it is assumed that the
 7-byte TSC packet value has wrapped. Improve that logic so that it will
not allow the timestamp to go past the buffer timestamp (which is recorded
when the buffer is copied out)

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 7c93ae2bd56c..c4044bc2fb86 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1499,9 +1499,15 @@ static void intel_pt_calc_tsc_timestamp(struct intel_pt_decoder *decoder)
 			timestamp = decoder->timestamp;
 		}
 		if (timestamp < decoder->timestamp) {
-			intel_pt_log_to("Wraparound timestamp", timestamp);
-			timestamp += (1ULL << 56);
-			decoder->tsc_timestamp = timestamp;
+			if (!decoder->buf_timestamp ||
+			    (timestamp + (1ULL << 56) < decoder->buf_timestamp)) {
+				intel_pt_log_to("Wraparound timestamp", timestamp);
+				timestamp += (1ULL << 56);
+				decoder->tsc_timestamp = timestamp;
+			} else {
+				intel_pt_log_to("Suppressing bad timestamp", timestamp);
+				timestamp = decoder->timestamp;
+			}
 		}
 		decoder->timestamp = timestamp;
 		decoder->timestamp_insn_cnt = 0;
-- 
2.25.1

