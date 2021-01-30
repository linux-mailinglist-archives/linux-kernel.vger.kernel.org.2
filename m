Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE5B309921
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 01:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhA3X7h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 30 Jan 2021 18:59:37 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:52371 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232548AbhA3Xub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 18:50:31 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-2WRfozZ-Of6_I1SwCc8o9g-1; Sat, 30 Jan 2021 18:49:18 -0500
X-MC-Unique: 2WRfozZ-Of6_I1SwCc8o9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C189D10054FF;
        Sat, 30 Jan 2021 23:49:16 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5590960DA0;
        Sat, 30 Jan 2021 23:49:14 +0000 (UTC)
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
Subject: [PATCH 05/24] perf daemon: Add client socket support
Date:   Sun, 31 Jan 2021 00:48:37 +0100
Message-Id: <20210130234856.271282-6-jolsa@kernel.org>
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

Adding support for client socket side that will be used
to send commands to daemon server socket.

This patch adds only the core support, all commands using
this functionality are coming in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 105 ++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 756d60616d7d..eada3ceb9b0c 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -11,6 +11,7 @@
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/un.h>
+#include <sys/stat.h>
 #include <poll.h>
 #include "builtin.h"
 #include "perf.h"
@@ -42,6 +43,50 @@ static void sig_handler(int sig __maybe_unused)
 	done = true;
 }
 
+static int client_config(const char *var, const char *value, void *cb)
+{
+	struct daemon *daemon = cb;
+
+	if (!strcmp(var, "daemon.base") && !daemon->base_user) {
+		daemon->base = strdup(value);
+		if (!daemon->base)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int check_base(struct daemon *daemon)
+{
+	struct stat st;
+
+	if (!daemon->base) {
+		pr_err("failed: base not defined\n");
+		return -EINVAL;
+	}
+
+	if (stat(daemon->base, &st)) {
+		pr_err("failed: base '%s' does not exists\n", daemon->base);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int setup_client_config(struct daemon *daemon)
+{
+	struct perf_config_set *set;
+	int err = -ENOMEM;
+
+	set = perf_config_set__load_file(daemon->config_real);
+	if (set) {
+		err = perf_config_set(set, client_config, daemon);
+		perf_config_set__delete(set);
+	}
+
+	return err ?: check_base(daemon);
+}
+
 static int setup_server_socket(struct daemon *daemon)
 {
 	struct sockaddr_un addr;
@@ -114,6 +159,32 @@ static int handle_server_socket(struct daemon *daemon __maybe_unused, int sock_f
 	return ret;
 }
 
+static int setup_client_socket(struct daemon *daemon)
+{
+	struct sockaddr_un addr;
+	char path[100];
+	int fd;
+
+	fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (fd == -1) {
+		perror("failed: socket");
+		return -1;
+	}
+
+	scnprintf(path, PATH_MAX, "%s/control", daemon->base);
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+	strncpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
+
+	if (connect(fd, (struct sockaddr *) &addr, sizeof(addr)) == -1) {
+		perror("failed: connect");
+		return -1;
+	}
+
+	return fd;
+}
+
 static void daemon__free(struct daemon *daemon)
 {
 	free(daemon->config_real);
@@ -211,6 +282,40 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 	return err;
 }
 
+__maybe_unused
+static int send_cmd(struct daemon *daemon, union cmd *cmd)
+{
+	char *line = NULL;
+	size_t len = 0;
+	ssize_t nread;
+	FILE *in;
+	int fd;
+
+	if (setup_client_config(daemon))
+		return -1;
+
+	fd = setup_client_socket(daemon);
+	if (fd < 0)
+		return -1;
+
+	if (sizeof(*cmd) != write(fd, cmd, sizeof(*cmd)))
+		return -1;
+
+	in = fdopen(fd, "r");
+	if (!in) {
+		perror("failed: fdopen");
+		return -1;
+	}
+
+	while ((nread = getline(&line, &len, in)) != -1) {
+		fwrite(line, nread, 1, stdout);
+		fflush(stdout);
+	}
+
+	fclose(in);
+	return 0;
+}
+
 int cmd_daemon(int argc, const char **argv)
 {
 	struct option daemon_options[] = {
-- 
2.29.2

