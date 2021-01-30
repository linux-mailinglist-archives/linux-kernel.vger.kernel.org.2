Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5143730991B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 00:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbhA3X6w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 30 Jan 2021 18:58:52 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:27042 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232543AbhA3Xub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 18:50:31 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-YruhqxhfO4SpN9anXDGgoA-1; Sat, 30 Jan 2021 18:49:15 -0500
X-MC-Unique: YruhqxhfO4SpN9anXDGgoA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F06D5803620;
        Sat, 30 Jan 2021 23:49:13 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89CCC60DA0;
        Sat, 30 Jan 2021 23:49:11 +0000 (UTC)
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
Subject: [PATCH 04/24] perf daemon: Add server socket support
Date:   Sun, 31 Jan 2021 00:48:36 +0100
Message-Id: <20210130234856.271282-5-jolsa@kernel.org>
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

Add support to create server socket that listens for client
commands and process them.

This patch adds only the core support, all commands using
this functionality are coming in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 101 +++++++++++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 8d0ac44ec808..756d60616d7d 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <subcmd/parse-options.h>
+#include <api/fd/array.h>
 #include <linux/limits.h>
 #include <string.h>
 #include <signal.h>
@@ -7,6 +8,10 @@
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
@@ -37,6 +42,78 @@ static void sig_handler(int sig __maybe_unused)
 	done = true;
 }
 
+static int setup_server_socket(struct daemon *daemon)
+{
+	struct sockaddr_un addr;
+	char path[100];
+	int fd;
+
+	fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (fd < 0) {
+		fprintf(stderr, "socket: %s\n", strerror(errno));
+		return -1;
+	}
+
+	fcntl(fd, F_SETFD, FD_CLOEXEC);
+
+	scnprintf(path, PATH_MAX, "%s/control", daemon->base);
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+
+	strncpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
+	unlink(path);
+
+	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) == -1) {
+		perror("failed: bind");
+		return -1;
+	}
+
+	if (listen(fd, 1) == -1) {
+		perror("failed: listen");
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
+	int ret = -EINVAL, fd;
+	union cmd cmd;
+	FILE *out;
+
+	fd = accept(sock_fd, NULL, NULL);
+	if (fd < 0) {
+		fprintf(stderr, "accept: %s\n", strerror(errno));
+		return -1;
+	}
+
+	if (sizeof(cmd) != read(fd, &cmd, sizeof(cmd))) {
+		fprintf(stderr, "read: %s\n", strerror(errno));
+		return -1;
+	}
+
+	out = fdopen(fd, "w");
+	if (!out) {
+		perror("failed: fdopen");
+		return -1;
+	}
+
+	switch (cmd.cmd) {
+	default:
+		break;
+	}
+
+	fclose(out);
+	close(fd);
+	return ret;
+}
+
 static void daemon__free(struct daemon *daemon)
 {
 	free(daemon->config_real);
@@ -82,6 +159,9 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 		OPT_PARENT(parent_options),
 		OPT_END()
 	};
+	int sock_fd = -1;
+	int sock_pos;
+	struct fdarray fda;
 	int err = 0;
 
 	argc = parse_options(argc, argv, start_options, daemon_usage, 0);
@@ -98,15 +178,34 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 
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

