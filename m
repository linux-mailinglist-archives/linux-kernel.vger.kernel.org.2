Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8076944B175
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 17:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240501AbhKIQtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 11:49:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240346AbhKIQtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 11:49:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0B2261279;
        Tue,  9 Nov 2021 16:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636476382;
        bh=iwKCM/jO+9o9b35SwF7b0v62iiX9B7NVPn8f/xUKTog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hd4mw67xQYzDNV5YKRgYiCO18qjOAf8X67P0tiO/eJnv2tA5WtqE/DbSuLVC4MR/P
         nnzVirk6dtQeaFv58ciOflE/9pM5VC1i/0eYw+WpGEYaKnRjG++KbWaZ/V89WnTBKG
         zVIO053iV6wmr9DuG2GG30xspOwWwiyGBRcZU6Yvn9vuNm/m7Nbt46LuJCoDqYvHkH
         BdjcfoApdQA5W8CrC3cm673vkUUw4PYZwuimCB18afoE/RGi32BkyUJFA4qoX07J/F
         K3Rto29y2wtE68qmQbUxwD3gghk9Y+lqVswRomouPsSztLpWJ++RTzWEIbfZOYSTcF
         cRr0mZlV6EY1g==
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
Subject: [RFC PATCH 6/7] static_call: rename EXPORT_ macros to be more self-explanatory
Date:   Tue,  9 Nov 2021 17:45:48 +0100
Message-Id: <20211109164549.1724710-7-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109164549.1724710-1-ardb@kernel.org>
References: <20211109164549.1724710-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7539; h=from:subject; bh=iwKCM/jO+9o9b35SwF7b0v62iiX9B7NVPn8f/xUKTog=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBhiqW6LwQe0/Dz1D0ywCEaBqzKo6gtCRvpstv2r8jX RqDBw+iJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYYqlugAKCRDDTyI5ktmPJMBrC/ 9y/8tAZSwvmjf43secWALL8zLs+qLmEk1+nVHzbJEZzQnIMERQt2eTljR6cbOW744QfqzAht2ImxV+ IxSsadmHWoD10iJtv8irdYTbH2WFa89bhjQzLwmd9esW/76fjJabdjBF+/kV0boQAF9EZOYYkyxZ+x 5McAxXHct4Sv/AVq5FSOYLldbD9xDJHH2QlroSFFHjkLwn5BM75fL7ppebaJYWxPLptpgGVHzR+3MC gZRH8ynl7bZrxS9Qd1W+voMbfrfEuHujFsOFzk47CnXhoEOpDxzN0rEiCbsnbAjgiQfjpfxEk1k1Wt b+UgqFsqEMJr93fskM6P8ovJMBCFP4hQvjtPEnYRRUg3DjesoCdx9x+sKun4hQVYRLb4s5AAPm9tOe LmxOsgsrF3Vs278xYGnfar4WQohvGFFqVHEqY/WAWNNAhdJ9eUxzbpU2GnXwKpod7+KL405TGDpbhM 4TcBueulESKffuBUtituCaPqnVxgO03a/BytyKEm0efDQ=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently two ways to export static calls to modules:
- export only the current static call target, so that modules can invoke
  it but not make it point to another target;
- export the static call key so that modules may call
  static_call_update() and patch all invocations tied to that key.

Depending on the flavor of static call implementation, different things
need to be exported: for the generic case, we need to export the key
regardless of which export was chosen, but for other cases, we only
export the trampoline but not the key.

As the latter is an implementation detail, EXPORT_STATIC_CALL_TRAMP() is
not the best choice for the name of the export macro that only exports
the target but not the key.

So let's rename these macros to

  EXPORT_STATIC_CALL        -> EXPORT_STATIC_CALL_FOR_UPDATE
  EXPORT_STATIC_CALL_TRAMP  -> EXPORT_STATIC_CALL

(and the _GPL suffixed ones in a similar fashion). That way, the default
does not expose the key, and users that need to expose control over the
static call key to modules can do so explicitly by choosing the
_FOR_UPDATE version instead.

While at it, add the missing ones for the generic static call
implementation.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kvm/x86.c          |  6 ++--
 include/linux/static_call.h | 35 ++++++++++++--------
 kernel/sched/core.c         |  8 ++---
 3 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2202db26c4d7..c3749911e966 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -130,9 +130,9 @@ EXPORT_SYMBOL_GPL(kvm_x86_ops);
 				*(((struct kvm_x86_ops *)0)->func));
 #define KVM_X86_OP_NULL KVM_X86_OP
 #include <asm/kvm-x86-ops.h>
-EXPORT_STATIC_CALL_GPL(kvm_x86_get_cs_db_l_bits);
-EXPORT_STATIC_CALL_GPL(kvm_x86_cache_reg);
-EXPORT_STATIC_CALL_GPL(kvm_x86_tlb_flush_current);
+EXPORT_STATIC_CALL_FOR_UPDATE_GPL(kvm_x86_get_cs_db_l_bits);
+EXPORT_STATIC_CALL_FOR_UPDATE_GPL(kvm_x86_cache_reg);
+EXPORT_STATIC_CALL_FOR_UPDATE_GPL(kvm_x86_tlb_flush_current);
 
 static bool __read_mostly ignore_msrs = 0;
 module_param(ignore_msrs, bool, S_IRUGO | S_IWUSR);
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 6b261fe96ba3..21929147879a 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -26,7 +26,7 @@
  *   static_call_update(name, func);
  *   static_call_query(name);
  *
