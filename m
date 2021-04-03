Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269103532F7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 09:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbhDCHYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 03:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbhDCHYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 03:24:18 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5137EC0613E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 00:24:14 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id h8so3415968plt.7
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 00:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3bJYjuYCTtWhwrCKpGnHmADzRXHuRA0WJhswRPbqlcU=;
        b=pr5WXbxne+FcUj2UFlhSterJzYjP5duG2D8uS214Owi4kqU75mB6LaUdtM5X+CyFpH
         Ys6Kfa7CTn6pIAoDBdKIEp7A5qEhpsCTa0ktTjVGFQqCNpQbqPssOOFeZF2t70a0OdFT
         arhCgUaReJG5D3bgTUPHsAn+0JeTO2eB9UZe7h7/N+FlSBYL9FyamzHnv4iaQxWdoMDj
         hTJKloem+OkHarkkhMkEpecZXh0Q+Cu8EfOu+Lmr17rhNab8rfA7t0Gk8apCK9WC2LGd
         uBtmkTGtENETakU7nISZzNhfWJ17k/a6fKp+L6pfJ/L95R9mdmWYPcC26eQYzgUBXjo9
         LLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3bJYjuYCTtWhwrCKpGnHmADzRXHuRA0WJhswRPbqlcU=;
        b=DHAzo1k+m0xVjKwT0uPOAIfKUTq9c4ZpZo42DlbcHkzVw+OGQ4Ns5FeKgkD/TSCxRL
         BhZIa8iEWrpXU59h1I54ZNn6RRpK0LJxsE7AZwos70BY+m4cyLTnXPX66igBsvTerClu
         B6sLI05nHPITIPNRbZusadDNS1kSzTvo8eZ9DBsz7GJh9u5tF95ekBqSER6CG66aEPcg
         EqxiBd27X11FWSfZrYvUzUvQnhOdGadngMjlBDWViM1rWnvn4kh9MAN0Oh3YxvylWqyB
         kNTiU/1kRssnqfuzLf/nk5LVL2l4FJkhGgCOi+SncyWlcHY4UFQxkoLeacgCKFTc0vMy
         AW+g==
X-Gm-Message-State: AOAM531rQSwtOt9VkCs9Me3WQwxYvfMpLAzBwpdPR/4rLDV1EiSPSWs9
        3Te7VF0aeiz9cJUx6pnq8/LceA==
X-Google-Smtp-Source: ABdhPJyFrX/o3qSUr9LuQOET/PDRhP/R2J/f2Kn7OSD6Kr3BHukRxCdWYhjXxvGrmqx1RFNtEQ5UDw==
X-Received: by 2002:a17:90a:f2cf:: with SMTP id gt15mr551359pjb.49.1617434653854;
        Sat, 03 Apr 2021 00:24:13 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id d4sm398196pjz.46.2021.04.03.00.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 00:24:13 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 6/7] perf arm-spe: Bail out if the trace is later than perf event
Date:   Sat,  3 Apr 2021 15:23:45 +0800
Message-Id: <20210403072346.30430-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210403072346.30430-1-leo.yan@linaro.org>
References: <20210403072346.30430-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible that record in Arm SPE trace is later than perf event and
vice versa.  This asks to correlate the perf events and Arm SPE
synthesized events to be processed in the manner of correct timing.

To achieve the time ordering, this patch reverses the flow, it firstly
calls arm_spe_sample() and then calls arm_spe_decode().  By comparing
the timestamp value and detect the perf event is coming earlier than Arm
SPE trace data, it bails out from the decoding loop, the last record is
pushed into auxtrace stack and is deferred to generate sample.  To track
the timestamp, everytime it updates timestamp for the latest record.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 80f5659e7f7e..99a394c366e0 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -434,12 +434,36 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 static int arm_spe_run_decoder(struct arm_spe_queue *speq, u64 *timestamp)
 {
 	struct arm_spe *spe = speq->spe;
+	struct arm_spe_record *record;
 	int ret;
 
 	if (!spe->kernel_start)
 		spe->kernel_start = machine__kernel_start(spe->machine);
 
 	while (1) {
+		/*
+		 * The usual logic is firstly to decode the packets, and then
+		 * based the record to synthesize sample; but here the flow is
+		 * reversed: it calls arm_spe_sample() for synthesizing samples
+		 * prior to arm_spe_decode().
+		 *
+		 * Two reasons for this code logic:
+		 * 1. Firstly, when setup queue in arm_spe__setup_queue(), it
+		 * has decoded trace data and generated a record, but the record
+		 * is left to generate sample until run to here, so it's correct
+		 * to synthesize sample for the left record.
+		 * 2. After decoding trace data, it needs to compare the record
+		 * timestamp with the coming perf event, if the record timestamp
+		 * is later than the perf event, it needs bail out and pushs the
+		 * record into auxtrace heap, thus the record can be deferred to
+		 * synthesize sample until run to here at the next time; so this
+		 * can correlate samples between Arm SPE trace data and other
+		 * perf events with correct time ordering.
+		 */
+		ret = arm_spe_sample(speq);
+		if (ret)
+			return ret;
+
 		ret = arm_spe_decode(speq->decoder);
 		if (!ret) {
 			pr_debug("No data or all data has been processed.\n");
@@ -453,10 +477,17 @@ static int arm_spe_run_decoder(struct arm_spe_queue *speq, u64 *timestamp)
 		if (ret < 0)
 			continue;
 
-		ret = arm_spe_sample(speq);
-		if (ret)
-			return ret;
+		record = &speq->decoder->record;
 
+		/* Update timestamp for the last record */
+		if (record->timestamp > speq->timestamp)
+			speq->timestamp = record->timestamp;
+
+		/*
+		 * If the timestamp of the queue is later than timestamp of the
+		 * coming perf event, bail out so can allow the perf event to
+		 * be processed ahead.
+		 */
 		if (!spe->timeless_decoding && speq->timestamp >= *timestamp) {
 			*timestamp = speq->timestamp;
 			return 0;
-- 
2.25.1

