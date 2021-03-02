Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DC932AD73
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837694AbhCBV6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581625AbhCBTA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 14:00:56 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49741C0611C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 10:46:04 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id u17so23734855ybi.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 10:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=kSiLnMDkk0ckb4albKKYSCbZaXElHQozT1Z/Ps7GfuI=;
        b=OHQSzC1bWC97Wo53/ZEgH7WOW5Ud0ZEnUvSaVvwdq0Ra5F8k+TKijqaCAAblPm/5Dj
         oS9Z5TX7fNhYfkDqOWOquzZMzgUZ0T+Al3eaKVABvAHfEVJQUcb015O9QRMbVLhNcCw0
         ThjWF23s8VRE2VMwpEsEZxFwRs0OJwpQ6n6IZpB4w/v9lJukl0TqknRXeh/2uGIOQeNe
         hkX6ChPh1Iq1RNBAMpC/+dx0BD5GseF6sHk/ffR1CAz4dXqRAmkjyQdy78zTtft+S+cc
         tKq4/73jmYQ9JJhdJ1oGQbX5eAof9aOBtgXzkB1Np4O+3uF8TGNWJ5cvdDzIThnAjv+Z
         juMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=kSiLnMDkk0ckb4albKKYSCbZaXElHQozT1Z/Ps7GfuI=;
        b=DnVWWBQB5eANEHuHfgxO74hBZ8JI8aPDrJCOabqpUdfdYoquOI6+N/2We/Lv98TRSZ
         WEouZgUDAwHecXKV+/BqYoOk78sDre6gvDh+ywT5/qIgqe3Kor+UmP1sXLzS8/Gnqg3E
         G3go68T1gK8+bdgKQ7LlhN8Tm1FlwHiFoQGWpIKYqilfR15FjAoYUQBrhY2vNXTbA/Zu
         8r4xKG35FlxPwfYNnIOUe10Ron4NI/0oLdtBgGHs+qqTwWFNXJS1SedmdjO4tyMI3D0V
         w747WkKp0Tauf3XmGoVK2mbo6+r0kxKB5mzKIWzU39R5heOoEoZ8yVPPBNhMMSmtm4ku
         biNg==
X-Gm-Message-State: AOAM532oIQsCoNeQAKwyodj/A2/HMTglBhL7KdQgLyEIWPFKQCPzGgT6
        2lp9Pjd/MqwgiH5QSgAAM5kg0QLwVoQ=
X-Google-Smtp-Source: ABdhPJyhoCBxSZ78KfAXRL1vCHIkU/3TxPhR2oR2b1EZQg7JjcPgRbrYiftVi5G0tXXzEVlJaeHqFI3Eapk=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:805d:6324:3372:6183])
 (user=seanjc job=sendgmr) by 2002:a25:d296:: with SMTP id j144mr32687925ybg.33.1614710763543;
 Tue, 02 Mar 2021 10:46:03 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  2 Mar 2021 10:45:32 -0800
In-Reply-To: <20210302184540.2829328-1-seanjc@google.com>
Message-Id: <20210302184540.2829328-8-seanjc@google.com>
Mime-Version: 1.0
References: <20210302184540.2829328-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 07/15] KVM: x86/mmu: Use '0' as the one and only value for an
 invalid PAE root
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use '0' to denote an invalid pae_root instead of '0' or INVALID_PAGE.
Unlike root_hpa, the pae_roots hold permission bits and thus are
guaranteed to be non-zero.  Having to deal with both values leads to
bugs, e.g. failing to set back to INVALID_PAGE, warning on the wrong
value, etc...

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 3ef7fb2a9878..59b1709a55b4 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3191,11 +3191,14 @@ void kvm_mmu_free_roots(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 		    (mmu->root_level >= PT64_ROOT_4LEVEL || mmu->direct_map)) {
 			mmu_free_root_page(kvm, &mmu->root_hpa, &invalid_list);
 		} else if (mmu->pae_root) {
-			for (i = 0; i < 4; ++i)
-				if (mmu->pae_root[i] != 0)
-					mmu_free_root_page(kvm,
-							   &mmu->pae_root[i],
-							   &invalid_list);
+			for (i = 0; i < 4; ++i) {
+				if (!mmu->pae_root[i])
+					continue;
+
+				mmu_free_root_page(kvm, &mmu->pae_root[i],
+						   &invalid_list);
+				mmu->pae_root[i] = 0;
+			}
 		}
 		mmu->root_hpa = INVALID_PAGE;
 		mmu->root_pgd = 0;
@@ -3244,8 +3247,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 		vcpu->arch.mmu->root_hpa = root;
 	} else if (shadow_root_level == PT32E_ROOT_LEVEL) {
 		for (i = 0; i < 4; ++i) {
-			WARN_ON_ONCE(vcpu->arch.mmu->pae_root[i] &&
-				     VALID_PAGE(vcpu->arch.mmu->pae_root[i]));
+			WARN_ON_ONCE(vcpu->arch.mmu->pae_root[i]);
 
 			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT),
 					      i << 30, PT32_ROOT_LEVEL, true);
@@ -3338,8 +3340,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	}
 
 	for (i = 0; i < 4; ++i) {
-		WARN_ON_ONCE(vcpu->arch.mmu->pae_root[i] &&
-			     VALID_PAGE(vcpu->arch.mmu->pae_root[i]));
+		WARN_ON_ONCE(vcpu->arch.mmu->pae_root[i]);
 
 		if (vcpu->arch.mmu->root_level == PT32E_ROOT_LEVEL) {
 			if (!(pdptrs[i] & PT_PRESENT_MASK)) {
@@ -3412,7 +3413,7 @@ void kvm_mmu_sync_roots(struct kvm_vcpu *vcpu)
 	for (i = 0; i < 4; ++i) {
 		hpa_t root = vcpu->arch.mmu->pae_root[i];
 
-		if (root && VALID_PAGE(root)) {
+		if (root && !WARN_ON_ONCE(!VALID_PAGE(root))) {
 			root &= PT64_BASE_ADDR_MASK;
 			sp = to_shadow_page(root);
 			mmu_sync_children(vcpu, sp);
@@ -5267,7 +5268,7 @@ static int __kvm_mmu_create(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu)
 
 	mmu->pae_root = page_address(page);
 	for (i = 0; i < 4; ++i)
-		mmu->pae_root[i] = INVALID_PAGE;
+		mmu->pae_root[i] = 0;
 
 	return 0;
 }
-- 
2.30.1.766.gb4fecdf3b7-goog

