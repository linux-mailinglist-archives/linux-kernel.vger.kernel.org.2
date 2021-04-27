Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965C636BFAE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbhD0HEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:04:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:54953 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234827AbhD0HEh (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:04:37 -0400
IronPort-SDR: oiTaUmoUyr5OnoFFiV1hMlRqdEbpE2TjC/6dBinPuM9QhCL5T6UJ4D7VMzfKnjPyAF/xuv7lGV
 sz8WBy7vXrtg==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="196573036"
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="196573036"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 00:03:54 -0700
IronPort-SDR: K6h2vq1tBAYyaIF33/Fq4aUbthJovvIcx+89QO5GDHA0OGsUOe3Ke24GISI1tNBwa6y60ns2xK
 1mu2maMqtYLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="447506940"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2021 00:03:52 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 17/26] perf record: Uniquify hybrid event name
Date:   Tue, 27 Apr 2021 15:01:30 +0800
Message-Id: <20210427070139.25256-18-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427070139.25256-1-yao.jin@linux.intel.com>
References: <20210427070139.25256-1-yao.jin@linux.intel.com>
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
v4 - v6:
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

