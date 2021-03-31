Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29AE6350472
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 18:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhCaQZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 12:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbhCaQZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 12:25:04 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FE5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 09:25:03 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id h12so1555728qvm.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 09:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fCRp+f9oEZRwz2tLs+x5UFPxXT2k+8MTEajLiG543iE=;
        b=E0qHaj7GNQHth1b1XDiydbi3LRxgSyXTRIt30yJXGr4euLVP08l00Kj4vigGox7iJE
         jBzfkUHPMmM/Su9k+GGHog40ud31Bv7dlve/m0FKG2DG23BU8HpQY7gQoCuDsBBRH22B
         CdY5qwoGoXR1W4nKtTgzqNuaICGfR3dR7sgKvCnxFJvoIjsjEd1EHMc0dyRrjwp45/hg
         eGFpOYrqWX68R6j8n91eZ8spafWkdPLPObVCDafOl/6dzjSmjX4vXlrowomC/MCrslIn
         Mp4Z4ggUIY640HII3euetw3kp67GfIyHfYix7mB77RrammP9A2Ssi2oVpQqJPcQQqVnK
         dHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fCRp+f9oEZRwz2tLs+x5UFPxXT2k+8MTEajLiG543iE=;
        b=R7deiy32It/kUs7xfJr1eTDXJBy8SCZvQzg8AnEXkKr+xkPYHOz+IAtGlJOhjuMPH7
         GPBTLz6TF1bhYmA0ZqL98OAvBRA2U7i44xJ8KqGX3Hq1swOAemhzq8/me749oRLu3QRZ
         WVsFR5putYCuqT2Q4zV6bvivOmUNZd9I/o50qIpuXW/WomrY1LO2L2VEv2SPbKV8iaYE
         o2nVqlLIfhD4xtYgJUmlQKnD6HFzi0ncg1+mQY1v+2velwloiRbfVi5po43GyvhHu0Re
         SywwB/pHWm3yyGWjYcZ/cIDNfGZ2SrDuuItFqIra6a0udGGKoHOBDmLlD5yfpG7TX3Zb
         bkRw==
X-Gm-Message-State: AOAM5335RB86V6BSHB6e0enBr6E+IIT9qDHdO7KNuV/EhiJmpdCUwClt
        28AAHODIkw2z6PDOBgrYPj8QovHEKO0Fkvwh
X-Google-Smtp-Source: ABdhPJxJoNO1B+fBvpC9kIudNhGjiUeJQbEm2VvLjUu0bQ1W0X8zAukiVTCaZU+TUNC5zkLU9rn/JCMdUCPaaB5L
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:f189:6e8f:457f:e245])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:16c1:: with SMTP id
 d1mr3810787qvz.29.1617207902660; Wed, 31 Mar 2021 09:25:02 -0700 (PDT)
Date:   Wed, 31 Mar 2021 18:24:59 +0200
Message-Id: <48079c52cc329fbc52f4386996598d58022fb872.1617207873.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH] kasan: detect false-positives in tests
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, KASAN-KUnit tests can check that a particular annotated part
of code causes a KASAN report. However, they do not check that no unwanted
reports happen between the annotated parts.

This patch implements these checks.

It is done by setting report_data.report_found to false in
kasan_test_init() and at the end of KUNIT_EXPECT_KASAN_FAIL() and then
checking that it remains false at the beginning of
KUNIT_EXPECT_KASAN_FAIL() and in kasan_test_exit().

kunit_add_named_resource() call is moved to kasan_test_init(), and the
value of fail_data.report_expected is kept as false in between
KUNIT_EXPECT_KASAN_FAIL() annotations for consistency.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 49 +++++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index d77c45edc7cd..bf9225002a7e 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -54,6 +54,10 @@ static int kasan_test_init(struct kunit *test)
 
 	multishot = kasan_save_enable_multi_shot();
 	kasan_set_tagging_report_once(false);
+	fail_data.report_found = false;
+	fail_data.report_expected = false;
+	kunit_add_named_resource(test, NULL, NULL, &resource,
+					"kasan_data", &fail_data);
 	return 0;
 }
 
@@ -61,6 +65,7 @@ static void kasan_test_exit(struct kunit *test)
 {
 	kasan_set_tagging_report_once(true);
 	kasan_restore_multi_shot(multishot);
+	KUNIT_EXPECT_FALSE(test, fail_data.report_found);
 }
 
 /**
@@ -78,28 +83,30 @@ static void kasan_test_exit(struct kunit *test)
  * fields, it can reorder or optimize away the accesses to those fields.
  * Use READ/WRITE_ONCE() for the accesses and compiler barriers around the
  * expression to prevent that.
+ *
+ * In between KUNIT_EXPECT_KASAN_FAIL checks, fail_data.report_found is kept as
+ * false. This allows detecting KASAN reports that happen outside of the checks
+ * by asserting !fail_data.report_found at the start of KUNIT_EXPECT_KASAN_FAIL
+ * and in kasan_test_exit.
  */
-#define KUNIT_EXPECT_KASAN_FAIL(test, expression) do {		\
-	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS))			\
-		migrate_disable();				\
-	WRITE_ONCE(fail_data.report_expected, true);		\
-	WRITE_ONCE(fail_data.report_found, false);		\
-	kunit_add_named_resource(test,				\
-				NULL,				\
-				NULL,				\
-				&resource,			\
-				"kasan_data", &fail_data);	\
-	barrier();						\
-	expression;						\
-	barrier();						\
-	KUNIT_EXPECT_EQ(test,					\
-			READ_ONCE(fail_data.report_expected),	\
-			READ_ONCE(fail_data.report_found));	\
-	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS)) {			\
-		if (READ_ONCE(fail_data.report_found))		\
-			kasan_enable_tagging();			\
-		migrate_enable();				\
-	}							\
+#define KUNIT_EXPECT_KASAN_FAIL(test, expression) do {			\
+	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS))				\
+		migrate_disable();					\
+	KUNIT_EXPECT_FALSE(test, READ_ONCE(fail_data.report_found));	\
+	WRITE_ONCE(fail_data.report_expected, true);			\
+	barrier();							\
+	expression;							\
+	barrier();							\
+	KUNIT_EXPECT_EQ(test,						\
+			READ_ONCE(fail_data.report_expected),		\
+			READ_ONCE(fail_data.report_found));		\
+	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS)) {				\
+		if (READ_ONCE(fail_data.report_found))			\
+			kasan_enable_tagging();				\
+		migrate_enable();					\
+	}								\
+	WRITE_ONCE(fail_data.report_found, false);			\
+	WRITE_ONCE(fail_data.report_expected, false);			\
 } while (0)
 
 #define KASAN_TEST_NEEDS_CONFIG_ON(test, config) do {			\
-- 
2.31.0.291.g576ba9dcdaf-goog

