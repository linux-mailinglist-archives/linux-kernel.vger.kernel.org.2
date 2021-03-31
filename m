Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E2234FE42
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 12:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbhCaKnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 06:43:15 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:48864 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbhCaKmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=daKJGLUJOBuUf0fgOh2wCiH/hZVeYRRvdX8mHcYNRVg=; b=a/pHrOgGvs1F+Eqa4+uJHEwZxE
        jNjKDQu5cZsr++sl938dTfbSpUPnXnbLb+o7GTRhtzEWEXXSsGGsgoN+0y3rAo6q5l9Puk1xthlU5
        DLnX5BCk0rutIckb9CUAdMVfLd8cmA007MvO1nYKziM6/1K2NG+hzJWskzEmz0PlvZjg=;
Received: from 198-48-224-11.cpe.pppoe.ca ([198.48.224.11] helo=[192.168.1.180])
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <nfraser@codeweavers.com>)
        id 1lRYJG-0002Lu-3f; Wed, 31 Mar 2021 05:42:50 -0500
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>, linux-kernel@vger.kernel.org
From:   Nicholas Fraser <nfraser@codeweavers.com>
Subject: [PATCH] perf data: Add JSON export
Message-ID: <c4d0b0f1-79f4-f08d-3d7e-00046120f845@codeweavers.com>
Date:   Wed, 31 Mar 2021 06:42:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From ddcfd620e7cad4100d0076090c4b39dba8aeead3 Mon Sep 17 00:00:00 2001
From: Nicholas Fraser <nfraser@codeweavers.com>
Date: Wed, 31 Mar 2021 06:10:00 -0400
Subject: [PATCH] perf data: Add JSON export

This adds a feature to export perf data to JSON. It uses a minimal
inline JSON encoding, no external dependencies. Currently it only
outputs some headers and sample metadata but it's easily extensible.

Use it like this:

    perf data convert --to-json out.json

Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>
---
 tools/perf/Documentation/perf-data.txt |   5 +-
 tools/perf/builtin-data.c              |  26 ++-
 tools/perf/util/Build                  |   1 +
 tools/perf/util/data-convert-bt.c      |   2 +-
 tools/perf/util/data-convert-bt.h      |  11 -
 tools/perf/util/data-convert-json.c    | 310 +++++++++++++++++++++++++
 tools/perf/util/data-convert.h         |  10 +
 7 files changed, 344 insertions(+), 21 deletions(-)
 delete mode 100644 tools/perf/util/data-convert-bt.h
 create mode 100644 tools/perf/util/data-convert-json.c

diff --git a/tools/perf/Documentation/perf-data.txt b/tools/perf/Documentation/perf-data.txt
index 726b9bc9e1a7..417bf17e265c 100644
--- a/tools/perf/Documentation/perf-data.txt
+++ b/tools/perf/Documentation/perf-data.txt
@@ -17,7 +17,7 @@ Data file related processing.
 COMMANDS
 --------
 convert::
-	Converts perf data file into another format (only CTF [1] format is support by now).
+	Converts perf data file into another format.
 	It's possible to set data-convert debug variable to get debug messages from conversion,
 	like:
 	  perf --debug data-convert data convert ...
@@ -27,6 +27,9 @@ OPTIONS for 'convert'
 --to-ctf::
 	Triggers the CTF conversion, specify the path of CTF data directory.
 
+--to-json::
+	Triggers JSON conversion. Specify the JSON filename to output.
+
 --tod::
 	Convert time to wall clock time.
 
diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
index 8d23b8d6ee8e..15ca23675ef0 100644
--- a/tools/perf/builtin-data.c
+++ b/tools/perf/builtin-data.c
@@ -7,7 +7,6 @@
 #include "debug.h"
 #include <subcmd/parse-options.h>
 #include "data-convert.h"
-#include "data-convert-bt.h"
 
 typedef int (*data_cmd_fn_t)(int argc, const char **argv);
 
