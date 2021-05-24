Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D2938E13C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 08:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhEXG6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 02:58:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:44083 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232120AbhEXG6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 02:58:24 -0400
IronPort-SDR: CDmAHf6C4gxR+mDBjiaaWRS3CrRKK4OtLlspvS2HHAq7Omfan0uqfo0ohz+VXkbocp9oitgJm4
 ememT/XVpibA==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="201612056"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="201612056"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 23:56:55 -0700
IronPort-SDR: sUVvNJlJf54rjSoEdrVCRzlMKn5mHQ5aCUGfRnjC4GtEY6zzEqT5av3QQ+cHI9rH7M4nF7DGOj
 C39RMMh3EoXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="442694722"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga008.fm.intel.com with ESMTP; 23 May 2021 23:56:54 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH V3] perf script: Find script file relative to exec path
Date:   Mon, 24 May 2021 09:57:18 +0300
Message-Id: <20210524065718.11421-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow perf script to find a script in the exec path.

Example:

Before:

 $ perf record -a -e intel_pt/branch=0/ sleep 0.1
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.954 MB perf.data ]
 $ perf script intel-pt-events.py 2>&1 | head -3
   Error: Couldn't find script `intel-pt-events.py'
   See perf script -l for available scripts.
 $ perf script -s intel-pt-events.py 2>&1 | head -3
 Can't open python script "intel-pt-events.py": No such file or directory
 $ perf script ~/libexec/perf-core/scripts/python/intel-pt-events.py 2>&1 | head -3
   Error: Couldn't find script `/home/ahunter/libexec/perf-core/scripts/python/intel-pt-events.py'
   See perf script -l for available scripts.
 $

After:

 $ perf script intel-pt-events.py 2>&1 | head -3
 Intel PT Power Events and PTWRITE
            perf  8123/8123  [000]       551.230753986     cbr:  42  freq: 4219 MHz  (156%)                0 [unknown] ([unknown])
            perf  8123/8123  [001]       551.230808216     cbr:  42  freq: 4219 MHz  (156%)                0 [unknown] ([unknown])
 $ perf script -s intel-pt-events.py 2>&1 | head -3
 Intel PT Power Events and PTWRITE
            perf  8123/8123  [000]       551.230753986     cbr:  42  freq: 4219 MHz  (156%)                0 [unknown] ([unknown])
            perf  8123/8123  [001]       551.230808216     cbr:  42  freq: 4219 MHz  (156%)                0 [unknown] ([unknown])
 $ perf script ~/libexec/perf-core/scripts/python/intel-pt-events.py 2>&1 | head -3
 Intel PT Power Events and PTWRITE
            perf  8123/8123  [000]       551.230753986     cbr:  42  freq: 4219 MHz  (156%)                0 [unknown] ([unknown])
            perf  8123/8123  [001]       551.230808216     cbr:  42  freq: 4219 MHz  (156%)                0 [unknown] ([unknown])
 $

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V3:

	Fix typo 'perf' -> 'perl'


 tools/perf/builtin-script.c                   | 43 ++++++++++++++++++-
 .../util/scripting-engines/trace-event-perl.c |  1 +
 .../scripting-engines/trace-event-python.c    |  1 +
 tools/perf/util/trace-event-scripting.c       |  2 +
 tools/perf/util/trace-event.h                 |  1 +
 5 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 1280cbfad4db..2a062466c69f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2665,6 +2665,37 @@ static void list_available_languages(void)
 	fprintf(stderr, "\n");
 }
 
+/* Find script file relative to current directory or exec path */
+static char *find_script(const char *script)
+{
+	char path[PATH_MAX];
+
+	if (!scripting_ops) {
+		const char *ext = strrchr(script, '.');
+
+		if (!ext)
+			return NULL;
+
+		scripting_ops = script_spec__lookup(++ext);
+		if (!scripting_ops)
+			return NULL;
+	}
+
+	if (access(script, R_OK)) {
+		char *exec_path = get_argv_exec_path();
+
+		if (!exec_path)
+			return NULL;
+		snprintf(path, sizeof(path), "%s/scripts/%s/%s",
+			 exec_path, scripting_ops->dirname, script);
+		free(exec_path);
+		script = path;
+		if (access(script, R_OK))
+			return NULL;
+	}
+	return strdup(script);
+}
+
 static int parse_scriptname(const struct option *opt __maybe_unused,
 			    const char *str, int unset __maybe_unused)
 {
@@ -2706,7 +2737,9 @@ static int parse_scriptname(const struct option *opt __maybe_unused,
 		}
 	}
 
-	script_name = strdup(script);
+	script_name = find_script(script);
+	if (!script_name)
+		script_name = strdup(script);
 
 	return 0;
 }
@@ -3718,6 +3751,12 @@ int cmd_script(int argc, const char **argv)
 		rep_script_path = get_script_path(argv[0], REPORT_SUFFIX);
 
 		if (!rec_script_path && !rep_script_path) {
+			script_name = find_script(argv[0]);
+			if (script_name) {
+				argc -= 1;
+				argv += 1;
+				goto script_found;
+			}
 			usage_with_options_msg(script_usage, options,
 				"Couldn't find script `%s'\n\n See perf"
 				" script -l for available scripts.\n", argv[0]);
@@ -3810,7 +3849,7 @@ int cmd_script(int argc, const char **argv)
 		free(__argv);
 		exit(-1);
 	}
-
+script_found:
 	if (rec_script_path)
 		script_path = rec_script_path;
 	if (rep_script_path)
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index 0e608a5ef599..865d310968fb 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -750,6 +750,7 @@ sub print_backtrace\n\
 
 struct scripting_ops perl_scripting_ops = {
 	.name = "Perl",
+	.dirname = "perl",
 	.start_script = perl_start_script,
 	.flush_script = perl_flush_script,
 	.stop_script = perl_stop_script,
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 4e4aa4c97ac5..db8f24341406 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1876,6 +1876,7 @@ static int python_generate_script(struct tep_handle *pevent, const char *outfile
 
 struct scripting_ops python_scripting_ops = {
 	.name			= "Python",
+	.dirname		= "python",
 	.start_script		= python_start_script,
 	.flush_script		= python_flush_script,
 	.stop_script		= python_stop_script,
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index 714581b0de65..721f38c0d5cf 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -63,6 +63,7 @@ static int python_generate_script_unsupported(struct tep_handle *pevent
 
 struct scripting_ops python_scripting_unsupported_ops = {
 	.name = "Python",
+	.dirname = "python",
 	.start_script = python_start_script_unsupported,
 	.flush_script = flush_script_unsupported,
 	.stop_script = stop_script_unsupported,
@@ -126,6 +127,7 @@ static int perl_generate_script_unsupported(struct tep_handle *pevent
 
 struct scripting_ops perl_scripting_unsupported_ops = {
 	.name = "Perl",
+	.dirname = "perl",
 	.start_script = perl_start_script_unsupported,
 	.flush_script = flush_script_unsupported,
 	.stop_script = stop_script_unsupported,
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 72fdf2a3577c..39fb39ed6612 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -71,6 +71,7 @@ struct perf_stat_config;
 
 struct scripting_ops {
 	const char *name;
+	const char *dirname; /* For script path .../scripts/<dirname>/... */
 	int (*start_script) (const char *script, int argc, const char **argv);
 	int (*flush_script) (void);
 	int (*stop_script) (void);
-- 
2.17.1

