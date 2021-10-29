Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5314F440596
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 00:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhJ2WwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 18:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbhJ2WwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 18:52:01 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3014EC061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 15:49:32 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q187so11222679pgq.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 15:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3HqKf372STdD2Z32MasgtKv8i3ViS4hTN8j0ScAXe9o=;
        b=E9IcizofXOsYRBDVFk0sx4cex5fb91Dwxzf2xlbwZGiiLwXBsq1iHdKyA0HfcyftS4
         d7NY6pyOUAvJSFipnS5fzG0rU2sItnIQXhKqO7OfY6xhwlyH/FYnxXHg8QU2S8CBDrYd
         /TTzTd/5LCZlgLb8LTJwlKHXX5mq15q2Sso4sXc0vmhVy4XI2Cow5OfngH9lO/dHm8uc
         Ca+wxB4mAqnDGOJn0daH6/qV7bGTD3O+bXlrawEpuf5KxQ/fXsbtNmTLtLrP1jd8JhSr
         YGc4aVeynHDdfsqox08lZ6BX4DJCV1zJB1J1MbLDWwbFogep8lkIZ32y+QzoMoG241Y8
         ysnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=3HqKf372STdD2Z32MasgtKv8i3ViS4hTN8j0ScAXe9o=;
        b=QCpoal6s8nCglSRmB19rHeoc2VcB1iNGuDaHZvzL+Yd8phfDz+3hHziSuS29Q3UKBm
         23rOa3UgN8CwTx2yqYBnOl83Y1SF4wfIWsMko/aLlEHHHURvTCIOghzi5k0Fmgt3zG/J
         BME+lUE9hAiAF5zgflsyGO7qyzTYV0SKOmUHQEXcBGs8RCsVx2IEHKJzOausRr4HwDH5
         /e5SABkURQoJw8A67cimgNlBwhVXEftSigdI9z+GajaFOjSrpjRaIb2R7Vrq8xcvF4JY
         nJi8gOF96V7pc+pZBdMfaITOHKgOvulD/pk/HMspS0P35LpU083TirIeAErvecQiTYrJ
         PA9g==
X-Gm-Message-State: AOAM5307qZBtuVC7wXMDJDF9vc2XIPYSmKESZcyRE1zJ7RCKsWw34nC5
        P+sv8vMYcc6adD4op7liyzg=
X-Google-Smtp-Source: ABdhPJycfawfYNgBPqrKv+xWh1kNfNafq28aEgpOSgU5iX8WyA9MA30P99Q0eiQGeDB+3FGU+VU8QA==
X-Received: by 2002:a05:6a00:2293:b0:480:704:2df1 with SMTP id f19-20020a056a00229300b0048007042df1mr1542363pfe.85.1635547771668;
        Fri, 29 Oct 2021 15:49:31 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:5800:5bfb:ee65:cd57:4ab6])
        by smtp.gmail.com with ESMTPSA id e14sm8172097pfv.192.2021.10.29.15.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 15:49:31 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH v3] perf evsel: Fix missing exclude_{host,guest} setting
Date:   Fri, 29 Oct 2021 15:49:29 -0700
Message-Id: <20211029224929.379505-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
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
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v3 changes)
 * check memory allocation failure
 * add more NULL check

v2 changes)
 * change to enum perf_missing_pmu_features
 * pass NULL to hashmap__find() to skip checking
 * add a blank line after declaration

 tools/perf/util/evsel.c | 54 ++++++++++++++++++++++++++++++++++++-----
 tools/perf/util/evsel.h |  7 ++++++
 2 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbfeceb2546c..d3ff4809627b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1434,6 +1434,10 @@ void evsel__delete(struct evsel *evsel)
 {
 	evsel__exit(evsel);
 	free(evsel);
+
+	/* just free it for the first evsel */
+	hashmap__free(perf_missing_features.pmu);
+	perf_missing_features.pmu = NULL;
 }
 
 void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
@@ -1791,6 +1795,23 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	return 0;
 }
 
