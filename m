Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3BB3FCC33
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239735AbhHaRUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhHaRUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:20:30 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067EBC061760
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:19:35 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 62-20020a3706410000b02903d2cdd9acf0so9819288qkg.21
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dmkOdfcI6U6JDwUvYTzByiIe7Et2CCkWqmfYAB8t7A8=;
        b=Ml7dcq37gQJuyMBrIRF+SqWDEkygN+PXfDuRZsIk3ntCeBt22foD9APomI6rr6CxX3
         ZKteec+wNKmAvAQnLa71p/gjdVmuh7ShSkwwmutFFZacegSnKf6OzEwmYetPuxH8e0nI
         kf9+fdlLbzBJlHOzhV7ota53+5qxuERECQ9PlpJIBOpnX1lDxbBGoMH/VIlU9qTS4lxf
         WWUJgrQDq5Um7bh7nZll/bqFem2VT9iohl/DmDAqDmafJejgdwKQz4yfPsxKWx5wybqv
         ZdgRlJgyyAfCYldUDVApV1q707yGvaXvh2DgCxLe+Dz+YPjenXA7pbeZdh87UYbIxiWW
         Lx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dmkOdfcI6U6JDwUvYTzByiIe7Et2CCkWqmfYAB8t7A8=;
        b=i09v3pjkKuYFtGB5PY6038lEK+x0Y1Ay9CldMVhS4eyxaIRGUUexlZpMuVC22l5k21
         LlYVzRg1Bjvy0vDRjA2hsm/p9vxOlP2s2hY4xSmhUGEX2nqAsuCgFysQX5PBRB8MnbT/
         gpaCd+7qRm2ef10x7U+ahCVUO/kG5T/dK5EQ0EKi0Zqx/s2PkrOcCsjKxKErUQKKOCjz
         uu1utbQShHfUM1t6rtLR+VmD2xl0B0iMovIMPJeLr6rrinKyr035FJrWuoBbPi5gTcro
         jHnxJe0a61eycUwgchyDOs7fuAIEn/+l80nE6f7WFusqHV4glb/v6mPaAyuiQMCKw4PG
         r90w==
X-Gm-Message-State: AOAM531PbIrsKA9P1O9VTTjfYJOm3/oePa/LEPIsP3z5VMqolyTg44V1
        4lv+1ig+XS2F3Lw/wMLMrqnFMzdDz7wyJw==
X-Google-Smtp-Source: ABdhPJyFEMhIUiSB9Ixf8MBWUFnT4sJu0XyS49wBGirVOsYp6NnJCWVeWZ0j7Cg8K1VyPfNHtVLeFMNTiX9ucg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:7ad4:b790:ae28:9a76])
 (user=dlatypov job=sendgmr) by 2002:ad4:5247:: with SMTP id
 s7mr29849422qvq.58.1630430374053; Tue, 31 Aug 2021 10:19:34 -0700 (PDT)
Date:   Tue, 31 Aug 2021 10:19:25 -0700
Message-Id: <20210831171926.3832806-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH v3 1/2] kunit: drop assumption in kunit-log-test about current suite
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This test assumes that the declared kunit_suite object is the exact one
which is being executed, which KUnit will not guarantee [1].

Specifically, `suite->log` is not initialized until a suite object is
executed. So if KUnit makes a copy of the suite and runs that instead,
this test dereferences an invalid pointer and (hopefully) segfaults.

N.B. since we no longer assume this, we can no longer verify that
`suite->log` is *not* allocated during normal execution.

An alternative to this patch that would allow us to test that would
require exposing an API for the current test to get its current suite.
Exposing that for one internal kunit test seems like overkill, and
grants users more footguns (e.g. reusing a test case in multiple suites
and changing behavior based on the suite name, dynamically modifying the
setup/cleanup funcs, storing/reading stuff out of the suite->log, etc.).

[1] In a subsequent patch, KUnit will allow running subsets of test
cases within a suite by making a copy of the suite w/ the filtered test
list. But there are other reasons KUnit might execute a copy, e.g. if it
ever wants to support parallel execution of different suites, recovering
from errors and restarting suites

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 lib/kunit/kunit-test.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index d69efcbed624..555601d17f79 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -415,12 +415,15 @@ static struct kunit_suite kunit_log_test_suite = {
 
 static void kunit_log_test(struct kunit *test)
 {
-	struct kunit_suite *suite = &kunit_log_test_suite;
+	struct kunit_suite suite;
+
+	suite.log = kunit_kzalloc(test, KUNIT_LOG_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
 
 	kunit_log(KERN_INFO, test, "put this in log.");
 	kunit_log(KERN_INFO, test, "this too.");
-	kunit_log(KERN_INFO, suite, "add to suite log.");
-	kunit_log(KERN_INFO, suite, "along with this.");
+	kunit_log(KERN_INFO, &suite, "add to suite log.");
+	kunit_log(KERN_INFO, &suite, "along with this.");
 
 #ifdef CONFIG_KUNIT_DEBUGFS
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
@@ -428,12 +431,11 @@ static void kunit_log_test(struct kunit *test)
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
 				     strstr(test->log, "this too."));
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
-				     strstr(suite->log, "add to suite log."));
+				     strstr(suite.log, "add to suite log."));
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
-				     strstr(suite->log, "along with this."));
+				     strstr(suite.log, "along with this."));
 #else
 	KUNIT_EXPECT_PTR_EQ(test, test->log, (char *)NULL);
-	KUNIT_EXPECT_PTR_EQ(test, suite->log, (char *)NULL);
 #endif
 }
 

base-commit: 9c849ce86e0fa93a218614eac562ace44053d7ce
-- 
2.33.0.259.gc128427fd7-goog

