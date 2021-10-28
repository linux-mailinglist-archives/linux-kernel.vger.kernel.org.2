Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D5B43DCC0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 10:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhJ1IOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 04:14:55 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40192 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhJ1IOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 04:14:52 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B15881FD4E;
        Thu, 28 Oct 2021 08:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635408744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QksQebk1Y8FPDBoAglLu73ax8R7o9eRK4x+nsqV+elk=;
        b=lRnnR5fTPLeK40Bxibys9A9K4vacdHa60hfErHP2QMDlMAYS5tZ2OFxKFgIyzjDvyyneJq
        PtWY0wY+RlPdkWOtQlg1hLP644z5QrjQ14SBUP0M0No27CpxKyVolR4eycuZUHWyPswFvo
        pib9cppXK/qTrRCRqpBLV6HJOibwId4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 58B2813B7D;
        Thu, 28 Oct 2021 08:12:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WOSfFGhbemE/MQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 28 Oct 2021 08:12:24 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] xen: allow pv-only hypercalls only with CONFIG_XEN_PV
Date:   Thu, 28 Oct 2021 10:12:19 +0200
Message-Id: <20211028081221.2475-3-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211028081221.2475-1-jgross@suse.com>
References: <20211028081221.2475-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put the definitions of the hypercalls usable only by pv guests inside
CONFIG_XEN_PV sections.

On Arm two dummy functions related to pv hypercalls can be removed.

While at it remove the no longer supported tmem hypercall definition.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/arm/xen/enlighten.c             |   1 -
 arch/arm/xen/hypercall.S             |   1 -
 arch/arm64/xen/hypercall.S           |   1 -
 arch/x86/include/asm/xen/hypercall.h | 211 +++++++++++++--------------
 include/xen/arm/hypercall.h          |  15 --
 5 files changed, 102 insertions(+), 127 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 7f1c106b746f..7619fbffcea2 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -442,7 +442,6 @@ EXPORT_SYMBOL_GPL(HYPERVISOR_hvm_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_memory_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_physdev_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_vcpu_op);
-EXPORT_SYMBOL_GPL(HYPERVISOR_tmem_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_platform_op_raw);
 EXPORT_SYMBOL_GPL(HYPERVISOR_multicall);
 EXPORT_SYMBOL_GPL(HYPERVISOR_vm_assist);
diff --git a/arch/arm/xen/hypercall.S b/arch/arm/xen/hypercall.S
index b11bba542fac..f794dac9859a 100644
--- a/arch/arm/xen/hypercall.S
+++ b/arch/arm/xen/hypercall.S
@@ -88,7 +88,6 @@ HYPERCALL2(hvm_op);
 HYPERCALL2(memory_op);
 HYPERCALL2(physdev_op);
 HYPERCALL3(vcpu_op);
-HYPERCALL1(tmem_op);
 HYPERCALL1(platform_op_raw);
 HYPERCALL2(multicall);
 HYPERCALL2(vm_assist);
diff --git a/arch/arm64/xen/hypercall.S b/arch/arm64/xen/hypercall.S
index 5b09aca55108..9d01361696a1 100644
--- a/arch/arm64/xen/hypercall.S
+++ b/arch/arm64/xen/hypercall.S
@@ -80,7 +80,6 @@ HYPERCALL2(hvm_op);
 HYPERCALL2(memory_op);
 HYPERCALL2(physdev_op);
 HYPERCALL3(vcpu_op);
-HYPERCALL1(tmem_op);
 HYPERCALL1(platform_op_raw);
 HYPERCALL2(multicall);
 HYPERCALL2(vm_assist);
diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index 02156b76aa92..b4832ec1a047 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -248,6 +248,7 @@ privcmd_call(unsigned int call,
 	return res;
 }
 
+#ifdef CONFIG_XEN_PV
 static inline int
 HYPERVISOR_set_trap_table(struct trap_info *table)
 {
@@ -280,6 +281,107 @@ HYPERVISOR_callback_op(int cmd, void *arg)
 	return _hypercall2(int, callback_op, cmd, arg);
 }
 