- *   EXPORT_STATIC_CALL{,_TRAMP}{,_GPL}()
+ *   EXPORT_STATIC_CALL{,_FOR_UPDATE}{,_GPL}()
  *
  * Usage example:
  *
@@ -90,7 +90,7 @@
  *     if (my_func_ptr)
  *         my_func_ptr(arg1)
  *
- *   where the argument evaludation also depends on the pointer value.
+ *   where the argument evaluation also depends on the pointer value.
  *
  *   To query which function is currently set to be called, use:
  *
@@ -116,11 +116,15 @@
  *   Notably argument setup is unconditional.
  *
  *
- * EXPORT_STATIC_CALL() vs EXPORT_STATIC_CALL_TRAMP():
+ * EXPORT_STATIC_CALL() vs EXPORT_STATIC_CALL_FOR_UPDATE():
  *
- *   The difference is that the _TRAMP variant tries to only export the
- *   trampoline with the result that a module can use static_call{,_cond}() but
- *   not static_call_update().
+ *   EXPORT_STATIC_CALL() exports the minimal set of symbols that are needed
+ *   for a module to be able invoke the static call, with the result that it
+ *   can use static_call{,_cond}() but not static_call_update(). If the intent
+ *   is to permit modules to manipulate the targets of static calls associated
+ *   with a certain static call key occurring anywhere in the core kernel or
+ *   other modules than the one importing the static call, use
+ *   EXPORT_STATIC_CALL_FOR_UPDATE() instead.
  *
  */
 
@@ -186,10 +190,10 @@ extern long __static_call_return0(void);
 	};								\
 	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
 
-#define EXPORT_STATIC_CALL(name)					\
+#define EXPORT_STATIC_CALL_FOR_UPDATE(name)				\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
-#define EXPORT_STATIC_CALL_GPL(name)					\
+#define EXPORT_STATIC_CALL_FOR_UPDATE_GPL(name)				\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
 
@@ -202,11 +206,11 @@ extern long __static_call_return0(void);
 	EXPORT_SYMBOL_GPL(STATIC_CALL_GETKEY(name))
 
 /* Leave the key unexported, so modules can't change static call targets: */
-#define EXPORT_STATIC_CALL_TRAMP(name)					\
+#define EXPORT_STATIC_CALL(name)					\
 	EXPORT_STATIC_CALL_QUERY(name,);				\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name));				\
 	EXPORT_STATIC_CALL_GETKEY_HELPER(name)
-#define EXPORT_STATIC_CALL_TRAMP_GPL(name)				\
+#define EXPORT_STATIC_CALL_GPL(name)					\
 	EXPORT_STATIC_CALL_QUERY(name, _GPL);				\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name));			\
 	EXPORT_STATIC_CALL_GETKEY_HELPER(name)
@@ -249,18 +253,18 @@ static inline long __static_call_return0(void)
 	return 0;
 }
 
-#define EXPORT_STATIC_CALL(name)					\
+#define EXPORT_STATIC_CALL_FOR_UPDATE(name)				\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
-#define EXPORT_STATIC_CALL_GPL(name)					\
+#define EXPORT_STATIC_CALL_FOR_UPDATE_GPL(name)				\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
 
 /* Leave the key unexported, so modules can't change static call targets: */
-#define EXPORT_STATIC_CALL_TRAMP(name)					\
+#define EXPORT_STATIC_CALL(name)					\
 	EXPORT_STATIC_CALL_QUERY(name,);				\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
-#define EXPORT_STATIC_CALL_TRAMP_GPL(name)				\
+#define EXPORT_STATIC_CALL_GPL(name)					\
 	EXPORT_STATIC_CALL_QUERY(name, _GPL);				\
 	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
 
@@ -301,6 +305,9 @@ static inline int static_call_text_reserved(void *start, void *end)
 #define EXPORT_STATIC_CALL(name)	EXPORT_SYMBOL(STATIC_CALL_KEY(name))
 #define EXPORT_STATIC_CALL_GPL(name)	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name))
 
+#define EXPORT_STATIC_CALL_FOR_UPDATE(name)	EXPORT_SYMBOL(STATIC_CALL_KEY(name))
+#define EXPORT_STATIC_CALL_FOR_UPDATE_GPL(name)	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name))
+
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
 #define DEFINE_STATIC_CALL(name, _func)					\
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 523fd602ea90..0e963d77176f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6445,7 +6445,7 @@ EXPORT_SYMBOL(preempt_schedule);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 DEFINE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
-EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
+EXPORT_STATIC_CALL(preempt_schedule);
 #endif
 
 
@@ -6503,7 +6503,7 @@ EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
-EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
+EXPORT_STATIC_CALL(preempt_schedule_notrace);
 #endif
 
 #endif /* CONFIG_PREEMPTION */
@@ -8150,10 +8150,10 @@ EXPORT_SYMBOL(__cond_resched);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
-EXPORT_STATIC_CALL_TRAMP(cond_resched);
+EXPORT_STATIC_CALL(cond_resched);
 
 DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
-EXPORT_STATIC_CALL_TRAMP(might_resched);
+EXPORT_STATIC_CALL(might_resched);
 #endif
 
 /*
-- 
2.30.2

