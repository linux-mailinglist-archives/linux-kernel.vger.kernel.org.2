Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896503952AD
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 21:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhE3TYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 15:24:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:21286 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbhE3TYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 15:24:37 -0400
IronPort-SDR: VU7Aak38d11Wbk7a2pLLZfaAXQcv1Mi/p53ShQ8RLgnZ0U1qkdtyYHzGfmGJyyLAZkHLV+rQAF
 pRAU7dYE4ORQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="190362457"
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="190362457"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2021 12:22:59 -0700
IronPort-SDR: N8aMovd213CBV3cSTWVEClamvJ0aLUsf4ZtBrnlGcn2DFCyGUhLM7OdzrQSakH1zfSy4pyG2ZG
 ABL7YO3OEi6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="415926287"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 30 May 2021 12:22:57 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] perf script: Factor out script_fetch_insn()
Date:   Sun, 30 May 2021 22:23:01 +0300
Message-Id: <20210530192308.7382-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210530192308.7382-1-adrian.hunter@intel.com>
References: <20210530192308.7382-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out script_fetch_insn() so it can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-script.c   | 10 ++++++++--
 tools/perf/util/trace-event.h |  3 +++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index fd5c257d55a8..57488d60b64a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1417,6 +1417,13 @@ __weak void arch_fetch_insn(struct perf_sample *sample __maybe_unused,
 {
 }
 
+void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
+		       struct machine *machine)
+{
+	if (sample->insn_len == 0 && native_arch)
+		arch_fetch_insn(sample, thread, machine);
+}
+
 static int perf_sample__fprintf_insn(struct perf_sample *sample,
 				     struct perf_event_attr *attr,
 				     struct thread *thread,
@@ -1424,8 +1431,7 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
 {
 	int printed = 0;
 
-	if (sample->insn_len == 0 && native_arch)
-		arch_fetch_insn(sample, thread, machine);
+	script_fetch_insn(sample, thread, machine);
 
 	if (PRINT_FIELD(INSNLEN))
 		printed += fprintf(fp, " ilen: %d", sample->insn_len);
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 73f5b29472f7..54aadeedf28c 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -97,6 +97,9 @@ extern unsigned int scripting_max_stack;
 
 int script_spec_register(const char *spec, struct scripting_ops *ops);
 
+void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
+		       struct machine *machine);
+
 void setup_perl_scripting(void);
 void setup_python_scripting(void);
 
-- 
2.17.1

