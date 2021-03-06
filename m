Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8C932F8E8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 09:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhCFIJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 03:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhCFIIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 03:08:46 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3BEC06175F
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 00:08:45 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 131so5400494ybp.16
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 00:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=R6bxlxn6SEFq8MFd7akjuYul4kQQDRjIClSoUqfhgZk=;
        b=iffMWUgJRJdVa33c4N+jW+/oLbjhoKVtnHRzSFuD2z3RgNFjgK4/PRytX0ddVYmvFW
         tXmDy2VUeaTSzaFfQL876e7U9v3TjRfwzfDXsHmAF3pl4hubY16Z9EvjXoyiVsT566ir
         O2e/BAy1rf/K1wGISkT8dyu+mU/EKHneCVRMmsp5FYIapTgXZb1FJaQM6vraSP/twcjB
         /0tk3bXHc08zNPoOVWYvWMfN+sCB0ZUkLXWfx8/JxuLocrF5S6RPPp+xFj5NH0qCmU7P
         A9EHfl4WBu0vuvtsckd7W4/L5eqaubUCLhDiZQ7RQ7Nn2Vr5StALOtAXLz1pFUdJeKfk
         7k5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=R6bxlxn6SEFq8MFd7akjuYul4kQQDRjIClSoUqfhgZk=;
        b=nuaB40utpjLgnfAqAL+4Mo+yJ1RKBkiVhWCs/ZXW1cdU0CXnwIlxbwqvbrZ2ssHmF3
         YvH4iAIQ0TfcsL8zOc8sAbFq6oCbHyTZ56lL2M8EuUkI0u3POQBTQQq+xxWcWjUyqLsO
         Vn9jEEgXP5d0sl9TGrxhSJWvUjf3oJ53VqCnHzIDopB8+k6b4McWSCOA7slzSAf9lW0w
         WPP4VjUimbz3wjj0WxBceSfpmd1jxISdhxKj/gX0nBzKzpClXKyzonbjfsEJf5q8Shf9
         jZDNOY+xOfn445XQW4oEjGwFIqP78LB6ARgZfcmNiSnO28zLZ4a4eJsJoXwaNG9ZO0xg
         b1mQ==
X-Gm-Message-State: AOAM533E4lOY5Pw4oWdniGsT6T+f28pGJBkBufuR+ySIqGOr9VyX47sA
        tUkVCCdam5sFq+LbzuQdP91XYXmmRP70
X-Google-Smtp-Source: ABdhPJyjnrBrfsvcV5/LKUwzGyo/BskDt/5z709FmcDfTEDDnQ9i59Sqx9jx7JgRGrTTn8PYDjeoHU+ju6De
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:d9f:b4b1:d43b:2030])
 (user=irogers job=sendgmr) by 2002:a25:c793:: with SMTP id
 w141mr19010425ybe.29.1615018125066; Sat, 06 Mar 2021 00:08:45 -0800 (PST)
Date:   Sat,  6 Mar 2021 00:08:38 -0800
Message-Id: <20210306080840.3785816-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 1/3] perf skel: Remove some unused variables.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes -Wall warnings.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c b/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
index c7cec92d0236..ab12b4c4ece2 100644
--- a/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
+++ b/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
@@ -52,7 +52,7 @@ int BPF_PROG(fentry_XXX)
 static inline void
 fexit_update_maps(struct bpf_perf_event_value *after)
 {
-	struct bpf_perf_event_value *before, diff, *accum;
+	struct bpf_perf_event_value *before, diff;
 	__u32 zero = 0;
 
 	before = bpf_map_lookup_elem(&fentry_readings, &zero);
@@ -78,7 +78,6 @@ int BPF_PROG(fexit_XXX)
 {
 	struct bpf_perf_event_value reading;
 	__u32 cpu = bpf_get_smp_processor_id();
-	__u32 one = 1, zero = 0;
 	int err;
 
 	/* read all events before updating the maps, to reduce error */
-- 
2.30.1.766.gb4fecdf3b7-goog