+static inline int
+HYPERVISOR_set_debugreg(int reg, unsigned long value)
+{
+	return _hypercall2(int, set_debugreg, reg, value);
+}
+
+static inline unsigned long
+HYPERVISOR_get_debugreg(int reg)
+{
+	return _hypercall1(unsigned long, get_debugreg, reg);
+}
+
+static inline int
+HYPERVISOR_update_descriptor(u64 ma, u64 desc)
+{
+	return _hypercall2(int, update_descriptor, ma, desc);
+}
+
+static inline int
+HYPERVISOR_update_va_mapping(unsigned long va, pte_t new_val,
+			     unsigned long flags)
+{
+	return _hypercall3(int, update_va_mapping, va, new_val.pte, flags);
+}
+
+static inline int
+HYPERVISOR_set_segment_base(int reg, unsigned long value)
+{
+	return _hypercall2(int, set_segment_base, reg, value);
+}
+
+static inline void
+MULTI_fpu_taskswitch(struct multicall_entry *mcl, int set)
+{
+	mcl->op = __HYPERVISOR_fpu_taskswitch;
+	mcl->args[0] = set;
+
+	trace_xen_mc_entry(mcl, 1);
+}
+
+static inline void
+MULTI_update_va_mapping(struct multicall_entry *mcl, unsigned long va,
+			pte_t new_val, unsigned long flags)
+{
+	mcl->op = __HYPERVISOR_update_va_mapping;
+	mcl->args[0] = va;
+	mcl->args[1] = new_val.pte;
+	mcl->args[2] = flags;
+
+	trace_xen_mc_entry(mcl, 3);
+}
+
+static inline void
+MULTI_update_descriptor(struct multicall_entry *mcl, u64 maddr,
+			struct desc_struct desc)
+{
+	mcl->op = __HYPERVISOR_update_descriptor;
+	mcl->args[0] = maddr;
+	mcl->args[1] = *(unsigned long *)&desc;
+
+	trace_xen_mc_entry(mcl, 2);
+}
+
+static inline void
+MULTI_mmu_update(struct multicall_entry *mcl, struct mmu_update *req,
+		 int count, int *success_count, domid_t domid)
+{
+	mcl->op = __HYPERVISOR_mmu_update;
+	mcl->args[0] = (unsigned long)req;
+	mcl->args[1] = count;
+	mcl->args[2] = (unsigned long)success_count;
+	mcl->args[3] = domid;
+
+	trace_xen_mc_entry(mcl, 4);
+}
+
+static inline void
+MULTI_mmuext_op(struct multicall_entry *mcl, struct mmuext_op *op, int count,
+		int *success_count, domid_t domid)
+{
+	mcl->op = __HYPERVISOR_mmuext_op;
+	mcl->args[0] = (unsigned long)op;
+	mcl->args[1] = count;
+	mcl->args[2] = (unsigned long)success_count;
+	mcl->args[3] = domid;
+
+	trace_xen_mc_entry(mcl, 4);
+}
+
+static inline void
+MULTI_stack_switch(struct multicall_entry *mcl,
+		   unsigned long ss, unsigned long esp)
+{
+	mcl->op = __HYPERVISOR_stack_switch;
+	mcl->args[0] = ss;
+	mcl->args[1] = esp;
+
+	trace_xen_mc_entry(mcl, 2);
+}
+#endif
+
 static inline int
 HYPERVISOR_sched_op(int cmd, void *arg)
 {
@@ -308,24 +410,6 @@ HYPERVISOR_platform_op(struct xen_platform_op *op)
 	return _hypercall1(int, platform_op, op);
 }
 
-static inline int
-HYPERVISOR_set_debugreg(int reg, unsigned long value)
-{
-	return _hypercall2(int, set_debugreg, reg, value);
-}
-
-static inline unsigned long
-HYPERVISOR_get_debugreg(int reg)
-{
-	return _hypercall1(unsigned long, get_debugreg, reg);
-}
-
-static inline int
-HYPERVISOR_update_descriptor(u64 ma, u64 desc)
-{
-	return _hypercall2(int, update_descriptor, ma, desc);
-}
-
 static inline long
 HYPERVISOR_memory_op(unsigned int cmd, void *arg)
 {
@@ -338,13 +422,6 @@ HYPERVISOR_multicall(void *call_list, uint32_t nr_calls)
 	return _hypercall2(int, multicall, call_list, nr_calls);
 }
 
-static inline int
-HYPERVISOR_update_va_mapping(unsigned long va, pte_t new_val,
-			     unsigned long flags)
-{
-	return _hypercall3(int, update_va_mapping, va, new_val.pte, flags);
-}
-
 static inline int
 HYPERVISOR_event_channel_op(int cmd, void *arg)
 {
@@ -387,14 +464,6 @@ HYPERVISOR_vcpu_op(int cmd, int vcpuid, void *extra_args)
 	return _hypercall3(int, vcpu_op, cmd, vcpuid, extra_args);
 }
 
-#ifdef CONFIG_X86_64
-static inline int
-HYPERVISOR_set_segment_base(int reg, unsigned long value)
-{
-	return _hypercall2(int, set_segment_base, reg, value);
-}
-#endif
-
 static inline int
 HYPERVISOR_suspend(unsigned long start_info_mfn)
 {
@@ -415,13 +484,6 @@ HYPERVISOR_hvm_op(int op, void *arg)
        return _hypercall2(unsigned long, hvm_op, op, arg);
 }
 
