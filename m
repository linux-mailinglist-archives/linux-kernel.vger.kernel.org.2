Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048274299C9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 01:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbhJKX0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 19:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhJKX0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 19:26:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0032C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 16:24:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s66-20020a252c45000000b005ba35261459so24571586ybs.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 16:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KXLwmwE4TrX9P6IfHZohm8oMSZRK5w3cuXTwrGX29F8=;
        b=et1Sxb65m9+vwLlfkIKKA7Y1J6IaM8BqdoCZ7ieLpPXx6cJfvUiCeZkiBmh3fDhCE2
         np7gIlRc/QDO3MpZCagM2OjOh8EGp7rct8ERiMkv806ee/7oCPXhMwoLzYzPo3QLc5XL
         1ZG+E8DRnnw1a1yldfTyyUMG0mHug4CgkcgENBj5AUtd+dnpaGb/Q6m6SUmuLAe2I0ip
         EnSwNmalP1m+kNGqj6b0tlZk4yMV80Eje2YbJpZcD869A8SvSgim5wCrcqPvo3dIhAnD
         MOQv/+qxBHp7R+ZI1c/ECvewReMmJapvzey8kPxNEu3AR5AUp32a97D+OO22O0lBidKd
         binA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KXLwmwE4TrX9P6IfHZohm8oMSZRK5w3cuXTwrGX29F8=;
        b=lWNkoJaSFQROKh1Z6MT7kouwpm0cM/hKL8DmEtA46uK3hzrALBwot9vLZqSbxtujec
         DrazIEP5cw1SRFmHJZ+FgDwp4AUlBjfWouw87hz49LN+kcZqz0zhncZvELjr2MgEdv7A
         1LEYFgcFul7J+EN1uuGXLO+KiQ6dQA1PAJJvajpficlMmjzKWS82pL8V+vdp6zM33flr
         rJT82uTk3LzoPZAtkop5jj4V+Q3RJBYJi8lE2TkPRV0sm1+rZRiuUqzUQ1eTfaY6KLT5
         IuNWzl1rWC8h/lHcISGTRMP89wtpugDPNyPK93ZEUmpFB4uA7Ho9jAVf2afOAoACQVB4
         enTA==
X-Gm-Message-State: AOAM533tCgIcm08WvJKXu52LB8aLjtgUP0mCv/3vD6gcSBVb4rU+iw2x
        WOTk7D5/HghLpkg0NwBouPu+JAwXeFWd
X-Google-Smtp-Source: ABdhPJxjpmIG7Z9kRVv+wVHGTX+Bu5icxM6x4AUwcyjgIx3vrUdMnA5hCS/M6pFKkLWPh6kJO3qktAImSvTJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2ad2:cb91:6fbd:a6f2])
 (user=irogers job=sendgmr) by 2002:a25:1ec6:: with SMTP id
 e189mr25691573ybe.150.1633994691230; Mon, 11 Oct 2021 16:24:51 -0700 (PDT)
Date:   Mon, 11 Oct 2021 16:24:45 -0700
Message-Id: <20211011232446.250195-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 1/2] tools: Bump minimum LLVM C++ std to GNU++14
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
        llvm@lists.linux.dev
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

