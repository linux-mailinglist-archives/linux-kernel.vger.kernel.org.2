Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7033AEBF2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhFUPHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:07:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:58521 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230165AbhFUPHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:07:17 -0400
IronPort-SDR: 3rS9dW1BvDURNiziI7YjavZkWRrlPC8JmHq24ARxeFBHcLwdmLSMVMJjAUn+DvLolG0+Jnloc0
 Gp7blVddiMfQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="193998833"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="193998833"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 08:05:02 -0700
IronPort-SDR: nyPvQPw3/q1vOotyg6l2FvjcbbpPEiDwuBBtnPeQq/32YE6IolV4yqdtlI9PlZYCOndt09N1a0
 xHYI8ItcwzRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="486519285"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2021 08:04:57 -0700
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
Subject: [PATCH RFC 02/11] perf script: Move filtering before scripting
Date:   Mon, 21 Jun 2021 18:05:05 +0300
Message-Id: <20210621150514.32159-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210621150514.32159-1-adrian.hunter@intel.com>
References: <20210621150514.32159-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make it possible to use filtering with scripts, move filtering before
scripting.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-script.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 08a2b5d51018..ff7b43899f2e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1984,12 +1984,6 @@ static void process_event(struct perf_script *script,
 	if (output[type].fields == 0)
 		return;
 
-	if (!show_event(sample, evsel, thread, al))
-		return;
-
-	if (evswitch__discard(&script->evswitch, evsel))
-		return;
-
 	++es->samples;
 
 	perf_sample__fprintf_start(script, sample, thread, evsel,
@@ -2203,6 +2197,12 @@ static int process_sample_event(struct perf_tool *tool,
 	if (al.filtered)
 		goto out_put;
 
+	if (!show_event(sample, evsel, al.thread, &al))
+		goto out_put;
+
+	if (evswitch__discard(&scr->evswitch, evsel))
+		goto out_put;
+
 	if (scripting_ops) {
 		struct addr_location *addr_al_ptr = NULL;
 		struct addr_location addr_al;
-- 
2.17.1

