Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7A038886E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 09:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbhESHqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 03:46:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:51685 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240919AbhESHqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 03:46:15 -0400
IronPort-SDR: tb9nyFe500ng1iyBaw6y4zISXJYjwSHpYCrA2lubwnDMuYAySSf6MGVEcNqKQ7coUTFfKUd5QG
 gp3XXtlyF4Rg==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="200964067"
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="200964067"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 00:44:56 -0700
IronPort-SDR: wUfyLc/bdowSY0HABRcb5PYL1wGuBxl9j2lqfOcmF621eNztE1XW+9vNunimorw08CxnKgI/Ld
 Rs/KWBOY5T9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="scan'208";a="411625038"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 19 May 2021 00:44:54 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] perf intel-pt: Remove redundant setting of ptq->insn_len
Date:   Wed, 19 May 2021 10:45:15 +0300
Message-Id: <20210519074515.9262-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210519074515.9262-1-adrian.hunter@intel.com>
References: <20210519074515.9262-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant "ptq->insn_len = 0" statement.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 4428dba24aa7..154a1077f22e 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1317,7 +1317,6 @@ static void intel_pt_sample_flags(struct intel_pt_queue *ptq)
 			ptq->flags = PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL |
 				     PERF_IP_FLAG_ASYNC |
 				     PERF_IP_FLAG_INTERRUPT;
-		ptq->insn_len = 0;
 	} else {
 		if (ptq->state->from_ip)
 			ptq->flags = intel_pt_insn_type(ptq->state->insn_op);
-- 
2.17.1

