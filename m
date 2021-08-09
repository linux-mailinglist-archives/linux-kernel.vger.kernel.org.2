Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D543E44C4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbhHIL0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbhHIL0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:26:06 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C097C061798
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 04:25:46 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id x2-20020a05620a0ec2b02903b8bd8b612eso5453001qkm.19
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 04:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IjiThGwuRkrniINoV9rDnWwojAYXJ1ow0v64nu+9jIE=;
        b=Gybcbx7DXBrAdXo/8Cu9203+ll+evUwCcQrDFi9obbyCJCE7OAwjP/8ON13Y8lDfzT
         56mwcvCXtrxghnYHL8gKL5wDMSWbt16+zfxP2KbQH0Q1kFzjquvZd+pLi+27ygX9AMeP
         msy2xegDthqviDXFjvR0nwHIqIU6+UccbKcWRhsXYNDeyDU7GumJoi7WYfRbTNajaY8k
         DwrcWzxA93M2wfKJw3Ot97nE9tr5tB9+FymYPrgZaLn5g+ihHiZ+KLlBCmeElNlF2iIW
         ltJGmVr+ENNvqgighiZ40qXm8AByxjqK1jol9Rr366uXbheoF84L7VGkU30lVUJn7Ffu
         nTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IjiThGwuRkrniINoV9rDnWwojAYXJ1ow0v64nu+9jIE=;
        b=gm+ZW1hPflSHQpFVmeNXFeqa0UXmK9pODJtCRxVFzKoBcbSQYvadhnhJ8G9XzFjexm
         eWp3pIcEtc7YdkFylfLYwXlYDqp7hbKsAL4z9SzoWL1N+ycf6HAQPrlVO6LPX8NuN0NR
         Qh80tlvFwTJfhwqkohIHXevYv19fxzeYfZtGu5oDz93zc/U2wdRxcnQ+LChgZt0sSBTG
         qUnlxFDz0i5uf+JWTftUAs3+tgVRUE/42JzBOzBnPzDgqQDg4xvV4xXRtH8kxFDUvZA/
         ZYE4jKLZPMRq9TSiqZ+gUQtFr7htI36LKAX2OTKNwtjc3y064l8vBYbkPIptADleJyU/
         35Wg==
X-Gm-Message-State: AOAM533s6TyVOtGXAlEg9dhnucLzIC4yZoP23odoFklY/8KS6IT4y4tU
        NQVIyIupNkq++meybsZjiQYajBURuw==
X-Google-Smtp-Source: ABdhPJz0Fu7+dA+jveHd0oVBOBpDTB4lfdnHNzGLRztXDU9U83O7SYk0AfR7leV7CSrkEvRWHGTeKoR4Gg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e5a3:e652:2b8b:ef12])
 (user=elver job=sendgmr) by 2002:a05:6214:f2e:: with SMTP id
 iw14mr11921075qvb.36.1628508345507; Mon, 09 Aug 2021 04:25:45 -0700 (PDT)
Date:   Mon,  9 Aug 2021 13:25:12 +0200
In-Reply-To: <20210809112516.682816-1-elver@google.com>
Message-Id: <20210809112516.682816-5-elver@google.com>
Mime-Version: 1.0
References: <20210809112516.682816-1-elver@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH 4/8] kcsan: Add ability to pass instruction pointer of access
 to reporting
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        boqun.feng@gmail.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to pass an explicitly set instruction pointer of access
from check_access() all the way through to reporting.

In preparation of using it in reporting.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/core.c   | 55 +++++++++++++++++++++++--------------------
 kernel/kcsan/kcsan.h  |  8 +++----
 kernel/kcsan/report.c | 20 +++++++++-------
 3 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 76e67d1e02d4..bffd1d95addb 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -350,6 +350,7 @@ void kcsan_restore_irqtrace(struct task_struct *task)
 static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 					    size_t size,
 					    int type,
