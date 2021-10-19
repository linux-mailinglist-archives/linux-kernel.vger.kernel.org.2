Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB294432D12
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 07:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbhJSFTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 01:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbhJSFTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:19:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E176EC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:17:37 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ls18-20020a17090b351200b001a00250584aso1092502pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K0VZKS1ICUvF0VKDj/TjmFxxuKxVm9cw/F2xdtoToVE=;
        b=lU+H3SC772Rez0KYcO5TqZkXHEslwzHNgDahx42NJVno3T1Tv5b8nNJ/lDahBg7wh4
         Pre/Iql5BjLjDdcWddRLeOuUYh/vzzrxXVrURb5ZgmgcR+cNQ8TVIUELIk/El9HGujK3
         QmVjBcnhJCCWVOqWQCOmpvTj/WRs9pWpYZcf4NaI8RhITux5ZQtGkhLkz7MNq/kQSIja
         Ryxp9opJ/LtjnmnJnkVewFdojQO8NNA5h/leLq9eO0Sj0llOoQaZP3q+GfTQxVDoVJNI
         elcOpA1ngvdSMbjOhr9lgAYOVSCBlZNihinljnTcB7UhzHO7+Jinp12CJMo3FV7eqNJL
         w4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K0VZKS1ICUvF0VKDj/TjmFxxuKxVm9cw/F2xdtoToVE=;
        b=1CKMBKibFakybRvHxdDB8Gs2b6Z9Tnkzh+QwQta/WXIk7jmarCQj57BiVv6/kaC0s+
         R3KX0tEaMwU5HnvKxMTTmqPqvcYs74OP8ItbIuAu4GEy04f6GMEQN/y4Lrmep9Yp3MuO
         wW82USn1BlMEIr++ZdfdTXZ+Ci3PfywYdNejYbqZAPbTO1oWDq6+ugpwswvL6SLHMulF
         fdGn2+jrn6Un1njA4le4BYvrwHAOVcsM0ZD86vY0vZZ7mfycQHHPojkGEaIp2PCP5FpI
         mvC29zHZpm13yGDZIRVwXQfqDY2xjyfvN5NMiyo7HbT+yvWRZPvT2FuU+n8rFd90wGDP
         5RXw==
X-Gm-Message-State: AOAM531T8Cx0MLzWxF0IAhjyZi9gIAgRVaUcWi7bMbsKqme8YtU/0/LH
        lgUu6F2An0wXCtPV+24uC64=
X-Google-Smtp-Source: ABdhPJysF1w2HhVm+eJuvIkYF7aCY8eB2ZO9h2K7+P+/TdOmNx9GuxvCTAX2634QVuf7PJbkGcivjg==
X-Received: by 2002:a17:90a:1fcf:: with SMTP id z15mr4006725pjz.31.1634620657460;
        Mon, 18 Oct 2021 22:17:37 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:4171:83c2:8384:24c5])
        by smtp.gmail.com with ESMTPSA id me12sm1168844pjb.27.2021.10.18.22.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 22:17:36 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 02/10] xtensa: use a14 instead of a15 in inline assembly
Date:   Mon, 18 Oct 2021 22:17:08 -0700
Message-Id: <20211019051716.4173-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211019051716.4173-1-jcmvbkbc@gmail.com>
References: <20211019051716.4173-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

a15 is a frame pointer in the call0 xtensa ABI, don't use it explicitly
in the inline assembly. Use a14 instead, as it has the same properties
as a15 w.r.t. window overflow.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/atomic.h  | 26 +++++++++++++-------------
 arch/xtensa/include/asm/cmpxchg.h | 16 ++++++++--------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/xtensa/include/asm/atomic.h b/arch/xtensa/include/asm/atomic.h
index 4361fe4247e3..52da614f953c 100644
--- a/arch/xtensa/include/asm/atomic.h
+++ b/arch/xtensa/include/asm/atomic.h
@@ -25,15 +25,15 @@
  *
  * Locking interrupts looks like this:
  *
- *    rsil a15, TOPLEVEL
+ *    rsil a14, TOPLEVEL
  *    <code>
- *    wsr  a15, PS
+ *    wsr  a14, PS
  *    rsync
  *
- * Note that a15 is used here because the register allocation
+ * Note that a14 is used here because the register allocation
  * done by the compiler is not guaranteed and a window overflow
  * may not occur between the rsil and wsr instructions. By using
- * a15 in the rsil, the machine is guaranteed to be in a state
+ * a14 in the rsil, the machine is guaranteed to be in a state
  * where no register reference will cause an overflow.
  */
 
