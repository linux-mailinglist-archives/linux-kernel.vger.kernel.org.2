Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607D239B200
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 07:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhFDF2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 01:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhFDF2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 01:28:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD03C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 22:26:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d6-20020a2568060000b0290535b52251cfso10172529ybc.18
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 22:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BmX2qAurH2kKXteL0ga3zN+hRpRwUJBvctVU87eAUVg=;
        b=ZqKBGRs5COtCI7jwHZPu5ic7cA1dWCcAo/mI9UZkSMb0/cfQvRqcJ9YomlMkb52Vfg
         vNKn9wV5maTnrxYTynB70FIRz+qK8GWNlM6k0OtW7CIcQhymiTv9HGjlTbk8KkuJnrQj
         i/ioR/dpT/5fKAkOL51VUviSkbQHlb/6qLkdK+7jXQx6Q7xLQF5jeOdy6+aAxv/0yZeQ
         W8aOaA2OA/nBK1o1KfCb/aKpyjgU8in27YliQtSBpT45ovV214/aG9c/pnpTabCVaLMr
         i4P++LgiYAJf4sIMeIgywq9TJqMZ2JfywBPl7+BDmanL6apDtYD75plWN4tntqxgiWLW
         9YMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BmX2qAurH2kKXteL0ga3zN+hRpRwUJBvctVU87eAUVg=;
        b=HzivRqb9OlFMQRybRKSHtyKwA4QXI1g8+1DbsTrYLVnrqoX8EagNzY01WNew3YVyjU
         gYzjpY1mEoaO5u3niZzqIEKuMGpDCVIhChvIb8oUyjdeLkQNRFK5XTJuQ0QHMROVIH1T
         FfkqQwuq9XpaR3GXXOLKz0LqOgPzxIc4Wr0DnyhwhqgPe+RRYOoq8uwm9hGZlwbPwAoG
         svektwxuA5B12xB7TDlOVbLYyZP/ZCdD56SgSyTD6Kh7yMae/ctopRunVjEuXOA6KfNJ
         6E/mgbfolvIWlIlPQCRWedZI7W2hWnWT1iGnb/3iUodDRGoV0POAfXH5jxO2wBuWHr0I
         lKBg==
X-Gm-Message-State: AOAM531+AJqyAeJTGNs6N2Nx8o3ofagD1+Jo1sB4WLoLvi5NDF3KZk17
        A97/U5xDCX0P9csTwuGyTTGwy2jmtA5LVw==
X-Google-Smtp-Source: ABdhPJw+Kr8c4pPwWG/RdqmPmT4XG9H+zkW0bC7DFmNbCOVbRND3fXFB9pTfjKIHZm+Mikgmk2YPg3y4vgT1gg==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:66ad:9d8a:27f0:46ba])
 (user=davidgow job=sendgmr) by 2002:a25:ac9d:: with SMTP id
 x29mr2692093ybi.369.1622784361599; Thu, 03 Jun 2021 22:26:01 -0700 (PDT)
Date:   Thu,  3 Jun 2021 22:25:48 -0700
Message-Id: <20210604052548.1889909-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH] kasan: test: Improve failure message in KUNIT_EXPECT_KASAN_FAIL()
From:   David Gow <davidgow@google.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Daniel Axtens <dja@axtens.net>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     David Gow <davidgow@google.com>, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KUNIT_EXPECT_KASAN_FAIL() macro currently uses KUNIT_EXPECT_EQ() to
compare fail_data.report_expected and fail_data.report_found. This
always gave a somewhat useless error message on failure, but the
addition of extra compile-time checking with READ_ONCE() has caused it
to get much longer, and be truncated before anything useful is displayed.

Instead, just check fail_data.report_found by hand (we've just test
report_expected to 'true'), and print a better failure message with
KUNIT_FAIL()

Beforehand, a failure in:
KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)area)[3100]);
would looked like:
[22:00:34] [FAILED] vmalloc_oob
[22:00:34]     # vmalloc_oob: EXPECTATION FAILED at lib/test_kasan.c:991
[22:00:34]     Expected ({ do { extern void __compiletime_assert_705(void) __attribute__((__error__("Unsupported access size for {READ,WRITE}_ONCE()."))); if (!((sizeof(fail_data.report_expected) == sizeof(char) || sizeof(fail_data.repp
[22:00:34]     not ok 45 - vmalloc_oob

With this change, it instead looks like:
[22:04:04] [FAILED] vmalloc_oob
[22:04:04]     # vmalloc_oob: EXPECTATION FAILED at lib/test_kasan.c:993
[22:04:04]     KASAN failure expected in "((volatile char *)area)[3100]", but none occurred
[22:04:04]     not ok 45 - vmalloc_oob

Signed-off-by: David Gow <davidgow@google.com>
---

Stumbled across this because the vmalloc_oob test is failing (i.e.,
KASAN isn't picking up an error) under qemu on my system, and the
message above was horrifying. (I'll file a Bugzilla bug for the test
failure today.)

Cheers,
-- David

 lib/test_kasan.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index cacbbbdef768..deda13c9d9ff 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -98,9 +98,11 @@ static void kasan_test_exit(struct kunit *test)
 	barrier();							\
 	expression;							\
 	barrier();							\
-	KUNIT_EXPECT_EQ(test,						\
-			READ_ONCE(fail_data.report_expected),		\
-			READ_ONCE(fail_data.report_found));		\
+	if (READ_ONCE(fail_data.report_found) == false) {		\
+		KUNIT_FAIL(test, KUNIT_SUBTEST_INDENT "KASAN failure "	\
+				"expected in \"" #expression		\
+				 "\", but none occurred");		\
+	}								\
 	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS)) {				\
 		if (READ_ONCE(fail_data.report_found))			\
 			kasan_enable_tagging_sync();			\
-- 
2.32.0.rc1.229.g3e70b5a671-goog

