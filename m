Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326A3309919
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 00:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhA3X6i convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 30 Jan 2021 18:58:38 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:57842 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232573AbhA3Xuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 18:50:32 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-DF19SCv9N2O67pYtTc7BHg-1; Sat, 30 Jan 2021 18:49:35 -0500
X-MC-Unique: DF19SCv9N2O67pYtTc7BHg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EFAC911B4;
        Sat, 30 Jan 2021 23:49:33 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33D0B60DA0;
        Sat, 30 Jan 2021 23:49:31 +0000 (UTC)
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
Subject: [PATCH 11/24] perf daemon: Add signal command
Date:   Sun, 31 Jan 2021 00:48:43 +0100
Message-Id: <20210130234856.271282-12-jolsa@kernel.org>
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

Allow perf daemon to send SIGUSR2 to all running sessions
or just to a specific session.

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

Send signal to all running sessions:

  # perf daemon signal
  signal 12 sent to session 'cycles [773738]'
  signal 12 sent to session 'sched [773739]'

Or to specific one:

  # perf daemon signal --session sched
  signal 12 sent to session 'sched [773739]'

And verify signals were delivered and perf.data dumped:

  # cat /opt/perfdata/session-cycles/output
  rounding mmap pages size to 32M (8192 pages)
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2021010220382490 ]

  # car /opt/perfdata/session-sched/output
  rounding mmap pages size to 32M (8192 pages)
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2021010220382489 ]
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2021010220393745 ]

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 75 +++++++++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index cdd1af4d672b..7581c5f296ad 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -490,9 +490,12 @@ static int setup_server_socket(struct daemon *daemon)
 
 enum {
 	CMD_LIST   = 0,
+	CMD_SIGNAL = 1,
 	CMD_MAX,
 };
 
+#define SESSION_MAX 64
+
 union cmd {
 	int cmd;
 
@@ -502,6 +505,13 @@ union cmd {
 		int	verbose;
 		char	csv_sep;
 	} list;
+
+	/* CMD_SIGNAL */
+	struct {
+		int	cmd;
+		int	sig;
+		char	name[SESSION_MAX];
+	} signal;
 };
 
 static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
@@ -559,6 +569,31 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 	return 0;
 }
 
+static int session__signal(struct session *session, int sig)
+{
+	if (session->pid < 0)
+		return -1;
+	return kill(session->pid, sig);
+}
+
+static int cmd_session_kill(struct daemon *daemon, union cmd *cmd, FILE *out)
+{
+	struct session *session;
+	bool all = false;
+
+	all = !strcmp(cmd->signal.name, "all");
+
+	list_for_each_entry(session, &daemon->sessions, list) {
+		if (all || !strcmp(cmd->signal.name, session->name)) {
+			session__signal(session, cmd->signal.sig);
+			fprintf(out, "signal %d sent to session '%s [%d]'\n",
+				cmd->signal.sig, session->name, session->pid);
+		}
+	}
+
+	return 0;
+}
+
 static int handle_server_socket(struct daemon *daemon, int sock_fd)
 {
 	int ret = -EINVAL, fd;
@@ -586,6 +621,9 @@ static int handle_server_socket(struct daemon *daemon, int sock_fd)
 	case CMD_LIST:
 		ret = cmd_session_list(daemon, &cmd, out);
 		break;
+	case CMD_SIGNAL:
+		ret = cmd_session_kill(daemon, &cmd, out);
+		break;
 	default:
 		break;
 	}
@@ -621,13 +659,6 @@ static int setup_client_socket(struct daemon *daemon)
 	return fd;
 }
 
-static int session__signal(struct session *session, int sig)
-{
-	if (session->pid < 0)
-		return -1;
-	return kill(session->pid, sig);
-}
-
 static void session__kill(struct session *session, struct daemon *daemon)
 {
 	session__signal(session, SIGTERM);
@@ -1034,6 +1065,34 @@ static int send_cmd_list(struct daemon *daemon)
 	return send_cmd(daemon, &cmd);
 }
 
+static int __cmd_signal(struct daemon *daemon, struct option parent_options[],
+			int argc, const char **argv)
+{
+	const char *name = "all";
+	struct option start_options[] = {
+		OPT_STRING(0, "session", &name, "session",
+			"Sent signal to specific session"),
+		OPT_PARENT(parent_options),
+		OPT_END()
+	};
+	union cmd cmd;
+
+	argc = parse_options(argc, argv, start_options, daemon_usage, 0);
+	if (argc)
+		usage_with_options(daemon_usage, start_options);
+
+	if (setup_config(daemon)) {
+		pr_err("failed: config not found\n");
+		return -1;
+	}
+
+	cmd.signal.cmd = CMD_SIGNAL,
+	cmd.signal.sig = SIGUSR2;
+	strncpy(cmd.signal.name, name, sizeof(cmd.signal.name) - 1);
+
+	return send_cmd(daemon, &cmd);
+}
+
 int cmd_daemon(int argc, const char **argv)
 {
 	struct option daemon_options[] = {
@@ -1056,6 +1115,8 @@ int cmd_daemon(int argc, const char **argv)
 	if (argc) {
 		if (!strcmp(argv[0], "start"))
 			return __cmd_start(&__daemon, daemon_options, argc, argv);
+		if (!strcmp(argv[0], "signal"))
+			return __cmd_signal(&__daemon, daemon_options, argc, argv);
 
 		pr_err("failed: unknown command '%s'\n", argv[0]);
 		return -1;
-- 
2.29.2

