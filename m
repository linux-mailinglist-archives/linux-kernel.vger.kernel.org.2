Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE61131415E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhBHVMK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 Feb 2021 16:12:10 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:23084 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236627AbhBHUKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:10:23 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-Zw6Wzt_xNweLRKVKlItphQ-1; Mon, 08 Feb 2021 15:09:26 -0500
X-MC-Unique: Zw6Wzt_xNweLRKVKlItphQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29B381005501;
        Mon,  8 Feb 2021 20:09:25 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E046D19C59;
        Mon,  8 Feb 2021 20:09:22 +0000 (UTC)
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
Subject: [PATCH 05/24] perf daemon: Add client socket support
Date:   Mon,  8 Feb 2021 21:08:49 +0100
Message-Id: <20210208200908.1019149-6-jolsa@kernel.org>
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

Adding support for client socket side that will be used
to send commands to daemon server socket.

This patch adds only the core support, all commands using
this functionality are coming in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 135 ++++++++++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 495e4ff120ed..e0880c5ee39c 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -13,6 +13,7 @@
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/un.h>
+#include <sys/stat.h>
 #include <poll.h>
 #include "builtin.h"
 #include "perf.h"
@@ -44,6 +45,67 @@ static void sig_handler(int sig __maybe_unused)
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
+		switch (errno) {
+		case EACCES:
+			pr_err("failed: permission denied for '%s' base\n",
+			       daemon->base);
+			return -EACCES;
+		case ENOENT:
+			pr_err("failed: base '%s' does not exists\n",
+			       daemon->base);
+			return -EACCES;
+		default:
+			pr_err("failed: can't access base '%s': %s\n",
+			       daemon->base, strerror(errno));
+			return -errno;
+		}
+	}
+
+	if ((st.st_mode & S_IFMT) != S_IFDIR) {
+		pr_err("failed: base '%s' is not directory\n",
+		       daemon->base);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int setup_client_config(struct daemon *daemon)
+{
+	struct perf_config_set *set = perf_config_set__load_file(daemon->config_real);
+	int err = -ENOMEM;
+
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
@@ -130,6 +192,38 @@ static int handle_server_socket(struct daemon *daemon __maybe_unused, int sock_f
 	return ret;
 }
 
+static int setup_client_socket(struct daemon *daemon)
+{
+	struct sockaddr_un addr;
+	char path[PATH_MAX];
+	int fd = socket(AF_UNIX, SOCK_STREAM, 0);
+
+	if (fd == -1) {
+		perror("failed: socket");
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
+	strlcpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
+
+	if (connect(fd, (struct sockaddr *) &addr, sizeof(addr)) == -1) {
+		perror("failed: connect");
+		close(fd);
+		return -1;
+	}
+
+	return fd;
+}
+
 static void daemon__exit(struct daemon *daemon)
 {
 	free(daemon->config_real);
@@ -222,6 +316,47 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 	return err;
 }
 
+__maybe_unused
+static int send_cmd(struct daemon *daemon, union cmd *cmd)
+{
+	int ret = -1, fd;
+	char *line = NULL;
+	size_t len = 0;
+	ssize_t nread;
+	FILE *in = NULL;
+
+	if (setup_client_config(daemon))
+		return -1;
+
+	fd = setup_client_socket(daemon);
+	if (fd < 0)
+		return -1;
+
+	if (sizeof(*cmd) != writen(fd, cmd, sizeof(*cmd))) {
+		perror("failed: write");
+		goto out;
+	}
+
+	in = fdopen(fd, "r");
+	if (!in) {
+		perror("failed: fdopen");
+		goto out;
+	}
+
+	while ((nread = getline(&line, &len, in)) != -1) {
+		fwrite(line, nread, 1, stdout);
+		fflush(stdout);
+	}
+
+	ret = 0;
+	fclose(in);
+out:
+	/* If in is defined, then fd is closed via fclose. */
+	if (!in)
+		close(fd);
+	return ret;
+}
+
 int cmd_daemon(int argc, const char **argv)
 {
 	struct option daemon_options[] = {
-- 
2.29.2

