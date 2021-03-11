Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF10336867
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 01:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhCKAJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 19:09:20 -0500
Received: from mail-il1-f174.google.com ([209.85.166.174]:41398 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhCKAJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 19:09:04 -0500
Received: by mail-il1-f174.google.com with SMTP id c10so17324854ilo.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 16:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6pXeu7+bDGssjO8s/anHP3hxNn1cbO6yq30ua5T050k=;
        b=bhEuSG9cWFIK1nTHW99dZZ5iG/Kplf0XxYa11jir2d+KE8sriSoV4/moGWbEiSm3sV
         4L95tDpvXtsRElD02DgUVkV5zrJ8XMk9AxfA00IM7Cm5oQ7Ai+XI8qO6rJKlZzrekZnf
         d2TkpLrBtaOkZdvm6LbO/zWIY3eS2/aIglZFx5a5LrMZxe/MlB5hO3yGfe4jY8BxnR+5
         jNjU5kop9vCgsRvuLokufrCsHe3YGJkm7ql2p0Kni++eNzXk9y6bOYaik9bqm/sq89DH
         hjDEnIaBkI/vbP31bFoQ1BB71NFKUhV/xghPxBUxZF/kAuHa9++CcBs63ovkvwnsnsHG
         nBKA==
X-Gm-Message-State: AOAM533fjxfXAEGvoxDi7gc34869wtSX04ReUJr+lMEwab2Ed50611Rw
        uqgVail1DzWGTDHPRkSeBA==
X-Google-Smtp-Source: ABdhPJzlFWP4g4KqM2/WmQPdc1YAoqFr6g9B3PdpvoMMB+znmVybK4Muj8cRV5kuUvSD3bjNjFIdaA==
X-Received: by 2002:a05:6e02:1be1:: with SMTP id y1mr4717252ilv.101.1615421344398;
        Wed, 10 Mar 2021 16:09:04 -0800 (PST)
Received: from xps15.herring.priv ([64.188.179.253])
        by smtp.googlemail.com with ESMTPSA id x17sm484351ilm.40.2021.03.10.16.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:09:03 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/10] perf: arm64: Add tests for 32-bit and 64-bit counter size userspace access
Date:   Wed, 10 Mar 2021 17:08:36 -0700
Message-Id: <20210311000837.3630499-10-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210311000837.3630499-1-robh@kernel.org>
References: <20210311000837.3630499-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add arm64 specific tests for 32-bit and 64-bit counter user access. On
arm64, counters default to 32-bit unless attr.config1:0 is set to 1. In
order to enable user access for 64-bit counters, attr.config1 must be set
to 3.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v6:
 - New patch
---
 tools/perf/arch/arm64/include/arch-tests.h |  5 +++
 tools/perf/arch/arm64/tests/arch-tests.c   |  8 +++++
 tools/perf/arch/arm64/tests/user-events.c  | 38 ++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/tools/perf/arch/arm64/include/arch-tests.h b/tools/perf/arch/arm64/include/arch-tests.h
index 380ad34a3f09..ddfa7460e1e1 100644
--- a/tools/perf/arch/arm64/include/arch-tests.h
+++ b/tools/perf/arch/arm64/include/arch-tests.h
@@ -15,5 +15,10 @@ extern struct test arch_tests[];
 int test__rd_pinned(struct test __maybe_unused *test,
 		       int __maybe_unused subtest);
 
+int test__rd_64bit(struct test __maybe_unused *test,
+		   int __maybe_unused subtest);
+
+int test__rd_32bit(struct test __maybe_unused *test,
+		   int __maybe_unused subtest);
 
 #endif
diff --git a/tools/perf/arch/arm64/tests/arch-tests.c b/tools/perf/arch/arm64/tests/arch-tests.c
index 80ce7bd3c16d..bbdb81aa3229 100644
--- a/tools/perf/arch/arm64/tests/arch-tests.c
+++ b/tools/perf/arch/arm64/tests/arch-tests.c
@@ -14,6 +14,14 @@ struct test arch_tests[] = {
 		.desc = "Pinned CPU user counter access",
 		.func = test__rd_pinned,
 	},
+	{
+		.desc = "User 64-bit counter access",
+		.func = test__rd_64bit,
+	},
+	{
+		.desc = "User 32-bit counter access",
+		.func = test__rd_32bit,
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/arch/arm64/tests/user-events.c b/tools/perf/arch/arm64/tests/user-events.c
index c8efc6b369e6..546323b5242c 100644
--- a/tools/perf/arch/arm64/tests/user-events.c
+++ b/tools/perf/arch/arm64/tests/user-events.c
@@ -175,3 +175,41 @@ int test__rd_pinned(struct test __maybe_unused *test,
 	perf_evsel__delete(evsel);
 	return ret;
 }
+
+static int test__rd_counter_size(struct test __maybe_unused *test,
+				 int config1)
+{
+	int ret;
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr = {
+		.type = PERF_TYPE_HARDWARE,
+		.config = PERF_COUNT_HW_INSTRUCTIONS,
+		.config1 = config1,
+		.exclude_kernel = 1,
+	};
+
+	if (!pmu_is_homogeneous())
+		return TEST_SKIP;
+
+	evsel = perf_init(&attr);
+	if (!evsel)
+		return -1;
+
+	ret = run_test(evsel);
+
+	perf_evsel__close(evsel);
+	perf_evsel__delete(evsel);
+	return ret;
+}
+
+int test__rd_64bit(struct test __maybe_unused *test,
+		   int __maybe_unused subtest)
+{
+	return test__rd_counter_size(test, 0x3);
+}
+
+int test__rd_32bit(struct test __maybe_unused *test,
+		   int __maybe_unused subtest)
+{
+	return test__rd_counter_size(test, 0x2);
+}
-- 
2.27.0

