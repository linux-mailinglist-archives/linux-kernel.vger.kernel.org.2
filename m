Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BC2314157
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbhBHVLD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 Feb 2021 16:11:03 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:56508 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236608AbhBHUKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:10:14 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-avzmIZN_M_eiF1ntnkvKWg-1; Mon, 08 Feb 2021 15:09:19 -0500
X-MC-Unique: avzmIZN_M_eiF1ntnkvKWg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C449107ACE3;
        Mon,  8 Feb 2021 20:09:17 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE78319C59;
        Mon,  8 Feb 2021 20:09:14 +0000 (UTC)
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
Subject: [PATCH 02/24] perf daemon: Add config option
Date:   Mon,  8 Feb 2021 21:08:46 +0100
Message-Id: <20210208200908.1019149-3-jolsa@kernel.org>
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

Adding config option and base functionality that takes the option
argument (if specified) and other system config locations and
produces 'acting' config file path.

The actual config file processing is coming in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-daemon.txt |  4 +++
 tools/perf/builtin-daemon.c              | 44 ++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/tools/perf/Documentation/perf-daemon.txt b/tools/perf/Documentation/perf-daemon.txt
index d05b8dab0a6a..ba3f88510aee 100644
--- a/tools/perf/Documentation/perf-daemon.txt
+++ b/tools/perf/Documentation/perf-daemon.txt
@@ -27,6 +27,10 @@ OPTIONS
 --verbose::
 	Be more verbose.
 
+--config=<PATH>::
+	Config file path. If not provided, perf will check system and default
+	locations (/etc/perfconfig, $HOME/.perfconfig).
+
 All generic options are available also under commands.
 
 
diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 8b13e455ac40..90b5a8ea9dda 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -3,14 +3,18 @@
 #include <linux/limits.h>
 #include <string.h>
 #include <signal.h>
+#include <stdlib.h>
 #include <stdio.h>
 #include <unistd.h>
 #include "builtin.h"
 #include "perf.h"
 #include "debug.h"
+#include "config.h"
 #include "util.h"
 
 struct daemon {
+	const char		*config;
+	char			*config_real;
 	char			*base;
 	FILE			*out;
 	char			 perf[PATH_MAX];
@@ -31,6 +35,32 @@ static void sig_handler(int sig __maybe_unused)
 	done = true;
 }
 
+static void daemon__exit(struct daemon *daemon)
+{
+	free(daemon->config_real);
+}
+
+static int setup_config(struct daemon *daemon)
+{
+	if (daemon->config) {
+		char *real = realpath(daemon->config, NULL);
+
+		if (!real) {
+			perror("failed: realpath");
+			return -1;
+		}
+		daemon->config_real = real;
+		return 0;
+	}
+
+	if (perf_config_system() && !access(perf_etc_perfconfig(), R_OK))
+		daemon->config_real = strdup(perf_etc_perfconfig());
+	else if (perf_config_global() && perf_home_perfconfig())
+		daemon->config_real = strdup(perf_home_perfconfig());
+
+	return daemon->config_real ? 0 : -1;
+}
+
 static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 		       int argc, const char **argv)
 {
@@ -44,6 +74,11 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 	if (argc)
 		usage_with_options(daemon_usage, start_options);
 
+	if (setup_config(daemon)) {
+		pr_err("failed: config not found\n");
+		return -1;
+	}
+
 	debug_set_file(daemon->out);
 	debug_set_display_time(true);
 
@@ -56,6 +91,8 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 		sleep(1);
 	}
 
+	daemon__exit(daemon);
+
 	pr_info("daemon exited\n");
 	fclose(daemon->out);
 	return err;
@@ -65,6 +102,8 @@ int cmd_daemon(int argc, const char **argv)
 {
 	struct option daemon_options[] = {
 		OPT_INCR('v', "verbose", &verbose, "be more verbose"),
+		OPT_STRING(0, "config", &__daemon.config,
+			"config file", "config file path"),
 		OPT_END()
 	};
 
@@ -82,5 +121,10 @@ int cmd_daemon(int argc, const char **argv)
 		return -1;
 	}
 
+	if (setup_config(&__daemon)) {
+		pr_err("failed: config not found\n");
+		return -1;
+	}
+
 	return -1;
 }
-- 
2.29.2