+					    unsigned long ip,
 					    atomic_long_t *watchpoint,
 					    long encoded_watchpoint)
 {
@@ -396,7 +397,7 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 
 	if (consumed) {
 		kcsan_save_irqtrace(current);
-		kcsan_report_set_info(ptr, size, type, watchpoint - watchpoints);
+		kcsan_report_set_info(ptr, size, type, ip, watchpoint - watchpoints);
 		kcsan_restore_irqtrace(current);
 	} else {
 		/*
@@ -416,7 +417,7 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 }
 
 static noinline void
-kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
+kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type, unsigned long ip)
 {
 	const bool is_write = (type & KCSAN_ACCESS_WRITE) != 0;
 	const bool is_assert = (type & KCSAN_ACCESS_ASSERT) != 0;
@@ -568,8 +569,8 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		if (is_assert && value_change == KCSAN_VALUE_CHANGE_TRUE)
 			atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_ASSERT_FAILURES]);
 
-		kcsan_report_known_origin(ptr, size, type, value_change,
-					  watchpoint - watchpoints,
+		kcsan_report_known_origin(ptr, size, type, ip,
+					  value_change, watchpoint - watchpoints,
 					  old, new, access_mask);
 	} else if (value_change == KCSAN_VALUE_CHANGE_TRUE) {
 		/* Inferring a race, since the value should not have changed. */
@@ -578,8 +579,10 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		if (is_assert)
 			atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_ASSERT_FAILURES]);
 
-		if (IS_ENABLED(CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN) || is_assert)
-			kcsan_report_unknown_origin(ptr, size, type, old, new, access_mask);
+		if (IS_ENABLED(CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN) || is_assert) {
+			kcsan_report_unknown_origin(ptr, size, type, ip,
+						    old, new, access_mask);
+		}
 	}
 
 	/*
@@ -596,8 +599,8 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	user_access_restore(ua_flags);
 }
 
-static __always_inline void check_access(const volatile void *ptr, size_t size,
-					 int type)
+static __always_inline void
+check_access(const volatile void *ptr, size_t size, int type, unsigned long ip)
 {
 	const bool is_write = (type & KCSAN_ACCESS_WRITE) != 0;
 	atomic_long_t *watchpoint;
@@ -625,13 +628,12 @@ static __always_inline void check_access(const volatile void *ptr, size_t size,
 	 */
 
 	if (unlikely(watchpoint != NULL))
-		kcsan_found_watchpoint(ptr, size, type, watchpoint,
-				       encoded_watchpoint);
+		kcsan_found_watchpoint(ptr, size, type, ip, watchpoint, encoded_watchpoint);
 	else {
 		struct kcsan_ctx *ctx = get_ctx(); /* Call only once in fast-path. */
 
 		if (unlikely(should_watch(ptr, size, type, ctx)))
-			kcsan_setup_watchpoint(ptr, size, type);
+			kcsan_setup_watchpoint(ptr, size, type, ip);
 		else if (unlikely(ctx->scoped_accesses.prev))
 			kcsan_check_scoped_accesses();
 	}
