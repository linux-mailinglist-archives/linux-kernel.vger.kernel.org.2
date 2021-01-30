Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA470309915
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 00:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhA3X5v convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 30 Jan 2021 18:57:51 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:47509 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232576AbhA3Xuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 18:50:39 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-gZWOamtFOK-FLabhZHV-eg-1; Sat, 30 Jan 2021 18:49:43 -0500
X-MC-Unique: gZWOamtFOK-FLabhZHV-eg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECFDE1005513;
        Sat, 30 Jan 2021 23:49:41 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 822F36F974;
        Sat, 30 Jan 2021 23:49:39 +0000 (UTC)
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
Subject: [PATCH 14/24] perf daemon: Set control fifo for session
Date:   Sun, 31 Jan 2021 00:48:46 +0100
Message-Id: <20210130234856.271282-15-jolsa@kernel.org>
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

Setup control fifos for session and add --control
option to session arguments.

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

Use can list control fifos with (control and ack files):

  # perf daemon -v
  [776459:daemon] base: /opt/perfdata
    output:  /opt/perfdata/output
    lock:    /opt/perfdata/lock
  [776460:cycles] perf record -m 20M -e cycles --overwrite --switch-output -a
    base:    /opt/perfdata/session-cycles
    output:  /opt/perfdata/session-cycles/output
    control: /opt/perfdata/session-cycles/control
    ack:     /opt/perfdata/session-cycles/ack
  [776461:sched] perf record -m 20M -e sched:* --overwrite --switch-output -a
    base:    /opt/perfdata/session-sched
    output:  /opt/perfdata/session-sched/output
    control: /opt/perfdata/session-sched/control
    ack:     /opt/perfdata/session-sched/ack

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 4ebeb524b16e..d7b3dd1e96f9 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -30,6 +30,8 @@
 #include "util.h"
 
 #define SESSION_OUTPUT  "output"
+#define SESSION_CONTROL "control"
+#define SESSION_ACK     "ack"
 
 /*
  * Session states:
@@ -72,6 +74,7 @@ struct session {
 	char			*base;
 	char			*name;
 	char			*run;
+	char			*control;
 	int			 pid;
 	struct list_head	 list;
 	enum session_state	 state;
@@ -348,7 +351,18 @@ static int session__run(struct session *session, struct daemon *daemon)
 	dup2(fd, 2);
 	close(fd);
 
-	scnprintf(buf, sizeof(buf), "%s record %s", daemon->perf, session->run);
+	if (mkfifo(SESSION_CONTROL, O_RDWR) && errno != EEXIST) {
+		perror("failed: create control fifo");
+		return -1;
+	}
+
+	if (mkfifo(SESSION_ACK, O_RDWR) && errno != EEXIST) {
+		perror("failed: create ack fifo");
+		return -1;
+	}
+
+	scnprintf(buf, sizeof(buf), "%s record --control=fifo:%s,%s %s",
+		  daemon->perf, SESSION_CONTROL, SESSION_ACK, session->run);
 
 	argv = argv_split(buf, &argc);
 	if (!argv)
@@ -562,6 +576,12 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 				/* session output */
 				csv_sep, session->base, SESSION_OUTPUT);
 
+			fprintf(out, "%c%s/%s%c%s/%s",
+				/* session control */
+				csv_sep, session->base, SESSION_CONTROL,
+				/* session ack */
+				csv_sep, session->base, SESSION_ACK);
+
 			fprintf(out, "\n");
 		} else {
 			fprintf(out, "[%d:%s] perf record %s\n",
@@ -572,6 +592,10 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 				session->base);
 			fprintf(out, "  output:  %s/%s\n",
 				session->base, SESSION_OUTPUT);
+			fprintf(out, "  control: %s/%s\n",
+				session->base, SESSION_CONTROL);
+			fprintf(out, "  ack:     %s/%s\n",
+				session->base, SESSION_ACK);
 		}
 	}
 
-- 
2.29.2

