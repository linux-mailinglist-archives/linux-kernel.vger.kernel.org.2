Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15E334163C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 08:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbhCSHC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 03:02:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:58016 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233819AbhCSHC0 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 03:02:26 -0400
IronPort-SDR: kgLa6CEnilUVWxeuYnmDbzLNst9oYesejSESPxZJsWBd1fu/lhEchWxqYXIIb+OvZXcJu6l0eF
 J4HpTHmnBN+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="189219773"
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; 
   d="scan'208";a="189219773"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 00:02:25 -0700
IronPort-SDR: CFQXGrvJvlnULvU5q3PAw3hkp6SGvAqCTs4ymPiDZq9jXS+eBTtXnpmSdvvHKAMkLnpAgIo/4h
 kfD6siG/iZ1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; 
   d="scan'208";a="413403376"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga008.jf.intel.com with ESMTP; 19 Mar 2021 00:02:22 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 1/2] perf stat: Align CSV output for summary mode
Date:   Fri, 19 Mar 2021 15:01:55 +0800
Message-Id: <20210319070156.20394-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf-stat has supported the summary mode. But the summary
lines break the CSV output so it's hard for scripts to parse
the result.

Before:

  # perf stat -x, -I1000 --interval-count 1 --summary
       1.001323097,8013.48,msec,cpu-clock,8013483384,100.00,8.013,CPUs utilized
       1.001323097,270,,context-switches,8013513297,100.00,0.034,K/sec
       1.001323097,13,,cpu-migrations,8013530032,100.00,0.002,K/sec
       1.001323097,184,,page-faults,8013546992,100.00,0.023,K/sec
       1.001323097,20574191,,cycles,8013551506,100.00,0.003,GHz
       1.001323097,10562267,,instructions,8013564958,100.00,0.51,insn per cycle
       1.001323097,2019244,,branches,8013575673,100.00,0.252,M/sec
       1.001323097,106152,,branch-misses,8013585776,100.00,5.26,of all branches
  8013.48,msec,cpu-clock,8013483384,100.00,7.984,CPUs utilized
  270,,context-switches,8013513297,100.00,0.034,K/sec
  13,,cpu-migrations,8013530032,100.00,0.002,K/sec
  184,,page-faults,8013546992,100.00,0.023,K/sec
  20574191,,cycles,8013551506,100.00,0.003,GHz
  10562267,,instructions,8013564958,100.00,0.51,insn per cycle
  2019244,,branches,8013575673,100.00,0.252,M/sec
  106152,,branch-misses,8013585776,100.00,5.26,of all branches

The summary line loses the timestamp column, which breaks the
CVS output.

We add a column at the original 'timestamp' position and it just says
'summary' for the summary line.

After:

  # perf stat -x, -I1000 --interval-count 1 --summary
       1.001196053,8012.72,msec,cpu-clock,8012722903,100.00,8.013,CPUs utilized
       1.001196053,218,,context-switches,8012753271,100.00,0.027,K/sec
       1.001196053,9,,cpu-migrations,8012769767,100.00,0.001,K/sec
       1.001196053,0,,page-faults,8012786257,100.00,0.000,K/sec
       1.001196053,15004518,,cycles,8012790637,100.00,0.002,GHz
       1.001196053,7954691,,instructions,8012804027,100.00,0.53,insn per cycle
       1.001196053,1590259,,branches,8012814766,100.00,0.198,M/sec
       1.001196053,82601,,branch-misses,8012824365,100.00,5.19,of all branches
           summary,8012.72,msec,cpu-clock,8012722903,100.00,7.986,CPUs utilized
           summary,218,,context-switches,8012753271,100.00,0.027,K/sec
           summary,9,,cpu-migrations,8012769767,100.00,0.001,K/sec
           summary,0,,page-faults,8012786257,100.00,0.000,K/sec
           summary,15004518,,cycles,8012790637,100.00,0.002,GHz
           summary,7954691,,instructions,8012804027,100.00,0.53,insn per cycle
           summary,1590259,,branches,8012814766,100.00,0.198,M/sec
           summary,82601,,branch-misses,8012824365,100.00,5.19,of all branches

Now it's easy for script to analyse the summary lines.

Of course, we also consider not to break possible existing scripts which
have fixed the broken CVS format, we provide a optiton '--no-cvs-summary'
to keep original output.

  # perf stat -x, -I1000 --interval-count 1 --summary --no-cvs-summary
       1.001213261,8012.67,msec,cpu-clock,8012672327,100.00,8.013,CPUs utilized
       1.001213261,197,,context-switches,8012703742,100.00,24.586,/sec
       1.001213261,9,,cpu-migrations,8012720902,100.00,1.123,/sec
       1.001213261,644,,page-faults,8012738266,100.00,80.373,/sec
       1.001213261,18350698,,cycles,8012744109,100.00,0.002,GHz
       1.001213261,12745021,,instructions,8012759001,100.00,0.69,insn per cycle
       1.001213261,2458033,,branches,8012770864,100.00,306.768,K/sec
       1.001213261,102107,,branch-misses,8012781751,100.00,4.15,of all branches
  8012.67,msec,cpu-clock,8012672327,100.00,7.985,CPUs utilized
  197,,context-switches,8012703742,100.00,24.586,/sec
  9,,cpu-migrations,8012720902,100.00,1.123,/sec
  644,,page-faults,8012738266,100.00,80.373,/sec
  18350698,,cycles,8012744109,100.00,0.002,GHz
  12745021,,instructions,8012759001,100.00,0.69,insn per cycle
  2458033,,branches,8012770864,100.00,306.768,K/sec
  102107,,branch-misses,8012781751,100.00,4.15,of all branches

