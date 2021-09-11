Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA9C407661
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 14:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbhIKMGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 08:06:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:50250 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230249AbhIKMGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 08:06:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10103"; a="221342731"
X-IronPort-AV: E=Sophos;i="5.85,285,1624345200"; 
   d="scan'208";a="221342731"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2021 05:05:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,285,1624345200"; 
   d="scan'208";a="649742301"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga005.jf.intel.com with ESMTP; 11 Sep 2021 05:05:24 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools: Fix perf_event_attr__fprintf()  missing/dupl. fields
Date:   Sat, 11 Sep 2021 15:05:50 +0300
Message-Id: <20210911120550.12203-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some fields are missing and text_poke is duplicated. Fix that up.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/perf_event_attr_fprintf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 30481825515b..47b7531f51da 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -137,6 +137,9 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(cgroup, p_unsigned);
 	PRINT_ATTRf(text_poke, p_unsigned);
 	PRINT_ATTRf(build_id, p_unsigned);
+	PRINT_ATTRf(inherit_thread, p_unsigned);
+	PRINT_ATTRf(remove_on_exec, p_unsigned);
+	PRINT_ATTRf(sigtrap, p_unsigned);
 
 	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned);
 	PRINT_ATTRf(bp_type, p_unsigned);
@@ -150,7 +153,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(aux_watermark, p_unsigned);
 	PRINT_ATTRf(sample_max_stack, p_unsigned);
 	PRINT_ATTRf(aux_sample_size, p_unsigned);
-	PRINT_ATTRf(text_poke, p_unsigned);
+	PRINT_ATTRf(sig_data, p_unsigned);
 
 	return ret;
 }
-- 
2.17.1

