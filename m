Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721583EB254
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 10:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239753AbhHMIL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 04:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239668AbhHMIL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:11:27 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53148C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 01:11:01 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id u8-20020a0cec880000b029035825559ec4so6241704qvo.22
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 01:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=j24ec91WRmx0ztj0QJuWNPagxwmZnLCi87UE9Mn0dxc=;
        b=PWHs269Ng8LX4PY0rhR7ggPQUyyCTuAzYxh3X8WJbn8/bwl1JGQ/Ne6xdnbJbhn1Ru
         S4Dyt7wg/cR0+MJp6fuY7m2qb3Blu1SqtihCeMebexkh+3vQ4ZyuZQh+LyPy1Vx775to
         RyRDj3GdIQ+zeJzZVPyfYzI9uSxF9kYtO+cs2lJG23DhjaGz0dXAXoQOpOP7KA2xxH4b
         H3IwfSML7VT+MyezFYghEJ300VJ+x6Knj7owxvV3nPScxdP4BTPXIYecKKHhVeuosGVf
         3QPa07A4t5NHIYwksjoXAy9G8KB+NIH55PerJmRIF/ZfqJpAghyXVrTpSr3eCvaoVA2m
         Mk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=j24ec91WRmx0ztj0QJuWNPagxwmZnLCi87UE9Mn0dxc=;
        b=tUIz3K/z6ECqI29eKgoAx+Hy2aKCAE6m1fxLOdGvBmOE+BuXHuKX1y8QwixWQfsg3d
         1O1l0p7fqqv1Iq3Wxr2vrrbc1fNibs09AEPS6+6DPk8Uh3Ew2+GpJGCdrUqfbqiZX2NN
         Ztg70SzsrtdUv25nOJVefqddus1fu2lBs0THrOVR70iniCD7nkERIHlIMWXXKZpAGHi6
         1O9p0hp34voTJR4i7IXr3Lv3VR7TsgN4I8wD3qtXQhAOwg3y4arh5W7OCnYII/RX4Wgh
         knxefOekJQe9vYCc02MqEj4n4Jt8zhTE5vUdsuXpwaqhDaDBD1tuSwiphW41d59VXZnb
         9/PA==
X-Gm-Message-State: AOAM533ioMHQfODJgBEmGJHzGSoKyMVMubImGfwcIIk0WXZ4Dg5mP9vX
        HrJw9uBaZKsnQ2MUq/MSUxFasjqnkA==
X-Google-Smtp-Source: ABdhPJymIhScIAv/J7lzTbC0lBD9x+Gzoef1bEntzwW1+piWSnivvOjHA1GCfSr2mWsBFpixVKp0FzwpSw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f52:cd7f:2e57:442e])
 (user=elver job=sendgmr) by 2002:a05:6214:5012:: with SMTP id
 jo18mr1521038qvb.31.1628842260479; Fri, 13 Aug 2021 01:11:00 -0700 (PDT)
Date:   Fri, 13 Aug 2021 10:10:55 +0200
Message-Id: <20210813081055.3119894-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH] kcsan: selftest: Cleanup and add missing __init
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        boqun.feng@gmail.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make test_encode_decode() more readable and add missing __init.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/selftest.c | 72 +++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 42 deletions(-)

diff --git a/kernel/kcsan/selftest.c b/kernel/kcsan/selftest.c
index 7f29cb0f5e63..b4295a3892b7 100644
--- a/kernel/kcsan/selftest.c
+++ b/kernel/kcsan/selftest.c
@@ -18,7 +18,7 @@
 #define ITERS_PER_TEST 2000
 
 /* Test requirements. */
