Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1006F314165
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbhBHVND convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 Feb 2021 16:13:03 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:31886 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236636AbhBHUKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:10:34 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-gLkWdLppNSORLo7o_GEQDg-1; Mon, 08 Feb 2021 15:09:29 -0500
X-MC-Unique: gLkWdLppNSORLo7o_GEQDg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE775801965;
        Mon,  8 Feb 2021 20:09:27 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 814E419C59;
        Mon,  8 Feb 2021 20:09:25 +0000 (UTC)
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
Subject: [PATCH 06/24] perf daemon: Add config file support
Date:   Mon,  8 Feb 2021 21:08:50 +0100
Message-Id: <20210208200908.1019149-7-jolsa@kernel.org>
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

Adding support to configure daemon with config file.

Each client or server invocation of perf daemon needs to know the
base directory, where all sessions data is stored.

The base is defined with:

  daemon.base
    Base path for daemon data. All sessions data are stored under
    this path.

The daemon allows to create record sessions. Each session is a
record command spawned and monitored by perf daemon.

The session is defined with:

  session-<NAME>.run
    Defines new record session for daemon. The value is record's
    command line without the 'record' keyword.

Example:

  # cat ~/.perfconfig
  [daemon]
  base=/opt/perfdata

  [session-cycles]
  run = -m 10M -e cycles --overwrite --switch-output -a

  [session-sched]
  run = -m 20M -e sched:* --overwrite --switch-output -a

Example above defines '/opt/perfdata' as a base directory
and 2 record sessions.

  # perf daemon start
  [2021-01-28 19:47:33.454413] daemon started (pid 16015)
  [2021-01-28 19:47:33.455910] reconfig: ruining session [cycles:16016]: -m 10M -e cycles --overwrite --switch-output -a
  [2021-01-28 19:47:33.456599] reconfig: ruining session [sched:16017]: -m 20M -e sched:* --overwrite --switch-output -a

  # ps -ef | grep perf
  ... perf daemon start
  ... /home/jolsa/.../perf record -m 20M -e cycles --overwrite --switch-output -a
  ... /home/jolsa/.../perf record -m 20M -e sched:* --overwrite --switch-output -a

The base directory is populated with:

  # find /opt/perfdata/
  /opt/perfdata/
  /opt/perfdata/control                    <- control socket
  /opt/perfdata/session-cycles             <- data for session 'cycles':
  /opt/perfdata/session-cycles/output      <-   perf record output
  /opt/perfdata/session-cycles/perf.data   <-   perf data
  /opt/perfdata/session-sched              <- ditto for session 'sched'
  /opt/perfdata/session-sched/output
  /opt/perfdata/session-sched/perf.data

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-config.txt |  14 +
 tools/perf/Documentation/perf-daemon.txt |  30 ++
 tools/perf/builtin-daemon.c              | 351 ++++++++++++++++++++++-
 3 files changed, 393 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index c3ce48f1b379..153bde14bbe0 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -703,6 +703,20 @@ auxtrace.*::
 		If the directory does not exist or has the wrong file type,
 		the current directory is used.
 
+daemon.*::
+
+	daemon.base::
+		Base path for daemon data. All sessions data are stored under
+		this path.
+
+session-<NAME>.*::
+
+	session-<NAME>.run::
+
+		Defines new record session for daemon. The value is record's
+		command line without the 'record' keyword.
+
+
 SEE ALSO
 --------
 linkperf:perf[1]
diff --git a/tools/perf/Documentation/perf-daemon.txt b/tools/perf/Documentation/perf-daemon.txt
index 1a4158cd973e..173b3f9f3a41 100644
--- a/tools/perf/Documentation/perf-daemon.txt
+++ b/tools/perf/Documentation/perf-daemon.txt
@@ -20,6 +20,20 @@ DESCRIPTION
 This command allows to run simple daemon process that starts and
 monitors configured record sessions.
 