+#define PMU_HASH_BITS  4
+
+static size_t pmu_hash(const void *key, void *ctx __maybe_unused)
+{
+	const struct evsel *evsel = key;
+
+	return hash_bits(evsel->core.attr.type, PMU_HASH_BITS);
+}
+
+static bool pmu_equal(const void *key1, const void *key2, void *ctx __maybe_unused)
+{
+	const struct evsel *a = key1;
+	const struct evsel *b = key2;
+
+	return a->core.attr.type == b->core.attr.type;
+}
+
 static void evsel__disable_missing_features(struct evsel *evsel)
 {
 	if (perf_missing_features.weight_struct) {
@@ -1807,8 +1828,14 @@ static void evsel__disable_missing_features(struct evsel *evsel)
 		evsel->open_flags &= ~(unsigned long)PERF_FLAG_FD_CLOEXEC;
 	if (perf_missing_features.mmap2)
 		evsel->core.attr.mmap2 = 0;
-	if (perf_missing_features.exclude_guest)
-		evsel->core.attr.exclude_guest = evsel->core.attr.exclude_host = 0;
+	if (perf_missing_features.exclude_guest) {
+		/* we only have EXCLUDE_GUEST bit, let's skip checking  */
+		if (perf_missing_features.pmu != NULL &&
+		    hashmap__find(perf_missing_features.pmu, evsel, NULL)) {
+			evsel->core.attr.exclude_guest = 0;
+			evsel->core.attr.exclude_host = 0;
+		}
+	}
 	if (perf_missing_features.lbr_flags)
 		evsel->core.attr.branch_sample_type &= ~(PERF_SAMPLE_BRANCH_NO_FLAGS |
 				     PERF_SAMPLE_BRANCH_NO_CYCLES);
@@ -1840,6 +1867,14 @@ int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 bool evsel__detect_missing_features(struct evsel *evsel)
 {
+	if (perf_missing_features.pmu == NULL) {
+		perf_missing_features.pmu = hashmap__new(pmu_hash, pmu_equal, NULL);
+		if (IS_ERR(perf_missing_features.pmu)) {
+			pr_err("Memory allocation failure!\n");
+			perf_missing_features.pmu = NULL;
+		}
+	}
+
 	/*
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
@@ -1900,10 +1935,17 @@ bool evsel__detect_missing_features(struct evsel *evsel)
 		perf_missing_features.mmap2 = true;
 		pr_debug2_peo("switching off mmap2\n");
 		return true;
-	} else if (!perf_missing_features.exclude_guest &&
-		   (evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host)) {
-		perf_missing_features.exclude_guest = true;
-		pr_debug2_peo("switching off exclude_guest, exclude_host\n");
+	} else if ((evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host) &&
+		   perf_missing_features.pmu != NULL &&
+		   !hashmap__find(perf_missing_features.pmu, evsel, NULL)) {
+		uintptr_t pmu_features = PERF_MISSING_PMU_EXCLUDE_GUEST;
+
+		hashmap__add(perf_missing_features.pmu, evsel, (void *)pmu_features);
+
+		if (!perf_missing_features.exclude_guest) {
+			perf_missing_features.exclude_guest = true;
+			pr_debug2_peo("switching off exclude_guest, exclude_host\n");
+		}
 		return true;
 	} else if (!perf_missing_features.sample_id_all) {
 		perf_missing_features.sample_id_all = true;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 1f7edfa8568a..11b5ece19f0e 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -172,6 +172,13 @@ struct perf_missing_features {
 	bool data_page_size;
 	bool code_page_size;
 	bool weight_struct;
+
+	/* contains enum perf_missing_pmu_features below */
+	struct hashmap *pmu;
+};
+
+enum perf_missing_pmu_features {
+	PERF_MISSING_PMU_EXCLUDE_GUEST		= 1UL << 0,
 };
 
 extern struct perf_missing_features perf_missing_features;
-- 
2.33.1.1089.g2158813163f-goog

