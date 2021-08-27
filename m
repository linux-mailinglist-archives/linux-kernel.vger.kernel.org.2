Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F8F3FA1A7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 00:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhH0W7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 18:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbhH0W7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 18:59:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDF3C0617A8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 15:58:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z8-20020a25ad88000000b0059a94ada16fso8094285ybi.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 15:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1vVn3tT4i3E1FmbURQDOaSj4WaBWIdDZC/BLf0YptVo=;
        b=amWWbC4Vd2VlctVqbhne1QKiw4B3hrhIb4FhT4FizxwTOMAgV7eULVijyk+3PVUZl3
         geP+wc1VfDExeq9hMedHt+dEh8yCqxDeOaW+DXQZrfa2fD8iAA5ShrKgwVHVfiphOFb+
         EVX35GpTlIEEXY1HpFuFxtjIu1U8RKscpyj/neSEFUl6c6hk1Y09chRFSMFTMfZA33n1
         Skvd0ELdhLLh3HdLm1LIPVcowumewcyvU+a0IwiifnBmwV8ZVLpMh2w52HxVrXmdihuv
         GFaZm9dRvZJLcYOK24g/OXezZs1BUTjAzokqRGTgfZiAQdg7l/dDR1iLW4liR30WRvc+
         sqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1vVn3tT4i3E1FmbURQDOaSj4WaBWIdDZC/BLf0YptVo=;
        b=hfybmoUMDmcw4ta1dPTnmr/52jQKaJoYCi6SxScW4C6yX9EEKbwBUPZPg8Lxw8ySYp
         8HRZB3wQBZlaj6oVzFYC5MzwY4/zRPZfpbNqnUQ1ggFFPVxVRlooZLj7MR1s7UjF0KQV
         Hm0K/aQXG/meLog4xy/S+Qoa/zS+km/drqnCus0nSue3PMTF2TXceTCrEDdCTVzWJlOz
         2lPp/uZqwy4yl1hGqZtXJ1DUg3NycclBF65QCyjFVMROY+1bctm3odaCzGDbY8YCtlZf
         CTQEixqk8hB2BeoSCbLIFtkAH+PDlg5zW1Pxx2eV6aTcSXOCzo1qvITZfWurBBgXiTto
         v27w==
X-Gm-Message-State: AOAM533NlU2v4vlmHzyeQZs08SQhyWQ28q8gakSn0swZ8jk/CxasuQlG
        YZ9hLCrheYAlC+B1FJtGSQiZt8hJ2w==
X-Google-Smtp-Source: ABdhPJxYJKi9TruSA6ySOacyal37q2p6g1uxh23QfUPvKU++OzDjQwdfE9PbLpLJFBQ5IRxHcLJ5qGpmJA==
X-Received: from sunrae.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2814])
 (user=rmoar job=sendgmr) by 2002:a25:b810:: with SMTP id v16mr8723586ybj.357.1630105108003;
 Fri, 27 Aug 2021 15:58:28 -0700 (PDT)
Date:   Fri, 27 Aug 2021 22:58:12 +0000
In-Reply-To: <20210827225812.3247919-1-rmoar@google.com>
Message-Id: <20210827225812.3247919-3-rmoar@google.com>
Mime-Version: 1.0
References: <20210827225812.3247919-1-rmoar@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH 2/2] Revert "selftests: Remove KSFT_TAP_LEVEL"
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com,
        dlatypov@google.com, keescook@chromium.org, shuah@kernel.org
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit f41c322f17ec4aa809222dc352439d80862c175b:
https://lore.kernel.org/linux-kselftest/20190424231236.aWGsEs-_2b6p3DpN3b_4U1xGERmHSv45uBzgjf6RIRk@z/

This patch removes nested TAP headers in kselftets TAP results and is part
of a series to alter the format of kselftest TAP results to improve
compatibility with proposed KTAP specification
(https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/).

Signed-off-by: Rae Moar <rmoar@google.com>
Change-Id: I24e74cacfc49a90a068eb30ee1448c097de5297d
---
 tools/testing/selftests/Makefile            | 6 ++++++
 tools/testing/selftests/kselftest/runner.sh | 1 +
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index fb010a35d61a..3bbfb83e2252 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -122,6 +122,12 @@ else
 	endif
 endif
 
+# KSFT_TAP_LEVEL is used from KSFT framework to prevent nested TAP header
+# printing from tests. Applicable to run_tests case where run_tests adds
+# TAP header prior running tests and when a test program invokes another
+# with system() call. Export it here to cover override RUN_TESTS defines.
+export KSFT_TAP_LEVEL=`echo 1`
+
 # Prepare for headers install
 top_srcdir ?= ../../..
 include $(top_srcdir)/scripts/subarch.include
diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 9b04aeb26d3a..40ce901cb38d 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 # Runs a set of tests in a given subdirectory.
+export KSFT_TAP_LEVEL=1
 export skip_rc=4
 export timeout_rc=124
 export logfile=/dev/stdout
-- 
2.33.0.259.gc128427fd7-goog

