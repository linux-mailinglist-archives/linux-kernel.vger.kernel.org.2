Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A7D31E8C2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 11:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhBRKij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 05:38:39 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12191 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbhBRJZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 04:25:41 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dh8P51t4qzlLl7;
        Thu, 18 Feb 2021 17:22:17 +0800 (CST)
Received: from huawei.com (10.174.28.241) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Thu, 18 Feb 2021
 17:24:01 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <hagen@jauu.net>, <john.wanghui@huawei.com>,
        <abudankov@huawei.com>, <yz.yuzhou@huawei.com>
Subject: [PATCH v4 1/2] perf tools: add 'perf irq' to measure the hardware interrupts
Date:   Thu, 18 Feb 2021 18:43:11 +0800
Message-ID: <20210218104312.50171-2-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218104312.50171-1-cuibixuan@huawei.com>
References: <20210218104312.50171-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.28.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'perf irq' to trace/measure the hardware interrupts.

Now three functions are provided:
  1. 'perf irq record <command>' to record the irq handler events.
  2. 'perf irq script' to see a detailed trace of the workload that
   was recorded.
  3. 'perf irq report' to calculate the time consumed by each
   hardware interrupt processing function.

Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
 tools/perf/Build         |   1 +
 tools/perf/builtin-irq.c | 260 +++++++++++++++++++++++++++++++++++++++
 tools/perf/builtin.h     |   1 +
 tools/perf/perf.c        |   1 +
 4 files changed, 263 insertions(+)
 create mode 100644 tools/perf/builtin-irq.c

diff --git a/tools/perf/Build b/tools/perf/Build
index 5f392dbb88fc..d52a1e1d6d8a 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -24,6 +24,7 @@ perf-y += builtin-mem.o
 perf-y += builtin-data.o
 perf-y += builtin-version.o
 perf-y += builtin-c2c.o
+perf-y += builtin-irq.o
 
 perf-$(CONFIG_TRACE) += builtin-trace.o
 perf-$(CONFIG_LIBELF) += builtin-probe.o
