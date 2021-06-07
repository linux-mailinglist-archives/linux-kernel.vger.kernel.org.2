Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E60D39DD1C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhFGM7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 08:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhFGM7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:59:06 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB700C061787
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 05:57:15 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id z25-20020a1c4c190000b029019f15b0657dso4071727wmf.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 05:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=INnLTycaFcjURtOKla7QnFpdUDO/KdMpHCcjcKTzueY=;
        b=kZoDM0QNwlMnELqJA4cdJAmWs2Fp5DiWfp2E+7HfHfZmDJb4VCAlXYBbfAYTzE6c+0
         JBVYYEyhx9LRQA7gHxRm7DoIju8Dyvlrks6X3hEIz8m15wpLaYy6EZqdTXRluOU55a2N
         1NPvl0/ce/jHRhYncl+NxfxqpH263tYSij7Xb6/iYJjXJO0nMMgUtIWlgGljMFHgcAh6
         Nu1k5LDE6tWn0NWV3CYlgTz9kwNs4CcHGFxw3xrCTLvzSr+WUM79sfmvVJo8xT8ra8LI
         C65Zo6crY6Rg5gf2VTiQdh43bcWsYcqK6/+uk/maJjA0iVFtbTLVX3MQjIqbFk7/0VA4
         MGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=INnLTycaFcjURtOKla7QnFpdUDO/KdMpHCcjcKTzueY=;
        b=KAZjJ3zD2aql+1FuyO46wya80Tqd9fiZwyKAZ8TydeP5lQCvjuryQNnLHNSRyT71Ug
         WLrkDUUda+YM/m9RS0l2Dtohl3wuPvcga3lO7ODquVvrIygBVCqEvFm5JnIWyjG9vDmu
         NXc1JE5odJE9lR6RO7gqheXt0eRWS91B0SEGKY5/bJC5vlGBC5Z5cVifffnVwf9EwJ8D
         uW6Iwtpv0m4/wT28hU5jjCuQuNCilTz2QUnssO9fPtX0VFQOtjSOnmYUI1smaQroPs7w
         E7yL3Pl7kqsFPY8EIvGmE9+JA+o6YIv9HZd71JzTj17+LZz/GLmgWKqSqD/232kAWXic
         n+2g==
X-Gm-Message-State: AOAM530GEot3ovSCj5lD0Z4Pq1A+zo549+4W0FfdZBkg8l6SDdzF4JUY
        Kds0s3coDiHijzaRTEglGLDVl3udgg==
X-Google-Smtp-Source: ABdhPJxILxUquDFXFjxxVuZIrbX7W9moo6BiEva+qeuQ/+ngQ3dUugZ5e+bcwx9WbLPpz3mM75EoSd3xiw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:2587:50:741c:6fde])
 (user=elver job=sendgmr) by 2002:adf:9031:: with SMTP id h46mr17415015wrh.125.1623070634196;
 Mon, 07 Jun 2021 05:57:14 -0700 (PDT)
Date:   Mon,  7 Jun 2021 14:56:50 +0200
In-Reply-To: <20210607125653.1388091-1-elver@google.com>
Message-Id: <20210607125653.1388091-5-elver@google.com>
Mime-Version: 1.0
References: <20210607125653.1388091-1-elver@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH 4/7] kcsan: Reduce get_ctx() uses in kcsan_found_watchpoint()
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     boqun.feng@gmail.com, mark.rutland@arm.com, will@kernel.org,
        glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number get_ctx() calls that are close to each other, which
results in poor codegen (repeated preempt_count loads).

Specifically in kcsan_found_watchpoint() (even though it's a slow-path)
it is beneficial to keep the race-window small until the watchpoint has
actually been consumed to avoid missed opportunities to report a race.

Let's clean it up a bit before we add more code in
kcsan_found_watchpoint().

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/core.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index d92977ede7e1..906100923b88 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -301,9 +301,9 @@ static inline void reset_kcsan_skip(void)
 	this_cpu_write(kcsan_skip, skip_count);
 }
 
-static __always_inline bool kcsan_is_enabled(void)
+static __always_inline bool kcsan_is_enabled(struct kcsan_ctx *ctx)
 {
-	return READ_ONCE(kcsan_enabled) && get_ctx()->disable_count == 0;
+	return READ_ONCE(kcsan_enabled) && !ctx->disable_count;
 }
 
 /* Introduce delay depending on context and configuration. */
@@ -353,10 +353,17 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 					    atomic_long_t *watchpoint,
 					    long encoded_watchpoint)
 {
+	struct kcsan_ctx *ctx = get_ctx();
 	unsigned long flags;
 	bool consumed;
 
-	if (!kcsan_is_enabled())
+	/*
+	 * We know a watchpoint exists. Let's try to keep the race-window
+	 * between here and finally consuming the watchpoint below as small as
+	 * possible -- avoid unneccessarily complex code until consumed.
+	 */
+
+	if (!kcsan_is_enabled(ctx))
 		return;
 
 	/*
@@ -364,14 +371,12 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 	 * reporting a race where e.g. the writer set up the watchpoint, but the
 	 * reader has access_mask!=0, we have to ignore the found watchpoint.
 	 */
-	if (get_ctx()->access_mask != 0)
+	if (ctx->access_mask)
 		return;
 
 	/*
-	 * Consume the watchpoint as soon as possible, to minimize the chances
-	 * of !consumed. Consuming the watchpoint must always be guarded by
-	 * kcsan_is_enabled() check, as otherwise we might erroneously
-	 * triggering reports when disabled.
+	 * Consuming the watchpoint must be guarded by kcsan_is_enabled() to
+	 * avoid erroneously triggering reports if the context is disabled.
 	 */
 	consumed = try_consume_watchpoint(watchpoint, encoded_watchpoint);
 
@@ -409,6 +414,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	unsigned long access_mask;
 	enum kcsan_value_change value_change = KCSAN_VALUE_CHANGE_MAYBE;
 	unsigned long ua_flags = user_access_save();
+	struct kcsan_ctx *ctx = get_ctx();
 	unsigned long irq_flags = 0;
 
 	/*
@@ -417,7 +423,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 */
 	reset_kcsan_skip();
 
-	if (!kcsan_is_enabled())
+	if (!kcsan_is_enabled(ctx))
 		goto out;
 
 	/*
@@ -489,7 +495,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 * Re-read value, and check if it is as expected; if not, we infer a
 	 * racy access.
 	 */
-	access_mask = get_ctx()->access_mask;
+	access_mask = ctx->access_mask;
 	new = 0;
 	switch (size) {
 	case 1:
-- 
2.32.0.rc1.229.g3e70b5a671-goog

