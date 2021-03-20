Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B273E342FC9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 23:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCTWKs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 20 Mar 2021 18:10:48 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:25860 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229780AbhCTWKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 18:10:24 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-moZNvdOQP8azMocmvBXbXg-1; Sat, 20 Mar 2021 18:10:19 -0400
X-MC-Unique: moZNvdOQP8azMocmvBXbXg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52342180FCA4;
        Sat, 20 Mar 2021 22:10:17 +0000 (UTC)
Received: from krava.cust.in.nbox.cz (unknown [10.40.192.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF99A376E;
        Sat, 20 Mar 2021 22:10:14 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 1/2] perf daemon: Force waipid for all session on SIGCHLD delivery
Date:   Sat, 20 Mar 2021 23:10:12 +0100
Message-Id: <20210320221013.1619613-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we don't process SIGCHLD before another comes, we will
see just one SIGCHLD as a result. In this case current code
will miss exit notification for a session and wait forever.

Adding extra waitpid check for all sessions when SIGCHLD
is received, to make sure we don't miss any session exit.

Also fix close condition for signal_fd.

Reported-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 50 +++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index ace8772a4f03..4697493842f5 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -402,35 +402,42 @@ static pid_t handle_signalfd(struct daemon *daemon)
 	int status;
 	pid_t pid;
 
+	/*
+	 * Take signal fd data as pure signal notification and check all
+	 * the sessions state. The reason is that multiple signals can get
+	 * coalesced in kernel and we can receive only single signal even
+	 * if multiple SIGCHLD were generated.
+	 */
 	err = read(daemon->signal_fd, &si, sizeof(struct signalfd_siginfo));
-	if (err != sizeof(struct signalfd_siginfo))
+	if (err != sizeof(struct signalfd_siginfo)) {
+		pr_err("failed to read signal fd\n");
 		return -1;
+	}
 
 	list_for_each_entry(session, &daemon->sessions, list) {
+		if (session->pid == -1)
+			continue;
 
-		if (session->pid != (int) si.ssi_pid)
+		pid = waitpid(session->pid, &status, WNOHANG);
+		if (pid <= 0)
 			continue;
 
-		pid = waitpid(session->pid, &status, 0);
-		if (pid == session->pid) {
-			if (WIFEXITED(status)) {
-				pr_info("session '%s' exited, status=%d\n",
-					session->name, WEXITSTATUS(status));
-			} else if (WIFSIGNALED(status)) {
-				pr_info("session '%s' killed (signal %d)\n",
-					session->name, WTERMSIG(status));
-			} else if (WIFSTOPPED(status)) {
-				pr_info("session '%s' stopped (signal %d)\n",
-					session->name, WSTOPSIG(status));
-			} else {
-				pr_info("session '%s' Unexpected status (0x%x)\n",
-					session->name, status);
-			}
+		if (WIFEXITED(status)) {
+			pr_info("session '%s' exited, status=%d\n",
+				session->name, WEXITSTATUS(status));
+		} else if (WIFSIGNALED(status)) {
+			pr_info("session '%s' killed (signal %d)\n",
+				session->name, WTERMSIG(status));
+		} else if (WIFSTOPPED(status)) {
+			pr_info("session '%s' stopped (signal %d)\n",
+				session->name, WSTOPSIG(status));
+		} else {
+			pr_info("session '%s' Unexpected status (0x%x)\n",
+				session->name, status);
 		}
 
 		session->state = KILL;
 		session->pid = -1;
-		return pid;
 	}
 
 	return 0;
@@ -443,7 +450,6 @@ static int daemon_session__wait(struct daemon_session *session, struct daemon *d
 		.fd	= daemon->signal_fd,
 		.events	= POLLIN,
 	};
-	pid_t wpid = 0, pid = session->pid;
 	time_t start;
 
 	start = time(NULL);
@@ -452,7 +458,7 @@ static int daemon_session__wait(struct daemon_session *session, struct daemon *d
 		int err = poll(&pollfd, 1, 1000);
 
 		if (err > 0) {
-			wpid = handle_signalfd(daemon);
+			handle_signalfd(daemon);
 		} else if (err < 0) {
 			perror("failed: poll\n");
 			return -1;
@@ -460,7 +466,7 @@ static int daemon_session__wait(struct daemon_session *session, struct daemon *d
 
 		if (start + secs < time(NULL))
 			return -1;
-	} while (wpid != pid);
+	} while (session->pid != -1);
 
 	return 0;
 }
@@ -1344,7 +1350,7 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 		close(sock_fd);
 	if (conf_fd != -1)
 		close(conf_fd);
-	if (conf_fd != -1)
+	if (signal_fd != -1)
 		close(signal_fd);
 
 	pr_info("daemon exited\n");
-- 
2.30.2

