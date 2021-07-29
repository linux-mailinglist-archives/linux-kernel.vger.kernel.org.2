Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1C23D9D9A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 08:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbhG2GZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 02:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbhG2GZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 02:25:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EE3C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 23:25:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r1-20020a0569021541b029054df41d5cceso5733683ybu.18
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 23:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BFgxncVDj5jCNzVVsA7tSI3+CxqTrEq04XR7t3uim6A=;
        b=jyZoaRrWr6+mCcNQhxux2+kKNDSn/zDW4PyxlSvUYousZN6mgZ/lqxBJj3D/mxwdSN
         3m6huorXRcVFzwHtlIYOCCa9jRH8oEAO6sfQPdm+UhhNqJGa4jtbqpfx9ohVuIGWMKA7
         zEtRDGm42rvD7alADwYSvvvXYZ6cKe+j1SwAbDS/U0VxjHwIUWLQpzzOnAVs4FWSJa+z
         DWRIyAgGdKUU6S4KsKoE9MtdDk1zTCaPp9ivYYKe4dDW6OduPIsql06/yRGHR76SrgRO
         hjLOcGYnq14hA40cnPQ4WF4RkfLzEbZ77hroOHrdT1/gyh2K62njRRfX5a+JYgRZbNqn
         /SNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BFgxncVDj5jCNzVVsA7tSI3+CxqTrEq04XR7t3uim6A=;
        b=JQFkxH9xz/77C8cUy5kd1qrqxVWlT0RT7alfx7BtsHhq74nnfkwY1yryxU1gD5tueJ
         wUpAhT5yRhkyT0d1AdvRgSDj9PBdd1LAwAb5fGimScfGzI2i5mi4SSouZf2kEtA5Mhu+
         3ikl+b4fHyWM2IhSAJGbJ+dIzSVZeVv5Du0Go97n5CjI+DEuaDT/o2sPxuKXRqzW/LI2
         0aI0/aTXgS2xFZq+bjbjtEfjCmSq6olRn/1pnFXSDwhMpaK2tIiCwyCp0ypRSRkHGKGY
         SUkIwKVDa42QpcRxdzFW83QLIzRuRm8UzJzlmadAOkMWX/HCZtueYsFxaWBmVMufgje/
         HAiQ==
X-Gm-Message-State: AOAM531J7wVnEGoxVhg1D88Xp99tG/wi+kRtDK6SRascXUgn0npwDt1C
        oe4qMxylMQswWfQzHz1f4DKSCOVRzRAr
X-Google-Smtp-Source: ABdhPJza0pEGLNIWpVqaTumyFFNYcohPp9sSrl3Mba2QXUty4R0wrRhVwA5hXh1VTPh+5BSOzsrmdrMUUfQl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8f98:bc28:73a6:e8c9])
 (user=irogers job=sendgmr) by 2002:a25:6e55:: with SMTP id
 j82mr4540463ybc.480.1627539899394; Wed, 28 Jul 2021 23:24:59 -0700 (PDT)
Date:   Wed, 28 Jul 2021 23:24:49 -0700
In-Reply-To: <20210729062451.1349566-1-irogers@google.com>
Message-Id: <20210729062451.1349566-2-irogers@google.com>
Mime-Version: 1.0
References: <20210729062451.1349566-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH 1/3] libperf: Prefer exit(EXIT_SUCCESS) over exit(0)
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

Change exit code to be more intention revealing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/tests/test-evlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index c67c83399170..eceacd4b014c 100644
--- a/tools/lib/perf/tests/test-evlist.c
+++ b/tools/lib/perf/tests/test-evlist.c
@@ -251,7 +251,7 @@ static int test_mmap_thread(void)
 		for (i = 0; i < 100; i++)
 			prctl(0, 0, 0, 0, 0);
 
-		exit(0);
+		exit(EXIT_SUCCESS);
 	}
 
 	threads = perf_thread_map__new_dummy();
-- 
2.32.0.432.gabb21c7263-goog

