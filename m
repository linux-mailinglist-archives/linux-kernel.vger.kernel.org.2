Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9783952B4
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 21:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhE3TZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 15:25:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:21290 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230030AbhE3TYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 15:24:52 -0400
IronPort-SDR: ex/SGkYiWF2iFAlgW54oB+kslbRNq3qAFSOSioIjp0SifSnqOmMmVjYLlwnIyEbb4F12e6A9pj
 aGY9QUMfWLNw==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="190362472"
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="190362472"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2021 12:23:12 -0700
IronPort-SDR: CcAb877m53YihV6/4tH75J6GqDnGXW+0ZmFLYumXeynB5nrPgeo/LK114ZTNcmDwgOKRQcBR9E
 ogTIhIC/0y/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="415926339"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 30 May 2021 12:23:11 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] perf scripting python: intel-pt-events.py: Add --insn-trace and --src-trace
Date:   Sun, 30 May 2021 22:23:08 +0300
Message-Id: <20210530192308.7382-14-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210530192308.7382-1-adrian.hunter@intel.com>
References: <20210530192308.7382-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an instruction trace and a source trace to the intel-pt-events.py
script.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt   |   6 +-
 tools/perf/scripts/python/intel-pt-events.py | 176 +++++++++++++++++--
 2 files changed, 163 insertions(+), 19 deletions(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index e382dbd4ff0a..184ba62420f0 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -174,7 +174,11 @@ Refer to script export-to-sqlite.py or export-to-postgresql.py for more details,
 and to script exported-sql-viewer.py for an example of using the database.
 
 There is also script intel-pt-events.py which provides an example of how to
-unpack the raw data for power events and PTWRITE.
+unpack the raw data for power events and PTWRITE. The script also displays
+branches, and supports 2 additional modes selected by option:
+
+ --insn-trace - instruction trace
+ --src-trace - source trace
 
 As mentioned above, it is easy to capture too much data.  One way to limit the
 data captured is to use 'snapshot' mode which is explained further below.
diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
index fcfae1de731b..1d3a189a9a54 100644
--- a/tools/perf/scripts/python/intel-pt-events.py
+++ b/tools/perf/scripts/python/intel-pt-events.py
@@ -16,21 +16,30 @@ from __future__ import print_function
 import os
 import sys
 import struct
+import argparse
+
+from libxed import LibXED
+from ctypes import create_string_buffer, addressof
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
 
-# These perf imports are not used at present
-#from perf_trace_context import *
-#from Core import *
+from perf_trace_context import perf_set_itrace_options, \
+	perf_sample_insn, perf_sample_srccode
 
 try:
 	broken_pipe_exception = BrokenPipeError
 except:
 	broken_pipe_exception = IOError
 
-glb_switch_str = None
-glb_switch_printed = True
+glb_switch_str		= None
+glb_switch_printed	= True
+glb_insn		= False
+glb_disassembler	= None
+glb_src			= False
+glb_source_file_name	= None
+glb_line_number		= None
+glb_dso			= None
 
 def get_optional_null(perf_dict, field):
 	if field in perf_dict:
@@ -42,6 +51,11 @@ def get_optional_zero(perf_dict, field):
 		return perf_dict[field]
 	return 0
 
+def get_optional_bytes(perf_dict, field):
+	if field in perf_dict:
+		return perf_dict[field]
+	return bytes()
+
 def get_optional(perf_dict, field):
 	if field in perf_dict:
 		return perf_dict[field]
@@ -53,7 +67,31 @@ def get_offset(perf_dict, field):
 	return ""
 
 def trace_begin():
-	print("Intel PT Branch Trace, Power Events and PTWRITE")
+	ap = argparse.ArgumentParser(usage = "", add_help = False)
+	ap.add_argument("--insn-trace", action='store_true')
+	ap.add_argument("--src-trace", action='store_true')
+	global glb_args
+	global glb_insn
+	global glb_src
+	glb_args = ap.parse_args()
+	if glb_args.insn_trace:
+		print("Intel PT Instruction Trace")
+		itrace = "i0nsepwx"
+		glb_insn = True
+	elif glb_args.src_trace:
+		print("Intel PT Source Trace")
+		itrace = "i0nsepwx"
+		glb_insn = True
+		glb_src = True
+	else:
+		print("Intel PT Branch Trace, Power Events and PTWRITE")
+		itrace = "bepwx"
+	global glb_disassembler
+	try:
+		glb_disassembler = LibXED()
+	except:
+		glb_disassembler = None
+	perf_set_itrace_options(perf_script_context, itrace)
 
 def trace_end():
 	print("End")
@@ -111,11 +149,14 @@ def print_psb(raw_buf):
 	offset = data[1]
 	print("offset: %#x" % (offset), end=' ')
 
-def print_common_start(comm, sample, name):
+def common_start_str(comm, sample):
 	ts = sample["time"]
 	cpu = sample["cpu"]
 	pid = sample["pid"]
 	tid = sample["tid"]
+	return "%16s %5u/%-5u [%03u] %9u.%09u  " % (comm, pid, tid, cpu, ts / 1000000000, ts %1000000000)
+
+def print_common_start(comm, sample, name):
 	flags_disp = get_optional_null(sample, "flags_disp")
 	# Unused fields:
 	# period      = sample["period"]
@@ -123,22 +164,96 @@ def print_common_start(comm, sample, name):
 	# weight      = sample["weight"]
 	# transaction = sample["transaction"]
 	# cpumode     = get_optional_zero(sample, "cpumode")
-	print("%16s %5u/%-5u [%03u] %9u.%09u  %7s  %19s" %
-		(comm, pid, tid, cpu, ts / 1000000000, ts %1000000000, name, flags_disp),
-		end=' ')
+	print(common_start_str(comm, sample) + "%7s  %19s" % (name, flags_disp), end=' ')
+
+def print_instructions_start(comm, sample):
+	if "x" in get_optional_null(sample, "flags"):
+		print(common_start_str(comm, sample) + "x", end=' ')
+	else:
+		print(common_start_str(comm, sample), end='  ')
+
+def disassem(insn, ip):
+	inst = glb_disassembler.Instruction()
+	glb_disassembler.SetMode(inst, 0) # Assume 64-bit
+	buf = create_string_buffer(64)
+	buf.value = insn
+	return glb_disassembler.DisassembleOne(inst, addressof(buf), len(insn), ip)
 
 def print_common_ip(param_dict, sample, symbol, dso):
 	ip   = sample["ip"]
 	offs = get_offset(param_dict, "symoff")
-	print("%16x %s%s (%s)" % (ip, symbol, offs, dso), end=' ')
+	if "cyc_cnt" in sample:
+		cyc_cnt = sample["cyc_cnt"]
+		insn_cnt = get_optional_zero(sample, "insn_cnt")
+		ipc_str = "  IPC: %#.2f (%u/%u)" % (insn_cnt / cyc_cnt, insn_cnt, cyc_cnt)
+	else:
+		ipc_str = ""
+	if glb_insn and glb_disassembler is not None:
+		insn = perf_sample_insn(perf_script_context)
+		if insn and len(insn):
+			cnt, text = disassem(insn, ip)
+			byte_str = ("%x" % ip).rjust(16)
+			if sys.version_info.major >= 3:
+				for k in range(cnt):
+					byte_str += " %02x" % insn[k]
+			else:
+				for k in xrange(cnt):
+					byte_str += " %02x" % ord(insn[k])
+			print("%-40s  %-30s" % (byte_str, text), end=' ')
+		print("%s%s (%s)" % (symbol, offs, dso), end=' ')
+	else:
+		print("%16x %s%s (%s)" % (ip, symbol, offs, dso), end=' ')
 	if "addr_correlates_sym" in sample:
 		addr   = sample["addr"]
 		dso    = get_optional(sample, "addr_dso")
 		symbol = get_optional(sample, "addr_symbol")
 		offs   = get_offset(sample, "addr_symoff")
-		print("=> %x %s%s (%s)" % (addr, symbol, offs, dso))
+		print("=> %x %s%s (%s)%s" % (addr, symbol, offs, dso, ipc_str))
+	else:
+		print(ipc_str)
+
+def print_srccode(comm, param_dict, sample, symbol, dso, with_insn):
+	ip = sample["ip"]
+	if symbol == "[unknown]":
+		start_str = common_start_str(comm, sample) + ("%x" % ip).rjust(16).ljust(40)
 	else:
-		print()
+		offs = get_offset(param_dict, "symoff")
+		start_str = common_start_str(comm, sample) + (symbol + offs).ljust(40)
+
+	if with_insn and glb_insn and glb_disassembler is not None:
+		insn = perf_sample_insn(perf_script_context)
+		if insn and len(insn):
+			cnt, text = disassem(insn, ip)
+		start_str += text.ljust(30)
+
+	global glb_source_file_name
+	global glb_line_number
+	global glb_dso
+
+	source_file_name, line_number, source_line = perf_sample_srccode(perf_script_context)
+	if source_file_name:
+		if glb_line_number == line_number and glb_source_file_name == source_file_name:
+			src_str = ""
+		else:
+			if len(source_file_name) > 40:
+				src_file = ("..." + source_file_name[-37:]) + " "
+			else:
+				src_file = source_file_name.ljust(41)
+			if source_line is None:
+				src_str = src_file + str(line_number).rjust(4) + " <source not found>"
+			else:
+				src_str = src_file + str(line_number).rjust(4) + " " + source_line
+		glb_dso = None
+	elif dso == glb_dso:
+		src_str = ""
+	else:
+		src_str = dso
+		glb_dso = dso
+
+	glb_line_number = line_number
+	glb_source_file_name = source_file_name
+
+	print(start_str, src_str)
 
 def do_process_event(param_dict):
 	global glb_switch_printed
@@ -159,24 +274,49 @@ def do_process_event(param_dict):
 	dso    = get_optional(param_dict, "dso")
 	symbol = get_optional(param_dict, "symbol")
 
-	print_common_start(comm, sample, name)
-
-	if name == "ptwrite":
+	if name[0:12] == "instructions":
+		if glb_src:
+			print_srccode(comm, param_dict, sample, symbol, dso, True)
+		else:
+			print_instructions_start(comm, sample)
+			print_common_ip(param_dict, sample, symbol, dso)
+	elif name[0:8] == "branches":
+		if glb_src:
+			print_srccode(comm, param_dict, sample, symbol, dso, False)
+		else:
+			print_common_start(comm, sample, name)
+			print_common_ip(param_dict, sample, symbol, dso)
+	elif name == "ptwrite":
+		print_common_start(comm, sample, name)
 		print_ptwrite(raw_buf)
+		print_common_ip(param_dict, sample, symbol, dso)
 	elif name == "cbr":
+		print_common_start(comm, sample, name)
 		print_cbr(raw_buf)
+		print_common_ip(param_dict, sample, symbol, dso)
 	elif name == "mwait":
+		print_common_start(comm, sample, name)
 		print_mwait(raw_buf)
+		print_common_ip(param_dict, sample, symbol, dso)
 	elif name == "pwre":
+		print_common_start(comm, sample, name)
 		print_pwre(raw_buf)
+		print_common_ip(param_dict, sample, symbol, dso)
 	elif name == "exstop":
+		print_common_start(comm, sample, name)
 		print_exstop(raw_buf)
+		print_common_ip(param_dict, sample, symbol, dso)
 	elif name == "pwrx":
+		print_common_start(comm, sample, name)
 		print_pwrx(raw_buf)
+		print_common_ip(param_dict, sample, symbol, dso)
 	elif name == "psb":
+		print_common_start(comm, sample, name)
 		print_psb(raw_buf)
-
-	print_common_ip(param_dict, sample, symbol, dso)
+		print_common_ip(param_dict, sample, symbol, dso)
+	else:
+		print_common_start(comm, sample, name)
+		print_common_ip(param_dict, sample, symbol, dso)
 
 def process_event(param_dict):
 	try:
-- 
2.17.1

