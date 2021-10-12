Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBA6429B54
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 04:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhJLCP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 22:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhJLCP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 22:15:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4648CC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 19:13:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f8-20020a2585480000b02905937897e3daso25809001ybn.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 19:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KXLwmwE4TrX9P6IfHZohm8oMSZRK5w3cuXTwrGX29F8=;
        b=s6h5WrvxdhfH8nPtVCEp6yhLe6ki5NJkW+X0HSOkzIm7FaG/nM7ZNv4StjZs3cN8qx
         FYoTKqfmeGy1MOSKo4Q3i6O/q+MKGpflPvh5SsGZAiM04or+oe6FezB+360Ra+pE1ixN
         JaTWixNi5478C09QmtT0KvRY0s8sVz7n6uvkw0q0Izaa5TRFMr6Ffoi6p2mTBsI3dpmh
         EW2qhP9uhfo1hM+x2ZIwOofiN5n6fennQEE+QzRa4olAEQlrPOhBqZX4WRVDHlIyX823
         Kn1FtbQ7jgS08c37hYUeN5p8Mg5YoDME/EROZCWDuFw96pXQoEgVtBMmQUBxVITKn78/
         DWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KXLwmwE4TrX9P6IfHZohm8oMSZRK5w3cuXTwrGX29F8=;
        b=W1gDXozgVHhG+FEiXkpXdrP+x47qb6HJPuUgdWfml3lOk30+4EL1RrkuvFjNamoGhM
         gH4Fds9XS7UXMtJGkHAzMyi/o1Smi8rlo/zehIbX+fCY+Ww1BrT4r3db/CMAFm0bb1Fp
         orDy2lLVokAe3Ui8XKH7+hT3yRL44Zi8mD2VTSI2bUbuokOV+R9QD/KmYTWeVQSFN9wg
         YlE0zCGQ0AtjBIF88QpeIPxnrYt1dlHbgs0HIYrO1K00/bXtKZn0dRqf8Ewfy4fheuTC
         tVxeRX7EI2xZ7OrPjwYiagDA/WQ1He65L2fi7n7UN/PHncl2p5EAiOVZhVk/rHwiH4Eq
         IDpA==
X-Gm-Message-State: AOAM532gDXkrFQ71t9xmQndRJ9U42Z3/3POS3bpxdC+PrbssCVtc54Kr
        G+YUKPcRvFcz6WIaw+GUrti7b5nSEdZk
X-Google-Smtp-Source: ABdhPJxfuUu/Fl1OhTq4pm+CzhQzuD9E4KsYwVBblC10vTGer3AmqY3riet4zRq0i5pEY9PK3+keIiba7UVd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2ad2:cb91:6fbd:a6f2])
 (user=irogers job=sendgmr) by 2002:a25:cc4a:: with SMTP id
 l71mr24630825ybf.41.1634004806327; Mon, 11 Oct 2021 19:13:26 -0700 (PDT)
Date:   Mon, 11 Oct 2021 19:13:20 -0700
Message-Id: <20211012021321.291635-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 1/2] tools: Bump minimum LLVM C++ std to GNU++14
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev, Fangrui Song <maskray@google.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LLVM 9 (current release is LLVM 13) moved the minimum C++ version to
GNU++14. Bump the version numbers in the feature test and perf build.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/feature/Makefile | 6 +++---
 tools/perf/Makefile.config   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index d024b5204ba0..19f145a35a43 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -300,7 +300,7 @@ $(OUTPUT)test-jvmti-cmlr.bin:
 	$(BUILD)
 
 $(OUTPUT)test-llvm.bin:
-	$(BUILDXX) -std=gnu++11 				\
+	$(BUILDXX) -std=gnu++14 				\
 		-I$(shell $(LLVM_CONFIG) --includedir) 		\
 		-L$(shell $(LLVM_CONFIG) --libdir)		\
 		$(shell $(LLVM_CONFIG) --libs Core BPF)		\
@@ -308,12 +308,12 @@ $(OUTPUT)test-llvm.bin:
 		> $(@:.bin=.make.output) 2>&1
 
 $(OUTPUT)test-llvm-version.bin:
-	$(BUILDXX) -std=gnu++11 				\
+	$(BUILDXX) -std=gnu++14					\
 		-I$(shell $(LLVM_CONFIG) --includedir)		\
 		> $(@:.bin=.make.output) 2>&1
 
 $(OUTPUT)test-clang.bin:
-	$(BUILDXX) -std=gnu++11 				\
+	$(BUILDXX) -std=gnu++14					\
 		-I$(shell $(LLVM_CONFIG) --includedir) 		\
 		-L$(shell $(LLVM_CONFIG) --libdir)		\
 		-Wl,--start-group -lclangBasic -lclangDriver	\
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0ae2e3d8b832..86be3f6ec018 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -285,7 +285,7 @@ CORE_CFLAGS += -Wall
 CORE_CFLAGS += -Wextra
 CORE_CFLAGS += -std=gnu99
 
-CXXFLAGS += -std=gnu++11 -fno-exceptions -fno-rtti
+CXXFLAGS += -std=gnu++14 -fno-exceptions -fno-rtti
 CXXFLAGS += -Wall
 CXXFLAGS += -fno-omit-frame-pointer
 CXXFLAGS += -ggdb3
-- 
2.33.0.882.g93a45727a2-goog

