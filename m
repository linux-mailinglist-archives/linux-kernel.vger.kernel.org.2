Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46211447248
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 10:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbhKGJDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 04:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbhKGJDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 04:03:03 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E78BC061714
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 01:00:21 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d8-20020a253608000000b005c202405f52so20775500yba.7
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 01:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=m2otj9XBu2PcJainIjXgKv2kW+bjLowTkdHsom43oaI=;
        b=JcnUKs01SmWnCOoxBwXPLREobdqvM/0WzdG2Yj1+JnWtVpuraqjxY4nzz9jx2ZCVC8
         a+RpCE3/w2x7AA4ck/SpIGawiFX2akngfC9oiopoAs88j4Nmv51EDHvUcCKZA/Iwi5iH
         Ku2hb5UhD2eSkTXKL+wymOkMFcTAfVbmYnslSisFLuoLgdIAWTiQPA2tusheNjVCM5wI
         6yCerfcPYldiTtfXqkgo8Ga5mjARAQeYptYQ2adAebXsb9Lu+KE+ISNC/pQaRlmrEM5D
         Yfq8Fr7t8/cJl00lULhMpj1Q8g1YmGO40v5OCIyWqtDK9a/jdkYc+v6FRgRgJxoRxEKh
         9nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m2otj9XBu2PcJainIjXgKv2kW+bjLowTkdHsom43oaI=;
        b=4Wrla+2r6Psr3qUFXN5voTmm4ez5h4gyGpKr9xh68bu4iFcLIONrmS9tfl6qU9RsEq
         dYiik/6/9l1H4DVJZe6FQRqZTPM2Uy7wZ3JXRySGO8Ry1b1MmGkj4sVlztvMVCWZCpc/
         K+pNxdiA9s82/FM3yTY7ZENVdXq8mcz4C+qJmnKPLpncg3xkSR90ydjZECk96WZ9xoRW
         CMvBcTIUuFzIdEiRhsji66l5LC/yEZeJ3M3MU7PGvUBbhlbMMNBctavcQ/xAXRldBbWN
         yGCWqWDY2Zq8IA0vd4OOgBraefmrKF8BOSvA/R2BG+F+DBcixuaoYJI+jAl/IEFWjgVf
         7P1A==
X-Gm-Message-State: AOAM531B2M5eb+1OXNGE2a4UWookogrlh/WT75EjRCeL+MAhX31EZ+Hs
        YXQM4Hh2vg1b+KiP1P747C1p3aKpyrL9
X-Google-Smtp-Source: ABdhPJzRd6lnqIoH8o3+YkXD32j7GbsxVuRzQ7cT4t/6Po7TRrxeBvoHiyZkX3lB5m2LjP7zGi+ZyACw1xy5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:421f:fd78:d785:693a])
 (user=irogers job=sendgmr) by 2002:a25:1503:: with SMTP id
 3mr77497145ybv.214.1636275620322; Sun, 07 Nov 2021 01:00:20 -0800 (PST)
Date:   Sun,  7 Nov 2021 01:00:02 -0800
In-Reply-To: <20211107090002.3784612-1-irogers@google.com>
Message-Id: <20211107090002.3784612-3-irogers@google.com>
Mime-Version: 1.0
References: <20211107090002.3784612-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v2 3/3] perf metric: Fix memory leaks.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain error paths may leak memory as caught by address sanitizer.
Ensure this is cleaned up to make sure address/leak sanitizer is happy.

Fixes: 5ecd5a0c7d1c ("perf metrics: Modify setup and deduplication")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 1b43cbc1961d..fffe02aae3ed 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -228,6 +228,7 @@ static void metric__free(struct metric *m)
 	free(m->metric_refs);
 	expr__ctx_free(m->pctx);
 	free((char *)m->modifier);
+	evlist__delete(m->evlist);
 	free(m);
 }
 
@@ -1482,8 +1483,10 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 	}
 
 
-	if (combined_evlist)
+	if (combined_evlist) {
 		evlist__splice_list_tail(perf_evlist, &combined_evlist->core.entries);
+		evlist__delete(combined_evlist);
+	}
 
 	list_for_each_entry(m, &metric_list, nd) {
 		if (m->evlist)
-- 
2.34.0.rc0.344.g81b53c2807-goog

