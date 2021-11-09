Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C65744B172
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 17:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240344AbhKIQtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 11:49:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240294AbhKIQtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 11:49:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9548F6112F;
        Tue,  9 Nov 2021 16:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636476375;
        bh=gjUEfzTxx7CnmMsXB2+9zhlLejtjtTi8JaWXvQe55N8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pjm9opuxFUh0H7vCKx73rzEzdGGqfI/ciQDk131nLUCqFz+AN+HVcGRi4ljm3S/wC
         PgaSX6016eGy2ybltt7XZmEEhOwgoxeq+lZ7aK+w/mEG3ybIHrr1ZqdL+Afastj6fY
         Uj5QLrPH9gfSNz6GYbSKqhw/U2f9/Xb6J4l+6LFSjpzcWlwq8h0X0nH4fuXwKTcsRK
         pL7L5jVUToW90BLEV1rOlXkE0quUWmyiVVgbTNNi42TEoLRzTRAmBCyTBVWWf6Lgsi
         qaBNNjnqrW3KVrHM9xxrwqGCuoUNeDuY4gC84OPL3UsqkhH2nPmQnQ8oy823uM9PLH
         JATLwljkE+d0Q==
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
Subject: [RFC PATCH 3/7] static_call: use helper to access non-exported key
Date:   Tue,  9 Nov 2021 17:45:45 +0100
Message-Id: <20211109164549.1724710-4-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109164549.1724710-1-ardb@kernel.org>
References: <20211109164549.1724710-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11120; h=from:subject; bh=gjUEfzTxx7CnmMsXB2+9zhlLejtjtTi8JaWXvQe55N8=; b=owEB7AET/pANAwAKAcNPIjmS2Y8kAcsmYgBhiqW0s9Dtw+iI2E1GGKxeeGII9T0LWRiONb5alEbu mP/fOReJAbIEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYYqltAAKCRDDTyI5ktmPJOQnC/ Y72vyZxxdMKvN2InH71n5q05E9fm5896DbUS2ypEoY4cARvpab0kurWbQZCJLye9/GVTRi+AVcxELe +GlfApXlb67D25t5JPp7rV2B4OoYBaDlmMpkojfswBbwBhBr1yf+Wa3ggkFmlruhv3zqb/vdd50XRo 6vEVJYH8hvtiKbbHK5/5Fq4iTyw3F8rnMD7PojQysZNUXSCuXXk0SM3WVAAoQWxPrnYo9GSkJVQIjh ZuvRstMlQSKWQElg4Gohl6Ar6L3DFAhWcwdGiCYnirqH7xPOZNQv9/tgJcz5gzkWkZ2t8UA4+w3itJ vwMAbC5IUyNu82zzcVs1AHRrsHZcUc/pOIl59lRjpfXLXih4aygkpVYlUAiH9Sfa/4SYg/0qSEZggq ItWRwhPlZcjROtSB7BRKRpnMAdwD+dEx/yN8hOFn/rNURwJU586onsqxLv4rQ9uNNWLi2h65tFxPGq 60xQridmuX9i2i2/SmLasA06E3XnQAL6XCAm5VBhSIjw==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We support static calls from modules without the keys being exported,
but since the inline patching code needs access to the key regardless,
we have special handling in the module notifier that looks up the key
based on the trampoline address in a list that is kept especially for
this purpose.

This list is part of the core kernel, and only contains static calls
exported from the core kernel. This means that exporting static calls
without the associated key is only possible from the core kernel, and
any attempts to do so from another module currently result in module
load failures.

So let's replace this list with a special per-static call helper that
returns the static call key address, provided that the call originates
from the core kernel. This prevents access to the key for modular
callers, while removing the need to keep a list of key/trampoline pairs.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
Alternatively, we might fix the module loader to look for
.static_call_tramp_key sections in all modules loaded prior, but I'm not
sure whether that would be cleaner.

 arch/x86/include/asm/static_call.h      |  6 -----
 include/asm-generic/vmlinux.lds.h       |  5 +----
 include/linux/static_call.h             | 18 ++++++++-------
 include/linux/static_call_types.h       |  9 +++++++-
 kernel/extable.c                        |  1 +
 kernel/static_call.c                    | 23 +++-----------------
 tools/include/linux/static_call_types.h |  9 +++++++-
 tools/objtool/check.c                   | 20 ++++++++++++-----
 8 files changed, 45 insertions(+), 46 deletions(-)

diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
index cbb67b6030f9..beb2bbaae8b1 100644
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -38,10 +38,4 @@
 	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "ret; nop; nop; nop; nop")
 
 
-#define ARCH_ADD_TRAMP_KEY(name)					\
-	asm(".pushsection .static_call_tramp_key, \"a\"		\n"	\
-	    ".long " STATIC_CALL_TRAMP_STR(name) " - .		\n"	\
-	    ".long " STATIC_CALL_KEY_STR(name) " - .		\n"	\
-	    ".popsection					\n")
-
 #endif /* _ASM_STATIC_CALL_H */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 42f3866bca69..5fd802ccb62f 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -408,10 +408,7 @@
 	. = ALIGN(8);							\
 	__start_static_call_sites = .;					\
 	KEEP(*(.static_call_sites))					\
