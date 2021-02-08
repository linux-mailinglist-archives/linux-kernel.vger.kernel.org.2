Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2FA31416A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbhBHVNY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 Feb 2021 16:13:24 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:35642 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236520AbhBHUKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:10:36 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-S2noU9tHNN235xHlfI8mHg-1; Mon, 08 Feb 2021 15:09:37 -0500
X-MC-Unique: S2noU9tHNN235xHlfI8mHg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACA586D4EE;
        Mon,  8 Feb 2021 20:09:35 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CF0719C59;
        Mon,  8 Feb 2021 20:09:33 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexei Budankov <abudankov@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 09/24] perf daemon: Add signalfd support
Date:   Mon,  8 Feb 2021 21:08:53 +0100
Message-Id: <20210208200908.1019149-10-jolsa@kernel.org>
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

Using signalfd fd for tracking SIGCHLD signals as
notification for perf session termination.

This way we don't need to actively check for child
status, but we are notified if there's change.

Suggested-by: Alexei Budankov <abudankov@huawei.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 161 ++++++++++++++++++++++++++++++++++--
 1 file changed, 155 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 2d7f282809b6..8b834a5d91ff 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <signal.h>
 #include <stdlib.h>
+#include <time.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <errno.h>
@@ -18,6 +19,8 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <sys/stat.h>
+#include <sys/signalfd.h>
+#include <sys/wait.h>
 #include <poll.h>
 #include <sys/stat.h>
 #include "builtin.h"
@@ -83,6 +86,7 @@ struct daemon {
 	struct list_head	 sessions;
 	FILE			*out;
 	char			 perf[PATH_MAX];
+	int			 signal_fd;
 };
 
 static struct daemon __daemon = {
@@ -368,6 +372,116 @@ static int daemon_session__run(struct daemon_session *session,
 	return -1;
 }
 
+static pid_t handle_signalfd(struct daemon *daemon)
+{
+	struct daemon_session *session;
+	struct signalfd_siginfo si;
+	ssize_t err;
+	int status;
+	pid_t pid;
+
+	err = read(daemon->signal_fd, &si, sizeof(struct signalfd_siginfo));
+	if (err != sizeof(struct signalfd_siginfo))
+		return -1;
+
+	list_for_each_entry(session, &daemon->sessions, list) {
+
+		if (session->pid != (int) si.ssi_pid)
+			continue;
+
+		pid = waitpid(session->pid, &status, 0);
+		if (pid == session->pid) {
+			if (WIFEXITED(status)) {
+				pr_info("session '%s' exited, status=%d\n",
+					session->name, WEXITSTATUS(status));
+			} else if (WIFSIGNALED(status)) {
+				pr_info("session '%s' killed (signal %d)\n",
+					session->name, WTERMSIG(status));
+			} else if (WIFSTOPPED(status)) {
+				pr_info("session '%s' stopped (signal %d)\n",
+					session->name, WSTOPSIG(status));
+			} else {
+				pr_info("session '%s' Unexpected status (0x%x)\n",
+					session->name, status);
+			}
+		}
+
+		session->state = KILL;
+		session->pid = -1;
+		return pid;
+	}
+
+	return 0;
+}
+
+static int daemon_session__wait(struct daemon_session *session, struct daemon *daemon,
+				int secs)
+{
+	struct pollfd pollfd = {
+		.fd	= daemon->signal_fd,
+		.events	= POLLIN,
+	};
+	pid_t wpid = 0, pid = session->pid;
+	time_t start;
+
+	start = time(NULL);
+
+	do {
+		int err = poll(&pollfd, 1, 1000);
+
+		if (err > 0) {
+			wpid = handle_signalfd(daemon);
+		} else if (err < 0) {
+			perror("failed: poll\n");
+			return -1;
+		}
+
+		if (start + secs < time(NULL))
+			return -1;
+	} while (wpid != pid);
+
+	return 0;
+}
+
+static bool daemon__has_alive_session(struct daemon *daemon)
+{
+	struct daemon_session *session;
+
+	list_for_each_entry(session, &daemon->sessions, list) {
+		if (session->pid != -1)
+			return true;
+	}
+
+	return false;
+}
+
+static int daemon__wait(struct daemon *daemon, int secs)
+{
+	struct pollfd pollfd = {
+		.fd	= daemon->signal_fd,
+		.events	= POLLIN,
+	};
+	time_t start;
+
+	start = time(NULL);
+
+	do {
+		int err = poll(&pollfd, 1, 1000);
+
+		if (err > 0) {
+			handle_signalfd(daemon);
+		} else if (err < 0) {
+			perror("failed: poll\n");
+			return -1;
+		}
+
+		if (start + secs < time(NULL))
+			return -1;
+	} while (daemon__has_alive_session(daemon));
+
+	return 0;
+}
+
 static int setup_server_socket(struct daemon *daemon)
 {
 	struct sockaddr_un addr;
@@ -493,9 +607,14 @@ static int daemon_session__signal(struct daemon_session *session, int sig)
 	return kill(session->pid, sig);
 }
 
-static void daemon_session__kill(struct daemon_session *session)
+static void daemon_session__kill(struct daemon_session *session,
+				 struct daemon *daemon)
 {
 	daemon_session__signal(session, SIGTERM);
+	if (daemon_session__wait(session, daemon, 10)) {
+		daemon_session__signal(session, SIGKILL);
+		daemon_session__wait(session, daemon, 10);
+	}
 }
 
 static void daemon__signal(struct daemon *daemon, int sig)
@@ -523,6 +642,10 @@ static void daemon_session__remove(struct daemon_session *session)
 static void daemon__kill(struct daemon *daemon)
 {
 	daemon__signal(daemon, SIGTERM);
+	if (daemon__wait(daemon, 10)) {
+		daemon__signal(daemon, SIGKILL);
+		daemon__wait(daemon, 10);
+	}
 }
 
 static void daemon__exit(struct daemon *daemon)
@@ -549,7 +672,7 @@ static int daemon__reconfig(struct daemon *daemon)
 		/* Remove session. */
 		if (session->state == KILL) {
 			if (session->pid > 0) {
-				daemon_session__kill(session);
+				daemon_session__kill(session, daemon);
 				pr_info("reconfig: session '%s' killed\n", session->name);
 			}
 			daemon_session__remove(session);
@@ -558,7 +681,7 @@ static int daemon__reconfig(struct daemon *daemon)
 
 		/* Reconfig session. */
 		if (session->pid > 0) {
-			daemon_session__kill(session);
+			daemon_session__kill(session, daemon);
 			pr_info("reconfig: session '%s' killed\n", session->name);
 		}
 		if (daemon_session__run(session, daemon))
@@ -724,6 +847,20 @@ static int go_background(struct daemon *daemon)
 	return 0;
 }
 
+static int setup_signalfd(struct daemon *daemon)
+{
+	sigset_t mask;
+
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGCHLD);
+
+	if (sigprocmask(SIG_BLOCK, &mask, NULL) == -1)
+		return -1;
+
+	daemon->signal_fd = signalfd(-1, &mask, SFD_NONBLOCK|SFD_CLOEXEC);
+	return daemon->signal_fd;
+}
+
 static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 		       int argc, const char **argv)
 {
@@ -733,8 +870,8 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 		OPT_PARENT(parent_options),
 		OPT_END()
 	};
