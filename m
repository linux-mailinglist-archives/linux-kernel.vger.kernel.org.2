Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA7C3952B0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 21:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhE3TYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 15:24:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:21286 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229988AbhE3TYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 15:24:48 -0400
IronPort-SDR: MBj2fGbukt7MevBScskKjqDER6ccir4opKPYzhBl/bGMTKt3J5nbMmUi8cQAnaCt3JlWlKb1rE
 OF9ph8NH0NzQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="190362465"
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="190362465"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2021 12:23:05 -0700
IronPort-SDR: Zylr10NcR7yyFrrCggcrSd6GYARnu7upO29P4J0G6ibb+ba9TVO/n350uCFH5RxEqhw3nAjEsb
 4FG4C/w3Pshw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="415926308"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 30 May 2021 12:23:03 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] perf scripting python: Add perf_set_itrace_options()
Date:   Sun, 30 May 2021 22:23:04 +0300
Message-Id: <20210530192308.7382-10-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210530192308.7382-1-adrian.hunter@intel.com>
References: <20210530192308.7382-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add perf_set_itrace_options() to the perf_trace_context module so that a
script can set the itrace options for a session if they have not been set
already.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/Perf-Trace-Util/Context.c  | 44 ++++++++++++++++++-
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index d7f044259f9b..3c9bc12a1332 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -11,12 +11,16 @@
 #include "../../../util/symbol.h"
 #include "../../../util/thread.h"
 #include "../../../util/maps.h"
+#include "../../../util/auxtrace.h"
+#include "../../../util/session.h"
 
 #if PY_MAJOR_VERSION < 3
 #define _PyCapsule_GetPointer(arg1, arg2) \
   PyCObject_AsVoidPtr(arg1)
 #define _PyBytes_FromStringAndSize(arg1, arg2) \
   PyString_FromStringAndSize((arg1), (arg2))
+#define _PyUnicode_AsUTF8(arg) \
+  PyString_AsString(arg)
 
 PyMODINIT_FUNC initperf_trace_context(void);
 #else
@@ -24,20 +28,28 @@ PyMODINIT_FUNC initperf_trace_context(void);
   PyCapsule_GetPointer((arg1), (arg2))
 #define _PyBytes_FromStringAndSize(arg1, arg2) \
   PyBytes_FromStringAndSize((arg1), (arg2))
+#define _PyUnicode_AsUTF8(arg) \
+  PyUnicode_AsUTF8(arg)
 
 PyMODINIT_FUNC PyInit_perf_trace_context(void);
 #endif
 
-static struct scripting_context *get_scripting_context(PyObject *args)
+static struct scripting_context *get_args(PyObject *args, const char *name, PyObject **arg2)
 {
+	int cnt = 1 + !!arg2;
 	PyObject *context;
 
-	if (!PyArg_ParseTuple(args, "O", &context))
+	if (!PyArg_UnpackTuple(args, name, 1, cnt, &context, arg2))
 		return NULL;
 
 	return _PyCapsule_GetPointer(context, NULL);
 }
 
+static struct scripting_context *get_scripting_context(PyObject *args)
+{
+	return get_args(args, "context", NULL);
+}
+
 static PyObject *perf_trace_context_common_pc(PyObject *obj, PyObject *args)
 {
 	struct scripting_context *c = get_scripting_context(args);
@@ -87,6 +99,32 @@ static PyObject *perf_sample_insn(PyObject *obj, PyObject *args)
 	return _PyBytes_FromStringAndSize(c->sample->insn, c->sample->insn_len);
 }
 
+static PyObject *perf_set_itrace_options(PyObject *obj, PyObject *args)
+{
+	struct scripting_context *c;
+	const char *itrace_options;
+	int retval = -1;
+	PyObject *str;
+
+	c = get_args(args, "itrace_options", &str);
+	if (!c)
+		return NULL;
+
+	if (!c->session || !c->session->itrace_synth_opts)
+		goto out;
+
+	if (c->session->itrace_synth_opts->set) {
+		retval = 1;
+		goto out;
+	}
+
+	itrace_options = _PyUnicode_AsUTF8(str);
+
+	retval = itrace_do_parse_synth_opts(c->session->itrace_synth_opts, itrace_options, 0);
+out:
+	return Py_BuildValue("i", retval);
+}
+
 static PyMethodDef ContextMethods[] = {
 	{ "common_pc", perf_trace_context_common_pc, METH_VARARGS,
 	  "Get the common preempt count event field value."},
@@ -96,6 +134,8 @@ static PyMethodDef ContextMethods[] = {
 	  METH_VARARGS,	"Get the common lock depth event field value."},
 	{ "perf_sample_insn", perf_sample_insn,
 	  METH_VARARGS,	"Get the machine code instruction."},
+	{ "perf_set_itrace_options", perf_set_itrace_options,
+	  METH_VARARGS,	"Set --itrace options."},
 	{ NULL, NULL, 0, NULL}
 };
 
-- 
2.17.1

