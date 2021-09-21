Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AADE413BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 22:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbhIUUuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 16:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbhIUUuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 16:50:20 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6B9C061756
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 13:48:51 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 70-20020a370b49000000b003d2f5f0dcc6so3414650qkl.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 13:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=SS8p382b/+MpzDEKHFqeki4mKVdeQdYY0H5NNgwH11A=;
        b=X3Fii41kydfo469RvTRIPRGu6D4NahUVyM1IpsOidXGdWldWHkUvhW2Vo9lN/LfOOd
         QFbtEMYXDNsaAbZM2qqgsULT4RqKHX6euBQPSLKnOjBwHjSeKYQp0oBHxRZUw63622BM
         AH+RbuQq3XuvOdajQxiR3SOys/l38Gkm/LKv+msY6QMovpYDxS6sv+JqTo2qS/BkOdc2
         6CUPke8MWARLJrNS2u/gOutk7TS6gL6EPCxRlDkkR8KOHxOl7R6quAGJZhIUJhpIRhWo
         S59HIYRLPLwOhnGUpMVrfMItPtQm4H+hdSrFSmU+XMCP3PNvuM9L8E1I/ZHAmLArzmdf
         L3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=SS8p382b/+MpzDEKHFqeki4mKVdeQdYY0H5NNgwH11A=;
        b=6RucheZrpl+bFThCT6v1ExtIKfofFGyPC5umQctJWRbhcKzZHecmH2DZZON9aAkGQ3
         SThluBgnqnfRZjGK6r/fvFnNPNdVgqHgz5JSzv4OjqZRH5ns4EMxzD7+AyR69NQf/Eri
         y9VII3uegMcP3DiwaMb9nMOINT6gdXZvG4JinR6sQOQSCN7GtBkicm/YKlg4t7Vp6e/H
         CFKJw03YxP4PGNWK8guooUKXU3Wc+/XwYuIHVNAo2tv63KlPGBrU+p3OsVEcZpkbjOex
         tg914vX8SPN3ipmRKsCaEzuAHussNS7NLe6uJd65N5RFsdKK+QKzFcCXeU0Yblp0m66c
         ++eA==
X-Gm-Message-State: AOAM531uWQMkzHIz+zrhBsrOJvCKC/ZNSBInT0pS3uXnQlkSlo7Hdi4W
        gi7nXNM7swJRyiEL2zfE8/wdlICBqBVG
X-Google-Smtp-Source: ABdhPJzcwyxZUGyLCqvEi6klZbQxxfa2zzSLXp8Z7ILqpWhvTXUEbxebpLk0txplencstN7nXLnwlS/+CzjX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:dffa:819a:f0e2:47e])
 (user=irogers job=sendgmr) by 2002:a05:6214:13a3:: with SMTP id
 h3mr32949438qvz.26.1632257330641; Tue, 21 Sep 2021 13:48:50 -0700 (PDT)
Date:   Tue, 21 Sep 2021 13:48:36 -0700
Message-Id: <20210921204839.236840-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2 1/4] perf: Enable libtracefs dynamic linking
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently libtracefs isn't used by perf, but there are potential
improvements by using it as identified Steven Rostedt's e-mail:
https://lore.kernel.org/lkml/20210610154759.1ef958f0@oasis.local.home/

This change is modelled on the dynamic libtraceevent patch by Michael
Petlan:
https://lore.kernel.org/linux-perf-users/20210428092023.4009-1-mpetlan@redhat.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature | 1 +
 tools/build/feature/Makefile | 4 ++++
 tools/perf/Makefile.config   | 9 +++++++++
 tools/perf/Makefile.perf     | 2 ++
 4 files changed, 16 insertions(+)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 3dd2f68366f9..45a9a59828c3 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -52,6 +52,7 @@ FEATURE_TESTS_BASIC :=                  \
         libslang                        \
         libslang-include-subdir         \
         libtraceevent                   \
+        libtracefs                      \
         libcrypto                       \
         libunwind                       \
         pthread-attr-setaffinity-np     \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index eff55d287db1..d024b5204ba0 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -36,6 +36,7 @@ FILES=                                          \
          test-libslang.bin                      \
          test-libslang-include-subdir.bin       \
          test-libtraceevent.bin                 \
+         test-libtracefs.bin                    \
          test-libcrypto.bin                     \
          test-libunwind.bin                     \
          test-libunwind-debug-frame.bin         \
@@ -199,6 +200,9 @@ $(OUTPUT)test-libslang-include-subdir.bin:
 $(OUTPUT)test-libtraceevent.bin:
 	$(BUILD) -ltraceevent
 
+$(OUTPUT)test-libtracefs.bin:
+	$(BUILD) -ltracefs
+
 $(OUTPUT)test-libcrypto.bin:
 	$(BUILD) -lcrypto
 
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 446180401e26..00ec900ddbca 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1098,6 +1098,15 @@ ifdef LIBTRACEEVENT_DYNAMIC
   endif
 endif
 
+ifdef LIBTRACEFS_DYNAMIC
+  $(call feature_check,libtracefs)
+  ifeq ($(feature-libtracefs), 1)
+    EXTLIBS += -ltracefs
+  else
+    dummy := $(error Error: No libtracefs devel library found, please install libtracefs-dev);
+  endif
+endif
+
 # Among the variables below, these:
 #   perfexecdir
 #   perf_include_dir
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e04313c4d840..7df13e74450c 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -130,6 +130,8 @@ include ../scripts/utilities.mak
 #
 # Define LIBTRACEEVENT_DYNAMIC to enable libtraceevent dynamic linking
 #
+# Define LIBTRACEFS_DYNAMIC to enable libtracefs dynamic linking
+#
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
-- 
2.33.0.464.g1972c5931b-goog

