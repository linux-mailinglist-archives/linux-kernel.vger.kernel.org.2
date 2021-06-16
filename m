Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABBE3AA63F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 23:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbhFPVoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 17:44:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232568AbhFPVoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 17:44:04 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53D8160FF4;
        Wed, 16 Jun 2021 21:41:57 +0000 (UTC)
Date:   Wed, 16 Jun 2021 17:41:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John 'Warthog9' Hawley <warthog9@kernel.org>
Subject: [RFC][PATCH] bootconfig/tracing/ktest: Add ktest examples of
 testing bootconfig
Message-ID: <20210616174155.007b764a@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

bootconfig is a new feature that appends scripts onto the initrd, and the
kernel executes the scripts as an extended kernel command line.

Need to add tests to test that the happened. To test the bootconfig
properly, the initrd needs to be updated and the kernel rebooted. ktest is
the perfect solution to perform these tests.

Add a example bootconfig.conf in the tools/testing/ktest/examples/include
and example bootconfig scripts in tools/testing/ktest/examples/bootconfig
and also include verifier scripts that ktest will install on the target
and run to make sure that the bootconfig options in the scripts took place
after the target rebooted with the new initrd update.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../examples/bootconfigs/boottrace.bconf      | 49 +++++++++++
 .../examples/bootconfigs/config-bootconfig    |  1 +
 .../ktest/examples/bootconfigs/ftrace.bconf   | 82 ++++++++++++++++++
 .../examples/bootconfigs/functiongraph.bconf  | 15 ++++
 .../ktest/examples/bootconfigs/tracing.bconf  | 51 +++++++++++
 .../examples/bootconfigs/verify-boottrace.sh  | 84 +++++++++++++++++++
 .../bootconfigs/verify-functiongraph.sh       | 61 ++++++++++++++
 .../examples/bootconfigs/verify-tracing.sh    | 74 ++++++++++++++++
 .../ktest/examples/include/bootconfig.conf    | 83 ++++++++++++++++++
 tools/testing/ktest/examples/kvm.conf         |  1 +
 10 files changed, 501 insertions(+)
 create mode 100644 tools/testing/ktest/examples/bootconfigs/boottrace.bconf
 create mode 100644 tools/testing/ktest/examples/bootconfigs/config-bootconfig
 create mode 100644 tools/testing/ktest/examples/bootconfigs/ftrace.bconf
 create mode 100644 tools/testing/ktest/examples/bootconfigs/functiongraph.bconf
 create mode 100644 tools/testing/ktest/examples/bootconfigs/tracing.bconf
 create mode 100755 tools/testing/ktest/examples/bootconfigs/verify-boottrace.sh
 create mode 100755 tools/testing/ktest/examples/bootconfigs/verify-functiongraph.sh
 create mode 100755 tools/testing/ktest/examples/bootconfigs/verify-tracing.sh
 create mode 100644 tools/testing/ktest/examples/include/bootconfig.conf

