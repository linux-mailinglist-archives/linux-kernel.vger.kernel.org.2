Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0C131E936
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 12:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhBRLjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 06:39:40 -0500
Received: from mga18.intel.com ([134.134.136.126]:58029 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232299AbhBRJ6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 04:58:51 -0500
IronPort-SDR: Nc+oSYo6bkfPBRktgY0WVa/8IO+pSFYvg8ZDJhGKyHpoVFEmCykpbMkV/2hx+Xo0C8APxmWsl+
 NPv217Wh9fMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="171127895"
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="171127895"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 01:58:07 -0800
IronPort-SDR: jiDyLhBLDnxOJ6uGWuciNPa8EeLFsG7S6rklnc9RmWvB3lV6umGkCIzpl1NCdSfGz9JgtApnxj
 WqWGN4f0P/1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="400427596"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.149])
  by orsmga008.jf.intel.com with ESMTP; 18 Feb 2021 01:58:05 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] perf script: Add branch types for VM-Entry and VM-Exit
Date:   Thu, 18 Feb 2021 11:57:51 +0200
Message-Id: <20210218095801.19576-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218095801.19576-1-adrian.hunter@intel.com>
References: <20210218095801.19576-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to support Intel PT decoding of virtual machine traces, add
branch types for VM-Entry and VM-Exit.

Note they are both treated as "calls" because the VM-Exit transfers control
to a different address.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-script.c | 2 ++
 tools/perf/util/db-export.c | 2 ++
 tools/perf/util/event.h     | 6 +++++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 4143d3f6eb37..57958bb96082 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1537,6 +1537,8 @@ static struct {
 	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TX_ABORT, "tx abrt"},
 	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TRACE_BEGIN, "tr strt"},
 	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TRACE_END, "tr end"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_VMENTRY, "vmentry"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_VMEXIT, "vmexit"},
 	{0, NULL}
 };
 
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index db7447154622..5cd189172525 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -438,6 +438,8 @@ static struct {
 	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TX_ABORT, "transaction abort"},
 	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TRACE_BEGIN, "trace begin"},
 	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TRACE_END, "trace end"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_VMENTRY, "vm entry"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_VMEXIT, "vm exit"},
 	{0, NULL}
 };
 
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 4a3b5b6478d8..034526288e05 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -96,6 +96,8 @@ enum {
 	PERF_IP_FLAG_TRACE_BEGIN	= 1ULL << 8,
 	PERF_IP_FLAG_TRACE_END		= 1ULL << 9,
 	PERF_IP_FLAG_IN_TX		= 1ULL << 10,
+	PERF_IP_FLAG_VMENTRY		= 1ULL << 11,
+	PERF_IP_FLAG_VMEXIT		= 1ULL << 12,
 };
 
 #define PERF_IP_FLAG_CHARS "bcrosyiABEx"
@@ -110,7 +112,9 @@ enum {
 	PERF_IP_FLAG_INTERRUPT		|\
 	PERF_IP_FLAG_TX_ABORT		|\
 	PERF_IP_FLAG_TRACE_BEGIN	|\
-	PERF_IP_FLAG_TRACE_END)
+	PERF_IP_FLAG_TRACE_END		|\
+	PERF_IP_FLAG_VMENTRY		|\
+	PERF_IP_FLAG_VMEXIT)
 
 #define MAX_INSN 16
 
-- 
2.17.1

