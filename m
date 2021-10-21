Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FAE435ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 08:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhJUGa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 02:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhJUGap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 02:30:45 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32FFC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 23:28:29 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id o22-20020ac85a56000000b002a7c1634c55so3837372qta.21
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 23:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2Bw0oJWyLIy8gqKZ5/OEeCDpWLo7HHi7UvaPnMLR7o4=;
        b=NJA3lzAaCLGv5YGqXi7DaRmNFPAK809xrGGdEbJmPwpbU7ydm+34dgSqhqQhxrG14z
         eIwZnp5vLqhM7zhgMdfV1V/ww8nWNut2OyTqr5O1SSirwtpqkBO8OhBK9qzCBoY0gtGN
         XJWkOgu1p51bP9GPzmz6a8sd6dxa2KPLT3h8tquGxEx5sdiWvhkAPbkBGBtgnz5gI+6D
         ZS0J16thvs11qoma51KZx6FzOzfJEE5xBcjIcgr/ZWxKKwDTZajva41Rx4UBfYfsWaZI
         uTIMspQ38PvoSSUEG5+ias05UlxhjRYclALt8GpLQDDMIdML5AioVtOhTUh/2qLQdyCR
         hMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2Bw0oJWyLIy8gqKZ5/OEeCDpWLo7HHi7UvaPnMLR7o4=;
        b=qoroJI8RjIZ5ZgTNnd8GjZIRpcplu5hBYV3pCKtZtWPlAeDLaNfzza3Cx4+BGWtZPU
         gZ0ePscu9AeQK4rqngTuHQgehClhWXzjOkQmiDyTkwAUEEOfy3y2L42MTYCajvcf/ovo
         SxvRGroR/CNrDb/Gh4bEZDJuGOLlgX9hgnVz219tHPpn9o8Mm1qiwoSVFx4xnlIUoJmv
         0PF/+7N+fQxiK77RSnRFOtbP2uPM+coH7ajyChlOUl3A1bCog6wxdE2oKZim2KQeodaC
         wGlKDjGaQaeWmsq6Z1ke+6uFHIn3QZq6HUaujpkdaSz2zMAQ3LQSOhNpsFhgT5H3d244
         /Jew==
X-Gm-Message-State: AOAM5303zTcBWZGZua29ggBp68hLmbDMzH/wcOqenSJ5I0/afuIPhajT
        Yng4ofoscnNgMOxs06fDX7fMgBJ9HPBiXw==
X-Google-Smtp-Source: ABdhPJzx63aAumbS3i7RouTbrcfOq504XIijU/AfzVhOXWNLEuszTvEPkC70xldrbniKYPGl7qZD59WCKrx7kw==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:1200:8c8:2819:6ab9])
 (user=davidgow job=sendgmr) by 2002:a25:24c1:: with SMTP id
 k184mr4238705ybk.2.1634797708963; Wed, 20 Oct 2021 23:28:28 -0700 (PDT)
Date:   Wed, 20 Oct 2021 23:28:19 -0700
In-Reply-To: <20211021062819.1313964-1-davidgow@google.com>
Message-Id: <20211021062819.1313964-2-davidgow@google.com>
Mime-Version: 1.0
References: <20211021062819.1313964-1-davidgow@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH 2/2] kunit: Report test parameter results as (K)TAP subtests
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

Note that this was previously posted as:
https://lore.kernel.org/all/20211006071112.2206942-1-davidgow@google.com/

No changes have been made, save for a trivial rebase on the current
kselftest/kunit branch.

 lib/kunit/test.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 3bd741e50a2d..85265f9a66a1 100644
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
2.33.0.1079.g6e70778dc9-goog

