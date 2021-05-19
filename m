Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E28388D00
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 13:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351082AbhESLjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 07:39:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242900AbhESLj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 07:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621424288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u0COqOfeHoUx0p+KcfxKXbKnjhR6mwLvwfEHtpXQ6zY=;
        b=cbPM9qo/6ZI5wdajxlahOb3JzHtC/Ys5hNdgz+8l9Uk2P6MZrDPPd6dld9VGOa3t6Z4Xwa
        vngwGuolgVyp2BMW1ZsTgvLIPJlWYkJ0tbDNCuogotsWKNxCoEyAu+d1qHGh48h+YKxyh/
        uOuHPRg9KBFnC+jvGLWv/TWkJTkRi8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-0Q-vryMfO0mCSocYdoI0PQ-1; Wed, 19 May 2021 07:38:05 -0400
X-MC-Unique: 0Q-vryMfO0mCSocYdoI0PQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 700F4801106;
        Wed, 19 May 2021 11:38:03 +0000 (UTC)
Received: from x1.com (ovpn-112-250.rdu2.redhat.com [10.10.112.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BA39614F5;
        Wed, 19 May 2021 11:37:58 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Kate Carcia <kcarcia@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Gabriele Paoloni <gabriele.paoloni@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>, linux-doc@vger.kernel.org
Subject: [RFC PATCH 07/16] tools/rv: Add dot2k
Date:   Wed, 19 May 2021 13:36:28 +0200
Message-Id: <e569772b0324d425619f10b2dab3c8dde2fc68b7.1621414942.git.bristot@redhat.com>
In-Reply-To: <cover.1621414942.git.bristot@redhat.com>
References: <cover.1621414942.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

transform .dot file into kernel rv monitor

usage: dot2k [-h] -d DOT_FILE -t MONITOR_TYPE [-n MODEL_NAME] [-D DESCRIPTION]

optional arguments:
  -h, --help            show this help message and exit
  -d DOT_FILE, --dot DOT_FILE
  -t MONITOR_TYPE, --monitor_type MONITOR_TYPE
  -n MODEL_NAME, --model_name MODEL_NAME
  -D DESCRIPTION, --description DESCRIPTION

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Gabriele Paoloni <gabriele.paoloni@intel.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 tools/tracing/rv/dot2/Makefile                |   5 +
 tools/tracing/rv/dot2/dot2k                   |  49 +++++
 tools/tracing/rv/dot2/dot2k.py                | 184 ++++++++++++++++++
 .../rv/dot2/dot2k_templates/main_global.c     |  96 +++++++++
 .../rv/dot2/dot2k_templates/main_global.h     |  64 ++++++
 .../rv/dot2/dot2k_templates/main_per_cpu.c    |  96 +++++++++
 .../rv/dot2/dot2k_templates/main_per_cpu.h    |  64 ++++++
 .../rv/dot2/dot2k_templates/main_per_task.c   |  96 +++++++++
 .../rv/dot2/dot2k_templates/main_per_task.h   |  70 +++++++
 9 files changed, 724 insertions(+)
 create mode 100644 tools/tracing/rv/dot2/dot2k
 create mode 100644 tools/tracing/rv/dot2/dot2k.py
 create mode 100644 tools/tracing/rv/dot2/dot2k_templates/main_global.c
 create mode 100644 tools/tracing/rv/dot2/dot2k_templates/main_global.h
 create mode 100644 tools/tracing/rv/dot2/dot2k_templates/main_per_cpu.c
 create mode 100644 tools/tracing/rv/dot2/dot2k_templates/main_per_cpu.h
 create mode 100644 tools/tracing/rv/dot2/dot2k_templates/main_per_task.c
 create mode 100644 tools/tracing/rv/dot2/dot2k_templates/main_per_task.h

diff --git a/tools/tracing/rv/dot2/Makefile b/tools/tracing/rv/dot2/Makefile
index 9dd59ec8a733..fcec4bf2bb11 100644
--- a/tools/tracing/rv/dot2/Makefile
+++ b/tools/tracing/rv/dot2/Makefile
@@ -19,3 +19,8 @@ install:
 	$(INSTALL) automata.py -D -m 644 $(DESTDIR)$(PYLIB)/dot2/automata.py
 	$(INSTALL) dot2c.py -D -m 644 $(DESTDIR)$(PYLIB)/dot2/dot2c.py
 	$(INSTALL) dot2c -D -m 755 $(DESTDIR)$(bindir)/
+	$(INSTALL) dot2k.py -D -m 644 $(DESTDIR)$(PYLIB)/dot2/dot2k.py
+	$(INSTALL) dot2k -D -m 755 $(DESTDIR)$(bindir)/
+
+	mkdir -p ${miscdir}/
+	cp -rp dot2k_templates $(DESTDIR)$(miscdir)/
diff --git a/tools/tracing/rv/dot2/dot2k b/tools/tracing/rv/dot2/dot2k
new file mode 100644
index 000000000000..5f9f7c2252f5
--- /dev/null
+++ b/tools/tracing/rv/dot2/dot2k
@@ -0,0 +1,49 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# dot2k: transform dot files into a monitor for the Linux kernel.
+#
+# For more information, see:
+#   https://bristot.me/efficient-formal-verification-for-the-linux-kernel/
+#
+# Copyright 2018-2020 Red Hat, Inc.
+#
+# Author:
+#  Daniel Bristot de Oliveira <bristot@redhat.com>
+
+if __name__ == '__main__':
+    from dot2.dot2k import dot2k
+    import argparse
+    import ntpath
+    import os
+    import platform
+    import sys
+    import sys
+    import argparse
+
+    parser = argparse.ArgumentParser(description='transform .dot file into kernel rv monitor')
+    parser.add_argument('-d', "--dot", dest="dot_file", required=True)
+    parser.add_argument('-t', "--monitor_type", dest="monitor_type", required=True)
+    parser.add_argument('-n', "--model_name", dest="model_name", required=False)
+    parser.add_argument("-D", "--description", dest="description", required=False)
+    params = parser.parse_args()
+
+    print("Opening and parsing the dot file %s" % params.dot_file)
+    try:
+        monitor=dot2k(params.dot_file, params.monitor_type)
+    except Exception as e:
+        print('Error: '+ str(e))
+        print("Sorry : :-(")
+        sys.exit(1)
+
+    # easier than using argparse action.
+    if params.model_name != None:
+        print(params.model_name)
+
+    print("Writing the monitor into the directory %s" % monitor.name)
+    monitor.print_files()
+    print("Done, now edit the %s/%s.c to add the instrumentation" % (monitor.name, monitor.name))
+    print("Then, move the monitor folder to the KERNEL_DIR/tools/rv/monitors")
+    print("and add the following line to KERNEL_DIR/tools/rv/Makefile")
+    print("        obj-m += rv/monitors/%s/%s.o" % (monitor.name, monitor.name))
+    print("and we are done!")
diff --git a/tools/tracing/rv/dot2/dot2k.py b/tools/tracing/rv/dot2/dot2k.py
new file mode 100644
index 000000000000..022441d08885
--- /dev/null
+++ b/tools/tracing/rv/dot2/dot2k.py
@@ -0,0 +1,184 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# dot2k: transform dot files into a monitor for the Linux kernel.
+#
+# For more information, see:
+#   https://bristot.me/efficient-formal-verification-for-the-linux-kernel/
+#
+# Copyright 2018-2020 Red Hat, Inc.
+#
+# Author:
+#  Daniel Bristot de Oliveira <bristot@redhat.com>
+
+from dot2.dot2c import Dot2c
+import platform
+import os
+
+class dot2k(Dot2c):
+    monitor_types={ "global" : 1, "per_cpu" : 2, "per_task" : 3 }
+    monitor_templates_dir="dot2k/rv_templates/"
+    monitor_type="per_cpu"
+
+    def __init__(self, file_path, MonitorType):
+        super().__init__(file_path)
+
+        self.monitor_type=self.monitor_types.get(MonitorType)
+        if self.monitor_type == None:
+            raise Exception("Unknown monitor type: %s" % MonitorType)
+
+        self.monitor_type=MonitorType
+        self.__fill_rv_templates_dir()
+        self.main_h = self.__open_file(self.monitor_templates_dir + "main_" + MonitorType + ".h")
+        self.main_c = self.__open_file(self.monitor_templates_dir + "main_" + MonitorType + ".c")
+
+    def __fill_rv_templates_dir(self):
+
+        if os.path.exists(self.monitor_templates_dir) == True:
+            return
+
+        if platform.system() != "Linux":
+            raise Exception("I can only run on Linux.")
+
+        kernel_path="/lib/modules/%s/build/tools/rv/%s" % (platform.release(), self.monitor_templates_dir)
+
+        if os.path.exists(kernel_path) == True:
+            self.monitor_templates_dir=kernel_path
+            return
+
+        if os.path.exists("/usr/share/dot2/dot2k_templates/") == True:
+            self.monitor_templates_dir="/usr/share/dot2/dot2k_templates/"
+            return
+
+        raise Exception("Could not find the template directory, do you have the kernel source installed?")
+
+
+    def __open_file(self, path):
+        try:
+            fd = open(path)
+        except OSError:
+            raise Exception("Cannot open the file: %s" % path)
+
+        content = fd.read()
+
+        return content
+
+    def __buff_to_string(self, buff):
+        string=""
+
+        for line in buff:
+            string=string + line + "\n"
+
+        # cut off the last \n
+        return string[:-1]
+
+    def fill_monitor_h(self):
+        monitor_h = self.monitor_h
+
+        min_type=self.get_minimun_type()
+
+        monitor_h = monitor_h.replace("MIN_TYPE", min_type)
+
+        return monitor_h
+
+    def fill_tracepoint_handlers_skel(self):
+        buff=[]
+        for event in self.events:
+            buff.append("void handle_%s(void *data, /* XXX: fill header */)" % event)
+            buff.append("{")
+            if self.monitor_type == "per_task":
+                buff.append("\tpid_t pid = /* XXX how do I get the pid? */;");
+                buff.append("\tda_handle_event_%s(pid, %s);" % (self.name, event));
+            else:
+                buff.append("\tda_handle_event_%s(%s);" % (self.name, event));
+            buff.append("}")
+            buff.append("")
+        return self.__buff_to_string(buff)
+
+    def fill_tracepoint_hook_helper(self):
+        buff=[]
+        for event in self.events:
+            buff.append("\t{")
+            buff.append("\t\t.probe = handle_%s," % event)
+            buff.append("\t\t.name = /* XXX: tracepoint name here */,")
+            buff.append("\t\t.registered = 0")
+            buff.append("\t},")
+        return self.__buff_to_string(buff)
+
+    def fill_main_c(self):
+        main_c = self.main_c
+        min_type=self.get_minimun_type()
+        nr_events=self.events.__len__()
+        tracepoint_handlers=self.fill_tracepoint_handlers_skel()
+        tracepoint_hook_helpers=self.fill_tracepoint_hook_helper()
+
+        main_c = main_c.replace("MIN_TYPE", min_type)
+        main_c = main_c.replace("MODEL_NAME", self.name)
+        main_c = main_c.replace("NR_EVENTS", str(nr_events))
+        main_c = main_c.replace("TRACEPOINT_HANDLERS_SKEL", tracepoint_handlers)
+        main_c = main_c.replace("TRACEPOINT_HOOK_HELPERS", tracepoint_hook_helpers)
+
+        return main_c
+
+    def fill_main_h(self):
+        main_h = self.main_h
+        main_h = main_h.replace("MIN_TYPE", self.get_minimun_type())
+        main_h = main_h.replace("MODEL_NAME_BIG", self.name.upper())
+        main_h = main_h.replace("MODEL_NAME", self.name)
+
+        return main_h
+
+    def fill_model_h(self):
+        #
+        # Adjust the definition names
+        #
+        self.enum_states_def="states_%s" % self.name
+        self.enum_events_def="events_%s" % self.name
+        self.struct_automaton_def="automaton_%s" % self.name
+        self.var_automaton_def="automaton_%s" % self.name
+
+        buff=self.format_model()
+
+        return self.__buff_to_string(buff)
+
+    def __create_directory(self):
+        try:
+            os.mkdir(self.name)
+        except FileExistsError:
+            return
+        except:
+            print("Fail creating the output dir: %s" % self.name)
+
+    def __create_file(self, file_name, content):
+        path="%s/%s" % (self.name, file_name)
+        try:
+            file = open(path, 'w')
+        except FileExistsError:
+            return
+        except:
+            print("Fail creating file: %s" % path)
+
+        file.write(content)
+
+        file.close()
+
+    def __get_main_name(self):
+        path="%s/%s" % (self.name, "main.c")
+        if os.path.exists(path) == False:
+           return "main.c"
+        return "__main.c"
+
+    def print_files(self):
+        main_h=self.fill_main_h()
+        main_c=self.fill_main_c()
+        model_h=self.fill_model_h()
+
+        self.__create_directory()
+
+        path="%s.h" % self.name
+        self.__create_file(path, main_h)
+
+        path="%s.c" % self.name
+        self.__create_file(path, main_c)
+
+        self.__create_file("model.h", model_h)
diff --git a/tools/tracing/rv/dot2/dot2k_templates/main_global.c b/tools/tracing/rv/dot2/dot2k_templates/main_global.c
new file mode 100644
index 000000000000..ef7e93368fdd
--- /dev/null
+++ b/tools/tracing/rv/dot2/dot2k_templates/main_global.c
@@ -0,0 +1,96 @@
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <rv/monitor.h>
+
+#define MODULE_NAME "MODEL_NAME"
+
+/*
+ * This is the self-generated part of the monitor. Generally, there is no need
+ * to touch this section.
+ */
+#include "model.h"
+
+/*
+ * Declare the deterministic automata monitor.
+ *
+ * The rv monitor reference is needed for the monitor declaration.
+ */
+struct rv_monitor rv_MODEL_NAME;
+DECLARE_DA_MON_GLOBAL(MODEL_NAME, MIN_TYPE);
+
+#define CREATE_TRACE_POINTS
+#include "MODEL_NAME.h"
+
+/*
+ * This is the instrumentation part of the monitor.
+ *
+ * This is the section where manual work is required. Here the kernel events
+ * are translated into model's event.
+ *
+ */
+
+TRACEPOINT_HANDLERS_SKEL
+#define NR_TP   NR_EVENTS
+static struct tracepoint_hook_helper tracepoints_to_hook[NR_TP] = {
+TRACEPOINT_HOOK_HELPERS
+};
+
+static int start_MODEL_NAME(void)
+{
+	int retval;
+
+	da_monitor_init_MODEL_NAME();
+
+	retval = thh_hook_probes(tracepoints_to_hook, NR_TP);
+	if (retval)
+		goto out_err;
+
+	return 0;
+
+out_err:
+	return -EINVAL;
+}
+
+static void stop_MODEL_NAME(void)
+{
+	rv_MODEL_NAME.enabled = 0;
+	thh_unhook_probes(tracepoints_to_hook, NR_TP);
+	return;
+}
+
+/*
+ * This is the monitor register section.
+ */
+struct rv_monitor rv_MODEL_NAME = {
+	.name = "MODEL_NAME",
+	.description = "auto-generated MODEL_NAME",
+	.start = start_MODEL_NAME,
+	.stop = stop_MODEL_NAME,
+	.reset = da_monitor_reset_all_MODEL_NAME,
+	.enabled = 0,
+};
+
+int register_MODEL_NAME(void)
+{
+	rv_register_monitor(&rv_MODEL_NAME);
+	return 0;
+}
+
+void unregister_MODEL_NAME(void)
+{
+	if (rv_MODEL_NAME.enabled)
+		stop_MODEL_NAME();
+
+	rv_unregister_monitor(&rv_MODEL_NAME);
+}
+
+module_init(register_MODEL_NAME);
+module_exit(unregister_MODEL_NAME);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("dot2k: auto-generated");
+MODULE_DESCRIPTION("MODEL_NAME");
diff --git a/tools/tracing/rv/dot2/dot2k_templates/main_global.h b/tools/tracing/rv/dot2/dot2k_templates/main_global.h
new file mode 100644
index 000000000000..d55cb8b83463
--- /dev/null
+++ b/tools/tracing/rv/dot2/dot2k_templates/main_global.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rv
+
+#if !defined(_MODEL_NAME_BIG_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _MODEL_NAME_BIG_TRACE_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(event_MODEL_NAME,
+
+	TP_PROTO(char state, char event, char next_state, bool safe),
+
+	TP_ARGS(state, event, next_state, safe),
+
+	TP_STRUCT__entry(
+		__field(	char,		state		)
+		__field(	char,		event		)
+		__field(	char,		next_state	)
+		__field(	bool,		safe		)
+	),
+
+	TP_fast_assign(
+		__entry->state = state;
+		__entry->event = event;
+		__entry->next_state = next_state;
+		__entry->safe = safe;
+	),
+
+	TP_printk("%s x %s -> %s %s",
+		model_get_state_name_MODEL_NAME(__entry->state),
+		model_get_event_name_MODEL_NAME(__entry->event),
+		model_get_state_name_MODEL_NAME(__entry->next_state),
+		__entry->safe ? "(safe)" : "")
+);
+
+TRACE_EVENT(error_MODEL_NAME,
+
+	TP_PROTO(char state, char event),
+
+	TP_ARGS(state, event),
+
+	TP_STRUCT__entry(
+		__field(	char,		state		)
+		__field(	char,		event		)
+	),
+
+	TP_fast_assign(
+		__entry->state = state;
+		__entry->event = event;
+	),
+
+	TP_printk("event %s not expected in the state %s",
+		model_get_event_name_MODEL_NAME(__entry->event),
+		model_get_state_name_MODEL_NAME(__entry->state))
+);
+
+#endif /* _MODEL_NAME_BIG_H */
+
+/* This part ust be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE MODEL_NAME
+#include <trace/define_trace.h>
diff --git a/tools/tracing/rv/dot2/dot2k_templates/main_per_cpu.c b/tools/tracing/rv/dot2/dot2k_templates/main_per_cpu.c
new file mode 100644
index 000000000000..05f5b461623d
--- /dev/null
+++ b/tools/tracing/rv/dot2/dot2k_templates/main_per_cpu.c
@@ -0,0 +1,96 @@
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <rv/monitor.h>
+
+#define MODULE_NAME "MODEL_NAME"
+
+/*
+ * This is the self-generated part of the monitor. Generally, there is no need
+ * to touch this section.
+ */
+#include "model.h"
+
+/*
+ * Declare the deterministic automata monitor.
+ *
+ * The rv monitor reference is needed for the monitor declaration.
+ */
+struct rv_monitor rv_MODEL_NAME;
+DECLARE_DA_MON_PER_CPU(MODEL_NAME, MIN_TYPE);
+
+#define CREATE_TRACE_POINTS
+#include "MODEL_NAME.h"
+
+/*
+ * This is the instrumentation part of the monitor.
+ *
+ * This is the section where manual work is required. Here the kernel events
+ * are translated into model's event.
+ *
+ */
+
+TRACEPOINT_HANDLERS_SKEL
+#define NR_TP   NR_EVENTS
+static struct tracepoint_hook_helper tracepoints_to_hook[NR_TP] = {
+TRACEPOINT_HOOK_HELPERS
+};
+
+static int start_MODEL_NAME(void)
+{
+	int retval;
+
+	da_monitor_init_MODEL_NAME();
+
+	retval = thh_hook_probes(tracepoints_to_hook, NR_TP);
+	if (retval)
+		goto out_err;
+
+	return 0;
+
+out_err:
+	return -EINVAL;
+}
+
+static void stop_MODEL_NAME(void)
+{
+	rv_MODEL_NAME.enabled = 0;
+	thh_unhook_probes(tracepoints_to_hook, NR_TP);
+	return;
+}
+
+/*
+ * This is the monitor register section.
+ */
+struct rv_monitor rv_MODEL_NAME = {
+	.name = "MODEL_NAME",
+	.description = "auto-generated MODEL_NAME",
+	.start = start_MODEL_NAME,
+	.stop = stop_MODEL_NAME,
+	.reset = da_monitor_reset_all_MODEL_NAME,
+	.enabled = 0,
+};
+
+int register_MODEL_NAME(void)
+{
+	rv_register_monitor(&rv_MODEL_NAME);
+	return 0;
+}
+
+void unregister_MODEL_NAME(void)
+{
+	if (rv_MODEL_NAME.enabled)
+		stop_MODEL_NAME();
+
+	rv_unregister_monitor(&rv_MODEL_NAME);
+}
+
+module_init(register_MODEL_NAME);
+module_exit(unregister_MODEL_NAME);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("dot2k: auto-generated");
+MODULE_DESCRIPTION("MODEL_NAME");
diff --git a/tools/tracing/rv/dot2/dot2k_templates/main_per_cpu.h b/tools/tracing/rv/dot2/dot2k_templates/main_per_cpu.h
new file mode 100644
index 000000000000..d55cb8b83463
--- /dev/null
+++ b/tools/tracing/rv/dot2/dot2k_templates/main_per_cpu.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rv
+
+#if !defined(_MODEL_NAME_BIG_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _MODEL_NAME_BIG_TRACE_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(event_MODEL_NAME,
+
+	TP_PROTO(char state, char event, char next_state, bool safe),
+
+	TP_ARGS(state, event, next_state, safe),
+
+	TP_STRUCT__entry(
+		__field(	char,		state		)
+		__field(	char,		event		)
+		__field(	char,		next_state	)
+		__field(	bool,		safe		)
+	),
+
+	TP_fast_assign(
+		__entry->state = state;
+		__entry->event = event;
+		__entry->next_state = next_state;
+		__entry->safe = safe;
+	),
+
+	TP_printk("%s x %s -> %s %s",
+		model_get_state_name_MODEL_NAME(__entry->state),
+		model_get_event_name_MODEL_NAME(__entry->event),
+		model_get_state_name_MODEL_NAME(__entry->next_state),
+		__entry->safe ? "(safe)" : "")
+);
+
+TRACE_EVENT(error_MODEL_NAME,
+
+	TP_PROTO(char state, char event),
+
+	TP_ARGS(state, event),
+
+	TP_STRUCT__entry(
+		__field(	char,		state		)
+		__field(	char,		event		)
+	),
+
+	TP_fast_assign(
+		__entry->state = state;
+		__entry->event = event;
+	),
+
+	TP_printk("event %s not expected in the state %s",
+		model_get_event_name_MODEL_NAME(__entry->event),
+		model_get_state_name_MODEL_NAME(__entry->state))
+);
+
+#endif /* _MODEL_NAME_BIG_H */
+
+/* This part ust be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE MODEL_NAME
+#include <trace/define_trace.h>
diff --git a/tools/tracing/rv/dot2/dot2k_templates/main_per_task.c b/tools/tracing/rv/dot2/dot2k_templates/main_per_task.c
new file mode 100644
index 000000000000..8ad817acfa72
--- /dev/null
+++ b/tools/tracing/rv/dot2/dot2k_templates/main_per_task.c
@@ -0,0 +1,96 @@
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <rv/monitor.h>
+
+#define MODULE_NAME "MODEL_NAME"
+
+/*
+ * This is the self-generated part of the monitor. Generally, there is no need
+ * to touch this section.
+ */
+#include "model.h"
+
+/*
+ * Declare the deterministic automata monitor.
+ *
+ * The rv monitor reference is needed for the monitor declaration.
+ */
+struct rv_monitor rv_MODEL_NAME;
+DECLARE_DA_MON_PER_TASK(MODEL_NAME, MIN_TYPE);
+
+#define CREATE_TRACE_POINTS
+#include "MODEL_NAME.h"
+
+/*
+ * This is the instrumentation part of the monitor.
+ *
+ * This is the section where manual work is required. Here the kernel events
+ * are translated into model's event.
+ *
+ */
+
+TRACEPOINT_HANDLERS_SKEL
+#define NR_TP   NR_EVENTS
+static struct tracepoint_hook_helper tracepoints_to_hook[NR_TP] = {
+TRACEPOINT_HOOK_HELPERS
+};
+
+static int start_MODEL_NAME(void)
+{
+	int retval;
+
+	da_monitor_init_MODEL_NAME();
+
+	retval = thh_hook_probes(tracepoints_to_hook, NR_TP);
+	if (retval)
+		goto out_err;
+
+	return 0;
+
+out_err:
+	return -EINVAL;
+}
+
+static void stop_MODEL_NAME(void)
+{
+	rv_MODEL_NAME.enabled = 0;
+	thh_unhook_probes(tracepoints_to_hook, NR_TP);
+	return;
+}
+
+/*
+ * This is the monitor register section.
+ */
+struct rv_monitor rv_MODEL_NAME = {
+	.name = "MODEL_NAME",
+	.description = "auto-generated MODEL_NAME",
+	.start = start_MODEL_NAME,
+	.stop = stop_MODEL_NAME,
+	.reset = da_monitor_reset_all_MODEL_NAME,
+	.enabled = 0,
+};
+
+int register_MODEL_NAME(void)
+{
+	rv_register_monitor(&rv_MODEL_NAME);
+	return 0;
+}
+
+void unregister_MODEL_NAME(void)
+{
+	if (rv_MODEL_NAME.enabled)
+		stop_MODEL_NAME();
+
+	rv_unregister_monitor(&rv_MODEL_NAME);
+}
+
+module_init(register_MODEL_NAME);
+module_exit(unregister_MODEL_NAME);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("dot2k: auto-generated");
+MODULE_DESCRIPTION("MODEL_NAME");
diff --git a/tools/tracing/rv/dot2/dot2k_templates/main_per_task.h b/tools/tracing/rv/dot2/dot2k_templates/main_per_task.h
new file mode 100644
index 000000000000..55fb47265344
--- /dev/null
+++ b/tools/tracing/rv/dot2/dot2k_templates/main_per_task.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rv
+
+#if !defined(_MODEL_NAME_BIG_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _MODEL_NAME_BIG_TRACE_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(event_MODEL_NAME,
+
+	TP_PROTO(pid_t pid, MIN_TYPE state, MIN_TYPE event, MIN_TYPE next_state, bool safe),
+
+	TP_ARGS(pid, state, event, next_state, safe),
+
+	TP_STRUCT__entry(
+		__field(	pid_t,		pid		)
+		__field(	MIN_TYPE,		state		)
+		__field(	MIN_TYPE,		event		)
+		__field(	MIN_TYPE,		next_state	)
+		__field(	bool,		safe		)
+	),
+
+	TP_fast_assign(
+		__entry->pid = pid;
+		__entry->state = state;
+		__entry->event = event;
+		__entry->next_state = next_state;
+		__entry->safe = safe;
+	),
+
+	TP_printk("%d: %s x %s -> %s %s",
+		__entry->pid,
+		model_get_state_name_MODEL_NAME(__entry->state),
+		model_get_event_name_MODEL_NAME(__entry->event),
+		model_get_state_name_MODEL_NAME(__entry->next_state),
+		__entry->safe ? "(safe)" : "")
+);
+
+TRACE_EVENT(error_MODEL_NAME,
+
+	TP_PROTO(pid_t pid, MIN_TYPE state, MIN_TYPE event),
+
+	TP_ARGS(pid, state, event),
+
+	TP_STRUCT__entry(
+		__field(	pid_t,		pid		)
+		__field(	MIN_TYPE,		state		)
+		__field(	MIN_TYPE,		event		)
+	),
+
+	TP_fast_assign(
+		__entry->pid = pid;
+		__entry->state = state;
+		__entry->event = event;
+	),
+
+	TP_printk("%d event %s not expected in the state %s",
+		__entry->pid,
+		model_get_event_name_MODEL_NAME(__entry->event),
+		model_get_state_name_MODEL_NAME(__entry->state))
+);
+
+#endif /* _MODEL_NAME_BIG_H */
+
+/* This part ust be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE MODEL_NAME
+#include <trace/define_trace.h>
-- 
2.26.2

