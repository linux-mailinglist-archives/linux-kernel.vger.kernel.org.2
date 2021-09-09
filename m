Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD36405BCB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 19:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240716AbhIIRMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 13:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbhIIRMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 13:12:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2037C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 10:11:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j9-20020a2581490000b02905897d81c63fso3192660ybm.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 10:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=uy74vWb7x9CjpeXzDF9JGC37Nd1wyF55MqZMbJTR5Wo=;
        b=KMiCfwB1nufAZzfwSVnXzPS82JzQ6fOxWEC4q/O5nQ7bU6Bx5w+WlxaqAclivgSus5
         9fRTE67ONAz6q79HJt9krqocKryGTA6icq1fxyfeQCbEl7MMlLb9/VsxTDw2VZCgjXVy
         bjWt9v0DF2GNZ3V/oH3W8RuMffP0BPf83mgRMhsogXJ9gy3tXO6C0WEOLgTTylju8Vrq
         5UNjDpNIKB77J1x6g/QtmtmozEth0VUpiHQScDl/dJZEKyEuVjMHPLKeedSmLiWSen1A
         sNL2h6S3wzPy7PbxAPU8oSSzRu+GLN4VSFfGM5+Y+xE2g1utwBqIyxBZWl5zuOUViXnK
         w1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=uy74vWb7x9CjpeXzDF9JGC37Nd1wyF55MqZMbJTR5Wo=;
        b=bPj/vI+Qqityw1b5kg8g1HEmhX+3z7TCX74Y9U7tgEosZrjmn9RJEU6XVtbVZ4ovwu
         OtLlUP3/rVRTNDNcdryCmo6oWy9Cyn4TnFig0eDLvLdBlqPsiiyaSzLuWCg3dOh6X22k
         h86dIlgTjj7GKvxCwsB+gvT2m5rGRqqMlvyDa/K+VXE6iQvaEqrGdjFFPF+BFPswwSy0
         He7iaIvVU3KsdgBo2DeP8Is7j45mZgS4XUBjgu57c8q8P2xGAAdFht/PzX7xhDdE+UjM
         0xORiv7Fai46+Km3vQBFMlvJ++zKCXPTXKGc3Ptse+5KM8Gld6jRPh5F+LhLmSOTSyn6
         OjFw==
X-Gm-Message-State: AOAM5302vWCOp1udd5MVqSxFqF5BYhqx17xeIpsTh6FlMUoCMIPvmZtN
        qW/jCxSZ3ci7gpbe4a5lZmolrMRvKSdY8Q==
X-Google-Smtp-Source: ABdhPJz/Qr4KbA9nPcYmGjr5qftwLt6v207+aRKN2ehtwNbyTWlnEO1sGHvMKOcEmYvY61jzJb5z16dBLCm17g==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:d3ed:35f2:f475:fbc1])
 (user=dlatypov job=sendgmr) by 2002:a25:d68e:: with SMTP id
 n136mr5409238ybg.271.1631207461822; Thu, 09 Sep 2021 10:11:01 -0700 (PDT)
Date:   Thu,  9 Sep 2021 10:10:51 -0700
Message-Id: <20210909171052.3192326-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v4 1/2] kunit: drop assumption in kunit-log-test about current suite
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
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
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
 

base-commit: a3fa7a101dcff93791d1b1bdb3affcad1410c8c1
-- 
2.33.0.309.g3052b89438-goog

