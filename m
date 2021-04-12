Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A2D35C21D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 11:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241398AbhDLJjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240782AbhDLJK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:10:57 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E510C061345
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:10:37 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id k8so8883791pgf.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DDdEqeCFnwU5ANrpdIiJovBy2YEnraj0jTTiTw73jWA=;
        b=gg91CZixyITMefJ1sJhgx2hdXm1ZE+PRY67Lka7AurxoPGvAFDu78OuIbjd8ih6vVl
         I/oeaaFX5uePc5UX5CIMzuWc+mL5n9XSyjzWMB2j/bBUrdkFDXntmO+017RX/UX+zhIB
         fe8yPcIuPIbrw93HkbAYlapl5xsTSrLQrtqksd+y4ON7P06weocFwd634h675ZQJcH6A
         NgQQLS6gLGlwTMC16kMGtVhGJOx8nUo197GKeu9pgp4JhoQ9+0PMqdxdXuewhtuw+qn/
         qr8k2NWxTuUrTAnNIGK55rwzJ+4WAuSppVdo6O3aV2nL5zfyGPYiNXvWDOJUz7mVDtLm
         MKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DDdEqeCFnwU5ANrpdIiJovBy2YEnraj0jTTiTw73jWA=;
        b=tZtYjDghlUR7u9LKdGHU7EESVWHd9ohK1wC3glZRcGbeIC5DnZgxCJIgK87t+gv/BJ
         hikQVHMHpKToBO4JHmOlW4HtyDUvOxbxAohShaLXp5R/GXQWVusW5AoxfbeGVwA2Bjs8
         IhZzAl1XbU7A7Ibsjrb/RcakZ/BdMH8RMPb3gRj1KpSoDbA5sGSHL7IayQtM366A67ij
         D5vHYATxNkmTlWQKeBHnQtys6gFXb3xNWSwjMFmVzljzROwWuMtHYolioWpZKQfCslob
         DqyybYAfeO5VKdsS3u6PHjgWd+9kSosClYwdxqGYAS6LpNtg5jJKuc5v6NxNc88fjf02
         Btzw==
X-Gm-Message-State: AOAM5314Wg0fXCSE8nkA8RP9csMhkqi6Tk21hes6a8+z4OTVm04RxkOa
        4mo1qsjQFvtVTz4rv8uft/FXXA==
X-Google-Smtp-Source: ABdhPJz7fgOGppChz65URuEp0R1SWnjO2GdVuEfsC8NuxoeKAA2p/4KKgvB+VV+20LJHEFGOL/1BLw==
X-Received: by 2002:a05:6a00:8c2:b029:23d:60e9:ecb7 with SMTP id s2-20020a056a0008c2b029023d60e9ecb7mr24072334pfu.57.1618218636576;
        Mon, 12 Apr 2021 02:10:36 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id lt11sm1503371pjb.23.2021.04.12.02.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 02:10:36 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Al Grant <Al.Grant@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        James Clark <James.Clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 5/6] perf arm-spe: Bail out if the trace is later than perf event
Date:   Mon, 12 Apr 2021 17:10:05 +0800
Message-Id: <20210412091006.468557-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412091006.468557-1-leo.yan@linaro.org>
References: <20210412091006.468557-1-leo.yan@linaro.org>
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
index c13a89f06ab8..b37d1cacebe9 100644
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

