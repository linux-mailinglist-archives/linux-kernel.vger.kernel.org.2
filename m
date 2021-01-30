Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A976309912
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 00:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbhA3X44 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 30 Jan 2021 18:56:56 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:24362 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232228AbhA3Xuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 18:50:44 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-dOOlXwZCPpCH-FA74K4UXQ-1; Sat, 30 Jan 2021 18:49:46 -0500
X-MC-Unique: dOOlXwZCPpCH-FA74K4UXQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7BA418B6126;
        Sat, 30 Jan 2021 23:49:44 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5202960DA0;
        Sat, 30 Jan 2021 23:49:42 +0000 (UTC)
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
Subject: [PATCH 15/24] perf daemon: Add ping command
Date:   Sun, 31 Jan 2021 00:48:47 +0100
Message-Id: <20210130234856.271282-16-jolsa@kernel.org>
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

Adding ping command to verify the perf record session
is up and operational.

It's used in following patches via test code to make
sure perf record is ready to receive signals.

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

Ping all sessions:

  # perf daemon ping
  OK   cycles
  OK   sched

Ping specific session:

  # perf daemon ping --session sched
  OK   sched

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 151 ++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index d7b3dd1e96f9..a5a71e0a706c 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -469,6 +469,80 @@ static int daemon__wait(struct daemon *daemon, int secs)
 	return 0;
 }
 
+static int
+session__control(struct session *session, const char *msg, bool do_ack)
+{
+	struct pollfd pollfd = { 0, };
+	char control_path[PATH_MAX];
+	char ack_path[PATH_MAX];
+	int control, ack = -1, len;
+	char buf[20];
+	int ret = -1;
+	ssize_t err;
+
+	/* open the control file */
+	scnprintf(control_path, sizeof(control_path), "%s/%s",
+		  session->base, SESSION_CONTROL);
+
+	control = open(control_path, O_WRONLY|O_NONBLOCK);
+	if (!control)
+		return -1;
+
+	if (do_ack) {
+		/* open the ack file */
+		scnprintf(ack_path, sizeof(ack_path), "%s/%s",
+			  session->base, SESSION_ACK);
+
+		ack = open(ack_path, O_RDONLY, O_NONBLOCK);
+		if (!ack) {
+			close(control);
+			return -1;
+		}
+	}
+
+	/* write the command */
+	len = strlen(msg);
+
+	do {
+		err = write(control, msg, len);
+		if (err == -1 && errno != EAGAIN) {
+			pr_err("failed: write to control pipe: %d (%s)\n",
+			       errno, control_path);
+			goto out;
+		}
+	} while (err != len);
+
+	if (!do_ack)
+		goto out;
+
+	/* wait for an ack */
+	pollfd.fd = ack;
+	pollfd.events = POLLIN;
+
+	if (!poll(&pollfd, 1, 2000)) {
+		pr_err("failed: control ack timeout\n");
+		goto out;
+	}
+
+	if (!pollfd.revents & POLLIN) {
+		pr_err("failed: did not received an ack\n");
+		goto out;
+	}
+
+	err = read(ack, buf, sizeof(buf));
+	if (err > 0)
+		ret = strcmp(buf, "ack\n");
+	else
+		perror("failed: read ack %d\n");
+
+out:
+	if (ack != -1)
+		close(ack);
+
+	close(control);
+	return ret;
+}
+
 static int setup_server_socket(struct daemon *daemon)
 {
 	struct sockaddr_un addr;
@@ -508,6 +582,7 @@ enum {
 	CMD_LIST   = 0,
 	CMD_SIGNAL = 1,
 	CMD_STOP   = 2,
+	CMD_PING   = 3,
 	CMD_MAX,
 };
 
@@ -529,8 +604,25 @@ union cmd {
 		int	sig;
 		char	name[SESSION_MAX];
 	} signal;
+
+	/* CMD_PING */
+	struct {
+		int	cmd;
+		char	name[SESSION_MAX];
+	} ping;
+};
+
+enum {
+	PING_OK	  = 0,
+	PING_FAIL = 1,
+	PING_MAX,
 };
 