-	__stop_static_call_sites = .;					\
-	__start_static_call_tramp_key = .;				\
-	KEEP(*(.static_call_tramp_key))					\
-	__stop_static_call_tramp_key = .;
+	__stop_static_call_sites = .;
 
 /*
  * Allow architectures to handle ro_after_init data on their
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 19c98cab8643..3bba0bcba844 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -161,12 +161,6 @@ struct static_call_mod {
 	struct static_call_site *sites;
 };
 
-/* For finding the key associated with a trampoline */
-struct static_call_tramp_key {
-	s32 tramp;
-	s32 key;
-};
-
 extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
 extern int static_call_mod_init(struct module *mod);
 extern int static_call_text_reserved(void *start, void *end);
@@ -196,13 +190,21 @@ extern long __static_call_return0(void);
 	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
 
+#define EXPORT_STATIC_CALL_GETKEY_HELPER(name)				\
+	struct static_call_key *STATIC_CALL_GETKEY(name)(void) {	\
+		BUG_ON(!core_kernel_text(				\
+			(unsigned long)__builtin_return_address(0)));	\
+		return &STATIC_CALL_KEY(name);				\
+	}								\
+	EXPORT_SYMBOL_GPL(STATIC_CALL_GETKEY(name))
+
 /* Leave the key unexported, so modules can't change static call targets: */
 #define EXPORT_STATIC_CALL_TRAMP(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name));				\
-	ARCH_ADD_TRAMP_KEY(name)
+	EXPORT_STATIC_CALL_GETKEY_HELPER(name)
 #define EXPORT_STATIC_CALL_TRAMP_GPL(name)				\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name));			\
-	ARCH_ADD_TRAMP_KEY(name)
+	EXPORT_STATIC_CALL_GETKEY_HELPER(name)
 
 #elif defined(CONFIG_HAVE_STATIC_CALL)
 
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index 0bb36294cce7..a31782909e43 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -18,6 +18,11 @@
 #define STATIC_CALL_TRAMP(name)		__PASTE(STATIC_CALL_TRAMP_PREFIX, name)
 #define STATIC_CALL_TRAMP_STR(name)	__stringify(STATIC_CALL_TRAMP(name))
 
+#define STATIC_CALL_GETKEY_PREFIX	__SCG__
+#define STATIC_CALL_GETKEY_PREFIX_STR	__stringify(STATIC_CALL_GETKEY_PREFIX)
+#define STATIC_CALL_GETKEY_PREFIX_LEN	(sizeof(STATIC_CALL_GETKEY_PREFIX_STR) - 1)
+#define STATIC_CALL_GETKEY(name)	__PASTE(STATIC_CALL_GETKEY_PREFIX, name)
+
 /*
  * Flags in the low bits of static_call_site::key.
  */
@@ -32,11 +37,12 @@
 struct static_call_site {
 	s32 addr;
 	s32 key;
-	s32 tramp;
+	s32 helper;
 };
 
 #define DECLARE_STATIC_CALL(name, func)					\
 	extern __weak struct static_call_key STATIC_CALL_KEY(name);	\
+	extern __weak struct static_call_key *STATIC_CALL_GETKEY(name)(void);\
 	extern typeof(func) STATIC_CALL_TRAMP(name);
 
 #ifdef CONFIG_HAVE_STATIC_CALL
