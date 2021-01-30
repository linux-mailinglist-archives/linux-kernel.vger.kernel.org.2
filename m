Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642183098F7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 00:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhA3Xvk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 30 Jan 2021 18:51:40 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:52012 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232532AbhA3XuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 18:50:23 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-0e_YwsMBObqCes-AavboFw-1; Sat, 30 Jan 2021 18:49:07 -0500
X-MC-Unique: 0e_YwsMBObqCes-AavboFw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6399D18B6126;
        Sat, 30 Jan 2021 23:49:05 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46FA8614ED;
        Sat, 30 Jan 2021 23:49:01 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: [PATCH 01/24] perf daemon: Add daemon command
Date:   Sun, 31 Jan 2021 00:48:33 +0100
Message-Id: <20210130234856.271282-2-jolsa@kernel.org>
In-Reply-To: <20210130234856.271282-1-jolsa@kernel.org>
References: <20210129134855.195810-1-jolsa@redhat.com>
 <20210130234856.271282-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding daemon skeleton with minimal base (non) functionality,
covering various setup in start command.

Adding empty perf-daemon.txt to skip compile warning. All the
features and man page are coming in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Build                         |  1 +
 tools/perf/Documentation/perf-daemon.txt |  0
 tools/perf/builtin-daemon.c              | 86 ++++++++++++++++++++++++
 tools/perf/builtin.h                     |  1 +
 tools/perf/command-list.txt              |  1 +
 tools/perf/perf.c                        |  1 +
 6 files changed, 90 insertions(+)
 create mode 100644 tools/perf/Documentation/perf-daemon.txt
 create mode 100644 tools/perf/builtin-daemon.c

diff --git a/tools/perf/Build b/tools/perf/Build
index 5f392dbb88fc..db61dbe2b543 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -24,6 +24,7 @@ perf-y += builtin-mem.o
 perf-y += builtin-data.o
 perf-y += builtin-version.o
 perf-y += builtin-c2c.o
+perf-y += builtin-daemon.o
 
 perf-$(CONFIG_TRACE) += builtin-trace.o
 perf-$(CONFIG_LIBELF) += builtin-probe.o
diff --git a/tools/perf/Documentation/perf-daemon.txt b/tools/perf/Documentation/perf-daemon.txt
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
new file mode 100644
index 000000000000..8b13e455ac40
--- /dev/null
+++ b/tools/perf/builtin-daemon.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <subcmd/parse-options.h>
+#include <linux/limits.h>
+#include <string.h>
+#include <signal.h>
+#include <stdio.h>
+#include <unistd.h>
+#include "builtin.h"
+#include "perf.h"
+#include "debug.h"
+#include "util.h"
+
+struct daemon {
+	char			*base;
+	FILE			*out;
+	char			 perf[PATH_MAX];
+};
+
+static struct daemon __daemon = { };
+
+static const char * const daemon_usage[] = {
+	"perf daemon start [<options>]",
+	"perf daemon [<options>]",
+	NULL
+};
+
+static bool done;
+
+static void sig_handler(int sig __maybe_unused)
+{
+	done = true;
+}
+
+static int __cmd_start(struct daemon *daemon, struct option parent_options[],
+		       int argc, const char **argv)
+{
+	struct option start_options[] = {
+		OPT_PARENT(parent_options),
+		OPT_END()
+	};
+	int err = 0;
+
+	argc = parse_options(argc, argv, start_options, daemon_usage, 0);
+	if (argc)
+		usage_with_options(daemon_usage, start_options);
+
+	debug_set_file(daemon->out);
+	debug_set_display_time(true);
+
+	pr_info("daemon started (pid %d)\n", getpid());
+
+	signal(SIGINT, sig_handler);
+	signal(SIGTERM, sig_handler);
+
+	while (!done && !err) {
+		sleep(1);
+	}
+
+	pr_info("daemon exited\n");
+	fclose(daemon->out);
+	return err;
+}
+
+int cmd_daemon(int argc, const char **argv)
+{
+	struct option daemon_options[] = {
+		OPT_INCR('v', "verbose", &verbose, "be more verbose"),
+		OPT_END()
+	};
+
+	perf_exe(__daemon.perf, sizeof(__daemon.perf));
+	__daemon.out = stdout;
+
+	argc = parse_options(argc, argv, daemon_options, daemon_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (argc) {
+		if (!strcmp(argv[0], "start"))
+			return __cmd_start(&__daemon, daemon_options, argc, argv);
+
+		pr_err("failed: unknown command '%s'\n", argv[0]);
+		return -1;
+	}
+
+	return -1;
+}
diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
index 14a2db622a7b..7303e80a639c 100644
--- a/tools/perf/builtin.h
+++ b/tools/perf/builtin.h
@@ -37,6 +37,7 @@ int cmd_inject(int argc, const char **argv);
 int cmd_mem(int argc, const char **argv);
 int cmd_data(int argc, const char **argv);
 int cmd_ftrace(int argc, const char **argv);
+int cmd_daemon(int argc, const char **argv);
 
 int find_scripts(char **scripts_array, char **scripts_path_array, int num,
 		 int pathlen);
diff --git a/tools/perf/command-list.txt b/tools/perf/command-list.txt
index bc6c585f74fc..825a12e8d694 100644
--- a/tools/perf/command-list.txt
+++ b/tools/perf/command-list.txt
@@ -31,3 +31,4 @@ perf-timechart			mainporcelain common
 perf-top			mainporcelain common
 perf-trace			mainporcelain audit
 perf-version			mainporcelain common
+perf-daemon			mainporcelain common
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 27f94b0bb874..20cb91ef06ff 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -88,6 +88,7 @@ static struct cmd_struct commands[] = {
 	{ "mem",	cmd_mem,	0 },
 	{ "data",	cmd_data,	0 },
 	{ "ftrace",	cmd_ftrace,	0 },
+	{ "daemon",	cmd_daemon,	0 },
 };
 
 struct pager_config {
-- 
2.29.2

