Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063CA38F20D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 19:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbhEXRMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 13:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbhEXRMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 13:12:30 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FE7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 10:11:02 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id y14so27213209wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 10:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7TLCHShw4BiZ522LdKzoZr3Q03ERlmB/trfI/zc8ujI=;
        b=eA7jwux3CXWIdKgqueBdQ7GbqMwQoKKvi9+NVeol+VI5Eq7ltMvEu9P6f3DrKFBKks
         6Dt7HkcvnS2qzfqQz8QJX92PBiO5nklGiR6SbGKTBvpyztdrdoSmBPAym1+IbmZXM3DR
         utjqbaoZNNpdOCsErpYmGFG+Ije+9PnIo+hwyXvAlLSuh/GNg4PKeFLlgwNjkTIIA6HV
         wHtHfHJpSPtXnflLIgRw8ElpxHjEG1RyT/+vuoY5i3qFqiKgW2OHwDSIrPI0JlllndVk
         jy19sTbIN9sMxB72zpdMe8dfbJCMt58rRNddnUDO+nakeEdI/7nIq8RjqH7h3Vnjf6Ec
         zvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7TLCHShw4BiZ522LdKzoZr3Q03ERlmB/trfI/zc8ujI=;
        b=q4peSjVpBG71UlzBR+rDgut10GC59ip26AwHGQ1j7D65C1x+QykoVZ+7YHeD0J5U0S
         V3SdOc9czPfUjmd1sAMqboRBeuvdZTy7Div3zC4aAXARMFS3dLYtJA/r3Z65EwYUPbhF
         PxnUA5r3iOz5tT+8sKPQKcSz+qmr28AORnUCyZr3DeURgFnPWy7o9CFksIPd4FwFW9Ou
         5PrW57Qc9zVJnhmfna7OmhH8yJ8lANLdfaVEGvkJGmoRGESSaqmwzrjTJwixqkrc+5uH
         8bcJWgOQ1PimGsMZti4YbzvscpVnjxzzQF2XNFOuq5Tiv0bibJtgA9Jjv6//hQMuEvjF
         Lp7g==
X-Gm-Message-State: AOAM5311rm3e/5BSFm0iC/fEcqoUTfv1p53JqOfpl72k7N0NCJEpQmm1
        OIeN+HDWjVha+aEZo0pGj2h0IorjLGLhjcgGbXez3lWP
X-Google-Smtp-Source: ABdhPJy9ptjEi1lNnQ0CnUUS8MHjkcevB8EQFGhbs4xbnMYHEW+MBhbqOPgwls09gAxBRBf+QQYIOQ==
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr23332205wrd.407.1621876260146;
        Mon, 24 May 2021 10:11:00 -0700 (PDT)
Received: from DESKTOP-37V4J6N.localdomain ([212.76.100.13])
        by smtp.gmail.com with ESMTPSA id k9sm7858273wmi.45.2021.05.24.10.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 10:10:59 -0700 (PDT)
From:   Elisha Hollander <just4now666666@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Elisha Hollander <just4now666666@gmail.com>
Subject: [PATCH 1/9] Remove redundant pass statements
Date:   Mon, 24 May 2021 20:11:25 +0300
Message-Id: <20210524171125.1974-1-just4now666666@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 tools/perf/scripts/python/check-perf-trace.py | 1 -
 tools/perf/scripts/python/sctop.py            | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/perf/scripts/python/check-perf-trace.py b/tools/perf/scripts/python/check-perf-trace.py
index d2c22954800d..d8136eb1e08e 100644
--- a/tools/perf/scripts/python/check-perf-trace.py
+++ b/tools/perf/scripts/python/check-perf-trace.py
@@ -22,7 +22,6 @@ unhandled = autodict()
 
 def trace_begin():
 	print("trace_begin")
-	pass
 
 def trace_end():
 	print_unhandled()
diff --git a/tools/perf/scripts/python/sctop.py b/tools/perf/scripts/python/sctop.py
index 6e0278dcb092..e290b9e276f5 100644
--- a/tools/perf/scripts/python/sctop.py
+++ b/tools/perf/scripts/python/sctop.py
@@ -47,7 +47,6 @@ syscalls = autodict()
 
 def trace_begin():
 	thread.start_new_thread(print_syscall_totals, (interval,))
