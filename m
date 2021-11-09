Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378C444B174
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 17:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240441AbhKIQtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 11:49:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:59916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239801AbhKIQtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 11:49:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77B5361208;
        Tue,  9 Nov 2021 16:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636476380;
        bh=y4wX9s7+HTFSjvSFbSz19j1vGuRP1pTMfkmfOmSDxk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K2HMR0HhOmDIjnKehI2zVcTXPq9wGyta0DEKpQg2jTiHG7jhmALFUsLkzG08xldsA
         wlo+v7aGh7S5m0+NIUatxOL3oigNXbkSK9UbDbZ0fC29FYujAGOWXta3q2Ln87m5sK
         TjgZnVTKb+MRpDVnhqAz7xrCKyE9ty+/9J7WEFLfiHEShFXsXGqo0ho41zIj4lvdZ5
         LBbtzM8HnhgCk7aT6cLYhT8rSy+batd5g11u/dmBVx8Vk9Q+4u/m6EDttdcoVXFVFY
         bi4K/tcPEx/2fxY2rtuSB6IrUiRocgtULA7Wjw/+ZdWm0vAzBYcE9QfGVyxcbEetFM
         r0n//gdXyinoA==
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
Subject: [RFC PATCH 5/7] static_call: use non-function types to refer to the trampolines
Date:   Tue,  9 Nov 2021 17:45:47 +0100
Message-Id: <20211109164549.1724710-6-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109164549.1724710-1-ardb@kernel.org>
References: <20211109164549.1724710-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3650; h=from:subject; bh=y4wX9s7+HTFSjvSFbSz19j1vGuRP1pTMfkmfOmSDxk0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBhiqW4kuuGzSKDlkzz0Prr9jyqVx4AQlIlqxGFdRli /7KncCGJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYYqluAAKCRDDTyI5ktmPJE3UC/ 4p0HTDMxRSJjJf/8PM0gRDp1+LIR1qeOeEhRxErabIqKkFs93BL+JUNgdDqFVDedZnHVP06Gw7zFZl gH4Kb9cn5wVIkLg+3UnZf1hHAu9r0cDk+jZHWlqY1Z4jVIYWBY6eKqZ5icgGd45gWeMSubeBJ7zcex RZCgqSdFvzhmRBnB9X5s+Rkv9EMuDtwQGYUPdHlh+ezQu9fQTo0H31kdlesKhqeXM8cY+fr9rYcPPx CGdv/TXZQJjoQyoB6Ldua6xst+ruUyuQT20FPD5v8s9536+0r148lSCGXlFQPGgpjd87c1TTf0Y+L3 +01rsbJAGslVw6m89pEQ6HsIgyUY5M89x77pYZLoi6UwrFK5L+VIqQLkUaI7QuD9+fRp3AfCMlTGro jjhjuHPikYB7skd5HoKLkjJAbpu9y9KWX/La123QpTghAuZ1eL1F9cT9e1W7rmX6t0hQQ6ukzQqus5 gMy0TLikfsxKQ9Lo8XvdyZStVt6eGnpmE+J0dMTJDh3H4=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prevent CFI enabled code from grabbing a jump table entry
that jumps to the trampoline, rather than the trampoline itself, use an
incomplete non-function type for the trampoline, and cast it to the
right type only when invoking it.

Acked-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/static_call.h             | 2 +-
 include/linux/static_call_types.h       | 6 +++---
 tools/include/linux/static_call_types.h | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 391f737496eb..6b261fe96ba3 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -144,7 +144,7 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
 
 #define static_call_update(name, func)					\
 ({									\
-	typeof(&STATIC_CALL_TRAMP(name)) __F = (func);			\
+	typeof(STATIC_CALL_QUERY(name)()) __F = (func);			\
 	__static_call_update(&STATIC_CALL_KEY(name),			\
 			     STATIC_CALL_TRAMP_ADDR(name), __F);	\
 })
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index 2fce9aa8a995..eae11c5b015d 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -47,7 +47,7 @@ struct static_call_site {
 	extern __weak struct static_call_key STATIC_CALL_KEY(name);	\
 	extern __weak struct static_call_key *STATIC_CALL_GETKEY(name)(void);\
 	extern __weak typeof(func) *STATIC_CALL_QUERY(name)(void);	\
-	extern typeof(func) STATIC_CALL_TRAMP(name)
+	extern struct static_call_tramp STATIC_CALL_TRAMP(name)
 
 #define __static_call_query(name)					\
 	((typeof(STATIC_CALL_QUERY(name)()))READ_ONCE(STATIC_CALL_KEY(name).func))
@@ -66,7 +66,7 @@ struct static_call_site {
 #define static_call(name)						\
 ({									\
 	__STATIC_CALL_ADDRESSABLE(name);				\
-	(&STATIC_CALL_TRAMP(name));					\
+	((typeof(STATIC_CALL_QUERY(name)()))&STATIC_CALL_TRAMP(name));	\
 })
 
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
@@ -107,7 +107,7 @@ struct static_call_key {
 };
 
 #define static_call(name)						\
-	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
+	((typeof(STATIC_CALL_QUERY(name)()))(STATIC_CALL_KEY(name).func))
 
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
diff --git a/tools/include/linux/static_call_types.h b/tools/include/linux/static_call_types.h
index 2fce9aa8a995..eae11c5b015d 100644
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -47,7 +47,7 @@ struct static_call_site {
 	extern __weak struct static_call_key STATIC_CALL_KEY(name);	\
 	extern __weak struct static_call_key *STATIC_CALL_GETKEY(name)(void);\
 	extern __weak typeof(func) *STATIC_CALL_QUERY(name)(void);	\
-	extern typeof(func) STATIC_CALL_TRAMP(name)
+	extern struct static_call_tramp STATIC_CALL_TRAMP(name)
 
 #define __static_call_query(name)					\
 	((typeof(STATIC_CALL_QUERY(name)()))READ_ONCE(STATIC_CALL_KEY(name).func))
@@ -66,7 +66,7 @@ struct static_call_site {
 #define static_call(name)						\
 ({									\
 	__STATIC_CALL_ADDRESSABLE(name);				\
-	(&STATIC_CALL_TRAMP(name));					\
+	((typeof(STATIC_CALL_QUERY(name)()))&STATIC_CALL_TRAMP(name));	\
 })
 
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
@@ -107,7 +107,7 @@ struct static_call_key {
 };
 
 #define static_call(name)						\
-	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
+	((typeof(STATIC_CALL_QUERY(name)()))(STATIC_CALL_KEY(name).func))
 
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
-- 
2.30.2

