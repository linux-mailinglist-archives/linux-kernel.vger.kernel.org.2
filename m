Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFDB9314185
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbhBHVRv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 Feb 2021 16:17:51 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:34385 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236682AbhBHUKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:10:53 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-k4XV6-cnNEu-tODbtJgXtA-1; Mon, 08 Feb 2021 15:09:58 -0500
X-MC-Unique: k4XV6-cnNEu-tODbtJgXtA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA498192D786;
        Mon,  8 Feb 2021 20:09:56 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CF2519C59;
        Mon,  8 Feb 2021 20:09:54 +0000 (UTC)
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
Subject: [PATCH 17/24] perf daemon: Add up time for daemon/session list
Date:   Mon,  8 Feb 2021 21:09:01 +0100
Message-Id: <20210208200908.1019149-18-jolsa@kernel.org>
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

Display up time for both daemon and sessions.

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

Get the details with up time:

  # perf daemon -v
  [778315:daemon] base: /opt/perfdata
    output:  /opt/perfdata/output
    lock:    /opt/perfdata/lock
    up:      15 minutes
  [778316:cycles] perf record -m 20M -e cycles --overwrite --switch-output -a
    base:    /opt/perfdata/session-cycles
    output:  /opt/perfdata/session-cycles/output
    control: /opt/perfdata/session-cycles/control
    ack:     /opt/perfdata/session-cycles/ack
    up:      10 minutes
  [778317:sched] perf record -m 20M -e sched:* --overwrite --switch-output -a
    base:    /opt/perfdata/session-sched
    output:  /opt/perfdata/session-sched/output
    control: /opt/perfdata/session-sched/control
    ack:     /opt/perfdata/session-sched/ack
    up:      2 minutes

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 11f9fac4cf12..90ef14353804 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -25,6 +25,7 @@
 #include <sys/wait.h>
 #include <poll.h>
 #include <sys/stat.h>
+#include <time.h>
 #include "builtin.h"
 #include "perf.h"
 #include "debug.h"
@@ -80,6 +81,7 @@ struct daemon_session {
 	int				 pid;
 	struct list_head		 list;
 	enum daemon_session_state	 state;
+	time_t				 start;
 };
 
 struct daemon {
@@ -93,6 +95,7 @@ struct daemon {
 	FILE			*out;
 	char			 perf[PATH_MAX];
 	int			 signal_fd;
+	time_t			 start;
 };
 
 static struct daemon __daemon = {
@@ -335,6 +338,8 @@ static int daemon_session__run(struct daemon_session *session,
 		return -1;
 	}
 
+	session->start = time(NULL);
+
 	session->pid = fork();
 	if (session->pid < 0)
 		return -1;
@@ -666,6 +671,7 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 {
 	char csv_sep = cmd->list.csv_sep;
 	struct daemon_session *session;
+	time_t curr = time(NULL);
 
 	if (csv_sep) {
 		fprintf(out, "%d%c%s%c%s%c%s/%s",
@@ -680,6 +686,10 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 			/* lock */
 			csv_sep, daemon->base, "lock");
 
+		fprintf(out, "%c%lu",
+			/* session up time */
+			csv_sep, (curr - daemon->start) / 60);
+
 		fprintf(out, "\n");
 	} else {
 		fprintf(out, "[%d:daemon] base: %s\n", getpid(), daemon->base);
@@ -688,6 +698,8 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 				daemon->base, SESSION_OUTPUT);
 			fprintf(out, "  lock:    %s/lock\n",
 				daemon->base);
+			fprintf(out, "  up:      %lu minutes\n",
+				(curr - daemon->start) / 60);
 		}
 	}
 
@@ -713,6 +725,10 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 				/* session ack */
 				csv_sep, session->base, SESSION_ACK);
 
+			fprintf(out, "%c%lu",
+				/* session up time */
+				csv_sep, (curr - session->start) / 60);
+
 			fprintf(out, "\n");
 		} else {
 			fprintf(out, "[%d:%s] perf record %s\n",
@@ -727,6 +743,8 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 				session->base, SESSION_CONTROL);
 			fprintf(out, "  ack:     %s/%s\n",
 				session->base, SESSION_ACK);
+			fprintf(out, "  up:      %lu minutes\n",
+				(curr - session->start) / 60);
 		}
 	}
 
@@ -1226,6 +1244,8 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 	if (argc)
 		usage_with_options(daemon_usage, start_options);
 
+	daemon->start = time(NULL);
+
 	if (setup_config(daemon)) {
 		pr_err("failed: config not found\n");
 		return -1;
-- 
2.29.2