diff --git a/tools/testing/ktest/examples/bootconfigs/boottrace.bconf b/tools/testing/ktest/examples/bootconfigs/boottrace.bconf
new file mode 100644
index 000000000000..2238a3196fa9
--- /dev/null
+++ b/tools/testing/ktest/examples/bootconfigs/boottrace.bconf
@@ -0,0 +1,49 @@
+ftrace.event {
+	task.task_newtask {
+		filter = "pid < 128"
+		enable
+	}
+	kprobes.vfs_read {
+              probes = "vfs_read $arg1 $arg2"
+              filter = "common_pid < 200"
+              enable
+      }
+      synthetic.initcall_latency {
+              fields = "unsigned long func", "u64 lat"
+              actions = "hist:keys=func.sym,lat:vals=lat:sort=lat"
+      }
+      initcall.initcall_start {
+              actions = "hist:keys=func:ts0=common_timestamp.usecs"
+      }
+      initcall.initcall_finish {
+              actions = "hist:keys=func:lat=common_timestamp.usecs-$ts0:onmatch(initcall.initcall_start).initcall_latency(func,$lat)"
+      }
+}
+
+ftrace.instance {
+      foo {
+              tracer = "function"
+              ftrace.filters = "user_*"
+              cpumask = 1
+              options = nosym-addr
+              buffer_size = 512KB
+              trace_clock = mono
+		event.signal.signal_deliver.actions=snapshot
+      }
+      bar {
+              tracer = "function"
+              ftrace.filters = "kernel_*"
+	      cpumask = 2
+             trace_clock = x86-tsc
+      }
+}
+
+ftrace.alloc_snapshot
+
+kernel {
+      trace_options = sym-addr
+      trace_event = "initcall:*"
+      trace_buf_size = 1M
+      ftrace = function
+      ftrace_filter = "vfs*"
+}
diff --git a/tools/testing/ktest/examples/bootconfigs/config-bootconfig b/tools/testing/ktest/examples/bootconfigs/config-bootconfig
new file mode 100644
index 000000000000..0685b6811388
--- /dev/null
+++ b/tools/testing/ktest/examples/bootconfigs/config-bootconfig
@@ -0,0 +1 @@
+CONFIG_CMDLINE="bootconfig"
diff --git a/tools/testing/ktest/examples/bootconfigs/ftrace.bconf b/tools/testing/ktest/examples/bootconfigs/ftrace.bconf
new file mode 100644
index 000000000000..30ab0d5e636f
--- /dev/null
+++ b/tools/testing/ktest/examples/bootconfigs/ftrace.bconf
@@ -0,0 +1,82 @@
+#!/bin/sh
+
+ftrace {
+	options = "sym-addr", "context-info"
+	buffer_size = 1MB
+}
+
+ftrace.event {
+	# Sample1: Make a histogram for initcall functions
+	synthetic.initcall_latency {
+                fields = "unsigned long func", "u64 lat"
+		hist {
+			keys = func.sym, lat
+			vals = lat
+			sort = lat
+		}
+	}
+	initcall.initcall_start.hist {
+		keys = func
+		var.ts0 = common_timestamp.usecs
+	}
+	initcall.initcall_finish.hist {
+		keys = func
+		var.lat = common_timestamp.usecs - $ts0
+		onmatch {
+			event = initcall.initcall_start
+			action = "initcall_latency(func, $lat)"
+		}
+	}
+
+	# Sample2: kmalloc() tracing in read(2) syscall
+	syscalls.sys_enter_read.enable_event {
+		event = kmem.kmalloc
+		count = 1
+	}
+	syscalls.sys_exit_read.disable_event {
+		event = kmem.kmalloc
+	}
+
+	# Sample3: Stacktrace at the event
+	kmem.kmalloc.stacktrace {
+		count = 5
+		filter = 'bytes_req >= 65536'
+	}
+
+	# Sample4: Take a snapshot
+	block.block_unplug.snapshot {
+		count = 1
+		filter = nr_rq > 1
+	}
+
+	# Sample5: Trace-on/off
+	block.block_plug.traceon {
+		filter = nr_rq > 1
+	}
+	block.block_unplug.traceoff {
+		filter = nr_rq > 1
+	}
+
+        # Sample6: onmax
+	sched.sched_waking {
+		enable
+		hist {
+			keys = pid
+			ts1 = common_timestamp.usecs
+			filter = 'comm == "cyclictest"'
+		}
+	}
+	sched.sched_switch {
+		enable
+		hist {
+			keys = next_pid
+			var.wakeup_lat = common_timestamp.usecs - $ts1
+			onmax {
+				var = wakeup_lat
+				action = "save(next_prio,next_comm,prev_pid,prev_prio,prev_comm)"
+			}
+			filter = 'next_comm == "cyclictest"'
+		}
+	}
+}
+
diff --git a/tools/testing/ktest/examples/bootconfigs/functiongraph.bconf b/tools/testing/ktest/examples/bootconfigs/functiongraph.bconf
new file mode 100644
index 000000000000..f9fb65caaad2
--- /dev/null
+++ b/tools/testing/ktest/examples/bootconfigs/functiongraph.bconf
@@ -0,0 +1,15 @@
+ftrace {
+      tracing_on = 0  # off by default
+      tracer = function_graph
+      event.kprobes {
+                start_event {
+                        probes = "pci_proc_init"
+                        actions = "traceon"
+                }
+                end_event {
+                        probes = "pci_proc_init%return"
+                        actions = "traceoff"
+                }
+        }
+  }
+
diff --git a/tools/testing/ktest/examples/bootconfigs/tracing.bconf b/tools/testing/ktest/examples/bootconfigs/tracing.bconf
new file mode 100644
index 000000000000..4094390ade41
--- /dev/null
+++ b/tools/testing/ktest/examples/bootconfigs/tracing.bconf
@@ -0,0 +1,51 @@
+ftrace {
+	tracer = function;
+	options = event-fork, sym-addr, stacktrace;
+	buffer_size = 1M;
+	alloc_snapshot;
+	trace_clock = global;
+	events = "task:task_newtask", "initcall:*";
+	event.sched.sched_process_exec {
+		filter = "pid < 128";
+	}
+	event.kprobes.myevent {
+		probes = "vfs_read $arg1 $arg2", "vfs_write $arg1 $arg2"
+	}
+	event.kprobes.myevent2 {
+		probes = "initrd_load";
+	}
+	event.kprobes.enable
+	instance.bar {
+		event.synthetic.initcall_latency {
+			fields = "unsigned long func", "u64 lat";
+			actions.hist {
+				keys = func.sym, lat;
+				vals = lat;
+				sort = lat;
+			}
+		}
+		event.initcall {
+			initcall_start.actions.hist {
+				keys = func;
+				ts0 = "common_timestamp.usecs";
+			}
+			initcall_finish.actions.hist {
+				keys = "func";
+				lat = "common_timestamp.usecs-$ts0";
+				onmatch = "initcall.initcall_start",
+					  "initcall_latency(func,$lat)";
+			}
+		}
+	}
+	instance.foo {
+		tracer = function-graph;
+		tracing_on = false;
+		event.workqueue.workqueue_start.actions = "tracing_on";
+		event.workqueue.workqueue_end.actions = "tracing_off";
+	};
+}
+kernel {
+	tp_printk;
+	dump_on_oops = 2
+	traceoff_on_warning
+}
diff --git a/tools/testing/ktest/examples/bootconfigs/verify-boottrace.sh b/tools/testing/ktest/examples/bootconfigs/verify-boottrace.sh
new file mode 100755
index 000000000000..f271940ce7fb
--- /dev/null
+++ b/tools/testing/ktest/examples/bootconfigs/verify-boottrace.sh
@@ -0,0 +1,84 @@
+#!/bin/sh
+
+cd /sys/kernel/tracing
+
+compare_file() {
+	file="$1"
+	val="$2"
+	content=`cat $file`
+	if [ "$content" != "$val" ]; then
+		echo "FAILED: $file has '$content', expected '$val'"
+		exit 1
+	fi
+}
+
+compare_file_partial() {
+	file="$1"
+	val="$2"
+	content=`cat $file | sed -ne "/^$val/p"`
+	if [ -z "$content" ]; then
+		echo "FAILED: $file does not contain '$val'"
+		cat $file
+		exit 1
+	fi
+}
+
+file_contains() {
+	file=$1
+	val="$2"
+
+	if ! grep -q "$val" $file ; then
+		echo "FAILED: $file does not contain $val"
+		cat $file
+		exit 1
+	fi
+}
+
+compare_mask() {
+	file=$1
+	val="$2"
+
+	content=`cat $file | sed -ne "/^[0 ]*$val/p"`
+	if [ -z "$content" ]; then
+		echo "FAILED: $file does not have mask '$val'"
+		cat $file
+		exit 1
+	fi
+}
+
+compare_file "events/task/task_newtask/filter" "pid < 128"
+compare_file "events/task/task_newtask/enable" "1"
+
+compare_file "events/kprobes/vfs_read/filter" "common_pid < 200"
+compare_file "events/kprobes/vfs_read/enable" "1"
+
+compare_file_partial "events/synthetic/initcall_latency/trigger" "hist:keys=func.sym,lat:vals=hitcount,lat:sort=lat"
+compare_file_partial "events/synthetic/initcall_latency/enable" "0"
+
+compare_file_partial "events/initcall/initcall_start/trigger" "hist:keys=func:vals=hitcount:ts0=common_timestamp.usecs"
+compare_file_partial "events/initcall/initcall_start/enable" "1"
+
+compare_file_partial "events/initcall/initcall_finish/trigger" 'hist:keys=func:vals=hitcount:lat=common_timestamp.usecs-\$ts0:sort=hitcount:size=2048:clock=global:onmatch(initcall.initcall_start).initcall_latency(func,\$lat)'
+compare_file_partial "events/initcall/initcall_finish/enable" "1"
+
+compare_file "instances/foo/current_tracer" "function"
+file_contains "instances/foo/set_ftrace_filter" "^user"
+compare_file "instances/foo/buffer_size_kb" "512"
+compare_mask "instances/foo/tracing_cpumask" "1"
+compare_file "instances/foo/options/sym-addr" "0"
+file_contains "instances/foo/trace_clock" '\[mono\]'
+compare_file_partial "instances/foo/events/signal/signal_deliver/trigger" "snapshot"
+
+compare_file "instances/bar/current_tracer" "function"
+file_contains "instances/bar/set_ftrace_filter" "^kernel"
+compare_mask "instances/bar/tracing_cpumask" "2"
+file_contains "instances/bar/trace_clock" '\[x86-tsc\]'
+
+file_contains "snapshot" "Snapshot is allocated"
+compare_file "options/sym-addr" "1"
+compare_file "events/initcall/enable" "1"
+compare_file "buffer_size_kb" "1027"
+compare_file "current_tracer" "function"
+file_contains "set_ftrace_filter" '^vfs'
+
+exit 0
diff --git a/tools/testing/ktest/examples/bootconfigs/verify-functiongraph.sh b/tools/testing/ktest/examples/bootconfigs/verify-functiongraph.sh
new file mode 100755
index 000000000000..b50baa10fe97
--- /dev/null
+++ b/tools/testing/ktest/examples/bootconfigs/verify-functiongraph.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+
+cd /sys/kernel/tracing
+
+compare_file() {
+	file="$1"
+	val="$2"
+	content=`cat $file`
+	if [ "$content" != "$val" ]; then
+		echo "FAILED: $file has '$content', expected '$val'"
+		exit 1
+	fi
+}
+
+compare_file_partial() {
+	file="$1"
+	val="$2"
+	content=`cat $file | sed -ne "/^$val/p"`
+	if [ -z "$content" ]; then
+		echo "FAILED: $file does not contain '$val'"
+		cat $file
+		exit 1
+	fi
+}
+
+file_contains() {
+	file=$1
+	val="$2"
+
+	if ! grep -q "$val" $file ; then
+		echo "FAILED: $file does not contain $val"
+		cat $file
+		exit 1
+	fi
+}
+
+compare_mask() {
+	file=$1
+	val="$2"
+
+	content=`cat $file | sed -ne "/^[0 ]*$val/p"`
+	if [ -z "$content" ]; then
+		echo "FAILED: $file does not have mask '$val'"
+		cat $file
+		exit 1
+	fi
+}
+
+
+compare_file "tracing_on" "0"
+compare_file "current_tracer" "function_graph"
+
+compare_file_partial "events/kprobes/start_event/enable" "1"
+compare_file_partial "events/kprobes/start_event/trigger" "traceon"
+file_contains "kprobe_events" 'start_event.*pci_proc_init'
+
+compare_file_partial "events/kprobes/end_event/enable" "1"
+compare_file_partial "events/kprobes/end_event/trigger" "traceoff"
+file_contains "kprobe_events" '^r.*end_event.*pci_proc_init'
+
+exit 0
diff --git a/tools/testing/ktest/examples/bootconfigs/verify-tracing.sh b/tools/testing/ktest/examples/bootconfigs/verify-tracing.sh
new file mode 100755
index 000000000000..fb95e6107fea
--- /dev/null
+++ b/tools/testing/ktest/examples/bootconfigs/verify-tracing.sh
@@ -0,0 +1,74 @@
+#!/bin/sh
+
+cd /sys/kernel/tracing
+
+compare_file() {
+	file="$1"
+	val="$2"
+	content=`cat $file`
+	if [ "$content" != "$val" ]; then
+		echo "FAILED: $file has '$content', expected '$val'"
+		exit 1
+	fi
+}
+
+compare_file_partial() {
+	file="$1"
+	val="$2"
+	content=`cat $file | sed -ne "/^$val/p"`
+	if [ -z "$content" ]; then
+		echo "FAILED: $file does not contain '$val'"
+		cat $file
+		exit 1
+	fi
+}
+
+file_contains() {
+	file=$1
+	val="$2"
+
+	if ! grep -q "$val" $file ; then
+		echo "FAILED: $file does not contain $val"
+		cat $file
+		exit 1
+	fi
+}
+
+compare_mask() {
+	file=$1
+	val="$2"
+
+	content=`cat $file | sed -ne "/^[0 ]*$val/p"`
+	if [ -z "$content" ]; then
+		echo "FAILED: $file does not have mask '$val'"
+		cat $file
+		exit 1
+	fi
+}
+
+compare_file "current_tracer" "function"
+compare_file "options/event-fork" "1"
+compare_file "options/sym-addr" "1"
+compare_file "options/stacktrace" "1"
+compare_file "buffer_size_kb" "1027"
+file_contains "snapshot" "Snapshot is allocated"
+file_contains "trace_clock" '\[global\]'
+compare_file "events/initcall/enable" "1"
+compare_file "events/task/task_newtask/enable" "1"
+compare_file "events/sched/sched_process_exec/filter" "pid < 128"
+compare_file "events/kprobes/enable" "1"
+
+compare_file_partial "instances/bar/events/synthetic/initcall_latency/trigger" "hist:keys=func.sym:vals=lat:sort=lat"
+compare_file_partial "instances/bar/events/initcall/initcall_start/trigger" "hist:keys=func.sym:ts=common_timestamp.usecs"
+compare_file_partial "instances/bar/events/initcall/initcall_finish/trigger" 'hist:keys=func.sym:lat=common_timestamp.usecs-\$ts0:onmatch(initcall.initcall_start).initcall_latency(func,\$lat)'
+
+compare_file "instances/foo/current_tracer" "function-graph"
+compare_file "instances/foo/tracing_on" "0"
+compare_file_partial "instances/foo/events/workqueue/workqueue_start/trigger" "tracing_on"
+compare_file_partial "instances/foo/events/workqueue/workqueue_end/trigger" "tracing_off"
+
+compare_file "/proc/sys/kernel/ftrace_dump_on_oops" "2"
+compare_file "/proc/sys/krenel/traceoff_on_warning" "1"
+compare_file "/proc/sys/kernel/tracepoint_printk" "1"
+
+exit 0
diff --git a/tools/testing/ktest/examples/include/bootconfig.conf b/tools/testing/ktest/examples/include/bootconfig.conf
new file mode 100644
index 000000000000..d6cee411cf57
--- /dev/null
+++ b/tools/testing/ktest/examples/include/bootconfig.conf
@@ -0,0 +1,83 @@
+# bootconfig.conf
+#
+# Tests to test some bootconfig scripts
+
+# List where on the target machine the initrd is used
+INITRD := /boot/initramfs-test.img
+
+# Install bootconfig on the target machine and define the path here.
+BOOTCONFIG := /usr/bin/bootconfig
+
+# Currenty we just build the .config in the BUILD_DIR
+BUILD_TYPE := oldconfig
+
+# Helper macro to run bootconfig on the target
+# SSH is defined in include/defaults.conf
+ADD_BOOTCONFIG := ${SSH} "${BOOTCONFIG} -d ${INITRD} && ${BOOTCONFIG} -a /tmp/${BOOTCONFIG_FILE} ${INITRD}"
+
+# This copies a bootconfig script to the target and then will
+# add it to the initrd. SSH_USER is defined in include/defaults.conf
+# and MACHINE is defined in the example configs.
+BOOTCONFIG_TEST_PREP = scp ${BOOTCONFIG_PATH}${BOOTCONFIG_FILE} ${SSH_USER}@${MACHINE}:/tmp && ${ADD_BOOTCONFIG}
+
+# When a test is complete, remove the bootconfig from the initrd.
+CLEAR_BOOTCONFIG := ${SSH} "${BOOTCONFIG} -d ${INITRD}"
+
+# Run a verifier on the target after it had booted, to make sure that the
+# bootconfig script did what it was expected to do
+DO_TEST = scp ${BOOTCONFIG_PATH}${BOOTCONFIG_VERIFY} ${SSH_USER}@${MACHINE}:/tmp && ${SSH} /tmp/${BOOTCONFIG_VERIFY}
+
+# Comment this out to not run the boot configs
+RUN_BOOTCONFIG := 1
+
+TEST_START IF DEFINED RUN_BOOTCONFIG
+TEST_TYPE = test
+TEST_NAME = bootconfig boottrace
+# Just testing the bootconfig on initrd, no need to build the kernel
+BUILD_TYPE = nobuild
+BOOTCONFIG_FILE = boottrace.bconf
+BOOTCONFIG_VERIFY = verify-boottrace.sh
+ADD_CONFIG = ${ADD_CONFIG} ${BOOTCONFIG_PATH}/config-bootconfig
+PRE_TEST = ${BOOTCONFIG_TEST_PREP}
+PRE_TEST_DIE = 1
+TEST = ${DO_TEST}
+POST_TEST = ${CLEAR_BOOTCONFIG}
+
+# Currently ftrace.bconf does not work, skip the test
+TEST_START IF DEFINED RUN_BOOTCONFIG SKIP
+TEST_TYPE = test
+TEST_NAME = bootconfig ftrace
+BUILD_TYPE = nobuild
+BOOTCONFIG_FILE = ftrace.bconf
+BOOTCONFIG_VERIFY = verify-ftrace.sh
+ADD_CONFIG = ${ADD_CONFIG} ${BOOTCONFIG_PATH}/config-bootconfig
+PRE_TEST = ${BOOTCONFIG_TEST_PREP}
+PRE_TEST_DIE = 1
+TEST = ${DO_TEST}
+POST_TEST = ${CLEAR_BOOTCONFIG}
+
+TEST_START IF DEFINED RUN_BOOTCONFIG
+TEST_TYPE = test
+TEST_NAME = bootconfig function graph
+BUILD_TYPE = nobuild
+BOOTCONFIG_FILE = functiongraph.bconf
+BOOTCONFIG_VERIFY = verify-functiongraph.sh
+ADD_CONFIG = ${ADD_CONFIG} ${BOOTCONFIG_PATH}/config-bootconfig
+PRE_TEST = ${BOOTCONFIG_TEST_PREP}
+PRE_TEST_DIE = 1
+TEST = ${DO_TEST}
+POST_TEST = ${CLEAR_BOOTCONFIG}
+
+# Currently tracing.bconf does not work, skip the test
+TEST_START IF DEFINED RUN_BOOTCONFIG SKIP
+TEST_TYPE = test
+TEST_NAME = bootconfig tracing
+BUILD_TYPE = nobuild
+BOOTCONFIG_FILE = tracing.bconf
+BOOTCONFIG_VERIFY = verify-tracing.sh
+ADD_CONFIG = ${ADD_CONFIG} ${BOOTCONFIG_PATH}/config-bootconfig
+PRE_TEST = ${BOOTCONFIG_TEST_PREP}
+PRE_TEST_DIE = 1
+TEST = ${DO_TEST}
+POST_TEST = ${CLEAR_BOOTCONFIG}
+
diff --git a/tools/testing/ktest/examples/kvm.conf b/tools/testing/ktest/examples/kvm.conf
index fbc134f9ac6e..c700e8bb7fde 100644
--- a/tools/testing/ktest/examples/kvm.conf
+++ b/tools/testing/ktest/examples/kvm.conf
@@ -90,3 +90,4 @@ INCLUDE include/patchcheck.conf
 INCLUDE include/tests.conf
 INCLUDE include/bisect.conf
 INCLUDE include/min-config.conf
+INCLUDE include/bootconfig.conf
\ No newline at end of file
-- 
2.29.2

