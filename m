Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF34443AB54
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 06:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhJZEgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 00:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhJZEgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 00:36:20 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5551CC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 21:33:57 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t11so9403138plq.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 21:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p+zYleLEvb8DmURbxxXerEhfZwwXU962QhwpppWK9i0=;
        b=hgnuSGRGQjYcsFR0nmEAPS3A1rqqLUJvhmyqI6IZAklu4Z6WoxixaNlmHb7EgakML1
         0sVBpzqTxM1ucLy8sC47FGB0lEH+jZ4OZsJDqx1DEXBueu0IW6ClaRluXlivXQp1YhJD
         evY2YJbBTBgpY/EJZxNF+7Ussugn8sxQipouC1ef+OyRt6/edh6qF/en9f3ATmU/RArl
         Fs249fTcf3bse210oWqErcZsizEkW+zW9Pe8N3ZMyCfkOogUA+qAobD6J5FaKFIp1qPM
         fKWGJ3u1fl7QrdxwmrNornnwxTIIcalrBc2YLJKNOYQ1iEbaRMW4tBA/lqQZEcM2bPG6
         C8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=p+zYleLEvb8DmURbxxXerEhfZwwXU962QhwpppWK9i0=;
        b=RVOovQmwsy3LvL2WP8u+ffSbckli7Mg04etUWJu0ogoA73O/Mx2jec6H9+sQyR5ul8
         nsqTBXMeA9y0FcdAK3yBCX7zvH+or/GM9bERgpdfn+v+X0bl7bGCOziazxQfjh0jeuM2
         mhAfWciqVknLuPcBvneTrHrgByQF7fVhlajjkzhqFcqNcssdzBbRLNtvk10mM+DZi7JT
         ocZ8BUqjt+hCSTI88VUUU1YsD2fjJHzjp6asti9W36ojVEmd2X0RJQOXhDPzClV8w41h
         s+/AR9aGBSA3ky41qnSb2gcKuzoybHLm2Cz7xJ5JJkpUVk+bI1pPWom8u8QvMxGbQwFa
         t77g==
X-Gm-Message-State: AOAM532w58I+Y/Tv7r9Zxa5qNMrwyOqE7hjzuhUjU7b/O2J3doYuOjez
        OWU4aOxqpGqp3nzkmbnAw+w=
X-Google-Smtp-Source: ABdhPJz63K9cRyJPRiaLYTFx65T9zOdylIxNx1fq+iIMAKz0SuEiP8AzCKJfMQ2kO60A4DT2fLAIdg==
X-Received: by 2002:a17:90b:1112:: with SMTP id gi18mr25316811pjb.136.1635222834744;
        Mon, 25 Oct 2021 21:33:54 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:5800:869d:250a:b25d:f5da])
        by smtp.gmail.com with ESMTPSA id x190sm4190246pfc.212.2021.10.25.21.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 21:33:54 -0700 (PDT)
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
Subject: [PATCH v2] perf evsel: Fix missing exclude_{host,guest} setting
Date:   Mon, 25 Oct 2021 21:33:51 -0700
Message-Id: <20211026043351.56662-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
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
v2 changes)
 * change to enum perf_missing_pmu_features
 * pass NULL to hashmap__find() to skip checking
 * add a blank line after declaration

 tools/perf/util/evsel.c | 47 +++++++++++++++++++++++++++++++++++------
 tools/perf/util/evsel.h |  7 ++++++
 2 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbfeceb2546c..f33801b4615d 100644
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
@@ -1807,8 +1828,13 @@ static void evsel__disable_missing_features(struct evsel *evsel)
 		evsel->open_flags &= ~(unsigned long)PERF_FLAG_FD_CLOEXEC;
 	if (perf_missing_features.mmap2)
 		evsel->core.attr.mmap2 = 0;
-	if (perf_missing_features.exclude_guest)
-		evsel->core.attr.exclude_guest = evsel->core.attr.exclude_host = 0;
+	if (perf_missing_features.exclude_guest) {
+		/* we only have EXCLUDE_GUEST bit, let's skip checking  */
+		if (hashmap__find(perf_missing_features.pmu, evsel, NULL)) {
+			evsel->core.attr.exclude_guest = 0;
+			evsel->core.attr.exclude_host = 0;
+		}
+	}
 	if (perf_missing_features.lbr_flags)
 		evsel->core.attr.branch_sample_type &= ~(PERF_SAMPLE_BRANCH_NO_FLAGS |
 				     PERF_SAMPLE_BRANCH_NO_CYCLES);
@@ -1840,6 +1866,9 @@ int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 bool evsel__detect_missing_features(struct evsel *evsel)
 {
+	if (perf_missing_features.pmu == NULL)
+		perf_missing_features.pmu = hashmap__new(pmu_hash, pmu_equal, NULL);
+
 	/*
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
@@ -1900,10 +1929,16 @@ bool evsel__detect_missing_features(struct evsel *evsel)
 		perf_missing_features.mmap2 = true;
 		pr_debug2_peo("switching off mmap2\n");
 		return true;
-	} else if (!perf_missing_features.exclude_guest &&
-		   (evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host)) {
-		perf_missing_features.exclude_guest = true;
-		pr_debug2_peo("switching off exclude_guest, exclude_host\n");
+	} else if ((evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host) &&
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
2.33.0.1079.g6e70778dc9-goog

