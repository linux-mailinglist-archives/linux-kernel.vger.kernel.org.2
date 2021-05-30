Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A273952AB
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 21:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhE3TYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 15:24:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:21268 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229905AbhE3TYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 15:24:36 -0400
IronPort-SDR: XXpiHzFE4gbnrgZEwaytNg0wzj41Gmue20Kb2zMYQ7JNiY57QUVqjNKPXe5+7BmiWbSqrVbZ4L
 MdtkQcRheLoQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="190362449"
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="190362449"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2021 12:22:57 -0700
IronPort-SDR: D3bl/3kUPldGfIhNhaMW+TMKltwCv6pddNIRgX7fTDfXnTfNE2ZoFso3nzshEN+4dxSyc17BF8
 HbZKElICrabg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="415926282"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 30 May 2021 12:22:55 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] perf scripting python: Assign perf_script_context
Date:   Sun, 30 May 2021 22:23:00 +0300
Message-Id: <20210530192308.7382-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210530192308.7382-1-adrian.hunter@intel.com>
References: <20210530192308.7382-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scripting_context pointer itself does not change and nor does it need
to. Put it directly into the script as a variable at the start so it does
not have to be passed on each call into the script.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/Perf-Trace-Util/Context.c  |  8 +++++-
 .../scripting-engines/trace-event-python.c    | 28 +++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index 7cef02d75bc7..26a45ae78be4 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -91,6 +91,12 @@ PyMODINIT_FUNC PyInit_perf_trace_context(void)
 		NULL,			/* m_clear */
 		NULL,			/* m_free */
 	};
-	return PyModule_Create(&moduledef);
+	PyObject *mod;
+
+	mod = PyModule_Create(&moduledef);
+	/* Add perf_script_context to the module so it can be imported */
+	PyObject_SetAttrString(mod, "perf_script_context", Py_None);
+
+	return mod;
 }
 #endif
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 02d134b6ba8d..164d2f45028c 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1599,6 +1599,31 @@ static void python_process_stat_interval(u64 tstamp)
 	Py_DECREF(t);
 }
 
+static int perf_script_context_init(void)
+{
+	PyObject *perf_script_context;
+	PyObject *perf_trace_context;
+	PyObject *dict;
+	int ret;
+
+	perf_trace_context = PyImport_AddModule("perf_trace_context");
+	if (!perf_trace_context)
+		return -1;
+	dict = PyModule_GetDict(perf_trace_context);
+	if (!dict)
+		return -1;
+
+	perf_script_context = _PyCapsule_New(scripting_context, NULL, NULL);
+	if (!perf_script_context)
+		return -1;
+
+	ret = PyDict_SetItemString(dict, "perf_script_context", perf_script_context);
+	if (!ret)
+		ret = PyDict_SetItemString(main_dict, "perf_script_context", perf_script_context);
+	Py_DECREF(perf_script_context);
+	return ret;
+}
+
 static int run_start_sub(void)
 {
 	main_module = PyImport_AddModule("__main__");
@@ -1611,6 +1636,9 @@ static int run_start_sub(void)
 		goto error;
 	Py_INCREF(main_dict);
 
+	if (perf_script_context_init())
+		goto error;
+
 	try_call_object("trace_begin", NULL);
 
 	return 0;
-- 
2.17.1

