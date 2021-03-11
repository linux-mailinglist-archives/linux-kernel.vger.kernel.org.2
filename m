Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542FA336863
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 01:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhCKAJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 19:09:15 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:46889 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbhCKAI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 19:08:57 -0500
Received: by mail-io1-f52.google.com with SMTP id u8so19931852ior.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 16:08:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cMWBDEKf74JKkqccLeDtjQtyXiOgJF8ujNiX0uD1tgM=;
        b=l6AktBNi9ceaezwS4GjXrHZYWuDsKNuYQBQN8SCnesApW/2kfBOSdNgpiKXSvYMQxr
         63serUFN0jKsbeBTBhXk6F9q/OJFX5Lu07GONW9gC4emNHhUxLH0BDUQxaky5aDGfsxO
         m+Op6sPgSweZ5SAFcgyBzGFtlP8G5fgS/g5qt9/m7TgOZhx4rWmmbw8p86yRw0cf2pjm
         r/IGzdtBDlFKk2ZKur2csUFhGr266BuEh8A7oGGrrfALjgA8FZ9a0dv4KWgtdC7AO4bA
         GMyIWIzvBCCFfOcj3/5lWDHZBHSLrd6Qg3K5KH7Pz3OeJICz5hOe5nH/EHwRssekWbhB
         +ftg==
X-Gm-Message-State: AOAM532B72pktlLnu28B+iWzaOxRaXoF+hdfEGdlBrIxgt0WaNKwazrQ
        7T9yNqz8IB6+rM0vXF+iC4vuBG7OWA==
X-Google-Smtp-Source: ABdhPJxhxorFjWXTOP+5B/dBI9Q+nfgJagXZt2qDq1YNmr8NQGHkHNZG89mFUVhmxGp/1OGbHbBrgw==
X-Received: by 2002:a5d:8d92:: with SMTP id b18mr4399896ioj.167.1615421336768;
        Wed, 10 Mar 2021 16:08:56 -0800 (PST)
Received: from xps15.herring.priv ([64.188.179.253])
        by smtp.googlemail.com with ESMTPSA id x17sm484351ilm.40.2021.03.10.16.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:08:56 -0800 (PST)
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
Subject: [PATCH v6 05/10] libperf: tests: Add support for verbose printing
Date:   Wed, 10 Mar 2021 17:08:32 -0700
Message-Id: <20210311000837.3630499-6-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210311000837.3630499-1-robh@kernel.org>
References: <20210311000837.3630499-1-robh@kernel.org>
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

