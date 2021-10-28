Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8016443DB64
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 08:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhJ1Goo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 02:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhJ1Goi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 02:44:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5616C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 23:42:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x1-20020a25acc1000000b005c1df16c5e9so3754372ybd.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 23:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P9SWEypmTPbKVG7Ig7VoDuxi23ZRLA0e0iWZ35O43SQ=;
        b=XuvBLav4PJf897n1gD6mFbx7dVi4qyYLHwS8nsy3imdYJZ2SMQrqgEszRP8AOk3jnr
         XEoeNC+xM+lcY3q05C1fE8cz2fYaPHBgDdANlc7X5yJI8w3XiSpRY33MvVodt4F+IAVV
         z+E9C6iKX9vysN8hfkU08+APtUeHC6qG+SxC4CZ8hm2ILADMo6DnEYVLE/WenBTjo3Q0
         h1J6ZRSbkIMAiI54N3OBG35x0ZhBjJjpidMeA6sP5zWT6nLippHJicjdm/b6Vfz7n5DY
         eXpQDc/FcPQYP++3vzaoW3buWjj7YMUaTeGLxGD7FT6r1Aut5KWaT8bPoHcZdkWF+vVI
         H6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P9SWEypmTPbKVG7Ig7VoDuxi23ZRLA0e0iWZ35O43SQ=;
        b=HCqCUvIhMzdxFwHV0TC7/rSWUg2SYl6cnk/NbxkW5BRU0wZUIJf0Oo3smdadA2M3BY
         CDYexnRAA7tE+Y7N3WPXrPGChG4zzW9JA2c6tSRf+ue1NmSniRBTclZYYFg7vY9tNIJj
         YiKw2qOjoF+jbP9hiag5n9dLA82r9WNSl14mUuhcPWbUa3kfbd1baJyLAPjfSB+JWUj2
         aE5FGhNKU/KH5YQbaZpigMIpo3siaHCltQiTjb2IKCNlFa7CEruTPSBXLePC4TKGGwgV
         WPQmmg1oN7pmBDX/qnHlBJKhnFQ0mk3HnryF48Y8Q1/9tPkbPdnzoBLDcWu+vBeU25iz
         DrFg==
X-Gm-Message-State: AOAM530JFR5lAIGFelyOhTxJiQhQUjJkiBJwCP05sxp/rhs6bMVTOWTy
        Jz8wkWj78WCEFHWgBSZ0l4KqVEJD2ta0jw==
X-Google-Smtp-Source: ABdhPJyrmo5cPPVA73k/5tdPcCtWy7uigQkPXo9HvkjSfLMjgpehGGaOw4rRFXN41aetORDMdi33RFArVVeCjg==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:d8b1:a4bf:2b6f:92f9])
 (user=davidgow job=sendgmr) by 2002:a25:e406:: with SMTP id
 b6mr2631217ybh.134.1635403331110; Wed, 27 Oct 2021 23:42:11 -0700 (PDT)
Date:   Wed, 27 Oct 2021 23:41:53 -0700
In-Reply-To: <20211028064154.2301049-1-davidgow@google.com>
Message-Id: <20211028064154.2301049-3-davidgow@google.com>
Mime-Version: 1.0
References: <20211028064154.2301049-1-davidgow@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v3 3/4] kunit: Don't crash if no parameters are generated
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

Changes since v2:
https://lore.kernel.org/linux-kselftest/20211027013702.2039566-3-davidgow@google.com/
- Rework to not share the loop between the parameterised and
  non-parameterised test cases.
  - Suggested by Daniel Latypov.
  - Avoids using a magic non-zero pointer value.

 lib/kunit/test.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 3bd741e50a2d..dfe1127aacfd 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -508,12 +508,12 @@ int kunit_run_tests(struct kunit_suite *suite)
 			/* Get initial param. */
 			param_desc[0] = '\0';
 			test.param_value = test_case->generate_params(NULL, param_desc);
-		}
+			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
+				  "# Subtest: %s", test_case->name);
 
-		do {
-			kunit_run_case_catch_errors(suite, test_case, &test);
+			while (test.param_value) {
+				kunit_run_case_catch_errors(suite, test_case, &test);
 
-			if (test_case->generate_params) {
 				if (param_desc[0] == '\0') {
 					snprintf(param_desc, sizeof(param_desc),
 						 "param-%d", test.param_index);
@@ -530,11 +530,15 @@ int kunit_run_tests(struct kunit_suite *suite)
 				param_desc[0] = '\0';
 				test.param_value = test_case->generate_params(test.param_value, param_desc);
 				test.param_index++;
-			}
 
+				kunit_update_stats(&param_stats, test.status);
+			}
+		} else {
+			/* Non-parameterised test. */
+			kunit_run_case_catch_errors(suite, test_case, &test);
 			kunit_update_stats(&param_stats, test.status);
+		}
 
-		} while (test.param_value);
 
 		kunit_print_test_stats(&test, param_stats);
 
-- 
2.33.0.1079.g6e70778dc9-goog

