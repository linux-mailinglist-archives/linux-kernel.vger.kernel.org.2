Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FAA314163
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbhBHVM4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 Feb 2021 16:12:56 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:30705 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236641AbhBHUKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:10:34 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-AkClS90HME6j6s5poFhl1g-1; Mon, 08 Feb 2021 15:09:34 -0500
X-MC-Unique: AkClS90HME6j6s5poFhl1g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2013D192D791;
        Mon,  8 Feb 2021 20:09:33 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C548819C59;
        Mon,  8 Feb 2021 20:09:30 +0000 (UTC)
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
Subject: [PATCH 08/24] perf daemon: Add background support
Date:   Mon,  8 Feb 2021 21:08:52 +0100
Message-Id: <20210208200908.1019149-9-jolsa@kernel.org>
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

Adding support to put daemon process in the background.

It's now enabled by default and -f option is added to
keep daemon process on the console for debugging.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-daemon.txt |  4 ++
 tools/perf/builtin-daemon.c              | 62 ++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/tools/perf/Documentation/perf-daemon.txt b/tools/perf/Documentation/perf-daemon.txt
index 173b3f9f3a41..af5916d1c3e0 100644
--- a/tools/perf/Documentation/perf-daemon.txt
+++ b/tools/perf/Documentation/perf-daemon.txt
@@ -56,6 +56,10 @@ START COMMAND
 -------------
 The start command creates the daemon process.
 
+-f::
+--foreground::
+	Do not put the process in background.
+
 
 CONFIG FILE
 -----------
diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index bdddaa2ea388..2d7f282809b6 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -675,10 +675,61 @@ static int setup_config(struct daemon *daemon)
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
+	if (fcntl(fd, F_SETFD, FD_CLOEXEC)) {
+		perror("failed: fcntl FD_CLOEXEC");
+		close(fd);
+		return -1;
+	}
+
+	close(0);
+	dup2(fd, 1);
+	dup2(fd, 2);
+	close(fd);
+
+	daemon->out = fdopen(1, "w");
+	if (!daemon->out) {
+		close(1);
+		close(2);
+		return -1;
+	}
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
@@ -699,6 +750,17 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 	if (setup_server_config(daemon))
 		return -1;
 
+	if (!foreground) {
+		err = go_background(daemon);
+		if (err) {
+			/* original process, exit normally */
+			if (err == 1)
+				err = 0;
+			daemon__exit(daemon);
+			return err;
+		}
+	}
+
 	debug_set_file(daemon->out);
 	debug_set_display_time(true);
 
-- 
2.29.2

