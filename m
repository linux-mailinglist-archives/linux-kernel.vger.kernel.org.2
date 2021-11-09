Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A999044B173
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 17:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbhKIQtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 11:49:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:59894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240237AbhKIQtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 11:49:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B8E8610CF;
        Tue,  9 Nov 2021 16:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636476378;
        bh=At1u3b+sYqBlXNyVUOqEsPvWFsVQ3X42m8iZpZWPAhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZGd5cLks9EUe3zAi3JimnKMf6MRlw+jafWKpV36KAVE1sSZ4k+2cSOcNaV6d+TWuO
         QqQJWuRdAyoJ8qHEtbrBf6qQSfPESYUxQE/FC+zU9AXXv2WnOuLMINWgnARFqq6sOL
         s4LSz2w61FIQpG5rXishROE9i1o6Rj0u12lP5z01VBi2Q1kat2oAr3hmgTY0XiVJ9g
         Pj/WmkUaXpF0WNiYI1Y8ifuIsLwpsgs6lk0j/WYG3b7LTjOTum/JxgCGXraVuGrkM5
         vhrotrfoaq5nXklf67YsEtDSopRi90R1dNJXOznAgjylJzNZouZZdFKubIaDvW/Np2
         Hwg6NaDBY5FJg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [RFC PATCH 4/7] static_call: fix broken static_call_query() for non-exported keys
Date:   Tue,  9 Nov 2021 17:45:46 +0100
Message-Id: <20211109164549.1724710-5-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109164549.1724710-1-ardb@kernel.org>
References: <20211109164549.1724710-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6201; h=from:subject; bh=At1u3b+sYqBlXNyVUOqEsPvWFsVQ3X42m8iZpZWPAhg=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBhiqW236pCzHlHpC/JKEQCBJcnxNmBDaSOLbE42NWi XfPhW3WJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYYqltgAKCRDDTyI5ktmPJKkKDA CltCe4pjql1KgI3pIsdvxX2XQQsj0ncfZIrFcQl5ZzZ4YZukRfHkgKmqOcAhpHoC+O1gNJBp7PBQz6 QdWup52/U6TrP6oDcSXZeWWuXo7A8BrFDwFRlyvqU7yCRXosscLBgl5ik6ESm7fJmUNn+K1Q/U9tt5 KFO4+UN9KHeannGGbtNMjnHykhwW/FyE3So4oI1Q1CBhsI4++hL0vyQVmcxG97Ojmqs3mBIXYx+pAS RO+kXwtR0nMNENg+6zgcnrpeLU9sZoJmpihs8W+8Q651UElphwv+9EZ4G85IKUs58A1grr+SriPsBI WTHqlwx1e+j2PYqbzbdY/M8g66wxCDFQanLrvpW7WIdSYIct4IUzIn3GAI61eWAERFRaYSlOH5MLS9 Tv5LcSTHKFmx2Ey/uYUqblUBifu+6caRR5PiMLTKq8EDYr+Z03Mbi6fuAJym0YyOWPYiqu7irwF0aZ ebS2nV7KCRWUWK2v4FfAm+ZVCagnIZOvE3j8y+azUDs9U=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

static_call_query() accesses the func member of the static call key
directly, which means that it is broken for cases where it is used from
a module and the key resides elsewhere and is not exported.

Let's add a helper that returns this value, and export it from the same
module that the key resides in if the key itself is not exported. This
way, we can always get the value regardless of whether the key is
exported or not.

Note that the non-NULL check of &STATIC_CALL_KEY(...) does not typically
result in a load: for ISAs that support relocatable immediates, the
address is patched into the instruction stream.

For example, on ARM/Thumb2, we get

 14a:   f240 0300       movw    r3, #0
                        14a: R_ARM_THM_MOVW_ABS_NC      __SCK__pv_steal_clock
 14e:   f2c0 0300       movt    r3, #0
                        14e: R_ARM_THM_MOVT_ABS         __SCK__pv_steal_clock
 152:   b10b            cbz     r3, 158 <foo+0x14>
 154:   6818            ldr     r0, [r3, #0]
 156:   4770            bx      lr
 158:   f7ff bffe       b.w     0 <__SCQ__pv_steal_clock>
                        158: R_ARM_THM_JUMP24           __SCQ__pv_steal_clock

I.e., it performs a conditional branch if zero (CBZ) on a quantity that
was loaded using an MOVW/MOVT move-immediate pair, and either loads the
func member directly, or tail calls __SCQ__pv_steal_clock if they key is
not exported.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/static_call.h             |  9 ++++++++-
 include/linux/static_call_types.h       | 18 +++++++++++++++++-
 tools/include/linux/static_call_types.h | 18 +++++++++++++++++-
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 3bba0bcba844..391f737496eb 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -149,7 +149,10 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
 			     STATIC_CALL_TRAMP_ADDR(name), __F);	\
 })
 
