Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150AD3952A8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 21:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhE3TYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 15:24:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:21268 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229866AbhE3TYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 15:24:30 -0400
IronPort-SDR: d8bdSoh3IBzRYDD3PNV+4ljqGFCJtdPLG6Krmuw7gytv4aCT68rUPryDn62aovJRQelgTwzTPV
 BKwsrnfHlxwg==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="190362425"
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="190362425"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2021 12:22:52 -0700
IronPort-SDR: QPfYqTArMA9UHIoDPIdYw3CvIFrgPLrUtFEFHSEM9EGKzRF8X9RFV59oftUMGSuiVguQdW7LCS
 jIcEOWNVl4Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="415926264"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 30 May 2021 12:22:50 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] perf scripting python: Simplify perf-trace-context module functions
Date:   Sun, 30 May 2021 22:22:57 +0300
Message-Id: <20210530192308.7382-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210530192308.7382-1-adrian.hunter@intel.com>
References: <20210530192308.7382-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify perf-trace-context module functions by factoring out some
common code.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/Perf-Trace-Util/Context.c  | 39 ++++++++-----------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index fdf692d1e8f3..7cef02d75bc7 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -20,51 +20,46 @@ PyMODINIT_FUNC initperf_trace_context(void);
 PyMODINIT_FUNC PyInit_perf_trace_context(void);
 #endif
 
-static PyObject *perf_trace_context_common_pc(PyObject *obj, PyObject *args)
+static struct scripting_context *get_scripting_context(PyObject *args)
 {
-	struct scripting_context *scripting_context;
 	PyObject *context;
-	int retval;
 
 	if (!PyArg_ParseTuple(args, "O", &context))
 		return NULL;
 
-	scripting_context = _PyCapsule_GetPointer(context, NULL);
-	retval = common_pc(scripting_context);
+	return _PyCapsule_GetPointer(context, NULL);
+}
+
+static PyObject *perf_trace_context_common_pc(PyObject *obj, PyObject *args)
+{
+	struct scripting_context *c = get_scripting_context(args);
+
+	if (!c)
+		return NULL;
 
-	return Py_BuildValue("i", retval);
+	return Py_BuildValue("i", common_pc(c));
 }
 
 static PyObject *perf_trace_context_common_flags(PyObject *obj,
 						 PyObject *args)
 {
-	struct scripting_context *scripting_context;
-	PyObject *context;
-	int retval;
+	struct scripting_context *c = get_scripting_context(args);
 
-	if (!PyArg_ParseTuple(args, "O", &context))
+	if (!c)
 		return NULL;
 
-	scripting_context = _PyCapsule_GetPointer(context, NULL);
-	retval = common_flags(scripting_context);
-
-	return Py_BuildValue("i", retval);
+	return Py_BuildValue("i", common_flags(c));
 }
 
 static PyObject *perf_trace_context_common_lock_depth(PyObject *obj,
 						      PyObject *args)
 {
-	struct scripting_context *scripting_context;
-	PyObject *context;
-	int retval;
+	struct scripting_context *c = get_scripting_context(args);
 
-	if (!PyArg_ParseTuple(args, "O", &context))
+	if (!c)
 		return NULL;
 
-	scripting_context = _PyCapsule_GetPointer(context, NULL);
-	retval = common_lock_depth(scripting_context);
-
-	return Py_BuildValue("i", retval);
+	return Py_BuildValue("i", common_lock_depth(c));
 }
 
 static PyMethodDef ContextMethods[] = {
-- 
2.17.1

