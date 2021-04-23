Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F9A368CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 07:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbhDWFiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 01:38:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:9345 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240767AbhDWFh7 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 01:37:59 -0400
IronPort-SDR: AYaHEqKSaYE7O7sltDPhDHfw6aycjVOOMpe41W3yLDEjFmsZpVqovioBxnwuQ0y2xkScE9wci3
 bXRP3cSiOHaA==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="183501849"
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="183501849"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 22:37:23 -0700
IronPort-SDR: j/4Tp0mfsnfrr9PxnKiPso/aUzDLqJ3itEbooLnyIS4/f0g7ec4n+0uv94taMYi8WFyFvTvyoQ
 yovEsW0zJtyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="386293694"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga006.jf.intel.com with ESMTP; 22 Apr 2021 22:37:20 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 17/26] perf record: Uniquify hybrid event name
Date:   Fri, 23 Apr 2021 13:35:32 +0800
Message-Id: <20210423053541.12521-18-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423053541.12521-1-yao.jin@linux.intel.com>
References: <20210423053541.12521-1-yao.jin@linux.intel.com>
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
v5:
 - No change.

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

