Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C74313D0B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbhBHSSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:18:01 -0500
Received: from mga09.intel.com ([134.134.136.24]:27981 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234062AbhBHPoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:44:02 -0500
IronPort-SDR: rneLbsfwukJL/4ylAsOEzLqn8Qqf8XsRDVEER4sZXQFtNwIkcnT69zbAUb2b6nOzldSXb5C+6k
 ceRx9zbqU69Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="181874631"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="181874631"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:37 -0800
IronPort-SDR: zPzWR2yG+tSalDVm/l/tSS9nRlhKXqYowMEJLOhuxfTk5G7HPoQ2RZs1xuK1r9YF2IGFGVrU94
 42xSUBu0+qCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820929"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:37 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: [PATCH 44/49] perf stat: Uniquify hybrid event name
Date:   Mon,  8 Feb 2021 07:25:41 -0800
Message-Id: <1612797946-18784-45-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

It would be useful to tell user the pmu which the event belongs to.
perf-stat has supported '--no-merge' option and it can print the pmu
name after the event name.

Now this option is enabled by default for hybrid platform.

Before:

root@otcpl-adl-s-2:~# ./perf stat -e cycles -a -- sleep 1

 Performance counter stats for 'system wide':

        10,301,466      cycles
         1,557,794      cycles

       1.002068584 seconds time elapsed

After:

root@otcpl-adl-s-2:~# ./perf stat -e cycles -a -- sleep 1

 Performance counter stats for 'system wide':

        11,190,657      cycles [cpu_core]
           669,063      cycles [cpu_atom]

       1.002147571 seconds time elapsed

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-stat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 0b08665..bfe7305 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2379,6 +2379,9 @@ int cmd_stat(int argc, const char **argv)
 
 	evlist__check_cpu_maps(evsel_list);
 
+	if (perf_pmu__hybrid_exist())
+		stat_config.no_merge = true;
+
 	/*
 	 * Initialize thread_map with comm names,
 	 * so we could print it out on output.
-- 
2.7.4

