Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987903532F8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 09:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbhDCHY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 03:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236514AbhDCHYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 03:24:19 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459BEC061788
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 00:24:17 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id a6so93247pls.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 00:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aVowY+HNEZ8f93+BvCcRoQEWjKnoEyL6nLVoSj85YSs=;
        b=zykFXQxAT+PKo/kXZ9htIc0/A1fsc4wSNY9pbf6pjVPeVe5MWZZsO5bDF9mcJrdi1M
         PmSqf33YsrXg1tflyKbwASByUguVQAM0bGx19HYaRLLMbErBWMqR/LmTyfBxp1Ig6pW1
         V+avYKDZ6ngh3aY6LHFnAJEt+AfsJhTtoqsFF0icCIOURfb6dKHnD63RH0Oml6hBxEXt
         VSv3VbspWOybX8gQALM04jqZjaOXim19w2GeTulnE/TfZ3Or3DPi5XmiHXCbQX5ZNNJn
         8Ffgob4rtNAj7Ztb21ZW3rN0M4SNOZe/sQS8xfDxFR92ZXIJxnKkdjxyEEKAxj/vfYAS
         Rsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aVowY+HNEZ8f93+BvCcRoQEWjKnoEyL6nLVoSj85YSs=;
        b=RXvDy1MpowcYnCRrubh5LZft/LqWtLFHNcAfAdbxfFwfbZKPDb2ErP+gJ6vMLHak7e
         Yi72OAhWWpa1ym5gYm4yTb/cCvwwVzKc3yAfYL799rGLx8e7l0fDjGmEf/+TT2L2y+wD
         bf8J5jErq2KDuWBIrHImgpaMEfnsikFeCaAv3QC7H9u7i+/dqlrOr3ucClFa2SvCNCgV
         ZBGjDtJkeItps98t3UkwYk3Ym9IBhp5GksLIjTOjnDD1TE2i2jAbxXHk8HF5bN8KZs37
         9u8rQzjSTc4LEwZcxUnqyl/uaL9NeXHxJFXpolHgYOmzZjeZrwZufL/hSe634kNTP4IU
         J1aA==
X-Gm-Message-State: AOAM531DCqKE/NegiaRTijBebxrPXPfuyFO3Wcng/8gqv9GRMG7JbsTu
        hwpW9qtsnqXFKzHH+ukuN+0N6Q==
X-Google-Smtp-Source: ABdhPJyVnlDCnwIailYc6VsRqgA2w6L9Bvz+1fyAPM3K6Ahop+AkYQU9VEAIbebVHqvGcvNCiH/wqg==
X-Received: by 2002:a17:902:a610:b029:e6:5eda:c39e with SMTP id u16-20020a170902a610b02900e65edac39emr15965751plq.11.1617434656797;
        Sat, 03 Apr 2021 00:24:16 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id o9sm357972pjr.43.2021.04.03.00.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 00:24:16 -0700 (PDT)
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
Subject: [PATCH v2 7/7] perf arm-spe: Don't wait for PERF_RECORD_EXIT event
Date:   Sat,  3 Apr 2021 15:23:46 +0800
Message-Id: <20210403072346.30430-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210403072346.30430-1-leo.yan@linaro.org>
References: <20210403072346.30430-1-leo.yan@linaro.org>
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
index 99a394c366e0..17dcad99912a 100644
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

