Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD39368B24
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 04:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240154AbhDWCjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 22:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhDWCjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 22:39:13 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40CDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 19:38:36 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 8so14689317qkv.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 19:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9GAjZOolHh/KVUtI+o1rheP1qwQJor7AwObCvclVnbM=;
        b=amxJ0TBF2/Wz/QgIEHvNK5O84kDeUuFzDEV7sllIV3GvO+VqQnR/DPEl+5zpgQ/Awo
         8fDollIl5iqvpsPmRoOnXJVF88A8Cf808dICie76dJ93ORQWz/I+Ig2+BURNmKtiojtQ
         mILI1qVFPWa8IEKNayjTiz0GyqjSRq6S+RXYwcpFzVzlJxt3tEMNzRPhMpwM6EbJwAe+
         bZp8g9RgeytHfpS0Wo5jaBFkqSgG7i04EuDrQJ2oghnKHkak18W1c7EkeHUc7DmaoXZl
         IGJo22tYCOI0ypGMLf+vtZdttNx2uGF8Blt+RiWD7jlUDD5Ds03JaEM8utYKw7eMiqV/
         8qUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=9GAjZOolHh/KVUtI+o1rheP1qwQJor7AwObCvclVnbM=;
        b=JINjqCSlL+/qGp0iMhXhX+RU6E/kr17y+rL97rbPC9J3w+OzDmWqN+mdspZtIGH0TJ
         9zaYW5P7nL3OYcHAOnpvMTzogd72sG6KcmBGyr9boyh6r/fYvRztx4G+gn6SeP5aukRm
         NTM1VJUDixAeHQcs3KWQdR4+fDXxPbxvjEopK7/+sLMWaXrfvNix9EAE2te24enC4wxo
         03bpj6PFLF0BNbi7TqKUX0P43JKLbjc8GneF5OrHEd2Ek0pJhofMS0atGKCdF3OiSDni
         P/+aoavvaD1DxgC189cmh79HMA+/9AsIIIKj6MKd0m7Fg3InePkpxpWJdTAnJJPQdX1/
         gAmQ==
X-Gm-Message-State: AOAM532MJyobTpIOSUSAt8UJq8vPQOD7tir53D2By9+bXTI4RGsSkY7C
        wtyk0IEL1mGcsy+1snqM8kQ=
X-Google-Smtp-Source: ABdhPJyhRElbEE6e4z75wyS6uEs4sZLKFe1RnhInAZXs1vg6ZQJ6jxamqNuS1DFPYFytoSjWs2jM2A==
X-Received: by 2002:a05:620a:12ac:: with SMTP id x12mr1920501qki.196.1619145516259;
        Thu, 22 Apr 2021 19:38:36 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([50.238.223.130])
        by smtp.gmail.com with ESMTPSA id n14sm3483356qke.123.2021.04.22.19.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 19:38:35 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf stat: Use aggregated counts directly
Date:   Thu, 22 Apr 2021 19:38:33 -0700
Message-Id: <20210423023833.1430520-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ps->res_stats is for repeated runs, so the interval code should
not touch it.  Actually the aggregated counts are available in the
counter->counts->aggr, so we can (and should) use it directly IMHO.

No functional change intended.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c |  8 ++++----
 tools/perf/util/stat.c         | 12 ------------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index d3137bc17065..a38fa6527586 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -807,11 +807,11 @@ static void counter_aggr_cb(struct perf_stat_config *config __maybe_unused,
 			    bool first __maybe_unused)
 {
 	struct caggr_data *cd = data;
-	struct perf_stat_evsel *ps = counter->stats;
+	struct perf_counts_values *aggr = &counter->counts->aggr;
 
-	cd->avg += avg_stats(&ps->res_stats[0]);
-	cd->avg_enabled += avg_stats(&ps->res_stats[1]);
-	cd->avg_running += avg_stats(&ps->res_stats[2]);
+	cd->avg += aggr->val;
+	cd->avg_enabled += aggr->ena;
+	cd->avg_running += aggr->run;
 }
 
 /*
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 2db46b9bebd0..d3ec2624e036 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -437,18 +437,6 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 
 	aggr->val = aggr->ena = aggr->run = 0;
 
-	/*
-	 * We calculate counter's data every interval,
-	 * and the display code shows ps->res_stats
-	 * avg value. We need to zero the stats for
-	 * interval mode, otherwise overall avg running
-	 * averages will be shown for each interval.
-	 */
-	if (config->interval || config->summary) {
-		for (i = 0; i < 3; i++)
-			init_stats(&ps->res_stats[i]);
-	}
-
 	if (counter->per_pkg)
 		evsel__zero_per_pkg(counter);
 
-- 
2.31.1.498.g6c1eba8ee3d-goog

