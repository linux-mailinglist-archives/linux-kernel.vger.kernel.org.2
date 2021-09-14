Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB2540B462
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhINQU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhINQUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:20:24 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8718FC061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:19:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m16-20020a25d410000000b005ab243aaaf4so13530723ybf.20
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ruv7ezEWWdUTVVZLqSe78q272b/bMY/ySC1JyxSYFiY=;
        b=kSQFla5goeALrlJJglGShYI58OnYi8n8lNeZAQmsyOVFVcov0bfzPiR4j7C7zcM7Xw
         yF4vcfBZIj4YlKKiz0Hw8BAS0s7Aw82FbD2l7aicpd9Z9Xn4w+Rf7jz//DiZNgyQ+sgc
         ultxKeOLXVO/N6+ptCKiVQZQ7oFt/xiGP45U58XxuOp/yeCVMldlIzrFjmTfuoMhSdid
         bxGeZicGy2KfLRgi3u/cs8umaU5WfRH3SS8G7vy8Odqm3X+LkM697vxJXc0PVbxl2E3A
         ggv9l1lSvl2CRvTa1l6vH0h0iYrnO52Y1T8A8e77o6taqG1n5XS23SNvNMXGHBPk4n2b
         dp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ruv7ezEWWdUTVVZLqSe78q272b/bMY/ySC1JyxSYFiY=;
        b=w1aD0oXbaAy5R1R+chhrgsMNs/Zvw4iPUq23NgMGz8HsN75xs8p+JJRpVMs7EukWms
         yumIOo0AT2302U0iBBmfQlECmNJNXwfLgCV5qbX3J3AHjSTb2j56SvejLh9HjfBulEOA
         G3YzS5+FzZJYncupFmORIqMelHaTE5o5h2IpzkpcB6Deqa8kPbXNLNweDWsDkCievsQD
         0PuPGLocFyhX61WN+/of3cSLq+rLwecRWd8Aow6xwMAfbxEcPMvrE6V81Hj3XrMyOh83
         31QU74UlbTy9lVNanpFGU5QnEHVCmzuVQ2f4R5kZayEuPVP4Yu1oqMfVTuD937xglrYR
         UzgQ==
X-Gm-Message-State: AOAM530gxvLkszrXDSFVKQPUQhPARviHJlbqtWBtzhSYQ7Dl3FViCj89
        RfcYdUv1L0nGtiySz/EFmcoZP5C8Dgzl7D26fhc=
X-Google-Smtp-Source: ABdhPJw9RLm32EL4GnbLXlA33WVRSTqrf7sM0HxL6TI8e7GhDqbjh06RFLuyVaPPTR3C85JrmG1m7RxSH+8qBqmTWRo=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:4780:ab8c:bb56:31d6])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6902:1002:: with SMTP id
 w2mr21614613ybt.183.1631636346725; Tue, 14 Sep 2021 09:19:06 -0700 (PDT)
Date:   Tue, 14 Sep 2021 09:17:04 -0700
Message-Id: <20210914161712.2463458-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH] powerpc: clean up UPD_CONSTR
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Daniel Axtens <dja@axtens.net>,
        Dan Williams <dan.j.williams@intel.com>,
        "Christopher M. Riedl" <cmr@codefail.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UPD_CONSTR was previously a preprocessor define for an old GCC 4.9 inline
asm bug with m<> constraints.

Fixes: 6563139d90ad ("powerpc: remove GCC version check for UPD_CONSTR")
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/powerpc/include/asm/asm-const.h | 2 --
 arch/powerpc/include/asm/atomic.h    | 8 ++++----
 arch/powerpc/include/asm/io.h        | 4 ++--
 arch/powerpc/include/asm/uaccess.h   | 6 +++---
 arch/powerpc/kvm/powerpc.c           | 4 ++--
 5 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-const.h b/arch/powerpc/include/asm/asm-const.h
index dbfa5e1e3198..bfb3c3534877 100644
--- a/arch/powerpc/include/asm/asm-const.h
+++ b/arch/powerpc/include/asm/asm-const.h
@@ -12,6 +12,4 @@
 #  define ASM_CONST(x)		__ASM_CONST(x)
 #endif
 
-#define UPD_CONSTR "<>"
-
 #endif /* _ASM_POWERPC_ASM_CONST_H */
diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 6a53ef178bfd..fd594fdbd84d 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -27,14 +27,14 @@ static __inline__ int arch_atomic_read(const atomic_t *v)
 {
 	int t;
 
-	__asm__ __volatile__("lwz%U1%X1 %0,%1" : "=r"(t) : "m"UPD_CONSTR(v->counter));
+	__asm__ __volatile__("lwz%U1%X1 %0,%1" : "=r"(t) : "m<>"(v->counter));
 
 	return t;
 }
 
 static __inline__ void arch_atomic_set(atomic_t *v, int i)
 {
-	__asm__ __volatile__("stw%U0%X0 %1,%0" : "=m"UPD_CONSTR(v->counter) : "r"(i));
+	__asm__ __volatile__("stw%U0%X0 %1,%0" : "=m<>"(v->counter) : "r"(i));
 }
 
 #define ATOMIC_OP(op, asm_op)						\
