Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3285B30638D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 19:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhA0Sro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 13:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbhA0SrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 13:47:14 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A114C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 10:46:34 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id lr5so3766641pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 10:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=yPncN/LFb+0jOXCobtprg4BugjzjBQthXlQSnUT4zSM=;
        b=MhWappxKaXxg6YMqcS1thj4DiUb//XodXNlHneWpWxvpgQJojbEXC2ZPffUYdp1oWp
         Hpjavvp4tVwxbjCeO1sjCW+c7jTowLWljnkReaiac0VVQSuxnu9PE8ppYE7+S9uAcZ7/
         CuMIqMzYCSv2AY2fhVc8y8YC8QjipejYu7JWpVjx4yz8RHJc0fLLUhLPYjV4nCoF30nh
         Yr15bvc3VZuZn3YrvpoFVMtXtyle6dRTd7I4YX06uKdnMKpQnldcPzN32axXGxQ+u9J7
         3DrSKmfVEXLNH9QgzC4OqI9rAjPx/WNwQcmK1anyTuRn52UeE6u7j1Pq8uFYeIGHGgnf
         BFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=yPncN/LFb+0jOXCobtprg4BugjzjBQthXlQSnUT4zSM=;
        b=INRSVh1vvOyE+SUqrrmLaZ2RkTXheaSNDjuKo/p36TxlYbb/LYGVJBzGAelP6Glv9L
         qlinnkMua0Vy8JSjCp8mkgN/6ggU6qOyI2FmbJrq7JgjObh6JjbzdWPey5PuB3G2x3Md
         5Q4pK/GzsBQoscF/TNlhfKno6koK3iHvQTN2cZKSuz4LM8Qm34JvA9nsn+Nu6185PSdy
         FSKx1TOTPgRTxfrKTEPgr6MNvKll0d5sJglhojt6egHlwBxT2CcrcyAqanBgNLJAoojO
         WbR6TFkC1cFd8mBdJ9HZ2BEZSLU7xQ2xVLb7uaAr8o07gmtc/3RwO/TkrKhKAHj1WuNB
         OOiw==
X-Gm-Message-State: AOAM530nQTP/Yv2al4/MP/It/k8FVSbDTjgPUawII1xv99UXuTTpNYq4
        U4LwrSE6PA9C1SIc8YCsEi7S1v4iFY3U
X-Google-Smtp-Source: ABdhPJwuCmJRdmDAGrXtGpAPk7pHY5jjYTfdVKNZ4WOl8wyib9z5NvMEZgkRoT6DS+5OfXxZrmRuURfLw9ug
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:8c72:a975:ea6f:4bbc])
 (user=irogers job=sendgmr) by 2002:a17:902:ba85:b029:de:ba16:818b with SMTP
 id k5-20020a170902ba85b02900deba16818bmr12683320pls.75.1611773193849; Wed, 27
 Jan 2021 10:46:33 -0800 (PST)
Date:   Wed, 27 Jan 2021 10:46:29 -0800
Message-Id: <20210127184629.516169-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH] perf parse-events: Remove unnecessary #includes
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor cleanup motivated by trying to separately fuzz test parse-events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 2 --
 tools/perf/util/parse-events.l | 1 -
 2 files changed, 3 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 42c84adeb2fb..8982b3c8014c 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -19,8 +19,6 @@
 #include <subcmd/exec-cmd.h>
 #include "string2.h"
 #include "strlist.h"
-#include "symbol.h"
-#include "header.h"
 #include "bpf-loader.h"
 #include "debug.h"
 #include <api/fs/tracing_path.h>
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 9db5097317f4..03d2ac04edb3 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -12,7 +12,6 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
-#include "../perf.h"
 #include "parse-events.h"
 #include "parse-events-bison.h"
 #include "evsel.h"
-- 
2.30.0.280.ga3ce27912f-goog