-	pass
 
 def raw_syscalls__sys_enter(event_name, context, common_cpu,
 	common_secs, common_nsecs, common_pid, common_comm,
-- 
2.25.1


From 15048e8da40f7c2c62833270057f7b526465b080 Mon Sep 17 00:00:00 2001
From: Elisha Hollander <just4now666666@gmail.com>
Date: Mon, 24 May 2021 18:05:09 +0300
Subject: [PATCH 2/9] global on module level is not best practice

---
 tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
index e15e20696d17..427ee20d9e4a 100755
--- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
+++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
@@ -63,8 +63,6 @@ C_USEC = 3
 C_SEC = 2
 C_CPU = 1
 
-global sample_num, last_sec_cpu, last_usec_cpu, start_time, testname
-
 # 11 digits covers uptime to 115 days
 getcontext().prec = 11
 
-- 
2.25.1


From 25a459f83d5433884544686d92971dfb9e4ac9bb Mon Sep 17 00:00:00 2001
From: Elisha Hollander <just4now666666@gmail.com>
Date: Mon, 24 May 2021 18:10:17 +0300
Subject: [PATCH 3/9] Remove unnecessary imports

---
 tools/power/pm-graph/bootgraph.py  | 2 --
 tools/power/pm-graph/sleepgraph.py | 1 -
 2 files changed, 3 deletions(-)

diff --git a/tools/power/pm-graph/bootgraph.py b/tools/power/pm-graph/bootgraph.py
index 2823cd3122f7..b6b19416df85 100755
--- a/tools/power/pm-graph/bootgraph.py
+++ b/tools/power/pm-graph/bootgraph.py
@@ -25,9 +25,7 @@
 # ----------------- LIBRARIES --------------------
 
 import sys
-import time
 import os
-import string
 import re
 import platform
 import shutil
diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index ffd50953a024..80bfad9e1eb8 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -53,7 +53,6 @@
 import sys
 import time
 import os
-import string
 import re
 import platform
 import signal
-- 
2.25.1


From 0675ade111aecbf50d8caf0ae526d53f02acd1b7 Mon Sep 17 00:00:00 2001
From: Elisha Hollander <just4now666666@gmail.com>
Date: Mon, 24 May 2021 18:13:55 +0300
Subject: [PATCH 4/9] Use "is" not "==" for None

Using == is not always a good idea when dealing with None's, for example, if you have this class:
`class NotNone: __eq__ = lambda self, other: True`
Then NotNone()==None returns True
But NonNone() is None returns False

And PEP 8 says: "Comparisons to singletons like None should always be done with 'is' or 'is not', NEVER the equality operators."
---
 tools/perf/scripts/python/exported-sql-viewer.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 7daa8bb70a5a..221f36c906da 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -445,7 +445,7 @@ class FindBar():
 		index = self.textbox.currentIndex()
 		data = self.textbox.itemData(index)
 		# Store the pattern in the combo box to keep it with the text value
-		if data == None:
+		if data is None:
 			self.textbox.setItemData(index, pattern)
 		else:
 			self.pattern.setChecked(data)
-- 
2.25.1


From 66c8d540f95498337b0ba35d00f1153a7d146f5e Mon Sep 17 00:00:00 2001
From: Elisha Hollander <just4now666666@gmail.com>
Date: Mon, 24 May 2021 18:28:28 +0300
Subject: [PATCH 5/9] Remove unnecessary imports

---
 scripts/clang-tools/run-clang-tools.py              | 1 -
 scripts/gdb/linux/clk.py                            | 1 -
 scripts/gdb/linux/genpd.py                          | 1 -
 scripts/gdb/linux/modules.py                        | 2 +-
 tools/cgroup/iocost_monitor.py                      | 1 -
 tools/cgroup/memcg_slabinfo.py                      | 2 --
 tools/perf/scripts/python/compaction-times.py       | 1 -
 tools/perf/scripts/python/event_analyzing_sample.py | 1 -
 tools/perf/scripts/python/mem-phys-addr.py          | 1 -
 9 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
index f754415af398..f298c07e948a 100755
--- a/scripts/clang-tools/run-clang-tools.py
+++ b/scripts/clang-tools/run-clang-tools.py
@@ -12,7 +12,6 @@ compile_commands.json.
 import argparse
 import json
 import multiprocessing
-import os
 import subprocess
 import sys
 
diff --git a/scripts/gdb/linux/clk.py b/scripts/gdb/linux/clk.py
index 061aecfa294e..7a7d81539fcd 100644
--- a/scripts/gdb/linux/clk.py
+++ b/scripts/gdb/linux/clk.py
@@ -3,7 +3,6 @@
 # Copyright (c) NXP 2019
 
 import gdb
-import sys
 
 from linux import utils, lists, constants
 
diff --git a/scripts/gdb/linux/genpd.py b/scripts/gdb/linux/genpd.py
index 39cd1abd8559..f0e4ae7b47f4 100644
--- a/scripts/gdb/linux/genpd.py
+++ b/scripts/gdb/linux/genpd.py
@@ -3,7 +3,6 @@
 # Copyright (c) NXP 2019
 
 import gdb
-import sys
 
 from linux.utils import CachedType
 from linux.lists import list_for_each_entry
diff --git a/scripts/gdb/linux/modules.py b/scripts/gdb/linux/modules.py
index 441b23239896..d8e771bb22e7 100644
--- a/scripts/gdb/linux/modules.py
+++ b/scripts/gdb/linux/modules.py
@@ -13,7 +13,7 @@
 
 import gdb
 
-from linux import cpus, utils, lists
+from linux import utils, lists
 
 
 module_type = utils.CachedType("struct module")
diff --git a/tools/cgroup/iocost_monitor.py b/tools/cgroup/iocost_monitor.py
index c4ff907c078b..364625ba4a2f 100644
--- a/tools/cgroup/iocost_monitor.py
+++ b/tools/cgroup/iocost_monitor.py
@@ -13,7 +13,6 @@ import sys
 import re
 import time
 import json
-import math
 
 import drgn
 from drgn import container_of
diff --git a/tools/cgroup/memcg_slabinfo.py b/tools/cgroup/memcg_slabinfo.py
index 1600b17dbb8a..1962f7618ea8 100644
--- a/tools/cgroup/memcg_slabinfo.py
+++ b/tools/cgroup/memcg_slabinfo.py
@@ -9,8 +9,6 @@ import sys
 
 from drgn.helpers.linux import list_for_each_entry, list_empty
 from drgn.helpers.linux import for_each_page
-from drgn.helpers.linux.cpumask import for_each_online_cpu
-from drgn.helpers.linux.percpu import per_cpu_ptr
 from drgn import container_of, FaultError, Object
 
 
diff --git a/tools/perf/scripts/python/compaction-times.py b/tools/perf/scripts/python/compaction-times.py
index 2560a042dc6f..5822b552756d 100644
--- a/tools/perf/scripts/python/compaction-times.py
+++ b/tools/perf/scripts/python/compaction-times.py
@@ -4,7 +4,6 @@
 # testing:
 # 'echo 1 > /proc/sys/vm/compact_memory' to force compaction of all zones
 
-import os
 import sys
 import re
 
diff --git a/tools/perf/scripts/python/event_analyzing_sample.py b/tools/perf/scripts/python/event_analyzing_sample.py
index aa1e2cfa26a6..8d0fbb78900e 100644
--- a/tools/perf/scripts/python/event_analyzing_sample.py
+++ b/tools/perf/scripts/python/event_analyzing_sample.py
@@ -20,7 +20,6 @@ from __future__ import print_function
 import os
 import sys
 import math
-import struct
 import sqlite3
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
diff --git a/tools/perf/scripts/python/mem-phys-addr.py b/tools/perf/scripts/python/mem-phys-addr.py
index 1f332e72b9b0..66b7ee8254c3 100644
--- a/tools/perf/scripts/python/mem-phys-addr.py
+++ b/tools/perf/scripts/python/mem-phys-addr.py
@@ -8,7 +8,6 @@ from __future__ import print_function
 
 import os
 import sys
-import struct
 import re
 import bisect
 import collections
-- 
2.25.1


From 68173551f2e77294de6b74b562dff4a1f1eea68c Mon Sep 17 00:00:00 2001
From: Elisha Hollander <just4now666666@gmail.com>
Date: Mon, 24 May 2021 18:31:44 +0300
Subject: [PATCH 6/9] Use "is" not "==" for None

Using == is not always a good idea when dealing with None's, for example, if you have this class:
`class NotNone: __eq__ = lambda self, other: True`
Then NotNone()==None returns True
But NonNone() is None returns False

And PEP 8 says: "Comparisons to singletons like None should always be done with 'is' or 'is not', NEVER the equality operators."
---
 tools/perf/scripts/python/compaction-times.py | 2 +-
 tools/perf/scripts/python/mem-phys-addr.py    | 2 +-
 tools/perf/scripts/python/net_dropmonitor.py  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/scripts/python/compaction-times.py b/tools/perf/scripts/python/compaction-times.py
index 5822b552756d..83098803144b 100644
--- a/tools/perf/scripts/python/compaction-times.py
+++ b/tools/perf/scripts/python/compaction-times.py
@@ -30,7 +30,7 @@ class comm_filter:
 
 	def filter(self, pid, comm):
 		m = self.re.search(comm)
-		return m == None or m.group() == ""
+		return m is None or m.group() == ""
 
 class pid_filter:
 	def __init__(self, low, high):
diff --git a/tools/perf/scripts/python/mem-phys-addr.py b/tools/perf/scripts/python/mem-phys-addr.py
index 66b7ee8254c3..c6064ed7a231 100644
--- a/tools/perf/scripts/python/mem-phys-addr.py
+++ b/tools/perf/scripts/python/mem-phys-addr.py
@@ -94,6 +94,6 @@ def process_event(param_dict):
 	phys_addr  = sample["phys_addr"]
 
 	global event_name
-	if event_name == None:
+	if event_name is None:
 		event_name = name
 	load_mem_type_cnt[find_memory_type(phys_addr)] += 1
diff --git a/tools/perf/scripts/python/net_dropmonitor.py b/tools/perf/scripts/python/net_dropmonitor.py
index 101059971738..cd9488f11e03 100755
--- a/tools/perf/scripts/python/net_dropmonitor.py
+++ b/tools/perf/scripts/python/net_dropmonitor.py
@@ -55,7 +55,7 @@ def print_drop_table():
 	print("%25s %25s %25s" % ("LOCATION", "OFFSET", "COUNT"))
 	for i in drop_log.keys():
 		(sym, off) = get_sym(i)
-		if sym == None:
+		if sym is None:
 			sym = i
 		print("%25s %25s %25s" % (sym, off, drop_log[i]))
 
-- 
2.25.1


From 58930684651f39421dd504c8667002f69f53bb39 Mon Sep 17 00:00:00 2001
From: Elisha Hollander <just4now666666@gmail.com>
Date: Mon, 24 May 2021 18:36:14 +0300
Subject: [PATCH 7/9] Remove redundant declarations

---
 tools/perf/scripts/python/event_analyzing_sample.py | 2 --
 tools/perf/scripts/python/exported-sql-viewer.py    | 1 -
 2 files changed, 3 deletions(-)

diff --git a/tools/perf/scripts/python/event_analyzing_sample.py b/tools/perf/scripts/python/event_analyzing_sample.py
index 8d0fbb78900e..c58a9878cb69 100644
--- a/tools/perf/scripts/python/event_analyzing_sample.py
+++ b/tools/perf/scripts/python/event_analyzing_sample.py
@@ -70,8 +70,6 @@ def trace_begin():
 # do more analysis with simple database commands.
 #
 def process_event(param_dict):
-        event_attr = param_dict["attr"]
-        sample     = param_dict["sample"]
         raw_buf    = param_dict["raw_buf"]
         comm       = param_dict["comm"]
         name       = param_dict["ev_name"]
diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 221f36c906da..7c37d212c3ab 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1688,7 +1688,6 @@ class SwitchGraphGraphicsItem(QGraphicsItem):
 		self.graph_origin_x = margin + title_width + margin
 		self.graph_origin_y = graph_height + margin
 
-		x_axis_size = 1
 		y_axis_size = 1
 		self.yline = QGraphicsLineItem(0, 0, 0, graph_height, self)
 
-- 
2.25.1


From 769d2f34b437cf6dabb209283de70c86a31aafb2 Mon Sep 17 00:00:00 2001
From: Elisha Hollander <just4now666666@gmail.com>
Date: Mon, 24 May 2021 18:47:11 +0300
Subject: [PATCH 8/9] Add exception specifications for regexes and imports to
 match PEP8

---
 scripts/checkkconfigsymbols.py                    | 2 +-
 tools/perf/scripts/python/compaction-times.py     | 2 +-
 tools/perf/scripts/python/export-to-postgresql.py | 2 +-
 tools/perf/scripts/python/export-to-sqlite.py     | 2 +-
 tools/perf/scripts/python/exported-sql-viewer.py  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/checkkconfigsymbols.py b/scripts/checkkconfigsymbols.py
index 1548f9ce4682..63b7e526fa34 100755
--- a/scripts/checkkconfigsymbols.py
+++ b/scripts/checkkconfigsymbols.py
@@ -107,7 +107,7 @@ def parse_options():
     if args.ignore:
         try:
             re.match(args.ignore, "this/is/just/a/test.c")
-        except:
+        except re.error:
             sys.exit("Please specify a valid Python regex.")
 
     return args
diff --git a/tools/perf/scripts/python/compaction-times.py b/tools/perf/scripts/python/compaction-times.py
index 83098803144b..e89398ddff50 100644
--- a/tools/perf/scripts/python/compaction-times.py
+++ b/tools/perf/scripts/python/compaction-times.py
@@ -302,7 +302,7 @@ if argc >= 1:
 			else:
 				try:
 					comm_re=re.compile(opt)
-				except:
+				except re.error:
 					sys.stderr.write("invalid regex '%s'" % opt)
 					sys.exit(usage)
 				f = comm_filter(comm_re)
diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index d187e46c2683..570c77d92678 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -217,7 +217,7 @@ if not "pyside-version-1" in sys.argv:
 	try:
 		from PySide2.QtSql import *
 		pyside_version_1 = False
-	except:
+	except ImportError:
 		pass
 
 if pyside_version_1:
diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index 8043a7272a56..3d6d90382798 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -74,7 +74,7 @@ if not "pyside-version-1" in sys.argv:
 	try:
 		from PySide2.QtSql import *
 		pyside_version_1 = False
-	except:
+	except ImportError:
 		pass
 
 if pyside_version_1:
diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 7c37d212c3ab..3e8f473e1fd1 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -117,7 +117,7 @@ if not "--pyside-version-1" in sys.argv:
 		from PySide2.QtSql import *
 		from PySide2.QtWidgets import *
 		pyside_version_1 = False
-	except:
+	except ImportError:
 		pass
 
 if pyside_version_1:
-- 
2.25.1


From cb661c61383fc19f553c8babbee852a32b08baf9 Mon Sep 17 00:00:00 2001
From: Elisha Hollander <just4now666666@gmail.com>
Date: Mon, 24 May 2021 18:59:48 +0300
Subject: [PATCH 9/9] Format exception to match PEP8

---
 tools/power/pm-graph/sleepgraph.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index 80bfad9e1eb8..ecdf6d6abaec 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -64,6 +64,7 @@ import gzip
 from threading import Thread
 from subprocess import call, Popen, PIPE
 import base64
+import binascii
 
 def pprint(msg):
 	print(msg)
@@ -890,7 +891,7 @@ class SystemValues:
 				with gzip.open(filename, mode+'t') as fp:
 					test = fp.read(64)
 				isgz = True
-			except:
+			except OSError:
 				isgz = False
 		if isgz:
 			return gzip.open(filename, mode+'t')
@@ -906,7 +907,7 @@ class SystemValues:
 	def b64unzip(self, data):
 		try:
 			out = codecs.decode(base64.b64decode(data), 'zlib').decode()
-		except:
+		except (ValueError, UnicodeDecodeError, binascii.Error):
 			out = data
 		return out
 	def b64zip(self, data):
@@ -1130,7 +1131,7 @@ class SystemValues:
 	def wifiDetails(self, dev):
 		try:
 			info = open('/sys/class/net/%s/device/uevent' % dev, 'r').read().strip()
-		except:
+		except OSError:
 			return dev
 		vals = [dev]
 		for prop in info.split('\n'):
@@ -1140,7 +1141,7 @@ class SystemValues:
 	def checkWifi(self, dev=''):
 		try:
 			w = open('/proc/net/wireless', 'r').read().strip()
-		except:
+		except OSError:
 			return ''
 		for line in reversed(w.split('\n')):
 			m = re.match(' *(?P<dev>.*): (?P<stat>[0-9a-f]*) .*', w.split('\n')[-1])
-- 
2.25.1

