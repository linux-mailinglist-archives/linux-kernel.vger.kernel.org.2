Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4AF35AAF9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 07:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbhDJFC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 01:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbhDJFC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 01:02:26 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC56C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 22:02:11 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f29so5383513pgm.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 22:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oe35wE+BbVYSlAv6bLKQWBrNW+CpBkb1nP7qyvMaXOo=;
        b=dakQ+7hDI1n5d61cGeZvMd84eX85QsLx2hO+uFeKBPnbmiVnsshDUV+1ujTxrB+ObS
         27ata5OTwKYpGKcNnkH7DDnZHEgUZXdMbeRoIkllbxeK2e2a5iRNksB/dchRn+fzZHIZ
         90FwUQJghrprLe3oqW/j0/+ORgd1031GGlouMIAZfmlaU7jUhCRDvq17abgU2UgZ8ziw
         CkWnCuY9l9tWfd2bU3lq7n2Td08gtCtxr3IDdTrdtYrV0WbODywdgtR9MOq8thijUJGs
         RnzWkJoN7Rml8Nf+TxcdGOXnoU54aqq8aWGwptPjHqD+b4uWPiHMPrA8rGkyqMRLhmvg
         +jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oe35wE+BbVYSlAv6bLKQWBrNW+CpBkb1nP7qyvMaXOo=;
        b=kZLZErRH57U85Ov/3N2gkkpjT+syKvj6ZjvtVmkGdqNk0j6UonmdCc1wvQohk2Na1s
         C3KeMJG/t4D8NnVYU6AdrmzwkFzuo28cvkEX0f5O/B5wUyTKK7dSfIrEQkbTbih+YUPU
         zwRIAUQN8931QUXTiixc2Zivn99C0peU1sUn0sLFAQpA2I8L8pFDYFdKi24drYW7tNcF
         tuzFWz2EZRXVqZbwnafbq3AQ1RSg38XaZRu1vnB4VDiX66hK2pUwtxvcXyFZ6vpo14sn
         ntCGBVkUMcZkVTswmnRaJX0w1nckkIgIAXtrglvsA3pkb3Q5vagsih2GrseqYCo7Ws5S
         XPsw==
X-Gm-Message-State: AOAM531wK9kyXwoXYWLpK5n+MnPCrgkypH/FgjPHydPrcI6c4jOdPt4X
        TTRDnep0tp0C/udmGsChZbp0iw==
X-Google-Smtp-Source: ABdhPJyXSvyNZhwpBbAQW3KabH8C0q+ZCfDMdRyhi/bsjFI7/yMNIIdibN0V/+JBs2oG8luUqhJ6uA==
X-Received: by 2002:a62:1757:0:b029:23e:9917:7496 with SMTP id 84-20020a6217570000b029023e99177496mr15395996pfx.51.1618030930814;
        Fri, 09 Apr 2021 22:02:10 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id w18sm3575933pjh.19.2021.04.09.22.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 22:02:10 -0700 (PDT)
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Clark <James.Clark@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 5/6] perf arm-spe: Bail out if the trace is later than perf event
Date:   Sat, 10 Apr 2021 13:00:45 +0800
Message-Id: <20210410050046.5394-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210410050046.5394-1-leo.yan@linaro.org>
References: <20210410050046.5394-1-leo.yan@linaro.org>
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
index ec7df83b50fd..8facda81a06c 100644
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

