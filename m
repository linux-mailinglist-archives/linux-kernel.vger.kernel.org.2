Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F372C31E923
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 12:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhBRL2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 06:28:39 -0500
Received: from mga18.intel.com ([134.134.136.126]:58029 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231386AbhBRKLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:11:32 -0500
IronPort-SDR: lq0QEewrT5bLONUSpEIQ8XQAWpmIT744KRD6M0crrFwCMm4WeT8nmg3MlzInQN1EYZLHiuKyoS
 o8RO/YzCRGvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="171127950"
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="171127950"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 01:58:21 -0800
IronPort-SDR: mHYDqPVViKM8f8KGEbTc2AXXmDvQT0jmbGU5kNevxpOndJIJfcmgBj5aUDEMCyoFWp0cefm2+A
 jdG8ywQqR+Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="400427699"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.149])
  by orsmga008.jf.intel.com with ESMTP; 18 Feb 2021 01:58:19 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] perf intel-pt: Allow for a guest kernel address filter
Date:   Thu, 18 Feb 2021 11:57:58 +0200
Message-Id: <20210218095801.19576-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218095801.19576-1-adrian.hunter@intel.com>
References: <20210218095801.19576-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handling TIP.PGD for an address filter for a guest kernel is the same as a
host kernel, but user space decoding, and hence address filters, are not
supported.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 29d871718995..546d512b300a 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -792,8 +792,14 @@ static int __intel_pt_pgd_ip(uint64_t ip, void *data)
 	u8 cpumode;
 	u64 offset;
 
-	if (ip >= ptq->pt->kernel_start)
+	if (ptq->state->to_nr) {
+		if (intel_pt_guest_kernel_ip(ip))
+			return intel_pt_match_pgd_ip(ptq->pt, ip, ip, NULL);
+		/* No support for decoding guest user space */
+		return -EINVAL;
+	} else if (ip >= ptq->pt->kernel_start) {
 		return intel_pt_match_pgd_ip(ptq->pt, ip, ip, NULL);
+	}
 
 	cpumode = PERF_RECORD_MISC_USER;
 
-- 
2.17.1

