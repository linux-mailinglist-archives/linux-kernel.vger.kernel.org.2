Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F66844B170
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 17:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239651AbhKIQs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 11:48:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:59662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238230AbhKIQs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 11:48:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B334E611AF;
        Tue,  9 Nov 2021 16:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636476370;
        bh=+2gWOpugscZp0kvfTR5LRNZ/CWYNRcFjEgOqHanBEfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pnXUv0xeqa6qJpy1YnvpvQiFRkhvqeVlldzU5yJ4OsP+ETNWRGtXUL1H4K0tUVoyq
         +P7S6rJKTHBcOP1Ircjjq8pe6uIuHJaxcoff1PrNjAvFFgWtOUb3FoKNFl5inpj5V7
         IJIfUQdZvYQWcLGbGzKtyuEARbwhsWieT7L3G4RN4BJ36w+GFg/hhZRrzRiaD7lu+w
         PPp/KDVhysnGx555QB5eUYUlHVWy3riY20En/Bc96aEtMIAPAZ34koRYI2skDN9bAD
         GgVuefYVXnoJH6zfpaiq5GCrQVvW5nyzBbmRGHfsR+WZ+lwniM3++AOZJS2lbgFQkj
         qPa62D219bycg==
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
Subject: [RFC PATCH 1/7] static_call: get rid of static_call_cond()
Date:   Tue,  9 Nov 2021 17:45:43 +0100
Message-Id: <20211109164549.1724710-2-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109164549.1724710-1-ardb@kernel.org>
References: <20211109164549.1724710-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10086; h=from:subject; bh=+2gWOpugscZp0kvfTR5LRNZ/CWYNRcFjEgOqHanBEfI=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBhiqWvOk8k/nR9UZNYPo/Yb+y25ENP26aVPYplyzoP mG33H4KJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYYqlrwAKCRDDTyI5ktmPJKNTC/ 9D++/IA9FKSXAh4wbxnBaEg/gqBlrSiGbWKyyku7UkbGXjZaD6oUaebFjzvKezVfuaiHPytzmw/TJL 6VmVqMdqcN9z1l+kr3HIxhsRRDb4lCdAcWl4mCQs47tQCXLoxq+xld2cSTezNNQCtFOMc776EwzPdm CcRp5tGrJSeFxUBCgnreCnJ3/cU+qHo0x76sIxNBGUFMGeu2QORjCztsigfZ09srsSQZ3v1vMTAqmr mKlahMzk0QQVVcFRRxvHwcCtajTTqzChXJ8jRsINyJuA7zgU1wUXoTmfgn/tQQ9spRXxvOVhnjAeT4 hYhrQeXaIIQIqfBYSji6Dc0DKEV/vWsyYtKfY0pLPzADy/Vcb66ARXqOFD5NzED1yScKupjvLT5n3O Z41LI6gD3me9nNsNde2JTYr9W4S7beNnfLngixCKUTLRTDKKcITyL3SO09nzt4zll20lZxlEclapRK K3n6zIlnd9DDJXUesGyyYpUCxyd8OxTx7AFvhYxSnkmLM=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main reason for the existence of static_call_cond() seems to be that
in theory, when using the generic implementation of static calls, it may
be possible for a compiler to elide the indirect call entirely if the
target is NULL, while still guaranteeing that all side effects of
argument evaluation occur as expected.

This is rather optimistic: as documented by an existing code comment,
both GCC and Clang (version 10) get this wrong, and even if they ever
get it right, this is far too subtle to rely on for a code path that is
expected to be used only by the 'remaining' architectures once all the
best supported ones implement either the out-of-line or inline optimized
variety of static calls.

Given that having static_call_cond() clutters up the API, and puts the
burden on the caller to go and check what kind of static call they are
dealing with, let's just get rid of the distinction.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/events/core.c          | 20 ++++----
 arch/x86/include/asm/kvm_host.h |  4 +-
 arch/x86/kvm/irq.c              |  2 +-
 arch/x86/kvm/x86.c              |  4 +-
 include/linux/static_call.h     | 49 ++++----------------
 5 files changed, 23 insertions(+), 56 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 38b2c779146f..ed1e5fcdb49d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -991,7 +991,7 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		n0 -= cpuc->n_txn;
 
