Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D213952B3
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 21:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhE3TZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 15:25:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:21286 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230016AbhE3TYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 15:24:51 -0400
IronPort-SDR: xzNgrbtk5e/uKLHJ6JliG/1PkggV2tVhspDcmWP5pOOmiA4SI9nGKzwsVmvu5oqhVtYqOFpBUO
 s5CYU+7gX9Pg==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="190362470"
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="190362470"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2021 12:23:10 -0700
IronPort-SDR: 3zf/RCa2OPfMfeec1xBr+BcoCZXoIPOyt53CmoYz+0A8SwpRx10WJVUs9LSw7JHUem/pWoFM8m
 2R1w713DltHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="415926329"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 30 May 2021 12:23:09 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] perf scripting python: exported-sql-viewer.py: Factor out libxed.py
Date:   Sun, 30 May 2021 22:23:07 +0300
Message-Id: <20210530192308.7382-13-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210530192308.7382-1-adrian.hunter@intel.com>
References: <20210530192308.7382-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out libxed.py so it can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/exported-sql-viewer.py     |  89 +--------------
 tools/perf/scripts/python/libxed.py           | 107 ++++++++++++++++++
 2 files changed, 108 insertions(+), 88 deletions(-)
 create mode 100644 tools/perf/scripts/python/libxed.py

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 711d4f9f5645..13f2d8a81610 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -113,6 +113,7 @@ import os
 import random
 import copy
 import math
+from libxed import LibXED
 
 pyside_version_1 = True
 if not "--pyside-version-1" in sys.argv:
@@ -4747,94 +4748,6 @@ class MainWindow(QMainWindow):
 		dialog = AboutDialog(self.glb, self)
 		dialog.exec_()
 
-# XED Disassembler
-
-class xed_state_t(Structure):
-
-	_fields_ = [
-		("mode", c_int),
-		("width", c_int)
-	]
-
-class XEDInstruction():
-
-	def __init__(self, libxed):
-		# Current xed_decoded_inst_t structure is 192 bytes. Use 512 to allow for future expansion
-		xedd_t = c_byte * 512
-		self.xedd = xedd_t()
-		self.xedp = addressof(self.xedd)
-		libxed.xed_decoded_inst_zero(self.xedp)
-		self.state = xed_state_t()
-		self.statep = addressof(self.state)
-		# Buffer for disassembled instruction text
-		self.buffer = create_string_buffer(256)
-		self.bufferp = addressof(self.buffer)
-
-class LibXED():
-
-	def __init__(self):
-		try:
-			self.libxed = CDLL("libxed.so")
-		except:
-			self.libxed = None
-		if not self.libxed:
-			self.libxed = CDLL("/usr/local/lib/libxed.so")
-
-		self.xed_tables_init = self.libxed.xed_tables_init
-		self.xed_tables_init.restype = None
-		self.xed_tables_init.argtypes = []
-
-		self.xed_decoded_inst_zero = self.libxed.xed_decoded_inst_zero
-		self.xed_decoded_inst_zero.restype = None
-		self.xed_decoded_inst_zero.argtypes = [ c_void_p ]
-
-		self.xed_operand_values_set_mode = self.libxed.xed_operand_values_set_mode
-		self.xed_operand_values_set_mode.restype = None
-		self.xed_operand_values_set_mode.argtypes = [ c_void_p, c_void_p ]
-
-		self.xed_decoded_inst_zero_keep_mode = self.libxed.xed_decoded_inst_zero_keep_mode
-		self.xed_decoded_inst_zero_keep_mode.restype = None
-		self.xed_decoded_inst_zero_keep_mode.argtypes = [ c_void_p ]
-
-		self.xed_decode = self.libxed.xed_decode
-		self.xed_decode.restype = c_int
-		self.xed_decode.argtypes = [ c_void_p, c_void_p, c_uint ]
-
-		self.xed_format_context = self.libxed.xed_format_context
-		self.xed_format_context.restype = c_uint
-		self.xed_format_context.argtypes = [ c_int, c_void_p, c_void_p, c_int, c_ulonglong, c_void_p, c_void_p ]
-
-		self.xed_tables_init()
-
-	def Instruction(self):
-		return XEDInstruction(self)
-
-	def SetMode(self, inst, mode):
-		if mode:
-			inst.state.mode = 4 # 32-bit
-			inst.state.width = 4 # 4 bytes
-		else:
-			inst.state.mode = 1 # 64-bit
-			inst.state.width = 8 # 8 bytes
-		self.xed_operand_values_set_mode(inst.xedp, inst.statep)
-
-	def DisassembleOne(self, inst, bytes_ptr, bytes_cnt, ip):
-		self.xed_decoded_inst_zero_keep_mode(inst.xedp)
-		err = self.xed_decode(inst.xedp, bytes_ptr, bytes_cnt)
-		if err:
-			return 0, ""
-		# Use AT&T mode (2), alternative is Intel (3)
-		ok = self.xed_format_context(2, inst.xedp, inst.bufferp, sizeof(inst.buffer), ip, 0, 0)
-		if not ok:
-			return 0, ""
-		if sys.version_info[0] == 2:
-			result = inst.buffer.value
-		else:
-			result = inst.buffer.value.decode()
-		# Return instruction length and the disassembled instruction text
-		# For now, assume the length is in byte 166
-		return inst.xedd[166], result
-
 def TryOpen(file_name):
 	try:
 		return open(file_name, "rb")
