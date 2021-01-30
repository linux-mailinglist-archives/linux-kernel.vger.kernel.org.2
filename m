Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B44309920
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 01:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhAaAAE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 30 Jan 2021 19:00:04 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:37726 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232558AbhA3Xub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 18:50:31 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-ZO6GFbXxPZunkDPjg5rjMQ-1; Sat, 30 Jan 2021 18:49:27 -0500
X-MC-Unique: ZO6GFbXxPZunkDPjg5rjMQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A3F2107ACE6;
        Sat, 30 Jan 2021 23:49:25 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA7366F974;
        Sat, 30 Jan 2021 23:49:22 +0000 (UTC)
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
Subject: [PATCH 08/24] perf daemon: Add background support
Date:   Sun, 31 Jan 2021 00:48:40 +0100
Message-Id: <20210130234856.271282-9-jolsa@kernel.org>
In-Reply-To: <20210130234856.271282-1-jolsa@kernel.org>
References: <20210129134855.195810-1-jolsa@redhat.com>
 <20210130234856.271282-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support to put daemon process in the background.

It's now enabled by default and -f option is added to
keep daemon process on the console for debugging.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 66 +++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index d0a0a998e073..324666058842 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -488,6 +488,13 @@ static void daemon__kill(struct daemon *daemon)
 	daemon__signal(daemon, SIGTERM);
 }
 
+static void __daemon__free(struct daemon *daemon)
+{
+	free(daemon->config_real);
+	free(daemon->config_base);
+	free(daemon->base);
+}
+
 static void daemon__free(struct daemon *daemon)
 {
 	struct session *session, *h;
@@ -495,9 +502,7 @@ static void daemon__free(struct daemon *daemon)
 	list_for_each_entry_safe(session, h, &daemon->sessions, list)
 		session__remove(session);
 
-	free(daemon->config_real);
-	free(daemon->config_base);
-	free(daemon->base);
+	__daemon__free(daemon);
 }
 
 static void daemon__exit(struct daemon *daemon)
@@ -643,10 +648,54 @@ static int setup_config(struct daemon *daemon)
 	return daemon->config_real ? 0 : -1;
 }
 
+static int go_background(struct daemon *daemon)
+{
+	int pid, fd;
+
+	pid = fork();
+	if (pid < 0)
+		return -1;
+
+	if (pid > 0)
+		return 1;
+
+	if (setsid() < 0)
+		return -1;
+
+	umask(0);
+
+	if (chdir(daemon->base)) {
+		perror("failed: chdir");
+		return -1;
+	}
+
+	fd = open("output", O_RDWR|O_CREAT|O_TRUNC, 0644);
+	if (fd < 0) {
+		perror("failed: open");
+		return -1;
+	}
+
+	fcntl(fd, F_SETFD, FD_CLOEXEC);
+
+	close(0);
+	dup2(fd, 1);
+	dup2(fd, 2);
+	close(fd);
+
+	daemon->out = fdopen(1, "w");
+	if (!daemon->out)
+		return -1;
+
+	setbuf(daemon->out, NULL);
+	return 0;
+}
+
 static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 		       int argc, const char **argv)
 {
+	bool foreground = false;
 	struct option start_options[] = {
+		OPT_BOOLEAN('f', "foreground", &foreground, "stay on console"),
 		OPT_PARENT(parent_options),
 		OPT_END()
 	};
@@ -667,6 +716,17 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 	if (setup_server_config(daemon))
 		return -1;
 
+	if (!foreground) {
+		err = go_background(daemon);
+		if (err) {
+			/* original process, exit normally */
+			if (err == 1)
+				err = 0;
+			__daemon__free(daemon);
+			return err;
+		}
+	}
+
 	debug_set_file(daemon->out);
 	debug_set_display_time(true);
 
-- 
2.29.2

