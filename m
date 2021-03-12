Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B943338440
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 04:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhCLDGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 22:06:40 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13881 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhCLDGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 22:06:12 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DxVyn41gNz8wrB;
        Fri, 12 Mar 2021 11:04:17 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Fri, 12 Mar 2021 11:05:57 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <yao.jin@linux.intel.com>, <gustavoars@kernel.org>,
        <mliska@suse.cz>, <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>, <zhangjinhao2@huawei.com>
Subject: [PATCH v2] perf annotate: Fix sample events lost in stdio mode
Date:   Fri, 12 Mar 2021 11:05:43 +0800
Message-ID: <20210312030543.214506-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In hist__find_annotations function, since have a hist_entry per IP for the same
symbol, we free notes->src to signal already processed this symbol in stdio mode;
when annotate, entry will skipped if notes->src is NULL to avoid repeated output.

However, there is a problem, for example, run the following command:

 # perf record -e branch-misses -e branch-instructions -a sleep 1

perf.data file contains different types of sample event.

If the same IP sample event exists in branch-misses and branch-instructions,
this event uses the same symbol. When annotate branch-misses events, notes->src
corresponding to this event is set to null, as a result, when annotate
branch-instructions events, this event is skipped and no annotate is output.

Solution of this patch is to add a bool member "processed_flag" in struct sym_hist
to indicate whether the symbol has been processed.
Because different types of event correspond to different sym_hist, no conflict
occurs.
---

Changes since v1:
  - Change processed flag variable from u8 to bool.

 tools/perf/builtin-annotate.c | 22 ++++++++++++++--------
 tools/perf/util/annotate.h    |  4 ++++
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index a23ba6bb99b6..6cd6612dbff6 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -372,15 +372,21 @@ static void hists__find_annotations(struct hists *hists,
 			if (next != NULL)
 				nd = next;
 		} else {
-			hist_entry__tty_annotate(he, evsel, ann);
+			struct sym_hist *h = annotated_source__histogram(notes->src,
+									 evsel->idx);
+
+			if (!h->processed_flag) {
+				hist_entry__tty_annotate(he, evsel, ann);
+
+				/*
+				 * Since we have a hist_entry per IP for the same
+				 * symbol, set processed flag of evsel in sym_hist
+				 * to signal we already processed this symbol.
+				 */
+				h->processed_flag = true;
+			}
+
 			nd = rb_next(nd);
-			/*
-			 * Since we have a hist_entry per IP for the same
-			 * symbol, free he->ms.sym->src to signal we already
-			 * processed this symbol.
-			 */
-			zfree(&notes->src->cycles_hist);
-			zfree(&notes->src);
 		}
 	}
 }
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 096cdaf21b01..9d071c9879c1 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -228,6 +228,10 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel);
 struct sym_hist {
 	u64		      nr_samples;
 	u64		      period;
+
+	/* whether symbol has been processed, used for annotate */
+	bool		      processed_flag;
+
 	struct sym_hist_entry addr[];
 };
 
-- 
2.30.GIT

