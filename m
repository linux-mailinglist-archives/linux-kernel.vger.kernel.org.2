Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC003F7F41
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 02:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbhHZAR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 20:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbhHZAR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 20:17:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145DCC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 17:16:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b198-20020a2534cf000000b0059bae206c16so1252487yba.18
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 17:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jKpOvBSXMQrCJiT5zO1xY+EZk8vDkrov86gD8oj2C2Q=;
        b=NpeAHgNjtm+yStWpoNqTQ3x7Xlzz/icd7LOJxn2vJfRcN6H/9c1ykD7krmgc2BEgNY
         +KV+HVbFD3M9Pq4xLayOJYzCy2H7KvEwD+bmzEbvEG1OhRX+datgCNNSY2jCFkAji4+o
         sbvyLW1e7nUE882dXm0As55FPIyDr73ocQOC4710N5q+csJe6WoMsLQboy3Zlb4wifDp
         1NCNQj7ofnbYv8LpZ+Cb66jyEQNshzPzphbl7RvWWUEW/V8XGVkWuRHkvE+MoMocL73X
         p7xUMilKuI6frKK1rAyow+MFsPng6EHu1MnkrFAYkDRZRWr25EImsWO1dDvwQgcCumpu
         yPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jKpOvBSXMQrCJiT5zO1xY+EZk8vDkrov86gD8oj2C2Q=;
        b=cedb1dd5IbjES6fl2MXS00QPF8V6ceYvYOnp+Lo+qzUhkTh0tqWiI68/PgRQAJRzWS
         ddDMfy0S+cWDl22XRzMxxbpoxlFU5SlnVbTKXazxCU2Jpx6u/xC87WtzC28KpcJnt9CE
         HzR3o33osXlbQv0j6SaqADRLxKSljWMhVIgvZ8xgDF4uUatBoUBGmZLh8aCCw6SKdk/F
         IYOcZFG4jBD+XWCw1ZseIAfLqF8XUbao9/DxE7wU7Ouh4pvPCT2R0mJlf+bySGxPXUUp
         P5LdWrgquVXYrLZ2Hd+KR3oU0CV2b4PwpVXg/kOsyYSuScgIGHn2DsYVlJ5s7Dl7DlHz
         Me9Q==
X-Gm-Message-State: AOAM5338QaqSNygqwxIYUZXWSUivVmZ/+VjpDq6VpD+fD+JJCO6//6Gu
        h3YhyEKQnWCLT40+DLrP+bwhT3S3MvF/
X-Google-Smtp-Source: ABdhPJxknXL2IQv1ORhIsgH9DLjXnjQK1sOefpzkiQe5Fq2OyH7vNUBwGCXZE2VTdxpDiq7eoEr2nRIpQBJd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d2f8:e3e3:cd4a:a809])
 (user=irogers job=sendgmr) by 2002:a25:5086:: with SMTP id
 e128mr1648317ybb.89.1629937000311; Wed, 25 Aug 2021 17:16:40 -0700 (PDT)
Date:   Wed, 25 Aug 2021 17:16:35 -0700
Message-Id: <20210826001635.285752-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH] perf bpf: Fix memory leak during synthesis.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BTF needs to be freed with btf_free.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index cdecda1ddd36..d193104db7f7 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -296,7 +296,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 
 out:
 	free(info_linear);
-	free(btf);
+	btf__free(btf);
 	return err ? -1 : 0;
 }
 
-- 
2.33.0.rc2.250.ged5fa647cd-goog

