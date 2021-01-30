Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35A130991A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 00:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhA3X6m convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 30 Jan 2021 18:58:42 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:35962 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232569AbhA3Xuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 18:50:32 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-DdfwTRTEMZ6kNMpVq8e5qg-1; Sat, 30 Jan 2021 18:49:32 -0500
X-MC-Unique: DdfwTRTEMZ6kNMpVq8e5qg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D43C9107ACE4;
        Sat, 30 Jan 2021 23:49:30 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4734560DA0;
        Sat, 30 Jan 2021 23:49:28 +0000 (UTC)
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
Subject: [PATCH 10/24] perf daemon: Add list command
Date:   Sun, 31 Jan 2021 00:48:42 +0100
Message-Id: <20210130234856.271282-11-jolsa@kernel.org>
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

Adding list command to display all running sessions.
It's the default command if no other command is specified.

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

List sessions:

  # perf daemon
  [771394:daemon] base: /opt/perfdata
  [771395:cycles] perf record -m 10M -e cycles --overwrite --switch-output -a
  [771396:sched] perf record -m 20M -e sched:* --overwrite --switch-output -a

List sessions with more info:

  # perf daemon -v
  [771394:daemon] base: /opt/perfdata
    output:  /opt/perfdata/output
  [771395:cycles] perf record -m 10M -e cycles --overwrite --switch-output -a
    base:    /opt/perfdata/session-cycles
    output:  /opt/perfdata/session-cycles/output
  [771396:sched] perf record -m 20M -e sched:* --overwrite --switch-output -a
    base:    /opt/perfdata/session-sched
    output:  /opt/perfdata/session-sched/output

The 'output' file is perf record output for specific session.

Note you have to stop all running perf processes manually at
this point, stop command is coming in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 89 +++++++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 69d3af70b642..cdd1af4d672b 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -79,6 +79,7 @@ struct daemon {
 	const char		*config;
 	char			*config_real;
 	char			*config_base;
+	const char		*csv_sep;
 	const char		*base_user;
 	char			*base;
 	struct list_head	 sessions;
@@ -487,11 +488,78 @@ static int setup_server_socket(struct daemon *daemon)
 	return fd;
 }
 
+enum {
+	CMD_LIST   = 0,
+	CMD_MAX,
+};
+
 union cmd {
 	int cmd;
+
+	/* CMD_LIST */
+	struct {
+		int	cmd;
+		int	verbose;
+		char	csv_sep;
+	} list;
 };
 
-static int handle_server_socket(struct daemon *daemon __maybe_unused, int sock_fd)
+static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
+{
+	char csv_sep = cmd->list.csv_sep;
+	struct session *session;
+
+	if (csv_sep) {
+		fprintf(out, "%d%c%s%c%s%c%s/%s",
+			/* pid daemon  */
+			getpid(), csv_sep, "daemon",
+			/* base */
+			csv_sep, daemon->base,
+			/* output */
+			csv_sep, daemon->base, SESSION_OUTPUT);
+
+		fprintf(out, "\n");
+	} else {
+		fprintf(out, "[%d:daemon] base: %s\n", getpid(), daemon->base);
+		if (cmd->list.verbose) {
+			fprintf(out, "  output:  %s/%s\n",
+				daemon->base, SESSION_OUTPUT);
+		}
+	}
+
+	list_for_each_entry(session, &daemon->sessions, list) {
+		if (csv_sep) {
+			fprintf(out, "%d%c%s%c%s",
+				/* pid */
+				session->pid,
+				/* name */
+				csv_sep, session->name,
+				/* base */
+				csv_sep, session->run);
+
+			fprintf(out, "%c%s%c%s/%s",
+				/* session dir */
+				csv_sep, session->base,
+				/* session output */
+				csv_sep, session->base, SESSION_OUTPUT);
+
+			fprintf(out, "\n");
+		} else {
+			fprintf(out, "[%d:%s] perf record %s\n",
+				session->pid, session->name, session->run);
+			if (!cmd->list.verbose)
+				continue;
+			fprintf(out, "  base:    %s\n",
+				session->base);
+			fprintf(out, "  output:  %s/%s\n",
+				session->base, SESSION_OUTPUT);
+		}
+	}
+
+	return 0;
+}
+
+static int handle_server_socket(struct daemon *daemon, int sock_fd)
 {
 	int ret = -EINVAL, fd;
 	union cmd cmd;
@@ -515,6 +583,9 @@ static int handle_server_socket(struct daemon *daemon __maybe_unused, int sock_f
 	}
 
 	switch (cmd.cmd) {
+	case CMD_LIST:
+		ret = cmd_session_list(daemon, &cmd, out);
+		break;
 	default:
 		break;
 	}
@@ -919,7 +990,6 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 	return err;
 }
 
-__maybe_unused
 static int send_cmd(struct daemon *daemon, union cmd *cmd)
 {
 	char *line = NULL;
@@ -953,6 +1023,17 @@ static int send_cmd(struct daemon *daemon, union cmd *cmd)
 	return 0;
 }
 
+static int send_cmd_list(struct daemon *daemon)
+{
+	union cmd cmd = {
+		.list.cmd	= CMD_LIST,
+		.list.verbose	= verbose,
+	};
+
+	cmd.list.csv_sep = daemon->csv_sep ? *daemon->csv_sep : 0;
+	return send_cmd(daemon, &cmd);
+}
+
 int cmd_daemon(int argc, const char **argv)
 {
 	struct option daemon_options[] = {
@@ -961,6 +1042,8 @@ int cmd_daemon(int argc, const char **argv)
 			"config file", "config file path"),
 		OPT_STRING(0, "base", &__daemon.base_user,
 			"directory", "base directory"),
+		OPT_STRING_OPTARG('x', "field-separator", &__daemon.csv_sep,
+			"field separator", "print counts with custom separator", ","),
 		OPT_END()
 	};
 
@@ -983,5 +1066,5 @@ int cmd_daemon(int argc, const char **argv)
 		return -1;
 	}
 
-	return -1;
+	return send_cmd_list(&__daemon);
 }
-- 
2.29.2

