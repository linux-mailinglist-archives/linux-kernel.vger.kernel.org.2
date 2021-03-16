Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B6A33CE9F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 08:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhCPH3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 03:29:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:14524 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229780AbhCPH33 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 03:29:29 -0400
IronPort-SDR: O+hDVeX70alJ4315+z3BD3EqQAQGVY269dBu+i+iSwNTK1K45HrdJROIdCWPiEv5AOLvtbQ3pk
 cVaZVhUqhpjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="209143061"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="209143061"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 00:29:29 -0700
IronPort-SDR: LUymvqHJeRkX4fjAHcTp/JXOI8pz3vYYbJfeA6EYIdKM1k2QQcyg9L0HpyrKvJXQ+qK8pQ57Jl
 kA0mJVc1WSSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="432916891"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 16 Mar 2021 00:29:27 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf stat: Align CSV output for summary mode
Date:   Tue, 16 Mar 2021 15:29:00 +0800
Message-Id: <20210316072900.1739-1-yao.jin@linux.intel.com>
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

We add a column at the 'timestamp' position and it just says 'summary'
for the summary line.

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

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/stat-display.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 7f09cdaf5b60..c4183d3e87a4 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -439,6 +439,10 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 		if (counter->cgrp)
 			os.nfields++;
 	}
+
+	if (config->csv_output && config->summary && !config->interval)
+		fprintf(config->output, "%16s%s", "summary", config->csv_sep);
+
 	if (run == 0 || ena == 0 || counter->counts->scaled == -1) {
 		if (config->metric_only) {
 			pm(config, &os, NULL, "", "", 0);
-- 
2.17.1