-static bool test_requires(void)
+static bool __init test_requires(void)
 {
 	/* random should be initialized for the below tests */
 	return prandom_u32() + prandom_u32() != 0;
@@ -28,14 +28,18 @@ static bool test_requires(void)
  * Test watchpoint encode and decode: check that encoding some access's info,
  * and then subsequent decode preserves the access's info.
  */
-static bool test_encode_decode(void)
+static bool __init test_encode_decode(void)
 {
 	int i;
 
 	for (i = 0; i < ITERS_PER_TEST; ++i) {
 		size_t size = prandom_u32_max(MAX_ENCODABLE_SIZE) + 1;
 		bool is_write = !!prandom_u32_max(2);
+		unsigned long verif_masked_addr;
+		long encoded_watchpoint;
+		bool verif_is_write;
 		unsigned long addr;
+		size_t verif_size;
 
 		prandom_bytes(&addr, sizeof(addr));
 		if (addr < PAGE_SIZE)
@@ -44,53 +48,37 @@ static bool test_encode_decode(void)
 		if (WARN_ON(!check_encodable(addr, size)))
 			return false;
 
-		/* Encode and decode */
-		{
-			const long encoded_watchpoint =
-				encode_watchpoint(addr, size, is_write);
-			unsigned long verif_masked_addr;
-			size_t verif_size;
-			bool verif_is_write;
-
-			/* Check special watchpoints */
-			if (WARN_ON(decode_watchpoint(
-				    INVALID_WATCHPOINT, &verif_masked_addr,
-				    &verif_size, &verif_is_write)))
-				return false;
-			if (WARN_ON(decode_watchpoint(
-				    CONSUMED_WATCHPOINT, &verif_masked_addr,
-				    &verif_size, &verif_is_write)))
-				return false;
-
-			/* Check decoding watchpoint returns same data */
-			if (WARN_ON(!decode_watchpoint(
-				    encoded_watchpoint, &verif_masked_addr,
-				    &verif_size, &verif_is_write)))
-				return false;
-			if (WARN_ON(verif_masked_addr !=
-				    (addr & WATCHPOINT_ADDR_MASK)))
-				goto fail;
-			if (WARN_ON(verif_size != size))
-				goto fail;
-			if (WARN_ON(is_write != verif_is_write))
-				goto fail;
-
-			continue;
-fail:
-			pr_err("%s fail: %s %zu bytes @ %lx -> encoded: %lx -> %s %zu bytes @ %lx\n",
-			       __func__, is_write ? "write" : "read", size,
-			       addr, encoded_watchpoint,
-			       verif_is_write ? "write" : "read", verif_size,
-			       verif_masked_addr);
+		encoded_watchpoint = encode_watchpoint(addr, size, is_write);
+
+		/* Check special watchpoints */
+		if (WARN_ON(decode_watchpoint(INVALID_WATCHPOINT, &verif_masked_addr, &verif_size, &verif_is_write)))
 			return false;
-		}
+		if (WARN_ON(decode_watchpoint(CONSUMED_WATCHPOINT, &verif_masked_addr, &verif_size, &verif_is_write)))
+			return false;
+
+		/* Check decoding watchpoint returns same data */
+		if (WARN_ON(!decode_watchpoint(encoded_watchpoint, &verif_masked_addr, &verif_size, &verif_is_write)))
+			return false;
+		if (WARN_ON(verif_masked_addr != (addr & WATCHPOINT_ADDR_MASK)))
+			goto fail;
+		if (WARN_ON(verif_size != size))
+			goto fail;
+		if (WARN_ON(is_write != verif_is_write))
+			goto fail;
+
+		continue;
+fail:
+		pr_err("%s fail: %s %zu bytes @ %lx -> encoded: %lx -> %s %zu bytes @ %lx\n",
+		       __func__, is_write ? "write" : "read", size, addr, encoded_watchpoint,
+		       verif_is_write ? "write" : "read", verif_size, verif_masked_addr);
+		return false;
 	}
 
 	return true;
 }
 
 /* Test access matching function. */
-static bool test_matching_access(void)
+static bool __init test_matching_access(void)
 {
 	if (WARN_ON(!matching_access(10, 1, 10, 1)))
 		return false;
-- 
2.33.0.rc1.237.g0d66db33f3-goog