diff --git a/tools/perf/scripts/python/libxed.py b/tools/perf/scripts/python/libxed.py
new file mode 100644
index 000000000000..2c70a5a7eb9c
--- /dev/null
+++ b/tools/perf/scripts/python/libxed.py
@@ -0,0 +1,107 @@
+#!/usr/bin/env python
+# SPDX-License-Identifier: GPL-2.0
+# libxed.py: Python wrapper for libxed.so
+# Copyright (c) 2014-2021, Intel Corporation.
+
+# To use Intel XED, libxed.so must be present. To build and install
+# libxed.so:
+#            git clone https://github.com/intelxed/mbuild.git mbuild
+#            git clone https://github.com/intelxed/xed
+#            cd xed
+#            ./mfile.py --share
+#            sudo ./mfile.py --prefix=/usr/local install
+#            sudo ldconfig
+#
+
+import sys
+
+from ctypes import CDLL, Structure, create_string_buffer, addressof, sizeof, \
+		   c_void_p, c_bool, c_byte, c_char, c_int, c_uint, c_longlong, c_ulonglong
+
+# XED Disassembler
+
+class xed_state_t(Structure):
+
+	_fields_ = [
+		("mode", c_int),
+		("width", c_int)
+	]
+
+class XEDInstruction():
+
+	def __init__(self, libxed):
+		# Current xed_decoded_inst_t structure is 192 bytes. Use 512 to allow for future expansion
+		xedd_t = c_byte * 512
+		self.xedd = xedd_t()
+		self.xedp = addressof(self.xedd)
+		libxed.xed_decoded_inst_zero(self.xedp)
+		self.state = xed_state_t()
+		self.statep = addressof(self.state)
+		# Buffer for disassembled instruction text
+		self.buffer = create_string_buffer(256)
+		self.bufferp = addressof(self.buffer)
+
+class LibXED():
+
+	def __init__(self):
+		try:
+			self.libxed = CDLL("libxed.so")
+		except:
+			self.libxed = None
+		if not self.libxed:
+			self.libxed = CDLL("/usr/local/lib/libxed.so")
+
+		self.xed_tables_init = self.libxed.xed_tables_init
+		self.xed_tables_init.restype = None
+		self.xed_tables_init.argtypes = []
+
+		self.xed_decoded_inst_zero = self.libxed.xed_decoded_inst_zero
+		self.xed_decoded_inst_zero.restype = None
+		self.xed_decoded_inst_zero.argtypes = [ c_void_p ]
+
+		self.xed_operand_values_set_mode = self.libxed.xed_operand_values_set_mode
+		self.xed_operand_values_set_mode.restype = None
+		self.xed_operand_values_set_mode.argtypes = [ c_void_p, c_void_p ]
+
+		self.xed_decoded_inst_zero_keep_mode = self.libxed.xed_decoded_inst_zero_keep_mode
+		self.xed_decoded_inst_zero_keep_mode.restype = None
+		self.xed_decoded_inst_zero_keep_mode.argtypes = [ c_void_p ]
+
+		self.xed_decode = self.libxed.xed_decode
+		self.xed_decode.restype = c_int
+		self.xed_decode.argtypes = [ c_void_p, c_void_p, c_uint ]
+
+		self.xed_format_context = self.libxed.xed_format_context
+		self.xed_format_context.restype = c_uint
+		self.xed_format_context.argtypes = [ c_int, c_void_p, c_void_p, c_int, c_ulonglong, c_void_p, c_void_p ]
+
+		self.xed_tables_init()
+
+	def Instruction(self):
+		return XEDInstruction(self)
+
+	def SetMode(self, inst, mode):
+		if mode:
+			inst.state.mode = 4 # 32-bit
+			inst.state.width = 4 # 4 bytes
+		else:
+			inst.state.mode = 1 # 64-bit
+			inst.state.width = 8 # 8 bytes
+		self.xed_operand_values_set_mode(inst.xedp, inst.statep)
+
+	def DisassembleOne(self, inst, bytes_ptr, bytes_cnt, ip):
+		self.xed_decoded_inst_zero_keep_mode(inst.xedp)
+		err = self.xed_decode(inst.xedp, bytes_ptr, bytes_cnt)
+		if err:
+			return 0, ""
+		# Use AT&T mode (2), alternative is Intel (3)
+		ok = self.xed_format_context(2, inst.xedp, inst.bufferp, sizeof(inst.buffer), ip, 0, 0)
+		if not ok:
+			return 0, ""
+		if sys.version_info[0] == 2:
+			result = inst.buffer.value
+		else:
+			result = inst.buffer.value.decode()
+		# Return instruction length and the disassembled instruction text
+		# For now, assume the length is in byte 166
+		return inst.xedd[166], result
-- 
2.17.1

