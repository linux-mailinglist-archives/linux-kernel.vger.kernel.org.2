Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C4A3885E4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 06:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbhESERU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 00:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbhESERQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 00:17:16 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B3AC061760
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 21:15:57 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 22so8601296pfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 21:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dSvPMJ6ajKYTaE4dMLmv0bU7XqFPvynhF+nhCSjEXqk=;
        b=aaCOTZsa/3yjYLdqdA/OfbMLWzu9RyJRXuZPYfr+wm3AI9457kCSoFMDCrIsLQrGLt
         ByoCDOENXrICY1ExhAww4HbaQCkuMYnaHUi2moXVW/S5cevx0U9KeGKRAg+EdufUBA+V
         1ZxFBOdj8svbSNooNQOceeTijJZm1lZDYEkpSXhTi+1d8Lr1q4cCdCLsaO/eKDLf19ez
         2YkqD0JJR1s5x88/GXM+P0fpjAOd+F+NR7xfHvvKO4rjabQ2boL8aHUt8jn1GFkgTkj3
         8xlRFRQ1K2K41Dhesb7oEyVgmMTj+CsIX46gFK77ODinRCHexWx2mKDAQQu7iBu65BYz
         ZwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dSvPMJ6ajKYTaE4dMLmv0bU7XqFPvynhF+nhCSjEXqk=;
        b=Gxk3MjRV9azEXvXh1OQv2pnyNs/ULXlsoWvECy/zkzcgbet2Jgs8gipUYvdQRH/8d8
         AsWEDOTasN8p5+t7sZ1NkNH+RCw1waco2U9t/2bbGhv8M8myMuLcr1jVioB67nXbLY0s
         tmS57Lkjrrsp2bYYEMJZSDpLOPP93AScaMhHAyaNoBBEoVO1FS3DQ/2Y4QgQ4FCfnfu9
         qDStv3a5Tyso5P+Usq6hVvERZDVMeAYoF14CriTZUK6g/IU2v9JSGEhlE0bLG2NiXtAy
         szuFf1VGPOg+eiiNvsWjJKtRoLOCC9pmRHkWqjxLNnKyoOmKemJVrRN6jy4KjQ1P6DIL
         82AQ==
X-Gm-Message-State: AOAM533mtEuaFWyrSjYAPNgsj+lkNtQfSApV0LdA9Kb6BaXWWw0YNbxi
        x+yA6glYP4yWAz2jrE96KLTKMA==
X-Google-Smtp-Source: ABdhPJypI2NKauTPCzBLknKllWhLQ9Zb5c+DwOn8mkNjD/GPp1xQGsoaRdyiZLKLGIK9pw/p+X+/Tg==
X-Received: by 2002:a65:5248:: with SMTP id q8mr8763715pgp.176.1621397756718;
        Tue, 18 May 2021 21:15:56 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id d3sm13588742pfn.141.2021.05.18.21.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 21:15:56 -0700 (PDT)
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
Subject: [PATCH v2 1/4] perf arm-spe: Correct sample flags for SPE event
Date:   Wed, 19 May 2021 12:15:43 +0800
Message-Id: <20210519041546.1574961-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210519041546.1574961-1-leo.yan@linaro.org>
References: <20210519041546.1574961-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now it's hard code to set sample flags for CPU, TIME and TID for SPE
event, which is pointless.

The CPU is useful for sampling only for per-mmap case, it is used to
indicate the AUX trace is associated to which CPU.

The TIME sample is not needed for AUX event, since the time for AUX
event is not really used and this time is a different thing from the
timestamp in Arm SPE trace, the timestamp tracing which is controlled
by Arm SPE's config bit.

The TID sample is not useful for AUX event.

This patch corrects the sample flags for SPE event, it only set CPU
sample bit for per-cpu mmap case.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
Tested-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm64/util/arm-spe.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 414c8a5584b1..902e73a64184 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -68,6 +68,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 			container_of(itr, struct arm_spe_recording, itr);
 	struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
 	struct evsel *evsel, *arm_spe_evsel = NULL;
+	struct perf_cpu_map *cpus = evlist->core.cpus;
 	bool privileged = perf_event_paranoid_check(-1);
 	struct evsel *tracking_evsel;
 	int err;
@@ -120,9 +121,9 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	 */
 	evlist__to_front(evlist, arm_spe_evsel);
 
-	evsel__set_sample_bit(arm_spe_evsel, CPU);
-	evsel__set_sample_bit(arm_spe_evsel, TIME);
-	evsel__set_sample_bit(arm_spe_evsel, TID);
+	/* In the case of per-cpu mmaps, sample CPU for AUX event. */
+	if (!perf_cpu_map__empty(cpus))
+		evsel__set_sample_bit(arm_spe_evsel, CPU);
 
 	/* Add dummy event to keep tracking */
 	err = parse_events(evlist, "dummy:u", NULL);
-- 
2.25.1