@@ -757,7 +759,7 @@ kcsan_begin_scoped_access(const volatile void *ptr, size_t size, int type,
 {
 	struct kcsan_ctx *ctx = get_ctx();
 
-	__kcsan_check_access(ptr, size, type);
+	check_access(ptr, size, type, _RET_IP_);
 
 	ctx->disable_count++; /* Disable KCSAN, in case list debugging is on. */
 
@@ -802,7 +804,7 @@ EXPORT_SYMBOL(kcsan_end_scoped_access);
 
 void __kcsan_check_access(const volatile void *ptr, size_t size, int type)
 {
-	check_access(ptr, size, type);
+	check_access(ptr, size, type, _RET_IP_);
 }
 EXPORT_SYMBOL(__kcsan_check_access);
 
@@ -823,7 +825,7 @@ EXPORT_SYMBOL(__kcsan_check_access);
 	void __tsan_read##size(void *ptr);                                     \
 	void __tsan_read##size(void *ptr)                                      \
 	{                                                                      \
-		check_access(ptr, size, 0);                                    \
+		check_access(ptr, size, 0, _RET_IP_);                          \
 	}                                                                      \
 	EXPORT_SYMBOL(__tsan_read##size);                                      \
 	void __tsan_unaligned_read##size(void *ptr)                            \
@@ -832,7 +834,7 @@ EXPORT_SYMBOL(__kcsan_check_access);
 	void __tsan_write##size(void *ptr);                                    \
 	void __tsan_write##size(void *ptr)                                     \
 	{                                                                      \
-		check_access(ptr, size, KCSAN_ACCESS_WRITE);                   \
+		check_access(ptr, size, KCSAN_ACCESS_WRITE, _RET_IP_);         \
 	}                                                                      \
 	EXPORT_SYMBOL(__tsan_write##size);                                     \
 	void __tsan_unaligned_write##size(void *ptr)                           \
@@ -842,7 +844,8 @@ EXPORT_SYMBOL(__kcsan_check_access);
 	void __tsan_read_write##size(void *ptr)                                \
 	{                                                                      \
 		check_access(ptr, size,                                        \
-			     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE);      \
+			     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE,       \
+			     _RET_IP_);                                        \
 	}                                                                      \
 	EXPORT_SYMBOL(__tsan_read_write##size);                                \
 	void __tsan_unaligned_read_write##size(void *ptr)                      \
@@ -858,14 +861,14 @@ DEFINE_TSAN_READ_WRITE(16);
 void __tsan_read_range(void *ptr, size_t size);
 void __tsan_read_range(void *ptr, size_t size)
 {
-	check_access(ptr, size, 0);
+	check_access(ptr, size, 0, _RET_IP_);
 }
 EXPORT_SYMBOL(__tsan_read_range);
 
 void __tsan_write_range(void *ptr, size_t size);
 void __tsan_write_range(void *ptr, size_t size)
 {
-	check_access(ptr, size, KCSAN_ACCESS_WRITE);
+	check_access(ptr, size, KCSAN_ACCESS_WRITE, _RET_IP_);
 }
 EXPORT_SYMBOL(__tsan_write_range);
 
@@ -886,7 +889,8 @@ EXPORT_SYMBOL(__tsan_write_range);
 				       IS_ALIGNED((unsigned long)ptr, size);   \
 		if (IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS) && is_atomic)      \
 			return;                                                \
-		check_access(ptr, size, is_atomic ? KCSAN_ACCESS_ATOMIC : 0);  \
+		check_access(ptr, size, is_atomic ? KCSAN_ACCESS_ATOMIC : 0,   \
+			     _RET_IP_);                                        \
 	}                                                                      \
 	EXPORT_SYMBOL(__tsan_volatile_read##size);                             \
 	void __tsan_unaligned_volatile_read##size(void *ptr)                   \
@@ -901,7 +905,8 @@ EXPORT_SYMBOL(__tsan_write_range);
 			return;                                                \
 		check_access(ptr, size,                                        \
 			     KCSAN_ACCESS_WRITE |                              \
-				     (is_atomic ? KCSAN_ACCESS_ATOMIC : 0));   \
+				     (is_atomic ? KCSAN_ACCESS_ATOMIC : 0),    \
+			     _RET_IP_);                                        \
 	}                                                                      \
 	EXPORT_SYMBOL(__tsan_volatile_write##size);                            \
 	void __tsan_unaligned_volatile_write##size(void *ptr)                  \
@@ -955,7 +960,7 @@ EXPORT_SYMBOL(__tsan_init);
 	u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder)                       \
 	{                                                                                          \
 		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
-			check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_ATOMIC);              \
+			check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_ATOMIC, _RET_IP_);    \
 		}                                                                                  \
 		return __atomic_load_n(ptr, memorder);                                             \
 	}                                                                                          \
@@ -965,7 +970,7 @@ EXPORT_SYMBOL(__tsan_init);
 	{                                                                                          \
 		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
 			check_access(ptr, bits / BITS_PER_BYTE,                                    \
-				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);                    \
+				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC, _RET_IP_);          \
 		}                                                                                  \
 		__atomic_store_n(ptr, v, memorder);                                                \
 	}                                                                                          \
@@ -978,7 +983,7 @@ EXPORT_SYMBOL(__tsan_init);
 		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
 			check_access(ptr, bits / BITS_PER_BYTE,                                    \
 				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
-					     KCSAN_ACCESS_ATOMIC);                                 \
+					     KCSAN_ACCESS_ATOMIC, _RET_IP_);                       \
 		}                                                                                  \
 		return __atomic_##op##suffix(ptr, v, memorder);                                    \
 	}                                                                                          \
@@ -1010,7 +1015,7 @@ EXPORT_SYMBOL(__tsan_init);
 		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
 			check_access(ptr, bits / BITS_PER_BYTE,                                    \
 				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
-					     KCSAN_ACCESS_ATOMIC);                                 \
+					     KCSAN_ACCESS_ATOMIC, _RET_IP_);                       \
 		}                                                                                  \
 		return __atomic_compare_exchange_n(ptr, exp, val, weak, mo, fail_mo);              \
 	}                                                                                          \
