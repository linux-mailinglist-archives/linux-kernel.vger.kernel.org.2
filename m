Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99533ABBFD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 20:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhFQSou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 14:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbhFQSop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 14:44:45 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EC0C061760
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 11:42:34 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id z6-20020a0cfec60000b0290263740e5b2aso1284204qvs.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 11:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P2HhH8guhta86S5605kqN5Fpf4VPJ3qSwUq040gmRik=;
        b=RnWQmXgJd+ZC16mQntBSthlxeSP5ca9Ii4s+Yhqyatut7+iaz9MqeF+t2ipQxypPwj
         wHNg1IIfJUC/s69tD3+GRzAEtY21jdDJTBi/HG4C4Ey3c1zSHdb0ZJjzeL88Gs8GZboY
         QDx8rO81Ic2V+Bql6lvvtpqXPZ2GzZsZ5tiyPu05NDejj5P8dBzcOTTAq918VWdV8XpG
         sjkwP5F1atnfmddHdtQ82gedkNMTCnQQMA32vPRmsEPfJmVONsb3Tnno+BPuyu+DeljG
         hiiz/9TJdzR4fpMhOfk75uA6oppsI4MQy8PCf0yzeM7hoq8RfXzehYUuOE/mMzgLAzU5
         l/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P2HhH8guhta86S5605kqN5Fpf4VPJ3qSwUq040gmRik=;
        b=uRX0QF5Ngz+9LoypHCdgyWIAqg0J1/8lsdUEDadLIVAHx53+uKHg8Hgz9hftreC0Aq
         r0mzcpe3Ycw8yD4D6pqLjfUAjrWr7vRo8mRs7d9sTPCDTwen7z1jMnMSQ7tDi9UA9UNz
         5HJDumlkTqYG8iwQ9UeUUAOMeF/aPe9SHvF0yAeNLfS6qgk6kDWtFBFDAvKqzAIyAiVw
         ZkpGLAEEjEJ/UXwMdamfZ4UaueDlovvN2vZlklTaAtfdihDwub/M6wUdhh3Kniia3R5l
         ZLYF2w/qjvaUt8xKRlQJRrR4RmsQYyULJqYGlKzW/B5mnoEc6FILyxdVrnG8HEXqwIN2
         29vA==
X-Gm-Message-State: AOAM530IRKTQPD1cH1PcfAY2lvLJyHFn3zIL0fHtUmxk6jHmnp25V43a
        CPBQ66sDEkzf1aKgHrMsYOtLBOlawRef
X-Google-Smtp-Source: ABdhPJzpOiTvkOQp/eLCOVbVooNjGST6jvV4yRj+qNFTjDSTcCx78tUUwFs1zh4lcm2s9a1yti7ljdeVtC/I
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ef90:beff:e92f:7ce0])
 (user=irogers job=sendgmr) by 2002:a25:be44:: with SMTP id
 d4mr8061096ybm.497.1623955353529; Thu, 17 Jun 2021 11:42:33 -0700 (PDT)
Date:   Thu, 17 Jun 2021 11:42:15 -0700
In-Reply-To: <20210617184216.2075588-1-irogers@google.com>
Message-Id: <20210617184216.2075588-3-irogers@google.com>
Mime-Version: 1.0
References: <20210617184216.2075588-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 3/4] perf test: Add verbose skip output for bpf counters
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
index 2f9948b3d943..81d61b6e1208 100755
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

