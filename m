Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5E93AFC13
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 06:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhFVEkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 00:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhFVEkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 00:40:39 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77D2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 21:38:24 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id c3-20020a37b3030000b02903ad0001a2e8so16567882qkf.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 21:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xjwwJU2DWInl98UuzSucz8mPGJZAy/tZZF05M3ACx4g=;
        b=SxBmB9zwpriFS+ea7DTHPna7ObAx1Cbp+mOw1qXB+g4ea7l5TOmE7zYhrd7srwZDoB
         maJ1PbCbyKa/mt2QsXSGsAHPRGej7A5HBveqrdnmn9gjth4JtCNBZghET/YSwF6gTOGK
         R6Ms7Q+LNea+msHOO5SUpbmZmCBYBa46v83hcIxioi2cfRL2mDJaiplJAOiIpilKD0qx
         s1PMWgszH2bH3ZqrAfiSKYeFZ7u5tsRbx66eFSo/4Sat9aQkR2DlDvJIB76wuh0Zbe7d
         aMkT3wuMBYNeB2j/KtBYf9+AL/Lev5K/N55O4BnWG4n4ZnPg2Ks6xYY35ljMHHwmXNyB
         9HvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xjwwJU2DWInl98UuzSucz8mPGJZAy/tZZF05M3ACx4g=;
        b=KguMAbcwqORK5ZM3NhFFxN+khNhilrBdFdJYXFC3Lmh15Vb2bZg9PFDUt5K1uT26rr
         9aKZmEVKA4SAGl1tlflR5EfRUn8gEOrQN+V/s8SMaV0w+0X4ysNzeVXLvrT/br05fCjZ
         Np+GF95+FVrRFCY/+7d1C9tZBrGpzdsV5nTq4qutOCBR0AYGxNWK1LaZ1ZkdjwxzvRQ2
         DyQFjiZhao1YLyqDjjmfUxZTJHDiV6jfX65zF7rKF4jYiksqeyWRcKIVjlPIfOaOFAOH
         2ulEXZBJmPSOaKHtrVlC1KlDG3VpByZGPJQCcgScsiSJ5ki+zm1UtLlSEdp3pzMjjMbQ
         ehrQ==
X-Gm-Message-State: AOAM531Ygey2QL1N+XlponCWApQ8RKLKmZPio50g3k7KLNeHbKmJop8q
        mUV2LnFiBYH3AB0gyj9KBLv5DsE1ALvg
X-Google-Smtp-Source: ABdhPJw4zp2WT6JLXLxngSGapcryB06Lr0NnqU3In77xsNtieZm2+cdkweostg0xo1GRduLuGfoAhdbmMAwd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ffd6:b7f5:87ee:7be2])
 (user=irogers job=sendgmr) by 2002:a25:b70c:: with SMTP id
 t12mr2273490ybj.90.1624336703769; Mon, 21 Jun 2021 21:38:23 -0700 (PDT)
Date:   Mon, 21 Jun 2021 21:38:08 -0700
Message-Id: <20210622043811.3108564-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 1/4] perf: Enable libtracefs dynamic linking
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-users@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Claire Jensen <cjense@google.com>
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
index 04a8e3db8a54..c87e876b6dd7 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -53,6 +53,7 @@ FEATURE_TESTS_BASIC :=                  \
         libslang                        \
         libslang-include-subdir         \
         libtraceevent                   \
+        libtracefs                      \
         libcrypto                       \
         libunwind                       \
         pthread-attr-setaffinity-np     \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index ec203e28407f..9488c4b4026e 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -37,6 +37,7 @@ FILES=                                          \
          test-libslang.bin                      \
          test-libslang-include-subdir.bin       \
          test-libtraceevent.bin                 \
+         test-libtracefs.bin                    \
          test-libcrypto.bin                     \
          test-libunwind.bin                     \
          test-libunwind-debug-frame.bin         \
@@ -200,6 +201,9 @@ $(OUTPUT)test-libslang-include-subdir.bin:
 $(OUTPUT)test-libtraceevent.bin:
 	$(BUILD) -ltraceevent
 
+$(OUTPUT)test-libtracefs.bin:
+	$(BUILD) -ltracefs
+
 $(OUTPUT)test-libcrypto.bin:
 	$(BUILD) -lcrypto
 
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a62d09808fef..3a8a54b71654 100644
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
index e47f04e5b51e..b56e26b703ff 100644
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
2.32.0.288.g62a8d224e6-goog

