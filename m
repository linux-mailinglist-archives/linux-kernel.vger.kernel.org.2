Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC6839EEFB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 08:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhFHGxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 02:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhFHGxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 02:53:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02C9C061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 23:51:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s8-20020a5b04480000b029049fb35700b9so25980157ybp.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 23:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+mHueS6XQQ0bYEG0FWWm1sQjelvw0uwp+bumwTE9gIs=;
        b=KtTTr7yH4H5Yn0j6hAC+HMJslKwB+AsVe2tnb8mAgNv0IXH56AIZO9EHiley8kl+Tu
         tkrIv1yunuVjoY6tscrY2PzSraaYV31/69Yl4oyifHWfOEZolwCDbDHhmaIJtMs+p8T4
         6kjvV2/7R6HNdXhts3Bej6q1gLCuYUOuOCwXzL2rW3cyf38f2HPn5UnQj1T8+tyqIMVN
         glpF/NTfvYNdpXzB14yfLIfiSkQMxW7NA8F8yPtkmt+thHaDXbzNz6wvi9ATOZylNR53
         p8HRHQlC67MfiBYm3Ptu2vHAlcGuX7nLvlknaQK41OtWghJ4TK3maSUajQLkKHxSyYFI
         ycJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+mHueS6XQQ0bYEG0FWWm1sQjelvw0uwp+bumwTE9gIs=;
        b=Uqaq4nOmW8wOJdgPtjozAUPPmTBXGOFE2OQTTYg1wo38o983VsXx/mR7UhUXi6VccU
         xaump2wiUdPNLCfZKia89dL+YLClpReYUXwMzniR68DlaCWrF0CCkvc+e07XOtdkDZ/h
         iWV/GxP7UGVm2Lnr20Jt+PqZFDHHDlOSjo3V8t84gz1flH28zsUs866Kbx+2b271SQO7
         SaAmOAf0AknfIzRriuVpmsVZzaeVJL3TwpCcPBNPB5Q/d52lCKAnzRL+z5R88wyVX+g1
         A0idnycRMlai+QnXcrK/rfq8lth76fyFIIC3+urhx9XxjMBhbZ9oFk5DLLvTcyQzesRP
         ow4w==
X-Gm-Message-State: AOAM533P+K0MgCqRHvO8SovMX1Xu22ONQEuwTyjU4PGcRWyC26MCKewC
        FaV0r3FVJsvLlqq1VjQrJ1dq0BxWNdrWmQ==
X-Google-Smtp-Source: ABdhPJzRmlSprcaFk7V319oNoQf7/v+DbzaXNgalr0FDTksLpqxZT6bcFh3qn8dfZfsY5XYvz5U6I75NdlA+ug==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:868:b4e3:8c14:177d])
 (user=davidgow job=sendgmr) by 2002:a25:1455:: with SMTP id
 82mr29369098ybu.403.1623135075148; Mon, 07 Jun 2021 23:51:15 -0700 (PDT)
Date:   Mon,  7 Jun 2021 23:51:11 -0700
In-Reply-To: <20210608064852.609327-1-davidgow@google.com>
Message-Id: <20210608065111.610297-1-davidgow@google.com>
Mime-Version: 1.0
References: <20210608064852.609327-1-davidgow@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 3/4] kunit: test: Add example tests which are always skipped
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two new tests to the example test suite, both of which are always
skipped. This is used as an example for how to write tests which are
skipped, and to demonstrate the difference between kunit_skip() and
kunit_mark_skipped().

Note that these tests are enabled by default, so a default run of KUnit
will have two skipped tests.

Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
---
 lib/kunit/kunit-example-test.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index be1164ecc476..51099b0ca29c 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -40,6 +40,35 @@ static int example_test_init(struct kunit *test)
 	return 0;
 }
 
+/*
+ * This test should always be skipped.
+ */
+static void example_skip_test(struct kunit *test)
+{
+	/* This line should run */
+	kunit_info(test, "You should not see a line below.");
+
+	/* Skip (and abort) the test */
+	kunit_skip(test, "this test should be skipped");
+
+	/* This line should not execute */
+	KUNIT_FAIL(test, "You should not see this line.");
+}
+
+/*
+ * This test should always be marked skipped.
+ */
+static void example_mark_skipped_test(struct kunit *test)
+{
+	/* This line should run */
+	kunit_info(test, "You should see a line below.");
+
+	/* Skip (but do not abort) the test */
+	kunit_mark_skipped(test, "this test should be skipped");
+
+	/* This line should run */
+	kunit_info(test, "You should see this line.");
+}
 /*
  * Here we make a list of all the test cases we want to add to the test suite
  * below.
@@ -52,6 +81,8 @@ static struct kunit_case example_test_cases[] = {
 	 * test suite.
 	 */
 	KUNIT_CASE(example_simple_test),
+	KUNIT_CASE(example_skip_test),
+	KUNIT_CASE(example_mark_skipped_test),
 	{}
 };
 
-- 
2.32.0.rc1.229.g3e70b5a671-goog

