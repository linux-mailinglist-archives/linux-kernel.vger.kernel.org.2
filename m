Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734F032AD65
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837532AbhCBVr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381058AbhCBS4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:56:35 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA6DC061225
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 10:46:01 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id f81so23415547yba.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 10:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=EnZFLski9RQiJKTWgrYgjdNat8xIrKSM9EmpDdRBoag=;
        b=scxjXT29yqaE1bBIE5x4Zgc6F4LOv8EyyWUiNAAv+qDm/hGXjM6o9kg5KhmWRVLUFM
         zhdR8/FEoWylqMQhxxHRXOmgM4H+qgRCyEhB8wDHUUXuiNZCbdlP9I1NtEUqdVkaTeam
         gugwntXjBdNu0JeTdAQsJcohYbSAh+LKkDEEfxFRTv1e3Ptcv+o+csDw8rXsx+ROPOPq
         PsNJl9LbRTh46hey3Z5YBQMwM9I1yUcTUhXsGy/vZXyLm/z6foWh2VFoUYuK3nA681DM
         DTp0zxmhLdpOzkoivjLs9wnh+z7T/CGXbwor9IaPLSpVlgJPeOWYp7nz0Gn2oUSa9Y78
         3gLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=EnZFLski9RQiJKTWgrYgjdNat8xIrKSM9EmpDdRBoag=;
        b=j4YON4MCAOT1YYdmc7ILUN4xc1fh6oCjCfNCV1NOSu2gAtdi7cs4QSOUvzxyZCIe4R
         DyfknZrg4VpPViWeHvqKIKpcu1fML8o2DNtOZchZDZIoy5dsnXQZWmGPZt6k8W9EKCgh
         UkSu1Iota0hpXuiHCfxSMp47J/Kemi7HM5kPkumKN+yha9tOr6nU91T/On55Pg4eq0P5
         Pdci9afPRTvDs3XN0rRsUNMSIrOG9g4JuNEQqms2m/iIAcXy/T0gVBOdIthOeRHR3+8Y
         y5ZdCnqjcVT0ARTI4IorflAnEs6BLVU4ruM7qBqh+1qU0FmiRnjF+3dgfbNkyhP7OM03
         9mMg==
X-Gm-Message-State: AOAM531gwS4YDfLJk0fvPSWq0gHibydE5cdrm5bgVWXZ4BGKTwDnKO6H
        Y/yG34OH84Qn4STLI3nTW9QPGI6m1qM=
X-Google-Smtp-Source: ABdhPJwv3m9DetMSaQqbcfD5ZJfQ7ppifSrZOl1LVpPtrJ2Cq+kVO1NCxwUULwBeK8zws6nAxNFtsyNNbBo=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:805d:6324:3372:6183])
 (user=seanjc job=sendgmr) by 2002:a25:e08b:: with SMTP id x133mr32155992ybg.138.1614710761217;
 Tue, 02 Mar 2021 10:46:01 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  2 Mar 2021 10:45:31 -0800
In-Reply-To: <20210302184540.2829328-1-seanjc@google.com>
Message-Id: <20210302184540.2829328-7-seanjc@google.com>
Mime-Version: 1.0
References: <20210302184540.2829328-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 06/15] KVM: x86/mmu: Fix and unconditionally enable WARNs to
 detect PAE leaks
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

Exempt NULL PAE roots from the check to detect leaks, since
kvm_mmu_free_roots() doesn't set them back to INVALID_PAGE.  Stop hiding
the WARNs to detect PAE root leaks behind MMU_WARN_ON, the hidden WARNs
obviously didn't do their job given the hilarious number of bugs that
could lead to PAE roots being leaked, not to mention the above false
positive.

Opportunistically delete a warning on root_hpa being valid, there's
nothing special about 4/5-level shadow pages that warrants a WARN.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index aa20e8d32197..3ef7fb2a9878 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3244,7 +3244,8 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 		vcpu->arch.mmu->root_hpa = root;
 	} else if (shadow_root_level == PT32E_ROOT_LEVEL) {
 		for (i = 0; i < 4; ++i) {
-			MMU_WARN_ON(VALID_PAGE(vcpu->arch.mmu->pae_root[i]));
+			WARN_ON_ONCE(vcpu->arch.mmu->pae_root[i] &&
+				     VALID_PAGE(vcpu->arch.mmu->pae_root[i]));
 
 			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT),
 					      i << 30, PT32_ROOT_LEVEL, true);
@@ -3289,8 +3290,6 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	 * write-protect the guests page table root.
 	 */
 	if (vcpu->arch.mmu->root_level >= PT64_ROOT_4LEVEL) {
-		MMU_WARN_ON(VALID_PAGE(vcpu->arch.mmu->root_hpa));
-
 		root = mmu_alloc_root(vcpu, root_gfn, 0,
 				      vcpu->arch.mmu->shadow_root_level, false);
 		vcpu->arch.mmu->root_hpa = root;
@@ -3339,7 +3338,8 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	}
 
 	for (i = 0; i < 4; ++i) {
-		MMU_WARN_ON(VALID_PAGE(vcpu->arch.mmu->pae_root[i]));
+		WARN_ON_ONCE(vcpu->arch.mmu->pae_root[i] &&
+			     VALID_PAGE(vcpu->arch.mmu->pae_root[i]));
 
 		if (vcpu->arch.mmu->root_level == PT32E_ROOT_LEVEL) {
 			if (!(pdptrs[i] & PT_PRESENT_MASK)) {
-- 
2.30.1.766.gb4fecdf3b7-goog

