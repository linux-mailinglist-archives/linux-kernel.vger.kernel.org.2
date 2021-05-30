Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E303952B2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 21:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhE3TZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 15:25:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:21268 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230004AbhE3TYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 15:24:50 -0400
IronPort-SDR: MEqpTDm/JXYaURsnSAFhipO6amwG04SFVTnScJK5ur9CA5m+pj1ATrF4LSl8s0r/90ebLGtKqW
 P/wAr8sDLJ2g==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="190362468"
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="190362468"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2021 12:23:09 -0700
IronPort-SDR: BXGUvhlRJucQAjnekVrCjEHvEGdP15c4ijvFZPVh7XfMDrS7cBtf+9u6AuXJsK/ZtKhJMzhhN6
 woo+YhgwD/bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="415926322"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 30 May 2021 12:23:07 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] perf scripting python: Update documentation for srcline etc
Date:   Sun, 30 May 2021 22:23:06 +0300
Message-Id: <20210530192308.7382-12-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210530192308.7382-1-adrian.hunter@intel.com>
References: <20210530192308.7382-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new fields and functions to the perf-script-python documentation.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../perf/Documentation/perf-script-python.txt | 46 +++++++++++++++++--
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-script-python.txt b/tools/perf/Documentation/perf-script-python.txt
index 0fb9eda3cbca..5e43cfa5ea1e 100644
--- a/tools/perf/Documentation/perf-script-python.txt
+++ b/tools/perf/Documentation/perf-script-python.txt
@@ -550,6 +550,27 @@ def trace_unhandled(event_name, context, event_fields_dict):
     pass
 ----
 
+*process_event*, if defined, is called for any non-tracepoint event
+
+----
+def process_event(param_dict):
+    pass
+----
+
+*context_switch*, if defined, is called for any context switch
+
+----
+def context_switch(ts, cpu, pid, tid, np_pid, np_tid, machine_pid, out, out_preempt, *x):
+    pass
+----
+
+*auxtrace_error*, if defined, is called for any AUX area tracing error
+
+----
+def auxtrace_error(typ, code, cpu, pid, tid, ip, ts, msg, cpumode, *x):
+    pass
+----
+
 The remaining sections provide descriptions of each of the available
 built-in perf script Python modules and their associated functions.
 
@@ -592,12 +613,18 @@ common, but need to be made accessible to user scripts nonetheless.
 perf_trace_context defines a set of functions that can be used to
 access this data in the context of the current event.  Each of these
 functions expects a context variable, which is the same as the
-context variable passed into every event handler as the second
-argument.
+context variable passed into every tracepoint event handler as the second
+argument. For non-tracepoint events, the context variable is also present
+as perf_trace_context.perf_script_context .
 
  common_pc(context) - returns common_preempt count for the current event
  common_flags(context) - returns common_flags for the current event
  common_lock_depth(context) - returns common_lock_depth for the current event
+ perf_sample_insn(context) - returns the machine code instruction
+ perf_set_itrace_options(context, itrace_options) - set --itrace options if they have not been set already
+ perf_sample_srcline(context) - returns source_file_name, line_number
+ perf_sample_srccode(context) - returns source_file_name, line_number, source_line
+
 
 Util.py Module
 ~~~~~~~~~~~~~~
@@ -616,9 +643,20 @@ SUPPORTED FIELDS
 Currently supported fields:
 
 ev_name, comm, pid, tid, cpu, ip, time, period, phys_addr, addr,
-symbol, dso, time_enabled, time_running, values, callchain,
+symbol, symoff, dso, time_enabled, time_running, values, callchain,
 brstack, brstacksym, datasrc, datasrc_decode, iregs, uregs,
-weight, transaction, raw_buf, attr.
+weight, transaction, raw_buf, attr, cpumode.
+
+Fields that may also be present:
+
+ flags - sample flags
+ flags_disp - sample flags display
+ insn_cnt - instruction count for determining instructions-per-cycle (IPC)
+ cyc_cnt - cycle count for determining IPC
+ addr_correlates_sym - addr can correlate to a symbol
+ addr_dso - addr dso
+ addr_symbol - addr symbol
+ addr_symoff - addr symbol offset
 
 Some fields have sub items:
 
-- 
2.17.1

