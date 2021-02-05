Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA7E310F5A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhBEQT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbhBEQRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:17:16 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2929CC061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 09:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w8uivUYYxqboC8erULkSyVBugoPixo9k3+BjNKBIFMA=; b=f5wg56kMnvr134w9qMppaPvfWm
        1zjnpQ17AWpaWEH5F0gUbaFESf+7fx0Lf8p/G2GHlAiwjNt/LvgbMDgA05BaeZ0f0pAevX9umA6Ot
        dse59xf3JHV9C7lhZXKgF/v/Zl7WKvFhhgO1jAPhHFXjtYy+ywfoiGyrWqFiwXzkAwzJ3sE7C8q6U
        QH1T1nMpkzdPIsCHNpVom2sKRiCcIy4ujm5+fACH2uC+7VJElv7y0qrWXXLkMoSRYj4LdJSWPbry8
        PIYJz7Kr/8Wgkf1aTX7iXcVp3/pMMmZPUk43JxrLOLNI9Rqw8M/9dXBUXRfI8NyhIL+hiPYQqZLiA
        aA3/EACQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l834U-0007JY-0R; Fri, 05 Feb 2021 15:30:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5459F3012DF;
        Fri,  5 Feb 2021 16:30:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 274B72BC43F84; Fri,  5 Feb 2021 16:30:56 +0100 (CET)
Date:   Fri, 5 Feb 2021 16:30:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        rostedt@goodmis.org, jbaron@akamai.com, ardb@kernel.org
Subject: Re: [RFC PATCH 6/8] preempt/dynamic: Provide
 preempt_schedule[_notrace]() static calls
Message-ID: <YB1ksCPhD40f0VQn@hirez.programming.kicks-ass.net>
References: <YBEuy6zlBcV8gLvY@hirez.programming.kicks-ass.net>
 <YBFODfNZCjA9s0IP@hirez.programming.kicks-ass.net>
 <20210127155914.jfmr4jay47yck5h5@treble>
 <YBGSdtnKIL3kryos@hirez.programming.kicks-ass.net>
 <20210127163308.cgiq7jxx2uziuhcc@treble>
 <YBG0cSoJmu8NnoAT@hirez.programming.kicks-ass.net>
 <20210127190003.64rdwoxyjgnq2rtx@treble>
 <20210127190218.hoztl7eidujqarkt@treble>
 <20210127231837.ifddpn7rhwdaepiu@treble>
 <YBqtZwIbj6kQEiEd@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBqtZwIbj6kQEiEd@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 03:04:23PM +0100, Peter Zijlstra wrote:
> Fair enough I suppose. I'll slap a changelog and your SoB on it and I
> suppose I'll got commit the whole lot. Then we can forget about it
> again.

FWIW, the whole thing looks like this..

---
Subject: static_call: Allow module use without exposing static_call_key
From: Josh Poimboeuf <jpoimboe@redhat.com>
Date: Wed, 27 Jan 2021 17:18:37 -0600

From: Josh Poimboeuf <jpoimboe@redhat.com>

When exporting static_call_key; with EXPORT_STATIC_CALL*(), the module
can use static_call_update() to change the function called.  This is
not desirable in general.

Not exporting static_call_key however also disallows usage of
static_call(), since objtool needs the key to construct the
static_call_site.

Solve this by allowing objtool to create the static_call_site using
the trampoline address when it builds a module and cannot find the
static_call_key symbol. The module loader will then try and map the
trampole back to a key before it constructs the normal sites list.

Doing this requires a trampoline -> key associsation, so add another
magic section that keeps those.

Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210127231837.ifddpn7rhwdaepiu@treble
---
 arch/x86/include/asm/static_call.h      |    7 ++++
 include/asm-generic/vmlinux.lds.h       |    5 ++
 include/linux/static_call.h             |   22 +++++++++++-
 include/linux/static_call_types.h       |   27 ++++++++++++++-
 kernel/static_call.c                    |   55 ++++++++++++++++++++++++++++++--
 tools/include/linux/static_call_types.h |   27 ++++++++++++++-
 tools/objtool/check.c                   |   17 ++++++++-
 7 files changed, 149 insertions(+), 11 deletions(-)

--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -37,4 +37,11 @@
 #define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)			\
 	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "ret; nop; nop; nop; nop")
 
+
+#define ARCH_ADD_TRAMP_KEY(name)					\
+	asm(".pushsection .static_call_tramp_key, \"a\"		\n"	\
+	    ".long " STATIC_CALL_TRAMP_STR(name) " - .		\n"	\
+	    ".long " STATIC_CALL_KEY_STR(name) " - .		\n"	\
+	    ".popsection					\n")
+
 #endif /* _ASM_STATIC_CALL_H */
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -393,7 +393,10 @@
 	. = ALIGN(8);							\
 	__start_static_call_sites = .;					\
 	KEEP(*(.static_call_sites))					\
