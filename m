Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F043621BF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244324AbhDPOIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:08:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:23086 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241911AbhDPOHd (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:07:33 -0400
IronPort-SDR: RguX0Q6x0qMK/oZnGv6YCuW1EPQVaeuEpqJLpBHFKgK5G/IRn3p+4CFDNV60I/xOs+V0BymRF9
 ZUlL0jTi6OZw==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="191854363"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="191854363"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 07:07:09 -0700
IronPort-SDR: h8z3Qmug4moNMleLlc2UO7ltWGZ0DyWaavEEtVjqxpS155MPeP9LK8iZBnOrCmV9SpXj3Cl4sW
 CX15ykpMKyew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="612766862"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga006.fm.intel.com with ESMTP; 16 Apr 2021 07:07:04 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 17/25] perf record: Uniquify hybrid event name
Date:   Fri, 16 Apr 2021 22:05:09 +0800
Message-Id: <20210416140517.18206-18-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210416140517.18206-1-yao.jin@linux.intel.com>
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For perf-record, it would be useful to tell user the pmu which the
event belongs to.

For example,

  # perf record -a -- sleep 1
  # perf report

  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 106  of event 'cpu_core/cycles/'
  # Event count (approx.): 22043448
  #
  # Overhead  Command       Shared Object            Symbol
  # ........  ............  .......................  ............................
  #
  ...

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v4:
 - No change.

 tools/perf/builtin-record.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 6af46c6a4fd8..3337b5f93336 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1605,6 +1605,32 @@ static void hit_auxtrace_snapshot_trigger(struct record *rec)
 	}
 }
 
+static void record__uniquify_name(struct record *rec)
+{
+	struct evsel *pos;
+	struct evlist *evlist = rec->evlist;
+	char *new_name;
+	int ret;
+
+	if (!perf_pmu__has_hybrid())
+		return;
+
+	evlist__for_each_entry(evlist, pos) {
+		if (!evsel__is_hybrid(pos))
+			continue;
+
+		if (strchr(pos->name, '/'))
+			continue;
+
+		ret = asprintf(&new_name, "%s/%s/",
+			       pos->pmu_name, pos->name);
+		if (ret) {
+			free(pos->name);
+			pos->name = new_name;
+		}
+	}
+}
+
 static int __cmd_record(struct record *rec, int argc, const char **argv)
 {
 	int err;
@@ -1709,6 +1735,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	if (data->is_pipe && rec->evlist->core.nr_entries == 1)
 		rec->opts.sample_id = true;
 
+	record__uniquify_name(rec);
+
 	if (record__open(rec) != 0) {
 		err = -1;
 		goto out_child;
-- 
2.17.1

