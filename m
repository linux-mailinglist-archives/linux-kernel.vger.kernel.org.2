Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BF53243B6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 19:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbhBXSZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 13:25:20 -0500
Received: from foss.arm.com ([217.140.110.172]:43440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234784AbhBXSZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 13:25:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE55BD6E;
        Wed, 24 Feb 2021 10:24:26 -0800 (PST)
Received: from e120189.arm.com (unknown [10.57.15.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7AF783F73B;
        Wed, 24 Feb 2021 10:24:24 -0800 (PST)
From:   Pierre.Gondois@arm.com
To:     linux-kernel@vger.kernel.org
Cc:     douglas.raillard@arm.com, Pierre Gondois <Pierre.Gondois@arm.com>,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Subject: [PATCH v1] perf: cast (struct timeval).tv_sec when printing
Date:   Wed, 24 Feb 2021 18:24:10 +0000
Message-Id: <20210224182410.5366-1-Pierre.Gondois@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre Gondois <Pierre.Gondois@arm.com>

The musl-libc [1] defines (struct timeval).tv_sec as a
'long long' for arm and other architectures. The default
build having a '-Wformat' flag, not casting the field
when printing prevents from building perf.

This patch casts the (struct timeval).tv_sec fields to the
expected format.

[1] git://git.musl-libc.org/musl

Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
---
 tools/perf/bench/sched-messaging.c | 4 ++--
 tools/perf/bench/sched-pipe.c      | 4 ++--
 tools/perf/bench/syscall.c         | 4 ++--
 tools/perf/util/header.c           | 4 ++--
 tools/perf/util/stat-display.c     | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
index cecce93ccc63..488f6e6ba1a5 100644
--- a/tools/perf/bench/sched-messaging.c
+++ b/tools/perf/bench/sched-messaging.c
@@ -309,11 +309,11 @@ int bench_sched_messaging(int argc, const char **argv)
 		       num_groups, num_groups * 2 * num_fds,
 		       thread_mode ? "threads" : "processes");
 		printf(" %14s: %lu.%03lu [sec]\n", "Total time",
-		       diff.tv_sec,
+		       (unsigned long) diff.tv_sec,
 		       (unsigned long) (diff.tv_usec / USEC_PER_MSEC));
 		break;
 	case BENCH_FORMAT_SIMPLE:
-		printf("%lu.%03lu\n", diff.tv_sec,
+		printf("%lu.%03lu\n", (unsigned long) diff.tv_sec,
 		       (unsigned long) (diff.tv_usec / USEC_PER_MSEC));
 		break;
 	default:
diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
index 3c88d1f201f1..a960e7a93aec 100644
--- a/tools/perf/bench/sched-pipe.c
+++ b/tools/perf/bench/sched-pipe.c
@@ -156,7 +156,7 @@ int bench_sched_pipe(int argc, const char **argv)
 		result_usec += diff.tv_usec;
 
 		printf(" %14s: %lu.%03lu [sec]\n\n", "Total time",
-		       diff.tv_sec,
+		       (unsigned long) diff.tv_sec,
 		       (unsigned long) (diff.tv_usec / USEC_PER_MSEC));
 
 		printf(" %14lf usecs/op\n",
@@ -168,7 +168,7 @@ int bench_sched_pipe(int argc, const char **argv)
 
 	case BENCH_FORMAT_SIMPLE:
 		printf("%lu.%03lu\n",
-		       diff.tv_sec,
+		       (unsigned long) diff.tv_sec,
 		       (unsigned long) (diff.tv_usec / USEC_PER_MSEC));
 		break;
 
diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
index 5fe621cff8e9..9b751016f4b6 100644
--- a/tools/perf/bench/syscall.c
+++ b/tools/perf/bench/syscall.c
@@ -54,7 +54,7 @@ int bench_syscall_basic(int argc, const char **argv)
 		result_usec += diff.tv_usec;
 
 		printf(" %14s: %lu.%03lu [sec]\n\n", "Total time",
-		       diff.tv_sec,
+		       (unsigned long) diff.tv_sec,
 		       (unsigned long) (diff.tv_usec/1000));
 
 		printf(" %14lf usecs/op\n",
@@ -66,7 +66,7 @@ int bench_syscall_basic(int argc, const char **argv)
 
 	case BENCH_FORMAT_SIMPLE:
 		printf("%lu.%03lu\n",
-		       diff.tv_sec,
+		       (unsigned long) diff.tv_sec,
 		       (unsigned long) (diff.tv_usec / 1000));
 		break;
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 4fe9e2a54346..20effdff76ce 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1618,8 +1618,8 @@ static void print_clock_data(struct feat_fd *ff, FILE *fp)
 
 	fprintf(fp, "# clockid: %s (%u)\n", clockid_name(clockid), clockid);
 	fprintf(fp, "# reference time: %s = %ld.%06d (TOD) = %ld.%09ld (%s)\n",
-		    tstr, tod_ns.tv_sec, (int) tod_ns.tv_usec,
-		    clockid_ns.tv_sec, clockid_ns.tv_nsec,
+		    tstr, (long) tod_ns.tv_sec, (int) tod_ns.tv_usec,
+		    (long) clockid_ns.tv_sec, clockid_ns.tv_nsec,
 		    clockid_name(clockid));
 }
 
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index cce7a76d6473..7f09cdaf5b60 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -983,7 +983,7 @@ static void print_interval(struct perf_stat_config *config,
 	if (config->interval_clear)
 		puts(CONSOLE_CLEAR);
 
-	sprintf(prefix, "%6lu.%09lu%s", ts->tv_sec, ts->tv_nsec, config->csv_sep);
+	sprintf(prefix, "%6lu.%09lu%s", (unsigned long) ts->tv_sec, ts->tv_nsec, config->csv_sep);
 
 	if ((num_print_interval == 0 && !config->csv_output) || config->interval_clear) {
 		switch (config->aggr_mode) {
-- 
2.17.1

