Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9913E42FA1C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242395AbhJORZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242350AbhJORZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:25:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73792C061783
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:22:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i83-20020a256d56000000b005b706d1417bso11970063ybc.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3qZZL4q7gSQLhx5UGqjT9ebzZrdH8WkBdFrjH947yQo=;
        b=StaSBoZiHR3EyDcQiaC3wo96F5TxLygYhJeEXjuSQKdGg/uFybL9coAqda6skNKa1/
         H8fDo4iMUdT1JQVheG1jNqSvOEnWloBo82r40zlKrFZYf/LVrQKJAEjiYmZYMt8qfGav
         Fmmw8VzQW/ArC8hnNcgfatbXub3CkaQJDW8rTvnczzJ9Jiaf2F+0yDsxQYlVflc01SHc
         L9VT5r4G9XqXnW9SmoAyluPVGe1EOtyIs2d0UAlsCOcpcodboa7ECIlhzSGn92vfOrda
         qIVKgFUoEqffuKDLl7PV4I+DO7juTtTbzh6Td73U7U7AB/wNlCuIhpTAD5pZEc2EqhSU
         oCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3qZZL4q7gSQLhx5UGqjT9ebzZrdH8WkBdFrjH947yQo=;
        b=YzmaYTs7wBKzczBLPuqzT8ZoOtL/EDI5+Z+XJiA9NellzfAbU5e4NvMu0rpY3fJnoe
         OoOfMKqJ9TzwyUxjm+0MUlO13bWg+INEYkGGh8QPnSABYTZp23HHvlTJ8ROGwnxPxt/U
         SNRoT0mmnWdef6Ph1ZpVSsOcgplC79bNKqIBdxYrrM1ErGqKdipdkpc3J1ES1Ik2hwjY
         mE/TLERwk6EBYqKjjJDpuC3r4WzgKciuu7Xdsvjnhx/jgzUDjxitU6AyRUfw4F8saFaD
         2F0gFEBPlm3UtsJETxRXSwCMED4VVYvMOxQhGoo12+bbPg5ulbCKKSoKhb6RzVf8I4qr
         9i/Q==
X-Gm-Message-State: AOAM5334C7TtmVubQjp3z2CuWRI89VfDRSO0/eq+fmjqETjLscg2bY9I
        fqqMlOi6nuOp9QT3M8j4DuIZnA3Ljabx
X-Google-Smtp-Source: ABdhPJyeqqip7OkTfcwULOAWPWB82HEh7RrGKGHXSPL6EryOsOno6pftEz+UnRvUr5qVyLdElW9ZzrXvitXl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:69bc:7451:58ad:6585])
 (user=irogers job=sendgmr) by 2002:a25:6884:: with SMTP id
 d126mr13929568ybc.533.1634318543629; Fri, 15 Oct 2021 10:22:23 -0700 (PDT)
Date:   Fri, 15 Oct 2021 10:21:30 -0700
In-Reply-To: <20211015172132.1162559-1-irogers@google.com>
Message-Id: <20211015172132.1162559-20-irogers@google.com>
Mime-Version: 1.0
References: <20211015172132.1162559-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 19/21] perf metric: Switch fprintf to pr_err.
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
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andrew Kilroy <andrew.kilroy@arm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no clear reason for the inconsistency that stems from the
initial commit.

Acked-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 988f9e95dded..b6ba1317973e 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1172,7 +1172,7 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 		ret = metricgroup__add_metric(p, metric_no_group, metric_list,
 					      map);
 		if (ret == -EINVAL)
-			fprintf(stderr, "Cannot find metric or group `%s'\n", p);
+			pr_err("Cannot find metric or group `%s'\n", p);
 
 		if (ret)
 			break;
-- 
2.33.0.1079.g6e70778dc9-goog

