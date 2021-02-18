Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF0D31E92F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 12:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhBRLdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 06:33:43 -0500
Received: from mga18.intel.com ([134.134.136.126]:58033 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229989AbhBRKOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:14:10 -0500
IronPort-SDR: WDVkiMEPiPF4nAB22kPGLnDLp03y/V+hWDI2WTypUofXcf40Fs7EBq4n7h6VTAypR3dFQ3bO9d
 kyo3lyp+IsXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="171127955"
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="171127955"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 01:58:23 -0800
IronPort-SDR: 7gxiEXXX8bLFARdUKcjXI9YuWUDL7sdi+cBdnVm+BLKjImR3/7d1X/VvFK5iPkWe2sukSfMZUQ
 q7KbeVcPPRoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="400427716"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.149])
  by orsmga008.jf.intel.com with ESMTP; 18 Feb 2021 01:58:21 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] perf intel-pt: Adjust sample flags for VM-Exit
Date:   Thu, 18 Feb 2021 11:57:59 +0200
Message-Id: <20210218095801.19576-10-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218095801.19576-1-adrian.hunter@intel.com>
References: <20210218095801.19576-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the change of NR to detect whether an asynchronous branch is a VM-Exit.

Note VM-Entry is determined from the vmlaunch or vmresume instruction,
in which case, sample flags will show "VMentry" even if the VM-Entry fails.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 546d512b300a..cafb3943d5f6 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1201,13 +1201,16 @@ static void intel_pt_sample_flags(struct intel_pt_queue *ptq)
 	if (ptq->state->flags & INTEL_PT_ABORT_TX) {
 		ptq->flags = PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TX_ABORT;
 	} else if (ptq->state->flags & INTEL_PT_ASYNC) {
-		if (ptq->state->to_ip)
+		if (!ptq->state->to_ip)
+			ptq->flags = PERF_IP_FLAG_BRANCH |
+				     PERF_IP_FLAG_TRACE_END;
+		else if (ptq->state->from_nr && !ptq->state->to_nr)
+			ptq->flags = PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL |
+				     PERF_IP_FLAG_VMEXIT;
+		else
 			ptq->flags = PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL |
 				     PERF_IP_FLAG_ASYNC |
 				     PERF_IP_FLAG_INTERRUPT;
-		else
-			ptq->flags = PERF_IP_FLAG_BRANCH |
-				     PERF_IP_FLAG_TRACE_END;
 		ptq->insn_len = 0;
 	} else {
 		if (ptq->state->from_ip)
-- 
2.17.1

