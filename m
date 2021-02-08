Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41DE31416F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbhBHVOw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 Feb 2021 16:14:52 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:34737 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236643AbhBHUKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:10:42 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-3CsvaeD5PsitDz5OBI9X9Q-1; Mon, 08 Feb 2021 15:09:45 -0500
X-MC-Unique: 3CsvaeD5PsitDz5OBI9X9Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CEB510082F6;
        Mon,  8 Feb 2021 20:09:43 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60C6519C59;
        Mon,  8 Feb 2021 20:09:41 +0000 (UTC)
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
Subject: [PATCH 12/24] perf daemon: Add stop command
Date:   Mon,  8 Feb 2021 21:08:56 +0100
Message-Id: <20210208200908.1019149-13-jolsa@kernel.org>
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

Add 'perf daemon stop' command to stop daemon process
and all running sessions.

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

Stopping the daemon

  # perf daemon stop

Daemon is not running, nothing to connect to:

  # perf daemon
  connect error: Connection refused

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-daemon.txt |  6 +++++
 tools/perf/builtin-daemon.c              | 29 ++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/tools/perf/Documentation/perf-daemon.txt b/tools/perf/Documentation/perf-daemon.txt
index 9cd47ec959e9..94d5e09a1e17 100644
--- a/tools/perf/Documentation/perf-daemon.txt
+++ b/tools/perf/Documentation/perf-daemon.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 'perf daemon'
 'perf daemon' [<options>]
 'perf daemon start'  [<options>]
+'perf daemon stop'   [<options>]
 'perf daemon signal' [<options>]
 
 
@@ -62,6 +63,11 @@ The start command creates the daemon process.
 	Do not put the process in background.
 
 
+STOP COMMAND
+------------
+The stop command stops all the session and the daemon process.
+
+
 SIGNAL COMMAND
 --------------
 The signal command sends signal to configured sessions.
diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 027e1e58b67b..2ef7fe9200f3 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -532,6 +532,7 @@ static int setup_server_socket(struct daemon *daemon)
 enum {
 	CMD_LIST   = 0,
 	CMD_SIGNAL = 1,
+	CMD_STOP   = 2,
 	CMD_MAX,
 };
 
@@ -665,6 +666,11 @@ static int handle_server_socket(struct daemon *daemon, int sock_fd)
 	case CMD_SIGNAL:
 		ret = cmd_session_kill(daemon, &cmd, out);
 		break;
+	case CMD_STOP:
+		done = 1;
+		ret = 0;
+		pr_debug("perf daemon is exciting\n");
+		break;
 	default:
 		break;
 	}
@@ -1149,6 +1155,27 @@ static int __cmd_signal(struct daemon *daemon, struct option parent_options[],
 	return send_cmd(daemon, &cmd);
 }
 
+static int __cmd_stop(struct daemon *daemon, struct option parent_options[],
+			int argc, const char **argv)
+{
+	struct option start_options[] = {
+		OPT_PARENT(parent_options),
+		OPT_END()
+	};
+	union cmd cmd = { .cmd = CMD_STOP, };
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
+	return send_cmd(daemon, &cmd);
+}
+
 int cmd_daemon(int argc, const char **argv)
 {
 	struct option daemon_options[] = {
@@ -1173,6 +1200,8 @@ int cmd_daemon(int argc, const char **argv)
 			return __cmd_start(&__daemon, daemon_options, argc, argv);
 		if (!strcmp(argv[0], "signal"))
 			return __cmd_signal(&__daemon, daemon_options, argc, argv);
+		else if (!strcmp(argv[0], "stop"))
+			return __cmd_stop(&__daemon, daemon_options, argc, argv);
 
 		pr_err("failed: unknown command '%s'\n", argv[0]);
 		return -1;
-- 
2.29.2

