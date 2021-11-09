Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C3244B171
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 17:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239751AbhKIQtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 11:49:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239801AbhKIQs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 11:48:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BED5610C8;
        Tue,  9 Nov 2021 16:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636476373;
        bh=7ZzvhFtWbybOkWfYS+IfbRYBGhMJHNq1ETuGEWSXG/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=INqH8qsyvPNUfdrOXzBWLDvK3LU1P5zOBLpD7JTtRYUWGIkw6HIolxxS1UPSos8No
         eRAinHUAasjdj7IZNsLApFLqJ4etsVwgU7iEZe1lQhU4rZ+ML9n3bfRs2b7r5OtRjz
         xE23kwmsdpvIFNUMjlRjnq/7VKcuTRRlx9/87xduB6ASR3aDkREOismlGsObbQNdgm
         dONchXISk9LyHbOFJeuRY2LqRcT7wFK/79BEPTDj2Hi8g1UqOE+Cq7/Zex1MI7Jq71
         HoiGzd7ANbMnHqUIiv1/8fbzBBxho+h4tqeibclgG1mhkxV4Lh74hb+faS+TIK7i6p
         tP6+AhRR8da9g==
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
Subject: [RFC PATCH 2/7] static_call: deal with unexported keys without cluttering up the API
Date:   Tue,  9 Nov 2021 17:45:44 +0100
Message-Id: <20211109164549.1724710-3-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109164549.1724710-1-ardb@kernel.org>
References: <20211109164549.1724710-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10376; h=from:subject; bh=7ZzvhFtWbybOkWfYS+IfbRYBGhMJHNq1ETuGEWSXG/E=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBhiqWx/EBUslL3LMMQ+zW/g55WcXPOmZoxDa6RujDX 1rjH97qJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYYqlsQAKCRDDTyI5ktmPJMlMC/ 9XAHyASjqKYt7Z1Z2ajFarzhmXmQOmVUKQZgfkYw4rBhtnpm5sYHVwDuYwhcL+gpw3ZhwUPp48Tfsb BBhcfdqee9LZkJ5gqRV6JNQfYV06fb9bqLRQ/QnVOcgJxrSZfpth1lp0hGKVmHMGkNozFFQDUmkW+k BCWRl24mLerxw4OG7tmM6DSFptYUA9ydkdZsSQkfrQ6OoKn1LLUlxZGSvm2U005Ui/zfSuJDncYVwH TNzadjZYA9bvMisUgTEpgBscEl2zCGSHAZmnu2MMtyRrgPW//hKMqur2zgq6m95NihyfZ3qjdxGz8n yZgJ007ZL9ROTvt6Mb1zaXzkiboNcE0XsMTT3Wad6hQ03fRp6h1UVHvBz5hcW8Ub7iiAWjuNUZtEYN CnWNTAOI7Smq/cZyQcVDaCyQ1rTJIWe+6rbGqXaJFVxmxadQzg0kb18Yn+yrzJSZzy3kRwwrRmLaoJ EiEMQhi+oY9ojdRsVEbOu+B9zJR41B5Psu1tly1CsPpd4=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In principle, invoking a static call does not require access to the
static call key that is used to manipulate the function that the static
call targets. This means that exporting only the static call but not its
key to modules should prevent such modules from manipulating the target
inadvertently.

However, for inline static calls, we do need access to the key at module
load time, because the code patching routines rely on it. For this
reason, there is special handling in objtool that recovers the key
pointer from the address of the trampoline (which does get exported
unconditionally), using a lookup table in the core kernel.

Unfortunately, this clutters up the user-visible API: a static call is
normally invoked using the static_call() macro, but in cases where a)
the call originates from a module and b) the associated key was not
exported, it is left up to the user to pick the static_call_mod() macro
instead. Since that macro relies on the lookup table in the core kernel,
it can only be used on static calls that are exported from the core
kernel.

It would be much better if the call sites can simply use static_call()
and not have to figure out whether or not the static call exports its
key and/or whether it as exported from the core kernel.

So let's address this, by using a weak reference for the key. This means
we can force the symbol reference in the module to be emitted
unconditionally, allowing the caller to use static_call() without
knowing the difference. This does imply that the logic in objtool that
tests whether a symbol exists in the object no longer works, as the
symbol is guaranteed to exist. So instead, add another field to struct
static_call_site to cover the trampoline reference, and fix up the
module notifier that consumes this data accordingly.