-	static_call_cond(x86_pmu_start_scheduling)(cpuc);
+	static_call(x86_pmu_start_scheduling)(cpuc);
 
 	for (i = 0, wmin = X86_PMC_IDX_MAX, wmax = 0; i < n; i++) {
 		c = cpuc->event_constraint[i];
@@ -1090,7 +1090,7 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 	 */
 	if (!unsched && assign) {
 		for (i = 0; i < n; i++)
-			static_call_cond(x86_pmu_commit_scheduling)(cpuc, i, assign[i]);
+			static_call(x86_pmu_commit_scheduling)(cpuc, i, assign[i]);
 	} else {
 		for (i = n0; i < n; i++) {
 			e = cpuc->event_list[i];
@@ -1098,13 +1098,13 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 			/*
 			 * release events that failed scheduling
 			 */
-			static_call_cond(x86_pmu_put_event_constraints)(cpuc, e);
+			static_call(x86_pmu_put_event_constraints)(cpuc, e);
 
 			cpuc->event_constraint[i] = NULL;
 		}
 	}
 
-	static_call_cond(x86_pmu_stop_scheduling)(cpuc);
+	static_call(x86_pmu_stop_scheduling)(cpuc);
 
 	return unsched ? -EINVAL : 0;
 }
@@ -1217,7 +1217,7 @@ static inline void x86_assign_hw_event(struct perf_event *event,
 	hwc->last_cpu = smp_processor_id();
 	hwc->last_tag = ++cpuc->tags[i];
 
-	static_call_cond(x86_pmu_assign)(event, idx);
+	static_call(x86_pmu_assign)(event, idx);
 
 	switch (hwc->idx) {
 	case INTEL_PMC_IDX_FIXED_BTS:
@@ -1494,7 +1494,7 @@ static int x86_pmu_add(struct perf_event *event, int flags)
 	 * This is before x86_pmu_enable() will call x86_pmu_start(),
 	 * so we enable LBRs before an event needs them etc..
 	 */
-	static_call_cond(x86_pmu_add)(event);
+	static_call(x86_pmu_add)(event);
 
 	ret = 0;
 out:
@@ -1647,7 +1647,7 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	if (i >= cpuc->n_events - cpuc->n_added)
 		--cpuc->n_added;
 
-	static_call_cond(x86_pmu_put_event_constraints)(cpuc, event);
+	static_call(x86_pmu_put_event_constraints)(cpuc, event);
 
 	/* Delete the array entry. */
 	while (++i < cpuc->n_events) {
@@ -1667,7 +1667,7 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	 * This is after x86_pmu_stop(); so we disable LBRs after any
 	 * event can need them etc..
 	 */
-	static_call_cond(x86_pmu_del)(event);
+	static_call(x86_pmu_del)(event);
 }
 
 int x86_pmu_handle_irq(struct pt_regs *regs)
@@ -2638,13 +2638,13 @@ static const struct attribute_group *x86_pmu_attr_groups[] = {
 
 static void x86_pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
 {
-	static_call_cond(x86_pmu_sched_task)(ctx, sched_in);
+	static_call(x86_pmu_sched_task)(ctx, sched_in);
 }
 
 static void x86_pmu_swap_task_ctx(struct perf_event_context *prev,
 				  struct perf_event_context *next)
 {
-	static_call_cond(x86_pmu_swap_task_ctx)(prev, next);
+	static_call(x86_pmu_swap_task_ctx)(prev, next);
 }
 
 void perf_check_microcode(void)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 2acf37cc1991..295f6285b895 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1914,12 +1914,12 @@ static inline bool kvm_irq_is_postable(struct kvm_lapic_irq *irq)
 
 static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu)
 {
-	static_call_cond(kvm_x86_vcpu_blocking)(vcpu);
+	static_call(kvm_x86_vcpu_blocking)(vcpu);
 }
 
 static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu)
 {
-	static_call_cond(kvm_x86_vcpu_unblocking)(vcpu);
+	static_call(kvm_x86_vcpu_unblocking)(vcpu);
 }
 
 static inline void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu) {}
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 172b05343cfd..79e9354f076a 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -150,7 +150,7 @@ void __kvm_migrate_timers(struct kvm_vcpu *vcpu)
 {
 	__kvm_migrate_apic_timer(vcpu);
 	__kvm_migrate_pit_timer(vcpu);
-	static_call_cond(kvm_x86_migrate_timers)(vcpu);
+	static_call(kvm_x86_migrate_timers)(vcpu);
 }
 
 bool kvm_arch_irqfd_allowed(struct kvm *kvm, struct kvm_irqfd *args)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c1c4e2b05a63..2202db26c4d7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11418,7 +11418,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 		__x86_set_memory_region(kvm, TSS_PRIVATE_MEMSLOT, 0, 0);
 		mutex_unlock(&kvm->slots_lock);
 	}
