Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499A943AE79
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 11:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbhJZJEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 05:04:23 -0400
Received: from mga17.intel.com ([192.55.52.151]:37214 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234628AbhJZJEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:04:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="210639808"
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="210639808"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 02:01:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="723991220"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by fmsmga005.fm.intel.com with ESMTP; 26 Oct 2021 02:01:57 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/6] perf auxtrace: Add itrace A option to approximate IPC
Date:   Tue, 26 Oct 2021 12:01:48 +0300
Message-Id: <20211026090152.357591-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211026090152.357591-1-adrian.hunter@intel.com>
References: <20211026090152.357591-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an option to specify that synthesized IPC can be approximate, rather
than completely accurate.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/itrace.txt | 1 +
 tools/perf/util/auxtrace.c          | 3 +++
 tools/perf/util/auxtrace.h          | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index 2d586fe5e4c5..141449e97bed 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -20,6 +20,7 @@
 		L	synthesize last branch entries on existing event records
 		s       skip initial number of events
 		q	quicker (less detailed) decoding
+		A	approximate IPC
 		Z	prefer to ignore timestamps (so-called "timeless" decoding)
 
 	The default is all events i.e. the same as --itrace=ibxwpe,
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 8d2865b9ade2..c679394b898d 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1564,6 +1564,9 @@ int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
 		case 'q':
 			synth_opts->quick += 1;
 			break;
+		case 'A':
+			synth_opts->approx_ipc = true;
+			break;
 		case 'Z':
 			synth_opts->timeless_decoding = true;
 			break;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 20dc78d86d54..889f976ea1a0 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -84,6 +84,7 @@ enum itrace_period_type {
  * @thread_stack: feed branches to the thread_stack
  * @last_branch: add branch context to 'instruction' events
  * @add_last_branch: add branch context to existing event records
+ * @approx_ipc: approximate IPC
  * @flc: whether to synthesize first level cache events
  * @llc: whether to synthesize last level cache events
  * @tlb: whether to synthesize TLB events
@@ -127,6 +128,7 @@ struct itrace_synth_opts {
 	bool			thread_stack;
 	bool			last_branch;
 	bool			add_last_branch;
+	bool			approx_ipc;
 	bool			flc;
 	bool			llc;
 	bool			tlb;
@@ -649,6 +651,7 @@ bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
 "				L[len]:			synthesize last branch entries on existing event records\n" \
 "				sNUMBER:    		skip initial number of events\n"		\
 "				q:			quicker (less detailed) decoding\n" \
+"				A:			approximate IPC\n" \
 "				Z:			prefer to ignore timestamps (so-called \"timeless\" decoding)\n" \
 "				PERIOD[ns|us|ms|i|t]:   specify period to sample stream\n" \
 "				concatenate multiple options. Default is ibxwpe or cewp\n"
-- 
2.25.1

