Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154F33067BE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbhA0XVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:21:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50958 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235159AbhA0XUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611789525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WMBO1K4VIh3mfp/iw1uzXDZd7s9UpPwyPgEMt328oCg=;
        b=bw84mkJkmHh9g/KIrc6g/tf415LWHVE8iy+0Tah1T99KHIX3XUmRG3+LY24EnKXEweuBVt
        ZlE4dnXPeA3PwxwxRl0RbIqaDbIYMTnLN5v7R8uBDl2QIWHsywzyPAYjA6cmGuY2dt3qly
        nOuRILbln/q0TspTuxKzHSNnJp/KkSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-m148DViiN_2jJuFyNHPp9Q-1; Wed, 27 Jan 2021 18:18:43 -0500
X-MC-Unique: m148DViiN_2jJuFyNHPp9Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F0F1107ACE3;
        Wed, 27 Jan 2021 23:18:41 +0000 (UTC)
Received: from treble (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D458A10023B3;
        Wed, 27 Jan 2021 23:18:39 +0000 (UTC)
Date:   Wed, 27 Jan 2021 17:18:37 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        rostedt@goodmis.org, jbaron@akamai.com, ardb@kernel.org
Subject: Re: [RFC PATCH 6/8] preempt/dynamic: Provide
 preempt_schedule[_notrace]() static calls
Message-ID: <20210127231837.ifddpn7rhwdaepiu@treble>
References: <20210122165226.GD16371@worktop.programming.kicks-ass.net>
 <20210126235730.lgfa2uida5se5urn@treble>
 <YBEuy6zlBcV8gLvY@hirez.programming.kicks-ass.net>
 <YBFODfNZCjA9s0IP@hirez.programming.kicks-ass.net>
 <20210127155914.jfmr4jay47yck5h5@treble>
 <YBGSdtnKIL3kryos@hirez.programming.kicks-ass.net>
 <20210127163308.cgiq7jxx2uziuhcc@treble>
 <YBG0cSoJmu8NnoAT@hirez.programming.kicks-ass.net>
 <20210127190003.64rdwoxyjgnq2rtx@treble>
 <20210127190218.hoztl7eidujqarkt@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210127190218.hoztl7eidujqarkt@treble>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 01:02:18PM -0600, Josh Poimboeuf wrote:
> On Wed, Jan 27, 2021 at 01:00:07PM -0600, Josh Poimboeuf wrote:
> > On Wed, Jan 27, 2021 at 07:44:01PM +0100, Peter Zijlstra wrote:
> > > On Wed, Jan 27, 2021 at 10:33:08AM -0600, Josh Poimboeuf wrote:
> > > 
> > > > What did you think about .static_call_tramp_key?  I could whip up a
> > > > patch later unless you beat me to it.
> > > 
> > > Yeah, I'm not sure.. why duplicate information already present in
> > > kallsyms?
> > 
> > Well, but it's not exactly duplicating kallsyms.  No need to store
> > symbol names, just the pointer relationships.  And kallsyms is
> > presumably slow.
> > 
> > > There's a fair number of features that already require KALLSYMS, I can't
> > > really be bothered about adding one more (kprobes, function_tracer,
> > > stack_tracer, ftrace_syscalls).

Here ya go.  It builds...  And the tramp_key section is nice and small.

Relocation section [1497] '.rela.static_call_tramp_key' for section [1496] '.static_call_tramp_key' at offset 0x179ab818 contains 8 entries:
  Offset              Type            Value               Addend Name
  000000000000000000  X86_64_PC32     0x00000000000004c0      +0 __SCT__preempt_schedule
  0x0000000000000004  X86_64_PC32     0x000000000005ee10      +0 __SCK__preempt_schedule
  0x0000000000000008  X86_64_PC32     0x00000000000004c8      +0 __SCT__preempt_schedule_notrace
  0x000000000000000c  X86_64_PC32     0x000000000005ee00      +0 __SCK__preempt_schedule_notrace
  0x0000000000000010  X86_64_PC32     0x00000000000004d0      +0 __SCT__cond_resched
  0x0000000000000014  X86_64_PC32     0x000000000005dd20      +0 __SCK__cond_resched
  0x0000000000000018  X86_64_PC32     0x00000000000004d8      +0 __SCT__might_resched
  0x000000000000001c  X86_64_PC32     0x000000000005dd10      +0 __SCK__might_resched


diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
index c37f11999d0c..cbb67b6030f9 100644
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
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2b3d81b1535..b0871e282c4f 100644
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
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 077330874c60..16bcd5af3d35 100644
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
@@ -216,11 +229,16 @@ static inline long __static_call_return0(void)
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
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index 08f78b1b88b4..ae5662d368b9 100644
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
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 66129245b6a0..9f4564b89e9f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5268,7 +5268,7 @@ EXPORT_SYMBOL(preempt_schedule);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 DEFINE_STATIC_CALL(preempt_schedule, __preempt_schedule_func());
-EXPORT_STATIC_CALL(preempt_schedule);
+EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
 #endif
 
 
@@ -5326,7 +5326,7 @@ EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func());
-EXPORT_STATIC_CALL(preempt_schedule_notrace);
+EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
 #endif
 
 #endif /* CONFIG_PREEMPTION */
@@ -6993,10 +6993,10 @@ EXPORT_SYMBOL(__cond_resched);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
-EXPORT_STATIC_CALL(cond_resched);
+EXPORT_STATIC_CALL_TRAMP(cond_resched);
 
 DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
-EXPORT_STATIC_CALL(might_resched);
+EXPORT_STATIC_CALL_TRAMP(might_resched);
 #endif
 
 /*
diff --git a/kernel/static_call.c b/kernel/static_call.c
index 0bc11b5ce681..5e6f567976c1 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -12,6 +12,8 @@
 
 extern struct static_call_site __start_static_call_sites[],
 			       __stop_static_call_sites[];
+extern struct static_call_tramp_key __start_static_call_tramp_key[],
+				    __stop_static_call_tramp_key[];
 
 static bool static_call_initialized;
 
@@ -323,10 +325,59 @@ static int __static_call_mod_text_reserved(void *start, void *end)
 	return ret;
 }
 
+static struct static_call_tramp_key *tramp_key_lookup(unsigned long addr)
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
+			return tramp_key;
+	}
+
+	return NULL;
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
+		struct static_call_tramp_key *tramp_key;
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
+		tramp_key = tramp_key_lookup(addr);
+		if (!tramp_key) {
+			pr_warn("Failed to fixup __raw_static_call() usage at: %ps\n",
+				static_call_addr(site));
+			return -EINVAL;
+		}
+
+		site->key = ((long)tramp_key->key - (long)&tramp_key->key) |
+			    (site->key & STATIC_CALL_SITE_FLAGS);
+	}
+
+	return __static_call_init(mod, start, stop);
 }
 
 static void static_call_del_module(struct module *mod)
diff --git a/tools/include/linux/static_call_types.h b/tools/include/linux/static_call_types.h
index 08f78b1b88b4..2a3afb6ebf49 100644
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -39,17 +39,39 @@ struct static_call_site {
 
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
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4bd30315eb62..f2e5e5ce1a05 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -502,8 +502,21 @@ static int create_static_call_sections(struct objtool_file *file)
 
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
 

