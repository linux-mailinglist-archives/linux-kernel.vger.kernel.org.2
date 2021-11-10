Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF2E44CCE0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 23:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbhKJWeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 17:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbhKJWeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 17:34:09 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37438C061228
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 14:31:13 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x14-20020a627c0e000000b0049473df362dso2720443pfc.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 14:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kiIatwAlHvvu2uBeY4ii96e1dHU62kAmoLcLl2YIwuU=;
        b=RnDqEGa/fEcU2We4hgto9VMn8KlebfcLVZiOFRmtEeoUfA42ScMbhhwf2EyLQ657fN
         mIJcNlq//gcq7sGDAaP2vVXJkRZ9KHQfahF6uNMfjkKte9KKk26GkrRuP78aDPZBlvaN
         28ulYf5vXbt5A1h6hgPU9OM+XyKvThbrmG+hrgl8mchydnzLzsiP5P50bJEVr5l+Qeo1
         ewZR2wDzQN+gEhyct5BRm6QZVul+MEvcMKGHwIWe0UKRNUntcWMRkcwIgpVZ0QZ0FVCA
         ACjP1Hh+pHd9ROVQpC22dUxnSoa0rSHPQU92ogo+RXYssTlhPRTA2Yn6OEr8SuHpgj/m
         HIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kiIatwAlHvvu2uBeY4ii96e1dHU62kAmoLcLl2YIwuU=;
        b=kCKQmTIufv9UPrkRphgSg/5Ag+NOUt7U56YtGkGxuNm6UAfT5owMLvygbY+Ux3QEth
         oxZXJ2vSTlyNwApIXFp3P6YI+sFLjWThxH3O72MyR/1Ry9JgrvX9Oc/zAQH0U7tf/viw
         LmzaPDD0s53D1Z1mp+qpLtu0AnT9FZPirY8iRVb8qgvnwLrcGrHGS5A9dGD0Kw3xbg5T
         PMnPIweSj4M7Stq5yeh9Oe2mZ/FDOGuYyllF3FNprzihqYP3z4D1TufByYCmZxR1Yi7n
         Lq5knN0qH6M2lwyU4y+dKDW7CjYhnVtrT958qbyOteUixRhixN3Hvz8YqRLcfuWqahyf
         OAGg==
X-Gm-Message-State: AOAM530SpttcMgpYUxhZ+gKkHg7DD4goaDo7roHo+7GY0B+lJ/ghF0Tg
        u5dZPfSLnS1siykc3caEhd5o9jJl26DQzZn8Z7gHJguKvHEbDnaI3yXT+ZVV3IMUksVpMYronAK
        4jnDrRHMK6oya9e5PVZmNvhkTRXeqHe5L6PYHFETM/xaq3rWNt4DvWefaU753qwiunUWPybTj
X-Google-Smtp-Source: ABdhPJxRkOjjvaAjzujyF2bBDUfldGJ3U4LikPZF4vwA1t4IZQZ/JS3wXmtHCpgOAl3XM9zKZg/6GD+smOA7
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:6586:7b2f:b259:2011])
 (user=bgardon job=sendgmr) by 2002:a17:90a:4a85:: with SMTP id
 f5mr21194680pjh.92.1636583472609; Wed, 10 Nov 2021 14:31:12 -0800 (PST)
Date:   Wed, 10 Nov 2021 14:30:09 -0800
In-Reply-To: <20211110223010.1392399-1-bgardon@google.com>
Message-Id: <20211110223010.1392399-19-bgardon@google.com>
Mime-Version: 1.0
References: <20211110223010.1392399-1-bgardon@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [RFC 18/19] KVM: x86/mmu: Make kvm_is_mmio_pfn usable outside of spte.c
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Kai Huang <kai.huang@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export kvm_is_mmio_pfn from spte.c. It will be used in a subsequent
commit for in-place lpage promotion when disabling dirty logging.


Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/spte.c | 2 +-
 arch/x86/kvm/mmu/spte.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 7be41d2dbb02..13b6143f6333 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -68,7 +68,7 @@ u64 make_mmio_spte(struct kvm_vcpu *vcpu, u64 gfn, unsigned int access)
 	return spte;
 }
 
-static bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
+bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
 {
 	if (pfn_valid(pfn))
 		return !is_zero_pfn(pfn) && PageReserved(pfn_to_page(pfn)) &&
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index d7598506fbad..909c24c733c4 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -347,4 +347,5 @@ u64 kvm_mmu_changed_pte_notifier_make_spte(u64 old_spte, kvm_pfn_t new_pfn);
 
 void kvm_mmu_reset_all_pte_masks(void);
 
+bool kvm_is_mmio_pfn(kvm_pfn_t pfn);
 #endif
-- 
2.34.0.rc0.344.g81b53c2807-goog

