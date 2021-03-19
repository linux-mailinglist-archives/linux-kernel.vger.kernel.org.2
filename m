Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335E7341950
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhCSKCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhCSKCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:02:21 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F767C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:21 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id i5so21572379wrp.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=K4McwqDhxnQfwM3x1riKe9KKt/V2sRmghUw1PVC3tdA=;
        b=OWizihQTxeoK0OkGiJM+DF3rJK1yEnncsb2/J6XoEmbk1W17MDNc6FchxdrVYqtXme
         8/5EQWkGBf685M2ymHAe+kfQu7tM/lrRmWdEN1LeEqKLgxQ7eHGXcKCQ8y6TOE4Uv8NL
         gYhqRGIsHKZdr/3ZhsMUGD/PXClAtSb3KPHMib3NQWgkGh2o3icFSi+rknIptMozyDaB
         r5L5Q+J3gV2g8qqwiCz9538VNBShhhfPG4S98zIzt9n0856wCxdMtl5ax/UTsYeViZ45
         Gpdsba74IfeBCn/co6goQDOvZwLUA8mfgwFmCh50b49voBR9jPtVSBZrIrUWVFZ+WE4H
         Jgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K4McwqDhxnQfwM3x1riKe9KKt/V2sRmghUw1PVC3tdA=;
        b=FhOG9JPDs6VV60WdSynmeTwF/LcsMlg6KaI+xDyF1PtOb3BJclZBHKLYWCiYjoCY1Q
         9gf/q5nmRBLGF0SWD9g7mJ8VzLwGa5b7FBvh1WoLI2Efv6aYcV4SB5BTjfRNOG6YzTFU
         iuJNpzoJinwysiKBxtWApQp4zWL3V13gNCwi1X21k6MZ7zsx2BjhZINfpnxdQbx+hhG9
         vFy4u+bVcupfXyz4cBIbSVXqTpWutz/KH3ynzoXfp/ay3tL0zqkf1BRH2t7Ok7FSUa8a
         bOMqLt5aylEQ9i74I7IH78mfEoRgzekdLm6y9lmJfWEbXcTjgmWaBVMF9UX2JZ3zKMo/
         IsaQ==
X-Gm-Message-State: AOAM5314Z2vkI2OOOIa5PTSLSO7ODVukE9tFOJzX5jUC+zralkJnlwxy
        cjyBoMHftaeBYyceHHpQ/0Zxpk41Mj6l
X-Google-Smtp-Source: ABdhPJy2pjU9chhbWoXKyCKmpezg7yxDnPrC3R6tHeGO7BRlQSoiYjTFgF9dFhbNIN3Oj8+UjcRdEPChZLUy
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:6243:: with SMTP id
 w64mr1313174wmb.0.1616148139504; Fri, 19 Mar 2021 03:02:19 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:22 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-15-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 14/38] KVM: arm64: Provide __flush_dcache_area at EL2
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
 arch/arm64/kvm/hyp/nvhe/hyp-smp.c       |  6 ++++++
 arch/arm64/kvm/sys_regs.c               |  1 +
 5 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/cache.S

diff --git a/arch/arm64/include/asm/kvm_cpufeature.h b/arch/arm64/include/asm/kvm_cpufeature.h
index 3d245f96a9fe..c2e7735f502b 100644
--- a/arch/arm64/include/asm/kvm_cpufeature.h
+++ b/arch/arm64/include/asm/kvm_cpufeature.h
@@ -19,4 +19,6 @@
 #define DEFINE_KVM_HYP_CPU_FTR_REG(name) BUILD_BUG()
 #endif
 
+DECLARE_KVM_HYP_CPU_FTR_REG(arm64_ftr_reg_ctrel0);
+
 #endif
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
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-smp.c b/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
index 879559057dee..71f00aca90e7 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
@@ -5,9 +5,15 @@
  */
 
 #include <asm/kvm_asm.h>
+#include <asm/kvm_cpufeature.h>
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
 
+/*
+ * Copies of the host's CPU features registers holding sanitized values.
+ */
+DEFINE_KVM_HYP_CPU_FTR_REG(arm64_ftr_reg_ctrel0);
+
 /*
  * nVHE copy of data structures tracking available CPU cores.
  * Only entries for CPUs that were online at KVM init are populated.
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

