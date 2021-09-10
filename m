Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590B44073A2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 00:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbhIJW7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 18:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhIJW7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 18:59:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DE7C061756
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 15:58:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 83-20020a251956000000b0059948f541cbso4487287ybz.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 15:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BJDLzCz2E12CBMys6DrXt32TSGJ21rsoRK0PrUSpQaA=;
        b=Endbm9Pm/v/6QwrJl3ZzV/vcW123iunM5yLNVPg4NPtCTmORPntR5zaUHX26ypI+rg
         jdaOoLhdv0gBepuVLuvwyQrP3INJq8EauSB40e7jU2gYvWJziFoMJ7s0I6tia6XfU+Xt
         kPOLVAqO31NLtDwiQM/N2O1ryfSRpOYcJN7xexG+iVrnNdTSAoNNcQPDIN1dvrir5U09
         6jdUfofz3mdPk1uYQ+rFz4Y2SnFN3w4NmxmK9AtKL42n5BIW38wArMiAE19dd2OokpZu
         HdyANTju6RWAFtAW5DZxQIcQ2tzMsAvAir68L1c7tI1Qj1dmRCQIh/rltOc/+bb0S5ul
         b8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BJDLzCz2E12CBMys6DrXt32TSGJ21rsoRK0PrUSpQaA=;
        b=uA/PW+GYtrqba1h5fGJYgk0ARKNW1XiFhEodXc3sHU5cXsJu4qjNoUVxSCB/Gkxv3z
         JJv6homlnViWYqOG/JY8A7F50xccQ+PDIhprkIudfONILkN6CyzeQFGCbYfJI37KmmYz
         S8n2+Kubew5p5xY+1/O/YOUGac+FOBuEQqoPbiUmVagz0YY0AHRmfoJIyLR7h+iWhZF8
         sr1bRFn5puTsj1OPyBg7rS8jZe22fRwX2Iaj3ayZ0SJEDbnEhbTurLWr+LAgOuAeiQh5
         CDqUNtbsq9SkpMS+8eWzQGPGYR9eTnVlQLKLKk9wFunbQtL7rVYqdpRCsdcNKOkkqf+K
         Zz8w==
X-Gm-Message-State: AOAM531XTihn9cuLGe0kMfYcu/2SlJSA8IP9x5YvglTnGHxETO74wN+3
        h5Oo/6LvJL/5k0ygNRPfp9p2i4iR83kz
X-Google-Smtp-Source: ABdhPJzS86peoZljfp47qbw+FvGX+MGtXWrIz+ZRaWfNVukgk5qwMaShTaAD4ktnHLowYYL7S+2xnEPktOo9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:245:160a:d9eb:a3dc])
 (user=irogers job=sendgmr) by 2002:a25:5205:: with SMTP id
 g5mr180791ybb.292.1631314680039; Fri, 10 Sep 2021 15:58:00 -0700 (PDT)
Date:   Fri, 10 Sep 2021 15:57:56 -0700
Message-Id: <20210910225756.729087-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH] perf tools: Add an option to build without libbfd
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tony Garnock-Jones <tonyg@leastfixedpoint.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some distributions, like debian, don't link perf with libbfd. Add a
build flag to make this configuration buildable and testable.
This was inspired by:
https://lore.kernel.org/linux-perf-users/20210910102307.2055484-1-tonyg@leastfixedpoint.com/T/#u

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 47 ++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b66cf128cbc7..446180401e26 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -827,33 +827,36 @@ else
   endif
 endif
 
-ifeq ($(feature-libbfd), 1)
-  EXTLIBS += -lbfd -lopcodes
-else
-  # we are on a system that requires -liberty and (maybe) -lz
-  # to link against -lbfd; test each case individually here
-
-  # call all detections now so we get correct
-  # status in VF output
-  $(call feature_check,libbfd-liberty)
-  $(call feature_check,libbfd-liberty-z)
 
-  ifeq ($(feature-libbfd-liberty), 1)
-    EXTLIBS += -lbfd -lopcodes -liberty
-    FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -ldl
+ifndef NO_LIBBFD
+  ifeq ($(feature-libbfd), 1)
+    EXTLIBS += -lbfd -lopcodes
   else
-    ifeq ($(feature-libbfd-liberty-z), 1)
-      EXTLIBS += -lbfd -lopcodes -liberty -lz
-      FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -lz -ldl
+    # we are on a system that requires -liberty and (maybe) -lz
+    # to link against -lbfd; test each case individually here
+
+    # call all detections now so we get correct
+    # status in VF output
+    $(call feature_check,libbfd-liberty)
+    $(call feature_check,libbfd-liberty-z)
+
+    ifeq ($(feature-libbfd-liberty), 1)
+      EXTLIBS += -lbfd -lopcodes -liberty
+      FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -ldl
+    else
+      ifeq ($(feature-libbfd-liberty-z), 1)
+        EXTLIBS += -lbfd -lopcodes -liberty -lz
+        FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -lz -ldl
+      endif
     endif
+    $(call feature_check,disassembler-four-args)
   endif
-  $(call feature_check,disassembler-four-args)
-endif
 
-ifeq ($(feature-libbfd-buildid), 1)
-  CFLAGS += -DHAVE_LIBBFD_BUILDID_SUPPORT
-else
-  msg := $(warning Old version of libbfd/binutils things like PE executable profiling will not be available);
+  ifeq ($(feature-libbfd-buildid), 1)
+    CFLAGS += -DHAVE_LIBBFD_BUILDID_SUPPORT
+  else
+    msg := $(warning Old version of libbfd/binutils things like PE executable profiling will not be available);
+  endif
 endif
 
 ifdef NO_DEMANGLE
-- 
2.33.0.309.g3052b89438-goog

