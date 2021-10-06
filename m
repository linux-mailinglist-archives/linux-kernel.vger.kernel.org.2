Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4B0423895
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 09:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbhJFHNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 03:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237360AbhJFHNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 03:13:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0398AC06174E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 00:11:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i21-20020a253b15000000b005b9c0fbba45so2143664yba.20
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 00:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KqCz8rmAPHNlo9jygUp6wJq6jLhH/2KGA1PQoWPEYJg=;
        b=M6xeyqf0h0PU+i7lWX9sJTiu9LgLZoq9gNZUugb2dJqy1ivjrj3eQomCL63nyv22YJ
         grnoUQPriNY8B6dqz0ha/OtimNRIKCOvPtJ+RQLDQpD6/Z/tC5f6P6kyfm9xgmwo1mqU
         ypDVew/+NncdWz+nDbQwaTVXzFj+AVN7ECorm0+keiW0/ZrtrvEWir44CFntHkns1r/A
         tu0J9wa1eILyo8CngjG8LLFLPb9r8xmP7lWXHA0M0ieFtEOBKbDhCicUDV6kpa7Pgw3W
         /LjzbX8HFKgv1/fT4bqb/nEuRW+Igtu0LdcSTOZgjQjlw3ZwbVNHbmQ9fISSl/hyrdSD
         2o/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KqCz8rmAPHNlo9jygUp6wJq6jLhH/2KGA1PQoWPEYJg=;
        b=RyS7X+oG4p16y1k6m8tQcUq818/xP+LWoK95XGY+CO4k1n6IRhA5cwqNRA0lGr3Og9
         bf0fqr+OW35Vb44SIO5/5rKFU0EUPsrv4Phm8KMNQ3v1Sx5Atq79G2oNAkq0vRcG63bv
         Kz7BOQpWVi0OkBfQKFaAMAjDecPY4xDqiAHyZisEQJc9pzo1/qxO9CRP2Pfrra52ZLGk
         6VTI6uvsu5ivSywKbFrmwXWQvxG2fI7gNFmOlFhhc4Oh0tOzXgD13g3uw0IHX8w3JSrU
         mDrMKyzLJMqOhNm/8S+DMPA1aem0Kk05i2IPgWlVlckrnnesA5SwSaj2XabSslOH3KgA
         T39Q==
X-Gm-Message-State: AOAM5310aH8AwAohpA0JdG2FfVxWZndDNYhnAlCcGldXN41rHTi+lvzI
        6ZZXtlzG7f0NvI37dSHslsCF4/EWlJ+JaQ==
X-Google-Smtp-Source: ABdhPJxcs1bbjnLuIj8fc8oCeQr2FUV7k3S5dFxRVt2dKtAMVRR3ZSARTn0yJKgWDe5n6ZTFGPGcHjUf1Eg7Aw==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:cc0e:cc10:4a79:f2b])
 (user=davidgow job=sendgmr) by 2002:a25:d258:: with SMTP id
 j85mr29360761ybg.398.1633504287187; Wed, 06 Oct 2021 00:11:27 -0700 (PDT)
Date:   Wed,  6 Oct 2021 00:11:12 -0700
Message-Id: <20211006071112.2206942-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH] kunit: Report test parameter results as (K)TAP subtests
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmr167@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the results for individial parameters in a parameterised test
are simply output as (K)TAP diagnostic lines. However, the plan was
always[1] to make these (K)TAP subtests when kunit_tool supported them.

With [2], these are now supported. (v5 will print out an error about the
missing plan line, but this can safely be ignored, and will hopefully be
changed). As a result, individual test parameter results are parsed,
displayed in the formatted results, and counted for test statistics.

[1]: https://lore.kernel.org/linux-kselftest/CABVgOSnJAgWvTTABaF082LuYjAoAWzrBsyu9sT7x4GGMVsOD6Q@mail.gmail.com/
[2]: https://lore.kernel.org/linux-kselftest/20211006001447.20919-1-dlatypov@google.com/

Signed-off-by: David Gow <davidgow@google.com>
---
 lib/kunit/test.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index f246b847024e..02a9fdadcae2 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -508,6 +508,8 @@ int kunit_run_tests(struct kunit_suite *suite)
 			/* Get initial param. */
 			param_desc[0] = '\0';
 			test.param_value = test_case->generate_params(NULL, param_desc);
+			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
+				  "# Subtest: %s", test_case->name);
 		}
 
 		do {
@@ -520,9 +522,8 @@ int kunit_run_tests(struct kunit_suite *suite)
 				}
 
 				kunit_log(KERN_INFO, &test,
-					  KUNIT_SUBTEST_INDENT
-					  "# %s: %s %d - %s",
-					  test_case->name,
+					  KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
+					  "%s %d - %s",
 					  kunit_status_to_ok_not_ok(test.status),
 					  test.param_index + 1, param_desc);
 
-- 
2.33.0.800.g4c38ced690-goog

