Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9891034C47A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhC2HDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:03:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:20002 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231190AbhC2HC0 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:02:26 -0400
IronPort-SDR: hy6U1f/2x6DJu4HFP/pcAFL7YIPuN8iM24amOQGPoI+lqIhMt+x3nFdKoqvsTTaljeJLkPyh9D
 H7EaIUqWLgww==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="190956280"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="190956280"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:02:26 -0700
IronPort-SDR: DfgZ1//7SUT0FGCKjxB0RQqrRYlx3e4IDrpcULi1DrwJr3eoJtMvPwFdXZu/tM6X7Ky9YOrvtH
 4BtsS2DU11cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="444677542"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2021 00:02:23 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 17/27] perf script: Support PERF_TYPE_HARDWARE_PMU and PERF_TYPE_HW_CACHE_PMU
Date:   Mon, 29 Mar 2021 15:00:36 +0800
Message-Id: <20210329070046.8815-18-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329070046.8815-1-yao.jin@linux.intel.com>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a hybrid system, the perf subsystem doesn't know which PMU the
events belong to. So the PMU aware version PERF_TYPE_HARDWARE_PMU and
PERF_TYPE_HW_CACHE_PMU are introduced.

Now define the new output[] entries for these two types.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v3:
 - No change.

 tools/perf/builtin-script.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 1280cbfad4db..627ec640d2e6 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -275,6 +275,30 @@ static struct {
 		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
 	},
 
+	[PERF_TYPE_HARDWARE_PMU] = {
+		.user_set = false,
+
+		.fields = PERF_OUTPUT_COMM | PERF_OUTPUT_TID |
+			      PERF_OUTPUT_CPU | PERF_OUTPUT_TIME |
+			      PERF_OUTPUT_EVNAME | PERF_OUTPUT_IP |
+			      PERF_OUTPUT_SYM | PERF_OUTPUT_SYMOFFSET |
+			      PERF_OUTPUT_DSO | PERF_OUTPUT_PERIOD,
+
+		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
+	},
+
+	[PERF_TYPE_HW_CACHE_PMU] = {
+		.user_set = false,
+
+		.fields = PERF_OUTPUT_COMM | PERF_OUTPUT_TID |
+			      PERF_OUTPUT_CPU | PERF_OUTPUT_TIME |
+			      PERF_OUTPUT_EVNAME | PERF_OUTPUT_IP |
+			      PERF_OUTPUT_SYM | PERF_OUTPUT_SYMOFFSET |
+			      PERF_OUTPUT_DSO | PERF_OUTPUT_PERIOD,
+
+		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
+	},
+
 	[OUTPUT_TYPE_SYNTH] = {
 		.user_set = false,
 
-- 
2.17.1

