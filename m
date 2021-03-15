Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794F733BF07
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241711AbhCOOxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239457AbhCOOgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:36:21 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D332FC0613DF
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:10 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id m9so15210773wrx.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=82gUjSiOy75013Ao/6wOddaZLFu0pa6owwuj1ggeuy4=;
        b=CD9bFfHL7VhMeePH17RF85emad8M7ZhRkOPIKahkEZ7HAAfIyxJpxFRokWpU32rFK1
         CzmaNCf+CCicqi+lk0p6Kvc37kc5L8PrGXpJcG/3oWqxwsDB5902k+kIYrZlNy95lekM
         IzF3use+ujY9UWJXdWi56mWRemJDlG7Xu98WTdWA1GndJDFoMBWOXaNzo8YUBErWGIwp
         CoqIM3BZqmueTp6q1/MpOuU+qpqIOJpDiIHw0PyfeAoZ0zn5Rg0Q9nChCJG0uflFusau
         3eMHJJHLViXpQmyPsZ8hZuLTpesIibwx+AcCBPlYjSON+7OmBlaQApjjCUAD5AfBNss+
         OlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=82gUjSiOy75013Ao/6wOddaZLFu0pa6owwuj1ggeuy4=;
        b=qhR8Xc5asG/lgVw6jDrD0suj4rgd0NNjudczNx6U1z6uKX6+EZGIn/2u8/kkpusTpH
         HCW0QICerscke3BX72cAMGaIcIAdMMje7Hq6erI2h6ApH9IjciCKuTpx62IUold3vqVJ
         JCR0B9FEquGR3obvsPipeELrtpt3lA+P+ySzHOrRkzQtcZmtRv0Bbb1hVxjqv6UCcVs6
         3NWEkB/dJXGshJpYgYAoy9nKVXVdUNYOJGi3zmzA/fUqWTYmjMZO1Q21AmMiW71z4FvB
         8DWRV5YuUujQywZpjuR8loj8HL/dTwm9BIRPPCvax5Ssp/jzpUIVXtgHERHtWTvrBoa+
         Me6w==
X-Gm-Message-State: AOAM530fv/Lf3kUpIP1UiqdWJtVDn7y5jyXoIbgcsY5HFSaEkf0rkom2
        8OO3Kk89gJGye6YJER0jZgEc5mqeodQY
X-Google-Smtp-Source: ABdhPJx9xRKDOfRDFlI/TfqGPcgwP0Fg2uHLCHIdGqPsMxwfgsZghPG6ZkVnzBXOgz/h4g5be4yqugrc6gdm
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a7b:c188:: with SMTP id
 y8mr33590wmi.76.1615818969596; Mon, 15 Mar 2021 07:36:09 -0700 (PDT)
Date:   Mon, 15 Mar 2021 14:35:14 +0000
In-Reply-To: <20210315143536.214621-1-qperret@google.com>
Message-Id: <20210315143536.214621-15-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v5 14/36] KVM: arm64: Provide __flush_dcache_area at EL2
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

We will need to do cache maintenance at EL2 soon, so compile a copy of
__flush_dcache_area at EL2, and provide a copy of arm64_ftr_reg_ctrel0
as it is needed by the read_ctr macro.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_cpufeature.h |  2 ++
 arch/arm64/kvm/hyp/nvhe/Makefile        |  3 ++-
 arch/arm64/kvm/hyp/nvhe/cache.S         | 13 +++++++++++++
 arch/arm64/kvm/sys_regs.c               |  1 +
 4 files changed, 18 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/cache.S

diff --git a/arch/arm64/include/asm/kvm_cpufeature.h b/arch/arm64/include/asm/kvm_cpufeature.h
index 3fd9f60d2180..efba1b89b8a4 100644
--- a/arch/arm64/include/asm/kvm_cpufeature.h
+++ b/arch/arm64/include/asm/kvm_cpufeature.h
@@ -13,3 +13,5 @@
 #define KVM_HYP_CPU_FTR_REG(name) extern struct arm64_ftr_reg kvm_nvhe_sym(name)
 #endif
 #endif
+
+KVM_HYP_CPU_FTR_REG(arm64_ftr_reg_ctrel0);
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 6894a917f290..42dde4bb80b1 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -13,7 +13,8 @@ lib-objs := clear_page.o copy_page.o memcpy.o memset.o
 lib-objs := $(addprefix ../../../lib/, $(lib-objs))
 
 obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
-	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o stub.o page_alloc.o
+	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o stub.o page_alloc.o \
+	 cache.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o
 obj-y += $(lib-objs)
diff --git a/arch/arm64/kvm/hyp/nvhe/cache.S b/arch/arm64/kvm/hyp/nvhe/cache.S
new file mode 100644
index 000000000000..36cef6915428
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/cache.S
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Code copied from arch/arm64/mm/cache.S.
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/alternative.h>
+
+SYM_FUNC_START_PI(__flush_dcache_area)
+	dcache_by_line_op civac, sy, x0, x1, x2, x3
+	ret
+SYM_FUNC_END_PI(__flush_dcache_area)
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 6c5d133689ae..3ec34c25e877 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2783,6 +2783,7 @@ struct __ftr_reg_copy_entry {
 	u32			sys_id;
 	struct arm64_ftr_reg	*dst;
 } hyp_ftr_regs[] __initdata = {
+	CPU_FTR_REG_HYP_COPY(SYS_CTR_EL0, arm64_ftr_reg_ctrel0),
 };
 
 void __init setup_kvm_el2_caps(void)
-- 
2.31.0.rc2.261.g7f71774620-goog