-static inline int
-HYPERVISOR_tmem_op(
-	struct tmem_op *op)
-{
-	return _hypercall1(int, tmem_op, op);
-}
-
 static inline int
 HYPERVISOR_xenpmu_op(unsigned int op, void *arg)
 {
@@ -439,73 +501,4 @@ HYPERVISOR_dm_op(
 	return ret;
 }
 
-static inline void
-MULTI_fpu_taskswitch(struct multicall_entry *mcl, int set)
-{
-	mcl->op = __HYPERVISOR_fpu_taskswitch;
-	mcl->args[0] = set;
-
-	trace_xen_mc_entry(mcl, 1);
-}
-
-static inline void
-MULTI_update_va_mapping(struct multicall_entry *mcl, unsigned long va,
-			pte_t new_val, unsigned long flags)
-{
-	mcl->op = __HYPERVISOR_update_va_mapping;
-	mcl->args[0] = va;
-	mcl->args[1] = new_val.pte;
-	mcl->args[2] = flags;
-
-	trace_xen_mc_entry(mcl, 3);
-}
-
-static inline void
-MULTI_update_descriptor(struct multicall_entry *mcl, u64 maddr,
-			struct desc_struct desc)
-{
-	mcl->op = __HYPERVISOR_update_descriptor;
-	mcl->args[0] = maddr;
-	mcl->args[1] = *(unsigned long *)&desc;
-
-	trace_xen_mc_entry(mcl, 2);
-}
-
-static inline void
-MULTI_mmu_update(struct multicall_entry *mcl, struct mmu_update *req,
-		 int count, int *success_count, domid_t domid)
-{
-	mcl->op = __HYPERVISOR_mmu_update;
-	mcl->args[0] = (unsigned long)req;
-	mcl->args[1] = count;
-	mcl->args[2] = (unsigned long)success_count;
-	mcl->args[3] = domid;
-
-	trace_xen_mc_entry(mcl, 4);
-}
-
-static inline void
-MULTI_mmuext_op(struct multicall_entry *mcl, struct mmuext_op *op, int count,
-		int *success_count, domid_t domid)
-{
-	mcl->op = __HYPERVISOR_mmuext_op;
-	mcl->args[0] = (unsigned long)op;
-	mcl->args[1] = count;
-	mcl->args[2] = (unsigned long)success_count;
-	mcl->args[3] = domid;
-
-	trace_xen_mc_entry(mcl, 4);
-}
-
-static inline void
-MULTI_stack_switch(struct multicall_entry *mcl,
-		   unsigned long ss, unsigned long esp)
-{
-	mcl->op = __HYPERVISOR_stack_switch;
-	mcl->args[0] = ss;
-	mcl->args[1] = esp;
-
-	trace_xen_mc_entry(mcl, 2);
-}
-
 #endif /* _ASM_X86_XEN_HYPERCALL_H */
diff --git a/include/xen/arm/hypercall.h b/include/xen/arm/hypercall.h
index b40485e54d80..9d7dd1c65a21 100644
--- a/include/xen/arm/hypercall.h
+++ b/include/xen/arm/hypercall.h
@@ -53,7 +53,6 @@ unsigned long HYPERVISOR_hvm_op(int op, void *arg);
 int HYPERVISOR_memory_op(unsigned int cmd, void *arg);
 int HYPERVISOR_physdev_op(int cmd, void *arg);
 int HYPERVISOR_vcpu_op(int cmd, int vcpuid, void *extra_args);
-int HYPERVISOR_tmem_op(void *arg);
 int HYPERVISOR_vm_assist(unsigned int cmd, unsigned int type);
 int HYPERVISOR_dm_op(domid_t domid, unsigned int nr_bufs,
 		     struct xen_dm_op_buf *bufs);
@@ -74,18 +73,4 @@ HYPERVISOR_suspend(unsigned long start_info_mfn)
 	return HYPERVISOR_sched_op(SCHEDOP_shutdown, &r);
 }
 
-static inline void
-MULTI_update_va_mapping(struct multicall_entry *mcl, unsigned long va,
-			unsigned int new_val, unsigned long flags)
-{
-	BUG();
-}
-
-static inline void
-MULTI_mmu_update(struct multicall_entry *mcl, struct mmu_update *req,
-		 int count, int *success_count, domid_t domid)
-{
-	BUG();
-}
-
 #endif /* _ASM_ARM_XEN_HYPERCALL_H */
-- 
2.26.2

