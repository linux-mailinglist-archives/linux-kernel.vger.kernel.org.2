Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1461A3083D9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 03:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhA2C1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 21:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhA2C1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 21:27:02 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA914C061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 18:26:21 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id l22so5244131pgc.15
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 18:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=n3QVZYbaEx1QKdrzKhOcsuU1Ip5WeKqlPvcQlaoeg8I=;
        b=euGrgs0CUuqbIHzAAmFTp2DUiY+nm+pM8LN/Ja06cfp3gv00FZAsNlrwgPBNOqF2nF
         5W/b8Th+7C0H4vS69d9QB6xbyO/1xE5YeAME5XhbEvV6eeRFbzcmvPNtOH/u3ZUrCG9n
         DfGc4rEx7MxRhOn5NXiEPXlUlgR+jpg4cPpkKrFtdXlk2IzS7Xj8q2NWvSLJ04whWf7G
         kic+agXZ+NimDZcNciwZ891bp7GdMhy8JYIz4eZOK7WKrxBuGHKvMacALsxtNYHoKw3w
         exS+6Hgg+/4atlhNFQq02Du1fVDp26cgZSXnsmFy+nxsJKUPV1KSQRBIzX3tV2yuWZoN
         YSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=n3QVZYbaEx1QKdrzKhOcsuU1Ip5WeKqlPvcQlaoeg8I=;
        b=Nu4GbZTPiE57TZatDUWZH2rWCY69GlHUTHiNwseH9Bc3qEotifTl8FCsXhVjh+Kq2v
         W7kx/GWUr7FkjGBvIhUi1l5QFEk6kobigwV56KhiITyqmcuFv5Jo5MCaSqCjKT1nVcKk
         JJkaE0V7J+hE+39Z6wUjWg7RFGfLKy+GMdC0uJ1WEPjXuZQBIPa397mbqftYRdjcdwIF
         CVBixEVyQAQL48YPxQa/ueecc3FEAytCfakeIStzN6o3F5JGROT6IqYGLxre+Ssvicmh
         OrfnifP2Zbv+EwsSY3DY6tgdkeT6PiYPfreovOMqXcn3u7GtRRhMGOFMTA3xEWutfkuR
         dlXQ==
X-Gm-Message-State: AOAM530NswGCcGxhdVV6VPYj3B7vvqPrj7XVpFAkQmQBDXN1lNJLuWJA
        WPUDPbSI/UDC/8fbYBnt7xhhVTpgOLDoYg==
X-Google-Smtp-Source: ABdhPJxHjauLez7g8rRglPZgCtcgINJsMRH+0R9wZKRiRrX6mTWAKwU/qbA19pr+ZTP4QQeapVedDhvtvJzk5g==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a17:902:a5c6:b029:e0:151c:5a60 with SMTP
 id t6-20020a170902a5c6b02900e0151c5a60mr2236776plq.9.1611887181283; Thu, 28
 Jan 2021 18:26:21 -0800 (PST)
Date:   Thu, 28 Jan 2021 18:25:55 -0800
Message-Id: <20210129022555.2411999-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH] kunit: don't show `1 == 1` in failed assertion messages
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, given something (fairly dystopian) like
> KUNIT_EXPECT_EQ(test, 2 + 2, 5)

KUnit will prints a failure message like this.
>  Expected 2 + 2 == 5, but
>      2 + 2 == 4
>      5 == 5

With this patch, the output just becomes
>  Expected 2 + 2 == 5, but
>      2 + 2 == 4

This patch is slightly hacky, but it's quite common* to compare an
expression to a literal integer value, so this can make KUnit less
chatty in many cases. (This patch also fixes variants like
KUNIT_EXPECT_GT, LE, et al.).

It also allocates an additional string briefly, but given this only
happens on test failures, it doesn't seem too bad a tradeoff.
Also, in most cases it'll realize the lengths are unequal and bail out
before the allocation.

We could save the result of the formatted string to avoid wasting this
extra work, but it felt cleaner to leave it as-is.

Edge case: for something silly and unrealistic like
> KUNIT_EXPECT_EQ(test, 4, 5);

It'll generate this message with a trailing "but"
>  Expected 2 + 2 == 5, but
>  <next line of normal output>

It didn't feel worth adding a check up-front to see if both sides are
literals to handle this better.

*A quick grep suggests 100+ comparisons to an integer literal as the
right hand side.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 lib/kunit/assert.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index 33acdaa28a7d..e0ec7d6fed6f 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -85,6 +85,29 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 }
 EXPORT_SYMBOL_GPL(kunit_ptr_not_err_assert_format);
 
+/* Checks if `text` is a literal representing `value`, e.g. "5" and 5 */
+static bool is_literal(struct kunit *test, const char *text, long long value,
+		       gfp_t gfp)
+{
+	char *buffer;
+	int len;
+	bool ret;
+
+	len = snprintf(NULL, 0, "%lld", value);
+	if (strlen(text) != len)
+		return false;
+
+	buffer = kunit_kmalloc(test, len+1, gfp);
+	if (!buffer)
+		return false;
+
+	snprintf(buffer, len+1, "%lld", value);
+	ret = strncmp(buffer, text, len) == 0;
+
+	kunit_kfree(test, buffer);
+	return ret;
+}
+
 void kunit_binary_assert_format(const struct kunit_assert *assert,
 				struct string_stream *stream)
 {
@@ -97,12 +120,16 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 			  binary_assert->left_text,
 			  binary_assert->operation,
 			  binary_assert->right_text);
-	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld\n",
-			  binary_assert->left_text,
-			  binary_assert->left_value);
-	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld",
-			  binary_assert->right_text,
-			  binary_assert->right_value);
+	if (!is_literal(stream->test, binary_assert->left_text,
+			binary_assert->left_value, stream->gfp))
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld\n",
+				  binary_assert->left_text,
+				  binary_assert->left_value);
+	if (!is_literal(stream->test, binary_assert->right_text,
+			binary_assert->right_value, stream->gfp))
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld",
+				  binary_assert->right_text,
+				  binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_binary_assert_format);

base-commit: e5ff2cb9cf67a542f2ec7fb87e24934c88b32678
-- 
2.30.0.365.g02bc693789-goog

