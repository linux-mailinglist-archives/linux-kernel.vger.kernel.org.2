Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D783DE014
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 21:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhHBT2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 15:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhHBT20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 15:28:26 -0400
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D219C0613D5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 12:28:17 -0700 (PDT)
Received: by mail-io1-xd49.google.com with SMTP id n2-20020a0566023402b0290561891c53e0so9475159ioz.18
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 12:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jx0kExs6wdQ4eyF+O8UZpjg55SHP0x/R47RYe4pO1Jg=;
        b=cnlnmm5jEcaX+8zW+WSejkVKj0nduwLltebT/qMtowaGCR+RHiHpBF/VdhhDT/Dtlq
         hdCvXd1HKtznA+2bWaWmZjX9fDY+VZnLTDnoWRpoJLt+CLD5HBQ1qeq9a24998lbwwGG
         XINPu6/m86yqEfenasB0uNWBtKwmdk1StlA8Kh6fvPSFY436m1Dx9ZvhB1cVoHPdY4QA
         J0BZyEP4DVP3GHIZK2GEyzOBo596dfU7U7PvH1hqzc9g+fyPi4oH9XJcWDNi7aKWtzpJ
         0fYZ1L5RsprfPc9XNpWjZC1cFy1+d01JC6jNyWRLyOLTJHhqX59EM1tKbveG66fhI5yY
         Bn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jx0kExs6wdQ4eyF+O8UZpjg55SHP0x/R47RYe4pO1Jg=;
        b=EOmYWr3LihM2e4KAI1k2JiN+nMVja6yy6vg4i6vu+47pnUA7CbR99/Sb9asnUslaPe
         c29tX5O1qG79P+jOM2qYunE3XSBejYul6w+/wVjJSjMAjXUTY648SvL3skcDIJF4AIFa
         UfPdeYsrtlBKziqspP+p0EuGPmwO122X/PD9WsxS4U/BvHNbG1uyWEYSynLDqZUBchCY
         YWBz9X8aItT6TS0PUqhjwe7gqU4s3q5OoIwKGTNpJhRkRtLXPq9pN0Cd4ShAHE/FFo4I
         sCYfnOHL+QdgUMk3b0uF9ERZCn02FA/4pK85W3MTU6oWBT67MttVRCE1s0cf+nf5XWeQ
         hWaw==
X-Gm-Message-State: AOAM533S5YTOtafeb1lbO1szUK0kzCWdFTpS17Wn8Uy7O8KDMTkbd7C+
        JrtH9iPJucPL95LBqxozrOuM+nFFlHE=
X-Google-Smtp-Source: ABdhPJzTnJVyWDVmpRbXbEdCYT1hqJ9Qs+9K/AwtglpDZFmw11pNZLaqhv7TtM62mzN8+d7RPIBMwsUg3V8=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a02:8206:: with SMTP id o6mr16038436jag.92.1627932496528;
 Mon, 02 Aug 2021 12:28:16 -0700 (PDT)
Date:   Mon,  2 Aug 2021 19:28:09 +0000
In-Reply-To: <20210802192809.1851010-1-oupton@google.com>
Message-Id: <20210802192809.1851010-4-oupton@google.com>
Mime-Version: 1.0
References: <20210802192809.1851010-1-oupton@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v3 3/3] KVM: arm64: Use generic KVM xfer to guest work function
From:   Oliver Upton <oupton@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Peter Shier <pshier@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Guangyu Shi <guangyus@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up handling of checks for pending work by switching to the generic
infrastructure to do so.

We pick up handling for TIF_NOTIFY_RESUME from this switch, meaning that
task work will be correctly handled.

Signed-off-by: Oliver Upton <oupton@google.com>
---
 arch/arm64/kvm/Kconfig |  1 +
 arch/arm64/kvm/arm.c   | 72 ++++++++++++++++++++++++++----------------
 2 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index a4eba0908bfa..8bc1fac5fa26 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -26,6 +26,7 @@ menuconfig KVM
 	select HAVE_KVM_ARCH_TLB_FLUSH_ALL
 	select KVM_MMIO
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
+	select KVM_XFER_TO_GUEST_WORK
 	select SRCU
 	select KVM_VFIO
 	select HAVE_KVM_EVENTFD
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 60d0a546d7fd..8245efc6e88f 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -6,6 +6,7 @@
 
 #include <linux/bug.h>
 #include <linux/cpu_pm.h>
