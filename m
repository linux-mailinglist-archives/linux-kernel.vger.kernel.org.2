Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3853885E6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 06:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353272AbhESER3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 00:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239977AbhESERY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 00:17:24 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A6CC0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 21:16:04 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id i6so1448110plt.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 21:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mnv8F8uuj2iGeObVVsabQBsjZH5xCx4JzTz8peGn5X8=;
        b=Y+RMOePPmr4kW5SydrzVYc81VRZiT9Pdaw7+lMi1c/3VQAJnwsVKJZ+Owg4oqkoImN
         VQ/xQHlYqld5wGmU3OvkCbAK6+LLB12H9EfoDb8qfgMLqCfFItZMQjUX1NhPRHHb0zg4
         u3ALxImkgMy4kfxfidk4xgaKDK/53HBYifOz5BQMJZL75y1MJ+cFXmGu+VgTSMkvT274
         64uQuhmXUWh9sb5p7LndkI/DAoEuUOfLL2At1xAMn88XQ/8H+jssdSXFofc3ef1vzkdb
         /tmX5nIfzFoAcKgfrMlZz2GElZHwA6QkrsYvzmUwL19070gJ+1AYJ+pfQbYkzz8Ped4B
         98ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mnv8F8uuj2iGeObVVsabQBsjZH5xCx4JzTz8peGn5X8=;
        b=a550Df+fUlCb7cZUq6ST2fgHP2lX8uzhvag1bxmDj30X2WPPHM0TlMg37L51lr0f2O
         BpirW+XUZLfMtP9wK7/3rlc52LrY491GAAOwAaFJUFrZ5uOx5P8pNFAuU/AAG/FM2UJ7
         e0yn56u/HTAMQiSCQCMEJrNqw1L8nFhyiq2vSN0cxfBXZgEXnixYC0sPf1daz7syOkNJ
         7waDbr9n3Xk8y8cYDZKrS/KZCoV3OsZUH+117YXnt47PbbPaW0vsZsA4h0+9qiOmiPPO
         p7u2V6JFMCzLibIhE+zPJpxCiooxjs4StmXwzxQySbbvwl8gkDl6TKdmeyjbPKYRSarp
         irUQ==
X-Gm-Message-State: AOAM5305wTGhaLp8SnDd4YkciEw9tzl4tMKSvbSHb6c9pLOb3TLc9IOI
        lDdRvvySBKjSLs5bMOe8YIaalA==
X-Google-Smtp-Source: ABdhPJxqPnecAC2BAEyYAoyFzR9V9h/+elZ/KCxFqPwDX2Iiya4EEcsqoiloKy2Ce3eTob3HDqmniQ==
X-Received: by 2002:a17:902:a58b:b029:ee:d13a:2642 with SMTP id az11-20020a170902a58bb02900eed13a2642mr8544241plb.35.1621397764039;
        Tue, 18 May 2021 21:16:04 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id n23sm811091pff.93.2021.05.18.21.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 21:16:03 -0700 (PDT)
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
Subject: [PATCH v2 3/4] perf arm-spe: Enable timestamp for per-cpu mode
Date:   Wed, 19 May 2021 12:15:45 +0800
Message-Id: <20210519041546.1574961-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210519041546.1574961-1-leo.yan@linaro.org>
References: <20210519041546.1574961-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For per-cpu mmap, it should enable timestamp tracing for Arm SPE; this
is helpful for samples correlation.

To automatically enable the timestamp, a helper arm_spe_set_timestamp()
is introduced for setting "ts_enable" format bit.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
Tested-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm64/util/arm-spe.c | 33 ++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 4c916626c203..bacdf366040d 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -14,6 +14,7 @@
 #include "../../../util/cpumap.h"
 #include "../../../util/event.h"
 #include "../../../util/evsel.h"
+#include "../../../util/evsel_config.h"
 #include "../../../util/evlist.h"
 #include "../../../util/session.h"
 #include <internal/lib.h> // page_size
@@ -32,6 +33,29 @@ struct arm_spe_recording {
 	struct evlist		*evlist;
 };
 
+static void arm_spe_set_timestamp(struct auxtrace_record *itr,
+				  struct evsel *evsel)
+{
+	struct arm_spe_recording *ptr;
+	struct perf_pmu *arm_spe_pmu;
+	struct evsel_config_term *term = evsel__get_config_term(evsel, CFG_CHG);
+	u64 user_bits = 0, bit;
+
+	ptr = container_of(itr, struct arm_spe_recording, itr);
+	arm_spe_pmu = ptr->arm_spe_pmu;
+
+	if (term)
+		user_bits = term->val.cfg_chg;
+
+	bit = perf_pmu__format_bits(&arm_spe_pmu->format, "ts_enable");
+
+	/* Skip if user has set it */
+	if (bit & user_bits)
+		return;
+
+	evsel->core.attr.config |= bit;
+}
+
 static size_t
 arm_spe_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 		       struct evlist *evlist __maybe_unused)
@@ -121,9 +145,14 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	 */
 	evlist__to_front(evlist, arm_spe_evsel);
 
-	/* In the case of per-cpu mmaps, sample CPU for AUX event. */
-	if (!perf_cpu_map__empty(cpus))
+	/*
+	 * In the case of per-cpu mmaps, sample CPU for AUX event;
+	 * also enable the timestamp tracing for samples correlation.
+	 */
+	if (!perf_cpu_map__empty(cpus)) {
 		evsel__set_sample_bit(arm_spe_evsel, CPU);
+		arm_spe_set_timestamp(itr, arm_spe_evsel);
+	}
 
 	/* Add dummy event to keep tracking */
 	err = parse_events(evlist, "dummy:u", NULL);
-- 
2.25.1

