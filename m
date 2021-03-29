Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E4F34C47D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhC2HDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:03:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:20002 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231263AbhC2HC3 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:02:29 -0400
IronPort-SDR: V3jcHYSGnlKs0BOMO2+WavN+TK1fsrauaGrNRxpbdC5sG78lFxbK8dccPNrbcNDUAYdZI1A0Yo
 qhtyAco974Gg==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="190956289"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="190956289"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:02:29 -0700
IronPort-SDR: yJUhL2YaYvIYkTDcpkwbjAUo2tnv+gNdqcSjcuXR45ppYTHdUdTcwrJ7vr4ISBk50wL5QzWgNo
 qPc45yPKB0zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="444677566"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2021 00:02:26 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 18/27] perf record: Uniquify hybrid event name
Date:   Mon, 29 Mar 2021 15:00:37 +0800
Message-Id: <20210329070046.8815-19-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329070046.8815-1-yao.jin@linux.intel.com>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
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
v3:
 - New patch in v3.

 tools/perf/builtin-record.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 1b44b1a8636e..74cc9ffbd9ef 100644
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

