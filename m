Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D0C3532F5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 09:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbhDCHYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 03:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236514AbhDCHYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 03:24:10 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6102C0613E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 00:24:07 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q10so4867404pgj.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 00:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2iRAidDQZZyw+FCAbxC+zhmWRgrEuLTIWjSv5I3ugHk=;
        b=N3OMEkPxpcbuiG6JAZcYAJb3Q9Om5ZTE6egSBdnSbrOIk7sa8c3AwHMZx7KIPJgRCd
         n//aEO4w5TzMQBXno7oIU7uwHD09MHQ5+wfhVtL/stVvrGsJwOq14zOi6gF2MOiZ4w/N
         Dozjk22vCFIp5NyQ36wak2M4PWz1Thn+BTdiRq+vJs3LnapT4OPoEnrfh4gunvuXAXJb
         TGp1xn1DnUYyRkG3AYWO7le6zxm3VcFR4j08iSZjPmAKeUTMxUA2UjfML6J3M/6rVn1C
         AYV/ec1JiuYjfkhipccSCsAEMopwYTthS4HGjcr5s4y+eQwdAIOXTL/4849IhazX40CG
         JTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2iRAidDQZZyw+FCAbxC+zhmWRgrEuLTIWjSv5I3ugHk=;
        b=WAuQtADMBUIK8b/uIIFDWvO4LZ0OYEbNuGBWNG95SUbsMWjXSRhJOirBDhbPZqDNCw
         EIFIRQVgc+RkSvx/b01TrnNHKP3at0B2yBWW3dfR/5rT2DZ8UvtN97TUBe7ypaGkSE0M
         zBpXovOTDdqPtcBHLkd4qCTynr2TK8yLOaBloe7j20N3JqFnq3TelMwjVeDTGBICpYgk
         IBQ24X3fgl9btUDAQ+ocgp+WZFsjv1ppr4p2QHYyIrbwHtu2TKbofb2IvJIOR+QbgwfB
         BkphDFZCjrXmoDx0uztubvV6HWCR8GWE+0mmYJxrOFMaMjvtzeXr27q7XLVODHrrBBeZ
         +Cyg==
X-Gm-Message-State: AOAM532vdnu+3TBHyCUU6W1vYfM4YkZzD6ZuBepV+wAfeN0Bh0DOp68V
        P83A12GNJ4XkqX/ODst279c8OA==
X-Google-Smtp-Source: ABdhPJze1wkZyt45WZ6IhC4qAtW1rNz0+KIiZjfpj1Y+PMXRL8erQqB1Z2zcgSsiGPTfH2q3lL1xcw==
X-Received: by 2002:a65:538f:: with SMTP id x15mr14932441pgq.429.1617434647491;
        Sat, 03 Apr 2021 00:24:07 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id y12sm10306484pfq.118.2021.04.03.00.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 00:24:07 -0700 (PDT)
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
Subject: [PATCH v2 4/7] perf arm-spe: Convert event kernel time to counter value
Date:   Sat,  3 Apr 2021 15:23:43 +0800
Message-Id: <20210403072346.30430-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210403072346.30430-1-leo.yan@linaro.org>
References: <20210403072346.30430-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When handle a perf event, Arm SPE decoder needs to decide if this perf
event is earlier or later than the samples from Arm SPE trace data; to
do comparision, it needs to use the same unit for the time.

This patch converts the event kernel time to arch timer's counter value,
thus it can be used to compare with counter value contained in Arm SPE
Timestamp packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 69ce3483d1af..4cf558b0218a 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -669,7 +669,7 @@ static int arm_spe_process_event(struct perf_session *session,
 	}
 
 	if (sample->time && (sample->time != (u64) -1))
-		timestamp = sample->time;
+		timestamp = perf_time_to_tsc(sample->time, &spe->tc);
 	else
 		timestamp = 0;
 
-- 
2.25.1

