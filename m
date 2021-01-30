Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D06530991C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 00:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhA3X7Q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 30 Jan 2021 18:59:16 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:44845 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232556AbhA3Xub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 18:50:31 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-GYGA01hhOAaAzHhDuxeWMA-1; Sat, 30 Jan 2021 18:49:24 -0500
X-MC-Unique: GYGA01hhOAaAzHhDuxeWMA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65B11911B3;
        Sat, 30 Jan 2021 23:49:22 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCFED60DA0;
        Sat, 30 Jan 2021 23:49:19 +0000 (UTC)
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
Subject: [PATCH 07/24] perf daemon: Add config file change check
Date:   Sun, 31 Jan 2021 00:48:39 +0100
Message-Id: <20210130234856.271282-8-jolsa@kernel.org>
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

Adding support to detect daemon's config file changes
and re-read the configuration when that happens.

Using inotify file descriptor pluged into the main
fdarray object for polling.

Example:

  # cat ~/.perfconfig
  [daemon]
  base=/opt/perfdata

  [session-cycles]
  run = -m 10M -e cycles --overwrite --switch-output -a

Starting the daemon:

  # perf daemon start

Check sessions:

  # perf daemon
  [772262:daemon] base: /opt/perfdata
  [772263:cycles] perf record -m 10M -e cycles --overwrite --switch-output -a

Change '-m 10M' to '-m 20M', and check daemon log:

  # tail -f /opt/perfdata/output
  [2021-01-02 20:31:41.234045] daemon started (pid 772262)
  [2021-01-02 20:31:41.235072] reconfig: ruining session [cycles:772263]: -m 10M -e cycles --overwrite --switch-output -a
  [2021-01-02 20:32:08.310137] reconfig: session 'cycles' killed
  [2021-01-02 20:32:08.310847] reconfig: ruining session [cycles:772338]: -m 20M -e cycles --overwrite --switch-output -a

And the session list:

  # perf daemon
  [772262:daemon] base: /opt/perfdata
  [772338:cycles] perf record -m 20M -e cycles --overwrite --switch-output -a

Note the changed '-m 20M' option is in place.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 99 +++++++++++++++++++++++++++++++++++--
 1 file changed, 96 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index be2ade9967b3..d0a0a998e073 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -10,6 +10,8 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <errno.h>
+#include <sys/inotify.h>
+#include <libgen.h>
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/un.h>
@@ -73,6 +75,7 @@ struct session {
 struct daemon {
 	const char		*config;
 	char			*config_real;
+	char			*config_base;
 	const char		*base_user;
 	char			*base;
 	struct list_head	 sessions;
@@ -493,6 +496,7 @@ static void daemon__free(struct daemon *daemon)
 		session__remove(session);
 
 	free(daemon->config_real);
+	free(daemon->config_base);
 	free(daemon->base);
 }
 
@@ -535,6 +539,83 @@ static int daemon__reconfig(struct daemon *daemon)
 	return 0;
 }
 
+static int setup_config_changes(struct daemon *daemon)
+{
+	char *basen = strdup(daemon->config_real);
+	char *dirn  = strdup(daemon->config_real);
+	char *base, *dir;
+	int fd, wd;
+
+	if (!dirn || !basen)
+		return -ENOMEM;
+
+	fd = inotify_init1(IN_NONBLOCK|O_CLOEXEC);
+	if (fd < 0) {
+		perror("failed: inotify_init");
+		return -1;
+	}
+
+	dir = dirname(dirn);
+	base = basename(basen);
+	pr_debug("config file: %s, dir: %s\n", base, dir);
+
+	wd = inotify_add_watch(fd, dir, IN_CLOSE_WRITE);
+	if (wd >= 0) {
+		daemon->config_base = strdup(base);
+		if (!daemon->config_base) {
+			close(fd);
+			wd = -1;
+		}
+	} else {
+		perror("failed: inotify_add_watch");
+	}
+
+	free(basen);
+	free(dirn);
+	return wd < 0 ? -1 : fd;
+}
+
+static bool process_inotify_event(struct daemon *daemon, char *buf, ssize_t len)
+{
+	char *p = buf;
+
+	while (p < (buf + len)) {
+		struct inotify_event *event = (struct inotify_event *) p;
+
+		/*
+		 * We monitor config directory, check if our
+		 * config file was changes.
+		 */
+		if ((event->mask & IN_CLOSE_WRITE) &&
+		    !(event->mask & IN_ISDIR)) {
+			if (!strcmp(event->name, daemon->config_base))
+				return true;
+		}
+		p += sizeof(*event) + event->len;
+	}
+	return false;
+}
+
+static int handle_config_changes(struct daemon *daemon, int conf_fd,
+				 bool *config_changed)
+{
+	char buf[4096];
+	ssize_t len;
+
+	while (!(*config_changed)) {
+		len = read(conf_fd, buf, sizeof(buf));
+		if (len == -1) {
+			if (errno != EAGAIN) {
+				perror("failed: read");
+				return -1;
+			}
+			return 0;
+		}
+		*config_changed = process_inotify_event(daemon, buf, len);
+	}
+	return 0;
+}
+
 static int setup_config(struct daemon *daemon)
 {
 	if (daemon->base_user) {
@@ -569,8 +650,8 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 		OPT_PARENT(parent_options),
 		OPT_END()
 	};
-	int sock_fd = -1;
-	int sock_pos;
+	int sock_fd = -1, conf_fd = -1;
+	int sock_pos, file_pos;
 	struct fdarray fda;
 	int err = 0;
 
@@ -591,16 +672,24 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 
 	pr_info("daemon started (pid %d)\n", getpid());
 
-	fdarray__init(&fda, 1);
+	fdarray__init(&fda, 2);
 
 	sock_fd = setup_server_socket(daemon);
 	if (sock_fd < 0)
 		goto out;
 
+	conf_fd = setup_config_changes(daemon);
+	if (conf_fd < 0)
+		goto out;
+
 	sock_pos = fdarray__add(&fda, sock_fd, POLLIN|POLLERR|POLLHUP, 0);
 	if (sock_pos < 0)
 		goto out;
 
+	file_pos = fdarray__add(&fda, conf_fd, POLLIN|POLLERR|POLLHUP, 0);
+	if (file_pos < 0)
+		goto out;
+
 	signal(SIGINT, sig_handler);
 	signal(SIGTERM, sig_handler);
 
@@ -612,6 +701,8 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 
 			if (fda.entries[sock_pos].revents & POLLIN)
 				err = handle_server_socket(daemon, sock_fd);
+			if (fda.entries[file_pos].revents & POLLIN)
+				err = handle_config_changes(daemon, conf_fd, &reconfig);
 
 			if (reconfig)
 				err = setup_server_config(daemon);
@@ -625,6 +716,8 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 
 	if (sock_fd != -1)
 		close(sock_fd);
+	if (conf_fd != -1)
+		close(conf_fd);
 
 	pr_info("daemon exited\n");
 	fclose(daemon->out);
-- 
2.29.2

