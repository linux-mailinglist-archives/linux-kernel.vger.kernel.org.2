Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9FE39F99F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbhFHOyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbhFHOyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:54:52 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE01C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 07:52:43 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id i34so10277530pgl.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 07:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NJBbIlN10zo6gxtXyHmx0RKdZoV8MV2Ra7I8+9IhS8c=;
        b=esGPVs/lq0L7m1V0gyMSaCe3KocNIKP+AgRVCaoZn/g31pb1FllDHp/xV9eryEpl1w
         3M+jq2UQly6MVNA02fsXwPKLhu8kRqT823H1of10K9/lEI6+ebGMHDoeb6HUavi69tR2
         3p2b0M91M+1z4Y2ihQKAXxjPPhYpxS2hiEi1syqKJvjZPrE1qUubHplBFkV7VRXmndPl
         rLnTc6LxNC7J0F5smIIIafKMeGMxVUTZMSiU2F+qzq5itlQNXl8BNz3JOBqwilP8YXyF
         1bbG/jqgVc0IurvnjhV/EzE7h6JAE+qfEdDjPcvWkwSbhS5iVelwve3xMPZh3b/xYa93
         iyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NJBbIlN10zo6gxtXyHmx0RKdZoV8MV2Ra7I8+9IhS8c=;
        b=ECJ3Xa5Uy5dOWGhm0Ybqwzb62g2ODwYOlIqVia2B7yyDJYCQlNYY2yAg/2FpTJnPOY
         oGfU4oa070RIVG4x01cKRAGgZVFRFgzzhzXYbo4BFZwSFLLZBZnbPSR3+7UkwsSL0K7h
         x00RubCeOFFC8Sz0YYU5uhf4U/YkOuE8ddYZkWOC5Z2LYjDDXC7G/Y84lpsGoHlcdiKx
         ztxrg8AVQEbr/v2vOCcxiSeRIPYt8nnE9sPv5Gon1w3GGP/hMpcYhPgOHyBuEKlix2Qx
         itxnYvupJguEfBzabcZ/4y9YOPeJ/+i+umX+JbiBC+meyRMNv6Lki7Rp10QECNO2mnDw
         N44Q==
X-Gm-Message-State: AOAM532jbRz9cgFmLQo1EmbXaZnFTAx+6QjrvaVxP7qy9wIMQdXUya4j
        LN2y3CGCxlCx/6qUhlzQmMG5sA==
X-Google-Smtp-Source: ABdhPJx+15XdCLs2WnyMINrYpTVoNMyg3aXt4IuPoUQlZk8IIWVXFF1IbDyyudDqlztbcZyT1J9evA==
X-Received: by 2002:aa7:8003:0:b029:2eb:2f8f:a320 with SMTP id j3-20020aa780030000b02902eb2f8fa320mr49724pfi.70.1623163962242;
        Tue, 08 Jun 2021 07:52:42 -0700 (PDT)
Received: from localhost (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id r11sm11995875pgl.34.2021.06.08.07.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 07:52:41 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/2] arm64: perf: Correct per-thread mode if the event is not supported
Date:   Tue,  8 Jun 2021 22:52:27 +0800
Message-Id: <20210608145228.36595-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the perf tool runs in per-thread mode, armpmu_event_init() defers
to handle events in armpmu_add(), the main reason is the selected PMU in
the init phase can mismatch with the CPUs when the profiled task
is scheduled on.

For example, on an Arm big.LTTILE platform with two clusters, every
cluster has its dedicated PMU; the event initialization happens on the
LITTLE cluster and its corresponding PMU is selected, but the profiled
task is scheduled on big cluster, it's deferred to handle this case in
armpmu_add().

Usually, we should report failure in the first place so this can allow
users to easily locate the issue they are facing.  For the per-thread
mode, the profiled task can be migrated on any CPU, therefore the event
can be enabled on any CPU.  In other words, if a PMU detects it fails to
support the process-following event, it can directly returns -EOPNOTSUPP
so can stop profiling.

This patch adds the checking for per-thread mode, if the event is not
supported, return -EOPNOTSUPP.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/perf/arm_pmu.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index d4f7f1f9cc77..aedea060ca8b 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -502,9 +502,9 @@ static int armpmu_event_init(struct perf_event *event)
 	/*
 	 * Reject CPU-affine events for CPUs that are of a different class to
 	 * that which this PMU handles. Process-following events (where
-	 * event->cpu == -1) can be migrated between CPUs, and thus we have to
-	 * reject them later (in armpmu_add) if they're scheduled on a
-	 * different class of CPU.
+	 * event->cpu == -1) can be migrated between CPUs, and thus we will
+	 * reject them when map_event() detects absent entry at below or later
+	 * (in armpmu_add) if they're scheduled on a different class of CPU.
 	 */
 	if (event->cpu != -1 &&
 		!cpumask_test_cpu(event->cpu, &armpmu->supported_cpus))
@@ -514,8 +514,16 @@ static int armpmu_event_init(struct perf_event *event)
 	if (has_branch_stack(event))
 		return -EOPNOTSUPP;
 
-	if (armpmu->map_event(event) == -ENOENT)
+	if (armpmu->map_event(event) == -ENOENT) {
+		/*
+		 * Process-following event is not supported on current PMU,
+		 * returns -EOPNOTSUPP to stop perf at the initialization
+		 * phase.
+		 */
+		if (event->cpu == -1)
+			return -EOPNOTSUPP;
 		return -ENOENT;
+	}
 
 	return __hw_perf_event_init(event);
 }
-- 
2.25.1

