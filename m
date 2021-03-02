Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9D332A82D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349725AbhCBRTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 12:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384504AbhCBPFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:05:19 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5D5C0698C2
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:00:39 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id s192so1311281wme.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=84bkslXA7Qi7zlX0xHNbjR4XGFTrfSQqHB0l+SkjRTk=;
        b=aEyIjsz9Q39OmQlGKhPsdWMeCxwA+8gfzAIcUr3vtuH7vJkQ/TC8zCkBwOeeBT65tq
         UvSouJ8Birgm8kdd91FSgiyZCYROychF8+9Sg1dSYXCER9zOEopyAV4P/kgm4Ysxeidy
         7ft7SR+/KlrHCJgsZMEZ51u1Cmk9vBYllJNwbmgZ1ompvmxQEqTIg6O0Ypw4YW+TiLNY
         Bdfy60xclmeqbqcp8GDWtDDVvsqYWew2CdzBsipN3fqfz7oI3broHa+hdFZwgg01rnPc
         IAtkChQhjHl8hf9R0x8GkU6smUb+gwabjgaL22vSTdg2PoB4sWRTIVOgQBrjdOfDE6Mh
         olZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=84bkslXA7Qi7zlX0xHNbjR4XGFTrfSQqHB0l+SkjRTk=;
        b=mBMSQIEi9mkkRl+jSaagfguDIEBLNRWW6iM6shqO+uXPTG0Prz/LjkoLimffwU4IPx
         qr+dMYQGofXjkuomyouwCuox5TIaZXDkIhbyQfaJJqw9fqJ7/SWPRMn6oUAb78qWH5VB
         XH0wok88ZA2NpnApI8gfCQwaKdjxR3ic7EqoPr2i7x0ToRUoB/QEf6npBQqiJQ7SSwYo
         Cxs6mS468i5hc3Lk3TwlnKVoi0+2DiXgOv+GsX6bka2UDs1UC9C6M1shplHQIxFybScj
         ivL3iLxx1eEDVoD6qdV0o2BLuOEuK9jvIKvN8IuHUQ3QKqLUgfpH7j0S+bmKHACE6Cs4
         uqYA==
X-Gm-Message-State: AOAM532gwnuvPssA+e8oQRFvQ57CFZdlgg1dgExm6O5FrO22Zh7mxQ0s
        096qLoMJiJ37GKJcAzHYsOB2HBJP6QGl
X-Google-Smtp-Source: ABdhPJwFUzBVYVUNUz65kgYHvUCXtvq4NXrt8gCrlNsOFSMTng7gs+AjbNDT7VknGe5P7PaLfd9Y7549RF9U
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:2e90:: with SMTP id
 u138mr496527wmu.0.1614697237854; Tue, 02 Mar 2021 07:00:37 -0800 (PST)
Date:   Tue,  2 Mar 2021 14:59:44 +0000
In-Reply-To: <20210302150002.3685113-1-qperret@google.com>
Message-Id: <20210302150002.3685113-15-qperret@google.com>
Mime-Version: 1.0
References: <20210302150002.3685113-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 14/32] KVM: arm64: Factor out vector address calculation
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
2.30.1.766.gb4fecdf3b7-goog

