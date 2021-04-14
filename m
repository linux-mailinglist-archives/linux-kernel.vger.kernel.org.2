Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD68835F28B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346583AbhDNL3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343964AbhDNL3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:29:10 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCB8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:28:46 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id i3-20020adffc030000b02900ffd75bf10aso936888wrr.14
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VkOAwUtZ9qQlBvfTOOD6U+Kd6iuYzrcUXQ5MLQjL3Vk=;
        b=vw/WsGYwcg3V6fgb6+UpR6Q15BByBnR9HfL2yOI4vfEug+KXzYobTC1Zpr8wmWpg6B
         cRDjsqfrXgxfZH6+DAeEmF0I136WvJoOecQ1tMIdX37Rq2J2ZMAXdMwzBbuzw6QWlo1H
         BdYUrsTePab2tpDL670jQ2blnmCXmqKDrAL6AR4TtpfGvCJH6J+UYcOzJTlf+F+5Utbq
         q6ueoRMAuRcbhRLj1C9lZH6LEmK81dmxxHYQMTcjwh5Y39UHm4A6Q2E4mbn0YvYW+hQS
         VoNZ+kb0oomzWX0mRNjdNb4tm8xdPY4yts0mc7pkJzNX9ebqhCOYtIJ6JYk7JDxeUilG
         NTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VkOAwUtZ9qQlBvfTOOD6U+Kd6iuYzrcUXQ5MLQjL3Vk=;
        b=c3Si/ZK83iwagdKkXpxOiTvHSgP9zGq1owynr0fBzYxgnZ5qViRDTRMuq/08SB2RBm
         8lLAKYh749Fgx+wO2Nv68Cvig9s4sypKVLLQPBds/zDL9m/g0rXhsruJFmYYLEmpeuo9
         89spLc5w26x3Wxy3L7q4L8xplit0ZGfj9vXnsjuQX/DFwOjSs0JGP6kLfLLIt2EW3uO0
         Si/vbq8l20i4csMgyaqATLhMWc/xKWcxLaChEQqypR5xOPzFd0qGOnZAqZ6nuDi+DkyK
         fM5bv4wp0BzFuCb+N4H5NUMWi78XWYb7PpEocoY+j+jaMH4ZrEQCIehyVg7umLT7Dcy8
         lzug==
X-Gm-Message-State: AOAM533no6OyGC2/IRYYEdm3vWuKgssfOrpKu7c+WRzyyzrz/V8YWHS3
        lZAP+Uyo9wWxnRfokRh3FYYw+0XPDA==
X-Google-Smtp-Source: ABdhPJx+fmVeZ8di+ClCYJADr4FSujA94daf3kIFsEJ9mpuqBs6N4pj6BRHFYy096IGhDpPVt7R9U/ykig==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:4051:8ddb:9de4:c1bb])
 (user=elver job=sendgmr) by 2002:a05:600c:4b92:: with SMTP id
 e18mr2621686wmp.150.1618399725592; Wed, 14 Apr 2021 04:28:45 -0700 (PDT)
Date:   Wed, 14 Apr 2021 13:28:17 +0200
In-Reply-To: <20210414112825.3008667-1-elver@google.com>
Message-Id: <20210414112825.3008667-2-elver@google.com>
Mime-Version: 1.0
References: <20210414112825.3008667-1-elver@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 1/9] kcsan: Simplify value change detection
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     mark.rutland@arm.com, will@kernel.org, dvyukov@google.com,
        glider@google.com, boqun.feng@gmail.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

In kcsan_setup_watchpoint() we store snapshots of a watched value into a
union of u8/u16/u32/u64 sized fields, modify this in place using a
consistent field, then later check for any changes via the u64 field.

We can achieve the safe effect more simply by always treating the field
as a u64, as smaller values will be zero-extended. As the values are
zero-extended, we don't need to truncate the access_mask when we apply
it, and can always apply the full 64-bit access_mask to the 64-bit
value.

Finally, we can store the two snapshots and calculated difference
separately, which makes the code a little easier to read, and will
permit reporting the old/new values in subsequent patches.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/core.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 45c821d4e8bd..d360183002d6 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -407,12 +407,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	const bool is_write = (type & KCSAN_ACCESS_WRITE) != 0;
 	const bool is_assert = (type & KCSAN_ACCESS_ASSERT) != 0;
 	atomic_long_t *watchpoint;
-	union {
-		u8 _1;
-		u16 _2;
-		u32 _4;
-		u64 _8;
-	} expect_value;
+	u64 old, new, diff;
 	unsigned long access_mask;
 	enum kcsan_value_change value_change = KCSAN_VALUE_CHANGE_MAYBE;
 	unsigned long ua_flags = user_access_save();
@@ -468,19 +463,19 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 * Read the current value, to later check and infer a race if the data
 	 * was modified via a non-instrumented access, e.g. from a device.
 	 */
-	expect_value._8 = 0;
+	old = 0;
 	switch (size) {
 	case 1:
-		expect_value._1 = READ_ONCE(*(const u8 *)ptr);
+		old = READ_ONCE(*(const u8 *)ptr);
 		break;
 	case 2:
-		expect_value._2 = READ_ONCE(*(const u16 *)ptr);
+		old = READ_ONCE(*(const u16 *)ptr);
 		break;
 	case 4:
-		expect_value._4 = READ_ONCE(*(const u32 *)ptr);
+		old = READ_ONCE(*(const u32 *)ptr);
 		break;
 	case 8:
-		expect_value._8 = READ_ONCE(*(const u64 *)ptr);
+		old = READ_ONCE(*(const u64 *)ptr);
 		break;
 	default:
 		break; /* ignore; we do not diff the values */
@@ -506,33 +501,30 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 * racy access.
 	 */
 	access_mask = get_ctx()->access_mask;
+	new = 0;
 	switch (size) {
 	case 1:
-		expect_value._1 ^= READ_ONCE(*(const u8 *)ptr);
-		if (access_mask)
-			expect_value._1 &= (u8)access_mask;
+		new = READ_ONCE(*(const u8 *)ptr);
 		break;
 	case 2:
-		expect_value._2 ^= READ_ONCE(*(const u16 *)ptr);
-		if (access_mask)
-			expect_value._2 &= (u16)access_mask;
+		new = READ_ONCE(*(const u16 *)ptr);
 		break;
 	case 4:
-		expect_value._4 ^= READ_ONCE(*(const u32 *)ptr);
-		if (access_mask)
-			expect_value._4 &= (u32)access_mask;
+		new = READ_ONCE(*(const u32 *)ptr);
 		break;
 	case 8:
-		expect_value._8 ^= READ_ONCE(*(const u64 *)ptr);
-		if (access_mask)
-			expect_value._8 &= (u64)access_mask;
+		new = READ_ONCE(*(const u64 *)ptr);
 		break;
 	default:
 		break; /* ignore; we do not diff the values */
 	}
 
+	diff = old ^ new;
+	if (access_mask)
+		diff &= access_mask;
+
 	/* Were we able to observe a value-change? */
-	if (expect_value._8 != 0)
+	if (diff != 0)
 		value_change = KCSAN_VALUE_CHANGE_TRUE;
 
 	/* Check if this access raced with another. */
-- 
2.31.1.295.g9ea45b61b8-goog

