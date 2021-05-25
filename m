Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6385D38FE33
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhEYJwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:52:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:18662 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232789AbhEYJwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:52:36 -0400
IronPort-SDR: yGndgsryig2+gHi/b45dJTp7KFnVIYoc1Y9TWiVTIwRRLb5eMVSOdvJtx3yDV9kwKqU9o4h32Z
 w+uFbId0GJBA==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="189531614"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="189531614"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 02:51:04 -0700
IronPort-SDR: Zu4ll7yHdFd6FdbHtnTFsFmlccfQ1+YsWZXBWbP+g2c0/rArHzUftw2AguDw6/YiDCwq0EfxiY
 TWR5XLyztV6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="479224571"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga002.fm.intel.com with ESMTP; 25 May 2021 02:51:02 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] perf scripting python: Add context switch
Date:   Tue, 25 May 2021 12:51:10 +0300
Message-Id: <20210525095112.1399-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210525095112.1399-1-adrian.hunter@intel.com>
References: <20210525095112.1399-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add context_switch to general python scripting.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripting-engines/trace-event-python.c    | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index cb708669e02e..c422901d5344 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1019,6 +1019,11 @@ static int tuple_set_s32(PyObject *t, unsigned int pos, s32 val)
 	return PyTuple_SetItem(t, pos, _PyLong_FromLong(val));
 }
 
+static int tuple_set_bool(PyObject *t, unsigned int pos, bool val)
+{
+	return PyTuple_SetItem(t, pos, PyBool_FromLong(val));
+}
+
 static int tuple_set_string(PyObject *t, unsigned int pos, const char *s)
 {
 	return PyTuple_SetItem(t, pos, _PyUnicode_FromString(s));
@@ -1406,6 +1411,44 @@ static void python_process_event(union perf_event *event,
 	}
 }
 
+static void python_do_process_switch(union perf_event *event,
+				     struct perf_sample *sample,
+				     struct machine *machine)
+{
+	const char *handler_name = "context_switch";
+	bool out = event->header.misc & PERF_RECORD_MISC_SWITCH_OUT;
+	bool out_preempt = out && (event->header.misc & PERF_RECORD_MISC_SWITCH_OUT_PREEMPT);
+	pid_t np_pid = -1, np_tid = -1;
+	PyObject *handler, *t;
+
+	handler = get_handler(handler_name);
+	if (!handler)
+		return;
+
+	if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE) {
+		np_pid = event->context_switch.next_prev_pid;
+		np_tid = event->context_switch.next_prev_tid;
+	}
+
+	t = tuple_new(9);
+	if (!t)
+		return;
+
+	tuple_set_u64(t, 0, sample->time);
+	tuple_set_s32(t, 1, sample->cpu);
+	tuple_set_s32(t, 2, sample->pid);
+	tuple_set_s32(t, 3, sample->tid);
+	tuple_set_s32(t, 4, np_pid);
+	tuple_set_s32(t, 5, np_tid);
+	tuple_set_s32(t, 6, machine->pid);
+	tuple_set_bool(t, 7, out);
+	tuple_set_bool(t, 8, out_preempt);
+
+	call_object(handler, t, handler_name);
+
+	Py_DECREF(t);
+}
+
 static void python_process_switch(union perf_event *event,
 				  struct perf_sample *sample,
 				  struct machine *machine)
@@ -1414,6 +1457,8 @@ static void python_process_switch(union perf_event *event,
 
 	if (tables->db_export_mode)
 		db_export__switch(&tables->dbe, event, sample, machine);
+	else
+		python_do_process_switch(event, sample, machine);
 }
 
 static void get_handler_name(char *str, size_t size,
-- 
2.17.1