-	__stop_static_call_sites = .;
+	__stop_static_call_sites = .;					\
+	__start_static_call_tramp_key = .;				\
+	KEEP(*(.static_call_tramp_key))					\
+	__stop_static_call_tramp_key = .;
 
 /*
  * Allow architectures to handle ro_after_init data on their
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -138,6 +138,12 @@ struct static_call_key {
 	};
 };
 
+/* For finding the key associated with a trampoline */
+struct static_call_tramp_key {
+	s32 tramp;
+	s32 key;
+};
+
 extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
 extern int static_call_mod_init(struct module *mod);
 extern int static_call_text_reserved(void *start, void *end);
@@ -165,11 +171,18 @@ extern long __static_call_return0(void);
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
-
 #define EXPORT_STATIC_CALL_GPL(name)					\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
 
+/* Leave the key unexported, so modules can't change static call targets: */
+#define EXPORT_STATIC_CALL_TRAMP(name)					\
+	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name));				\
+	ARCH_ADD_TRAMP_KEY(name)
+#define EXPORT_STATIC_CALL_TRAMP_GPL(name)				\
+	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name));			\
+	ARCH_ADD_TRAMP_KEY(name)
+
 #elif defined(CONFIG_HAVE_STATIC_CALL)
 
 static inline int static_call_init(void) { return 0; }
@@ -216,11 +229,16 @@ static inline long __static_call_return0
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
-
 #define EXPORT_STATIC_CALL_GPL(name)					\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
 
+/* Leave the key unexported, so modules can't change static call targets: */
+#define EXPORT_STATIC_CALL_TRAMP(name)					\
+	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
+#define EXPORT_STATIC_CALL_TRAMP_GPL(name)				\
+	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
+
 #else /* Generic implementation */
 
 static inline int static_call_init(void) { return 0; }
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -10,6 +10,7 @@
 #define STATIC_CALL_KEY_PREFIX_STR	__stringify(STATIC_CALL_KEY_PREFIX)
 #define STATIC_CALL_KEY_PREFIX_LEN	(sizeof(STATIC_CALL_KEY_PREFIX_STR) - 1)
 #define STATIC_CALL_KEY(name)		__PASTE(STATIC_CALL_KEY_PREFIX, name)
+#define STATIC_CALL_KEY_STR(name)	__stringify(STATIC_CALL_KEY(name))
 
 #define STATIC_CALL_TRAMP_PREFIX	__SCT__
 #define STATIC_CALL_TRAMP_PREFIX_STR	__stringify(STATIC_CALL_TRAMP_PREFIX)
@@ -39,17 +40,39 @@ struct static_call_site {
 
 #ifdef CONFIG_HAVE_STATIC_CALL
 
+#define __raw_static_call(name)	(&STATIC_CALL_TRAMP(name))
+
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
+
 /*
  * __ADDRESSABLE() is used to ensure the key symbol doesn't get stripped from
  * the symbol table so that objtool can reference it when it generates the
  * .static_call_sites section.
  */
+#define __STATIC_CALL_ADDRESSABLE(name) \
+	__ADDRESSABLE(STATIC_CALL_KEY(name))
+
 #define __static_call(name)						\
 ({									\
-	__ADDRESSABLE(STATIC_CALL_KEY(name));				\
-	&STATIC_CALL_TRAMP(name);					\
+	__STATIC_CALL_ADDRESSABLE(name);				\
+	__raw_static_call(name);					\
 })
 
+#else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
+
+#define __STATIC_CALL_ADDRESSABLE(name)
+#define __static_call(name)	__raw_static_call(name)
+
+#endif /* CONFIG_HAVE_STATIC_CALL_INLINE */
+
+#ifdef MODULE
+#define __STATIC_CALL_MOD_ADDRESSABLE(name)
+#define static_call_mod(name)	__raw_static_call(name)
+#else
+#define __STATIC_CALL_MOD_ADDRESSABLE(name) __STATIC_CALL_ADDRESSABLE(name)
+#define static_call_mod(name)	__static_call(name)
+#endif
+
 #define static_call(name)	__static_call(name)
 
 #else
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -12,6 +12,8 @@
 
 extern struct static_call_site __start_static_call_sites[],
 			       __stop_static_call_sites[];
+extern struct static_call_tramp_key __start_static_call_tramp_key[],
+				    __stop_static_call_tramp_key[];
 
 static bool static_call_initialized;
 
@@ -323,10 +325,59 @@ static int __static_call_mod_text_reserv
 	return ret;
 }
 