+You can imagine 'perf daemon' of background process with several
+'perf record' child tasks, like:
+
+  # ps axjf
+  ...
+       1  916507 ... perf daemon start
+  916507  916508 ...  \_ perf record --control=fifo:control,ack -m 10M -e cycles --overwrite --switch-output -a
+  916507  916509 ...  \_ perf record --control=fifo:control,ack -m 20M -e sched:* --overwrite --switch-output -a
+
+Not every 'perf record' session is suitable for running under daemon.
+User need perf session that either produces data on query, like the
+flight recorder sessions in above example or session that is configured
+to produce data periodically, like with --switch-output configuration
+for time and size.
 
 OPTIONS
 -------
@@ -43,6 +57,22 @@ START COMMAND
 The start command creates the daemon process.
 
 
+CONFIG FILE
+-----------
+The daemon is configured within standard perf config file by
+following new variables:
+
+daemon.base:
+	Base path for daemon data. All sessions data are
+	stored under this path.
+
+session-<NAME>.run:
+	Defines new record session. The value is record's command
+	line without the 'record' keyword.
+
+Each perf record session is run in daemon.base/<NAME> directory.
+
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-config[1]
diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index e0880c5ee39c..15b328f6bd9a 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -2,6 +2,8 @@
 #include <internal/lib.h>
 #include <subcmd/parse-options.h>
 #include <api/fd/array.h>
+#include <linux/zalloc.h>
+#include <linux/string.h>
 #include <linux/limits.h>
 #include <linux/string.h>
 #include <string.h>
@@ -15,22 +17,74 @@
 #include <sys/un.h>
 #include <sys/stat.h>
 #include <poll.h>
+#include <sys/stat.h>
 #include "builtin.h"
 #include "perf.h"
 #include "debug.h"
 #include "config.h"
 #include "util.h"
 
+#define SESSION_OUTPUT  "output"
+
+/*
+ * Session states:
+ *
+ *   OK       - session is up and running
+ *   RECONFIG - session is pending for reconfiguration,
+ *              new values are already loaded in session object
+ *   KILL     - session is pending to be killed
+ *
+ * Session object life and its state is maintained by
+ * following functions:
+ *
+ *  setup_server_config
+ *    - reads config file and setup session objects
+ *      with following states:
+ *
+ *      OK       - no change needed
+ *      RECONFIG - session needs to be changed
+ *                 (run variable changed)
+ *      KILL     - session needs to be killed
+ *                 (session is no longer in config file)
+ *
+ *  daemon__reconfig
+ *    - scans session objects and does following actions
+ *      for states:
+ *
+ *      OK       - skip
+ *      RECONFIG - session is killed and re-run with new config
+ *      KILL     - session is killed
+ *
+ *    - all sessions have OK state on the function exit
+ */
+enum daemon_session_state {
+	OK,
+	RECONFIG,
+	KILL,
+};
+
+struct daemon_session {
+	char				*base;
+	char				*name;
+	char				*run;
+	int				 pid;
+	struct list_head		 list;
+	enum daemon_session_state	 state;
+};
+
 struct daemon {
 	const char		*config;
 	char			*config_real;
 	const char		*base_user;
 	char			*base;
+	struct list_head	 sessions;
 	FILE			*out;
 	char			 perf[PATH_MAX];
 };
 
-static struct daemon __daemon = { };
+static struct daemon __daemon = {
+	.sessions = LIST_HEAD_INIT(__daemon.sessions),
+};
 
 static const char * const daemon_usage[] = {
 	"perf daemon start [<options>]",
@@ -45,6 +99,125 @@ static void sig_handler(int sig __maybe_unused)
 	done = true;
 }
 