+static int session__ping(struct session *session)
+{
+	return session__control(session, "ping", true) ?  PING_FAIL : PING_OK;
+}
+
 static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 {
 	char csv_sep = cmd->list.csv_sep;
@@ -627,6 +719,34 @@ static int cmd_session_kill(struct daemon *daemon, union cmd *cmd, FILE *out)
 	return 0;
 }
 
+static const char *ping_str[PING_MAX] = {
+	[PING_OK]   = "OK",
+	[PING_FAIL] = "FAIL",
+};
+
+static int cmd_session_ping(struct daemon *daemon, union cmd *cmd, FILE *out)
+{
+	struct session *session;
+	bool all = false, found = false;
+
+	all = !strcmp(cmd->ping.name, "all");
+
+	list_for_each_entry(session, &daemon->sessions, list) {
+		if (all || !strcmp(cmd->ping.name, session->name)) {
+			int state = session__ping(session);
+
+			fprintf(out, "%-4s %s\n", ping_str[state], session->name);
+			found = true;
+		}
+	}
+
+	if (!found && !all) {
+		fprintf(out, "%-4s %s (not found)\n",
+			ping_str[PING_FAIL], cmd->ping.name);
+	}
+	return 0;
+}
+
 static int handle_server_socket(struct daemon *daemon, int sock_fd)
 {
 	int ret = -EINVAL, fd;
@@ -661,6 +781,9 @@ static int handle_server_socket(struct daemon *daemon, int sock_fd)
 		done = 1;
 		pr_debug("perf daemon is exciting\n");
 		break;
+	case CMD_PING:
+		ret = cmd_session_ping(daemon, &cmd, out);
+		break;
 	default:
 		break;
 	}
@@ -1072,6 +1195,7 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 
 	signal(SIGINT, sig_handler);
 	signal(SIGTERM, sig_handler);
+	signal(SIGPIPE, SIG_IGN);
 
 	while (!done && !err) {
 		err = daemon__reconfig(daemon);
@@ -1201,6 +1325,31 @@ static int __cmd_stop(struct daemon *daemon, struct option parent_options[],
 	return send_cmd(daemon, &cmd);
 }
 
+static int __cmd_ping(struct daemon *daemon, struct option parent_options[],
+		      int argc, const char **argv)
+{
+	const char *name = "all";
+	struct option ping_options[] = {
+		OPT_STRING(0, "session", &name, "session",
+			"Ping to specific session"),
+		OPT_PARENT(parent_options),
+		OPT_END()
+	};
+	union cmd cmd = { .cmd = CMD_PING, };
+
+	argc = parse_options(argc, argv, ping_options, daemon_usage, 0);
+	if (argc)
+		usage_with_options(daemon_usage, ping_options);
+
+	if (setup_config(daemon)) {
+		pr_err("failed: config not found\n");
+		return -1;
+	}
+
+	scnprintf(cmd.ping.name, sizeof(cmd.ping.name), "%s", name);
+	return send_cmd(daemon, &cmd);
+}
+
 int cmd_daemon(int argc, const char **argv)
 {
 	struct option daemon_options[] = {
@@ -1227,6 +1376,8 @@ int cmd_daemon(int argc, const char **argv)
 			return __cmd_signal(&__daemon, daemon_options, argc, argv);
 		else if (!strcmp(argv[0], "stop"))
 			return __cmd_stop(&__daemon, daemon_options, argc, argv);
+		else if (!strcmp(argv[0], "ping"))
+			return __cmd_ping(&__daemon, daemon_options, argc, argv);
 
 		pr_err("failed: unknown command '%s'\n", argv[0]);
 		return -1;
-- 
2.29.2

