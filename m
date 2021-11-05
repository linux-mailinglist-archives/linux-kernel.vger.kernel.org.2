Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A648446744
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbhKEQtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbhKEQtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:49:42 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49653C061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 09:47:02 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id y13-20020aa7942d000000b0049fa1a97f02so708275pfo.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 09:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=if51XuBZwIEX2x5mLxcA/AQLijVPXzGJ1zH9O3ITOIA=;
        b=Bg4zUOjdV8Y7SgLyQzPIDKkpSFIJLkTHj9Rt68Qmz24lHffLYUbriq4yw14sx6Dddz
         QixjtB9SIw/v7q7tS/uI3csIuQrYnZZ2M4evplGWaWqLSrFIl1kfVEaXkdHRs1GaRbqe
         uaVvnj6DLevC87Ht5zZBi5aPIMFrSO248B9hDL5wdTpTCT1S2U3gIN8XlfZhT9SV4S0u
         AS9z2RIsg8nBAa9T/YzTD2vH4SgaU5kLiyacN8yGDuawRf/DzN05HEwW6Ao6eGSF0aS5
         TrBdDUR/Px5z4oLqtZwki7e25BU1SEQzjyCHJmnWQSnAjKvJW0Ods9NY0fihVavm5N7m
         DU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=if51XuBZwIEX2x5mLxcA/AQLijVPXzGJ1zH9O3ITOIA=;
        b=b47I3eLaL5jrBXnEsczIGS+H2Z5SpDrxihmU7r1cRJ7eqod0LYPiyKvopmVaQR2MZR
         +vKZJgZAG0fTqiqxDL9C281AIRGl957pA1gGKvGnvSMEDH3Uvo/G8l2fJ73hvuB9l1j+
         WYZO5ri/MHwF1FtgnFKbtxdrTp7qQM+B7N7xeuuA5Gyydo0tetQcyHaFGRu/6gUfQtJJ
         D4lTXTsS5whbZd6qUK/XnGDEN7Vfbhfg62k4m82fZUXpQHbV2NiNf1OESANHDWZV8/f1
         rjPjSCj2E4+bgDmeCkfxDYV/3FLQRrhNSM5fKJRou8qVj4mLoKuzrAffElRw18yBOORU
         KmQQ==
X-Gm-Message-State: AOAM532CvcC1jiPrh1b9sC3OPmdtvvYNR62eIINA08BA5aqXygsqGKTG
        M3czB2i6lK4GVbAVNzf4lbypiZp2/0pD
X-Google-Smtp-Source: ABdhPJwEGWwXqFldXt9Fi9QKrpUbQ4nHAs9t/CUL8QIAuTpk8dAqdUX5hkJ9RJrD2Cz3NpNMAU2kUctDYDRx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4cee:beb8:1744:5207])
 (user=irogers job=sendgmr) by 2002:a17:90b:2389:: with SMTP id
 mr9mr13880566pjb.152.1636130821694; Fri, 05 Nov 2021 09:47:01 -0700 (PDT)
Date:   Fri,  5 Nov 2021 09:46:57 -0700
Message-Id: <20211105164657.3476647-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH] perf metric: Fix memory leaks.
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
 tools/perf/util/metricgroup.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 4917e9704765..734d2ce94825 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -228,6 +228,7 @@ static void metric__free(struct metric *m)
 	free(m->metric_refs);
 	expr__ctx_free(m->pctx);
 	free((char *)m->modifier);
+	evlist__delete(m->evlist);
 	free(m);
 }
 
@@ -1352,6 +1353,14 @@ static int parse_ids(struct perf_pmu *fake_pmu, struct expr_parse_ctx *ids,
 	*out_evlist = parsed_evlist;
 	parsed_evlist = NULL;
 err_out:
+	/*
+	 * Errors are generally cleaned up by printing, but parsing may succeed
+	 * with intermediate unused errors being recorded.
+	 */
+	free(parse_error.str);
+	free(parse_error.help);
+	free(parse_error.first_str);
+	free(parse_error.first_help);
 	evlist__delete(parsed_evlist);
 	strbuf_release(&events);
 	return ret;
@@ -1481,8 +1490,10 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
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

