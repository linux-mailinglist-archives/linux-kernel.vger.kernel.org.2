Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9139A38FE36
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbhEYJw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:52:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:18661 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232807AbhEYJwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:52:40 -0400
IronPort-SDR: jSEkNKTp+OIrWBZo92AgDgOH0wH4Wv8Zb0T6Mu2dyHyikT7gkiJUvQWZCQ4ndaCuopH2VwsIZF
 k8PCf914oEGQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="189531617"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="189531617"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 02:51:08 -0700
IronPort-SDR: 54aRHRYWHN9zaEwf0W4gA8wO02TibKdpdOW9HkrM3eU/xnERraDD0Ti7A9Md3tNPFb7Uu+k84M
 PkJFgTJWMJEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="479224589"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga002.fm.intel.com with ESMTP; 25 May 2021 02:51:06 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] perf scripts python: intel-pt-events.py: Add branches to script
Date:   Tue, 25 May 2021 12:51:12 +0300
Message-Id: <20210525095112.1399-11-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210525095112.1399-1-adrian.hunter@intel.com>
References: <20210525095112.1399-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As an example, add branch information to intel-pt-events.py script.
This shows how a simple python script can be used to customize
perf script output for Intel PT branch traces or power event traces.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/bin/intel-pt-events-record |   4 +-
 .../scripts/python/bin/intel-pt-events-report |   4 +-
 tools/perf/scripts/python/intel-pt-events.py  | 143 ++++++++++++++----
 3 files changed, 116 insertions(+), 35 deletions(-)

diff --git a/tools/perf/scripts/python/bin/intel-pt-events-record b/tools/perf/scripts/python/bin/intel-pt-events-record
index 10fe2b6977d4..6b9877cfe23e 100644
--- a/tools/perf/scripts/python/bin/intel-pt-events-record
+++ b/tools/perf/scripts/python/bin/intel-pt-events-record
@@ -1,8 +1,8 @@
 #!/bin/bash
 
 #
-# print Intel PT Power Events and PTWRITE. The intel_pt PMU event needs
-# to be specified with appropriate config terms.
+# print Intel PT Events including Power Events and PTWRITE. The intel_pt PMU
+# event needs to be specified with appropriate config terms.
 #
 if ! echo "$@" | grep -q intel_pt ; then
 	echo "Options must include the Intel PT event e.g. -e intel_pt/pwr_evt,ptw/"
diff --git a/tools/perf/scripts/python/bin/intel-pt-events-report b/tools/perf/scripts/python/bin/intel-pt-events-report
index 9a9c92fcd026..beeac3fde9db 100644
--- a/tools/perf/scripts/python/bin/intel-pt-events-report
+++ b/tools/perf/scripts/python/bin/intel-pt-events-report
@@ -1,3 +1,3 @@
 #!/bin/bash
-# description: print Intel PT Power Events and PTWRITE
-perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/intel-pt-events.py
\ No newline at end of file
+# description: print Intel PT Events including Power Events and PTWRITE
+perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/intel-pt-events.py
diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
index a73847c8f548..fcfae1de731b 100644
--- a/tools/perf/scripts/python/intel-pt-events.py
+++ b/tools/perf/scripts/python/intel-pt-events.py
@@ -1,5 +1,6 @@
-# intel-pt-events.py: Print Intel PT Power Events and PTWRITE
-# Copyright (c) 2017, Intel Corporation.
+# SPDX-License-Identifier: GPL-2.0
+# intel-pt-events.py: Print Intel PT Events including Power Events and PTWRITE
+# Copyright (c) 2017-2021, Intel Corporation.
 #
 # This program is free software; you can redistribute it and/or modify it
 # under the terms and conditions of the GNU General Public License,
@@ -23,8 +24,36 @@ sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 #from perf_trace_context import *
 #from Core import *
 
+try:
+	broken_pipe_exception = BrokenPipeError
+except:
+	broken_pipe_exception = IOError
+
+glb_switch_str = None
+glb_switch_printed = True
+
+def get_optional_null(perf_dict, field):
+	if field in perf_dict:
+		return perf_dict[field]
+	return ""
+
+def get_optional_zero(perf_dict, field):
+	if field in perf_dict:
+		return perf_dict[field]
+	return 0
+
+def get_optional(perf_dict, field):
+	if field in perf_dict:
+		return perf_dict[field]
+	return "[unknown]"
+
+def get_offset(perf_dict, field):
+	if field in perf_dict:
+		return "+%#x" % perf_dict[field]
+	return ""
+
 def trace_begin():
-	print("Intel PT Power Events and PTWRITE")
+	print("Intel PT Branch Trace, Power Events and PTWRITE")
 
 def trace_end():
 	print("End")
@@ -77,58 +106,110 @@ def print_pwrx(raw_buf):
 	print("deepest cstate: %u last cstate: %u wake reason: %#x" %
 		(deepest_cstate, last_cstate, wake_reason), end=' ')
 
+def print_psb(raw_buf):
+	data = struct.unpack_from("<IQ", raw_buf)
+	offset = data[1]
+	print("offset: %#x" % (offset), end=' ')
+
 def print_common_start(comm, sample, name):
 	ts = sample["time"]
 	cpu = sample["cpu"]
 	pid = sample["pid"]
 	tid = sample["tid"]
