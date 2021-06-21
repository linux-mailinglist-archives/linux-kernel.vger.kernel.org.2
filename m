Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC8F3AEBF9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFUPHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:07:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:58565 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230354AbhFUPHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:07:38 -0400
IronPort-SDR: Sqp3J51aStvcVsfKrWFg5gqvhwowQD8USh8sMnLWMaz9HktMHJ2MG2rgXkEZgtVylnhEutHX6A
 gAKfKaZEzDeA==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="193998939"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="193998939"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 08:05:24 -0700
IronPort-SDR: WlBsMYrmL1N1KJgSgEmZ0Gbfwin42995hEyTbT/xScxO/8B/Yee2lQ99YGYj7s/bu41HlfGR36
 KzJI9TqDgAuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="486519583"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2021 08:05:21 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 08/11] perf dlfilter: Add insn() to perf_dlfilter_fns
Date:   Mon, 21 Jun 2021 18:05:11 +0300
Message-Id: <20210621150514.32159-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210621150514.32159-1-adrian.hunter@intel.com>
References: <20210621150514.32159-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function, for use by dlfilters, to return instruction bytes.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-dlfilter.txt |  5 +++-
 tools/perf/util/dlfilter.c                 | 32 ++++++++++++++++++++++
 tools/perf/util/perf_dlfilter.h            |  4 ++-
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-dlfilter.txt b/tools/perf/Documentation/perf-dlfilter.txt
index c3fe3bc02819..5ed64bbf084e 100644
--- a/tools/perf/Documentation/perf-dlfilter.txt
+++ b/tools/perf/Documentation/perf-dlfilter.txt
@@ -110,7 +110,8 @@ struct perf_dlfilter_fns {
 	const struct perf_dlfilter_al *(*resolve_ip)(void *ctx);
 	const struct perf_dlfilter_al *(*resolve_addr)(void *ctx);
 	__s32 (*resolve_address)(void *ctx, __u64 address, struct perf_dlfilter_al *al);
-	void *(*reserved[125])(void *);
+	const __u8 *(*insn)(void *ctx, __u32 *length);
+	void *(*reserved[124])(void *);
 };
 ----
 
@@ -121,6 +122,8 @@ struct perf_dlfilter_fns {
 'resolve_address' provides information about 'address'. al->size must be set
 before calling. Returns 0 on success, -1 otherwise.
 
+'insn' returns instruction bytes and length.
+
 The perf_dlfilter_al structure
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index 3b29bf9f2bd3..375fb01bdeb8 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -15,6 +15,7 @@
 #include "dso.h"
 #include "map.h"
 #include "thread.h"
+#include "trace-event.h"
 #include "symbol.h"
 #include "dlfilter.h"
 #include "perf_dlfilter.h"
@@ -159,10 +160,41 @@ static __s32 dlfilter__resolve_address(void *ctx, __u64 address, struct perf_dlf
 	return 0;
 }
 
+static const __u8 *dlfilter__insn(void *ctx, __u32 *len)
+{
+	struct dlfilter *d = (struct dlfilter *)ctx;
+
+	if (!len)
+		return NULL;
+
+	*len = 0;
+
+	if (!d->ctx_valid)
+		return NULL;
+
+	if (d->sample->ip && !d->sample->insn_len) {
+		struct addr_location *al = d->al;
+
+		if (!al->thread && machine__resolve(d->machine, al, d->sample) < 0)
+			return NULL;
+
+		if (al->thread->maps && al->thread->maps->machine)
+			script_fetch_insn(d->sample, al->thread, al->thread->maps->machine);
+	}
+
+	if (!d->sample->insn_len)
+		return NULL;
+
+	*len = d->sample->insn_len;
+
+	return (__u8 *)d->sample->insn;
+}
+
 static const struct perf_dlfilter_fns perf_dlfilter_fns = {
 	.resolve_ip      = dlfilter__resolve_ip,
 	.resolve_addr    = dlfilter__resolve_addr,
 	.resolve_address = dlfilter__resolve_address,
+	.insn            = dlfilter__insn,
 };
 
 #define CHECK_FLAG(x) BUILD_BUG_ON((u64)PERF_DLFILTER_FLAG_ ## x != (u64)PERF_IP_FLAG_ ## x)
diff --git a/tools/perf/util/perf_dlfilter.h b/tools/perf/util/perf_dlfilter.h
index 97bceb625b54..913b773af268 100644
--- a/tools/perf/util/perf_dlfilter.h
+++ b/tools/perf/util/perf_dlfilter.h
@@ -95,8 +95,10 @@ struct perf_dlfilter_fns {
 	 * calling). Returns 0 on success, -1 otherwise.
 	 */
 	__s32 (*resolve_address)(void *ctx, __u64 address, struct perf_dlfilter_al *al);
+	/* Return instruction bytes and length */
+	const __u8 *(*insn)(void *ctx, __u32 *length);
 	/* Reserved */
-	void *(*reserved[125])(void *);
+	void *(*reserved[124])(void *);
 };
 
 /*
-- 
2.17.1

