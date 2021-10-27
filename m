Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8AD43C49B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 10:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240742AbhJ0IGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 04:06:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:24473 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239088AbhJ0IGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 04:06:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="229960793"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="229960793"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 01:03:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="465644374"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by orsmga002.jf.intel.com with ESMTP; 27 Oct 2021 01:03:47 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 5/6] perf auxtrace: Add itrace d+o option to direct debug log to stdout
Date:   Wed, 27 Oct 2021 11:03:33 +0300
Message-Id: <20211027080334.365596-6-adrian.hunter@intel.com>
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

Add 'o' to the flags of debug option 'd', so that '--itrace=d+o' can
specify output of the debug log to stdout.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/itrace.txt | 1 +
 tools/perf/util/auxtrace.h          | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index 141449e97bed..c52755481e2f 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -62,5 +62,6 @@
 	debug messages will or will not be logged. Each flag must be preceded
 	by either '+' or '-'. The flags are:
 		a	all perf events
+		o	output to stdout
 
 	If supported, the 'q' option may be repeated to increase the effect.
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 889f976ea1a0..bbf0d78c6401 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -59,6 +59,7 @@ enum itrace_period_type {
 #define AUXTRACE_ERR_FLG_DATA_LOST	(1 << ('l' - 'a'))
 
 #define AUXTRACE_LOG_FLG_ALL_PERF_EVTS	(1 << ('a' - 'a'))
+#define AUXTRACE_LOG_FLG_USE_STDOUT	(1 << ('o' - 'a'))
 
 /**
  * struct itrace_synth_opts - AUX area tracing synthesis options.
@@ -641,6 +642,7 @@ bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
 "				d[flags]:		create a debug log\n" \
 "							each flag must be preceded by + or -\n" \
 "							log flags are: a (all perf events)\n" \
+"							               o (output to stdout)\n" \
 "				f:	    		synthesize first level cache events\n" \
 "				m:	    		synthesize last level cache events\n" \
 "				t:	    		synthesize TLB events\n" \
-- 
2.25.1

