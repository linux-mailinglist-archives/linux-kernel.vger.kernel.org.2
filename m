Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186763650BB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 05:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbhDTDQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 23:16:15 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:43838 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbhDTDQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 23:16:02 -0400
Received: by mail-oi1-f178.google.com with SMTP id x20so3868254oix.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 20:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6pXeu7+bDGssjO8s/anHP3hxNn1cbO6yq30ua5T050k=;
        b=aVW9T8OGQfmV7EIVu+uoUfBTIrx8zCOOTRQRtqUgD0UnyM84qn3rz4w831KfouaOSL
         gbG46FJP9QUz+chQ6rtpFUDpiiesd+y7eh3qsB+cPCd5NIHzbgDWYYesvGcXmUSi8IGo
         tkzeZvUp7DGFUXgqDijmG24k9bpq6GREBgBy+bcvvkjiqykUVPFseJtjLjakGyT+l+BI
         geNWaYCyfCef09xeN2Vyb0C0STklP7KnY7LC/swAjW2AZ1OelfumpX4S6NyI/bUhEqoL
         Hhz/7OoMeFk9xOGnGp8gtFuxi5CCuLQrFDCHqkpwTwO9/g0i9nRiKZzq+7qMYP6cytJ5
         jkiw==
X-Gm-Message-State: AOAM532ApMTs1pQBaNrmLCyNGbkbfMD4KviMlPM8icVFncKTw046Rpcc
        apUMfyclE5gGFoqiKPlszg==
X-Google-Smtp-Source: ABdhPJykR7poh0WmQ/MMrDRYS86JiFqeqdWgxNCC0vb4Jkf3MdgM7h5svFVCgCmHIei1eVBU487Arg==
X-Received: by 2002:aca:482:: with SMTP id 124mr1582826oie.130.1618888527472;
        Mon, 19 Apr 2021 20:15:27 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id g16sm2347896oof.43.2021.04.19.20.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 20:15:26 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 8/9] perf: arm64: Add tests for 32-bit and 64-bit counter size userspace access
Date:   Mon, 19 Apr 2021 22:15:10 -0500
Message-Id: <20210420031511.2348977-9-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210420031511.2348977-1-robh@kernel.org>
References: <20210420031511.2348977-1-robh@kernel.org>
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

