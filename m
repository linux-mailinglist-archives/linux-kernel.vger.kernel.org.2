Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550ED32AD51
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350935AbhCBVkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577324AbhCBSuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:50:21 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7CFC061A86
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 10:46:23 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v6so23499240ybk.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 10:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=zBqYuQzYqXZuUz7wWVvo+o2pLB8f3Vunolmns9pwVP8=;
        b=KxmHKUHAYUpp0BZzBTJrdy95ud8ykZUG4XuLTzs7YG6WAIGg2Vb36WpSdPYtS2RG4M
         vcoXlGgljLFVnsvPO7uzRfaqqTTOIGQOfdrlBA8twvtUTebg5f95btqpBml0AoyXMdP1
         /K5ONmYCXT8YDNNGGq66LoEZ0zqiDS+qsYsoJqplmxMSmAUJzi6HGQE7+7SzGJWMfHsQ
         qcKMnAwDUHHYNdwGojtbR/2hg924mlFeY58M5tbyO16Pll62nH9tUdzd3weJU2LFhYSk
         l94nDy2cezC+ouVLivg/uU1q1SZBdA2fkVmbUI9scbeF34FdFoIttdga6Ws4eejrAvUv
         QUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=zBqYuQzYqXZuUz7wWVvo+o2pLB8f3Vunolmns9pwVP8=;
        b=nCJzeSu9urmzqiDHPxvkdL9MVL7JuTYR+ngBNCE7DaF1qJVPzZcH+6rDHGFy0HjsdX
         EyVmcLMszdE2dG9ymdd3FotsRON6m5p+LIsDCY0fC8hAUl629gMBqX3ow9Hg7lR4DMbm
         TVr7SAbddHBKudffNU6P3Cp6mv9ulmcpCkUgu1b82azr/NjpPm+cgrMPJlam2plzMaiv
         PeM3ElwVq60tDM4a+UN68uFIZbAkyt5kzQsaCRthbOCsLgqlKQ/2BuqlokAyPTUf8Oc+
         KOZNcodwYg4taSBOj1KGoXYDEUqpBKj/Uysz6YqCxzPg2XAGzq6LPq7Pi7/11D8Hw/RD
         IyUw==
X-Gm-Message-State: AOAM530mV3MImdvSDlqoC/uQq58/ANh2QgWzVIHaSUofNLb3R+8ANuoa
        uyZ6GN6eBfvHTdTwfXBX3SqCn2Gd/o8=
X-Google-Smtp-Source: ABdhPJyzdm9UNlhvQlwfULHP76PgQpjC8ZOw2uHTjdczOMWXqJX0skjLrOvOgr96OidyUOnWHZcla6JJ2CI=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:805d:6324:3372:6183])
 (user=seanjc job=sendgmr) by 2002:a25:c689:: with SMTP id k131mr32210406ybf.515.1614710782684;
 Tue, 02 Mar 2021 10:46:22 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  2 Mar 2021 10:45:40 -0800
In-Reply-To: <20210302184540.2829328-1-seanjc@google.com>
Message-Id: <20210302184540.2829328-16-seanjc@google.com>
Mime-Version: 1.0
References: <20210302184540.2829328-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 15/15] KVM: x86/mmu: WARN on NULL pae_root and bad shadow root level
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

WARN if KVM is about to derference a NULL pae_root when loading an MMU,
and convert the BUG() on a bad shadow_root_level into a WARN (now that
errors are handled cleanly).  With nested NPT, botching the level and
sending KVM down the wrong path is all too easy, and the on-demand
allocation of pae_root means bugs crash the host.  Obviously, KVM could
unconditionally allocate pae_root, but that's arguably a worse failure
mode as it would potentially corrupt the guest instead of crashing it.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 34eeb39ee0f9..35f89bb1f205 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3247,6 +3247,9 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 				      true);
 		vcpu->arch.mmu->root_hpa = root;
 	} else if (shadow_root_level == PT32E_ROOT_LEVEL) {
+		if (WARN_ON_ONCE(!vcpu->arch.mmu->pae_root))
+			return -EIO;
+
 		for (i = 0; i < 4; ++i) {
 			WARN_ON_ONCE(vcpu->arch.mmu->pae_root[i]);
 
@@ -3256,8 +3259,10 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 						      shadow_me_mask;
 		}
 		vcpu->arch.mmu->root_hpa = __pa(vcpu->arch.mmu->pae_root);
-	} else
-		BUG();
+	} else {
+		WARN_ONCE(1, "Bad TDP root level = %d\n", shadow_root_level);
+		return -EIO;
+	}
 
 	/* root_pgd is ignored for direct MMUs. */
 	vcpu->arch.mmu->root_pgd = 0;
@@ -3340,6 +3345,8 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 		vcpu->arch.mmu->lm_root = lm_root;
 
 		lm_root[0] = __pa(vcpu->arch.mmu->pae_root) | pm_mask;
+	} else if (WARN_ON_ONCE(!vcpu->arch.mmu->pae_root)) {
+		return -EIO;
 	}
 
 	for (i = 0; i < 4; ++i) {
-- 
2.30.1.766.gb4fecdf3b7-goog