+static unsigned long tramp_key_lookup(unsigned long addr)
+{
+	struct static_call_tramp_key *start = __start_static_call_tramp_key;
+	struct static_call_tramp_key *stop = __stop_static_call_tramp_key;
+	struct static_call_tramp_key *tramp_key;
+
+	for (tramp_key = start; tramp_key != stop; tramp_key++) {
+		unsigned long tramp;
+
+		tramp = (long)tramp_key->tramp + (long)&tramp_key->tramp;
+		if (tramp == addr)
+			return (long)tramp_key->key + (long)&tramp_key->key;
+	}
+
+	return 0;
+}
+
 static int static_call_add_module(struct module *mod)
 {
-	return __static_call_init(mod, mod->static_call_sites,
-				  mod->static_call_sites + mod->num_static_call_sites);
+	struct static_call_site *start = mod->static_call_sites;
+	struct static_call_site *stop = start + mod->num_static_call_sites;
+	struct static_call_site *site;
+
+	for (site = start; site != stop; site++) {
+		unsigned long addr = (unsigned long)static_call_key(site);
+		unsigned long key;
+
+		/*
+		 * Is the key is exported, 'addr' points to the key, which
+		 * means modules are allowed to call static_call_update() on
+		 * it.
+		 *
+		 * Otherwise, the key isn't exported, and 'addr' points to the
+		 * trampoline so we need to lookup the key.
+		 *
+		 * We go through this dance to prevent crazy modules from
+		 * abusing sensitive static calls.
+		 */
+		if (!kernel_text_address(addr))
+			continue;
+
+		key = tramp_key_lookup(addr);
+		if (!key) {
+			pr_warn("Failed to fixup __raw_static_call() usage at: %ps\n",
+				static_call_addr(site));
+			return -EINVAL;
+		}
+
+		site->key = (key - (long)&site->key) |
+			    (site->key & STATIC_CALL_SITE_FLAGS);
+	}
+
+	return __static_call_init(mod, start, stop);
 }
 
 static void static_call_del_module(struct module *mod)
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -10,6 +10,7 @@
 #define STATIC_CALL_KEY_PREFIX_STR	__stringify(STATIC_CALL_KEY_PREFIX)
 #define STATIC_CALL_KEY_PREFIX_LEN	(sizeof(STATIC_CALL_KEY_PREFIX_STR) - 1)
 #define STATIC_CALL_KEY(name)		__PASTE(STATIC_CALL_KEY_PREFIX, name)
+#define STATIC_CALL_KEY_STR(name)	__stringify(STATIC_CALL_KEY(name))
 
 #define STATIC_CALL_TRAMP_PREFIX	__SCT__
 #define STATIC_CALL_TRAMP_PREFIX_STR	__stringify(STATIC_CALL_TRAMP_PREFIX)
@@ -39,17 +40,39 @@ struct static_call_site {
 
 #ifdef CONFIG_HAVE_STATIC_CALL
 
+#define __raw_static_call(name)	(&STATIC_CALL_TRAMP(name))
+
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
+
 /*
  * __ADDRESSABLE() is used to ensure the key symbol doesn't get stripped from
  * the symbol table so that objtool can reference it when it generates the
  * .static_call_sites section.
  */
+#define __STATIC_CALL_ADDRESSABLE(name) \
+	__ADDRESSABLE(STATIC_CALL_KEY(name))
+
 #define __static_call(name)						\
 ({									\
-	__ADDRESSABLE(STATIC_CALL_KEY(name));				\
-	&STATIC_CALL_TRAMP(name);					\
+	__STATIC_CALL_ADDRESSABLE(name);				\
+	__raw_static_call(name);					\
 })
 
+#else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
+
+#define __STATIC_CALL_ADDRESSABLE(name)
+#define __static_call(name)	__raw_static_call(name)
+
+#endif /* CONFIG_HAVE_STATIC_CALL_INLINE */
+
+#ifdef MODULE
+#define __STATIC_CALL_MOD_ADDRESSABLE(name)
+#define static_call_mod(name)	__raw_static_call(name)
+#else
+#define __STATIC_CALL_MOD_ADDRESSABLE(name) __STATIC_CALL_ADDRESSABLE(name)
+#define static_call_mod(name)	__static_call(name)
+#endif
+
 #define static_call(name)	__static_call(name)
 
 #else
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -507,8 +507,21 @@ static int create_static_call_sections(s
 
 		key_sym = find_symbol_by_name(file->elf, tmp);
 		if (!key_sym) {
-			WARN("static_call: can't find static_call_key symbol: %s", tmp);
-			return -1;
+			if (!module) {
+				WARN("static_call: can't find static_call_key symbol: %s", tmp);
+				return -1;
+			}
+
+			/*
+			 * For modules(), the key might not be exported, which
+			 * means the module can make static calls but isn't
+			 * allowed to change them.
+			 *
+			 * In that case we temporarily set the key to be the
+			 * trampoline address.  This is fixed up in
+			 * static_call_add_module().
+			 */
+			key_sym = insn->call_dest;
 		}
 		free(key_name);
 
