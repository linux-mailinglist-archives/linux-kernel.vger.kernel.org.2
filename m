Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0835231E921
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 12:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhBRL1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 06:27:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:58033 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231280AbhBRKLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:11:32 -0500
IronPort-SDR: sBNNj64VsiWfvIo/Sa0VU6ZJC3Q9l0NBdOzTssEHqLqeaGXjdTC5C6izqmgzSin1ZCHCyIvpwM
 g66voRCEyj9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="171127960"
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="171127960"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 01:58:25 -0800
IronPort-SDR: RBp81skWTBia1fuX6qCLhyUA3jBBWCnbKRtmVssJ7PgxzVX3lMw1iQln/jSP9atTWoKq+ECZbL
 YsZf7zGU0fiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="400427733"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.149])
  by orsmga008.jf.intel.com with ESMTP; 18 Feb 2021 01:58:23 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] perf intel-pt: Split VM-Entry and VM-Exit branches
Date:   Thu, 18 Feb 2021 11:58:00 +0200
Message-Id: <20210218095801.19576-11-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218095801.19576-1-adrian.hunter@intel.com>
References: <20210218095801.19576-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Events record a single cpumode so the tools cannot handle a branch from
the host machine to a virtual machine, or vice versa. Split it in two so
that each branch can have a different cpumode.

  E.g.		host ip -> guest ip

  becomes:	host ip -> 0
		      0 -> guest ip

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index cafb3943d5f6..f6e28ac231b7 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2171,7 +2171,27 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 	}
 
 	if (pt->sample_branches) {
-		err = intel_pt_synth_branch_sample(ptq);
+		if (state->from_nr != state->to_nr &&
+		    state->from_ip && state->to_ip) {
+			struct intel_pt_state *st = (struct intel_pt_state *)state;
+			u64 to_ip = st->to_ip;
+			u64 from_ip = st->from_ip;
+
+			/*
+			 * perf cannot handle having different machines for ip
+			 * and addr, so create 2 branches.
+			 */
+			st->to_ip = 0;
+			err = intel_pt_synth_branch_sample(ptq);
+			if (err)
+				return err;
+			st->from_ip = 0;
+			st->to_ip = to_ip;
+			err = intel_pt_synth_branch_sample(ptq);
+			st->from_ip = from_ip;
+		} else {
+			err = intel_pt_synth_branch_sample(ptq);
+		}
 		if (err)
 			return err;
 	}
-- 
2.17.1

