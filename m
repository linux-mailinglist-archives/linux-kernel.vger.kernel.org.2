Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E0933BEE8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbhCOOvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236465AbhCOOfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:35:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CDFC061762
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:35:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n10so38045639ybb.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QCiwKULDYqVgexkGV6Dq4fSAHDULaRDXCu3D8lkxqPg=;
        b=iK3iA9Le6NIOxFqnnOGydvPsVh9eFpoc5tZQ8MakyNCAPomspGiuigZpQT6lwe3SFF
         /yQ3hpyI19AJd0uIM49IUp2khK9zKhKeViLxpWNrkLFdaqAA2e99nV8o8EjsvBsx+WX6
         FmImG2PnItPG0E6aP6zsd65tpscbF6tnWMAjwsJBqRYM/7h7LmkR2P5F7WKgmgz+YycA
         j/qDN2taN3kjSG0UC0Etzj81u2s0ZA+AfypGwk+q12JbHrDeO7VkrwQjtCnbyR87sGSp
         booCjHiMTwH+6EeeBQ2cPhr4+LFyX7Ie71bcgPpvbKymD62byTXAQBfi4RY2CPcQl0do
         CNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QCiwKULDYqVgexkGV6Dq4fSAHDULaRDXCu3D8lkxqPg=;
        b=eb2+4K2vUWqv6yfuIIgKP3VcOKGoNIofzYSPwxvmV/HzzEysyt92BGuQTyCaQJesGC
         mVQhOI7Hzhwkce4WDaBv59XKN06O5rBwXuoprpNeKlQg8/9rSZ59WFqiIj4jU6pRxKlf
         H6YSxNmxzPifyU6AJnXKOZ0f6gwLaKa25Wmg7ZFCdBlOiOsP6uWHDm4EdDEZJg86iEsG
         LGtN3xKUy0v6Q4EBYVzYfI2n43Gk6drZrhrK0NyuhNcV023yGDg2K9Nio4yJTIr0HUoL
         G0p3e81oetxTmW9hlj67AXqvFmFc833seML+b6UKYOSrmjBbgEUq5X8YUacJH/O2mTVx
         OqoQ==
X-Gm-Message-State: AOAM530Yv6t95ttTBtjLPInPL3L+U2+kVrTXOLbZrj+NuD98XnYxhrEY
        F2OSN406tRamHGvMrlpC28c6jkhDthDP
X-Google-Smtp-Source: ABdhPJwHGIHg9XTZbc3HEBIYJ9tmGlbLwS4HxToVqjqt4gD1/EyubOCELNOgZ+D5F1ItCkeU8vcMEm6n+dsT
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a25:3354:: with SMTP id
 z81mr38906912ybz.289.1615818943871; Mon, 15 Mar 2021 07:35:43 -0700 (PDT)
Date:   Mon, 15 Mar 2021 14:35:02 +0000
In-Reply-To: <20210315143536.214621-1-qperret@google.com>
Message-Id: <20210315143536.214621-3-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v5 02/36] KVM: arm64: Link position-independent string
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

