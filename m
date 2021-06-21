Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C55A3AF825
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 23:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhFUV7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 17:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbhFUV7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 17:59:11 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE49C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 14:56:56 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id a2-20020ad441c20000b0290251bb08ce61so14300603qvq.19
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 14:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=o7AiO7cf+g5j73bnIKC5PyTIHqUoKVu2uLnXWRb97sM=;
        b=ZArou9EpOMHKZdF4JziC2HUFizemZfHZxYohE3H/4NjcwmlquDQ2fdyZIrSB4+jrGa
         qKjnVY3MV7YctoL7xZq2jvEu2DE8x03uMjUTGvi63UUsOqaULaUISvn/ymiX17zzp1iX
         XYw12fKEsRvWK1PQmAa1IbLPJ6XP6a8/qfVSvp3poP9JHGMV+LAR+ou5QzseEkjnAG/R
         qWhObxJnFu16ryTZ0BP7ZKBAO9Qd4bBcKHX4Mqf8nJq70mUuiC4WTpb6qRbdUYj/4lZ3
         pcLQdqdBhNMd57MwVAA5807sijCAQ9PHJaAussOPguyfoICmC6VLJ3dTFDS4qE/2Gqwd
         cBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o7AiO7cf+g5j73bnIKC5PyTIHqUoKVu2uLnXWRb97sM=;
        b=oU2OecHejSSwPxvYpon1WlC95qk8nFrSQ1e7mWeTMCpvsP3G7H7GOamoFhbI4wzSn+
         ZHCBR2HP4ao5pN5rr7QEqVewoNz3aGRUSrtNdZtG5xgaauGzjwXT2Q6incJ1CtquEoiX
         RvDJCzWsD605zMEmj9EwLvWCu29zhM1ggTVPfelpIDFU8eTtyjDF7o4m6vixu7aRoMUC
         LpW2DpvlVDa021DxeHwIizA0FIhHHDcX+cXJf1dY2qZiBl+Z4A50NuiQgF4sertm3R5c
         T+V4bazdgUhVHjRrx50kRYicgv6ZfkGJ/3LGaaLp0n51W27kAg5RB16y/+FgZX+hP/D8
         62dA==
X-Gm-Message-State: AOAM532pCvKqLB6q7lwSylkL2ERHkbUEKMS98DRs1HDU+IeYZgUm6m4b
        gLn0CczL4ya+EKi/IMlDmouAYT5vzyBv
X-Google-Smtp-Source: ABdhPJyGBlSlo07F4G7w4AxwWPsxT8RK5eHECX8mtkRUDvlMQ9S86+4p8nnfQnKE92k781Q430veQF9794kH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ffd6:b7f5:87ee:7be2])
 (user=irogers job=sendgmr) by 2002:a25:cac4:: with SMTP id
 a187mr112611ybg.423.1624312615504; Mon, 21 Jun 2021 14:56:55 -0700 (PDT)
Date:   Mon, 21 Jun 2021 14:56:47 -0700
In-Reply-To: <20210621215648.2991319-1-irogers@google.com>
Message-Id: <20210621215648.2991319-2-irogers@google.com>
Mime-Version: 1.0
References: <20210621215648.2991319-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH v2 2/3] perf test: Add verbose skip output for bpf counters
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide additional context for when the stat bpf counters test skips.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_bpf_counters.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index 22eb31e48ca7..85eb689fe202 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -22,7 +22,13 @@ compare_number()
 }
 
 # skip if --bpf-counters is not supported
-perf stat --bpf-counters true > /dev/null 2>&1 || exit 2
+if ! perf stat --bpf-counters true > /dev/null 2>&1; then
+	if [ "$1" == "-v" ]; then
+		echo "Skipping: --bpf-counters not supported"
+		perf --no-pager stat --bpf-counters true || true
+	fi
+	exit 2
+fi
 
 base_cycles=$(perf stat --no-big-num -e cycles -- perf bench sched messaging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
 bpf_cycles=$(perf stat --no-big-num --bpf-counters -e cycles -- perf bench sched messaging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
-- 
2.32.0.288.g62a8d224e6-goog

