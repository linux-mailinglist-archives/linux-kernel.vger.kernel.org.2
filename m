Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29AC36EB0B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 14:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239201AbhD2NAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 09:00:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:50859 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238780AbhD2NAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 09:00:09 -0400
IronPort-SDR: PDvHjcpJWnLHGbvHjo6OmsgngcgERTwIL27OJ9jmDeouOlu9NCNfYhG49GmXEZ0xYICl4eaHyN
 CreXNw82f+nA==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="177107525"
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="177107525"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 05:58:51 -0700
IronPort-SDR: 3/3b5QseZ4HsUftWd/EiooAuVWZlLihivT0V2hb/zuq8XC99+h8zs19K+v+wfnXZ88eAB1r9s0
 mDWEbV1eN44Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="537361675"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga004.jf.intel.com with ESMTP; 29 Apr 2021 05:58:50 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] perf intel-pt: Better 7-byte timestamp wraparound logic
Date:   Thu, 29 Apr 2021 15:58:52 +0300
Message-Id: <20210429125854.13905-11-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429125854.13905-1-adrian.hunter@intel.com>
References: <20210429125854.13905-1-adrian.hunter@intel.com>
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
index ba5b5782acc1..b95312ec3832 100644
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
2.17.1

