Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1510E446550
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 15:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhKEPCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 11:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233299AbhKEPCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 11:02:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA2F56120E;
        Fri,  5 Nov 2021 14:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636124367;
        bh=LTEQ9tKb2OswdfIaK6ja2qhw7vJe2vjWwbgDDi2F2KI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KHxZwMnWoLSCh3BplkdKQx55GLWP3miOHICLoAs65/DObBdbqbanivKtkFLGBTuPX
         LoKuOKGJxg1p8owN4n16YXrjCtiBJ3vv8EqGGgmENYLyo2zoAsoXnVT/LCRHQtWK4/
         a5jXUFpY1g3uktx/gbFOsIWxX+pN19J/PMuQjUupzVwlqQbr8EonJG4JEXaHt8CNwz
         q7/0GorvtpHTpOC7yvvtpHxJjrARgaPMwD4BSlJOEqxNVGQYJUauSMRGGq7Eaa/pUC
         5dc8ljuRm9kCJPyA2yBDdLiYoVEsZNRIu1e66LeVaNsVlc8i8WntNsFNPw75cs7O4A
         yi22ifteqDnSQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v6 1/2] static_call: use non-function types to refer to the trampolines
Date:   Fri,  5 Nov 2021 15:59:16 +0100
Message-Id: <20211105145917.2828911-2-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211105145917.2828911-1-ardb@kernel.org>
References: <20211105145917.2828911-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2779; h=from:subject; bh=LTEQ9tKb2OswdfIaK6ja2qhw7vJe2vjWwbgDDi2F2KI=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBhhUbCOTl4Vs8hTbJG0j/c1dP2rCZXXb9EsgKFaSQ5 V6x8sKCJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYYVGwgAKCRDDTyI5ktmPJBQJC/ 495LgbATNfrHgBMTSiz5iUUHKuHyFuSuB3KqdYiLLGeiwplhoXPUY91mlb+XOWWhox+63pVm5xXZt/ bBq0peBfZugdvP7N6V7jFzGiWS3De4Ogo/0h57OJUZhp2KljqWkE8dmr38s6/z5f+zje2+faPEdPia iOWFLNWDiYazX+RO40O1JfnlUmDRXNdMpPHPLU/UCE6yxUuoyOIq820m8PIlG1Tv45Q4UzcriodI2H 5tQzOgnHgSB0jZLjqa8FeD92OgK37SjHDyQgaATBHQ4Bnc8r4FT5fsL+JLqZ6L4SnOTppR5tQ2XhvG eifgHLi+P7DZWaUkh1klmgIXIkF6os06+6lTn+CiQJxrkak1Np/kxc13b0toiny/Zf8THtbzOgYl6t jifC8hYC8RcKDowGjmc5s5bUwpjWdA3iONKUtjl49Fi15/zFEzThtg3apWyeHyFuOTQkEnHso7EXj9 OJ2ZyshYWzKbyvVJn4vbJJZB0GKRHvimvvL+JHEdeKNz0=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prevent CFI enabled code from grabbing a jump table entry
that jumps to the trampoline, rather than the trampoline itself, use an
incomplete non-function type for the trampoline, and cast it to the
right type only when invoking it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/static_call.h       |  4 ++--
 include/linux/static_call_types.h | 11 ++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 3e56a9751c06..616607393273 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -151,7 +151,7 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
 
 #define static_call_update(name, func)					\
 ({									\
-	typeof(&STATIC_CALL_TRAMP(name)) __F = (func);			\
+	typeof(&STATIC_CALL_TYPE(name)) __F = (func);			\
 	__static_call_update(&STATIC_CALL_KEY(name),			\
 			     STATIC_CALL_TRAMP_ADDR(name), __F);	\
 })
@@ -306,7 +306,7 @@ static inline void __static_call_nop(void) { }
 	void *func = READ_ONCE(STATIC_CALL_KEY(name).func);		\
 	if (!func)							\
 		func = &__static_call_nop;				\
-	(typeof(STATIC_CALL_TRAMP(name))*)func;				\
+	(typeof(&STATIC_CALL_TYPE(name)))func;				\
 })
 
 #define static_call_cond(name)	(void)__static_call_cond(name)
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index 5a00b8b2cf9f..5e658ef537e4 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -18,6 +18,9 @@
 #define STATIC_CALL_TRAMP(name)		__PASTE(STATIC_CALL_TRAMP_PREFIX, name)
 #define STATIC_CALL_TRAMP_STR(name)	__stringify(STATIC_CALL_TRAMP(name))
 
+#define STATIC_CALL_TYPE_PREFIX		__SCtype__
+#define STATIC_CALL_TYPE(name)		__PASTE(STATIC_CALL_TYPE_PREFIX, name)
+
 /*
  * Flags in the low bits of static_call_site::key.
  */
@@ -36,11 +39,13 @@ struct static_call_site {
 
 #define DECLARE_STATIC_CALL(name, func)					\
 	extern struct static_call_key STATIC_CALL_KEY(name);		\
-	extern typeof(func) STATIC_CALL_TRAMP(name);
+	extern struct static_call_tramp STATIC_CALL_TRAMP(name);	\
+	extern typeof(func) STATIC_CALL_TYPE(name)
 
 #ifdef CONFIG_HAVE_STATIC_CALL
 
-#define __raw_static_call(name)	(&STATIC_CALL_TRAMP(name))
+#define __raw_static_call(name)						\
+	((typeof(&STATIC_CALL_TYPE(name)))&STATIC_CALL_TRAMP(name))
 
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 
@@ -96,7 +101,7 @@ struct static_call_key {
 };
 
 #define static_call(name)						\
-	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
+	((typeof(&STATIC_CALL_TYPE(name)))(STATIC_CALL_KEY(name).func))
 
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
-- 
2.30.2