This gets rid of the following macros:

  __STATIC_CALL_MOD_ADDRESSABLE()
  static_call_mod()
  __static_call()
  __raw_static_call()

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/preempt.h          |  4 +--
 include/linux/kernel.h                  |  2 +-
 include/linux/sched.h                   |  2 +-
 include/linux/static_call_types.h       | 26 +++++-----------
 kernel/static_call.c                    |  8 ++---
 tools/include/linux/static_call_types.h | 26 +++++-----------
 tools/objtool/check.c                   | 31 ++++++++++----------
 7 files changed, 38 insertions(+), 61 deletions(-)

diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index fe5efbcba824..341745a03726 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -121,7 +121,7 @@ DECLARE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
 
 #define __preempt_schedule() \
 do { \
-	__STATIC_CALL_MOD_ADDRESSABLE(preempt_schedule); \
+	__STATIC_CALL_ADDRESSABLE(preempt_schedule); \
 	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule) : ASM_CALL_CONSTRAINT); \
 } while (0)
 
@@ -129,7 +129,7 @@ DECLARE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
 
 #define __preempt_schedule_notrace() \
 do { \
-	__STATIC_CALL_MOD_ADDRESSABLE(preempt_schedule_notrace); \
+	__STATIC_CALL_ADDRESSABLE(preempt_schedule_notrace); \
 	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule_notrace) : ASM_CALL_CONSTRAINT); \
 } while (0)
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index e5359b09de1d..1e1159878e40 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -101,7 +101,7 @@ DECLARE_STATIC_CALL(might_resched, __cond_resched);
 
 static __always_inline void might_resched(void)
 {
-	static_call_mod(might_resched)();
+	static_call(might_resched)();
 }
 
 #else
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 78c351e35fec..3cdf55c1074c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2014,7 +2014,7 @@ DECLARE_STATIC_CALL(cond_resched, __cond_resched);
 
 static __always_inline int _cond_resched(void)
 {
-	return static_call_mod(cond_resched)();
+	return static_call(cond_resched)();
 }
 
 #else
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index 5a00b8b2cf9f..0bb36294cce7 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -32,15 +32,20 @@
 struct static_call_site {
 	s32 addr;
 	s32 key;
+	s32 tramp;
 };
 
 #define DECLARE_STATIC_CALL(name, func)					\
-	extern struct static_call_key STATIC_CALL_KEY(name);		\
+	extern __weak struct static_call_key STATIC_CALL_KEY(name);	\
 	extern typeof(func) STATIC_CALL_TRAMP(name);
 
 #ifdef CONFIG_HAVE_STATIC_CALL
 
