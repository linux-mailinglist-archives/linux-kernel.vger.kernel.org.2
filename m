Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624B23952A9
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 21:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhE3TYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 15:24:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:21268 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229894AbhE3TYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 15:24:32 -0400
IronPort-SDR: tajxl0L54L8XSxhkA4J/X1I6fYah6tKTrRJMrjDixdtmY/xTohjDtujfTEZn3X+IipJ+HCjplB
 J0NCp0f9oL0g==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="190362430"
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="190362430"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2021 12:22:54 -0700
IronPort-SDR: yP9mV7GneARocJ+USNOLoPTV2Sv6Iqb6W1NhrdXYe0GVUHjXfszF0ggSGvf1JThQTr0iWUXZEF
 83/fKgeRkFfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="415926271"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 30 May 2021 12:22:52 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] perf scripting: Add scripting_context__update()
Date:   Sun, 30 May 2021 22:22:58 +0300
Message-Id: <20210530192308.7382-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210530192308.7382-1-adrian.hunter@intel.com>
References: <20210530192308.7382-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move scripting_context update to a separate function and add
the arguments of ->process_event() to it.

This prepares the way for adding more methods to the perf_trace_context
module, by providing the context information that they will need.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../util/scripting-engines/trace-event-perl.c |  6 ++----
 .../scripting-engines/trace-event-python.c    |  5 ++---
 tools/perf/util/trace-event-scripting.c       | 21 +++++++++++++++++++
 tools/perf/util/trace-event.h                 | 13 ++++++++++++
 4 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index a837aee24674..5bbf00c1179f 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -371,9 +371,6 @@ static void perl_process_tracepoint(struct perf_sample *sample,
 	s = nsecs / NSEC_PER_SEC;
 	ns = nsecs - s * NSEC_PER_SEC;
 
-	scripting_context->event_data = data;
-	scripting_context->pevent = evsel->tp_format->tep;
-
 	ENTER;
 	SAVETMPS;
 	PUSHMARK(SP);
@@ -457,8 +454,9 @@ static void perl_process_event(union perf_event *event,
 			       struct perf_sample *sample,
 			       struct evsel *evsel,
 			       struct addr_location *al,
-			       struct addr_location *addr_al __maybe_unused)
+			       struct addr_location *addr_al)
 {
+	scripting_context__update(scripting_context, event, sample, evsel, al, addr_al);
 	perl_process_tracepoint(sample, evsel, al);
 	perl_process_event_generic(event, sample, evsel);
 }
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index ffc5f4cffdba..d99f71916af7 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -897,9 +897,6 @@ static void python_process_tracepoint(struct perf_sample *sample,
 	s = nsecs / NSEC_PER_SEC;
 	ns = nsecs - s * NSEC_PER_SEC;
 
-	scripting_context->event_data = data;
-	scripting_context->pevent = evsel->tp_format->tep;
-
 	context = _PyCapsule_New(scripting_context, NULL, NULL);
 
 	PyTuple_SetItem(t, n++, _PyUnicode_FromString(handler_name));
@@ -1403,6 +1400,8 @@ static void python_process_event(union perf_event *event,
 {
 	struct tables *tables = &tables_global;
 
+	scripting_context__update(scripting_context, event, sample, evsel, al, addr_al);
+
 	switch (evsel->core.attr.type) {
 	case PERF_TYPE_TRACEPOINT:
 		python_process_tracepoint(sample, evsel, al, addr_al);
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index 6c51fba70d49..a2f0c1e460a2 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -12,10 +12,31 @@
 
 #include "debug.h"
 #include "trace-event.h"
+#include "event.h"
+#include "evsel.h"
 #include <linux/zalloc.h>
 
 struct scripting_context *scripting_context;
 
+void scripting_context__update(struct scripting_context *c,
+			       union perf_event *event,
+			       struct perf_sample *sample,
+			       struct evsel *evsel,
+			       struct addr_location *al,
+			       struct addr_location *addr_al)
+{
+	c->event_data = sample->raw_data;
+	if (evsel->tp_format)
+		c->pevent = evsel->tp_format->tep;
+	else
+		c->pevent = NULL;
+	c->event = event;
+	c->sample = sample;
+	c->evsel = evsel;
+	c->al = al;
+	c->addr_al = addr_al;
+}
+
 static int flush_script_unsupported(void)
 {
 	return 0;
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 35c354a15c3a..a939318b88a6 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -11,6 +11,7 @@ union perf_event;
 struct perf_tool;
 struct thread;
 struct tep_plugin_list;
+struct evsel;
 
 struct trace_event {
 	struct tep_handle	*pevent;
@@ -101,8 +102,20 @@ void setup_python_scripting(void);
 struct scripting_context {
 	struct tep_handle *pevent;
 	void *event_data;
+	union perf_event *event;
+	struct perf_sample *sample;
+	struct evsel *evsel;
+	struct addr_location *al;
+	struct addr_location *addr_al;
 };
 
+void scripting_context__update(struct scripting_context *scripting_context,
+			       union perf_event *event,
+			       struct perf_sample *sample,
+			       struct evsel *evsel,
+			       struct addr_location *al,
+			       struct addr_location *addr_al);
+
 int common_pc(struct scripting_context *context);
 int common_flags(struct scripting_context *context);
 int common_lock_depth(struct scripting_context *context);
-- 
2.17.1

