Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD3733BEFD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240883AbhCOOwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237242AbhCOOgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:36:50 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9973AC0613EE
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:47 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id v5so8277000wml.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1sjrUiSLuOCFjAOkDHJ7nIx3ITkYs7fzKUyioa9mJ40=;
        b=EOHSqjIMLmTf3oiHD3RmkQcg9TZQYTPctLXy/V0f4BziHbVqUX4uyYFanP57G0CqZI
         kzH0qQ5cG6HSkzlr2E6ZjBNTir0mCD9Xy/Q2r8YD/Q/0eD4/CfrgYntSiZXDWGJ8AQLF
         K7vAW/ZAEawiWUdqMIfWOXIHRSDOOGUN4+2mgH8PhRZEPrviBcwlTL64shC35HSCg2cV
         yA7QoWm3cE4oP82rVDLmEUTOKg7Gh6EkGAbV42LPvCYkPus+4yoeGdy5BNuntlGmO/HT
         hY8/sQzuF/64X1ZaQK/NfUB161/P5+453+qtxBm6aW4ApoFK5iIG/3lrPBatWLFurlbf
         oRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1sjrUiSLuOCFjAOkDHJ7nIx3ITkYs7fzKUyioa9mJ40=;
        b=pps3bxzjXgqH6fUCaDcmMyoG7JMzQw7jq66BjAvMeWB/u2KPcX+Me4abZOhfAeLGux
         8qFbet8YpTpKfuaqzJHBLDxsRTnDXpJhRYwoSFt9HEROT5Sjh6U0kxtF6WcX6ya+BQwE
         kVro3Ls2LPon80sr/980pH67XmR0kypFwp+Ixt7PYXj9sVlYVmuXI5/BW/NLzPu8rgQz
         cJNB5RJreGIIGkN6nSFfXDHasrPt5xlnWPMLx9xmL8N5bnjZiV3IXIpjl8v3tcXnP+Z9
         CfqofGhdAYjZSDsnixUic8Fx0WpUeHnjT3FyrDQ4Edla83h5Se3fn0zb/3yQAvauVaDH
         OhuA==
X-Gm-Message-State: AOAM531m4weqSq5QJu+y5r67wnGgF6RrmAcNQycC5jLpxyOB18z0B/FC
        GQ6zYJv2UcbT7PMEBSfdzCDdiuh3aQn7
X-Google-Smtp-Source: ABdhPJxRU1Y0mzNBnxlekqfWtLXk/SoCMst6R7gkuiF3eTNottSRcVQMhVqaCB4Xbuwrq8TclRXAUa/wMXdR
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a7b:c75a:: with SMTP id
 w26mr2323wmk.49.1615819006355; Mon, 15 Mar 2021 07:36:46 -0700 (PDT)
Date:   Mon, 15 Mar 2021 14:35:32 +0000
In-Reply-To: <20210315143536.214621-1-qperret@google.com>
Message-Id: <20210315143536.214621-33-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v5 32/36] KVM: arm64: Provide sanitized mmfr* registers at EL2
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

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_cpufeature.h | 2 ++
 arch/arm64/kvm/sys_regs.c               | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_cpufeature.h b/arch/arm64/include/asm/kvm_cpufeature.h
index efba1b89b8a4..48cba6cecd71 100644
--- a/arch/arm64/include/asm/kvm_cpufeature.h
+++ b/arch/arm64/include/asm/kvm_cpufeature.h
@@ -15,3 +15,5 @@
 #endif
 
 KVM_HYP_CPU_FTR_REG(arm64_ftr_reg_ctrel0);
+KVM_HYP_CPU_FTR_REG(arm64_ftr_reg_id_aa64mmfr0_el1);
+KVM_HYP_CPU_FTR_REG(arm64_ftr_reg_id_aa64mmfr1_el1);
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

