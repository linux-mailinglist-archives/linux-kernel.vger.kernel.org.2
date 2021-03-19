Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B58341931
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhCSKCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhCSKBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:01:55 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80588C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:01:55 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id h5so21518680wrr.17
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QCiwKULDYqVgexkGV6Dq4fSAHDULaRDXCu3D8lkxqPg=;
        b=YsykdfHMlrALCZI0j/lFF8X23+hN+Zu3fDiK1ID85DnPouGtnQLEmewg79JgR6rjVF
         kPU/iYhzhmpW8dg5GxiWf5NEbaAPjywICzQZOnlcn+pOldrRNy48XFX5MPV3IPrAXBSn
         9qtwV0D9x9ZsilM3McX3RcpvJdUARTU8n08E5gu7j+N1u52VviYAWxhBVM1+gtr7z/Ow
         NyFvxEPGlX3fblHkO0JxtGDo+SUSPEVzgjWiR6bmEERmFVqlWBhtgJG18fTfo66C8BOR
         9kK9G7CoQRoNzALus8imZsx/9855keRRGBrUso/WZ+1cKQz7/UsVIHBlcuFkJV1Rdlwe
         RDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QCiwKULDYqVgexkGV6Dq4fSAHDULaRDXCu3D8lkxqPg=;
        b=XNmEo02BwNngz/G+b9bdkMl61kdPB7xB8NGHihBawivTbU/byzfM+6jiBKcZxX4I2E
         kFNQvjG8dyjS8siqqHNwMJ9gwyty+y3RhuuLkfamVKxNATHqZYXTbOyoT+QcaP/2zT+R
         d0HOHygyApoLc17SdDAiLqYeHtPd3PO3klM5V5Cc6FNh9PxEaLkwgy3CtTWjo8mnJotF
         UNUA0/3IbmWLAy7VeeEMtMhWL8RVKr6xZ/MarllRSBvJZXYl7E7D7MlilFrEayBBCJzR
         amEG488OroAgJ7PyJRjFK8r+uNCrJHj6mBYGNRIT0XTA9OTHAEWLSvuaG6kJ+T4AowUY
         OpEw==
X-Gm-Message-State: AOAM530N4B0a18wgz6FamjX8dsgTryTbS6EhXSQRL0YbuSEOetHe1P3c
        yubqi+d10vQ3aRwejiXU3YbTNmrrJS0w
X-Google-Smtp-Source: ABdhPJynBItS8S3NsqD1ssoT1ZqH19/azGgDhWvgPMOcebHSNlUyhK+MNUoRziO27fIkmI2sqEz5Xbr29CO/
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:600c:4f55:: with SMTP id
 m21mr2914524wmq.11.1616148114138; Fri, 19 Mar 2021 03:01:54 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:10 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-3-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 02/38] KVM: arm64: Link position-independent string
 routines into .hyp.text
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, qperret@google.com
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
2.31.0.rc2.261.g7f71774620-goog