-	static_call_cond(kvm_x86_vm_destroy)(kvm);
+	static_call(kvm_x86_vm_destroy)(kvm);
 	kvm_free_msr_filter(srcu_dereference_check(kvm->arch.msr_filter, &kvm->srcu, 1));
 	kvm_pic_destroy(kvm);
 	kvm_ioapic_destroy(kvm);
@@ -12038,7 +12038,7 @@ bool kvm_arch_can_dequeue_async_page_present(struct kvm_vcpu *vcpu)
 void kvm_arch_start_assignment(struct kvm *kvm)
 {
 	if (atomic_inc_return(&kvm->arch.assigned_device_count) == 1)
-		static_call_cond(kvm_x86_start_assignment)(kvm);
+		static_call(kvm_x86_start_assignment)(kvm);
 }
 EXPORT_SYMBOL_GPL(kvm_arch_start_assignment);
 
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 3e56a9751c06..19c98cab8643 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -92,23 +92,16 @@
  *
  *   where the argument evaludation also depends on the pointer value.
  *
- *   When calling a static_call that can be NULL, use:
- *
- *     static_call_cond(name)(arg1);
- *
- *   which will include the required value tests to avoid NULL-pointer
- *   dereferences.
- *
  *   To query which function is currently set to be called, use:
  *
  *   func = static_call_query(name);
  *
  *
- * DEFINE_STATIC_CALL_RET0 / __static_call_return0:
+ * DEFINE_STATIC_CALL_RET0:
  *
- *   Just like how DEFINE_STATIC_CALL_NULL() / static_call_cond() optimize the
- *   conditional void function call, DEFINE_STATIC_CALL_RET0 /
- *   __static_call_return0 optimize the do nothing return 0 function.
+ *   Just like how DEFINE_STATIC_CALL_NULL() optimizes the conditional void
+ *   function call, DEFINE_STATIC_CALL_RET0 optimizes the do nothing return 0
+ *   function.
  *
  *   This feature is strictly UB per the C standard (since it casts a function
  *   pointer to a different signature) and relies on the architecture ABI to
@@ -196,8 +189,6 @@ extern long __static_call_return0(void);
 	};								\
 	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
 
-#define static_call_cond(name)	(void)__static_call(name)
-
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
@@ -232,8 +223,6 @@ static inline int static_call_init(void) { return 0; }
 	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
 
 
-#define static_call_cond(name)	(void)__static_call(name)
-
 static inline
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 {
@@ -275,6 +264,8 @@ static inline long __static_call_return0(void)
 	return 0;
 }
 
+static inline void __static_call_nop(void) { }
+
 #define __DEFINE_STATIC_CALL(name, _func, _func_init)			\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
@@ -284,37 +275,13 @@ static inline long __static_call_return0(void)
 #define DEFINE_STATIC_CALL_NULL(name, _func)				\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
-		.func = NULL,						\
+		.func = (void *)__static_call_nop,			\
 	}
 
-static inline void __static_call_nop(void) { }
-
-/*
- * This horrific hack takes care of two things:
- *
- *  - it ensures the compiler will only load the function pointer ONCE,
- *    which avoids a reload race.
- *
- *  - it ensures the argument evaluation is unconditional, similar
- *    to the HAVE_STATIC_CALL variant.
- *
- * Sadly current GCC/Clang (10 for both) do not optimize this properly
- * and will emit an indirect call for the NULL case :-(
- */
-#define __static_call_cond(name)					\
-({									\
-	void *func = READ_ONCE(STATIC_CALL_KEY(name).func);		\
-	if (!func)							\
-		func = &__static_call_nop;				\
-	(typeof(STATIC_CALL_TRAMP(name))*)func;				\
-})
-
-#define static_call_cond(name)	(void)__static_call_cond(name)
-
 static inline
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 {
-	WRITE_ONCE(key->func, func);
+	WRITE_ONCE(key->func, func ?: (void *)&__static_call_nop);
 }
 
 static inline int static_call_text_reserved(void *start, void *end)
-- 
2.30.2

