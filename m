Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F79E35F87A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351012AbhDNPxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:53:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:37627 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352442AbhDNPxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:53:10 -0400
IronPort-SDR: YgqaTmEZuTha6PLsJKYH54ZctbJlusWAn83cXt4+Kj2v1Qvy7MJQndVRBlCRpR3OEIMu68uDdH
 3AMy4gGLVN9A==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="279979739"
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="279979739"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 08:51:02 -0700
IronPort-SDR: jfbCfrwYhwQxqKkQsYOLHpPCHplyHhu3S+5x/t1gLornIi/I/MxrFhHJPPky0gB+0+EkWgCKi5
 tbU7Z6IyPmjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="399226043"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 14 Apr 2021 08:50:59 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        adrian.hunter@intel.com
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v1 2/2] perf intel-pt: Use aux_watermark
Date:   Wed, 14 Apr 2021 18:49:55 +0300
Message-Id: <20210414154955.49603-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414154955.49603-1-alexander.shishkin@linux.intel.com>
References: <20210414154955.49603-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out, the default setting of attr.aux_watermark to half of the total
buffer size is not very useful, especially with smaller buffers. The
problem is that, after half of the buffer is filled up, the kernel updates
->aux_head and sets up the next "transaction", while observing that
->aux_tail is still zero (as userspace haven't had the chance to update
it), meaning that the trace will have to stop at the end of this second
"transaction". This means, for example, that the second PERF_RECORD_AUX in
every trace comes with TRUNCATED flag set.

Setting attr.aux_watermark to quarter of the buffer gives enough space for
the ->aux_tail update to be observed and prevents the data loss.

The obligatory before/after showcase:

> # perf_before record -e intel_pt//u -m,8 uname
> Linux
> [ perf record: Woken up 6 times to write data ]
> Warning:
> AUX data lost 4 times out of 10!
>
> [ perf record: Captured and wrote 0.099 MB perf.data ]
> # perf record -e intel_pt//u -m,8 uname
> Linux
> [ perf record: Woken up 4 times to write data ]
> [ perf record: Captured and wrote 0.039 MB perf.data ]

The effect is still visible with large workloads and large buffers,
although less pronounced.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index a6420c647959..6df0dc00d73a 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -776,6 +776,12 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 		}
 	}
 
+	if (!opts->auxtrace_snapshot_mode && !opts->auxtrace_sample_mode) {
+		u32 aux_watermark = opts->auxtrace_mmap_pages * page_size / 4;
+
+		intel_pt_evsel->core.attr.aux_watermark = aux_watermark;
+	}
+
 	intel_pt_parse_terms(intel_pt_pmu->name, &intel_pt_pmu->format,
 			     "tsc", &tsc_bit);
 
-- 
2.30.2

