Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5B645554E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 08:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243713AbhKRHQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 02:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242205AbhKRHQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 02:16:14 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63FDC061207
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 23:12:52 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v7-20020a25ab87000000b005c2130838beso8489143ybi.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 23:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=skq4P9T6KtKDwyZw1ZKeY27aIa6yFc8QolZIysalVnQ=;
        b=pMhXGuz+NjsXR9CxpSpB+s0xuJZqv/3iQYQHwVTKv/36M9oLhmMUWwEBtvvDrbJsV0
         D9N8hxTFaiyLh5RdrRezPZ6Q5SkmNEXVqNXVT46ejojaLI6F5ClwpF0oiU0LuyH6d/rZ
         U4wBO1Pr7xFiMUDJg6w3EC4c9BXeBQ5yIu4Mt5C7I1YG+ITclzrKGGwtLaPSYvzcfz+4
         h0MUR6Qp4e7BM9QpLupceF+QaCntui9UqI59lK6lR7TOvrQTQWFSgYWr7IG6WqHvwSkp
         dSpSIm/kapllKtzijhjSBIgB+8rdipsYTnn+DG7lTtPwcRzVz7N70/T24jrSB/GMgh2r
         Eruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=skq4P9T6KtKDwyZw1ZKeY27aIa6yFc8QolZIysalVnQ=;
        b=DY6rkRocqqIzykxOr6WglTu6dhrOQSq44T6sUHrza3DN+LQS4A52DOrY50N4mP6mIb
         SKQWWN/gukfc3iX8MQdT2/gUdzcYt17zig7gfMi+jIEyd6a6qt3kyRe1z4erJvmpvx/a
         Ffhr9Bl4nN9bPxR1cI63J2k9c01VVi0z7EoiV8wICqnSlIg9IGg7rRMGUCOmSVCbq+t4
         I4NYuAhyMEirVMquCynuerHHBOevk+q9JiRmUp8U7thoQMgHL42SD+4uxt6DvR/9Ufnx
         kVpg8rq7YfjFJ/IfyADRzWWC/qcB0aGvpdP3j+rhFxJhLgjQmgLMODxRHd4A0K9tqegZ
         pmig==
X-Gm-Message-State: AOAM533xwH1fmw4tl/Rczi/G/ngAqL9DpWvma9LKnmjfq6ohW/bCv/vi
        wqsL1Z3H4yG4kIL51WP+Y/tKrMLy7igi
X-Google-Smtp-Source: ABdhPJzX4Vz+h0R6UP4eA/RJSLyOSp0dl9Mb4hEzxj2xfVawuOLFv44oQxi/ze358O3kc+HxRL6sWRybBrwM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:b539:25b3:faf2:d1b3])
 (user=irogers job=sendgmr) by 2002:a25:abe3:: with SMTP id
 v90mr23979943ybi.315.1637219572118; Wed, 17 Nov 2021 23:12:52 -0800 (PST)
Date:   Wed, 17 Nov 2021 23:12:47 -0800
Message-Id: <20211118071247.2140392-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH] perf hist: Fix memory leak of a perf_hpp_fmt
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf_hpp__column_unregister removes an entry from a list but doesn't
free the memory causing a memory leak spotted by leak sanitizer. Add the
free while at the same time reducing the scope of the function to
static.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/hist.c   | 28 ++++++++++++++--------------
 tools/perf/util/hist.h |  1 -
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index c1f24d004852..5075ecead5f3 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -535,6 +535,18 @@ struct perf_hpp_list perf_hpp_list = {
 #undef __HPP_SORT_ACC_FN
 #undef __HPP_SORT_RAW_FN
 
+static void fmt_free(struct perf_hpp_fmt *fmt)
+{
+	/*
+	 * At this point fmt should be completely
+	 * unhooked, if not it's a bug.
+	 */
+	BUG_ON(!list_empty(&fmt->list));
+	BUG_ON(!list_empty(&fmt->sort_list));
+
+	if (fmt->free)
+		fmt->free(fmt);
+}
 
 void perf_hpp__init(void)
 {
@@ -598,9 +610,10 @@ void perf_hpp_list__prepend_sort_field(struct perf_hpp_list *list,
 	list_add(&format->sort_list, &list->sorts);
 }
 
-void perf_hpp__column_unregister(struct perf_hpp_fmt *format)
+static void perf_hpp__column_unregister(struct perf_hpp_fmt *format)
 {
 	list_del_init(&format->list);
+	fmt_free(format);
 }
 
 void perf_hpp__cancel_cumulate(void)
@@ -672,19 +685,6 @@ void perf_hpp__append_sort_keys(struct perf_hpp_list *list)
 }
 
 
-static void fmt_free(struct perf_hpp_fmt *fmt)
-{
-	/*
-	 * At this point fmt should be completely
-	 * unhooked, if not it's a bug.
-	 */
-	BUG_ON(!list_empty(&fmt->list));
-	BUG_ON(!list_empty(&fmt->sort_list));
-
-	if (fmt->free)
-		fmt->free(fmt);
-}
-
 void perf_hpp__reset_output_field(struct perf_hpp_list *list)
 {
 	struct perf_hpp_fmt *fmt, *tmp;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 5343b62476e6..621f35ae1efa 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -369,7 +369,6 @@ enum {
 };
 
 void perf_hpp__init(void);
-void perf_hpp__column_unregister(struct perf_hpp_fmt *format);
 void perf_hpp__cancel_cumulate(void);
 void perf_hpp__setup_output_field(struct perf_hpp_list *list);
 void perf_hpp__reset_output_field(struct perf_hpp_list *list);
-- 
2.34.0.rc1.387.gb447b232ab-goog

