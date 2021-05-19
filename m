Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D44F3885E5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 06:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240217AbhESER0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 00:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbhESERX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 00:17:23 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205AFC061761
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 21:16:01 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id b7so2126312plg.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 21:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9hP472i8tu0x2oWr2ZZdW3TiExRRKywLv6WAxBp0eH4=;
        b=ZqWbS934HXeMusilkVQHGpZ3Q7vGiO7M0MUhqBwrcrwXi+yiv+LfI1IFFgG55aPJ3F
         AqPEzAT7IbucWE+hJY1kLI3IgxoGc26uDeR8hTERW6r4mUhqr/wj25zAXWpckxqMyJaQ
         e9wa8PoKnLRs6YM2oykFuACMjKlfifKrW/fRG8dH5auH3N++J40GsQb/mOGRSbp7AVtt
         63ew5qNPYMksJ374gKdWGU3yxvOlLUj5a2GWDAzzBIOolZT8BYehXPx47F5zXJe1ZxIp
         oS0+kaCHvPBfeER/gIuQpIjD4BQ2cJJOugivvlmBYPxNN3J+NmK1UfzRCeFHqoyRV6gW
         IqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9hP472i8tu0x2oWr2ZZdW3TiExRRKywLv6WAxBp0eH4=;
        b=LPewvBSHl/8VeAUQkDEPTI2MuhbI2y7LH8wYPwjftZNGSGS7cYCkzUadd/FLQbZNoH
         j1bIMeV+0YNkpWrwEv3hNlANNWgGxWId++sebeyHEdr/8pg2xna3eQIzGErLn0BY6qH6
         b+t6YofJiQ68i3xOjDRREYAeExspC08MsRdSLwMmFKxvzEg/8cq6CeYb938P+VYvBcTD
         j1DvrnagudwzTyZ/8Lea+Gx7X9tYI3tufn1MMuUHMneKh4LfJyrSfmHAcO1w5QKjZfud
         hVtBHa9x7zykwCdYRA6UzdVXAhR8a3aBIoiUkj/FtfxLhGM/bn1ZxuYP3CH+cBnGsQbG
         Dbog==
X-Gm-Message-State: AOAM530rw+wsDK2kvw60YSlA5vedXCwl83TOBdski3Jek4BYu7tsDfVC
        dHJxhfFcyIHZ6Ya3JQnd6/n2VA==
X-Google-Smtp-Source: ABdhPJyGVQQN0GIEUbL3koaYY2sK4NeUkK5gEA8vO0yJRRxu3bib5xdQI2HlfpWuxUUBFFDAnKf5BA==
X-Received: by 2002:a17:90a:1a43:: with SMTP id 3mr9090485pjl.154.1621397760560;
        Tue, 18 May 2021 21:16:00 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id kk7sm2993954pjb.16.2021.05.18.21.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 21:16:00 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 2/4] perf arm-spe: Correct sample flags for dummy event
Date:   Wed, 19 May 2021 12:15:44 +0800
Message-Id: <20210519041546.1574961-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210519041546.1574961-1-leo.yan@linaro.org>
References: <20210519041546.1574961-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dummy event is mainly used for mmap, the TIME sample is only needed
for per-cpu case so that the perf tool can rely on the correct timing
for parsing symbols.  And the CPU sample is useless for mmap.

The BRANCH_STACK sample bit will be always reset for the dummy event in
the function evsel__config(), so don't need to repeatedly reset it for
Arm SPE specific.

So this patch only enables TIME sample for per-cpu mmap.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
Tested-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm64/util/arm-spe.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 902e73a64184..4c916626c203 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -135,9 +135,10 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 
 	tracking_evsel->core.attr.freq = 0;
 	tracking_evsel->core.attr.sample_period = 1;
-	evsel__set_sample_bit(tracking_evsel, TIME);
-	evsel__set_sample_bit(tracking_evsel, CPU);
-	evsel__reset_sample_bit(tracking_evsel, BRANCH_STACK);
+
+	/* In per-cpu case, always need the time of mmap events etc */
+	if (!perf_cpu_map__empty(cpus))
+		evsel__set_sample_bit(tracking_evsel, TIME);
 
 	return 0;
 }
-- 
2.25.1

