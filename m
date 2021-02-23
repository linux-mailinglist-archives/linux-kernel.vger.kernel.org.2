Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF337322E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhBWP7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbhBWP7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:59:16 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC3BC06178C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:58:13 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id g20so3439630edr.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hbo/fIEaWX4c5hJYDj52Y9HBS/ixC+8Uan9va/UAV4o=;
        b=MsvMqsrWgIjPTUfL+9bUuFfHs/AJkmsUnMSYjUDpL+kly2SzmV9AP2PI6Z6YPv5iyr
         I5briQE+B0HSQWWlCKdpbDbkPhLPILKWm7wHnDjyN1NUEnOtlIAoIrUyaHcjknezngMr
         NROr9vXsB4COrlgbycNpv4+u9mSHW479boINNOYsKIpb62bDxH+9OoiBZoa4xBGIhOyF
         1TtcpdtcISIv1hbUa4kPh5Ah8/WrXPqgUV3DNuseG6F9farP6jv7NqM2+tAeCN6I/KC2
         W9YK7iuVL9Qwz6oCPOnt8RikbT/hubTjSrEu8WjAtlT2Sbkpd0ER36IQ35EXMhaQXG4U
         kEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hbo/fIEaWX4c5hJYDj52Y9HBS/ixC+8Uan9va/UAV4o=;
        b=j7+31NcoDn475MyE5lJFexsX95DeB3qzyCGKSFSy6OUmZZbqX+tTi4V4Zs5DeqEvlU
         E8o2UTBkz+7xn/RdH36q1AyzuWcQ3ws2QpVnI95UOmJFf2MNfHYxrOURCzgdYZzRWGB5
         x2SjdUL1fZW1KUI/RgbEpWfZLhvF9Of3JRSh64gQqlf8mjRIjOZl+DzPk1Fypn7JCVVp
         s2aK0GNqgs3pfFZthnn94xhFCZOUe4eskGpm/RF3VcWDY8rAFumrFLgxuXQKXdx4eLhj
         GPD5h/SgoHH4yXuOvnoLzrmdkBtmVMhcG70FchyjvGKK/vLNsWhQzl/Wgzhih1h+xVIW
         hfqA==
X-Gm-Message-State: AOAM530JfasT/EbwYC3fIPtOyoCqMFlS+5DCgE2LlLDm9AwaYYqi8M3J
        l9DeQWgNtFCd9qwMlWSfHewy/k9hPbQ=
X-Google-Smtp-Source: ABdhPJyPe+c2Q+sfZINNQxEpgvVftiVO2WUsRctfaxO187quXd00aex+44zqV9cR0FsWx3qJRrQ3wUp6RGc=
Sender: "ascull via sendgmr" <ascull@ascull.c.googlers.com>
X-Received: from ascull.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1510])
 (user=ascull job=sendgmr) by 2002:a17:906:f9d2:: with SMTP id
 lj18mr23372019ejb.291.1614095891993; Tue, 23 Feb 2021 07:58:11 -0800 (PST)
Date:   Tue, 23 Feb 2021 15:57:59 +0000
In-Reply-To: <20210223155759.3495252-1-ascull@google.com>
Message-Id: <20210223155759.3495252-5-ascull@google.com>
Mime-Version: 1.0
References: <20210223155759.3495252-1-ascull@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v2 4/4] KVM: arm64: Log source when panicking from nVHE hyp
From:   Andrew Scull <ascull@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, james.morse@arm.com,
        suzuki.poulose@arm.com, julien.thierry.kdev@gmail.com,
        will@kernel.org, catalin.marinas@arm.com, kernel-team@android.com,
        Andrew Scull <ascull@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To aid with debugging, add details of the source of a panic. This is
done by having nVHE hyp exit to nvhe_hyp_panic_handler() rather than
directly to panic(). The handler will then add the extra details for
debugging before panicking the kernel.

If the panic was due to a BUG(), look up the metadata to log the file
and line, if available, otherwise log the kimg address that can be
looked up in vmlinux.

__hyp_panic_string is now inlined since it no longer needs to be
references as a symbol and message is free to diverge between VHE and
nVHE.

Signed-off-by: Andrew Scull <ascull@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h        |  2 ++
 arch/arm64/kernel/image-vars.h          |  3 +--
 arch/arm64/kvm/handle_exit.c            | 31 +++++++++++++++++++++++++
 arch/arm64/kvm/hyp/include/hyp/switch.h |  2 --
 arch/arm64/kvm/hyp/nvhe/host.S          | 17 ++++++--------
 arch/arm64/kvm/hyp/nvhe/psci-relay.c    |  2 --
 arch/arm64/kvm/hyp/vhe/switch.c         |  4 +---
 7 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index e52d82aeadca..f07c55f9dd1e 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -130,6 +130,8 @@ void kvm_update_va_mask(struct alt_instr *alt,
 			__le32 *origptr, __le32 *updptr, int nr_inst);
 void kvm_compute_layout(void);
 