-	int sock_fd = -1, conf_fd = -1;
-	int sock_pos, file_pos;
+	int sock_fd = -1, conf_fd = -1, signal_fd = -1;
+	int sock_pos, file_pos, signal_pos;
 	struct fdarray fda;
 	int err = 0;
 
@@ -766,7 +903,7 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 
 	pr_info("daemon started (pid %d)\n", getpid());
 
-	fdarray__init(&fda, 2);
+	fdarray__init(&fda, 3);
 
 	sock_fd = setup_server_socket(daemon);
 	if (sock_fd < 0)
@@ -776,6 +913,10 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 	if (conf_fd < 0)
 		goto out;
 
+	signal_fd = setup_signalfd(daemon);
+	if (signal_fd < 0)
+		goto out;
+
 	sock_pos = fdarray__add(&fda, sock_fd, POLLIN|POLLERR|POLLHUP, 0);
 	if (sock_pos < 0)
 		goto out;
@@ -784,6 +925,10 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 	if (file_pos < 0)
 		goto out;
 
+	signal_pos = fdarray__add(&fda, signal_fd, POLLIN|POLLERR|POLLHUP, 0);
+	if (signal_pos < 0)
+		goto out;
+
 	signal(SIGINT, sig_handler);
 	signal(SIGTERM, sig_handler);
 
@@ -797,6 +942,8 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 				err = handle_server_socket(daemon, sock_fd);
 			if (fda.entries[file_pos].revents & POLLIN)
 				err = handle_config_changes(daemon, conf_fd, &reconfig);
+			if (fda.entries[signal_pos].revents & POLLIN)
+				err = handle_signalfd(daemon) < 0;
 
 			if (reconfig)
 				err = setup_server_config(daemon);
@@ -813,6 +960,8 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 		close(sock_fd);
 	if (conf_fd != -1)
 		close(conf_fd);
+	if (conf_fd != -1)
+		close(signal_fd);
 
 	pr_info("daemon exited\n");
 	fclose(daemon->out);
-- 
2.29.2

