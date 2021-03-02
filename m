Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6769C32A918
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352119AbhCBSLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345118AbhCBP2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:28:22 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AC2C0610CC
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:00:11 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id x5so13356910qti.23
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=dxCzN3RMauKWh2fvqFWMKg2laCezvVx9+eyFyeOVXIM=;
        b=SYScX5nR7lDOGlIBks1wS5OnBfnruugDhQBoDtlrcbZ3ivNnmk3Bs6FUZozkeKfqUw
         8FQnMyan0qCfc0piBSuDGa3ZdS6PWWoNnVtTdxngVrbsCxqT7kUhluPqK1E9J8/SZr+i
         ymJHr9JIAnzwHKh3RMDwHPcpJ/1u827BNbW4N6hu3aTniww7uqtKpch1dkNZ3MsFC9F9
         /G3yHgNC/ffTCpeOUZYbd0UcP/eV2nyrv2S+u2R+ppY+A9DLrs1gH7JOs0evPYZPAljI
         MLnL8vBSo6ZQhoQFgM9hj1r0lL4DQwJ6HLotKRxxq9PVfZ4bZAkBdIQcoTjnsNDO6jq5
         ZNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dxCzN3RMauKWh2fvqFWMKg2laCezvVx9+eyFyeOVXIM=;
        b=CbVKnvB97DP2lj+qTVFBqRTAvrgoiuNGQWSw4URTtKzAMVWusHuT+RNZwfWFuprV7u
         OwTJDmfsTqTXl25RyY5Pr/NBS9KK1Mr6+MuB9+Dym4xanvE+Xf5+KuqAm6QsTK0gvBdw
         nWUGtnTmNqUrJXWX6iKg4OFVkovL24XclVG1QB2SdHxoBq3ZcUY67s1ZqNGvr14+xaYY
         SgHHr1Ej2frAxvkrYNRX49Bcbj74T7l+CvoVqiRz299GFfw8zyMjlQH7HfQTnkgyzL2G
         DtFsoN6ELPXryKyHXdyGB3awG0yW5ncaj5FbrMYNZeIYqaeMOn7Yke48aAT+qEpMbCpd
         X+FA==
X-Gm-Message-State: AOAM5308581yXxegH46PvnhPdTsFZNgJr3YMFiiqxOpTeeuikrqgW4FH
        jWEqzS0OwV1ro5HAiHG8NlokDVFvrdSB
X-Google-Smtp-Source: ABdhPJxJVHSJYp6BIq2xVxKnGl6ariG1yZa/yPQUQ6PMkwXMADmlS67ocdrPIQpjgm15zvCkG4mhGRx9u+Bb
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:c60b:: with SMTP id
 v11mr19576129qvi.44.1614697210699; Tue, 02 Mar 2021 07:00:10 -0800 (PST)
Date:   Tue,  2 Mar 2021 14:59:32 +0000
In-Reply-To: <20210302150002.3685113-1-qperret@google.com>
Message-Id: <20210302150002.3685113-3-qperret@google.com>
Mime-Version: 1.0
References: <20210302150002.3685113-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 02/32] KVM: arm64: Link position-independent string
 routines into .hyp.text
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

Pull clear_page(), copy_page(), memcpy() and memset() into the nVHE hyp
code and ensure that we always execute the '__pi_' entry point on the
offchance that it changes in future.

[ qperret: Commit title nits and added linker script alias ]

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/hyp_image.h |  3 +++
 arch/arm64/kernel/image-vars.h     | 11 +++++++++++
 arch/arm64/kvm/hyp/nvhe/Makefile   |  4 ++++
 3 files changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/hyp_image.h b/arch/arm64/include/asm/hyp_image.h
index 737ded6b6d0d..78cd77990c9c 100644
--- a/arch/arm64/include/asm/hyp_image.h
+++ b/arch/arm64/include/asm/hyp_image.h
@@ -56,6 +56,9 @@
  */
 #define KVM_NVHE_ALIAS(sym)	kvm_nvhe_sym(sym) = sym;
 
+/* Defines a linker script alias for KVM nVHE hyp symbols */
+#define KVM_NVHE_ALIAS_HYP(first, sec)	kvm_nvhe_sym(first) = kvm_nvhe_sym(sec);
+
 #endif /* LINKER_SCRIPT */
 
 #endif /* __ARM64_HYP_IMAGE_H__ */
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 5aa9ed1e9ec6..4eb7a15c8b60 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -104,6 +104,17 @@ KVM_NVHE_ALIAS(kvm_arm_hyp_percpu_base);
 /* PMU available static key */
 KVM_NVHE_ALIAS(kvm_arm_pmu_available);
 
+/* Position-independent library routines */
+KVM_NVHE_ALIAS_HYP(clear_page, __pi_clear_page);
+KVM_NVHE_ALIAS_HYP(copy_page, __pi_copy_page);
+KVM_NVHE_ALIAS_HYP(memcpy, __pi_memcpy);
+KVM_NVHE_ALIAS_HYP(memset, __pi_memset);
+
+#ifdef CONFIG_KASAN
+KVM_NVHE_ALIAS_HYP(__memcpy, __pi_memcpy);
+KVM_NVHE_ALIAS_HYP(__memset, __pi_memset);
+#endif
+
 #endif /* CONFIG_KVM */
 
 #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index a6707df4f6c0..bc98f8e3d1da 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -9,10 +9,14 @@ ccflags-y := -D__KVM_NVHE_HYPERVISOR__ -D__DISABLE_EXPORTS
 hostprogs := gen-hyprel
 HOST_EXTRACFLAGS += -I$(objtree)/include
 
+lib-objs := clear_page.o copy_page.o memcpy.o memset.o
+lib-objs := $(addprefix ../../../lib/, $(lib-objs))
+
 obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
 	 hyp-main.o hyp-smp.o psci-relay.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o
+obj-y += $(lib-objs)
 
 ##
 ## Build rules for compiling nVHE hyp code
-- 
2.30.1.766.gb4fecdf3b7-goog

