Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AEA3E44C0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbhHIL0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbhHIL0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:26:01 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDAAC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 04:25:41 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id f10-20020a0ccc8a0000b02903521ac3b9d7so2972526qvl.15
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 04:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ETG24eNjcLOqgZgZJOfludY7in3fTtyTQv+qiRTb/Zk=;
        b=lxmkxAUi6k8gTayII388qxpVH2X9phCKrRpAJkVJk/qMijTiV+a05KAuEJsOwaGo8E
         TDjkM9gTaEmzpXNNvKRVx2ClTxtZ+Qnrnd0cf5YB2Idm303i95v5uqPycGf7ptg9fNJw
         brG6runSlPnK3TaKx3JY5DkzxQ+JfUhVpd2fDNz9IoxSlyaIlq6IViA2Ev0Zino4fEzg
         5T/Yuj2JV2Ss8B36x1CAt/7h/DHVZL/Rd1Qubi2cJwhtZX5EH5Z/ub7p1BmoLNLsi/tN
         H3L4zsoTg52K6sh/y1uDbNEA00gXVctXBVIF+Pq7f+Sr93dxmOSmP9pzOc/U7qsqRA3B
         gLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ETG24eNjcLOqgZgZJOfludY7in3fTtyTQv+qiRTb/Zk=;
        b=VXnkKdQgC9XeqHX2fUJ+B3U1MyFPHgMgWLBavfpWLRZNI5LPCSmlzoMcoEXqtSYmcI
         ilxSlVHcInKZ0ueKwYaETJ1t8Xh8ocTp9fHBOpLaw51Nxre1PsV8WtB4xa7D8MHuV84O
         q3RELyOaE4bl7uH0X1N2swBKzv7OsQdJ0m7fkqASBfIaAE5vdfuAN4TaAb9MXrMdrT94
         brdSIDb2iWc6dMD6CT6hi4MbfSb5YkhMZL+kDi/6FX4Wrs1qZJjewmCxEkUtcTb45Csb
         IzxHq034qDsoJTQINbGWglSbqu18+dHStM6NvKEZl6qeoX2rz6GP0HxK+XQ5V7oeR1uF
         pVGA==
X-Gm-Message-State: AOAM532ISKRVzZgOFxg+9M23pBkPWkZUQ6KVuqOchLA62Wix9K89Uci3
        Tqk1RHZICLSAZW3qv22zHU49tgw0Dw==
X-Google-Smtp-Source: ABdhPJwqq9PKYLQ1Wstt4ndKsgm6fHlZ/8t+X8abQUHS2byAsREzbPxcItS4biw5rbFmkZSAeXdzrh2pLw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e5a3:e652:2b8b:ef12])
 (user=elver job=sendgmr) by 2002:ad4:4e50:: with SMTP id eb16mr9341163qvb.14.1628508340651;
 Mon, 09 Aug 2021 04:25:40 -0700 (PDT)
Date:   Mon,  9 Aug 2021 13:25:10 +0200
In-Reply-To: <20210809112516.682816-1-elver@google.com>
Message-Id: <20210809112516.682816-3-elver@google.com>
Mime-Version: 1.0
References: <20210809112516.682816-1-elver@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH 2/8] kcsan: test: Use kunit_skip() to skip tests
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        boqun.feng@gmail.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new kunit_skip() to skip tests if requirements were not met.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/kcsan_test.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index df041bdb6088..d93f226327af 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -29,6 +29,11 @@
 #include <linux/types.h>
 #include <trace/events/printk.h>
 
+#define KCSAN_TEST_REQUIRES(test, cond) do {			\
+	if (!(cond))						\
+		kunit_skip((test), "Test requires: " #cond);	\
+} while (0)
+
 #ifdef CONFIG_CC_HAS_TSAN_COMPOUND_READ_BEFORE_WRITE
 #define __KCSAN_ACCESS_RW(alt) (KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE)
 #else
@@ -642,8 +647,7 @@ static void test_read_plain_atomic_write(struct kunit *test)
 	};
 	bool match_expect = false;
 
-	if (IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS))
-		return;
+	KCSAN_TEST_REQUIRES(test, !IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS));
 
 	begin_test_checks(test_kernel_read, test_kernel_write_atomic);
 	do {
@@ -665,8 +669,7 @@ static void test_read_plain_atomic_rmw(struct kunit *test)
 	};
 	bool match_expect = false;
 
-	if (IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS))
-		return;
+	KCSAN_TEST_REQUIRES(test, !IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS));
 
 	begin_test_checks(test_kernel_read, test_kernel_atomic_rmw);
 	do {
-- 
2.32.0.605.g8dce9f2422-goog

