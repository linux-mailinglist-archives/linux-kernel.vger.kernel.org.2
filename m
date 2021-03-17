Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F5233ED4F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhCQJpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:45:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13183 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhCQJo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:44:29 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F0lYR1tcqzmYhp;
        Wed, 17 Mar 2021 17:42:03 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Wed, 17 Mar 2021 17:44:19 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <yao.jin@linux.intel.com>, <gustavoars@kernel.org>,
        <mliska@suse.cz>, <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH v6] perf annotate: Fix sample events lost in stdio mode
Date:   Wed, 17 Mar 2021 17:44:09 +0800
Message-ID: <20210317094409.94293-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In hist__find_annotations function, since different hist_entry may point to same
symbol, we free notes->src to signal already processed this symbol in stdio mode;
when annotate, entry will skipped if notes->src is NULL to avoid repeated output.

However, there is a problem, for example, run the following command:

 # perf record -e branch-misses -e branch-instructions -a sleep 1

perf.data file contains different types of sample event.

If the same IP sample event exists in branch-misses and branch-instructions,
this event uses the same symbol. When annotate branch-misses events, notes->src
corresponding to this event is set to null, as a result, when annotate
branch-instructions events, this event is skipped and no annotate is output.

Solution of this patch is to remove zfree in hists__find_annotations and
change sort order to "dso,symbol" to avoid duplicate output when different
processes correspond to the same symbol.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---

Changes since v5:
  - Add Signed-off-by tag.

Changes since v4:
  - Use the same sort key "dso,symbol" in branch stack mode.

Changes since v3:
  - Modify the first line of comments.

Changes since v2:
  - Remove zfree in hists__find_annotations.
  - Change sort order to avoid duplicate output.

Changes since v1:
  - Change processed flag variable from u8 to bool.

 tools/perf/builtin-annotate.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index a23ba6bb99b6..92c55f292c11 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -374,13 +374,6 @@ static void hists__find_annotations(struct hists *hists,
 		} else {
 			hist_entry__tty_annotate(he, evsel, ann);
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
@@ -619,6 +612,12 @@ int cmd_annotate(int argc, const char **argv)
 
 	setup_browser(true);
 
+	/*
+	 * Events of different processes may correspond to the same
+	 * symbol, we do not care about the processes in annotate,
+	 * set sort order to avoid repeated output.
+	 */
+	sort_order = "dso,symbol";
 	if ((use_browser == 1 || annotate.use_stdio2) && annotate.has_br_stack) {
 		sort__mode = SORT_MODE__BRANCH;
 		if (setup_sorting(annotate.session->evlist) < 0)
-- 
2.30.GIT

