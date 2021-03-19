Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E388F341967
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhCSKDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhCSKDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:03:04 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E59C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:03:03 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id p133so9866820qka.17
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=72klzlc424mmLnO4+mJQoCgQ9qRpj0AFz2PNi4O1btg=;
        b=TMZfoBWZybpbOvmfNQdWuKj+QVKLPZzdehM7jBlnqDYUOKYV3P/bzmuXd9DoW51F8R
         H6kFU8L0dmMyPxVo6VKzl0acSAKA4miwiVfDJC2HaQLLKPJVKpVuNECdOvffl0h20EGZ
         dki+nPIqygOPTh07KcxIji93rqNvHQ/YplTidtBxHrXcga0uelpTSZ2ciZ26j4uc0BiH
         HGy7Ctq2zMR9RMv3+Nww1SOu1DedI/hlRfgdFh1lRqoBGPGSb0v4Eu5hpQ/sOow7W0QU
         BiB9P1/vWKs+V5Dv34S8S2KeMqtEpLRBiF45IC2HkWJWzyyj0By+9TDBtYVd88DAn7ux
         XhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=72klzlc424mmLnO4+mJQoCgQ9qRpj0AFz2PNi4O1btg=;
        b=eFOlyLhv8mZwZIQNZtdTetATatgPmdxEC7CfKp2//T3f3THP0oSlcNgy2Rh59RXlgl
         QXoO39As33Oa4SnryEyKWJcCJ4LLJ+RN78VcTI6YUEeEpIL1nJd5P0hHJTDAN5KZ7Vhs
         lZA/QPx9PGkgL0W5CwthGGh8Nqmbu+8Djt2Chn+GdQonzpN8zdMZA+T/Z7iVW/0F+PAV
         zstwNW0kQKMYkT6QafVp28Ko/+86vrmbVD0Ldt9Mc/1MYpI6/1lRogUrmn0YJAddaXwe
         PlUowa4j6Yo5MwSNBPj9Rg/9w7jGgIclF3C+Y/ZMAEc+E4V7b6RZFS+ejJoaweQQjduX
         ICog==
X-Gm-Message-State: AOAM530wzZ6g4yzNRvQ36+XnYjy3xo1+MDWWF5nfa6JSwfGRkpf2VG4b
        rekTt96c48dvk2D7ddfgG4bkoRdamj1n
X-Google-Smtp-Source: ABdhPJz5Nn0SRzIcLJbprGdjasWPY3TTPXoVZ8gwqBfwupsjTDVeieeAgP/GqFP3q3tkNq0mnFuOA6wwnW1X
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:6214:15d1:: with SMTP id
 p17mr8491639qvz.28.1616148182510; Fri, 19 Mar 2021 03:03:02 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:42 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-35-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 34/38] KVM: arm64: Provide sanitized mmfr* registers at EL2
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

We will need to read sanitized values of mmfr{0,1}_el1 at EL2 soon, so
add them to the list of copied variables.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_cpufeature.h | 2 ++
 arch/arm64/kvm/hyp/nvhe/hyp-smp.c       | 2 ++
 arch/arm64/kvm/sys_regs.c               | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_cpufeature.h b/arch/arm64/include/asm/kvm_cpufeature.h
index c2e7735f502b..ff302d15e840 100644
--- a/arch/arm64/include/asm/kvm_cpufeature.h
+++ b/arch/arm64/include/asm/kvm_cpufeature.h
@@ -20,5 +20,7 @@
 #endif
 
 DECLARE_KVM_HYP_CPU_FTR_REG(arm64_ftr_reg_ctrel0);
+DECLARE_KVM_HYP_CPU_FTR_REG(arm64_ftr_reg_id_aa64mmfr0_el1);
+DECLARE_KVM_HYP_CPU_FTR_REG(arm64_ftr_reg_id_aa64mmfr1_el1);
 
 #endif
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-smp.c b/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
index 71f00aca90e7..17ad1b3a9530 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
@@ -13,6 +13,8 @@
  * Copies of the host's CPU features registers holding sanitized values.
  */
 DEFINE_KVM_HYP_CPU_FTR_REG(arm64_ftr_reg_ctrel0);
+DEFINE_KVM_HYP_CPU_FTR_REG(arm64_ftr_reg_id_aa64mmfr0_el1);
+DEFINE_KVM_HYP_CPU_FTR_REG(arm64_ftr_reg_id_aa64mmfr1_el1);
 
 /*
  * nVHE copy of data structures tracking available CPU cores.
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 3ec34c25e877..dfb3b4f9ca84 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2784,6 +2784,8 @@ struct __ftr_reg_copy_entry {
 	struct arm64_ftr_reg	*dst;
 } hyp_ftr_regs[] __initdata = {
 	CPU_FTR_REG_HYP_COPY(SYS_CTR_EL0, arm64_ftr_reg_ctrel0),
+	CPU_FTR_REG_HYP_COPY(SYS_ID_AA64MMFR0_EL1, arm64_ftr_reg_id_aa64mmfr0_el1),
+	CPU_FTR_REG_HYP_COPY(SYS_ID_AA64MMFR1_EL1, arm64_ftr_reg_id_aa64mmfr1_el1),
 };
 
 void __init setup_kvm_el2_caps(void)
-- 
2.31.0.rc2.261.g7f71774620-goog