@@ -185,15 +185,15 @@ static inline void arch_atomic_##op(int i, atomic_t * v)		\
 	unsigned int vval;						\
 									\
 	__asm__ __volatile__(						\
-			"       rsil    a15, "__stringify(TOPLEVEL)"\n"	\
+			"       rsil    a14, "__stringify(TOPLEVEL)"\n"	\
 			"       l32i    %[result], %[mem]\n"		\
 			"       " #op " %[result], %[result], %[i]\n"	\
 			"       s32i    %[result], %[mem]\n"		\
-			"       wsr     a15, ps\n"			\
+			"       wsr     a14, ps\n"			\
 			"       rsync\n"				\
 			: [result] "=&a" (vval), [mem] "+m" (*v)	\
 			: [i] "a" (i)					\
-			: "a15", "memory"				\
+			: "a14", "memory"				\
 			);						\
 }									\
 
@@ -203,15 +203,15 @@ static inline int arch_atomic_##op##_return(int i, atomic_t * v)	\
 	unsigned int vval;						\
 									\
 	__asm__ __volatile__(						\
-			"       rsil    a15,"__stringify(TOPLEVEL)"\n"	\
+			"       rsil    a14,"__stringify(TOPLEVEL)"\n"	\
 			"       l32i    %[result], %[mem]\n"		\
 			"       " #op " %[result], %[result], %[i]\n"	\
 			"       s32i    %[result], %[mem]\n"		\
-			"       wsr     a15, ps\n"			\
+			"       wsr     a14, ps\n"			\
 			"       rsync\n"				\
 			: [result] "=&a" (vval), [mem] "+m" (*v)	\
 			: [i] "a" (i)					\
-			: "a15", "memory"				\
+			: "a14", "memory"				\
 			);						\
 									\
 	return vval;							\
@@ -223,16 +223,16 @@ static inline int arch_atomic_fetch_##op(int i, atomic_t * v)		\
 	unsigned int tmp, vval;						\
 									\
 	__asm__ __volatile__(						\
-			"       rsil    a15,"__stringify(TOPLEVEL)"\n"	\
+			"       rsil    a14,"__stringify(TOPLEVEL)"\n"	\
 			"       l32i    %[result], %[mem]\n"		\
 			"       " #op " %[tmp], %[result], %[i]\n"	\
 			"       s32i    %[tmp], %[mem]\n"		\
-			"       wsr     a15, ps\n"			\
+			"       wsr     a14, ps\n"			\
 			"       rsync\n"				\
 			: [result] "=&a" (vval), [tmp] "=&a" (tmp),	\
 			  [mem] "+m" (*v)				\
 			: [i] "a" (i)					\
-			: "a15", "memory"				\
+			: "a14", "memory"				\
 			);						\
 									\
 	return vval;							\
diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/cmpxchg.h
index 3699e2818efb..eb87810357ad 100644
--- a/arch/xtensa/include/asm/cmpxchg.h
+++ b/arch/xtensa/include/asm/cmpxchg.h
@@ -52,16 +52,16 @@ __cmpxchg_u32(volatile int *p, int old, int new)
 	return new;
 #else
 	__asm__ __volatile__(
-			"       rsil    a15, "__stringify(TOPLEVEL)"\n"
+			"       rsil    a14, "__stringify(TOPLEVEL)"\n"
 			"       l32i    %[old], %[mem]\n"
 			"       bne     %[old], %[cmp], 1f\n"
 			"       s32i    %[new], %[mem]\n"
 			"1:\n"
-			"       wsr     a15, ps\n"
+			"       wsr     a14, ps\n"
 			"       rsync\n"
 			: [old] "=&a" (old), [mem] "+m" (*p)
 			: [cmp] "a" (old), [new] "r" (new)
-			: "a15", "memory");
+			: "a14", "memory");
 	return old;
 #endif
 }
@@ -116,10 +116,10 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
 /*
  * xchg_u32
  *
- * Note that a15 is used here because the register allocation
+ * Note that a14 is used here because the register allocation
  * done by the compiler is not guaranteed and a window overflow
  * may not occur between the rsil and wsr instructions. By using
- * a15 in the rsil, the machine is guaranteed to be in a state
+ * a14 in the rsil, the machine is guaranteed to be in a state
  * where no register reference will cause an overflow.
  */
 
@@ -157,14 +157,14 @@ static inline unsigned long xchg_u32(volatile int * m, unsigned long val)
 #else
 	unsigned long tmp;
 	__asm__ __volatile__(
-			"       rsil    a15, "__stringify(TOPLEVEL)"\n"
+			"       rsil    a14, "__stringify(TOPLEVEL)"\n"
 			"       l32i    %[tmp], %[mem]\n"
 			"       s32i    %[val], %[mem]\n"
-			"       wsr     a15, ps\n"
+			"       wsr     a14, ps\n"
 			"       rsync\n"
 			: [tmp] "=&a" (tmp), [mem] "+m" (*m)
 			: [val] "a" (val)
-			: "a15", "memory");
+			: "a14", "memory");
 	return tmp;
 #endif
 }
-- 
2.20.1

