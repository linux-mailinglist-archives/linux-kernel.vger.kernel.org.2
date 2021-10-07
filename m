Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC6942589C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 18:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243059AbhJGRAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242920AbhJGQ7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 12:59:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E90DC06177D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 09:57:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i83-20020a256d56000000b005b706d1417bso8688782ybc.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 09:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OwtG3KcDJxke5D774Uab+PiyO85QX1RNGG5ovQh35I4=;
        b=ZIv5H5CoJQJWz3tWkWfYKWgy5tn4MRtuJCihwj9WfaMa5yJhRb2Nn8rmaf7yNVaXBs
         NDrknjUj37h0k4YznfQSqDxwyVjGE+mUjN7GVluoP47gHKz+wmuNRFJdR80m4+0B9Q9D
         5DSBnuuwrt2iM0qFZe91Y8WFnSV7GR3MLUtpyBo/BMO9iiKoKhp2WFroeiLQ8iqMEKzT
         ewmMUvrm9VzjsTziU1eSVZxj6pjwhQpa+J3VGXnfxUpc2NQWX3BbWx3RPs6rLDA1bMXw
         3P+zD4SM5WvQkHzmC7ajYdAzT8NCBB2MO9gYIavdpxLX33f0r5ERZj3c5NnsqPD2F/5L
         b8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OwtG3KcDJxke5D774Uab+PiyO85QX1RNGG5ovQh35I4=;
        b=8OleNBTr+658zKTTw5kKKqsGmvlEE1pPu7rjwz3XK71tEfVdkz3dfZgwxK/gZdeCIz
         e+qEbS4OdsNdpyV64oM8teNWF8++rjUzx7S/AcF7NPTbaXl5/KfU0+M4zOfX4jhNlovX
         GoMtdj+qBvjrooVHgrXOsU+qHbrZ7T4pyOVRFWTAr3r1+S5fAIoTQ++gmCtN9yRMQKoS
         Z/OqmqBXwaWkdGUtq4Vr2bt1qA9wypovhjZYwmsEIKNquObFP7SFjGGT7g3mi/b969gS
         o+7q0rGZQtvoMVcgjb6asyW/HpWQjlB8e87x2nNm8Vp1kjsxH7UI3MRVfsmJIjHnV7Hs
         rghA==
X-Gm-Message-State: AOAM533ejVc7ngCx0Bv7MZBIc6z8yAusYv5kcVmCfA/zpiZc1T8fuZAO
        u4JX0NiccfJQ+QrSQr7yWRvvoh0niNUO
X-Google-Smtp-Source: ABdhPJxe5+Ly7EVn336VFPaVmpq3P4GYEHE8cZE+sVDwfR24/Ifl3ueo+wt/UYxaEWVuotrFrE+ukYamM3Zo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:fe85:5e36:cb6f:76bc])
 (user=irogers job=sendgmr) by 2002:a25:d607:: with SMTP id
 n7mr6776021ybg.96.1633625868586; Thu, 07 Oct 2021 09:57:48 -0700 (PDT)
Date:   Thu,  7 Oct 2021 09:56:34 -0700
In-Reply-To: <20211007165647.3514803-1-irogers@google.com>
Message-Id: <20211007165647.3514803-9-irogers@google.com>
Mime-Version: 1.0
References: <20211007165647.3514803-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 08/21] perf metric: Only add a referenced metric once
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        ToastC <mrtoastcheng@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Felix Fietkau <nbd@nbd.name>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Song Liu <songliubraving@fb.com>, Fabian Hemmer <copy@copy.sh>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Denys Zagorui <dzagorui@cisco.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a metric references other metrics then the same other metrics may be
referenced more than once, but the events and metric ref are only needed
once. An example of this is in tests/parse-metric.c where DCache_L2_Hits
references the metric DCache_L2_All_Hits twice, once directly and once
through DCache_L2_All.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index e4ce19389258..6c4c51e35aa7 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -870,12 +870,18 @@ static int __add_metric(struct list_head *metric_list,
 		*mp = m;
 	} else {
 		/*
-		 * We got here for the referenced metric, via the
-		 * recursive metricgroup__add_metric call, add
-		 * it to the parent group.
+		 * This metric was referenced in a metric higher in the
+		 * tree. Check if the same metric is already resolved in the
+		 * metric_refs list.
 		 */
 		m = *mp;
 
+		list_for_each_entry(ref, &m->metric_refs, list) {
+			if (!strcmp(pe->metric_name, ref->metric_name))
+				return 0;
+		}
+
+		/*Add the new referenced metric to the pare the parent group. */
 		ref = malloc(sizeof(*ref));
 		if (!ref)
 			return -ENOMEM;
-- 
2.33.0.882.g93a45727a2-goog