+#define __hyp_pa(x) ((phys_addr_t)((x)) + hyp_physvirt_offset)
+
 static __always_inline unsigned long __kern_hyp_va(unsigned long v)
 {
 	asm volatile(ALTERNATIVE_CB("and %0, %0, #1\n"
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index f676243abac6..cf12b0d6441e 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -71,8 +71,7 @@ KVM_NVHE_ALIAS(kvm_get_kimage_voffset);
 KVM_NVHE_ALIAS(kvm_vgic_global_state);
 
 /* Kernel symbols used to call panic() from nVHE hyp code (via ERET). */
-KVM_NVHE_ALIAS(__hyp_panic_string);
-KVM_NVHE_ALIAS(panic);
+KVM_NVHE_ALIAS(nvhe_hyp_panic_handler);
 
 /* Vectors installed by hyp-init on reset HVC. */
 KVM_NVHE_ALIAS(__hyp_stub_vectors);
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index cebe39f3b1b6..b25b88d8c150 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -291,3 +291,34 @@ void handle_exit_early(struct kvm_vcpu *vcpu, int exception_index)
 	if (exception_index == ARM_EXCEPTION_EL1_SERROR)
 		kvm_handle_guest_serror(vcpu, kvm_vcpu_get_esr(vcpu));
 }
+
+void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr, u64 elr,
+					      u64 par, uintptr_t vcpu,
+					      u64 far, u64 hpfar) {
+	u64 elr_in_kimg = __phys_to_kimg(__hyp_pa(elr));
+	u64 mode = spsr & PSR_MODE_MASK;
+
+	if (mode != PSR_MODE_EL2t && mode != PSR_MODE_EL2h) {
+		kvm_err("Invalid host exception to nVHE hyp!\n");
+	} else if (ESR_ELx_EC(esr) == ESR_ELx_EC_BRK64 &&
+		   (esr & ESR_ELx_BRK64_ISS_COMMENT_MASK) == BUG_BRK_IMM) {
+		struct bug_entry *bug = find_bug(elr_in_kimg);
+		const char *file = NULL;
+		unsigned int line = 0;
+
+		/* All hyp bugs, including warnings, are treated as fatal. */
+		if (bug)
+			bug_get_file_line(bug, &file, &line);
+
+		if (file) {
+			kvm_err("nVHE hyp BUG at: %s:%u!\n", file, line);
+		} else {
+			kvm_err("nVHE hyp BUG at: %016llx!\n", elr_in_kimg);
+		}
+	} else {
+		kvm_err("nVHE hyp panic at: %016llx!\n", elr_in_kimg);
+	}
+
+	panic("HYP panic:\nPS:%08llx PC:%016llx ESR:%08llx\nFAR:%016llx HPFAR:%016llx PAR:%016llx\nVCPU:%016lx\n",
+	      spsr, elr, esr, far, hpfar, par, vcpu);
+}
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 84473574c2e7..f9e8bb97d199 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -30,8 +30,6 @@
 #include <asm/processor.h>
 #include <asm/thread_info.h>
 
-extern const char __hyp_panic_string[];
-
 extern struct exception_table_entry __start___kvm_ex_table;
 extern struct exception_table_entry __stop___kvm_ex_table;
 
diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index 3dc5a9f3e575..04d661614b0f 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -77,21 +77,18 @@ SYM_FUNC_END(__host_enter)
 SYM_FUNC_START(__hyp_do_panic)
 	mov	x29, x0
 
-	/* Load the format string into x0 and arguments into x1-7 */
-	ldr	x0, =__hyp_panic_string
-
-	mov	x6, x3
-	get_vcpu_ptr x7, x3
-
-	mrs	x3, esr_el2
-	mrs	x4, far_el2
-	mrs	x5, hpfar_el2
+	/* Load the panic arguments into x0-7 */
+	mrs	x0, esr_el2
+	get_vcpu_ptr x4, x5
+	mrs	x5, far_el2
+	mrs	x6, hpfar_el2
+	mov	x7, x0			// Unused argument
 
 	/* Prepare and exit to the host's panic funciton. */
 	mov	lr, #(PSR_F_BIT | PSR_I_BIT | PSR_A_BIT | PSR_D_BIT |\
 		      PSR_MODE_EL1h)
 	msr	spsr_el2, lr
-	ldr	lr, =panic
+	ldr	lr, =nvhe_hyp_panic_handler
 	msr	elr_el2, lr
 
 	/* Enter the host, restoring the host context if it was provided. */
diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
index 8e7128cb7667..54b70189229b 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
@@ -22,8 +22,6 @@ void __noreturn __host_enter(struct kvm_cpu_context *host_ctxt);
 struct kvm_host_psci_config __ro_after_init kvm_host_psci_config;
 s64 __ro_after_init hyp_physvirt_offset;
 
-#define __hyp_pa(x) ((phys_addr_t)((x)) + hyp_physvirt_offset)
-
 #define INVALID_CPU_ID	UINT_MAX
 
 struct psci_boot_args {
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index af8e940d0f03..7b8f7db5c1ed 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -27,8 +27,6 @@
 #include <asm/processor.h>
 #include <asm/thread_info.h>
 
-const char __hyp_panic_string[] = "HYP panic:\nPS:%08llx PC:%016llx ESR:%08llx\nFAR:%016llx HPFAR:%016llx PAR:%016llx\nVCPU:%p\n";
-
 /* VHE specific context */
 DEFINE_PER_CPU(struct kvm_host_data, kvm_host_data);
 DEFINE_PER_CPU(struct kvm_cpu_context, kvm_hyp_ctxt);
@@ -207,7 +205,7 @@ static void __hyp_call_panic(u64 spsr, u64 elr, u64 par)
 	__deactivate_traps(vcpu);
 	sysreg_restore_host_state_vhe(host_ctxt);
 
-	panic(__hyp_panic_string,
+	panic("HYP panic:\nPS:%08llx PC:%016llx ESR:%08llx\nFAR:%016llx HPFAR:%016llx PAR:%016llx\nVCPU:%p\n",
 	      spsr, elr,
 	      read_sysreg_el2(SYS_ESR), read_sysreg_el2(SYS_FAR),
 	      read_sysreg(hpfar_el2), par, vcpu);
-- 
2.30.0.617.g56c4b15f3c-goog