@@ -320,14 +320,14 @@ static __inline__ s64 arch_atomic64_read(const atomic64_t *v)
 {
 	s64 t;
 
-	__asm__ __volatile__("ld%U1%X1 %0,%1" : "=r"(t) : "m"UPD_CONSTR(v->counter));
+	__asm__ __volatile__("ld%U1%X1 %0,%1" : "=r"(t) : "m<>"(v->counter));
 
 	return t;
 }
 
 static __inline__ void arch_atomic64_set(atomic64_t *v, s64 i)
 {
-	__asm__ __volatile__("std%U0%X0 %1,%0" : "=m"UPD_CONSTR(v->counter) : "r"(i));
+	__asm__ __volatile__("std%U0%X0 %1,%0" : "=m<>"(v->counter) : "r"(i));
 }
 
 #define ATOMIC64_OP(op, asm_op)						\
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index f130783c8301..beba4979bff9 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -122,7 +122,7 @@ static inline u##size name(const volatile u##size __iomem *addr)	\
 {									\
 	u##size ret;							\
 	__asm__ __volatile__("sync;"#insn"%U1%X1 %0,%1;twi 0,%0,0;isync"\
-		: "=r" (ret) : "m"UPD_CONSTR (*addr) : "memory");	\
+		: "=r" (ret) : "m<>" (*addr) : "memory");	\
 	return ret;							\
 }
 
@@ -130,7 +130,7 @@ static inline u##size name(const volatile u##size __iomem *addr)	\
 static inline void name(volatile u##size __iomem *addr, u##size val)	\
 {									\
 	__asm__ __volatile__("sync;"#insn"%U0%X0 %1,%0"			\
-		: "=m"UPD_CONSTR (*addr) : "r" (val) : "memory");	\
+		: "=m<>" (*addr) : "r" (val) : "memory");	\
 	mmiowb_set_pending();						\
 }
 
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 22c79ab40006..63316100080c 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -86,7 +86,7 @@ __pu_failed:							\
 		"1:	" op "%U1%X1 %0,%1	# put_user\n"	\
 		EX_TABLE(1b, %l2)				\
 		:						\
-		: "r" (x), "m"UPD_CONSTR (*addr)		\
+		: "r" (x), "m<>" (*addr)		\
 		:						\
 		: label)
 
@@ -143,7 +143,7 @@ do {								\
 		"1:	"op"%U1%X1 %0, %1	# get_user\n"	\
 		EX_TABLE(1b, %l2)				\
 		: "=r" (x)					\
-		: "m"UPD_CONSTR (*addr)				\
+		: "m<>" (*addr)				\
 		:						\
 		: label)
 
@@ -200,7 +200,7 @@ __gus_failed:								\
 		".previous\n"				\
 		EX_TABLE(1b, 3b)			\
 		: "=r" (err), "=r" (x)			\
-		: "m"UPD_CONSTR (*addr), "i" (-EFAULT), "0" (err))
+		: "m<>" (*addr), "i" (-EFAULT), "0" (err))
 
 #ifdef __powerpc64__
 #define __get_user_asm2(x, addr, err)			\
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index b4e6f70b97b9..3fd037d36afb 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1094,7 +1094,7 @@ static inline u64 sp_to_dp(u32 fprs)
 
 	preempt_disable();
 	enable_kernel_fp();
-	asm ("lfs%U1%X1 0,%1; stfd%U0%X0 0,%0" : "=m"UPD_CONSTR (fprd) : "m"UPD_CONSTR (fprs)
+	asm ("lfs%U1%X1 0,%1; stfd%U0%X0 0,%0" : "=m<>" (fprd) : "m<>" (fprs)
 	     : "fr0");
 	preempt_enable();
 	return fprd;
@@ -1106,7 +1106,7 @@ static inline u32 dp_to_sp(u64 fprd)
 
 	preempt_disable();
 	enable_kernel_fp();
-	asm ("lfd%U1%X1 0,%1; stfs%U0%X0 0,%0" : "=m"UPD_CONSTR (fprs) : "m"UPD_CONSTR (fprd)
+	asm ("lfd%U1%X1 0,%1; stfs%U0%X0 0,%0" : "=m<>" (fprs) : "m<>" (fprd)
 	     : "fr0");
 	preempt_enable();
 	return fprs;
-- 
2.33.0.309.g3052b89438-goog

