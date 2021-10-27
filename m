Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B8E43C49A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 10:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240751AbhJ0IGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 04:06:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:24473 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239109AbhJ0IGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 04:06:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="229960802"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="229960802"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 01:03:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="465644391"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by orsmga002.jf.intel.com with ESMTP; 27 Oct 2021 01:03:49 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 6/6] perf intel-pt: Support itrace d+o option to direct debug log to stdout
Date:   Wed, 27 Oct 2021 11:03:34 +0300
Message-Id: <20211027080334.365596-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211027080334.365596-1-adrian.hunter@intel.com>
References: <20211027080334.365596-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can be useful to see debug output in between normal output.

Add support for AUXTRACE_LOG_FLG_USE_STDOUT to Intel PT.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt      | 1 +
 tools/perf/util/intel-pt-decoder/intel-pt-log.c | 8 ++++----
 tools/perf/util/intel-pt.c                      | 5 +++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 5fa0a448e6a6..94933915e2f3 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -953,6 +953,7 @@ by flags which affect what debug messages will or will not be logged. Each flag
 must be preceded by either '+' or '-'. The flags support by Intel PT are:
 		-a	Suppress logging of perf events
 		+a	Log all perf events
+		+o	Output to stdout instead of "intel_pt.log"
 By default, logged perf events are filtered by any specified time ranges, but
 flag +a overrides that.
 
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-log.c b/tools/perf/util/intel-pt-decoder/intel-pt-log.c
index 09feb5b07d32..5f5dfc8753f3 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-log.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-log.c
@@ -82,10 +82,10 @@ static int intel_pt_log_open(void)
 	if (f)
 		return 0;
 
-	if (!log_name[0])
-		return -1;
-
-	f = fopen(log_name, "w+");
+	if (log_name[0])
+		f = fopen(log_name, "w+");
+	else
+		f = stdout;
 	if (!f) {
 		intel_pt_enable_logging = false;
 		return -1;
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 57e49b23ad25..793bac850268 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -3659,8 +3659,6 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	if (err)
 		goto err_free;
 
-	intel_pt_log_set_name(INTEL_PT_PMU_NAME);
-
 	if (session->itrace_synth_opts->set) {
 		pt->synth_opts = *session->itrace_synth_opts;
 	} else {
@@ -3675,6 +3673,9 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 		pt->synth_opts.thread_stack = opts->thread_stack;
 	}
 
+	if (!(pt->synth_opts.log_plus_flags & AUXTRACE_LOG_FLG_USE_STDOUT))
+		intel_pt_log_set_name(INTEL_PT_PMU_NAME);
+
 	pt->session = session;
 	pt->machine = &session->machines.host; /* No kvm support */
 	pt->auxtrace_type = auxtrace_info->type;
-- 
2.25.1

