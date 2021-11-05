Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1A0446A37
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 21:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhKEVBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 17:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhKEVB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 17:01:29 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7FAC061570
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 13:58:49 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id e65so9315570pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 13:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+j1ZQ9YT0ivpxVxUs9Ife+qn1HzNFmx84nxQJj9eH5o=;
        b=ozHzcOHoCY0EJG5mO2vIStL+KJTB9XsYJR43xdROgi0VxYB4o/D1pK84xpfAPb+GaX
         Nod7tL8FbPGGRNA+2PzVaZEa0uJIRhlfR2j2oDLeDhigTePQtIvUaUXG6Y3gAtonvgQ2
         e06ocvoq+lOFcB2zvWKy53p99cCvuGRG/A9CngGjvFKaQUyXcuwuGjNDXf2/8+ja8R05
         URfDxFmxAmvjWE4FoNCH6gr9yEQgRN5vGWEibbriTpk/gX93LtzxC99QL56D5CtQxYGJ
         tVODSgDw0ZR67E4xDQFkMcm9ETJyZKSK0xdZfPiEojx84HfhiotOaF2ZuUcVxv2jGhhN
         qu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=+j1ZQ9YT0ivpxVxUs9Ife+qn1HzNFmx84nxQJj9eH5o=;
        b=xwH+SDm/hySnjEAltoQdZPfBLAL5SJYKeFK2hO3NNf7Ed4UxNQ0aaW3BAIP4xMzwNH
         ezP4kgrHgpyQuncnY/sqmsSYCTTLB+2wGYPl40InXGvU+dufip+r/+/WJNLGjjrwqybM
         c42P/n+oxmGuRFsvo5gf9azsxPiMe30Aw2XRfi042FE1VsubT8E2iOC5BT+FTXEWVGIH
         4Ych034UQ6ZTWlGhLI/KjE+o2+bvpnelWRr//Iaj6gNcwdkbXAHH5uAFh4/AzJKadv7Y
         UTAJGl5qIHbkUpIulq93WOh5iIInBpBcZNrWHhQTis5rH/Y9Fu/zSOPL/3pe/8EaSYiH
         Px1A==
X-Gm-Message-State: AOAM5307fY/l2LCyN1kV/P/zfBemPEoS/4d6KpIBJJ9faDHfjtY+XlKq
        ZOY1pjzQ1SR46V2Go+7jwZm+k86nq2g=
X-Google-Smtp-Source: ABdhPJzvOWRCTqeT4/w8GaZRBe93i1b/8MSiTl7qzmKWXgbNi0b1o30BLagYlZXgaT3yaWwX9ZUSmw==
X-Received: by 2002:a63:f54c:: with SMTP id e12mr15665161pgk.464.1636145929146;
        Fri, 05 Nov 2021 13:58:49 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:5800:b275:19b3:fe7e:8efa])
        by smtp.gmail.com with ESMTPSA id c21sm8254428pfv.119.2021.11.05.13.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:58:48 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH v4] perf evsel: Fix missing exclude_{host,guest} setting
Date:   Fri,  5 Nov 2021 13:58:47 -0700
Message-Id: <20211105205847.120950-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current logic for the perf missing feature has a bug that it can
wrongly clear some modifiers like G or H.  Actually some PMUs don't
support any filtering or exclusion while others do.  But we check it
as a global feature.

For example, the cycles event can have 'G' modifier to enable it only
in the guest mode on x86.  When you don't run any VMs it'll return 0.

  # perf stat -a -e cycles:G sleep 1

    Performance counter stats for 'system wide':

                    0      cycles:G

          1.000721670 seconds time elapsed

But when it's used with other pmu events that don't support G modifier,
it'll be reset and return non-zero values.

  # perf stat -a -e cycles:G,msr/tsc/ sleep 1

    Performance counter stats for 'system wide':

          538,029,960      cycles:G
       16,924,010,738      msr/tsc/

          1.001815327 seconds time elapsed

