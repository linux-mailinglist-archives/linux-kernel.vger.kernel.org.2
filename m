Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977C0309914
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 00:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbhA3X5e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 30 Jan 2021 18:57:34 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:45986 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232295AbhA3Xui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 18:50:38 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-QgamZPOlM4i5N5EehMcQ-g-1; Sat, 30 Jan 2021 18:49:40 -0500
X-MC-Unique: QgamZPOlM4i5N5EehMcQ-g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CED1107ACE8;
        Sat, 30 Jan 2021 23:49:39 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B935A6F974;
        Sat, 30 Jan 2021 23:49:36 +0000 (UTC)
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
Subject: [PATCH 13/24] perf daemon: Allow only one daemon over base directory
Date:   Sun, 31 Jan 2021 00:48:45 +0100
Message-Id: <20210130234856.271282-14-jolsa@kernel.org>
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

Add 'lock' file under daemon base and flock it, so only one
perf daemon can run on top of it.

Each daemon tries to create and lock BASE/lock file, if it's
successful we are sure we're the only daemon running over
the BASE.

Once daemon is finished, file descriptor to lock file is
closed and lock is released.

Example:

  # cat ~/.perfconfig
  [daemon]
  base=/opt/perfdata

  [session-cycles]
  run = -m 10M -e cycles --overwrite --switch-output -a

  [session-sched]
  run = -m 20M -e sched:* --overwrite --switch-output -a

Starting the daemon:

  # perf daemon start

And try once more:

  # perf daemon start
  failed: another perf daemon (pid 775594) owns /opt/perfdata

will end up with an error, because there's already one running
on top of /opt/perfdata.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 58 +++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 468ed2af8b3f..4ebeb524b16e 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -1,10 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <subcmd/parse-options.h>
 #include <api/fd/array.h>
+#include <api/fs/fs.h>
 #include <linux/zalloc.h>
 #include <linux/string.h>
 #include <linux/limits.h>
 #include <string.h>
+#include <sys/file.h>
 #include <signal.h>
 #include <stdlib.h>
 #include <time.h>
@@ -529,12 +531,18 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 			/* output */
 			csv_sep, daemon->base, SESSION_OUTPUT);
 
+		fprintf(out, "%c%s/%s",
+			/* lock */
+			csv_sep, daemon->base, "lock");
+
 		fprintf(out, "\n");
 	} else {
 		fprintf(out, "[%d:daemon] base: %s\n", getpid(), daemon->base);
 		if (cmd->list.verbose) {
 			fprintf(out, "  output:  %s/%s\n",
 				daemon->base, SESSION_OUTPUT);
+			fprintf(out, "  lock:    %s/lock\n",
+				daemon->base);
 		}
 	}
 
@@ -864,6 +872,50 @@ static int setup_config(struct daemon *daemon)
 	return daemon->config_real ? 0 : -1;
 }
 
+/*
+ * Each daemon tries to create and lock BASE/lock file,
+ * if it's successful we are sure we're the only daemon
+ * running over the BASE.
+ *
+ * Once daemon is finished, file descriptor to lock file
+ * is closed and lock is released.
+ */
+static int check_lock(struct daemon *daemon)
+{
+	char path[PATH_MAX];
+	char buf[20];
+	int fd, pid;
+	ssize_t len;
+
+	scnprintf(path, sizeof(path), "%s/lock", daemon->base);
+
+	fd = open(path, O_RDWR|O_CREAT|O_CLOEXEC, 0640);
+	if (fd < 0)
+		return -1;
+
+	if (lockf(fd, F_TLOCK, 0) < 0) {
+		filename__read_int(path, &pid);
+		fprintf(stderr, "failed: another perf daemon (pid %d) owns %s\n",
+			pid, daemon->base);
+		return -1;
+	}
+
+	scnprintf(buf, sizeof(buf), "%d", getpid());
+	len = strlen(buf);
+
+	if (write(fd, buf, len) != len) {
+		perror("failed: write");
+		return -1;
+	}
+
+	if (ftruncate(fd, len)) {
+		perror("failed: ftruncate");
+		return -1;
+	}
+
+	return 0;
+}
+
 static int go_background(struct daemon *daemon)
 {
 	int pid, fd;
@@ -878,6 +930,9 @@ static int go_background(struct daemon *daemon)
 	if (setsid() < 0)
 		return -1;
 
+	if (check_lock(daemon))
+		return -1;
+
 	umask(0);
 
 	if (chdir(daemon->base)) {
@@ -946,6 +1001,9 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 	if (setup_server_config(daemon))
 		return -1;
 
+	if (foreground && check_lock(daemon))
+		return -1;
+
 	if (!foreground) {
 		err = go_background(daemon);
 		if (err) {
-- 
2.29.2

