Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAFE3532F3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 09:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbhDCHYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 03:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236385AbhDCHYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 03:24:03 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92659C061788
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 00:24:01 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id s21so3661116pjq.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 00:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KJK8dZgEf3LiQZYSvERG5S+Cf6jpruVmV7G871UJxKw=;
        b=kZLfyEe5T8/wnO8BEbhuFtnTsyTc/C8sYJVZwBAi1A/HGl92g87YQ1C9Su4O0ruBCG
         rinlZfXPhRugDJzWwjQr068t3E0i3vSoExW770aLNZDAUFFByf/nVM3VkcW2lYmZJhUh
         K6o/R2OvbNqIVAnf5wnIEgo6OWNG6FJNnzjoHhE6AYXV8EXBzNpYrMN9A0gLGyvmUuOl
         12QgolaRdDnxtr2T2SXnXJe9z7p0v2NFE8X7iJQ7yfnKFv4r7NPFtCepHmkpidsFhTii
         d4dp6Fj4IvtfsC3fdAfRn+9NwaKZNp48YIo8uD/DcPlWvtfP+E3PWF2nUmt/SQ0+NP4r
         9SxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KJK8dZgEf3LiQZYSvERG5S+Cf6jpruVmV7G871UJxKw=;
        b=RgSmtN4CL/9mE66dzRIcCA/9uTpdPlQckZpxoSfJ6mJs1vG7aWQk6TmJ2CengjTSHD
         p4Hk3G/paVlu5fPQnxAnMn6I/WHSNoH51B/Gfr7oSgaBdgpN/ayUkiFFAIkzX03+JyJF
         8MkliGFkVr6PKC8DV2UVZH5COkoGaXGhIUQCS2JIy5KiyCcG7yqyOMulFw81OHi30fHU
         xA5T2iXJf1/Fv6gZDZvHGa/cXb2htA6qtdpSsBnSY5n7hKPw+enhhAgQ5+bFNZMdnIdH
         iDgENcQrWAh0ndKMWeldEeoLWSIxCVcgvdHVnNEuZ4cK0VZk/fLE2vwbxY9Fpdkpbs/X
         fCHA==
X-Gm-Message-State: AOAM533OhGm8dnFbTCHQ5gP4JSktLP7eOYb9yT5mFqWaBoTTnZ8XTEgg
        s1IcbIo7hRCrWIBg8melEg7vQQ==
X-Google-Smtp-Source: ABdhPJxYJx6Wa94k81HS7tqgo1m6KoH0q4eesEXFtdU6WZbMujxG6jDxFlKdkYfyee3d0Z9yXBc48Q==
X-Received: by 2002:a17:90a:5d09:: with SMTP id s9mr17009472pji.228.1617434641111;
        Sat, 03 Apr 2021 00:24:01 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id w203sm9704435pfc.188.2021.04.03.00.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 00:24:00 -0700 (PDT)
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
Subject: [PATCH v2 2/7] perf arm-spe: Store TSC parameters in auxtrace info
Date:   Sat,  3 Apr 2021 15:23:41 +0800
Message-Id: <20210403072346.30430-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210403072346.30430-1-leo.yan@linaro.org>
References: <20210403072346.30430-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TSC parameters are used for conversion between arch timer counter
and kernel timestamp, this patch stores the parameters into the struct
perf_record_auxtrace_info, and it is saved in perf data file.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c | 23 +++++++++++++++++++++++
 tools/perf/util/arm-spe.h            |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 414c8a5584b1..dd940cf16f49 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -15,7 +15,9 @@
 #include "../../../util/event.h"
 #include "../../../util/evsel.h"
 #include "../../../util/evlist.h"
+#include "../../../util/mmap.h"
 #include "../../../util/session.h"
+#include "../../../util/tsc.h"
 #include <internal/lib.h> // page_size
 #include "../../../util/pmu.h"
 #include "../../../util/debug.h"
@@ -47,6 +49,9 @@ static int arm_spe_info_fill(struct auxtrace_record *itr,
 	struct arm_spe_recording *sper =
 			container_of(itr, struct arm_spe_recording, itr);
 	struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
+	struct perf_event_mmap_page *pc;
+	struct perf_tsc_conversion tc = { .time_mult = 0, };
+	int err;
 
 	if (priv_size != ARM_SPE_AUXTRACE_PRIV_SIZE)
 		return -EINVAL;
@@ -54,8 +59,26 @@ static int arm_spe_info_fill(struct auxtrace_record *itr,
 	if (!session->evlist->core.nr_mmaps)
 		return -EINVAL;
 
+	pc = session->evlist->mmap[0].core.base;
+	if (pc) {
+		err = perf_read_tsc_conversion(pc, &tc);
+		if (err) {
+			if (err != -EOPNOTSUPP)
+				return err;
+		}
+
+		if (!tc.time_mult)
+			ui__warning("Arm SPE: arch timer not available\n");
+	}
+
 	auxtrace_info->type = PERF_AUXTRACE_ARM_SPE;
 	auxtrace_info->priv[ARM_SPE_PMU_TYPE] = arm_spe_pmu->type;
+	auxtrace_info->priv[ARM_SPE_TIME_SHIFT] = tc.time_shift;
+	auxtrace_info->priv[ARM_SPE_TIME_MULT] = tc.time_mult;
+	auxtrace_info->priv[ARM_SPE_TIME_ZERO] = tc.time_zero;
+	auxtrace_info->priv[ARM_SPE_TIME_CYCLES] = tc.time_cycles;
+	auxtrace_info->priv[ARM_SPE_TIME_MASK] = tc.time_mask;
+	auxtrace_info->priv[ARM_SPE_CAP_USER_TIME_SHORT] = tc.cap_user_time_short;
 
 	return 0;
 }
diff --git a/tools/perf/util/arm-spe.h b/tools/perf/util/arm-spe.h
index 105ce0ea0a01..5bf3e838d226 100644
--- a/tools/perf/util/arm-spe.h
+++ b/tools/perf/util/arm-spe.h
@@ -11,6 +11,12 @@
 
 enum {
 	ARM_SPE_PMU_TYPE,
+	ARM_SPE_TIME_SHIFT,
+	ARM_SPE_TIME_MULT,
+	ARM_SPE_TIME_ZERO,
+	ARM_SPE_TIME_CYCLES,
+	ARM_SPE_TIME_MASK,
+	ARM_SPE_CAP_USER_TIME_SHORT,
 	ARM_SPE_AUXTRACE_PRIV_MAX,
 };
 
-- 
2.25.1

