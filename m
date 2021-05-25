Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2DC38FE35
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbhEYJwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:52:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:18657 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232755AbhEYJwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:52:38 -0400
IronPort-SDR: vif5ySqEe5LaKy1N+eZWx6Vdtf9m0WFkqDfQoGB2PGpqJzQVejWIfR7wbt1vjgTKPPu3S74qrK
 o5m3C5otfcmA==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="189531615"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="189531615"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 02:51:06 -0700
IronPort-SDR: z5SSbCa/a/fCVwbo7wcY4mPO/6cjQ6nnZsvzpYkS+FQ8PbLby5T8KgmLI72QwVZuNbaMmr+yUn
 f/Jf4CdgLJaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="479224583"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga002.fm.intel.com with ESMTP; 25 May 2021 02:51:04 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] perf scripting python: Add auxtrace error
Date:   Tue, 25 May 2021 12:51:11 +0300
Message-Id: <20210525095112.1399-10-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210525095112.1399-1-adrian.hunter@intel.com>
References: <20210525095112.1399-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add auxtrace_error to general python scripting.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-script.c                   | 13 ++++++
 .../scripting-engines/trace-event-python.c    | 42 +++++++++++++++++++
 tools/perf/util/trace-event.h                 |  2 +
 3 files changed, 57 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 69bce65ea430..7a7a19f52db5 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2432,6 +2432,17 @@ static int process_switch_event(struct perf_tool *tool,
 			   sample->tid);
 }
 
+static int process_auxtrace_error(struct perf_session *session,
+				  union perf_event *event)
+{
+	if (scripting_ops && scripting_ops->process_auxtrace_error) {
+		scripting_ops->process_auxtrace_error(session, event);
+		return 0;
+	}
+
+	return perf_event__process_auxtrace_error(session, event);
+}
+
 static int
 process_lost_event(struct perf_tool *tool,
 		   union perf_event *event,
@@ -2571,6 +2582,8 @@ static int __cmd_script(struct perf_script *script)
 	}
 	if (script->show_switch_events || (scripting_ops && scripting_ops->process_switch))
 		script->tool.context_switch = process_switch_event;
+	if (scripting_ops && scripting_ops->process_auxtrace_error)
+		script->tool.auxtrace_error = process_auxtrace_error;
 	if (script->show_namespace_events)
 		script->tool.namespaces = process_namespaces_event;
 	if (script->show_cgroup_events)
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index c422901d5344..ffc5f4cffdba 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1014,6 +1014,11 @@ static int tuple_set_u64(PyObject *t, unsigned int pos, u64 val)
 #endif
 }
 
+static int tuple_set_u32(PyObject *t, unsigned int pos, u32 val)
+{
+	return PyTuple_SetItem(t, pos, PyLong_FromUnsignedLong(val));
+}
+
 static int tuple_set_s32(PyObject *t, unsigned int pos, s32 val)
 {
 	return PyTuple_SetItem(t, pos, _PyLong_FromLong(val));
@@ -1461,6 +1466,42 @@ static void python_process_switch(union perf_event *event,
 		python_do_process_switch(event, sample, machine);
 }
 
+static void python_process_auxtrace_error(struct perf_session *session __maybe_unused,
+					  union perf_event *event)
+{
+	struct perf_record_auxtrace_error *e = &event->auxtrace_error;
+	u8 cpumode = e->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
+	const char *handler_name = "auxtrace_error";
+	unsigned long long tm = e->time;
+	const char *msg = e->msg;
+	PyObject *handler, *t;
+
+	handler = get_handler(handler_name);
+	if (!handler)
+		return;
+
+	if (!e->fmt) {
+		tm = 0;
+		msg = (const char *)&e->time;
+	}
+
+	t = tuple_new(9);
+
+	tuple_set_u32(t, 0, e->type);
+	tuple_set_u32(t, 1, e->code);
+	tuple_set_s32(t, 2, e->cpu);
+	tuple_set_s32(t, 3, e->pid);
+	tuple_set_s32(t, 4, e->tid);
+	tuple_set_u64(t, 5, e->ip);
+	tuple_set_u64(t, 6, tm);
+	tuple_set_string(t, 7, msg);
+	tuple_set_u32(t, 8, cpumode);
+
+	call_object(handler, t, handler_name);
+
+	Py_DECREF(t);
+}
+
 static void get_handler_name(char *str, size_t size,
 			     struct evsel *evsel)
 {
@@ -1999,6 +2040,7 @@ struct scripting_ops python_scripting_ops = {
 	.stop_script		= python_stop_script,
 	.process_event		= python_process_event,
 	.process_switch		= python_process_switch,
+	.process_auxtrace_error	= python_process_auxtrace_error,
 	.process_stat		= python_process_stat,
 	.process_stat_interval	= python_process_stat_interval,
 	.generate_script	= python_generate_script,
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 7276674e2971..35c354a15c3a 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -83,6 +83,8 @@ struct scripting_ops {
 	void (*process_switch)(union perf_event *event,
 			       struct perf_sample *sample,
 			       struct machine *machine);
+	void (*process_auxtrace_error)(struct perf_session *session,
+				       union perf_event *event);
 	void (*process_stat)(struct perf_stat_config *config,
 			     struct evsel *evsel, u64 tstamp);
 	void (*process_stat_interval)(u64 tstamp);
-- 
2.17.1

