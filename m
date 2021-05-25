Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4459E38FE2F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbhEYJw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:52:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:40266 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232754AbhEYJwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:52:24 -0400
IronPort-SDR: ZS3y5MCnGzdghjL5WELvFeZoNzn6+u/evUlzRuXLdPiPn2+vRRQmMR6iS6Ld4fYvKGpWrVj/KM
 UG0nihdCkdmQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="181793007"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="181793007"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 02:50:55 -0700
IronPort-SDR: +FomL8dF9+p9Kme+VbZ5E9+5WV1E8ffmhvEkdDDOziZGj7z8OitC2rus6VX52QadH99DBQKLcL
 l1cGkqEIHFKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="479224503"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga002.fm.intel.com with ESMTP; 25 May 2021 02:50:53 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] perf scripting python: Add 'addr_location' for 'addr'
Date:   Tue, 25 May 2021 12:51:05 +0300
Message-Id: <20210525095112.1399-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210525095112.1399-1-adrian.hunter@intel.com>
References: <20210525095112.1399-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If sample addr correlates to a symbol, add  "addr_dso", "addr_symbol", and
"addr_symoff" to python scripting.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-script.c                   | 15 ++++++++---
 tools/perf/util/db-export.c                   | 12 +++------
 tools/perf/util/db-export.h                   |  2 +-
 .../util/scripting-engines/trace-event-perl.c |  3 ++-
 .../scripting-engines/trace-event-python.c    | 26 +++++++++++++------
 tools/perf/util/trace-event-scripting.c       |  3 ++-
 tools/perf/util/trace-event.h                 |  3 ++-
 7 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 2a062466c69f..f502d1c8a353 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2189,10 +2189,19 @@ static int process_sample_event(struct perf_tool *tool,
 	if (filter_cpu(sample))
 		goto out_put;
 
-	if (scripting_ops)
-		scripting_ops->process_event(event, sample, evsel, &al);
-	else
+	if (scripting_ops) {
+		struct addr_location *addr_al_ptr = NULL;
+		struct addr_location addr_al;
+
+		if ((evsel->core.attr.sample_type & PERF_SAMPLE_ADDR) &&
+		    sample_addr_correlates_sym(&evsel->core.attr)) {
+			thread__resolve(al.thread, &addr_al, sample);
+			addr_al_ptr = &addr_al;
+		}
+		scripting_ops->process_event(event, sample, evsel, &al, addr_al_ptr);
+	} else {
 		process_event(scr, sample, evsel, &al, machine);
+	}
 
 out_put:
 	addr_location__put(&al);
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 5cd189172525..e0d4f08839fb 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -343,7 +343,7 @@ static int db_export__threads(struct db_export *dbe, struct thread *thread,
 
 int db_export__sample(struct db_export *dbe, union perf_event *event,
 		      struct perf_sample *sample, struct evsel *evsel,
-		      struct addr_location *al)
+		      struct addr_location *al, struct addr_location *addr_al)
 {
 	struct thread *thread = al->thread;
 	struct export_sample es = {
@@ -389,18 +389,14 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 		}
 	}
 
-	if ((evsel->core.attr.sample_type & PERF_SAMPLE_ADDR) &&
-	    sample_addr_correlates_sym(&evsel->core.attr)) {
-		struct addr_location addr_al;
-
-		thread__resolve(thread, &addr_al, sample);
-		err = db_ids_from_al(dbe, &addr_al, &es.addr_dso_db_id,
+	if (addr_al) {
+		err = db_ids_from_al(dbe, addr_al, &es.addr_dso_db_id,
 				     &es.addr_sym_db_id, &es.addr_offset);
 		if (err)
 			goto out_put;
 		if (dbe->crp) {
 			err = thread_stack__process(thread, comm, sample, al,
-						    &addr_al, es.db_id,
+						    addr_al, es.db_id,
 						    dbe->crp);
 			if (err)
 				goto out_put;
diff --git a/tools/perf/util/db-export.h b/tools/perf/util/db-export.h
index 9c3d38f5a40d..23983cb35706 100644
--- a/tools/perf/util/db-export.h
+++ b/tools/perf/util/db-export.h
@@ -97,7 +97,7 @@ int db_export__branch_type(struct db_export *dbe, u32 branch_type,
 			   const char *name);
 int db_export__sample(struct db_export *dbe, union perf_event *event,
 		      struct perf_sample *sample, struct evsel *evsel,
-		      struct addr_location *al);
+		      struct addr_location *al, struct addr_location *addr_al);
 
 int db_export__branch_types(struct db_export *dbe);
 
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index 865d310968fb..a837aee24674 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -456,7 +456,8 @@ static void perl_process_event_generic(union perf_event *event,
 static void perl_process_event(union perf_event *event,
 			       struct perf_sample *sample,
 			       struct evsel *evsel,
-			       struct addr_location *al)
+			       struct addr_location *al,
+			       struct addr_location *addr_al __maybe_unused)
 {
 	perl_process_tracepoint(sample, evsel, al);
 	perl_process_event_generic(event, sample, evsel);
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 4c067601595c..a434f4bc25a4 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -745,6 +745,7 @@ static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
 static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 					 struct evsel *evsel,
 					 struct addr_location *al,
+					 struct addr_location *addr_al,
 					 PyObject *callchain)
 {
 	PyObject *dict, *dict_sample, *brstack, *brstacksym;
@@ -798,6 +799,12 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 	brstacksym = python_process_brstacksym(sample, al->thread);
 	pydict_set_item_string_decref(dict, "brstacksym", brstacksym);
 
+	if (addr_al) {
+		pydict_set_item_string_decref(dict_sample, "addr_correlates_sym",
+			PyBool_FromLong(1));
+		set_sym_in_dict(dict_sample, addr_al, "addr_dso", "addr_symbol", "addr_symoff");
+	}
+
 	set_regs_in_dict(dict, sample, evsel);
 
 	return dict;
@@ -805,7 +812,8 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 
 static void python_process_tracepoint(struct perf_sample *sample,
 				      struct evsel *evsel,
-				      struct addr_location *al)
+				      struct addr_location *al,
+				      struct addr_location *addr_al)
 {
 	struct tep_event *event = evsel->tp_format;
 	PyObject *handler, *context, *t, *obj = NULL, *callchain;
@@ -915,7 +923,7 @@ static void python_process_tracepoint(struct perf_sample *sample,
 		PyTuple_SetItem(t, n++, dict);
 
 	if (get_argument_count(handler) == (int) n + 1) {
-		all_entries_dict = get_perf_sample_dict(sample, evsel, al,
+		all_entries_dict = get_perf_sample_dict(sample, evsel, al, addr_al,
 			callchain);
 		PyTuple_SetItem(t, n++,	all_entries_dict);
 	} else {
@@ -1306,7 +1314,8 @@ static int python_process_call_return(struct call_return *cr, u64 *parent_db_id,
 
 static void python_process_general_event(struct perf_sample *sample,
 					 struct evsel *evsel,
-					 struct addr_location *al)
+					 struct addr_location *al,
+					 struct addr_location *addr_al)
 {
 	PyObject *handler, *t, *dict, *callchain;
 	static char handler_name[64];
@@ -1328,7 +1337,7 @@ static void python_process_general_event(struct perf_sample *sample,
 
 	/* ip unwinding */
 	callchain = python_process_callchain(sample, evsel, al);
-	dict = get_perf_sample_dict(sample, evsel, al, callchain);
+	dict = get_perf_sample_dict(sample, evsel, al, addr_al, callchain);
 
 	PyTuple_SetItem(t, n++, dict);
 	if (_PyTuple_Resize(&t, n) == -1)
@@ -1342,20 +1351,21 @@ static void python_process_general_event(struct perf_sample *sample,
 static void python_process_event(union perf_event *event,
 				 struct perf_sample *sample,
 				 struct evsel *evsel,
-				 struct addr_location *al)
+				 struct addr_location *al,
+				 struct addr_location *addr_al)
 {
 	struct tables *tables = &tables_global;
 
 	switch (evsel->core.attr.type) {
 	case PERF_TYPE_TRACEPOINT:
-		python_process_tracepoint(sample, evsel, al);
+		python_process_tracepoint(sample, evsel, al, addr_al);
 		break;
 	/* Reserve for future process_hw/sw/raw APIs */
 	default:
 		if (tables->db_export_mode)
-			db_export__sample(&tables->dbe, event, sample, evsel, al);
+			db_export__sample(&tables->dbe, event, sample, evsel, al, addr_al);
 		else
-			python_process_general_event(sample, evsel, al);
+			python_process_general_event(sample, evsel, al, addr_al);
 	}
 }
 
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index 721f38c0d5cf..a60885fa5c0f 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -29,7 +29,8 @@ static int stop_script_unsupported(void)
 static void process_event_unsupported(union perf_event *event __maybe_unused,
 				      struct perf_sample *sample __maybe_unused,
 				      struct evsel *evsel __maybe_unused,
-				      struct addr_location *al __maybe_unused)
+				      struct addr_location *al __maybe_unused,
+				      struct addr_location *addr_al __maybe_unused)
 {
 }
 
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 39fb39ed6612..24694463c0be 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -78,7 +78,8 @@ struct scripting_ops {
 	void (*process_event) (union perf_event *event,
 			       struct perf_sample *sample,
 			       struct evsel *evsel,
-			       struct addr_location *al);
+			       struct addr_location *al,
+			       struct addr_location *addr_al);
 	void (*process_switch)(union perf_event *event,
 			       struct perf_sample *sample,
 			       struct machine *machine);
-- 
2.17.1

