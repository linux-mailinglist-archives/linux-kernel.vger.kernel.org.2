Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B310636EB08
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 14:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbhD2NAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 09:00:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:50859 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237260AbhD2NAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 09:00:07 -0400
IronPort-SDR: qFleX3tIZEIRf61bkX3+d48uRIISEXAONN4wLXF6NNa4G7dwws7GHHVE4Ov56YqLN6CBkQB2c3
 SY9LoVyXIVAA==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="177107466"
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="177107466"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 05:58:45 -0700
IronPort-SDR: O60dDAnW7QdgfSuIoqsYUfCNGznM1catHOIzz4c8ynrmqYj8r9jbzUGL4GfYkdKxY/Lf22xagk
 TH2AyNLaxssw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="537361641"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga004.jf.intel.com with ESMTP; 29 Apr 2021 05:58:44 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] perf intel-pt: Let overlap detection handle VM timestamps
Date:   Thu, 29 Apr 2021 15:58:49 +0300
Message-Id: <20210429125854.13905-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429125854.13905-1-adrian.hunter@intel.com>
References: <20210429125854.13905-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel PT timestamps are affected by virtualization. While TSC packets can
still be considered to be unique, the TSC values need not be in order any
more. Adjust the algorithm accordingly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 12 ++++++++----
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.h |  3 ++-
 tools/perf/util/intel-pt.c                          | 10 +++++++++-
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 8c59677bee13..8f916f90205e 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -3227,6 +3227,7 @@ static unsigned char *adj_for_padding(unsigned char *buf_b,
  * @len_b: size of second buffer
  * @consecutive: returns true if there is data in buf_b that is consecutive
  *               to buf_a
+ * @ooo_tsc: out-of-order TSC due to VM TSC offset / scaling
  *
  * If the trace contains TSC we can look at the last TSC of @buf_a and the
  * first TSC of @buf_b in order to determine if the buffers overlap, and then
@@ -3239,7 +3240,8 @@ static unsigned char *adj_for_padding(unsigned char *buf_b,
 static unsigned char *intel_pt_find_overlap_tsc(unsigned char *buf_a,
 						size_t len_a,
 						unsigned char *buf_b,
-						size_t len_b, bool *consecutive)
+						size_t len_b, bool *consecutive,
+						bool ooo_tsc)
 {
 	uint64_t tsc_a, tsc_b;
 	unsigned char *p;
@@ -3274,7 +3276,7 @@ static unsigned char *intel_pt_find_overlap_tsc(unsigned char *buf_a,
 				start = buf_b + len_b - (rem_b - rem_a);
 				return adj_for_padding(start, buf_a, len_a);
 			}
-			if (cmp < 0)
+			if (cmp < 0 && !ooo_tsc)
 				return buf_b; /* tsc_a < tsc_b => no overlap */
 		}
 
@@ -3292,6 +3294,7 @@ static unsigned char *intel_pt_find_overlap_tsc(unsigned char *buf_a,
  * @have_tsc: can use TSC packets to detect overlap
  * @consecutive: returns true if there is data in buf_b that is consecutive
  *               to buf_a
+ * @ooo_tsc: out-of-order TSC due to VM TSC offset / scaling
  *
  * When trace samples or snapshots are recorded there is the possibility that
  * the data overlaps.  Note that, for the purposes of decoding, data is only
@@ -3302,7 +3305,8 @@ static unsigned char *intel_pt_find_overlap_tsc(unsigned char *buf_a,
  */
 unsigned char *intel_pt_find_overlap(unsigned char *buf_a, size_t len_a,
 				     unsigned char *buf_b, size_t len_b,
-				     bool have_tsc, bool *consecutive)
+				     bool have_tsc, bool *consecutive,
+				     bool ooo_tsc)
 {
 	unsigned char *found;
 
@@ -3315,7 +3319,7 @@ unsigned char *intel_pt_find_overlap(unsigned char *buf_a, size_t len_a,
 
 	if (have_tsc) {
 		found = intel_pt_find_overlap_tsc(buf_a, len_a, buf_b, len_b,
-						  consecutive);
+						  consecutive, ooo_tsc);
 		if (found)
 			return found;
 	}
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index d9e62a7f6f0e..bebdb7d37b39 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -269,7 +269,8 @@ int intel_pt_fast_forward(struct intel_pt_decoder *decoder, uint64_t timestamp);
 
 unsigned char *intel_pt_find_overlap(unsigned char *buf_a, size_t len_a,
 				     unsigned char *buf_b, size_t len_b,
-				     bool have_tsc, bool *consecutive);
+				     bool have_tsc, bool *consecutive,
+				     bool ooo_tsc);
 
 int intel_pt__strerror(int code, char *buf, size_t buflen);
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 7bee969eb335..a494d47aa1ad 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -278,9 +278,17 @@ static int intel_pt_do_fix_overlap(struct intel_pt *pt, struct auxtrace_buffer *
 	void *start;
 
 	start = intel_pt_find_overlap(a->data, a->size, b->data, b->size,
-				      pt->have_tsc, &consecutive);
+				      pt->have_tsc, &consecutive,
+				      pt->synth_opts.vm_time_correlation);
 	if (!start)
 		return -EINVAL;
+	/*
+	 * In the case of vm_time_correlation, the overlap might contain TSC
+	 * packets that will not be fixed, and that will then no longer work for
+	 * overlap detection. Avoid that by zeroing out the overlap.
+	 */
+	if (pt->synth_opts.vm_time_correlation)
+		memset(b->data, 0, start - b->data);
 	b->use_size = b->data + b->size - start;
 	b->use_data = start;
 	if (b->use_size && consecutive)
-- 
2.17.1