This option can be enabled in perf config by setting the variable
'stat.no-cvs-summary'.

  # perf config stat.no-cvs-summary=true

  # perf config -l
  stat.no-cvs-summary=true

  # perf stat -x, -I1000 --interval-count 1 --summary
       1.001330198,8013.28,msec,cpu-clock,8013279201,100.00,8.013,CPUs utilized
       1.001330198,205,,context-switches,8013308394,100.00,25.583,/sec
       1.001330198,10,,cpu-migrations,8013324681,100.00,1.248,/sec
       1.001330198,0,,page-faults,8013340926,100.00,0.000,/sec
       1.001330198,8027742,,cycles,8013344503,100.00,0.001,GHz
       1.001330198,2871717,,instructions,8013356501,100.00,0.36,insn per cycle
       1.001330198,553564,,branches,8013366204,100.00,69.081,K/sec
       1.001330198,54021,,branch-misses,8013375952,100.00,9.76,of all branches
  8013.28,msec,cpu-clock,8013279201,100.00,7.985,CPUs utilized
  205,,context-switches,8013308394,100.00,25.583,/sec
  10,,cpu-migrations,8013324681,100.00,1.248,/sec
  0,,page-faults,8013340926,100.00,0.000,/sec
  8027742,,cycles,8013344503,100.00,0.001,GHz
  2871717,,instructions,8013356501,100.00,0.36,insn per cycle
  553564,,branches,8013366204,100.00,69.081,K/sec
  54021,,branch-misses,8013375952,100.00,9.76,of all branches

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 v3:
   - No change.

 v2:
   - Add new option '--no-cvs-summary'.
   - Add perf config variable 'stat.no-cvs-summary'.

 tools/perf/Documentation/perf-stat.txt | 9 +++++++++
 tools/perf/builtin-stat.c              | 7 +++++++
 tools/perf/util/config.c               | 3 +++
 tools/perf/util/stat-display.c         | 6 ++++++
 tools/perf/util/stat.h                 | 2 ++
 5 files changed, 27 insertions(+)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 3055aad38d46..854597e70406 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -471,6 +471,15 @@ convenient for post processing.
 --summary::
 Print summary for interval mode (-I).
 
+--no-cvs-summary::
+Don't print 'summary' at the first column for CVS summary output.
+This option must be used with -x and --summary.
+
+This option can be enabled in perf config by setting the variable
+'stat.no-cvs-summary'.
+
+$ perf config stat.no-cvs-summary=true
+
 EXAMPLES
 --------
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2e2e4a8345ea..3823dd5fd6e8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1083,6 +1083,11 @@ void perf_stat__set_big_num(int set)
 	stat_config.big_num = (set != 0);
 }
 
+void perf_stat__set_no_cvs_summary(int set)
+{
+	stat_config.no_cvs_summary = (set != 0);
+}
+
 static int stat__set_big_num(const struct option *opt __maybe_unused,
 			     const char *s __maybe_unused, int unset)
 {
@@ -1235,6 +1240,8 @@ static struct option stat_options[] = {
 		    "threads of same physical core"),
 	OPT_BOOLEAN(0, "summary", &stat_config.summary,
 		       "print summary for interval mode"),
+	OPT_BOOLEAN(0, "no-cvs-summary", &stat_config.no_cvs_summary,
+		       "don't print 'summary' for CVS summary output"),
 	OPT_BOOLEAN(0, "quiet", &stat_config.quiet,
 			"don't print output (useful with record)"),
 #ifdef HAVE_LIBPFM
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 6984c77068a3..dbf585460791 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -457,6 +457,9 @@ static int perf_stat_config(const char *var, const char *value)
 	if (!strcmp(var, "stat.big-num"))
 		perf_stat__set_big_num(perf_config_bool(var, value));
 
+	if (!strcmp(var, "stat.no-cvs-summary"))
+		perf_stat__set_no_cvs_summary(perf_config_bool(var, value));
+
 	/* Add other config variables here. */
 	return 0;
 }
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 7f09cdaf5b60..2e7fec0bd8f3 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -439,6 +439,12 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 		if (counter->cgrp)
 			os.nfields++;
 	}
+
+	if (!config->no_cvs_summary && config->csv_output &&
+	    config->summary && !config->interval) {
+		fprintf(config->output, "%16s%s", "summary", config->csv_sep);
+	}
+
 	if (run == 0 || ena == 0 || counter->counts->scaled == -1) {
 		if (config->metric_only) {
 			pm(config, &os, NULL, "", "", 0);
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 41107b8deac5..def0cdc84133 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -128,6 +128,7 @@ struct perf_stat_config {
 	bool			 all_user;
 	bool			 percore_show_thread;
 	bool			 summary;
+	bool			 no_cvs_summary;
 	bool			 metric_no_group;
 	bool			 metric_no_merge;
 	bool			 stop_read_counter;
@@ -160,6 +161,7 @@ struct perf_stat_config {
 };
 
 void perf_stat__set_big_num(int set);
+void perf_stat__set_no_cvs_summary(int set);
 
 void update_stats(struct stats *stats, u64 val);
 double avg_stats(struct stats *stats);
-- 
2.17.1

