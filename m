Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0982430063
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 07:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243679AbhJPFPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 01:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbhJPFPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 01:15:06 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B540C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 22:12:59 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r2so10453724pgl.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 22:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tB6yT/z5WTW96arh1CIlVxwS8X4LHTKs6HugafCgS3w=;
        b=OHMbFO+V1U7Sacg7IClpQC3s9FZQqR2K86dwJ+bZQ77HVvH+IS57lEEgTXc9U0BRQc
         p27tNRcs7URd2UiAcufjsKtI7PJPouV9G2nVMMVc9vKshODYVCDFHKnKquZ+6bOaJLEC
         L4vjvG9o/z2muYmWFyNrrWv6w/d90hefdaau5Bi8C/oBECcNZG2CY/3NChuA5jImBK+a
         Ny6+PSpWLbRaW3hTUGXcWoubKaDnexOyotHi7HoOXdmAiiglq3gC+sOMGRAwZCbO+u9D
         y/aS37mO2SB+/+JDWswOcpRur+TxburBp/f+6CsHnkkf7Ns9LXkpyjkLRPVMczp4N3L0
         UhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=tB6yT/z5WTW96arh1CIlVxwS8X4LHTKs6HugafCgS3w=;
        b=ToDv4BuLZ+QqZmq7rXhmxDlhUs6Kc0bsmeMgb8neKDKwfIH6DXPWOOO2Ab3qbvbfB1
         hBqJM/NKvNV8BDD0uZ+rCiw6Ee790DLx/+99RPLg117scIi5W169N7iVIUqgSVmxKKyx
         Rqy3MDB4RIJqnJmVbaPx8w6qRQrTNEn8X4ix+QP9k1kbSvuiQARtrmxCS6t0v6fbtTuk
         fYjJLDkUNDzQbveZf2KjnO3EIDYWPPOrhni69VryRoiHpUu+UrVLOWSBcIahtBbGz4Br
         uUzCQCsKqqTykLTfNj5aw7Jh0JUovJpGSb1gpfy+Yec1tfTvyXDTpdhMqTf5RlDowVBv
         sxTg==
X-Gm-Message-State: AOAM532FTqvLZbivQOdHJcFOIa4aqftbWEPThqUatJt2izWeEmlcqR6e
        dTNZu3kz+hms/54O2xUQfHI=
X-Google-Smtp-Source: ABdhPJwyI3onrSBmhfC8Xo2EHzGDzVsjEANO/WN7f5Fa6tClySGfj0Oad1508EjsbGLRNYnh6u37+A==
X-Received: by 2002:a65:64c3:: with SMTP id t3mr12276017pgv.244.1634361178764;
        Fri, 15 Oct 2021 22:12:58 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:5800:fa43:784e:a05:3c3d])
        by smtp.gmail.com with ESMTPSA id s14sm6493054pfg.50.2021.10.15.22.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 22:12:56 -0700 (PDT)
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
Subject: [PATCH] perf evsel: Fix missing exclude_{host,guest} setting
Date:   Fri, 15 Oct 2021 22:12:53 -0700
Message-Id: <20211016051253.2035821-1-namhyung@kernel.org>
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
 tools/perf/util/evsel.c | 47 +++++++++++++++++++++++++++++++++++------
 tools/perf/util/evsel.h |  6 ++++++
 2 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbfeceb2546c..437a28e769fe 100644
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
+		void *pmu;
+
+		if (hashmap__find(perf_missing_features.pmu, evsel, &pmu)) {
+			evsel->core.attr.exclude_guest = 0;
+			evsel->core.attr.exclude_host = 0;
+		}
+	}
 	if (perf_missing_features.lbr_flags)
 		evsel->core.attr.branch_sample_type &= ~(PERF_SAMPLE_BRANCH_NO_FLAGS |
 				     PERF_SAMPLE_BRANCH_NO_CYCLES);
@@ -1840,6 +1867,9 @@ int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 bool evsel__detect_missing_features(struct evsel *evsel)
 {
+	if (perf_missing_features.pmu == NULL)
+		perf_missing_features.pmu = hashmap__new(pmu_hash, pmu_equal, NULL);
+
 	/*
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
@@ -1900,10 +1930,15 @@ bool evsel__detect_missing_features(struct evsel *evsel)
 		perf_missing_features.mmap2 = true;
 		pr_debug2_peo("switching off mmap2\n");
 		return true;
-	} else if (!perf_missing_features.exclude_guest &&
-		   (evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host)) {
-		perf_missing_features.exclude_guest = true;
-		pr_debug2_peo("switching off exclude_guest, exclude_host\n");
+	} else if ((evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host) &&
+		   !hashmap__find(perf_missing_features.pmu, evsel, NULL)) {
+		struct perf_missing_pmu_features pmu_features = { true };
+		hashmap__add(perf_missing_features.pmu, evsel, &pmu_features);
+
+		if (!perf_missing_features.exclude_guest) {
+			perf_missing_features.exclude_guest = true;
+			pr_debug2_peo("switching off exclude_guest, exclude_host\n");
+		}
 		return true;
 	} else if (!perf_missing_features.sample_id_all) {
 		perf_missing_features.sample_id_all = true;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 1f7edfa8568a..8dd11c8e022d 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -172,6 +172,12 @@ struct perf_missing_features {
 	bool data_page_size;
 	bool code_page_size;
 	bool weight_struct;
+
+	struct hashmap *pmu;
+};
+
+struct perf_missing_pmu_features {
+	bool exclude_guest;
 };
 
 extern struct perf_missing_features perf_missing_features;
-- 
2.33.0.1079.g6e70778dc9-goog

