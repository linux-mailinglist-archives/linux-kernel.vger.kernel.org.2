Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7AD38CCB3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbhEURwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:52:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:60783 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232017AbhEURwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:52:31 -0400
IronPort-SDR: iW4/CVHGfjIXi234N4zA2eKY+91o1QdC/7WGTzT3wrLCWYbdNVy3ZiXl5Buof11Jox4BfXs822
 DSAnrE6Kw17A==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="222648851"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="222648851"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 10:51:03 -0700
IronPort-SDR: MLCcEIQGRTK11MVoTgPMXLLXzTPDyU/6qt38J1p58s+COtJq/F0HbHGlI+q+Bs5TQ5aBC5wIRt
 kWyhvN0W2aQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="441182358"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga008.fm.intel.com with ESMTP; 21 May 2021 10:51:01 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] perf script: Add missing PERF_IP_FLAG_CHARS for VM-Entry and VM-Exit
Date:   Fri, 21 May 2021 20:51:27 +0300
Message-Id: <20210521175127.27264-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'g' (guest) for VM-Entry and 'h' (host) for VM-Exit.

Fixes: c025d46cd932c ("perf script: Add branch types for VM-Entry and VM-Exit")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt | 6 +++---
 tools/perf/Documentation/perf-script.txt   | 7 ++++---
 tools/perf/util/event.h                    | 2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 8d6cce062a5f..e382dbd4ff0a 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -108,9 +108,9 @@ displayed as follows:
 
 	perf script --itrace=ibxwpe -F+flags
 
-The flags are "bcrosyiABEx" which stand for branch, call, return, conditional,
-system, asynchronous, interrupt, transaction abort, trace begin, trace end, and
-in transaction, respectively.
+The flags are "bcrosyiABExgh" which stand for branch, call, return, conditional,
+system, asynchronous, interrupt, transaction abort, trace begin, trace end,
+in transaction, VM-entry, and VM-exit respectively.
 
 perf script also supports higher level ways to dump instruction traces:
 
diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 5b8b61075039..48a5f5b26dd4 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -183,14 +183,15 @@ OPTIONS
 	At this point usage is displayed, and perf-script exits.
 
 	The flags field is synthesized and may have a value when Instruction
-	Trace decoding. The flags are "bcrosyiABEx" which stand for branch,
+	Trace decoding. The flags are "bcrosyiABExgh" which stand for branch,
 	call, return, conditional, system, asynchronous, interrupt,
-	transaction abort, trace begin, trace end, and in transaction,
+	transaction abort, trace begin, trace end, in transaction, VM-Entry, and VM-Exit
 	respectively. Known combinations of flags are printed more nicely e.g.
 	"call" for "bc", "return" for "br", "jcc" for "bo", "jmp" for "b",
 	"int" for "bci", "iret" for "bri", "syscall" for "bcs", "sysret" for "brs",
 	"async" for "by", "hw int" for "bcyi", "tx abrt" for "bA", "tr strt" for "bB",
-	"tr end" for "bE". However the "x" flag will be display separately in those
+	"tr end" for "bE", "vmentry" for "bcg", "vmexit" for "bch".
+	However the "x" flag will be displayed separately in those
 	cases e.g. "jcc     (x)" for a condition branch within a transaction.
 
 	The callindent field is synthesized and may have a value when
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 8a62fb39e365..19ad64f2bd83 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -100,7 +100,7 @@ enum {
 	PERF_IP_FLAG_VMEXIT		= 1ULL << 12,
 };
 
-#define PERF_IP_FLAG_CHARS "bcrosyiABEx"
+#define PERF_IP_FLAG_CHARS "bcrosyiABExgh"
 
 #define PERF_BRANCH_MASK		(\
 	PERF_IP_FLAG_BRANCH		|\
-- 
2.17.1