-#define static_call_query(name) (READ_ONCE(STATIC_CALL_KEY(name).func))
+#define EXPORT_STATIC_CALL_QUERY(name, sfx)				\
+	typeof(STATIC_CALL_QUERY(name)()) STATIC_CALL_QUERY(name)(void)	\
+		{ return STATIC_CALL_KEY(name).func; }			\
+	EXPORT_SYMBOL ## sfx (STATIC_CALL_QUERY(name))
 
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 
@@ -200,9 +203,11 @@ extern long __static_call_return0(void);
 
 /* Leave the key unexported, so modules can't change static call targets: */
 #define EXPORT_STATIC_CALL_TRAMP(name)					\
+	EXPORT_STATIC_CALL_QUERY(name,);				\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name));				\
 	EXPORT_STATIC_CALL_GETKEY_HELPER(name)
 #define EXPORT_STATIC_CALL_TRAMP_GPL(name)				\
+	EXPORT_STATIC_CALL_QUERY(name, _GPL);				\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name));			\
 	EXPORT_STATIC_CALL_GETKEY_HELPER(name)
 
@@ -253,8 +258,10 @@ static inline long __static_call_return0(void)
 
 /* Leave the key unexported, so modules can't change static call targets: */
 #define EXPORT_STATIC_CALL_TRAMP(name)					\
+	EXPORT_STATIC_CALL_QUERY(name,);				\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
 #define EXPORT_STATIC_CALL_TRAMP_GPL(name)				\
+	EXPORT_STATIC_CALL_QUERY(name, _GPL);				\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
 
 #else /* Generic implementation */
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index a31782909e43..2fce9aa8a995 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -23,6 +23,9 @@
 #define STATIC_CALL_GETKEY_PREFIX_LEN	(sizeof(STATIC_CALL_GETKEY_PREFIX_STR) - 1)
 #define STATIC_CALL_GETKEY(name)	__PASTE(STATIC_CALL_GETKEY_PREFIX, name)
 
+#define STATIC_CALL_QUERY_PREFIX	__SCQ__
+#define STATIC_CALL_QUERY(name)		__PASTE(STATIC_CALL_QUERY_PREFIX, name)
+
 /*
  * Flags in the low bits of static_call_site::key.
  */
@@ -43,7 +46,20 @@ struct static_call_site {
 #define DECLARE_STATIC_CALL(name, func)					\
 	extern __weak struct static_call_key STATIC_CALL_KEY(name);	\
 	extern __weak struct static_call_key *STATIC_CALL_GETKEY(name)(void);\
-	extern typeof(func) STATIC_CALL_TRAMP(name);
+	extern __weak typeof(func) *STATIC_CALL_QUERY(name)(void);	\
+	extern typeof(func) STATIC_CALL_TRAMP(name)
+
+#define __static_call_query(name)					\
+	((typeof(STATIC_CALL_QUERY(name)()))READ_ONCE(STATIC_CALL_KEY(name).func))
+
+#ifdef MODULE
+/* the key might not be exported */
+#define static_call_query(name)						\
+	(&STATIC_CALL_KEY(name) ? __static_call_query(name)		\
+				: STATIC_CALL_QUERY(name)())
+#else
+#define static_call_query(name)	__static_call_query(name)
+#endif
 
 #ifdef CONFIG_HAVE_STATIC_CALL
 
diff --git a/tools/include/linux/static_call_types.h b/tools/include/linux/static_call_types.h
index a31782909e43..2fce9aa8a995 100644
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -23,6 +23,9 @@
 #define STATIC_CALL_GETKEY_PREFIX_LEN	(sizeof(STATIC_CALL_GETKEY_PREFIX_STR) - 1)
 #define STATIC_CALL_GETKEY(name)	__PASTE(STATIC_CALL_GETKEY_PREFIX, name)
 
+#define STATIC_CALL_QUERY_PREFIX	__SCQ__
+#define STATIC_CALL_QUERY(name)		__PASTE(STATIC_CALL_QUERY_PREFIX, name)
+
 /*
  * Flags in the low bits of static_call_site::key.
  */
@@ -43,7 +46,20 @@ struct static_call_site {
 #define DECLARE_STATIC_CALL(name, func)					\
 	extern __weak struct static_call_key STATIC_CALL_KEY(name);	\
 	extern __weak struct static_call_key *STATIC_CALL_GETKEY(name)(void);\
-	extern typeof(func) STATIC_CALL_TRAMP(name);
+	extern __weak typeof(func) *STATIC_CALL_QUERY(name)(void);	\
+	extern typeof(func) STATIC_CALL_TRAMP(name)
+
+#define __static_call_query(name)					\
+	((typeof(STATIC_CALL_QUERY(name)()))READ_ONCE(STATIC_CALL_KEY(name).func))
+
+#ifdef MODULE
+/* the key might not be exported */
+#define static_call_query(name)						\
+	(&STATIC_CALL_KEY(name) ? __static_call_query(name)		\
+				: STATIC_CALL_QUERY(name)())
+#else
+#define static_call_query(name)	__static_call_query(name)
+#endif
 
 #ifdef CONFIG_HAVE_STATIC_CALL
 
-- 
2.30.2

