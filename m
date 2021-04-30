Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B457236F614
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhD3HDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:03:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:34039 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230394AbhD3HDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:03:42 -0400
IronPort-SDR: sMOgepCJFXJOekkbgoTnYOE6zD9seQkwHCi7WioDh1vVKrVigHMrkcKBc8DTYnEQU2tWeJ46Lf
 tfYt0mpq5EtA==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="197312419"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="197312419"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 00:02:55 -0700
IronPort-SDR: dk2uJVozepeqF0WX0F3r2arPnhu0md8sDNP7j6sgPjbv5d2NiJV4dQnRFGgwDK4bBS+SMmmm86
 KGDC8rFTJhFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="404492245"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 30 Apr 2021 00:02:53 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH V2 02/12] perf intel-pt: Move synth_opts initialization earlier
Date:   Fri, 30 Apr 2021 10:02:59 +0300
Message-Id: <20210430070309.17624-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210430070309.17624-1-adrian.hunter@intel.com>
References: <20210430070309.17624-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move synth_opts initialization earlier, so it can be used earlier.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 8658d42ce57a..eef8970d98fe 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -3479,6 +3479,20 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 
 	intel_pt_log_set_name(INTEL_PT_PMU_NAME);
 
+	if (session->itrace_synth_opts->set) {
+		pt->synth_opts = *session->itrace_synth_opts;
+	} else {
+		struct itrace_synth_opts *opts = session->itrace_synth_opts;
+
+		itrace_synth_opts__set_default(&pt->synth_opts, opts->default_no_sample);
+		if (!opts->default_no_sample && !opts->inject) {
+			pt->synth_opts.branches = false;
+			pt->synth_opts.callchain = true;
+			pt->synth_opts.add_callchain = true;
+		}
+		pt->synth_opts.thread_stack = opts->thread_stack;
+	}
+
 	pt->session = session;
 	pt->machine = &session->machines.host; /* No kvm support */
 	pt->auxtrace_type = auxtrace_info->type;
@@ -3609,21 +3623,6 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 		goto err_delete_thread;
 	}
 
-	if (session->itrace_synth_opts->set) {
-		pt->synth_opts = *session->itrace_synth_opts;
-	} else {
-		itrace_synth_opts__set_default(&pt->synth_opts,
-				session->itrace_synth_opts->default_no_sample);
-		if (!session->itrace_synth_opts->default_no_sample &&
-		    !session->itrace_synth_opts->inject) {
-			pt->synth_opts.branches = false;
-			pt->synth_opts.callchain = true;
-			pt->synth_opts.add_callchain = true;
-		}
-		pt->synth_opts.thread_stack =
-				session->itrace_synth_opts->thread_stack;
-	}
-
 	if (pt->synth_opts.log)
 		intel_pt_log_enable();
 
-- 
2.25.1

