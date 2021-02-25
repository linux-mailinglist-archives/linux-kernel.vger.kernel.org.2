Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342313257ED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhBYUsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhBYUsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:48:41 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A55C061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:48:00 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id p136so7622146ybc.21
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=dqqMnpXbv9GtgsoIAfcqn+NffK0Y9luh9hhBXNIAc1w=;
        b=LJrgs6eZBraYVLoHmXIbR/ceJisGaqISWo801gt9OBRf/fqEOrARTU61943OgAt7yN
         uTJEXaSbNbI/J/kZvNqKJ+YbIIkcl99nWfok3tiBtpDuFv0Bo7Qcy3Su+JkCC+kevDJ4
         kI+FNjrBFAWNaXCKT+o3POGGNrXRZm6mSJy+36NZdwIrhD/ftaXw7gMEqSk1JZ+rXoKe
         nzA57bjON7jkDgenv8nutLeRNRzibmkp767w6dtzFVXD07PXspPK9ttwJBRksipLFbok
         RWddPDWAVkSdKPHkgU4SqywGssuRH3AQxtKIjyT8hPEQ82EkXSCaX7nHpv1UmPEEWz6t
         BRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=dqqMnpXbv9GtgsoIAfcqn+NffK0Y9luh9hhBXNIAc1w=;
        b=glaGruGA45bd4XItkI0KPl3xx4vekwnPF1PBP5haASRl4DiD2BY7G9d+gG3Fd8BZ4m
         iYg+DtkgVfuQb/AeB1JgVLlp6VfdCLh2XaEHpLigwyrtP3Omg28LRSnCNzGsKZRw0W7O
         TFSX9evyUUEzMsqvYDSvRY1smyMtB/oveie6SCPT8kJv6fV3ifrtTaQBnqxjDpzuQOAQ
         BUt0MmxvbsMuhPIxUegyCTi2xVG40fxvM58+W0dHykE3ksIFQazhRmGiSVLFVEDc1nWp
         EDa4I0KyorPQengh7BZ4JqvA+cawc3ciPg58t3AlETaAO8jwcjSojXbNZDweyWljA1UP
         zeMg==
X-Gm-Message-State: AOAM530Y821vhdHqFXBOaL6aggflkD4jlx/K0ED/ZkwRxyWoVbPVx/rQ
        MW6Wri2LIKKap+xy76BYrqfrBJm1FyA=
X-Google-Smtp-Source: ABdhPJz2moruALIIKXz6XYFjRun2PuAcc2wsLbw3y5G/mYWepR5qnXm0prqWXw9TX9g8mKVJPKdKrN1xgy0=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:34c4:7c1d:f9ba:4576])
 (user=seanjc job=sendgmr) by 2002:a25:74d4:: with SMTP id p203mr6436875ybc.75.1614286080185;
 Thu, 25 Feb 2021 12:48:00 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 25 Feb 2021 12:47:26 -0800
In-Reply-To: <20210225204749.1512652-1-seanjc@google.com>
Message-Id: <20210225204749.1512652-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210225204749.1512652-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 01/24] KVM: x86/mmu: Set SPTE_AD_WRPROT_ONLY_MASK if and only
 if PML is enabled
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check that PML is actually enabled before setting the mask to force a
SPTE to be write-protected.  The bits used for the !AD_ENABLED case are
in the upper half of the SPTE.  With 64-bit paging and EPT, these bits
are ignored, but with 32-bit PAE paging they are reserved.  Setting them
for L2 SPTEs without checking PML breaks NPT on 32-bit KVM.

Fixes: 1f4e5fc83a42 ("KVM: x86: fix nested guest live migration with PML")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu_internal.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 72b0928f2b2d..ec4fc28b325a 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -81,15 +81,15 @@ static inline struct kvm_mmu_page *sptep_to_sp(u64 *sptep)
 static inline bool kvm_vcpu_ad_need_write_protect(struct kvm_vcpu *vcpu)
 {
 	/*
-	 * When using the EPT page-modification log, the GPAs in the log
-	 * would come from L2 rather than L1.  Therefore, we need to rely
-	 * on write protection to record dirty pages.  This also bypasses
-	 * PML, since writes now result in a vmexit.  Note, this helper will
-	 * tag SPTEs as needing write-protection even if PML is disabled or
-	 * unsupported, but that's ok because the tag is consumed if and only
-	 * if PML is enabled.  Omit the PML check to save a few uops.
+	 * When using the EPT page-modification log, the GPAs in the CPU dirty
+	 * log would come from L2 rather than L1.  Therefore, we need to rely
+	 * on write protection to record dirty pages, which bypasses PML, since
+	 * writes now result in a vmexit.  Note, the check on CPU dirty logging
+	 * being enabled is mandatory as the bits used to denote WP-only SPTEs
+	 * are reserved for NPT w/ PAE (32-bit KVM).
 	 */
-	return vcpu->arch.mmu == &vcpu->arch.guest_mmu;
+	return vcpu->arch.mmu == &vcpu->arch.guest_mmu &&
+	       kvm_x86_ops.cpu_dirty_log_size;
 }
 
 bool is_nx_huge_page_enabled(void);
-- 
2.30.1.766.gb4fecdf3b7-goog