diff --git a/tools/perf/builtin-irq.c b/tools/perf/builtin-irq.c
new file mode 100644
index 000000000000..bf1e6efd85f8
--- /dev/null
+++ b/tools/perf/builtin-irq.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "builtin.h"
+#include "perf.h"
+#include "perf-sys.h"
+
+#include "util/cpumap.h"
+#include "util/evlist.h"
+#include "util/evsel.h"
+#include "util/evsel_fprintf.h"
+#include "util/symbol.h"
+#include "util/thread.h"
+#include "util/header.h"
+#include "util/session.h"
+#include "util/tool.h"
+#include "util/cloexec.h"
+#include "util/thread_map.h"
+#include "util/color.h"
+#include "util/stat.h"
+#include "util/string2.h"
+#include "util/callchain.h"
+#include "util/time-utils.h"
+
+#include <subcmd/pager.h>
+#include <subcmd/parse-options.h>
+#include "util/trace-event.h"
+
+#include "util/debug.h"
+#include "util/event.h"
+
+#include <linux/kernel.h>
+#include <linux/log2.h>
+#include <linux/zalloc.h>
+#include <sys/prctl.h>
+#include <sys/resource.h>
+#include <inttypes.h>
+
+#include <errno.h>
+#include <semaphore.h>
+#include <pthread.h>
+#include <math.h>
+#include <api/fs/fs.h>
+#include <perf/cpumap.h>
+#include <linux/time64.h>
+#include <linux/err.h>
+
+#include <linux/ctype.h>
+
+#define IRQ_NAME_LEN		24
+#define MAX_CPUS		4096
+
+static const char *cpu_list;
+static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
+
+struct perf_irq {
+	struct perf_tool tool;
+	bool force;
+
+	char irq_name[MAX_CPUS][IRQ_NAME_LEN];
+	u32 irq_num[MAX_CPUS];
+	u64 irq_entry_time[MAX_CPUS];
+	u64 irq_exit_time[MAX_CPUS];
+};
+
+typedef int (*irq_handler)(struct perf_tool *tool,
+			  struct evsel *evsel,
+			  struct perf_sample *sample);
+
+static int perf_report_process_sample(struct perf_tool *tool,
+					 union perf_event *event __maybe_unused,
+					 struct perf_sample *sample,
+					 struct evsel *evsel,
+					 struct machine *machine __maybe_unused)
+{
+	int err = 0;
+
+	if (evsel->handler != NULL) {
+		irq_handler f = evsel->handler;
+		err = f(tool, evsel, sample);
+	}
+
+	return err;
+}
+
+static void output_report(struct perf_irq *irq, u32 cpu)
+{
+	int ret, i;
+	char irq_entry_time[30], irq_exit_time[30], irq_diff[30];
+
+	timestamp__scnprintf_usec(irq->irq_entry_time[cpu],
+				  irq_entry_time, sizeof(irq_entry_time));
+	timestamp__scnprintf_usec(irq->irq_exit_time[cpu],
+				  irq_exit_time, sizeof(irq_exit_time));
+	timestamp__scnprintf_usec(irq->irq_exit_time[cpu] - irq->irq_entry_time[cpu],
+				  irq_diff, sizeof(irq_diff));
+
+	ret = printf("   %s ", irq->irq_name[cpu]);
+	for (i = 0; i < IRQ_NAME_LEN - ret; i++)
+		printf(" ");
+
+	printf("| [%04d] | %13s s | %16s s | %16s s\n",
+		cpu, irq_diff, irq_entry_time, irq_exit_time);
+}
+
+static int report_irq_handler_entry_event(struct perf_tool *tool,
+				      struct evsel *evsel,
+				      struct perf_sample *sample)
+{
+	int this_cpu = sample->cpu, err = 0;
+	struct perf_irq *irq = container_of(tool, struct perf_irq, tool);
+	const char *name = evsel__strval(evsel, sample, "name");
+
+	irq->irq_entry_time[this_cpu] = sample->time;
+
+	strncpy(irq->irq_name[this_cpu], name, IRQ_NAME_LEN - 1);
+	irq->irq_name[this_cpu][IRQ_NAME_LEN - 1] = '\0';
+
+	return err;
+}
+
+static int report_irq_handler_exit_event(struct perf_tool *tool,
+				      struct evsel *evsel __maybe_unused,
+				      struct perf_sample *sample)
+{
+	int this_cpu = sample->cpu, err = 0;
+	struct perf_irq *irq = container_of(tool, struct perf_irq, tool);
+
+	irq->irq_exit_time[this_cpu] = sample->time;
+
+	if (cpu_list && !test_bit(this_cpu, cpu_bitmap))
+		return err;
+
+	output_report(irq, this_cpu);
+
+	return err;
+}
+
+static int perf_irq__read_events(struct perf_irq *irq)
+{
+	struct evsel_str_handler handlers[] = {
+		{ "irq:irq_handler_entry",	report_irq_handler_entry_event, },
+		{ "irq:irq_handler_exit",	report_irq_handler_exit_event, },
+	};
+	struct perf_session *session;
+	struct perf_data data = {
+		.path  = input_name,
+		.mode  = PERF_DATA_MODE_READ,
+		.force = irq->force,
+	};
+	int rc = -1;
+
+	irq->tool.sample = perf_report_process_sample;
+
+	session = perf_session__new(&data, false, &irq->tool);
+	if (IS_ERR(session)) {
+		pr_debug("Error creating perf session");
+		return PTR_ERR(session);
+	}
+
+	if (cpu_list) {
+		rc = perf_session__cpu_bitmap(session, cpu_list, cpu_bitmap);
+		if (rc < 0)
+			goto out_delete;
+	}
+
+	if (perf_session__set_tracepoints_handlers(session, handlers))
+		goto out_delete;
+
+	rc = perf_session__process_events(session);
+	if (rc) {
+		pr_err("Failed to process events, error %d", rc);
+		goto out_delete;
+	}
+
+out_delete:
+	perf_session__delete(session);
+	return rc;
+}
+
+static int irq_report(struct perf_irq *irq)
+{
+	printf("  -------------------------------------------------------------------------------------------------------------------------------------------\n");
+	printf("   Irq name             |  CPU   | Time consume us | Handler entry time | Handler exit time \n");
+	printf("  -------------------------------------------------------------------------------------------------------------------------------------------\n");
+
+	if (perf_irq__read_events(irq))
+		return -1;
+
+	return 0;
+}
+
+static int __cmd_record(int argc, const char **argv)
+{
+	unsigned int rec_argc, i, j;
+	const char **rec_argv;
+	const char * const record_args[] = {
+		"record",
+		"-a",
+		"-R",
+		"-c", "1",
+		"-e", "irq:irq_handler_entry",
+		"-e", "irq:irq_handler_exit",
+	};
+
+	rec_argc = ARRAY_SIZE(record_args) + argc - 1;
+	rec_argv = calloc(rec_argc + 1, sizeof(char *));
+	if (rec_argv == NULL)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(record_args); i++)
+		rec_argv[i] = strdup(record_args[i]);
+
+	for (j = 1; j < (unsigned int)argc; j++, i++)
+		rec_argv[i] = argv[j];
+
+	BUG_ON(i != rec_argc);
+
+	return cmd_record(i, rec_argv);
+}
+
+int cmd_irq(int argc, const char **argv)
+{
+	struct perf_irq irq = {
+		.force	= false,
+	};
+
+	const struct option irq_options[] = {
+	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
+	OPT_END()
+	};
+	const struct option report_options[] = {
+	OPT_PARENT(irq_options)
+	};
+
+	const char * const report_usage[] = {
+		"perf irq report [<options>]",
+		NULL
+	};
+	const char *const irq_subcommands[] = { "record", "report", NULL };
+	const char *irq_usage[] = {
+		NULL,
+		NULL
+	};
+
+	argc = parse_options_subcommand(argc, argv, irq_options, irq_subcommands,
+					irq_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+	if (!argc)
+		usage_with_options(irq_usage, irq_options);
+
+	if (!strncmp(argv[0], "record", 6)) {
+		return __cmd_record(argc, argv);
+	} else if (!strncmp(argv[0], "report", 6)) {
+		if (argc > 1) {
+			argc = parse_options(argc, argv, report_options, report_usage, 0);
+			if (argc)
+				usage_with_options(report_usage, report_options);
+		}
+		return irq_report(&irq);
+	}
+	return 0;
+}
diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
index 14a2db622a7b..fd92dfc89370 100644
--- a/tools/perf/builtin.h
+++ b/tools/perf/builtin.h
@@ -37,6 +37,7 @@ int cmd_inject(int argc, const char **argv);
 int cmd_mem(int argc, const char **argv);
 int cmd_data(int argc, const char **argv);
 int cmd_ftrace(int argc, const char **argv);
+int cmd_irq(int argc, const char **argv);
 
 int find_scripts(char **scripts_array, char **scripts_path_array, int num,
 		 int pathlen);
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 27f94b0bb874..df9cb344c2d0 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -88,6 +88,7 @@ static struct cmd_struct commands[] = {
 	{ "mem",	cmd_mem,	0 },
 	{ "data",	cmd_data,	0 },
 	{ "ftrace",	cmd_ftrace,	0 },
+	{ "irq",	cmd_irq,	0 },
 };
 
 struct pager_config {
-- 
2.17.1

