Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9444314154
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbhBHVK0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 Feb 2021 16:10:26 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:41186 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236625AbhBHUKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:10:19 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-yb2a3I5pOryEHcePFiHNIw-1; Mon, 08 Feb 2021 15:09:24 -0500
X-MC-Unique: yb2a3I5pOryEHcePFiHNIw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DA416D4E0;
        Mon,  8 Feb 2021 20:09:22 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F91019C59;
        Mon,  8 Feb 2021 20:09:20 +0000 (UTC)
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
        Alexei Budankov <abudankov@huawei.com>
Subject: [PATCH 04/24] perf daemon: Add server socket support
Date:   Mon,  8 Feb 2021 21:08:48 +0100
Message-Id: <20210208200908.1019149-5-jolsa@kernel.org>
In-Reply-To: <20210208200908.1019149-1-jolsa@kernel.org>
References: <20210208200908.1019149-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to create server socket that listens for client
commands and process them.

This patch adds only the core support, all commands using
this functionality are coming in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 117 +++++++++++++++++++++++++++++++++++-
 1 file changed, 116 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index ce0373f453d6..495e4ff120ed 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -1,12 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <internal/lib.h>
 #include <subcmd/parse-options.h>
+#include <api/fd/array.h>
 #include <linux/limits.h>
+#include <linux/string.h>
 #include <string.h>
 #include <signal.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <errno.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <poll.h>
 #include "builtin.h"
 #include "perf.h"
 #include "debug.h"
@@ -37,6 +44,92 @@ static void sig_handler(int sig __maybe_unused)
 	done = true;
 }
 
+static int setup_server_socket(struct daemon *daemon)
+{
+	struct sockaddr_un addr;
+	char path[PATH_MAX];
+	int fd = socket(AF_UNIX, SOCK_STREAM, 0);
+
+	if (fd < 0) {
+		fprintf(stderr, "socket: %s\n", strerror(errno));
+		return -1;
+	}
+
+	if (fcntl(fd, F_SETFD, FD_CLOEXEC)) {
+		perror("failed: fcntl FD_CLOEXEC");
+		close(fd);
+		return -1;
+	}
+
+	scnprintf(path, sizeof(path), "%s/control", daemon->base);
+
+	if (strlen(path) + 1 >= sizeof(addr.sun_path)) {
+		pr_err("failed: control path too long '%s'\n", path);
+		close(fd);
+		return -1;
+	}
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+
+	strlcpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
+	unlink(path);
+
+	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) == -1) {
+		perror("failed: bind");
+		close(fd);
+		return -1;
+	}
+
+	if (listen(fd, 1) == -1) {
+		perror("failed: listen");
+		close(fd);
+		return -1;
+	}
+
+	return fd;
+}
+
+union cmd {
+	int cmd;
+};
+
+static int handle_server_socket(struct daemon *daemon __maybe_unused, int sock_fd)
+{
+	int ret = -1, fd;
+	FILE *out = NULL;
+	union cmd cmd;
+
+	fd = accept(sock_fd, NULL, NULL);
+	if (fd < 0) {
+		perror("failed: accept");
+		return -1;
+	}
+
+	if (sizeof(cmd) != readn(fd, &cmd, sizeof(cmd))) {
+		perror("failed: read");
+		goto out;
+	}
+
+	out = fdopen(fd, "w");
+	if (!out) {
+		perror("failed: fdopen");
+		goto out;
+	}
+
+	switch (cmd.cmd) {
+	default:
+		break;
+	}
+
+	fclose(out);
+out:
+	/* If out is defined, then fd is closed via fclose. */
+	if (!out)
+		close(fd);
+	return ret;
+}
+
 static void daemon__exit(struct daemon *daemon)
 {
 	free(daemon->config_real);
@@ -77,6 +170,9 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 		OPT_PARENT(parent_options),
 		OPT_END()
 	};
+	int sock_fd = -1;
+	int sock_pos;
+	struct fdarray fda;
 	int err = 0;
 
 	argc = parse_options(argc, argv, start_options, daemon_usage, 0);
@@ -93,15 +189,34 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 
 	pr_info("daemon started (pid %d)\n", getpid());
 
+	fdarray__init(&fda, 1);
+
+	sock_fd = setup_server_socket(daemon);
+	if (sock_fd < 0)
+		goto out;
+
+	sock_pos = fdarray__add(&fda, sock_fd, POLLIN|POLLERR|POLLHUP, 0);
+	if (sock_pos < 0)
+		goto out;
+
 	signal(SIGINT, sig_handler);
 	signal(SIGTERM, sig_handler);
 
 	while (!done && !err) {
-		sleep(1);
+		if (fdarray__poll(&fda, -1)) {
+			if (fda.entries[sock_pos].revents & POLLIN)
+				err = handle_server_socket(daemon, sock_fd);
+		}
 	}
 
+out:
+	fdarray__exit(&fda);
+
 	daemon__exit(daemon);
 
+	if (sock_fd != -1)
+		close(sock_fd);
+
 	pr_info("daemon exited\n");
 	fclose(daemon->out);
 	return err;
-- 
2.29.2

