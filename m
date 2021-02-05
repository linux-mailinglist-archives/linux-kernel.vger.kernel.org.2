Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2CF31192D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 03:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhBFC5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 21:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbhBFCfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:35:00 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64AEC0698C8
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 14:18:15 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w11so3336448ybq.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 14:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=h1P5+j+r2bLJx1bqqHOaKHRT8j4ftFPbzcum8mBY1zk=;
        b=mcx4H+N3Y96PlBfUpR32o2wa1baEWAPMNaY3XlZY1crmU5fmQCozhESwTjOkU/6szQ
         vb3P1crJn0ZXVSEpm3F8yGi8GYTvIwa3fEqWnP+j1RFjwWRZ0I38oZWMqRgSW28mCgZD
         NvJeEGce11MQaIgEoSO8uJrph/cHXjKG1VqLZ9TdQx9bBLvrlsC45fEKwoRvDG/B9/5W
         0Ql1PUSJdEFqjORTNZOEU1UNqJQu/tRQvReJpr/c3ProqZuGzClh+PWUXQmucdtxv6nG
         3XD5xFJcS34ePMZIsM8GdhiZftCdjl93l6WFfHPY+SHiCN6m/w2bRhJ9PAbNKEoAuz8G
         617w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=h1P5+j+r2bLJx1bqqHOaKHRT8j4ftFPbzcum8mBY1zk=;
        b=ZJRa2TKmPPRL6S06jK6WXL6Ai1XRzN3QhxmBjFh8elY/GSNMOedMI4Hw/TVM2Wov0b
         qInHCoTW2H/ou8psvxQgAU22tZ/3BPTycpAlWhr84guWhTjgKqvb6Ec5KD90IV45OlwA
         kshbBtiMQpEwjyBo1UPCWlyFmLAE8IB2cJKCS6KgBpD3gGHvjsJMGQljHOz4/ddl6ObM
         RBlAu8K8xlQXEk/ehrJRYgg/ZE+rvU8ciUcDZYAgz4tebQPevujDQdLJe/F0ug3YWM8C
         L3cGmnHZMr6MZ5Rmbp2yGZJQ0gitnu2diIQ/L/A0K8gt1DLqRJ3+xjPTMWJpfUg4Kwzs
         0rBQ==
X-Gm-Message-State: AOAM5331IVIXm1Bws5fQTkkAd8Qn5OEzZLuU27E5XeoYayQa6j9uVusw
        koEg4uNfEi1dYldaRP9gHI7A5LqelbE0Tw==
X-Google-Smtp-Source: ABdhPJzEjw6yfxHwmlTOg2G4YDHFF0J/qsAiQnvNLMuWgD2tsDsoSSd9DtlGAuAgcOdTUfRL6Co12tiFY7WTHA==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a8b1:128a:69fa:86fb])
 (user=dlatypov job=sendgmr) by 2002:a25:d683:: with SMTP id
 n125mr9741087ybg.256.1612563495011; Fri, 05 Feb 2021 14:18:15 -0800 (PST)
Date:   Fri,  5 Feb 2021 14:18:08 -0800
Message-Id: <20210205221808.1966010-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH] kunit: make KUNIT_EXPECT_STREQ() quote values, don't print literals
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before:
>  Expected str == "world", but
>      str == hello
>      "world" == world

After:
>  Expected str == "world", but
>      str == "hello"
<we don't need to tell the user that "world" == "world">

Note: like the literal ellision for integers, this doesn't handle the
case of
  KUNIT_EXPECT_STREQ(test, "hello", "world")
since we don't expect it to realistically happen in checked in tests.
(If you really wanted a test to fail, KUNIT_FAIL("msg") exists)

In that case, you'd get:
>  Expected "hello" == "world", but
<output for next failure>

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 lib/kunit/assert.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index e0ec7d6fed6f..176ef547fa94 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -156,6 +156,22 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 }
 EXPORT_SYMBOL_GPL(kunit_binary_ptr_assert_format);
 
+/* Checks if KUNIT_EXPECT_STREQ() args were string literals.
+ * Note: `text` will have ""s where as `value` will not.
+ */
+static bool is_str_literal(const char *text, const char *value)
+{
+	int len;
+
+	len = strlen(text);
+	if (len < 2)
+		return false;
+	if (text[0] != '\"' || text[len-1] != '\"')
+		return false;
+
+	return strncmp(text+1, value, len-2) == 0;
+}
+
 void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 				    struct string_stream *stream)
 {
@@ -168,12 +184,14 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 			  binary_assert->left_text,
 			  binary_assert->operation,
 			  binary_assert->right_text);
-	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %s\n",
-			  binary_assert->left_text,
-			  binary_assert->left_value);
-	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %s",
-			  binary_assert->right_text,
-			  binary_assert->right_value);
+	if (!is_str_literal(binary_assert->left_text, binary_assert->left_value))
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == \"%s\"\n",
+				  binary_assert->left_text,
+				  binary_assert->left_value);
+	if (!is_str_literal(binary_assert->right_text, binary_assert->right_value))
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == \"%s\"",
+				  binary_assert->right_text,
+				  binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_binary_str_assert_format);

base-commit: 1e0d27fce010b0a4a9e595506b6ede75934c31be
prerequisite-patch-id: 290f8022f30763cbfb6aec969b038a6f60a57482
-- 
2.30.0.478.g8a0d178c01-goog