@@ -55,6 +61,7 @@ struct static_call_site {
  * .static_call_sites section.
  */
 #define __STATIC_CALL_ADDRESSABLE(name) \
+	__ADDRESSABLE(STATIC_CALL_GETKEY(name)) \
 	__ADDRESSABLE(STATIC_CALL_KEY(name))
 
 struct static_call_key {
diff --git a/kernel/extable.c b/kernel/extable.c
index 290661f68e6b..e52579e46180 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -81,6 +81,7 @@ int notrace core_kernel_text(unsigned long addr)
 		return 1;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(core_kernel_text);
 
 /**
  * core_kernel_data - tell if addr points to kernel data
diff --git a/kernel/static_call.c b/kernel/static_call.c
index 360cc3cd0fbf..29ae772dc86e 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -12,8 +12,6 @@
 
 extern struct static_call_site __start_static_call_sites[],
 			       __stop_static_call_sites[];
-extern struct static_call_tramp_key __start_static_call_tramp_key[],
-				    __stop_static_call_tramp_key[];
 
 static bool static_call_initialized;
 
@@ -333,23 +331,6 @@ static int __static_call_mod_text_reserved(void *start, void *end)
 	return ret;
 }
 
-static unsigned long tramp_key_lookup(unsigned long addr)
-{
-	struct static_call_tramp_key *start = __start_static_call_tramp_key;
-	struct static_call_tramp_key *stop = __stop_static_call_tramp_key;
-	struct static_call_tramp_key *tramp_key;
-
-	for (tramp_key = start; tramp_key != stop; tramp_key++) {
-		unsigned long tramp;
-
-		tramp = (long)tramp_key->tramp + (long)&tramp_key->tramp;
-		if (tramp == addr)
-			return (long)tramp_key->key + (long)&tramp_key->key;
-	}
-
-	return 0;
-}
-
 static int static_call_add_module(struct module *mod)
 {
 	struct static_call_site *start = mod->static_call_sites;
@@ -359,6 +340,7 @@ static int static_call_add_module(struct module *mod)
 	for (site = start; site != stop; site++) {
 		unsigned long s_key = __static_call_key(site);
 		unsigned long addr = s_key & ~STATIC_CALL_SITE_FLAGS;
+		unsigned long (*key_helper)(void);
 		unsigned long key;
 
 		/*
@@ -375,7 +357,8 @@ static int static_call_add_module(struct module *mod)
 		if (addr)
 			continue;
 
-		key = tramp_key_lookup((unsigned long)offset_to_ptr(&site->tramp));
+		key_helper = offset_to_ptr(&site->helper);
+		key = key_helper();
 		if (!key) {
 			pr_warn("Failed to fixup static_call() usage at: %ps\n",
 				static_call_addr(site));
diff --git a/tools/include/linux/static_call_types.h b/tools/include/linux/static_call_types.h
index 0bb36294cce7..a31782909e43 100644
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -18,6 +18,11 @@
 #define STATIC_CALL_TRAMP(name)		__PASTE(STATIC_CALL_TRAMP_PREFIX, name)
 #define STATIC_CALL_TRAMP_STR(name)	__stringify(STATIC_CALL_TRAMP(name))
 
+#define STATIC_CALL_GETKEY_PREFIX	__SCG__
+#define STATIC_CALL_GETKEY_PREFIX_STR	__stringify(STATIC_CALL_GETKEY_PREFIX)
+#define STATIC_CALL_GETKEY_PREFIX_LEN	(sizeof(STATIC_CALL_GETKEY_PREFIX_STR) - 1)
+#define STATIC_CALL_GETKEY(name)	__PASTE(STATIC_CALL_GETKEY_PREFIX, name)
+
 /*
  * Flags in the low bits of static_call_site::key.
  */
@@ -32,11 +37,12 @@
 struct static_call_site {
 	s32 addr;
 	s32 key;
-	s32 tramp;
+	s32 helper;
 };
 
 #define DECLARE_STATIC_CALL(name, func)					\
 	extern __weak struct static_call_key STATIC_CALL_KEY(name);	\
+	extern __weak struct static_call_key *STATIC_CALL_GETKEY(name)(void);\
 	extern typeof(func) STATIC_CALL_TRAMP(name);
 
 #ifdef CONFIG_HAVE_STATIC_CALL
@@ -55,6 +61,7 @@ struct static_call_site {
  * .static_call_sites section.
  */
 #define __STATIC_CALL_ADDRESSABLE(name) \
+	__ADDRESSABLE(STATIC_CALL_GETKEY(name)) \
 	__ADDRESSABLE(STATIC_CALL_KEY(name))
 
 struct static_call_key {
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ec6ddaaf6cf6..3698ace884a5 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -600,7 +600,7 @@ static int create_static_call_sections(struct objtool_file *file)
 	struct section *sec;
 	struct static_call_site *site;
 	struct instruction *insn;
-	struct symbol *key_sym;
+	struct symbol *key_sym, *helper_sym;
 	char *key_name, *tmp;
 	int idx;
 
@@ -655,7 +655,6 @@ static int create_static_call_sections(struct objtool_file *file)
 			WARN("static_call: can't find static_call_key symbol: %s", tmp);
 			return -1;
 		}
-		free(key_name);
 
 		/* populate reloc for 'key' */
 		if (elf_add_reloc(file->elf, sec,
@@ -664,18 +663,27 @@ static int create_static_call_sections(struct objtool_file *file)
 				  is_sibling_call(insn) * STATIC_CALL_SITE_TAIL))
 			return -1;
 
+		memcpy(tmp, STATIC_CALL_GETKEY_PREFIX_STR, STATIC_CALL_GETKEY_PREFIX_LEN);
+
+		helper_sym = find_symbol_by_name(file->elf, tmp);
+		if (!helper_sym) {
+			WARN("static_call: can't find static_call_key symbol: %s", tmp);
+			return -1;
+		}
+		free(key_name);
+
 		/*
 		 * For modules(), the key might not be exported, which means
 		 * the module can make static calls but isn't allowed to change
 		 * them.
 		 *
-		 * For this case, we pass the trampoline in .static_call_sites
-		 * as well. This is used to lookup the key in
-		 * static_call_add_module().
+		 * For this case, we pass the special key helper routine in
+		 * .static_call_sites as well. This is used to lookup the key
+		 * in static_call_add_module().
 		 */
 		if (elf_add_reloc(file->elf, sec,
 				  idx * sizeof(struct static_call_site) + 8,
-				  R_X86_64_PC32, insn->call_dest, 0))
+				  R_X86_64_PC32, helper_sym, 0))
 			return -1;
 
 		idx++;
-- 
2.30.2