-#define __raw_static_call(name)	(&STATIC_CALL_TRAMP(name))
+#define static_call(name)						\
+({									\
+	__STATIC_CALL_ADDRESSABLE(name);				\
+	(&STATIC_CALL_TRAMP(name));					\
+})
 
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 
@@ -52,12 +57,6 @@ struct static_call_site {
 #define __STATIC_CALL_ADDRESSABLE(name) \
 	__ADDRESSABLE(STATIC_CALL_KEY(name))
 
-#define __static_call(name)						\
-({									\
-	__STATIC_CALL_ADDRESSABLE(name);				\
-	__raw_static_call(name);					\
-})
-
 struct static_call_key {
 	void *func;
 	union {
@@ -71,7 +70,6 @@ struct static_call_key {
 #else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
 
 #define __STATIC_CALL_ADDRESSABLE(name)
-#define __static_call(name)	__raw_static_call(name)
 
 struct static_call_key {
 	void *func;
@@ -79,16 +77,6 @@ struct static_call_key {
 
 #endif /* CONFIG_HAVE_STATIC_CALL_INLINE */
 
-#ifdef MODULE
-#define __STATIC_CALL_MOD_ADDRESSABLE(name)
-#define static_call_mod(name)	__raw_static_call(name)
-#else
-#define __STATIC_CALL_MOD_ADDRESSABLE(name) __STATIC_CALL_ADDRESSABLE(name)
-#define static_call_mod(name)	__static_call(name)
-#endif
-
-#define static_call(name)	__static_call(name)
-
 #else
 
 struct static_call_key {
diff --git a/kernel/static_call.c b/kernel/static_call.c
index 43ba0b1e0edb..360cc3cd0fbf 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -366,18 +366,18 @@ static int static_call_add_module(struct module *mod)
 		 * means modules are allowed to call static_call_update() on
 		 * it.
 		 *
-		 * Otherwise, the key isn't exported, and 'addr' points to the
+		 * Otherwise, the key isn't exported, and 'tramp' points to the
 		 * trampoline so we need to lookup the key.
 		 *
 		 * We go through this dance to prevent crazy modules from
 		 * abusing sensitive static calls.
 		 */
-		if (!kernel_text_address(addr))
+		if (addr)
 			continue;
 
-		key = tramp_key_lookup(addr);
+		key = tramp_key_lookup((unsigned long)offset_to_ptr(&site->tramp));
 		if (!key) {
-			pr_warn("Failed to fixup __raw_static_call() usage at: %ps\n",
+			pr_warn("Failed to fixup static_call() usage at: %ps\n",
 				static_call_addr(site));
 			return -EINVAL;
 		}
diff --git a/tools/include/linux/static_call_types.h b/tools/include/linux/static_call_types.h
index 5a00b8b2cf9f..0bb36294cce7 100644
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -32,15 +32,20 @@
 struct static_call_site {
 	s32 addr;
 	s32 key;
+	s32 tramp;
 };
 
 #define DECLARE_STATIC_CALL(name, func)					\
-	extern struct static_call_key STATIC_CALL_KEY(name);		\
+	extern __weak struct static_call_key STATIC_CALL_KEY(name);	\
 	extern typeof(func) STATIC_CALL_TRAMP(name);
 
 #ifdef CONFIG_HAVE_STATIC_CALL
 
-#define __raw_static_call(name)	(&STATIC_CALL_TRAMP(name))
+#define static_call(name)						\
+({									\
+	__STATIC_CALL_ADDRESSABLE(name);				\
+	(&STATIC_CALL_TRAMP(name));					\
+})
 
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 
@@ -52,12 +57,6 @@ struct static_call_site {
 #define __STATIC_CALL_ADDRESSABLE(name) \
 	__ADDRESSABLE(STATIC_CALL_KEY(name))
 
-#define __static_call(name)						\
-({									\
-	__STATIC_CALL_ADDRESSABLE(name);				\
-	__raw_static_call(name);					\
-})
-
 struct static_call_key {
 	void *func;
 	union {
@@ -71,7 +70,6 @@ struct static_call_key {
 #else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
 
 #define __STATIC_CALL_ADDRESSABLE(name)
-#define __static_call(name)	__raw_static_call(name)
 
 struct static_call_key {
 	void *func;
@@ -79,16 +77,6 @@ struct static_call_key {
 
 #endif /* CONFIG_HAVE_STATIC_CALL_INLINE */
 
-#ifdef MODULE
-#define __STATIC_CALL_MOD_ADDRESSABLE(name)
-#define static_call_mod(name)	__raw_static_call(name)
-#else
-#define __STATIC_CALL_MOD_ADDRESSABLE(name) __STATIC_CALL_ADDRESSABLE(name)
-#define static_call_mod(name)	__static_call(name)
-#endif
-
-#define static_call(name)	__static_call(name)
-
 #else
 
 struct static_call_key {
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index add39902166d..ec6ddaaf6cf6 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -652,21 +652,8 @@ static int create_static_call_sections(struct objtool_file *file)
 
 		key_sym = find_symbol_by_name(file->elf, tmp);
 		if (!key_sym) {
-			if (!module) {
-				WARN("static_call: can't find static_call_key symbol: %s", tmp);
-				return -1;
-			}
-
-			/*
-			 * For modules(), the key might not be exported, which
-			 * means the module can make static calls but isn't
-			 * allowed to change them.
-			 *
-			 * In that case we temporarily set the key to be the
-			 * trampoline address.  This is fixed up in
-			 * static_call_add_module().
-			 */
-			key_sym = insn->call_dest;
+			WARN("static_call: can't find static_call_key symbol: %s", tmp);
+			return -1;
 		}
 		free(key_name);
 
@@ -677,6 +664,20 @@ static int create_static_call_sections(struct objtool_file *file)
 				  is_sibling_call(insn) * STATIC_CALL_SITE_TAIL))
 			return -1;
 
+		/*
+		 * For modules(), the key might not be exported, which means
+		 * the module can make static calls but isn't allowed to change
+		 * them.
+		 *
+		 * For this case, we pass the trampoline in .static_call_sites
+		 * as well. This is used to lookup the key in
+		 * static_call_add_module().
+		 */
+		if (elf_add_reloc(file->elf, sec,
+				  idx * sizeof(struct static_call_site) + 8,
+				  R_X86_64_PC32, insn->call_dest, 0))
+			return -1;
+
 		idx++;
 	}
 
-- 
2.30.2

