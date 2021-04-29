Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4ACD36ECE7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 17:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240602AbhD2PCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 11:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240376AbhD2PCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 11:02:03 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8584C06138E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:01:16 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id y30so2169531pgl.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kKALg3mdCIPQXLNAB5VYdkufEFOWrU4WkUMpgl9QzUE=;
        b=Iz9sOTAaVV/ExNsgTbz8EJRpo7emfPqpNUJOUagetQg1r5WM58iT155wkgu3nZLaXU
         /on+JnGNm6L0urdVJY30uVWupmNFeOXJ1tGMsEayPSQkDUe7V6QpOJdrB14AomSEZc6Q
         p9Mus2luS1g2ZJOpFA+Qtuw1LJAgoODKQi5BlABbmAWRSE1FxHOm44VdnFRvC7tIPY2e
         if3WtfID6mzd6309I/ShyyJAYSwIK6w2u3Rgpa494ulJOci78eQU27cpm7H8lRBq3fkM
         ckhJh095HbhLJZGnlHxBsn1evO+IV5CzfO0q5+YpFJ+2sIFu1ieeGwx92JRQC0ipTUtR
         2fDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kKALg3mdCIPQXLNAB5VYdkufEFOWrU4WkUMpgl9QzUE=;
        b=Y53oUGVzdT1+fcoHh2K5ZBvXEi/VOFe01TKg6azZ4YFjueWjWOu2CSzBxZCn3o8XiX
         tIgo7DZpbRGewW/V/rbSBXYD5Ug8R5NaabxhVZHzGmxCIpAo3a2cZy1L3V0TRRGOB0+x
         MG7ShYQu0jD9/+qp6sJuWJyQt+HjlR8ESg+70aPbS404PWFS+LDbILy1+oTkrdPiXWsZ
         doAznOjYxZDUbagR0S2IeyXVKJKxLutz5RicOfccQbckq0HnLCyIZKow9hP4C3jzB/dU
         Q8xKBlmr3SwabJDRCTckZ2jSMLp+nm1BtOnSdTEvovRlVmul7kDVPLuz7PTf5uB63II4
         bm2A==
X-Gm-Message-State: AOAM532rTnJUr00kmbijEPygw91x9jh+1FJ1cDlPqmHaCFnFZFBMmgkm
        r8PrbRveSssbMMDaziZ0bhjMOg==
X-Google-Smtp-Source: ABdhPJwul8+2yIAI7+lC44DnHk4W6dca44WS0deVPwTk2JwaNCFtRQMzn1H07FIdZa/rX1sk6E9DsA==
X-Received: by 2002:aa7:84d0:0:b029:27d:fff:40c9 with SMTP id x16-20020aa784d00000b029027d0fff40c9mr110903pfn.7.1619708476222;
        Thu, 29 Apr 2021 08:01:16 -0700 (PDT)
Received: from localhost ([204.124.180.30])
        by smtp.gmail.com with ESMTPSA id q5sm2747191pfu.5.2021.04.29.08.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 08:01:15 -0700 (PDT)
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
Subject: [PATCH v1 2/3] perf arm-spe: Correct sample flags for dummy event
Date:   Thu, 29 Apr 2021 23:00:59 +0800
Message-Id: <20210429150100.282180-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210429150100.282180-1-leo.yan@linaro.org>
References: <20210429150100.282180-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dummy event is mainly used for mmap, the TIME sample is only needed
for per-cpu case so that the perf tool can rely on the correct timing
for parsing symbols.  And the CPU sample is useless for mmap.

This patch enables TIME sample for per-cpu mmap and doesn't enable CPU
sample.  For later extension (e.g. support multiple AUX events), it sets
the dummy event when the condition "opts->full_auxtrace" is true.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c | 30 ++++++++++++++++------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 902e73a64184..f6eec0900604 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -70,7 +70,6 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	struct evsel *evsel, *arm_spe_evsel = NULL;
 	struct perf_cpu_map *cpus = evlist->core.cpus;
 	bool privileged = perf_event_paranoid_check(-1);
-	struct evsel *tracking_evsel;
 	int err;
 
 	sper->evlist = evlist;
@@ -126,18 +125,23 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 		evsel__set_sample_bit(arm_spe_evsel, CPU);
 
 	/* Add dummy event to keep tracking */
-	err = parse_events(evlist, "dummy:u", NULL);
-	if (err)
-		return err;
-
-	tracking_evsel = evlist__last(evlist);
-	evlist__set_tracking_event(evlist, tracking_evsel);
-
-	tracking_evsel->core.attr.freq = 0;
-	tracking_evsel->core.attr.sample_period = 1;
-	evsel__set_sample_bit(tracking_evsel, TIME);
-	evsel__set_sample_bit(tracking_evsel, CPU);
-	evsel__reset_sample_bit(tracking_evsel, BRANCH_STACK);
+	if (opts->full_auxtrace) {
+		struct evsel *tracking_evsel;
+
+		err = parse_events(evlist, "dummy:u", NULL);
+		if (err)
+			return err;
+
+		tracking_evsel = evlist__last(evlist);
+		evlist__set_tracking_event(evlist, tracking_evsel);
+
+		tracking_evsel->core.attr.freq = 0;
+		tracking_evsel->core.attr.sample_period = 1;
+
+		/* In per-cpu case, always need the time of mmap events etc */
+		if (!perf_cpu_map__empty(cpus))
+			evsel__set_sample_bit(tracking_evsel, TIME);
+	}
 
 	return 0;
 }
-- 
2.25.1