This is because of the missing feature detection logic being global.
Add a hashmap to set pmu-specific exclude_host/guest features.

Reported-by: Stephane Eranian <eranian@google.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v4 changes)
 * add pmu->missing_features.exclude_guest
 * bail out if evsel->exclude_GH is set

v3 changes)
 * check memory allocation failure
 * add more NULL check

v2 changes)
 * change to enum perf_missing_pmu_features
 * pass NULL to hashmap__find() to skip checking
 * add a blank line after declaration

 tools/perf/util/evsel.c | 27 ++++++++++++++++++++++-----
 tools/perf/util/evsel.h |  4 ++++
 tools/perf/util/pmu.h   |  4 ++++
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2cfc2935d1d2..3cc1f8fcf15c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1824,7 +1824,7 @@ static void evsel__disable_missing_features(struct evsel *evsel)
 		evsel->open_flags &= ~(unsigned long)PERF_FLAG_FD_CLOEXEC;
 	if (perf_missing_features.mmap2)
 		evsel->core.attr.mmap2 = 0;
-	if (perf_missing_features.exclude_guest)
+	if (evsel->pmu && evsel->pmu->missing_features.exclude_guest)
 		evsel->core.attr.exclude_guest = evsel->core.attr.exclude_host = 0;
 	if (perf_missing_features.lbr_flags)
 		evsel->core.attr.branch_sample_type &= ~(PERF_SAMPLE_BRANCH_NO_FLAGS |
@@ -1917,10 +1917,27 @@ bool evsel__detect_missing_features(struct evsel *evsel)
 		perf_missing_features.mmap2 = true;
 		pr_debug2_peo("switching off mmap2\n");
 		return true;
-	} else if (!perf_missing_features.exclude_guest &&
-		   (evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host)) {
-		perf_missing_features.exclude_guest = true;
-		pr_debug2_peo("switching off exclude_guest, exclude_host\n");
+	} else if ((evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host) &&
+		   (evsel->pmu == NULL || evsel->pmu->missing_features.exclude_guest)) {
+		if (evsel->pmu == NULL) {
+			evsel->pmu = evsel__find_pmu(evsel);
+			if (evsel->pmu)
+				evsel->pmu->missing_features.exclude_guest = true;
+			else {
+				/* we cannot find PMU, disable attrs now */
+				evsel->core.attr.exclude_host = false;
+				evsel->core.attr.exclude_guest = false;
+			}
+		}
+
+		if (evsel->exclude_GH) {
+			pr_debug2_peo("PMU has no exclude_host/guest support, bailing out\n");
+			return false;
+		}
+		if (!perf_missing_features.exclude_guest) {
+			perf_missing_features.exclude_guest = true;
+			pr_debug2_peo("switching off exclude_guest, exclude_host\n");
+		}
 		return true;
 	} else if (!perf_missing_features.sample_id_all) {
 		perf_missing_features.sample_id_all = true;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 846c827934de..dcc87c2881b8 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -22,6 +22,7 @@ struct target;
 struct hashmap;
 struct bperf_leader_bpf;
 struct bperf_follower_bpf;
+struct perf_pmu;
 
 typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
 
@@ -153,6 +154,9 @@ struct evsel {
 	};
 	unsigned long		open_flags;
 	int			precise_ip_original;
+
+	/* for missing_features */
+	struct perf_pmu		*pmu;
 };
 
 struct perf_missing_features {
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 15bbec3a9959..541889fa9f9c 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -49,6 +49,10 @@ struct perf_pmu {
 	struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
 	struct list_head list;    /* ELEM */
 	struct list_head hybrid_list;
+
+	struct {
+		bool exclude_guest;
+	} missing_features;
 };
 
 extern struct perf_pmu perf_pmu__fake;
-- 
2.34.0.rc0.344.g81b53c2807-goog