-	print("%16s %5u/%-5u [%03u] %9u.%09u %7s:" %
-		(comm, pid, tid, cpu, ts / 1000000000, ts %1000000000, name),
+	flags_disp = get_optional_null(sample, "flags_disp")
+	# Unused fields:
+	# period      = sample["period"]
+	# phys_addr   = sample["phys_addr"]
+	# weight      = sample["weight"]
+	# transaction = sample["transaction"]
+	# cpumode     = get_optional_zero(sample, "cpumode")
+	print("%16s %5u/%-5u [%03u] %9u.%09u  %7s  %19s" %
+		(comm, pid, tid, cpu, ts / 1000000000, ts %1000000000, name, flags_disp),
 		end=' ')
 
-def print_common_ip(sample, symbol, dso):
-	ip = sample["ip"]
-	print("%16x %s (%s)" % (ip, symbol, dso))
+def print_common_ip(param_dict, sample, symbol, dso):
+	ip   = sample["ip"]
+	offs = get_offset(param_dict, "symoff")
+	print("%16x %s%s (%s)" % (ip, symbol, offs, dso), end=' ')
+	if "addr_correlates_sym" in sample:
+		addr   = sample["addr"]
+		dso    = get_optional(sample, "addr_dso")
+		symbol = get_optional(sample, "addr_symbol")
+		offs   = get_offset(sample, "addr_symoff")
+		print("=> %x %s%s (%s)" % (addr, symbol, offs, dso))
+	else:
+		print()
 
-def process_event(param_dict):
+def do_process_event(param_dict):
+	global glb_switch_printed
+	if not glb_switch_printed:
+		print(glb_switch_str)
+		glb_switch_printed = True
 	event_attr = param_dict["attr"]
-	sample	 = param_dict["sample"]
-	raw_buf	= param_dict["raw_buf"]
+	sample	   = param_dict["sample"]
+	raw_buf	   = param_dict["raw_buf"]
 	comm	   = param_dict["comm"]
 	name	   = param_dict["ev_name"]
+	# Unused fields:
+	# callchain  = param_dict["callchain"]
+	# brstack    = param_dict["brstack"]
+	# brstacksym = param_dict["brstacksym"]
 
 	# Symbol and dso info are not always resolved
-	if "dso" in param_dict:
-		dso = param_dict["dso"]
-	else:
-		dso = "[unknown]"
+	dso    = get_optional(param_dict, "dso")
+	symbol = get_optional(param_dict, "symbol")
 
-	if "symbol" in param_dict:
-		symbol = param_dict["symbol"]
-	else:
-		symbol = "[unknown]"
+	print_common_start(comm, sample, name)
 
 	if name == "ptwrite":
-		print_common_start(comm, sample, name)
 		print_ptwrite(raw_buf)
-		print_common_ip(sample, symbol, dso)
 	elif name == "cbr":
-		print_common_start(comm, sample, name)
 		print_cbr(raw_buf)
-		print_common_ip(sample, symbol, dso)
 	elif name == "mwait":
-		print_common_start(comm, sample, name)
 		print_mwait(raw_buf)
-		print_common_ip(sample, symbol, dso)
 	elif name == "pwre":
-		print_common_start(comm, sample, name)
 		print_pwre(raw_buf)
-		print_common_ip(sample, symbol, dso)
 	elif name == "exstop":
-		print_common_start(comm, sample, name)
 		print_exstop(raw_buf)
-		print_common_ip(sample, symbol, dso)
 	elif name == "pwrx":
-		print_common_start(comm, sample, name)
 		print_pwrx(raw_buf)
-		print_common_ip(sample, symbol, dso)
+	elif name == "psb":
+		print_psb(raw_buf)
+
+	print_common_ip(param_dict, sample, symbol, dso)
+
+def process_event(param_dict):
+	try:
+		do_process_event(param_dict)
+	except broken_pipe_exception:
+		# Stop python printing broken pipe errors and traceback
+		sys.stdout = open(os.devnull, 'w')
+		sys.exit(1)
+
+def auxtrace_error(typ, code, cpu, pid, tid, ip, ts, msg, cpumode, *x):
+	try:
+		print("%16s %5u/%-5u [%03u] %9u.%09u  error type %u code %u: %s ip 0x%16x" %
+			("Trace error", pid, tid, cpu, ts / 1000000000, ts %1000000000, typ, code, msg, ip))
+	except broken_pipe_exception:
+		# Stop python printing broken pipe errors and traceback
+		sys.stdout = open(os.devnull, 'w')
+		sys.exit(1)
+
+def context_switch(ts, cpu, pid, tid, np_pid, np_tid, machine_pid, out, out_preempt, *x):
+	global glb_switch_printed
+	global glb_switch_str
+	if out:
+		out_str = "Switch out "
+	else:
+		out_str = "Switch In  "
+	if out_preempt:
+		preempt_str = "preempt"
+	else:
+		preempt_str = ""
+	if machine_pid == -1:
+		machine_str = ""
+	else:
+		machine_str = "machine PID %d" % machine_pid
+	glb_switch_str = "%16s %5d/%-5d [%03u] %9u.%09u %5d/%-5d %s %s" % \
+		(out_str, pid, tid, cpu, ts / 1000000000, ts %1000000000, np_pid, np_tid, machine_str, preempt_str)
+	glb_switch_printed = False
-- 
2.17.1

