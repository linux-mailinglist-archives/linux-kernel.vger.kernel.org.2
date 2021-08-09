Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070433E44CA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbhHIL0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbhHIL0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:26:16 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D143EC06179B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 04:25:55 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id b4-20020a3799040000b02903b899a4309cso12305882qke.14
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 04:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3M2/xbQIahIs7ogtIo1dLeYQP/7ls8f8pJkByGd/S5I=;
        b=aBPh3KoQ3oBNe/12tjRjmDpZNwrnoHTVpnq6sQOkGrVXZck/SoGHptZlU0IhkXjS35
         FjctM08aPen+7vepm/ZYPyCQn9mGoF39Ym6az8LppJdNvMB64P0P9obnFjOzsokX94Pu
         1N3gv9FgfTWxWE1FQ6wglWgrr1uQ4nOKORkGr95aqH6+g/6H+zNb4ux3RKQ0a4RUxhk0
         QKz00CipisvFj5UuHaKJt0MQKgT1zkfUMpM3uagjR39G9ncTODdry4N5MarVLn1JelSz
         WgCaw5fVAXSWUWHhDEO+7CD6+M/6DTZrYecvafKpb/iZcd5BEaaNENBxI9s18ngcvJbM
         qx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3M2/xbQIahIs7ogtIo1dLeYQP/7ls8f8pJkByGd/S5I=;
        b=mRuj9BBZOru+z25eJwY9YXSi/jKiGX8L5lWPZ7k5Jpgp33H00WcRr2o5JnQNRWXQWM
         IyIfy237uqVweWViuUaPhR0BHtqi4n5dx/NPu4SNtsOt/7wi0VZzoyULD8+W+rE4JMRg
         qUzGzSEMF7sFmzgeeFUPniPVWOTkpuWGpMTcsq6B16JIwwerVG5/ag47oF3TMlwgRtay
         01HOCPjEwl7vfQ/gNtfJGOp10np4WvVf6PkMW0CXHVb8Uk1zNitGXGuR8vWCUDS8LR5z
         Rw31Yo/zLcop4pWB+QFrbcJojMS1cIjKL5GLzn0KCAT0tUGEaYE87cwUXx+Lk5Ga/w3g
         /qkw==
X-Gm-Message-State: AOAM533Y48MUHSTw7rSm3UaH+/5xSCiDaypkNGnubSVzhoHwxgQfgeMc
        bbpF4mwpemke9P3BanACf+5WVp2WaQ==
X-Google-Smtp-Source: ABdhPJw1/FPbT7Cr4bruWkEitvkE6rq35h7Vi5zjL0fk6MkScYV2R58/zvdTctg6/cebT6VuAeqGSKeXJg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e5a3:e652:2b8b:ef12])
 (user=elver job=sendgmr) by 2002:a05:6214:d0c:: with SMTP id
 12mr5970119qvh.10.1628508355005; Mon, 09 Aug 2021 04:25:55 -0700 (PDT)
Date:   Mon,  9 Aug 2021 13:25:16 +0200
In-Reply-To: <20210809112516.682816-1-elver@google.com>
Message-Id: <20210809112516.682816-9-elver@google.com>
Mime-Version: 1.0
References: <20210809112516.682816-1-elver@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH 8/8] kcsan: Move ctx to start of argument list
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        boqun.feng@gmail.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is clearer if ctx is at the start of the function argument list;
it'll be more consistent when adding functions with varying arguments
but all requiring ctx.

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 8b20af541776..4b84c8e7884b 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -222,7 +222,7 @@ static noinline void kcsan_check_scoped_accesses(void)
 
 /* Rules for generic atomic accesses. Called from fast-path. */
 static __always_inline bool
-is_atomic(const volatile void *ptr, size_t size, int type, struct kcsan_ctx *ctx)
+is_atomic(struct kcsan_ctx *ctx, const volatile void *ptr, size_t size, int type)
 {
 	if (type & KCSAN_ACCESS_ATOMIC)
 		return true;
@@ -259,7 +259,7 @@ is_atomic(const volatile void *ptr, size_t size, int type, struct kcsan_ctx *ctx
 }
 
 static __always_inline bool
-should_watch(const volatile void *ptr, size_t size, int type, struct kcsan_ctx *ctx)
+should_watch(struct kcsan_ctx *ctx, const volatile void *ptr, size_t size, int type)
 {
 	/*
 	 * Never set up watchpoints when memory operations are atomic.
@@ -268,7 +268,7 @@ should_watch(const volatile void *ptr, size_t size, int type, struct kcsan_ctx *
 	 * should not count towards skipped instructions, and (2) to actually
 	 * decrement kcsan_atomic_next for consecutive instruction stream.
 	 */
-	if (is_atomic(ptr, size, type, ctx))
+	if (is_atomic(ctx, ptr, size, type))
 		return false;
 
 	if (this_cpu_dec_return(kcsan_skip) >= 0)
@@ -637,7 +637,7 @@ check_access(const volatile void *ptr, size_t size, int type, unsigned long ip)
 	else {
 		struct kcsan_ctx *ctx = get_ctx(); /* Call only once in fast-path. */
 
-		if (unlikely(should_watch(ptr, size, type, ctx)))
+		if (unlikely(should_watch(ctx, ptr, size, type)))
 			kcsan_setup_watchpoint(ptr, size, type, ip);
 		else if (unlikely(ctx->scoped_accesses.prev))
 			kcsan_check_scoped_accesses();
-- 
2.32.0.605.g8dce9f2422-goog

