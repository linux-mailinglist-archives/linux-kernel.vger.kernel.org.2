Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCF13952AA
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 21:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhE3TYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 15:24:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:21268 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229901AbhE3TYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 15:24:34 -0400
IronPort-SDR: MJ6jpt+2Kf3T21oMiyQ0BL/1A1CK+jZLsZrR8aiunz/nDoBxY+MQyeiHC9XzvJpULzPRvxbtWV
 xZcENmCsOYhQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="190362441"
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="190362441"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2021 12:22:55 -0700
IronPort-SDR: G2NJzbNMSCj97NEkqMw7k9GbJDPT98gRhALb17AIp2zHBxN5HHaV6lSCxGgGvNWufsHTukPvQW
 C6nv2XpWPMSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="415926276"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 30 May 2021 12:22:54 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] perf scripting: Add perf_session to scripting_context
Date:   Sun, 30 May 2021 22:22:59 +0300
Message-Id: <20210530192308.7382-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210530192308.7382-1-adrian.hunter@intel.com>
References: <20210530192308.7382-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is preparation for allowing a script to set the itrace options
for the session if they have not already been set.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-script.c                            | 2 +-
 tools/perf/util/scripting-engines/trace-event-perl.c   | 5 ++++-
 tools/perf/util/scripting-engines/trace-event-python.c | 4 +++-
 tools/perf/util/trace-event-scripting.c                | 6 ++++--
 tools/perf/util/trace-event.h                          | 4 +++-
 5 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 7a7a19f52db5..fd5c257d55a8 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -4017,7 +4017,7 @@ int cmd_script(int argc, const char **argv)
 	}
 
 	if (script_name) {
-		err = scripting_ops->start_script(script_name, argc, argv);
+		err = scripting_ops->start_script(script_name, argc, argv, session);
 		if (err)
 			goto out_delete;
 		pr_debug("perf script started with script %s\n\n", script_name);
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index 5bbf00c1179f..32a721b3e9a5 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -473,11 +473,14 @@ static void run_start_sub(void)
 /*
  * Start trace script
  */
-static int perl_start_script(const char *script, int argc, const char **argv)
+static int perl_start_script(const char *script, int argc, const char **argv,
+			     struct perf_session *session)
 {
 	const char **command_line;
 	int i, err = 0;
 
+	scripting_context->session = session;
+
 	command_line = malloc((argc + 2) * sizeof(const char *));
 	command_line[0] = "";
 	command_line[1] = script;
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index d99f71916af7..02d134b6ba8d 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1746,7 +1746,8 @@ static void _free_command_line(wchar_t **command_line, int num)
 /*
  * Start trace script
  */
-static int python_start_script(const char *script, int argc, const char **argv)
+static int python_start_script(const char *script, int argc, const char **argv,
+			       struct perf_session *session)
 {
 	struct tables *tables = &tables_global;
 #if PY_MAJOR_VERSION < 3
@@ -1762,6 +1763,7 @@ static int python_start_script(const char *script, int argc, const char **argv)
 	int i, err = 0;
 	FILE *fp;
 
+	scripting_context->session = session;
 #if PY_MAJOR_VERSION < 3
 	command_line = malloc((argc + 1) * sizeof(const char *));
 	command_line[0] = script;
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index a2f0c1e460a2..7172ca05265f 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -66,7 +66,8 @@ static void print_python_unsupported_msg(void)
 
 static int python_start_script_unsupported(const char *script __maybe_unused,
 					   int argc __maybe_unused,
-					   const char **argv __maybe_unused)
+					   const char **argv __maybe_unused,
+					   struct perf_session *session __maybe_unused)
 {
 	print_python_unsupported_msg();
 
@@ -131,7 +132,8 @@ static void print_perl_unsupported_msg(void)
 
 static int perl_start_script_unsupported(const char *script __maybe_unused,
 					 int argc __maybe_unused,
-					 const char **argv __maybe_unused)
+					 const char **argv __maybe_unused,
+					 struct perf_session *session __maybe_unused)
 {
 	print_perl_unsupported_msg();
 
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index a939318b88a6..73f5b29472f7 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -73,7 +73,8 @@ struct perf_stat_config;
 struct scripting_ops {
 	const char *name;
 	const char *dirname; /* For script path .../scripts/<dirname>/... */
-	int (*start_script) (const char *script, int argc, const char **argv);
+	int (*start_script)(const char *script, int argc, const char **argv,
+			    struct perf_session *session);
 	int (*flush_script) (void);
 	int (*stop_script) (void);
 	void (*process_event) (union perf_event *event,
@@ -107,6 +108,7 @@ struct scripting_context {
 	struct evsel *evsel;
 	struct addr_location *al;
 	struct addr_location *addr_al;
+	struct perf_session *session;
 };
 
 void scripting_context__update(struct scripting_context *scripting_context,
-- 
2.17.1

