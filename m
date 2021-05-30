Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887453952B1
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 21:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhE3TY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 15:24:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:21290 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229995AbhE3TYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 15:24:49 -0400
IronPort-SDR: FDkwBQ54ZCC4PMtO5s18SIlCv/WD0uWuf9YzAkP/IvQsU30xZqQY+eClIcxGPntaXDttC+9stV
 3A+DQAHdh3Ug==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="190362467"
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="190362467"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2021 12:23:07 -0700
IronPort-SDR: 9E0IYUC5AxmHLr0UXpDrPfdAlpRAuhukgSIvKJHe/8UYF88QssyUfmGFZn0ntg1B55fTyB0cTq
 K/7cIP0pRK4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="415926313"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 30 May 2021 12:23:05 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] perf scripting python: Add perf_sample_srcline() and perf_sample_srccode()
Date:   Sun, 30 May 2021 22:23:05 +0300
Message-Id: <20210530192308.7382-11-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210530192308.7382-1-adrian.hunter@intel.com>
References: <20210530192308.7382-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add perf_sample_srcline() and perf_sample_srccode() to the
perf_trace_context module so that a script can get the srcline or srccode
information.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/Perf-Trace-Util/Context.c  | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index 3c9bc12a1332..895f5fc23965 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -5,14 +5,23 @@
  * Copyright (C) 2010 Tom Zanussi <tzanussi@gmail.com>
  */
 
+/*
+ * Use Py_ssize_t for '#' formats to avoid DeprecationWarning: PY_SSIZE_T_CLEAN
+ * will be required for '#' formats.
+ */
+#define PY_SSIZE_T_CLEAN
+
 #include <Python.h>
 #include "../../../util/trace-event.h"
 #include "../../../util/event.h"
 #include "../../../util/symbol.h"
 #include "../../../util/thread.h"
+#include "../../../util/map.h"
 #include "../../../util/maps.h"
 #include "../../../util/auxtrace.h"
 #include "../../../util/session.h"
+#include "../../../util/srcline.h"
+#include "../../../util/srccode.h"
 
 #if PY_MAJOR_VERSION < 3
 #define _PyCapsule_GetPointer(arg1, arg2) \
@@ -125,6 +134,49 @@ static PyObject *perf_set_itrace_options(PyObject *obj, PyObject *args)
 	return Py_BuildValue("i", retval);
 }
 
+static PyObject *perf_sample_src(PyObject *obj, PyObject *args, bool get_srccode)
+{
+	struct scripting_context *c = get_scripting_context(args);
+	unsigned int line = 0;
+	char *srcfile = NULL;
+	char *srccode = NULL;
+	PyObject *result;
+	struct map *map;
+	int len = 0;
+	u64 addr;
+
+	if (!c)
+		return NULL;
+
+	map = c->al->map;
+	addr = c->al->addr;
+
+	if (map && map->dso)
+		srcfile = get_srcline_split(map->dso, map__rip_2objdump(map, addr), &line);
+
+	if (get_srccode) {
+		if (srcfile)
+			srccode = find_sourceline(srcfile, line, &len);
+		result = Py_BuildValue("(sIs#)", srcfile, line, srccode, (Py_ssize_t)len);
+	} else {
+		result = Py_BuildValue("(sI)", srcfile, line);
+	}
+
+	free(srcfile);
+
+	return result;
+}
+
+static PyObject *perf_sample_srcline(PyObject *obj, PyObject *args)
+{
+	return perf_sample_src(obj, args, false);
+}
+
+static PyObject *perf_sample_srccode(PyObject *obj, PyObject *args)
+{
+	return perf_sample_src(obj, args, true);
+}
+
 static PyMethodDef ContextMethods[] = {
 	{ "common_pc", perf_trace_context_common_pc, METH_VARARGS,
 	  "Get the common preempt count event field value."},
@@ -136,6 +188,10 @@ static PyMethodDef ContextMethods[] = {
 	  METH_VARARGS,	"Get the machine code instruction."},
 	{ "perf_set_itrace_options", perf_set_itrace_options,
 	  METH_VARARGS,	"Set --itrace options."},
+	{ "perf_sample_srcline", perf_sample_srcline,
+	  METH_VARARGS,	"Get source file name and line number."},
+	{ "perf_sample_srccode", perf_sample_srccode,
+	  METH_VARARGS,	"Get source file name, line number and line."},
 	{ NULL, NULL, 0, NULL}
 };
 
-- 
2.17.1

