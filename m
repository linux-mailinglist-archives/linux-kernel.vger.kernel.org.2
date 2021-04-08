Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D33D358889
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhDHPc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:32:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:22953 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232200AbhDHPcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:32:22 -0400
IronPort-SDR: /jGr9UpEUiZXT16CZurb2c+fU2XsWT2mu8SEHcQwDJ5Sb+/dch6JDr00FEoVCwoJR540EXRwMT
 OfEftTBwDFYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="191412401"
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="191412401"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 08:32:11 -0700
IronPort-SDR: HrgZ+UPlK0iS9+SpWhX+He/x97IHaPsta2J1B7FNpOVoj5TDB8QDD6Z0B4yHvwror4GcJil6/3
 Hjh+TJ7+cZoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="415820756"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 08 Apr 2021 08:32:08 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        adrian.hunter@intel.com
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 2/2] perf intel-pt: Use aux_watermark
Date:   Thu,  8 Apr 2021 18:31:59 +0300
Message-Id: <20210408153159.81880-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210408153159.81880-1-alexander.shishkin@linux.intel.com>
References: <20210408153159.81880-1-alexander.shishkin@linux.intel.com>
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
 tools/perf/arch/x86/util/intel-pt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index a6420c647959..d00707faf547 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -776,6 +776,10 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 		}
 	}
 
+	if (opts->full_auxtrace)
+		intel_pt_evsel->core.attr.aux_watermark =
+		       opts->auxtrace_mmap_pages / 4 * page_size;
+
 	intel_pt_parse_terms(intel_pt_pmu->name, &intel_pt_pmu->format,
 			     "tsc", &tsc_bit);
 
-- 
2.30.2