+#include <linux/entry-kvm.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/kvm_host.h>
@@ -714,6 +715,45 @@ static bool vcpu_mode_is_bad_32bit(struct kvm_vcpu *vcpu)
 		static_branch_unlikely(&arm64_mismatched_32bit_el0);
 }
 
+/**
+ * kvm_vcpu_exit_request - returns true if the VCPU should *not* enter the guest
+ * @vcpu:	The VCPU pointer
+ * @ret:	Pointer to write optional return code
+ *
+ * Returns: true if the VCPU needs to return to a preemptible + interruptible
+ *	    and skip guest entry.
+ *
+ * This function disambiguates between two different types of exits: exits to a
+ * preemptible + interruptible kernel context and exits to userspace. For an
+ * exit to userspace, this function will write the return code to ret and return
+ * true. For an exit to preemptible + interruptible kernel context (i.e. check
+ * for pending work and re-enter), return true without writing to ret.
+ */
+static bool kvm_vcpu_exit_request(struct kvm_vcpu *vcpu, int *ret)
+{
+	struct kvm_run *run = vcpu->run;
+
+	/*
+	 * If we're using a userspace irqchip, then check if we need
+	 * to tell a userspace irqchip about timer or PMU level
+	 * changes and if so, exit to userspace (the actual level
+	 * state gets updated in kvm_timer_update_run and
+	 * kvm_pmu_update_run below).
+	 */
+	if (static_branch_unlikely(&userspace_irqchip_in_use)) {
+		if (kvm_timer_should_notify_user(vcpu) ||
+		    kvm_pmu_should_notify_user(vcpu)) {
+			*ret = -EINTR;
+			run->exit_reason = KVM_EXIT_INTR;
+			return true;
+		}
+	}
+
+	return kvm_request_pending(vcpu) ||
+			need_new_vmid_gen(&vcpu->arch.hw_mmu->vmid) ||
+			xfer_to_guest_mode_work_pending();
+}
+
 /**
  * kvm_arch_vcpu_ioctl_run - the main VCPU run function to execute guest code
  * @vcpu:	The VCPU pointer
@@ -757,7 +797,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		/*
 		 * Check conditions before entering the guest
 		 */
-		cond_resched();
+		ret = xfer_to_guest_mode_handle_work(vcpu);
+		if (!ret)
+			ret = 1;
 
 		update_vmid(&vcpu->arch.hw_mmu->vmid);
 
@@ -776,31 +818,6 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 		kvm_vgic_flush_hwstate(vcpu);
 
-		/*
-		 * Exit if we have a signal pending so that we can deliver the
-		 * signal to user space.
-		 */
-		if (signal_pending(current)) {
-			ret = -EINTR;
-			run->exit_reason = KVM_EXIT_INTR;
-			++vcpu->stat.signal_exits;
-		}
-
-		/*
-		 * If we're using a userspace irqchip, then check if we need
-		 * to tell a userspace irqchip about timer or PMU level
-		 * changes and if so, exit to userspace (the actual level
-		 * state gets updated in kvm_timer_update_run and
-		 * kvm_pmu_update_run below).
-		 */
-		if (static_branch_unlikely(&userspace_irqchip_in_use)) {
-			if (kvm_timer_should_notify_user(vcpu) ||
-			    kvm_pmu_should_notify_user(vcpu)) {
-				ret = -EINTR;
-				run->exit_reason = KVM_EXIT_INTR;
-			}
-		}
-
 		/*
 		 * Ensure we set mode to IN_GUEST_MODE after we disable
 		 * interrupts and before the final VCPU requests check.
@@ -809,8 +826,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		 */
 		smp_store_mb(vcpu->mode, IN_GUEST_MODE);
 
-		if (ret <= 0 || need_new_vmid_gen(&vcpu->arch.hw_mmu->vmid) ||
-		    kvm_request_pending(vcpu)) {
+		if (ret <= 0 || kvm_vcpu_exit_request(vcpu, &ret)) {
 			vcpu->mode = OUTSIDE_GUEST_MODE;
 			isb(); /* Ensure work in x_flush_hwstate is committed */
 			kvm_pmu_sync_hwstate(vcpu);
-- 
2.32.0.554.ge1b32706d8-goog

