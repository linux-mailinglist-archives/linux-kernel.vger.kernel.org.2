Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9343A0BBA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 07:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhFIFJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 01:09:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:11924 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhFIFJX (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 01:09:23 -0400
IronPort-SDR: aeJRs9fD9LqCj0QgKaWhmqTZEtHsnNgvJqKkH+1CntwitAKuB57ykFw9jUp5gcC+F2le9dTF/s
 lL4GA95r3JwQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="201981035"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="201981035"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 22:07:28 -0700
IronPort-SDR: 9b3Tz4AFBpCJq48F/lFucv7cUg0hdGPiiyEYBF8DVh5bwW4KRm5CNKGQrKOp1uIoDoCZQnoiUF
 Kyq0bnVJJFdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="637882584"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jun 2021 22:07:25 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2] perf stat: Disable NMI watchdog message on hybrid
Date:   Wed,  9 Jun 2021 13:06:00 +0800
Message-Id: <20210609050600.7308-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we run a single workload that only runs on big core, there is always a
ugly message about disabling the NMI watchdog because the atom is not
counted.

Before:

  # ./perf stat true

   Performance counter stats for 'true':

                0.43 msec task-clock                #    0.396 CPUs utilized
                   0      context-switches          #    0.000 /sec
                   0      cpu-migrations            #    0.000 /sec
                  45      page-faults               #  103.918 K/sec
             639,634      cpu_core/cycles/          #    1.477 G/sec
       <not counted>      cpu_atom/cycles/                                              (0.00%)
             643,498      cpu_core/instructions/    #    1.486 G/sec
       <not counted>      cpu_atom/instructions/                                        (0.00%)
             123,715      cpu_core/branches/        #  285.694 M/sec
       <not counted>      cpu_atom/branches/                                            (0.00%)
               4,094      cpu_core/branch-misses/   #    9.454 M/sec
       <not counted>      cpu_atom/branch-misses/                                       (0.00%)

         0.001092407 seconds time elapsed

         0.001144000 seconds user
         0.000000000 seconds sys

  Some events weren't counted. Try disabling the NMI watchdog:
          echo 0 > /proc/sys/kernel/nmi_watchdog
          perf stat ...
          echo 1 > /proc/sys/kernel/nmi_watchdog

  # ./perf stat -e '{cpu_atom/cycles/,msr/tsc/}' true

   Performance counter stats for 'true':

       <not counted>      cpu_atom/cycles/                                              (0.00%)
       <not counted>      msr/tsc/                                                      (0.00%)

         0.001904106 seconds time elapsed

         0.001947000 seconds user
         0.000000000 seconds sys

  Some events weren't counted. Try disabling the NMI watchdog:
          echo 0 > /proc/sys/kernel/nmi_watchdog
          perf stat ...
          echo 1 > /proc/sys/kernel/nmi_watchdog
  The events in group usually have to be from the same PMU. Try reorganizing the group.

Now we disable the NMI watchdog message on hybrid, otherwise there
are too many false positives.

After:

  # ./perf stat true

   Performance counter stats for 'true':

                0.79 msec task-clock                #    0.419 CPUs utilized
                   0      context-switches          #    0.000 /sec
                   0      cpu-migrations            #    0.000 /sec
                  48      page-faults               #   60.889 K/sec
             777,692      cpu_core/cycles/          #  986.519 M/sec
       <not counted>      cpu_atom/cycles/                                              (0.00%)
             669,147      cpu_core/instructions/    #  848.828 M/sec
       <not counted>      cpu_atom/instructions/                                        (0.00%)
             128,635      cpu_core/branches/        #  163.176 M/sec
       <not counted>      cpu_atom/branches/                                            (0.00%)
               4,089      cpu_core/branch-misses/   #    5.187 M/sec
       <not counted>      cpu_atom/branch-misses/                                       (0.00%)

         0.001880649 seconds time elapsed

         0.001935000 seconds user
         0.000000000 seconds sys

  # ./perf stat -e '{cpu_atom/cycles/,msr/tsc/}' true

   Performance counter stats for 'true':

       <not counted>      cpu_atom/cycles/                                              (0.00%)
       <not counted>      msr/tsc/                                                      (0.00%)

         0.000963319 seconds time elapsed

         0.000999000 seconds user
         0.000000000 seconds sys

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v2:
 - If the group was mixed with hybrid event and non-hybrid event,
   the NMI watchdog message was still reported. V2 adds checking
   for hybrid event mixed group.

v1:
 - Get ACK from Jiri.

 tools/perf/util/stat-display.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index b759dfd633b4..c1314f13bc9a 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -404,6 +404,19 @@ static bool is_mixed_hw_group(struct evsel *counter)
 	return false;
 }
 
+static bool is_mixed_hybrid_group(struct evsel *counter)
+{
+	struct evlist *evlist = counter->evlist;
+	struct evsel *pos;
+
+	evlist__for_each_entry(evlist, pos) {
+		if (perf_pmu__is_hybrid(pos->pmu_name))
+			return true;
+	}
+
+	return false;
+}
+
 static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int nr,
 		     struct evsel *counter, double uval,
 		     char *prefix, u64 run, u64 ena, double noise,
@@ -465,9 +478,12 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 			config->csv_sep);
 
 		if (counter->supported) {
-			config->print_free_counters_hint = 1;
-			if (is_mixed_hw_group(counter))
-				config->print_mixed_hw_group_error = 1;
+			if (!is_mixed_hybrid_group(counter)) {
+				if (!perf_pmu__is_hybrid(counter->pmu_name))
+					config->print_free_counters_hint = 1;
+				if (is_mixed_hw_group(counter))
+					config->print_mixed_hw_group_error = 1;
+			}
 		}
 
 		fprintf(config->output, "%-*s%s",
-- 
2.17.1