@@ -1025,7 +1030,7 @@ EXPORT_SYMBOL(__tsan_init);
 		if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
 			check_access(ptr, bits / BITS_PER_BYTE,                                    \
 				     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
-					     KCSAN_ACCESS_ATOMIC);                                 \
+					     KCSAN_ACCESS_ATOMIC, _RET_IP_);                       \
 		}                                                                                  \
 		__atomic_compare_exchange_n(ptr, &exp, val, 0, mo, fail_mo);                       \
 		return exp;                                                                        \
diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
index f36e25c497ed..ae33c2a7f07e 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -121,7 +121,7 @@ enum kcsan_value_change {
  * to be consumed by the reporting thread. No report is printed yet.
  */
 void kcsan_report_set_info(const volatile void *ptr, size_t size, int access_type,
-			   int watchpoint_idx);
+			   unsigned long ip, int watchpoint_idx);
 
 /*
  * The calling thread observed that the watchpoint it set up was hit and
@@ -129,14 +129,14 @@ void kcsan_report_set_info(const volatile void *ptr, size_t size, int access_typ
  * thread.
  */
 void kcsan_report_known_origin(const volatile void *ptr, size_t size, int access_type,
-			       enum kcsan_value_change value_change, int watchpoint_idx,
-			       u64 old, u64 new, u64 mask);
+			       unsigned long ip, enum kcsan_value_change value_change,
+			       int watchpoint_idx, u64 old, u64 new, u64 mask);
 
 /*
  * No other thread was observed to race with the access, but the data value
  * before and after the stall differs. Reports a race of "unknown origin".
  */
 void kcsan_report_unknown_origin(const volatile void *ptr, size_t size, int access_type,
-				 u64 old, u64 new, u64 mask);
+				 unsigned long ip, u64 old, u64 new, u64 mask);
 
 #endif /* _KERNEL_KCSAN_KCSAN_H */
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 21137929d428..50c4119f5cc0 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -31,6 +31,7 @@ struct access_info {
 	int			access_type;
 	int			task_pid;
 	int			cpu_id;
+	unsigned long		ip;
 };
 
 /*
@@ -576,21 +577,22 @@ static bool prepare_report_consumer(unsigned long *flags,
 }
 
 static struct access_info prepare_access_info(const volatile void *ptr, size_t size,
-					      int access_type)
+					      int access_type, unsigned long ip)
 {
 	return (struct access_info) {
 		.ptr		= ptr,
 		.size		= size,
 		.access_type	= access_type,
 		.task_pid	= in_task() ? task_pid_nr(current) : -1,
-		.cpu_id		= raw_smp_processor_id()
+		.cpu_id		= raw_smp_processor_id(),
+		.ip		= ip,
 	};
 }
 
 void kcsan_report_set_info(const volatile void *ptr, size_t size, int access_type,
-			   int watchpoint_idx)
+			   unsigned long ip, int watchpoint_idx)
 {
-	const struct access_info ai = prepare_access_info(ptr, size, access_type);
+	const struct access_info ai = prepare_access_info(ptr, size, access_type, ip);
 	unsigned long flags;
 
 	kcsan_disable_current();
@@ -603,10 +605,10 @@ void kcsan_report_set_info(const volatile void *ptr, size_t size, int access_typ
 }
 
 void kcsan_report_known_origin(const volatile void *ptr, size_t size, int access_type,
-			       enum kcsan_value_change value_change, int watchpoint_idx,
-			       u64 old, u64 new, u64 mask)
+			       unsigned long ip, enum kcsan_value_change value_change,
+			       int watchpoint_idx, u64 old, u64 new, u64 mask)
 {
-	const struct access_info ai = prepare_access_info(ptr, size, access_type);
+	const struct access_info ai = prepare_access_info(ptr, size, access_type, ip);
 	struct other_info *other_info = &other_infos[watchpoint_idx];
 	unsigned long flags = 0;
 
@@ -637,9 +639,9 @@ void kcsan_report_known_origin(const volatile void *ptr, size_t size, int access
 }
 
 void kcsan_report_unknown_origin(const volatile void *ptr, size_t size, int access_type,
-				 u64 old, u64 new, u64 mask)
+				 unsigned long ip, u64 old, u64 new, u64 mask)
 {
-	const struct access_info ai = prepare_access_info(ptr, size, access_type);
+	const struct access_info ai = prepare_access_info(ptr, size, access_type, ip);
 	unsigned long flags;
 
 	kcsan_disable_current();
-- 
2.32.0.605.g8dce9f2422-goog

