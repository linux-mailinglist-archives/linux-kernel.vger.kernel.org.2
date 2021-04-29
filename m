Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAE636ECE5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 17:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240515AbhD2PCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 11:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbhD2PB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 11:01:59 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41C6C06138C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:01:12 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t13so8699143pji.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SE2j4G0rnU+RbiAnIU0X9z105Hwk3a+nEYNJ2sTp6CU=;
        b=o2ddHO/AJTn4nUM9kptqP2uMHAMJ+tXCezYjcHsPtHtR80o3MLq8ZcI0kgffb1PEfg
         YzVpScqWNeHsXdYbKZD/1Dn1dqBQQCHG+AuDXc5TXsUlYKmJ/IXGBqvUJhmE9e5Bp0rG
         AXSAhRsjkIjhCW3rnSIFonB08/nLdXVP+rlcb4QdcnUTmEtQWSHLQCJQqLCROz4BeUDG
         nzCk76wnyt2npPUsVmwQeHWlhBOMmqJkBnsECFgxrlTEaHPlrceAgHkwo82nBbvKsrOr
         Gm6kmwW/TlN3MRUppOT0xr7TuVUxXUseXw8agsFhll17BSzCcN5uIae2xBoycb3vMscr
         tA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SE2j4G0rnU+RbiAnIU0X9z105Hwk3a+nEYNJ2sTp6CU=;
        b=qan33Owi+k8kl3dSN1Tb4ouX7Dn0YcudO1uOLzRXV+dhNyTuPOUkMKHMs4FvfjtmOs
         TbOBwWGnQqQIKke+JM5vtCun87FYMPSM0iru7lppD4DJM5uqvuPTSHmPIEnrqaFsQdO0
         68wL7u2TSc2IElcLJCuS/8I1aPO8ipRWQNAx24nWD1T4+tI5p1b5G51tjStpI5jr6hwr
         Yy94m7jnrtiPmWiRLrg5filFX/bC7yijBt1zqHJtikq+xH6puXrIv6nC5Uj2eKSub4xi
         ByDrgWB5LGWNK82Zkry/ynEsm/5NE4llGTmtQAuadWhHYLBO/x4+7w4tTz3J/cHP2MAo
         9ANA==
X-Gm-Message-State: AOAM531SOOb95pHX4zBMMXDE3EV4dOyww77dynO9WuINT9s77Xy7jgGn
        2WnTE+d/NB+zh1AVibC6jBXKWw==
X-Google-Smtp-Source: ABdhPJwf7g1oC6ruN3H77OZGGIRAb6C00AkhUyagpmFnha9GKdP+iU7Pm4OP9a7ydWBuovm7owxq/A==
X-Received: by 2002:a17:902:778f:b029:ec:d04d:4556 with SMTP id o15-20020a170902778fb02900ecd04d4556mr152564pll.43.1619708472144;
        Thu, 29 Apr 2021 08:01:12 -0700 (PDT)
Received: from localhost ([204.124.180.30])
        by smtp.gmail.com with ESMTPSA id e2sm2627677pjk.31.2021.04.29.08.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 08:01:11 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <James.Clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Grant <Al.Grant@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/3] perf arm-spe: Correct sample flags for SPE event
Date:   Thu, 29 Apr 2021 23:00:58 +0800
Message-Id: <20210429150100.282180-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210429150100.282180-1-leo.yan@linaro.org>
References: <20210429150100.282180-1-leo.yan@linaro.org>
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

