Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1603435AAFA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 07:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbhDJFCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 01:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbhDJFC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 01:02:29 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2D3C061763
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 22:02:14 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id f29so5383579pgm.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 22:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/FRqUqvNjs79TnDqfwRoRqULHUSQK3XkQp9fw1XE/Ss=;
        b=uLb+rAlP0rliUZ9kzB8VvMlZWsMmWz7FMZN7x1QXRzTkgffgWxG5QtRMR10sqWiuZ/
         m3xOzH8wdXgp+yujnDOKeVUszCevlHvsVE6qz3EIG8ghEBNI5sm5R6BOuflfVT21wRXr
         y802OYRVR6Qg+7WqWMtnrC5ZX47iKttoZDh9hCERu46Ak55sHYL6PJZsXesF1InV2xBY
         MrH98RZ1bRgbd6HrN9XgBEkmX1R5ZpRfZkOaSPHGN0PBvFSf3VTybMONajbwgjHJtbiV
         ojXjkVry+/QAb/diVs0MQDZVjWgcEOtT9j0QsMpr6j+K4SKWwZXVs0MTHofzQ5G1Maer
         6NyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/FRqUqvNjs79TnDqfwRoRqULHUSQK3XkQp9fw1XE/Ss=;
        b=bPKfLjZ8sVA8sYgxPOI5kLCYxCp2eyoPmEmaL03cCCoHmFA40eDuvZwWkG+YF01Jed
         CreEy18hp1EFTxiamtyvw3fnG6u5IfLTt7uFRsq01qiDxchj5f+ArhROvpUzeDQZxsDB
         vN0Jd+kIRIDUjfDqpzVtPkhEuP/yhj70ntkvqtIRSwNHNHAjOJgmNtTuK1kLlSL8H1T8
         BtxmRZ0XQJnqBRRM/kbrfT2S58AVOtndxY4wDAqgOKmDCknqChBsuzxRxu36k+G9ZneK
         H7FmhZZFgrYKoNsePqQ9NuHAK5QDhFqH//3+VKk6sI90SkxMqTbb/1qrHG1AQPXmbWbC
         11PQ==
X-Gm-Message-State: AOAM5300pqd4JGNRUJI4QmB2QSZXuAbYrqD0aIBrB0jGRz1Rzg90DRIG
        eak5rfpKGNAEa34/38C/RMbnfw==
X-Google-Smtp-Source: ABdhPJxPDNjwlwFKTNRs6KKYQT7AO5Ydc9sRTph0uNM4ScrRD/fIuoA8TtPbGVL4lAopQ9VJidLVtw==
X-Received: by 2002:a62:7917:0:b029:23f:594:e289 with SMTP id u23-20020a6279170000b029023f0594e289mr15293911pfc.1.1618030933682;
        Fri, 09 Apr 2021 22:02:13 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id k69sm4398112pga.45.2021.04.09.22.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 22:02:13 -0700 (PDT)
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
Subject: [PATCH v3 6/6] perf arm-spe: Don't wait for PERF_RECORD_EXIT event
Date:   Sat, 10 Apr 2021 13:00:46 +0800
Message-Id: <20210410050046.5394-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210410050046.5394-1-leo.yan@linaro.org>
References: <20210410050046.5394-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When decode Arm SPE trace, it waits for PERF_RECORD_EXIT event (the last
perf event) for processing trace data, which is needless and even might
cause logic error, e.g. it might fail to correlate perf events with Arm
SPE events correctly.

So this patch removes the condition checking for PERF_RECORD_EXIT event.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 8facda81a06c..5e98a29fcbdb 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -717,11 +717,7 @@ static int arm_spe_process_event(struct perf_session *session,
 					sample->time);
 		}
 	} else if (timestamp) {
-		if (event->header.type == PERF_RECORD_EXIT) {
-			err = arm_spe_process_queues(spe, timestamp);
-			if (err)
-				return err;
-		}
+		err = arm_spe_process_queues(spe, timestamp);
 	}
 
 	return err;
-- 
2.25.1