@@ -55,7 +54,8 @@ static const char * const data_convert_usage[] = {
 
 static int cmd_data_convert(int argc, const char **argv)
 {
-	const char *to_ctf     = NULL;
+	const char *to_json = NULL;
+	const char *to_ctf = NULL;
 	struct perf_data_convert_opts opts = {
 		.force = false,
 		.all = false,
@@ -63,6 +63,7 @@ static int cmd_data_convert(int argc, const char **argv)
 	const struct option options[] = {
 		OPT_INCR('v', "verbose", &verbose, "be more verbose"),
 		OPT_STRING('i', "input", &input_name, "file", "input file name"),
+		OPT_STRING(0, "to-json", &to_json, NULL, "Convert to JSON format"),
 #ifdef HAVE_LIBBABELTRACE_SUPPORT
 		OPT_STRING(0, "to-ctf", &to_ctf, NULL, "Convert to CTF format"),
 		OPT_BOOLEAN(0, "tod", &opts.tod, "Convert time to wall clock time"),
@@ -72,11 +73,6 @@ static int cmd_data_convert(int argc, const char **argv)
 		OPT_END()
 	};
 
-#ifndef HAVE_LIBBABELTRACE_SUPPORT
-	pr_err("No conversion support compiled in. perf should be compiled with environment variables LIBBABELTRACE=1 and LIBBABELTRACE_DIR=/path/to/libbabeltrace/\n");
-	return -1;
-#endif
-
 	argc = parse_options(argc, argv, options,
 			     data_convert_usage, 0);
 	if (argc) {
@@ -84,11 +80,25 @@ static int cmd_data_convert(int argc, const char **argv)
 		return -1;
 	}
 
+	if (to_json && to_ctf) {
+		pr_err("You cannot specify both --to-ctf and --to-json.\n");
+		return -1;
+	}
+	if (!to_json && !to_ctf) {
+		pr_err("You must specify one of --to-ctf or --to-json.\n");
+		return -1;
+	}
+
+	if (to_json)
+		return bt_convert__perf2json(input_name, to_json, &opts);
+
 	if (to_ctf) {
 #ifdef HAVE_LIBBABELTRACE_SUPPORT
 		return bt_convert__perf2ctf(input_name, to_ctf, &opts);
 #else
-		pr_err("The libbabeltrace support is not compiled in.\n");
+		pr_err("The libbabeltrace support is not compiled in. perf should be "
+		       "compiled with environment variables LIBBABELTRACE=1 and "
+		       "LIBBABELTRACE_DIR=/path/to/libbabeltrace/\n");
 		return -1;
 #endif
 	}
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index e2563d0154eb..de9ac182b25a 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -163,6 +163,7 @@ perf-$(CONFIG_LIBUNWIND_X86)      += libunwind/x86_32.o
 perf-$(CONFIG_LIBUNWIND_AARCH64)  += libunwind/arm64.o
 
 perf-$(CONFIG_LIBBABELTRACE) += data-convert-bt.o
+perf-y += data-convert-json.o
 
 perf-y += scripting-engines/
 
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 27c5fef9ad54..803102207a8b 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -21,7 +21,7 @@
 #include <babeltrace/ctf/events.h>
 #include <traceevent/event-parse.h>
 #include "asm/bug.h"
-#include "data-convert-bt.h"
+#include "data-convert.h"
 #include "session.h"
 #include "debug.h"
 #include "tool.h"
diff --git a/tools/perf/util/data-convert-bt.h b/tools/perf/util/data-convert-bt.h
deleted file mode 100644
index 821674d63c4e..000000000000
--- a/tools/perf/util/data-convert-bt.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __DATA_CONVERT_BT_H
-#define __DATA_CONVERT_BT_H
-#include "data-convert.h"
-#ifdef HAVE_LIBBABELTRACE_SUPPORT
-
-int bt_convert__perf2ctf(const char *input_name, const char *to_ctf,
-			 struct perf_data_convert_opts *opts);
-
-#endif /* HAVE_LIBBABELTRACE_SUPPORT */
-#endif /* __DATA_CONVERT_BT_H */
diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
new file mode 100644
index 000000000000..73f22c1b28ce
--- /dev/null
+++ b/tools/perf/util/data-convert-json.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * JSON export.
+ *
+ * Copyright (C) 2021, CodeWeavers Inc. <nfraser@codeweavers.com>
+ */
+
+#include "data-convert.h"
+
+#include <fcntl.h>
+#include <inttypes.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "linux/compiler.h"
+#include "linux/err.h"
+#include "util/auxtrace.h"
+#include "util/debug.h"
+#include "util/dso.h"
+#include "util/event.h"
+#include "util/evsel.h"
+#include "util/header.h"
+#include "util/map.h"
+#include "util/session.h"
+#include "util/symbol.h"
+#include "util/thread.h"
+#include "util/tool.h"
+
+struct convert_json {
+	struct perf_tool tool;
+	FILE *out;
+	bool first;
+};
+
+static void output_json_string(FILE *out, const char *s)
+{
+	fputc('"', out);
+	while (*s) {
+		switch (*s) {
+
+		// required escapes with special forms as per RFC 8259
+		case '"':  fputs("\\\"", out); break;
+		case '\\': fputs("\\\\", out); break;
+		case '\b': fputs("\\b", out);  break;
+		case '\f': fputs("\\f", out);  break;
+		case '\n': fputs("\\n", out);  break;
+		case '\r': fputs("\\r", out);  break;
+		case '\t': fputs("\\t", out);  break;
+
+		default:
+			// all other control characters must be escaped by hex code
+			if (*s <= 0x1f)
+				fprintf(out, "\\u%04x", *s);
+			else
+				fputc(*s, out);
+			break;
+		}
+
+		++s;
+	}
+	fputc('"', out);
+}
+
+static void output_sample_callchain_entry(struct perf_tool *tool,
+		u64 ip, struct addr_location *al)
+{
+	struct convert_json *c = container_of(tool, struct convert_json, tool);
+	FILE *out = c->out;
+
+	fprintf(out, "\n\t\t\t\t{");
+	fprintf(out, "\n\t\t\t\t\t\"ip\": \"0x%" PRIx64 "\"", ip);
+
+	if (al && al->sym && al->sym->name && strlen(al->sym->name) > 0) {
+		fprintf(out, ",\n\t\t\t\t\t\"symbol\": ");
+		output_json_string(out, al->sym->name);
+
+		if (al->map && al->map->dso) {
+			const char *dso = al->map->dso->short_name;
+
+			if (dso && strlen(dso) > 0) {
+				fprintf(out, ",\n\t\t\t\t\t\"dso\": ");
+				output_json_string(out, dso);
+			}
+		}
+	}
+
+	fprintf(out, "\n\t\t\t\t}");
+}
+
+static int process_sample_event(struct perf_tool *tool,
+				union perf_event *event __maybe_unused,
+				struct perf_sample *sample,
+				struct evsel *evsel __maybe_unused,
+				struct machine *machine)
+{
+	struct convert_json *c = container_of(tool, struct convert_json, tool);
+	FILE *out = c->out;
+	struct addr_location al, tal;
+	u8 cpumode = PERF_RECORD_MISC_USER;
+
+	if (machine__resolve(machine, &al, sample) < 0) {
+		pr_err("Sample resolution failed!\n");
+		return -1;
+	}
+
+	if (c->first)
+		c->first = false;
+	else
+		fputc(',', out);
+	fprintf(out, "\n\t\t{");
+
+	fprintf(out, "\n\t\t\t\"timestamp\": %" PRIi64, sample->time);
+	fprintf(out, ",\n\t\t\t\"pid\": %i", al.thread->pid_);
+	fprintf(out, ",\n\t\t\t\"tid\": %i", al.thread->tid);
+
+	if (al.thread->cpu >= 0)
+		fprintf(out, ",\n\t\t\t\"cpu\": %i", al.thread->cpu);
+
+	fprintf(out, ",\n\t\t\t\"comm\": ");
+	output_json_string(out, thread__comm_str(al.thread));
+
+	fprintf(out, ",\n\t\t\t\"callchain\": [");
+	if (sample->callchain) {
+		unsigned int i;
+		bool ok;
+		bool first_callchain = true;
+
+		for (i = 0; i < sample->callchain->nr; ++i) {
+			u64 ip = sample->callchain->ips[i];
+
+			if (ip >= PERF_CONTEXT_MAX) {
+				switch (ip) {
+				case PERF_CONTEXT_HV:
+					cpumode = PERF_RECORD_MISC_HYPERVISOR;
+					break;
+				case PERF_CONTEXT_KERNEL:
+					cpumode = PERF_RECORD_MISC_KERNEL;
+					break;
+				case PERF_CONTEXT_USER:
+					cpumode = PERF_RECORD_MISC_USER;
+					break;
+				default:
+					pr_debug("invalid callchain context: %"
+							PRId64 "\n", (s64) ip);
+					break;
+				}
+				continue;
+			}
+
+			if (first_callchain)
+				first_callchain = false;
+			else
+				fputc(',', out);
+
+			ok = thread__find_symbol(al.thread, cpumode, ip, &tal);
+			output_sample_callchain_entry(tool, ip, ok ? &tal : NULL);
+		}
+	} else {
+		output_sample_callchain_entry(tool, sample->ip, &al);
+	}
+	fprintf(out, "\n\t\t\t]");
+
+	fprintf(out, "\n\t\t}");
+	return 0;
+}
+
+static void output_headers(struct perf_session *session, struct convert_json *c)
+{
+	struct stat st;
+	struct perf_header *header = &session->header;
+	int ret;
+	int fd = perf_data__fd(session->data);
+	int i;
+	bool first;
+
+	fprintf(c->out, "\n\t\t\t\"header-version\": %u", header->version);
+
+	ret = fstat(fd, &st);
+	if (ret >= 0) {
+		time_t stctime = st.st_mtime;
+		char buf[256];
+
+		strftime(buf, sizeof(buf), "%FT%TZ", gmtime(&stctime));
+		fprintf(c->out, ",\n\t\t\t\"captured-on\": \"%s\"", buf);
+	} else {
+		pr_debug("Failed to get mtime of source file, not writing \"captured-on\"");
+	}
+
+	fprintf(c->out, ",\n\t\t\t\"data-offset\": %" PRIu64, header->data_offset);
+	fprintf(c->out, ",\n\t\t\t\"data-size\": %" PRIu64, header->data_size);
+	fprintf(c->out, ",\n\t\t\t\"feat-offset\": %" PRIu64, header->feat_offset);
+
+	fputs(",\n\t\t\t\"hostname\": ", c->out);
+	output_json_string(c->out, header->env.hostname);
+	fputs(",\n\t\t\t\"os-release\": ", c->out);
+	output_json_string(c->out, header->env.os_release);
+	fputs(",\n\t\t\t\"arch\": ", c->out);
+	output_json_string(c->out, header->env.arch);
+
+	fputs(",\n\t\t\t\"cpu-desc\": ", c->out);
+	output_json_string(c->out, header->env.cpu_desc);
+	fputs(",\n\t\t\t\"cpuid\": ", c->out);
+	output_json_string(c->out, header->env.cpuid);
+	fprintf(c->out, ",\n\t\t\t\"nrcpus-online\": %u", header->env.nr_cpus_online);
+	fprintf(c->out, ",\n\t\t\t\"nrcpus-avail\": %u", header->env.nr_cpus_avail);
+
+	fputs(",\n\t\t\t\"perf-version\": ", c->out);
+	output_json_string(c->out, header->env.version);
+
+	fputs(",\n\t\t\t\"cmdline\": [", c->out);
+	first = true;
+	for (i = 0; i < header->env.nr_cmdline; i++) {
+		if (first)
+			first = false;
+		else
+			fputc(',', c->out);
+		fputs("\n\t\t\t\t", c->out);
+		output_json_string(c->out, header->env.cmdline_argv[i]);
+	}
+	fputs("\n\t\t\t]", c->out);
+}
+
+int bt_convert__perf2json(const char *input_name, const char *output_name,
+			 struct perf_data_convert_opts *opts __maybe_unused)
+{
+	struct perf_session *session;
+	int fd;
+
+	struct convert_json c = {
+		.tool = {
+			.sample         = process_sample_event,
+			.mmap           = perf_event__process_mmap,
+			.mmap2          = perf_event__process_mmap2,
+			.comm           = perf_event__process_comm,
+			.namespaces     = perf_event__process_namespaces,
+			.cgroup         = perf_event__process_cgroup,
+			.exit           = perf_event__process_exit,
+			.fork           = perf_event__process_fork,
+			.lost           = perf_event__process_lost,
+			.tracing_data   = perf_event__process_tracing_data,
+			.build_id       = perf_event__process_build_id,
+			.id_index       = perf_event__process_id_index,
+			.auxtrace_info  = perf_event__process_auxtrace_info,
+			.auxtrace       = perf_event__process_auxtrace,
+			.event_update   = perf_event__process_event_update,
+			.ordered_events = true,
+			.ordering_requires_timestamps = true,
+		},
+		.first = true,
+	};
+
+	struct perf_data data = {
+		.mode = PERF_DATA_MODE_READ,
+		.path = input_name,
+		.force = opts->force,
+	};
+
+	if (opts->all) {
+		pr_err("--all is currently unsupported for JSON output.\n");
+		return -1;
+	}
+	if (opts->tod) {
+		pr_err("--tod is currently unsupported for JSON output.\n");
+		return -1;
+	}
+
+	fd = open(output_name, O_CREAT | O_WRONLY | (opts->force ? 0 : O_EXCL), 0666);
+	if (fd == -1) {
+		if (errno == EEXIST)
+			pr_err("Output file exists. Use --force to overwrite it.\n");
+		else
+			pr_err("Error opening output file!\n");
+		return -1;
+	}
+
+	c.out = fdopen(fd, "w");
+	if (!c.out) {
+		fprintf(stderr, "Error opening output file!\n");
+		return -1;
+	}
+
+	session = perf_session__new(&data, false, &c.tool);
+	if (IS_ERR(session)) {
+		fprintf(stderr, "Error creating perf session!\n");
+		return -1;
+	}
+
+	if (symbol__init(&session->header.env) < 0) {
+		fprintf(stderr, "Symbol init error!\n");
+		return -1;
+	}
+
+	// Version number for future-proofing. Most additions should be able to be
+	// done in a backwards-compatible way so this should only need to be bumped
+	// if some major breaking change must be made.
+	fprintf(c.out, "{\n\t\"linux-perf-json-version\": 1,");
+
+	// Output headers
+	fprintf(c.out, "\n\t\"headers\": {");
+	output_headers(session, &c);
+	fprintf(c.out, "\n\t},");
+
+	// Output samples
+	fprintf(c.out, "\n\t\"samples\": [");
+	perf_session__process_events(session);
+	fprintf(c.out, "\n\t]\n}\n");
+
+	perf_session__delete(session);
+	return 0;
+}
diff --git a/tools/perf/util/data-convert.h b/tools/perf/util/data-convert.h
index feab5f114e37..1b4c5f598415 100644
--- a/tools/perf/util/data-convert.h
+++ b/tools/perf/util/data-convert.h
@@ -2,10 +2,20 @@
 #ifndef __DATA_CONVERT_H
 #define __DATA_CONVERT_H
 
+#include <stdbool.h>
+
 struct perf_data_convert_opts {
 	bool force;
 	bool all;
 	bool tod;
 };
 
+#ifdef HAVE_LIBBABELTRACE_SUPPORT
+int bt_convert__perf2ctf(const char *input_name, const char *to_ctf,
+			 struct perf_data_convert_opts *opts);
+#endif /* HAVE_LIBBABELTRACE_SUPPORT */
+
+int bt_convert__perf2json(const char *input_name, const char *to_ctf,
+			 struct perf_data_convert_opts *opts);
+
 #endif /* __DATA_CONVERT_H */
-- 
2.31.0


