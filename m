Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE7F35E4CC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344366AbhDMRQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:16:37 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:34481 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbhDMRQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:16:31 -0400
Received: by mail-oi1-f169.google.com with SMTP id k18so12812540oik.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 10:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cMWBDEKf74JKkqccLeDtjQtyXiOgJF8ujNiX0uD1tgM=;
        b=XUH3HHr+S6Yf62V2SXtACPEUVq/9PtlLKOygReKd7QV7bqDphaIdoeHK+pQwys/MoV
         QIBW6Sza+haxm5w9jrpmeMF+Lg7YrLkFF/DqPoSViLOMztx+6Hux99Awfs1kdknqmpHR
         GyTBq8DZ3fFwAgwvXcVLhhB75Q7MiDzO2KJhQ+yuPY7T6PDWovjMWPxZ5V7EKznq5AkQ
         dJ7tjMyJX6iB1CKRaJ0m9HmhXB8guZXXSGuDqB5/glqmlSkZYwm6uk63lzpgFGSr4vUu
         PaNK6jIpiJQppRD/GfV27Dxk8wgw5QiZx/xHW8huVaLSxFIT9Xm9gFZM/79x9u/DTVuR
         HE8Q==
X-Gm-Message-State: AOAM533Kh1VdspyRZlrsJqZ0Y0G+9mUmhSaR//jUq0VbTP5XsNPPW94H
        Oi5RWXq2aJ96hRxPFYB3Lw==
X-Google-Smtp-Source: ABdhPJy24vtEkuT1x54/NTVCVcNGF8KmtLWrKHM97wjxsUZymV+8OhdbEdOWoVWJpWCKCZn0ZANfLA==
X-Received: by 2002:aca:bc42:: with SMTP id m63mr720422oif.42.1618334171557;
        Tue, 13 Apr 2021 10:16:11 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id y4sm109278oia.53.2021.04.13.10.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 10:16:11 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: [PATCH v7 3/4] libperf: tests: Add support for verbose printing
Date:   Tue, 13 Apr 2021 12:16:05 -0500
Message-Id: <20210413171606.1825808-4-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210413171606.1825808-1-robh@kernel.org>
References: <20210413171606.1825808-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __T_VERBOSE() so tests can add verbose output. The verbose output is
enabled with the '-v' command line option.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v5:
 - Pass verbose flag to static tests
 - Fix getopt loop with unsigned char (arm64)
v3:
 - New patch
---
 tools/lib/perf/include/internal/tests.h | 32 +++++++++++++++++++++++++
 tools/lib/perf/tests/Makefile           |  6 +++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/include/internal/tests.h b/tools/lib/perf/include/internal/tests.h
index 2093e8868a67..29425c2dabe1 100644
--- a/tools/lib/perf/include/internal/tests.h
+++ b/tools/lib/perf/include/internal/tests.h
@@ -3,11 +3,32 @@
 #define __LIBPERF_INTERNAL_TESTS_H
 
 #include <stdio.h>
+#include <unistd.h>
 
 int tests_failed;
+int tests_verbose;
+
+static inline int get_verbose(char **argv, int argc)
+{
+	int c;
+	int verbose = 0;
+
+	while ((c = getopt(argc, argv, "v")) != -1) {
+		switch (c)
+		{
+		case 'v':
+			verbose = 1;
+			break;
+		default:
+			break;
+		}
+	}
+	return verbose;
+}
 
 #define __T_START					\
 do {							\
+	tests_verbose = get_verbose(argv, argc);	\
 	fprintf(stdout, "- running %s...", __FILE__);	\
 	fflush(NULL);					\
 	tests_failed = 0;				\
@@ -30,4 +51,15 @@ do {
 	}                                                                        \
 } while (0)
 
+#define __T_VERBOSE(...)						\
+do {									\
+	if (tests_verbose) {						\
+		if (tests_verbose == 1) {				\
+			fputc('\n', stderr);				\
+			tests_verbose++;				\
+		}							\
+		fprintf(stderr, ##__VA_ARGS__);				\
+	}								\
+} while (0)
+
 #endif /* __LIBPERF_INTERNAL_TESTS_H */
diff --git a/tools/lib/perf/tests/Makefile b/tools/lib/perf/tests/Makefile
index 96841775feaf..b536cc9a26dd 100644
--- a/tools/lib/perf/tests/Makefile
+++ b/tools/lib/perf/tests/Makefile
@@ -5,6 +5,8 @@ TESTS = test-cpumap test-threadmap test-evlist test-evsel
 TESTS_SO := $(addsuffix -so,$(TESTS))
 TESTS_A  := $(addsuffix -a,$(TESTS))
 
+TEST_ARGS := $(if $(V),-v)
+
 # Set compile option CFLAGS
 ifdef EXTRA_CFLAGS
   CFLAGS := $(EXTRA_CFLAGS)
@@ -28,9 +30,9 @@ all: $(TESTS_A) $(TESTS_SO)
 
 run:
 	@echo "running static:"
-	@for i in $(TESTS_A); do ./$$i; done
+	@for i in $(TESTS_A); do ./$$i $(TEST_ARGS); done
 	@echo "running dynamic:"
-	@for i in $(TESTS_SO); do LD_LIBRARY_PATH=../ ./$$i; done
+	@for i in $(TESTS_SO); do LD_LIBRARY_PATH=../ ./$$i $(TEST_ARGS); done
 
 clean:
 	$(call QUIET_CLEAN, tests)$(RM) $(TESTS_A) $(TESTS_SO)
-- 
2.27.0

