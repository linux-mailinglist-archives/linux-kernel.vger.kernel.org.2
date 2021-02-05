Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD38131080F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhBEJjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:39:46 -0500
Received: from foss.arm.com ([217.140.110.172]:53714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230273AbhBEJhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:37:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C3C431B;
        Fri,  5 Feb 2021 01:36:10 -0800 (PST)
Received: from net-arm-thunderx2-02.shanghai.arm.com (net-arm-thunderx2-02.shanghai.arm.com [10.169.208.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EBECC3F73B;
        Fri,  5 Feb 2021 01:36:04 -0800 (PST)
From:   Jianlin Lv <Jianlin.Lv@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, natechancellor@gmail.com,
        ndesaulniers@google.com, mhiramat@kernel.org, fche@redhat.com,
        irogers@google.com, sumanthk@linux.ibm.com, adrian.hunter@intel.com
Cc:     Jianlin.Lv@arm.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] perf probe: fix kretprobe issue caused by GCC bug
Date:   Fri,  5 Feb 2021 17:35:58 +0800
Message-Id: <20210205093558.3057814-1-Jianlin.Lv@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf failed to add kretprobe event with debuginfo of vmlinux which is
compiled by gcc with -fpatchable-function-entry option enabled.
The same issue with kernel module.

Issue:

  # perf probe  -v 'kernel_clone%return $retval'
  ......
  Writing event: r:probe/kernel_clone__return _text+599624 $retval
  Failed to write event: Invalid argument
    Error: Failed to add events. Reason: Invalid argument (Code: -22)

  # cat /sys/kernel/debug/tracing/error_log
  [156.75] trace_kprobe: error: Retprobe address must be an function entry
  Command: r:probe/kernel_clone__return _text+599624 $retval
                                        ^

  # llvm-dwarfdump  vmlinux |grep  -A 10  -w 0x00df2c2b
  0x00df2c2b:   DW_TAG_subprogram
                DW_AT_external  (true)
                DW_AT_name      ("kernel_clone")
                DW_AT_decl_file ("/home/code/linux-next/kernel/fork.c")
                DW_AT_decl_line (2423)
                DW_AT_decl_column       (0x07)
                DW_AT_prototyped        (true)
                DW_AT_type      (0x00dcd492 "pid_t")
                DW_AT_low_pc    (0xffff800010092648)
                DW_AT_high_pc   (0xffff800010092b9c)
                DW_AT_frame_base        (DW_OP_call_frame_cfa)

  # cat /proc/kallsyms |grep kernel_clone
  ffff800010092640 T kernel_clone
  # readelf -s vmlinux |grep -i kernel_clone
  183173: ffff800010092640  1372 FUNC    GLOBAL DEFAULT    2 kernel_clone

  # objdump -d vmlinux |grep -A 10  -w \<kernel_clone\>:
  ffff800010092640 <kernel_clone>:
  ffff800010092640:       d503201f        nop
  ffff800010092644:       d503201f        nop
  ffff800010092648:       d503233f        paciasp
  ffff80001009264c:       a9b87bfd        stp     x29, x30, [sp, #-128]!
  ffff800010092650:       910003fd        mov     x29, sp
  ffff800010092654:       a90153f3        stp     x19, x20, [sp, #16]

The entry address of kernel_clone converted by debuginfo is _text+599624
(0x92648), which is consistent with the value of DW_AT_low_pc attribute.
But the symbolic address of kernel_clone from /proc/kallsyms is
ffff800010092640.

This issue is found on arm64, -fpatchable-function-entry=2 is enabled when
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y;
Just as objdump displayed the assembler contents of kernel_clone,
GCC generate 2 NOPs  at the beginning of each function.

kprobe_on_func_entry detects that (_text+599624) is not the entry address
of the function, which leads to the failure of adding kretprobe event.

---
kprobe_on_func_entry
->_kprobe_addr
->kallsyms_lookup_size_offset
->arch_kprobe_on_func_entry		// FALSE
---

The cause of the issue is that the first instruction in the compile unit
indicated by DW_AT_low_pc does not include NOPs.
This issue exists in all gcc versions that support
-fpatchable-function-entry option.

I have reported it to the GCC community:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=98776

Currently arm64 and PA-RISC may enable fpatchable-function-entry option.
The kernel compiled with clang does not have this issue.

FIX:

The result of my investigation is that this GCC issue will only cause the
registration failure of the kretprobe event;
Other functions of perf probe will not be affected, such as line probe,
local variable probe, uprobe, etc.

A workaround solution is to traverse all the compilation units in
debuginfo for the retprobe event and check whether the DW_AT_producer
attribute valaue of each CUs contains substrings: "GNU" and
"-fpatchable-function-entry". If these two substrings are included,
then debuginfo will not be used to convert perf_probe_event.
Instead, map will be used to query the probe function address.

-grecord-gcc-switches causes the command-line options used to invoke the
compiler to be appended to the DW_AT_producer attribute in DWARF debugging
information.It is enabled by default.

A potential defect is that if -gno-record-gcc-switches option is enabled,
the command-line options will not be recorded in debuginfo. This workaround
solution will fail.
Assume that this situation may not happen for kernel compilation.

Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
---
 tools/perf/util/probe-event.c | 60 +++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 8eae2afff71a..c0c1bcc59250 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -885,6 +885,60 @@ static int post_process_probe_trace_events(struct perf_probe_event *pev,
 	return ret;
 }
 
+/*
+ * Perf failed to add kretprobe event with debuginfo of vmlinux which is
+ * compiled by gcc with -fpatchable-function-entry option enabled.
+ * The same issue with kernel module. Refer to gcc issue: #98776
+ * This issue only cause the registration failure of kretprobe event,
+ * and it doesn't affect other perf probe functions.
+ * This workaround solution use map to query the probe function address
+ * for retprobe event.
+ * A potential defect is that if -gno-record-gcc-switches option is enabled,
+ * the command-line options will not be recorded in debuginfo. This workaround
+ * solution will fail.
+ */
+static bool retprobe_gcc_fpatchable_issue_workaround(struct debuginfo *dbg,
+		struct perf_probe_event *pev)
+{
+	Dwarf_Off off = 0, noff = 0;
+	size_t cuhl;
+	Dwarf_Die cu_die;
+	const char *producer = NULL;
+	Dwarf_Attribute attr;
+
+	if (!pev->point.retprobe)
+		return false;
+
+	/* Loop on CUs (Compilation Unit) */
+	while (!dwarf_nextcu(dbg->dbg, off, &noff, &cuhl, NULL, NULL, NULL)) {
+		/* Get the DIE(Debugging Information Entry) of this CU */
+		if (dwarf_offdie(dbg->dbg, off + cuhl, &cu_die) == NULL) {
+			off = noff;
+			continue;
+		}
+
+		/* Get information about the compiler that produced CUs */
+		if (dwarf_hasattr(&cu_die, DW_AT_producer)
+			&& dwarf_attr(&cu_die, DW_AT_producer, &attr)) {
+			producer = dwarf_formstring(&attr);
+			if (producer == NULL) {
+				off = noff;
+				continue;
+			}
+			/* Check that CU is compiled by GCC with
+			 * fpatchable-function-entry option enabled
+			 */
+			if (strstr(producer, "GNU") &&
+				strstr(producer, "-fpatchable-function-entry")) {
+				pr_debug("Workaround for gcc issue, find probe function addresses from map.\n");
+				return true;
+			}
+		}
+		off = noff;
+	}
+	return false;
+}
+
 /* Try to find perf_probe_event with debuginfo */
 static int try_to_find_probe_trace_events(struct perf_probe_event *pev,
 					  struct probe_trace_event **tevs)
@@ -902,6 +956,12 @@ static int try_to_find_probe_trace_events(struct perf_probe_event *pev,
 		return 0;
 	}
 
+	/* workaround for gcc #98776 issue */
+	if (retprobe_gcc_fpatchable_issue_workaround(dinfo, pev) && !need_dwarf) {
+		debuginfo__delete(dinfo);
+		return 0;
+	}
+
 	pr_debug("Try to find probe point from debuginfo.\n");
 	/* Searching trace events corresponding to a probe event */
 	ntevs = debuginfo__find_trace_events(dinfo, pev, tevs);
-- 
2.25.1

