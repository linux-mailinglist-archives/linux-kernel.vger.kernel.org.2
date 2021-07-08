Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34513C16D7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 18:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhGHQHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 12:07:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:18800 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229542AbhGHQHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 12:07:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="196808730"
X-IronPort-AV: E=Sophos;i="5.84,224,1620716400"; 
   d="scan'208";a="196808730"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 09:04:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,224,1620716400"; 
   d="scan'208";a="428431061"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 08 Jul 2021 09:04:58 -0700
From:   kan.liang@intel.com
To:     acme@kernel.org, mingo@redhat.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, yao.jin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf record: Add a dummy event for a hybrid system
Date:   Thu,  8 Jul 2021 09:03:32 -0700
Message-Id: <1625760212-18441-1-git-send-email-kan.liang@intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Some symbols may not be resolved if a user only monitor one type of PMU.

 $ sudo perf record -e cpu_atom/branch-instructions/ ./big_small_workload
 $ sudo perf report –stdio
 # Overhead  Command    Shared Object      Symbol
 # ........  .........  .................
 # ......................................
 #
    28.02%  perf-exec  [unknown]          [.] 0x0000000000401cf6
    11.32%  perf-exec  [unknown]          [.] 0x0000000000401d04
    10.90%  perf-exec  [unknown]          [.] 0x0000000000401d11
    10.61%  perf-exec  [unknown]          [.] 0x0000000000401cfc

To parse symbols, the side-band events, e.g., COMM, which are generated
by the kernel are required. To decide whether to generate the side-band
event, the kernel relies on the event_filter_match() to filter the
unrelated events. On a hybrid system, the event_filter_match() further
checks the CPU mask of the current enabled PMU. If an event is collected
on the CPU which doesn't have an enabled PMU, it's treated as an
unrelated event.

The "big_small_workload" is created in a big core, but runs on a small
core. The side-band events are filtered, because the user only monitors
the PMU of the small core. The big core PMU is not enabled.

For a hybrid system, a dummy event is required to generate the complete
side-band events.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-record.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 3337b5f..99607b9 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -891,11 +891,12 @@ static int record__open(struct record *rec)
 	int rc = 0;
 
 	/*
-	 * For initial_delay or system wide, we need to add a dummy event so
-	 * that we can track PERF_RECORD_MMAP to cover the delay of waiting or
-	 * event synthesis.
+	 * For initial_delay or system wide or a hybrid system, we need to
+	 * add a dummy event so that we can track PERF_RECORD_MMAP to cover
+	 * the delay of waiting or event synthesis.
 	 */
-	if (opts->initial_delay || target__has_cpu(&opts->target)) {
+	if (opts->initial_delay || target__has_cpu(&opts->target) ||
+	    perf_pmu__has_hybrid()) {
 		pos = evlist__get_tracking_event(evlist);
 		if (!evsel__is_dummy_event(pos)) {
 			/* Set up dummy event. */
-- 
2.7.4

