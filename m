Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA7333BEF9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240271AbhCOOwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbhCOOgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:36:49 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC71C0613E4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:29 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id r18so8239444wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GjgSG2oEX6Y5d63Q6T6vut7ZZTlqBxwi5efWbFs4G3E=;
        b=Aa8fUv21ijIEQhNQRFlfwR/ZR0ql0KDFcjJ2wWkBRKMMqZHPVWvEVhkPGuKSA25VmE
         IB3ju2RX15BiJq/PiF0wmfJ37jVOYGLAr2w7w7MrpAOVvSBID3xTJO2yLASU+Xutfl65
         yWDDZ/PPzZua3NRiptTTgpjqlmJgF8nVbFUFCm6QIWv9aUUjNyjFUQQYKv5FeFufo1fv
         EwZiUFJ60WQQfevwMGcHLKIDQzqK77UgnIbGPwyVsX65v3xp006rtl2UcTE67DymvaWJ
         J2xmcWsgDLnKDpC5CLUerUWv9iB4quj0WrhNx4vMoV1rWtAHo60X1w2vzNYZUB2FMgHk
         d2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GjgSG2oEX6Y5d63Q6T6vut7ZZTlqBxwi5efWbFs4G3E=;
        b=n/qlBavJtCXjfzEomT92PxZDFayq7L4lNKiwGSffV7ujq0tromnmQawW+wCUApZUA7
         tBpX5lp5ALIkB05ObQlco7cwaO82mh6Q2+JyRbaf0rhUFEjPpIvUzX13K+j1eBwDg2Lg
         V/kq8TohYJkdPxATwMQCPKNEwgAyMUvTm2d/FH7eAZWu15hUMOb1BtyUEzGbXaPs3vwc
         /A4A3aJXYIODZGwG4ui8BV12795CCrC0Ck52eLmZvldK1zjhqC3oWUrIRuopf4e8xx+z
         IYuQeuOUXGPN7tXRSADa0n7oOSP5UTu/iOgzuBwrGFnTH6Qeydx8DXd10aYmcxtmxrxJ
         XnQQ==
X-Gm-Message-State: AOAM531f5+aZk7oSb8ouQrSH3Oem3PxiEyx76EKk017c2XowwZ/hVJVj
        vv1tCCq3jUpTNpqTbA6SIAe4QAYIhQNT
X-Google-Smtp-Source: ABdhPJxRVdeyBsJa/HlT/zZefSVJKkc7JEEzUjQpsvXHTeJJD8923jx01t3RtCKophvOBQkDzIaQSSKtF6NW
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:6243:: with SMTP id
 w64mr1121799wmb.0.1615818987813; Mon, 15 Mar 2021 07:36:27 -0700 (PDT)
Date:   Mon, 15 Mar 2021 14:35:23 +0000
In-Reply-To: <20210315143536.214621-1-qperret@google.com>
Message-Id: <20210315143536.214621-24-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v5 23/36] KVM: arm64: Refactor __load_guest_stage2()
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

Refactor __load_guest_stage2() to introduce __load_stage2() which will
be re-used when loading the host stage 2.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 6f743e20cb06..9d64fa73ee67 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -270,9 +270,9 @@ static __always_inline u64 kvm_get_vttbr(struct kvm_s2_mmu *mmu)
  * Must be called from hyp code running at EL2 with an updated VTTBR
  * and interrupts disabled.
  */
-static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu)
+static __always_inline void __load_stage2(struct kvm_s2_mmu *mmu, unsigned long vtcr)
 {
-	write_sysreg(kern_hyp_va(mmu->arch)->vtcr, vtcr_el2);
+	write_sysreg(vtcr, vtcr_el2);
 	write_sysreg(kvm_get_vttbr(mmu), vttbr_el2);
 
 	/*
@@ -283,6 +283,11 @@ static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu)
 	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_SPECULATIVE_AT));
 }
 
+static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu)
+{
+	__load_stage2(mmu, kern_hyp_va(mmu->arch)->vtcr);
+}
+
 static inline struct kvm *kvm_s2_mmu_to_kvm(struct kvm_s2_mmu *mmu)
 {
 	return container_of(mmu->arch, struct kvm, arch);
-- 
2.31.0.rc2.261.g7f71774620-goog

