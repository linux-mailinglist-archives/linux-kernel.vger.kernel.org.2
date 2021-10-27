Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B471343BF1A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 03:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237647AbhJ0Bjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 21:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237610AbhJ0Bjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 21:39:39 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C246AC061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 18:37:14 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id z187-20020a6233c4000000b0047c2090f1abso643816pfz.23
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 18:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zdnP+CcH+cj0gO5XtMfjV6pCIZrG8LN0fjsgBOUCOoc=;
        b=b92pU0ZPZUKilkgCeq0jDth2ifnAa83QiCk+5MfUApUiPVy9/uv1rEJVPOPooi3Ye3
         YfCUuvbWmOHiEC2kiFUgckBwDx8ENqtu1wYm9f8ZZzOF6ZWP2R2VWrtb4/OJA5Qh7kHC
         ockwapbrUmbsiLTmpcJfHXvND0KHLx3uk/mBv9dAkylFjmtjylw30n9ZsqovaSunDOyL
         CC79OcNdjexhtkkPeny6kbLhIxQVyLc1U66yYRui05WVAQJLHWN1ZjSZhaqkKwCfncbx
         al3w5JaVx8c3mYiPY1ySJmX5e6/pHOd69OcroHkmgDbIdSi9ygOfZOtNrWZjNHMBtRxR
         fsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zdnP+CcH+cj0gO5XtMfjV6pCIZrG8LN0fjsgBOUCOoc=;
        b=iAOyYp7Q5s254dGIYnV1Zxt+IzJl2vJkRRqQIAk9mLVejpv+XRjMBUPFc/d4OLlmQm
         9EvvJ9a/D7oacXXHOO2OSun3YqBjPqcSw5GOdTr0ihIZ18Ln/PV/iyhJbynOv5tzZbg8
         MQEQmd3NdJuuuWZeT57dISHgCcMH+AXMzYmbwl48ijm4HHPtUG8r4wrUm3Y2HrM7xQJb
         GxU1c3K5zdo96X2oSqyOYbJ+kfFR0l2Y44fYPGfx8HcZn1i+6qxmTeQSB6cgPIeWFLoj
         fsWq/LxNjePEMDVhlpNTB02DTusoVQH3z73sGhnB3br7Jh6s/IFOSqbf6GunvnEPg5LO
         a9aw==
X-Gm-Message-State: AOAM532EB0MBwCJ+h+u3ExRdaMkAZA3uyut31ZbjfVz/bT6bFX452MEV
        w3u9980PQVNK6+oFFwrdg6VePlcpc1UKrA==
X-Google-Smtp-Source: ABdhPJwg2vr2nzlms3KujpRdCOHHVuWmWK5Bzr5xe8wdyiH+1BuM42b6Pjw14dOKIyYClEOzMDsPm2olcO1xAQ==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:c628:e925:d58d:6232])
 (user=davidgow job=sendgmr) by 2002:a17:902:ed87:b0:141:5fe1:e794 with SMTP
 id e7-20020a170902ed8700b001415fe1e794mr4334276plj.77.1635298634290; Tue, 26
 Oct 2021 18:37:14 -0700 (PDT)
Date:   Tue, 26 Oct 2021 18:37:01 -0700
In-Reply-To: <20211027013702.2039566-1-davidgow@google.com>
Message-Id: <20211027013702.2039566-3-davidgow@google.com>
Mime-Version: 1.0
References: <20211027013702.2039566-1-davidgow@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 3/4] kunit: Don't crash if no parameters are generated
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmr167@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible that a parameterised test could end up with zero
parameters. At the moment, the test function will nevertheless be called
with NULL as the parameter. Instead, don't try to run the test code, and
just mark the test as SKIPped.

Reported-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---
 lib/kunit/test.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 3bd741e50a2d..e028d98e4f5b 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -500,7 +500,10 @@ int kunit_run_tests(struct kunit_suite *suite)
 	kunit_print_subtest_start(suite);
 
 	kunit_suite_for_each_test_case(suite, test_case) {
-		struct kunit test = { .param_value = NULL, .param_index = 0 };
+		/* The initial param value is nonzero, as we want
+		 * non-parametrised tests to run once.
+		 */
+		struct kunit test = { .param_value = (void *)-1, .param_index = 0 };
 		struct kunit_result_stats param_stats = { 0 };
 		test_case->status = KUNIT_SKIPPED;
 
@@ -510,7 +513,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 			test.param_value = test_case->generate_params(NULL, param_desc);
 		}
 
-		do {
+		while (test.param_value) {
 			kunit_run_case_catch_errors(suite, test_case, &test);
 
 			if (test_case->generate_params) {
@@ -530,11 +533,12 @@ int kunit_run_tests(struct kunit_suite *suite)
 				param_desc[0] = '\0';
 				test.param_value = test_case->generate_params(test.param_value, param_desc);
 				test.param_index++;
-			}
+			} else
+				test.param_value = NULL;
 
 			kunit_update_stats(&param_stats, test.status);
 
-		} while (test.param_value);
+		}
 
 		kunit_print_test_stats(&test, param_stats);
 
-- 
2.33.0.1079.g6e70778dc9-goog

