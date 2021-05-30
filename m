Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0543952AE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 21:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhE3TYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 15:24:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:21290 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229969AbhE3TYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 15:24:39 -0400
IronPort-SDR: BClPBc7MC+sEvTRi7fftIw+NW6K51JoQcxAuw2j0a0uA+ZHevNV1bWxhyVP0qNfL6OMq9tD8So
 mafsFwWK8yDw==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="190362458"
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="190362458"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2021 12:23:01 -0700
IronPort-SDR: KZa4zlZ7aIX7H4JPPuVl/fyS8hVWoMYYcdJNDmhrYImuQgK1fXENUYeNnj1bBsaEKN6riSm+W5
 7CqolCNpNwbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="415926290"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 30 May 2021 12:22:59 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] perf scripting python: Add perf_sample_insn()
Date:   Sun, 30 May 2021 22:23:02 +0300
Message-Id: <20210530192308.7382-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210530192308.7382-1-adrian.hunter@intel.com>
References: <20210530192308.7382-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add perf_sample_insn() to the perf_trace_context module so that a script
can get the instruction bytes.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/Perf-Trace-Util/Context.c  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index 26a45ae78be4..d7f044259f9b 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -7,15 +7,23 @@
 
 #include <Python.h>
 #include "../../../util/trace-event.h"
+#include "../../../util/event.h"
+#include "../../../util/symbol.h"
+#include "../../../util/thread.h"
+#include "../../../util/maps.h"
 
 #if PY_MAJOR_VERSION < 3
 #define _PyCapsule_GetPointer(arg1, arg2) \
   PyCObject_AsVoidPtr(arg1)
+#define _PyBytes_FromStringAndSize(arg1, arg2) \
+  PyString_FromStringAndSize((arg1), (arg2))
 
 PyMODINIT_FUNC initperf_trace_context(void);
 #else
 #define _PyCapsule_GetPointer(arg1, arg2) \
   PyCapsule_GetPointer((arg1), (arg2))
+#define _PyBytes_FromStringAndSize(arg1, arg2) \
+  PyBytes_FromStringAndSize((arg1), (arg2))
 
 PyMODINIT_FUNC PyInit_perf_trace_context(void);
 #endif
@@ -62,6 +70,23 @@ static PyObject *perf_trace_context_common_lock_depth(PyObject *obj,
 	return Py_BuildValue("i", common_lock_depth(c));
 }
 
+static PyObject *perf_sample_insn(PyObject *obj, PyObject *args)
+{
+	struct scripting_context *c = get_scripting_context(args);
+
+	if (!c)
+		return NULL;
+
+	if (c->sample->ip && !c->sample->insn_len &&
+	    c->al->thread->maps && c->al->thread->maps->machine)
+		script_fetch_insn(c->sample, c->al->thread, c->al->thread->maps->machine);
+
+	if (!c->sample->insn_len)
+		Py_RETURN_NONE; /* N.B. This is a return statement */
+
+	return _PyBytes_FromStringAndSize(c->sample->insn, c->sample->insn_len);
+}
+
 static PyMethodDef ContextMethods[] = {
 	{ "common_pc", perf_trace_context_common_pc, METH_VARARGS,
 	  "Get the common preempt count event field value."},
@@ -69,6 +94,8 @@ static PyMethodDef ContextMethods[] = {
 	  "Get the common flags event field value."},
 	{ "common_lock_depth", perf_trace_context_common_lock_depth,
 	  METH_VARARGS,	"Get the common lock depth event field value."},
+	{ "perf_sample_insn", perf_sample_insn,
+	  METH_VARARGS,	"Get the machine code instruction."},
 	{ NULL, NULL, 0, NULL}
 };
 
-- 
2.17.1

