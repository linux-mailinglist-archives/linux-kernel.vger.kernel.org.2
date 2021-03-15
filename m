Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C49133BEF4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239870AbhCOOwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbhCOOgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:36:48 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E629C0613E0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:13 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id m9so15210812wrx.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3hA7tosEY4dPQwz7wIkxBpuvpX7Hy1acE9O5r7Hvk3A=;
        b=VPdm53sxCIyfLckE3eCIPGFnhmYvji9+FFRac0tP5RFkNTeQjU3PyWF73wMpp3qHuq
         MRq80VDnvyyJZtBXgaMd+6qwAuEqoVacMii3LnsVTDa6VXGxQd2FDcKgPXOQlfHbf2hr
         7jeLnfAWLaA5hmrMMDXGstV9vSBjjgFM2Iz2GsUR/MPprlCiITEsgWZZZvIbviMyi3ky
         4hUqbjDNdpbvNidGmiLsNlpyjlKOmgE7+fKcw7rBk8FUhXTO4oiZZPbiFgfRypFdEd6R
         Fe+FdmnVguWbs048n5yF43ce39d2OX9fdmx8TfQzKJJ5yZWFdUKFlB0NqvPvJOJOzcez
         BdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3hA7tosEY4dPQwz7wIkxBpuvpX7Hy1acE9O5r7Hvk3A=;
        b=XedPWHA82Ya8Bhr1Po3TrYfs6W+o3iozj3ftGQ0AKsXKNqt0f3QP4jNDQI0EIHNubF
         j1e2zGV6/Icjt9L7il/3s5gYIvqa9lge0Jc6AJFwxO9n+cWYXN/R7D07rFpohtJlO1tX
         qyJGkXv6umtOsf+BZo7Cnho1OYolvWETkCuTscMFeENecubRucDiQdGlbhgIH5dL3bAW
         f8ijgfYbSH++MFU/5CcQKtFQPDqxuqORlMYbpRn6XhQZPppcsAvn4uz+31PpJhGu65Wj
         wUSTL6EG1z9n7MhHihDZ26YV80xm9sauFJersIXBvtQxBPQal2TU2+TYB6UdbA84vrlY
         n22w==
X-Gm-Message-State: AOAM533sl6tQ/vM4wMKmazrIGIP+lDTZ+Ew30jeTvSMXm1Q4RLwbekpE
        K8FphH/Ll5L4uXqKlYuZrCQ1S8oLBpVW
X-Google-Smtp-Source: ABdhPJzYhRfdIlEKb6klF7NPABZ+u2gjQiVHViCdjX1yjgBMKmlXOcLm5BOWaFgW0byaeWgbp83VIVYMf99n
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a7b:c18e:: with SMTP id
 y14mr1121168wmi.1.1615818971570; Mon, 15 Mar 2021 07:36:11 -0700 (PDT)
Date:   Mon, 15 Mar 2021 14:35:15 +0000
In-Reply-To: <20210315143536.214621-1-qperret@google.com>
Message-Id: <20210315143536.214621-16-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v5 15/36] KVM: arm64: Factor out vector address calculation
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

In order to re-map the guest vectors at EL2 when pKVM is enabled,
refactor __kvm_vector_slot2idx() and kvm_init_vector_slot() to move all
the address calculation logic in a static inline function.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 8 ++++++++
 arch/arm64/kvm/arm.c             | 9 +--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 90873851f677..5c42ec023cc7 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -168,6 +168,14 @@ phys_addr_t kvm_mmu_get_httbr(void);
 phys_addr_t kvm_get_idmap_vector(void);
 int kvm_mmu_init(void);
 
+static inline void *__kvm_vector_slot2addr(void *base,
+					   enum arm64_hyp_spectre_vector slot)
+{
+	int idx = slot - (slot != HYP_VECTOR_DIRECT);
+
+	return base + (idx * SZ_2K);
+}
+
 struct kvm;
 
 #define kvm_flush_dcache_to_poc(a,l)	__flush_dcache_area((a), (l))
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 3f8bcf8db036..26e573cdede3 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1345,16 +1345,9 @@ static unsigned long nvhe_percpu_order(void)
 /* A lookup table holding the hypervisor VA for each vector slot */
 static void *hyp_spectre_vector_selector[BP_HARDEN_EL2_SLOTS];
 
-static int __kvm_vector_slot2idx(enum arm64_hyp_spectre_vector slot)
-{
-	return slot - (slot != HYP_VECTOR_DIRECT);
-}
-
 static void kvm_init_vector_slot(void *base, enum arm64_hyp_spectre_vector slot)
 {
-	int idx = __kvm_vector_slot2idx(slot);
-
-	hyp_spectre_vector_selector[slot] = base + (idx * SZ_2K);
+	hyp_spectre_vector_selector[slot] = __kvm_vector_slot2addr(base, slot);
 }
 
 static int kvm_init_vector_slots(void)
-- 
2.31.0.rc2.261.g7f71774620-goog

