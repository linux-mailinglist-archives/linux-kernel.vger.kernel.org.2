Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A065393E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 10:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbhE1IEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 04:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbhE1ICq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 04:02:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A645AC06138A
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 00:59:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d63-20020a254f420000b02904f91ef33453so3519063ybb.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 00:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Nv+J3ke0GgapMp0UwGNPvITZFCUM1uizFSit9ptyMQc=;
        b=A9wEfeV2t5zjcVvkmopt+OUo5Y7cIiuq7m1TuoNpJzQrlg9gsm8EUl72tZ0ez0V9Kb
         kl6mhDIxUZjaOT6zQ5ZFVycdhRRrOVSotS48Qn39ZT3JFxT352uVJNif0nErp1cXsPn7
         IKsmQHZo2Cv1qFL9knyaREXUzsSfEb57mSBFkpJn9rZp2IHs5CncHIBfk7H8XQzSJx4t
         nEEdpBsj9352d55+nXXMelUzktOVJ6eXBb4WbseKtnb4I7uo75ewLfYgpUzkqenEZWHY
         U6NxtjsAqmKdBLh5GsIH4XDm7oZIZwa0O+ZTiR+Ml5qWAcL8JZjthCTc5c5YunbDWO3b
         T+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Nv+J3ke0GgapMp0UwGNPvITZFCUM1uizFSit9ptyMQc=;
        b=aXcjZnrvYxqBgNA6MYMw3roUWjW5/+oX82FQYbG1DAPaZHnZjBYTbJNrV3ByZlof4B
         4o3STgfpga609oeRojg7XSu0b7s8stkuiv2QQL+lVcEa9TJ9qKbB//iXi4cq2bNkigdj
         hlvhw4C6qza7o31XM3CRA9Qb5aUIzVQVlh4skhT8mUC/SZxzK6nTjsQ2KH58BPTqPivT
         JxIAkpBX031kBIh0lVQpFbr5rcwa4QUYrPQYBwlWmj+xG7E3qjMaPsHcc0tgFZe8nX73
         zW8zTwG3umX7HpB/dUWXBB1cVUk0ytqmhzh53RPYtQfnP1WhN+GMEgIYVF9dQuRC4bbe
         VD1A==
X-Gm-Message-State: AOAM533cWMYG9/bWmp3CN4kE9ttf76NB3bVfvrHHAJb8tfg3Vsncfatm
        Ql4xC2WuE0+9Z8/FAfzP785aPSJfP1itTg==
X-Google-Smtp-Source: ABdhPJxNNkb2l9aDeHKTGKTTzls8rE4nlnET5wh8WCWcLieRI70ZHvNzD4OkfPNXZIniPZB50+3I2ZGjOnfq5A==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:621b:e8e2:f86a:41f])
 (user=davidgow job=sendgmr) by 2002:a25:d341:: with SMTP id
 e62mr10161864ybf.197.1622188784739; Fri, 28 May 2021 00:59:44 -0700 (PDT)
Date:   Fri, 28 May 2021 00:59:32 -0700
In-Reply-To: <20210528075932.347154-1-davidgow@google.com>
Message-Id: <20210528075932.347154-4-davidgow@google.com>
Mime-Version: 1.0
References: <20210528075932.347154-1-davidgow@google.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v2 4/4] kasan: test: make use of kunit_skip()
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     Marco Elver <elver@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Make use of the recently added kunit_skip() to skip tests, as it permits
TAP parsers to recognize if a test was deliberately skipped.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---
 lib/test_kasan.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index cacbbbdef768..0a2029d14c91 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -111,17 +111,13 @@ static void kasan_test_exit(struct kunit *test)
 } while (0)
 
 #define KASAN_TEST_NEEDS_CONFIG_ON(test, config) do {			\
-	if (!IS_ENABLED(config)) {					\
-		kunit_info((test), "skipping, " #config " required");	\
-		return;							\
-	}								\
+	if (!IS_ENABLED(config))					\
+		kunit_skip((test), "Test requires " #config "=y");	\
 } while (0)
 
 #define KASAN_TEST_NEEDS_CONFIG_OFF(test, config) do {			\
-	if (IS_ENABLED(config)) {					\
-		kunit_info((test), "skipping, " #config " enabled");	\
-		return;							\
-	}								\
+	if (IS_ENABLED(config))						\
+		kunit_skip((test), "Test requires " #config "=n");	\
 } while (0)
 
 static void kmalloc_oob_right(struct kunit *test)
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

