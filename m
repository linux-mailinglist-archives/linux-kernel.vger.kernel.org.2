Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7842144286A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhKBHdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhKBHdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:33:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A679AC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 00:30:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v7-20020a25ab87000000b005c2130838beso15112297ybi.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 00:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ccic3rr4mdoxbdec06AcmZnoBxRewK3GJUdYuoNnen4=;
        b=D1CekfftDJe+rtDY9HWYJwucEzP5l6K0C+HneWxHOD3zepmQR/GMV0yegg0KuY31Ji
         GQXdWGwrGqstc0vOw6oclM/e2Xex53BWfvqSC3qZu13RsITXL2u30USINCOctSICRnX/
         Cl/U8dMEvnAexLUEOQAPjxc6Tv3oI4UOkyqFNzC+FcnjUbZeP4/HE/Pr9Hq9YwRE3Jtt
         IkEP9N2Km/wgmhb+F/FZgss/x1hI1+e/kZzUAjKMRIDZW2WeuAZGWc/VCgjNXajEhOiF
         HOfzefb36NHsYW/KrKomnusQE9KBx+NcWAwlQb5Z1rwNWDJmkvrZ59Pes+sfYyGYu5Ia
         DJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ccic3rr4mdoxbdec06AcmZnoBxRewK3GJUdYuoNnen4=;
        b=5fLS6W3kZs0GX+dOV7bmZiXM6DohBzAjrYmHxnTQyWSQ7+SYc4IxYawI4tYOXzyCX7
         jbY8FNVv3dmWmfMk1RzUf7esHzbXBNpbZToqZjKNtSBlCc8QUJeWkx74XtpoLXLisy5V
         MaVji03AixzNGbiQUr9Gc6KqFkMoCi1a176nSVwX5RM1LX4tumXUsuAQeJhiA8/f8qUo
         1kyyV5pmBSO3DzDBQteSbMJuPF+Mjnn3omgM2nk4FggduuF0dcWFcEJJ+T+EBnJ98Kds
         DFHek028XS+jt76hIOr55qw6IPXhM5SwRjw06gWFQ1ntDEZck8iZkz26vrdt8oB93Vcu
         Q/rA==
X-Gm-Message-State: AOAM5332kTKJ+P4kjvjozyB6mk65/cOR01pUDNaWJFsIOfi+cQhMei5i
        1Gf4xQsGcURP3JoZvzKSdvNpzKpKvG2Gww==
X-Google-Smtp-Source: ABdhPJy1s2Yko/ka6XxoOb8uiAt2VfEYKhvlH9ZvKrjTWRKBwfamluyKBPgySQrqEVYvpT0H6OaQioq+vPtKwg==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:524f:74d8:b474:2517])
 (user=davidgow job=sendgmr) by 2002:a25:cc07:: with SMTP id
 l7mr26331915ybf.313.1635838226959; Tue, 02 Nov 2021 00:30:26 -0700 (PDT)
Date:   Tue,  2 Nov 2021 00:30:14 -0700
In-Reply-To: <20211102073014.2901870-1-davidgow@google.com>
Message-Id: <20211102073014.2901870-4-davidgow@google.com>
Mime-Version: 1.0
References: <20211102073014.2901870-1-davidgow@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v4 4/4] kunit: Report test parameter results as (K)TAP subtests
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

Currently, the results for individial parameters in a parameterised test
are simply output as (K)TAP diagnostic lines.

As kunit_tool now supports nested subtests, report each parameter as its
own subtest.

For example, here's what the output now looks like:
	# Subtest: inode_test_xtimestamp_decoding
	ok 1 - 1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits
	ok 2 - 1969-12-31 Upper bound of 32bit < 0 timestamp, no extra bits
	ok 3 - 1970-01-01 Lower bound of 32bit >=0 timestamp, no extra bits
	ok 4 - 2038-01-19 Upper bound of 32bit >=0 timestamp, no extra bits
	ok 5 - 2038-01-19 Lower bound of 32bit <0 timestamp, lo extra sec bit on
	ok 6 - 2106-02-07 Upper bound of 32bit <0 timestamp, lo extra sec bit on
	ok 7 - 2106-02-07 Lower bound of 32bit >=0 timestamp, lo extra sec bit on
	ok 8 - 2174-02-25 Upper bound of 32bit >=0 timestamp, lo extra sec bit on
	ok 9 - 2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit on
	ok 10 - 2242-03-16 Upper bound of 32bit <0 timestamp, hi extra sec bit on
	ok 11 - 2242-03-16 Lower bound of 32bit >=0 timestamp, hi extra sec bit on
	ok 12 - 2310-04-04 Upper bound of 32bit >=0 timestamp, hi extra sec bit on
	ok 13 - 2310-04-04 Upper bound of 32bit>=0 timestamp, hi extra sec bit 1. 1 ns
	ok 14 - 2378-04-22 Lower bound of 32bit>= timestamp. Extra sec bits 1. Max ns
	ok 15 - 2378-04-22 Lower bound of 32bit >=0 timestamp. All extra sec bits on
	ok 16 - 2446-05-10 Upper bound of 32bit >=0 timestamp. All extra sec bits on
	# inode_test_xtimestamp_decoding: pass:16 fail:0 skip:0 total:16
	ok 1 - inode_test_xtimestamp_decoding

Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
---

Changes since v3:
https://lore.kernel.org/linux-kselftest/20211028064154.2301049-4-davidgow@google.com/
- Fix the missing log line which ended up in patch 3 by mistake.

Changes since v2:
https://lore.kernel.org/linux-kselftest/20211027013702.2039566-4-davidgow@google.com/
- No changes to this patch.


 lib/kunit/test.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index f96498ede2cc..c7ed4aabec04 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -512,6 +512,8 @@ int kunit_run_tests(struct kunit_suite *suite)
 			/* Get initial param. */
 			param_desc[0] = '\0';
 			test.param_value = test_case->generate_params(NULL, param_desc);
+			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
+				  "# Subtest: %s", test_case->name);
 
 			while (test.param_value) {
 				kunit_run_case_catch_errors(suite, test_case, &test);
@@ -522,9 +524,8 @@ int kunit_run_tests(struct kunit_suite *suite)
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
2.33.1.1089.g2158813163f-goog

