Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB773952A7
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 21:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhE3TY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 15:24:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:21268 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhE3TY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 15:24:28 -0400
IronPort-SDR: LwztQVC99VXZ8S9Zftlkix3W2s196UxpCDBg7SUtaExmQxzTQrsW+Ba2V1B8rfqQJWa9rUtIsw
 HabIPo2gr2dw==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="190362415"
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="190362415"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2021 12:22:50 -0700
IronPort-SDR: 0Li01REAUbq1fbjzzgd7ZGQYpuulDYS9PAl/VgeMXEaVkqRePClSxu579f3FXPvY7upM/zWwDc
 Dmk1mwEI+zNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="415926261"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 30 May 2021 12:22:48 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] perf scripting python: Remove unnecessary 'static'
Date:   Sun, 30 May 2021 22:22:56 +0300
Message-Id: <20210530192308.7382-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210530192308.7382-1-adrian.hunter@intel.com>
References: <20210530192308.7382-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variables are always assigned before use, making the 'static'
storage class unnecessary.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/scripts/python/Perf-Trace-Util/Context.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index 0b7096847991..fdf692d1e8f3 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -22,7 +22,7 @@ PyMODINIT_FUNC PyInit_perf_trace_context(void);
 
 static PyObject *perf_trace_context_common_pc(PyObject *obj, PyObject *args)
 {
-	static struct scripting_context *scripting_context;
+	struct scripting_context *scripting_context;
 	PyObject *context;
 	int retval;
 
@@ -38,7 +38,7 @@ static PyObject *perf_trace_context_common_pc(PyObject *obj, PyObject *args)
 static PyObject *perf_trace_context_common_flags(PyObject *obj,
 						 PyObject *args)
 {
-	static struct scripting_context *scripting_context;
+	struct scripting_context *scripting_context;
 	PyObject *context;
 	int retval;
 
@@ -54,7 +54,7 @@ static PyObject *perf_trace_context_common_flags(PyObject *obj,
 static PyObject *perf_trace_context_common_lock_depth(PyObject *obj,
 						      PyObject *args)
 {
-	static struct scripting_context *scripting_context;
+	struct scripting_context *scripting_context;
 	PyObject *context;
 	int retval;
 
-- 
2.17.1

