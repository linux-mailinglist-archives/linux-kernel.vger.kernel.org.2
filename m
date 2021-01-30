Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A2B30991F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 01:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhA3X73 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 30 Jan 2021 18:59:29 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:51820 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232539AbhA3Xub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 18:50:31 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-SMmFNuE4Ni2Oz5xKn4RYLQ-1; Sat, 30 Jan 2021 18:49:10 -0500
X-MC-Unique: SMmFNuE4Ni2Oz5xKn4RYLQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5364A10054FF;
        Sat, 30 Jan 2021 23:49:08 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8D8A60DA0;
        Sat, 30 Jan 2021 23:49:05 +0000 (UTC)
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
Subject: [PATCH 02/24] perf daemon: Add config option
Date:   Sun, 31 Jan 2021 00:48:34 +0100
Message-Id: <20210130234856.271282-3-jolsa@kernel.org>
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

Adding config option and base functionality that takes the option
argument (if specified) and other system config locations and
produces 'acting' config file path.

The actual config file processing is coming in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 49 +++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 8b13e455ac40..1f2393faad75 100644
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
@@ -31,6 +35,37 @@ static void sig_handler(int sig __maybe_unused)
 	done = true;
 }
 
+static void daemon__free(struct daemon *daemon)
+{
+	free(daemon->config_real);
+}
+
+static void daemon__exit(struct daemon *daemon)
+{
+	daemon__free(daemon);
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
@@ -44,6 +79,11 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 	if (argc)
 		usage_with_options(daemon_usage, start_options);
 
+	if (setup_config(daemon)) {
+		pr_err("failed: config not found\n");
+		return -1;
+	}
+
 	debug_set_file(daemon->out);
 	debug_set_display_time(true);
 
@@ -56,6 +96,8 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 		sleep(1);
 	}
 
+	daemon__exit(daemon);
+
 	pr_info("daemon exited\n");
 	fclose(daemon->out);
 	return err;
@@ -65,6 +107,8 @@ int cmd_daemon(int argc, const char **argv)
 {
 	struct option daemon_options[] = {
 		OPT_INCR('v', "verbose", &verbose, "be more verbose"),
+		OPT_STRING(0, "config", &__daemon.config,
+			"config file", "config file path"),
 		OPT_END()
 	};
 
@@ -82,5 +126,10 @@ int cmd_daemon(int argc, const char **argv)
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