+static struct daemon_session *daemon__add_session(struct daemon *config, char *name)
+{
+	struct daemon_session *session = zalloc(sizeof(*session));
+
+	if (!session)
+		return NULL;
+
+	session->name = strdup(name);
+	if (!session->name) {
+		free(session);
+		return NULL;
+	}
+
+	session->pid = -1;
+	list_add_tail(&session->list, &config->sessions);
+	return session;
+}
+
+static struct daemon_session *daemon__find_session(struct daemon *daemon, char *name)
+{
+	struct daemon_session *session;
+
+	list_for_each_entry(session, &daemon->sessions, list) {
+		if (!strcmp(session->name, name))
+			return session;
+	}
+
+	return NULL;
+}
+
+static int get_session_name(const char *var, char *session, int len)
+{
+	const char *p = var + sizeof("session-") - 1;
+
+	while (*p != '.' && *p != 0x0 && len--)
+		*session++ = *p++;
+
+	*session = 0;
+	return *p == '.' ? 0 : -EINVAL;
+}
+
+static int session_config(struct daemon *daemon, const char *var, const char *value)
+{
+	struct daemon_session *session;
+	char name[100];
+
+	if (get_session_name(var, name, sizeof(name)))
+		return -EINVAL;
+
+	var = strchr(var, '.');
+	if (!var)
+		return -EINVAL;
+
+	var++;
+
+	session = daemon__find_session(daemon, name);
+
+	if (!session) {
+		/* New session is defined. */
+		session = daemon__add_session(daemon, name);
+		if (!session)
+			return -ENOMEM;
+
+		pr_debug("reconfig: found new session %s\n", name);
+
+		/* Trigger reconfig to start it. */
+		session->state = RECONFIG;
+	} else if (session->state == KILL) {
+		/* Current session is defined, no action needed. */
+		pr_debug("reconfig: found current session %s\n", name);
+		session->state = OK;
+	}
+
+	if (!strcmp(var, "run")) {
+		bool same = false;
+
+		if (session->run)
+			same = !strcmp(session->run, value);
+
+		if (!same) {
+			if (session->run) {
+				free(session->run);
+				pr_debug("reconfig: session %s is changed\n", name);
+			}
+
+			session->run = strdup(value);
+			if (!session->run)
+				return -ENOMEM;
+
+			/*
+			 * Either new or changed run value is defined,
+			 * trigger reconfig for the session.
+			 */
+			session->state = RECONFIG;
+		}
+	}
+
+	return 0;
+}
+
+static int server_config(const char *var, const char *value, void *cb)
+{
+	struct daemon *daemon = cb;
+
+	if (strstarts(var, "session-")) {
+		return session_config(daemon, var, value);
+	} else if (!strcmp(var, "daemon.base") && !daemon->base_user) {
+		if (daemon->base && strcmp(daemon->base, value)) {
+			pr_err("failed: can't redefine base, bailing out\n");
+			return -EINVAL;
+		}
+		daemon->base = strdup(value);
+		if (!daemon->base)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static int client_config(const char *var, const char *value, void *cb)
 {
 	struct daemon *daemon = cb;
@@ -106,6 +279,92 @@ static int setup_client_config(struct daemon *daemon)
 	return err ?: check_base(daemon);
 }
 
+static int setup_server_config(struct daemon *daemon)
+{
+	struct perf_config_set *set;
+	struct daemon_session *session;
+	int err = -ENOMEM;
+
+	pr_debug("reconfig: started\n");
+
+	/*
+	 * Mark all sessions for kill, the server config
+	 * will set following states, see explanation at
+	 * enum daemon_session_state declaration.
+	 */
+	list_for_each_entry(session, &daemon->sessions, list)
+		session->state = KILL;
+
+	set = perf_config_set__load_file(daemon->config_real);
+	if (set) {
+		err = perf_config_set(set, server_config, daemon);
+		perf_config_set__delete(set);
+	}
+
+	return err ?: check_base(daemon);
+}
+
+static int daemon_session__run(struct daemon_session *session,
+			       struct daemon *daemon)
+{
+	char buf[PATH_MAX];
+	char **argv;
+	int argc, fd;
+
+	if (asprintf(&session->base, "%s/session-%s",
+		     daemon->base, session->name) < 0) {
+		perror("failed: asprintf");
+		return -1;
+	}
+
+	if (mkdir(session->base, 0755) && errno != EEXIST) {
+		perror("failed: mkdir");
+		return -1;
+	}
+
+	session->pid = fork();
+	if (session->pid < 0)
+		return -1;
+	if (session->pid > 0) {
+		pr_info("reconfig: ruining session [%s:%d]: %s\n",
+			session->name, session->pid, session->run);
+		return 0;
+	}
+
+	if (chdir(session->base)) {
+		perror("failed: chdir");
+		return -1;
+	}
+
+	fd = open("/dev/null", O_RDONLY);
+	if (fd < 0) {
+		perror("failed: open /dev/null");
+		return -1;
+	}
+
+	dup2(fd, 0);
+	close(fd);
+
+	fd = open(SESSION_OUTPUT, O_RDWR|O_CREAT|O_TRUNC, 0644);
+	if (fd < 0) {
+		perror("failed: open session output");
+		return -1;
+	}
+
+	dup2(fd, 1);
+	dup2(fd, 2);
+	close(fd);
+
+	scnprintf(buf, sizeof(buf), "%s record %s", daemon->perf, session->run);
+
+	argv = argv_split(buf, &argc);
+	if (!argv)
+		exit(-1);
+
+	exit(execve(daemon->perf, argv, NULL));
+	return -1;
+}
+
 static int setup_server_socket(struct daemon *daemon)
 {
 	struct sockaddr_un addr;
@@ -224,12 +483,89 @@ static int setup_client_socket(struct daemon *daemon)
 	return fd;
 }
 
+static int daemon_session__signal(struct daemon_session *session, int sig)
+{
+	if (session->pid < 0)
+		return -1;
+	return kill(session->pid, sig);
+}
+
+static void daemon_session__kill(struct daemon_session *session)
+{
+	daemon_session__signal(session, SIGTERM);
+}
+
+static void daemon__signal(struct daemon *daemon, int sig)
+{
+	struct daemon_session *session;
+
+	list_for_each_entry(session, &daemon->sessions, list)
+		daemon_session__signal(session, sig);
+}
+
+static void daemon_session__delete(struct daemon_session *session)
+{
+	free(session->base);
+	free(session->name);
+	free(session->run);
+	free(session);
+}
+
+static void daemon_session__remove(struct daemon_session *session)
+{
+	list_del(&session->list);
+	daemon_session__delete(session);
+}
+
+static void daemon__kill(struct daemon *daemon)
+{
+	daemon__signal(daemon, SIGTERM);
+}
+
 static void daemon__exit(struct daemon *daemon)
 {
+	struct daemon_session *session, *h;
+
+	list_for_each_entry_safe(session, h, &daemon->sessions, list)
+		daemon_session__remove(session);
+
 	free(daemon->config_real);
 	free(daemon->base);
 }
 
+static int daemon__reconfig(struct daemon *daemon)
+{
+	struct daemon_session *session, *n;
+
+	list_for_each_entry_safe(session, n, &daemon->sessions, list) {
+		/* No change. */
+		if (session->state == OK)
+			continue;
+
+		/* Remove session. */
+		if (session->state == KILL) {
+			if (session->pid > 0) {
+				daemon_session__kill(session);
+				pr_info("reconfig: session '%s' killed\n", session->name);
+			}
+			daemon_session__remove(session);
+			continue;
+		}
+
+		/* Reconfig session. */
+		if (session->pid > 0) {
+			daemon_session__kill(session);
+			pr_info("reconfig: session '%s' killed\n", session->name);
+		}
+		if (daemon_session__run(session, daemon))
+			return -1;
+
+		session->state = OK;
+	}
+
+	return 0;
+}
+
 static int setup_config(struct daemon *daemon)
 {
 	if (daemon->base_user) {
@@ -278,6 +614,9 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 		return -1;
 	}
 
+	if (setup_server_config(daemon))
+		return -1;
+
 	debug_set_file(daemon->out);
 	debug_set_display_time(true);
 
@@ -297,15 +636,23 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 	signal(SIGTERM, sig_handler);
 
 	while (!done && !err) {
-		if (fdarray__poll(&fda, -1)) {
+		err = daemon__reconfig(daemon);
+
+		if (!err && fdarray__poll(&fda, -1)) {
+			bool reconfig = false;
+
 			if (fda.entries[sock_pos].revents & POLLIN)
 				err = handle_server_socket(daemon, sock_fd);
+
+			if (reconfig)
+				err = setup_server_config(daemon);
 		}
 	}
 
 out:
 	fdarray__exit(&fda);
 
+	daemon__kill(daemon);
 	daemon__exit(daemon);
 
 	if (sock_fd != -1)
-- 
2.29.2

