Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CE039290A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 09:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbhE0H5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:57:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:39420 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233375AbhE0H5K (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:57:10 -0400
IronPort-SDR: PEst/Ct3eayDBzJSZIaq1k5ExgjS+9ghklmNEcgG47PR3NbQl3ZmVRBsiF9L5MaBvnCfn+6gNK
 G9VxDVd4UQeQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="288262852"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="288262852"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 00:54:50 -0700
IronPort-SDR: CEAB2tbHsmbXE+gtCiJ2IwoLMjtNAUApqrzWeCXUOtUR0O6qs3LKZOJoUnrLCFZ7gcyVXXHmVy
 /HvbA9l6Q0XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="547586604"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2021 00:54:48 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 7/8] perf mem: Disable 'mem-loads-aux' group before reporting
Date:   Thu, 27 May 2021 08:16:09 +0800
Message-Id: <20210527001610.10553-8-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210527001610.10553-1-yao.jin@linux.intel.com>
References: <20210527001610.10553-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some platforms, such as Alderlake, the 'mem-loads' event is required
to use together with 'mem-loads-aux' within a group and 'mem-loads-aux'
must be the group leader. Now we disable this group before reporting
because 'mem-loads-aux' is just an auxiliary event. It doesn't carry
any valid memory load result. If we show the 'mem-loads-aux' +
'mem-loads' as a group in report, it needs many of changes but they
are totally unnecessary.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v2:
 - New in v2.

 tools/perf/builtin-report.c |  2 ++
 tools/perf/util/evlist.c    | 25 +++++++++++++++++++++++++
 tools/perf/util/evlist.h    |  1 +
 3 files changed, 28 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 36f9ccfeb38a..bc5c393021dc 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -934,6 +934,8 @@ static int __cmd_report(struct report *rep)
 		return ret;
 	}
 
+	evlist__check_mem_load_aux(session->evlist);
+
 	if (rep->stats_mode)
 		return stats_print(rep);
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 6ea3e677dc1e..6ba9664089bd 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2161,3 +2161,28 @@ int evlist__scnprintf_evsels(struct evlist *evlist, size_t size, char *bf)
 
 	return printed;
 }
+
+void evlist__check_mem_load_aux(struct evlist *evlist)
+{
+	struct evsel *leader, *evsel, *pos;
+
+	/*
+	 * For some platforms, the 'mem-loads' event is required to use
+	 * together with 'mem-loads-aux' within a group and 'mem-loads-aux'
+	 * must be the group leader. Now we disable this group before reporting
+	 * because 'mem-loads-aux' is just an auxiliary event. It doesn't carry
+	 * any valid memory load information.
+	 */
+	evlist__for_each_entry(evlist, evsel) {
+		leader = evsel->leader;
+		if (leader == evsel)
+			continue;
+
+		if (leader->name && strstr(leader->name, "mem-loads-aux")) {
+			for_each_group_evsel(pos, leader) {
+				pos->leader = pos;
+				pos->core.nr_members = 0;
+			}
+		}
+	}
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index a8b97b50cceb..2073cfa79f79 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -367,4 +367,5 @@ int evlist__ctlfd_ack(struct evlist *evlist);
 struct evsel *evlist__find_evsel(struct evlist *evlist, int idx);
 
 int evlist__scnprintf_evsels(struct evlist *evlist, size_t size, char *bf);
+void evlist__check_mem_load_aux(struct evlist *evlist);
 #endif /* __PERF_EVLIST_H */
-- 
2.17.1

