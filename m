Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3633B0C36
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbhFVSD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbhFVSDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:03:13 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F81C061A3F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:59:10 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id t144-20020a3746960000b02903ad9c5e94baso18998286qka.16
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=AxsRK2ImS4sX2YhbK1ZoKxLuOaRGjI3JwD6rPRybQYU=;
        b=pDmKsy23UTC+dTo/4uIFj4a+wCnm5aPUtxKO+DelRIoI1MICP/8r9THgzjEDmqtbdn
         gS6hr3PX15L4UCXbFsvW17Ycf1fAiM1vEzvXBSo1ysYAfgiYpaTfIdQhz0ugb/qDynCv
         KPA8ACRvRpcmkUAJ0yMc09I27wa2jIkFvxT0NyyjieAvWOmc6szi/Tkuf3j2bOuPasfv
         /tf+DNr4FGFLd2Z0xwn8a3KMdVmxDeOlU6GbyC8fwuderczhYAk2PuF6/BQzbRkrey0Z
         hFpN+Eqgfxgo97SwH2ZyESvSKZnThkuMrsZbr8cmi2PPrEbtuSTtahf6otB4ibA1FG0e
         orBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=AxsRK2ImS4sX2YhbK1ZoKxLuOaRGjI3JwD6rPRybQYU=;
        b=YnlPV/au6vXxFXWQ6iW3EZD0SN6pJqRlbXCuZ3DMgMYf1LTJIILbKwcgN/GL0aImdK
         neQogOSKPCwYNMjRm3XMAA9AV2VsXALVC+ggt5oq2TT25lebvHkhAUisTDFgdyCKD/3J
         KqmeFgD+QdF3qeWigl3YaeyljYMf4v5oQZ8Syu2/NowYjlX/LEyIHTRjWlBMnwju3Zy0
         QpU8jIofSbBimeomwqGzgXLI4T9ylRCiGc/GKRWpwAfvQZXTrf3enxIS+8O0cfsON5b4
         YFe43ql5SmNgBnTIooruLonFRoRtcj5yGSGwtxe1Bm1oU9Old8qqrJMmOF5auD4HTLOn
         ufjQ==
X-Gm-Message-State: AOAM530qJu1p2iZ7U90yTnRGCddtrU+s82kfZtkOTtISLXEtbiVBlg1i
        zM0rdvHpLAUaOqQUWqqHU4lsdWeXquc=
X-Google-Smtp-Source: ABdhPJyX0zZB8kxLADbwUwXSQoMZ1QccAerKbpDfYMqg0PqZYli2jyMSrWHkHaTQ/5gbICTOwwbaLuXbL8o=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:5722:92ce:361f:3832])
 (user=seanjc job=sendgmr) by 2002:a05:6214:311:: with SMTP id
 i17mr7885985qvu.57.1624384749550; Tue, 22 Jun 2021 10:59:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 22 Jun 2021 10:57:17 -0700
In-Reply-To: <20210622175739.3610207-1-seanjc@google.com>
Message-Id: <20210622175739.3610207-33-seanjc@google.com>
Mime-Version: 1.0
References: <20210622175739.3610207-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 32/54] KVM: x86/mmu: Use MMU's role to compute permission bitmask
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the MMU's role to generate the permission bitmasks for the MMU.
For some flows, the vCPU state may not be correct (or relevant), e.g.
the nested NPT MMU can be initialized with incoherent vCPU state.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c3bf5d4186e9..bd412e082356 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4365,8 +4365,7 @@ reset_ept_shadow_zero_bits_mask(struct kvm_vcpu *vcpu,
 	 (7 & (access) ? 128 : 0))
 
 
-static void update_permission_bitmask(struct kvm_vcpu *vcpu,
-				      struct kvm_mmu *mmu, bool ept)
+static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 {
 	unsigned byte;
 
@@ -4374,9 +4373,9 @@ static void update_permission_bitmask(struct kvm_vcpu *vcpu,
 	const u8 w = BYTE_MASK(ACC_WRITE_MASK);
 	const u8 u = BYTE_MASK(ACC_USER_MASK);
 
-	bool cr4_smep = kvm_read_cr4_bits(vcpu, X86_CR4_SMEP) != 0;
-	bool cr4_smap = kvm_read_cr4_bits(vcpu, X86_CR4_SMAP) != 0;
-	bool cr0_wp = is_write_protection(vcpu);
+	bool cr4_smep = is_cr4_smep(mmu);
+	bool cr4_smap = is_cr4_smap(mmu);
+	bool cr0_wp = is_cr0_wp(mmu);
 
 	for (byte = 0; byte < ARRAY_SIZE(mmu->permissions); ++byte) {
 		unsigned pfec = byte << 1;
@@ -4672,7 +4671,7 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
 		context->gva_to_gpa = paging32_gva_to_gpa;
 	}
 
-	update_permission_bitmask(vcpu, context, false);
+	update_permission_bitmask(context, false);
 	update_pkru_bitmask(vcpu, context, false);
 	update_last_nonleaf_level(vcpu, context);
 	reset_tdp_shadow_zero_bits_mask(vcpu, context);
@@ -4730,7 +4729,7 @@ static void shadow_mmu_init_context(struct kvm_vcpu *vcpu, struct kvm_mmu *conte
 
 	if (____is_cr0_pg(regs)) {
 		reset_rsvds_bits_mask(vcpu, context);
-		update_permission_bitmask(vcpu, context, false);
+		update_permission_bitmask(context, false);
 		update_pkru_bitmask(vcpu, context, false);
 		update_last_nonleaf_level(vcpu, context);
 	}
@@ -4838,7 +4837,7 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 	context->root_level = level;
 	context->direct_map = false;
 
-	update_permission_bitmask(vcpu, context, true);
+	update_permission_bitmask(context, true);
 	update_pkru_bitmask(vcpu, context, true);
 	update_last_nonleaf_level(vcpu, context);
 	reset_rsvds_bits_mask_ept(vcpu, context, execonly);
@@ -4935,7 +4934,7 @@ static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu)
 		g_context->gva_to_gpa = paging32_gva_to_gpa_nested;
 	}
 
-	update_permission_bitmask(vcpu, g_context, false);
+	update_permission_bitmask(g_context, false);
 	update_pkru_bitmask(vcpu, g_context, false);
 	update_last_nonleaf_level(vcpu, g_context);
 }
-- 
2.32.0.288.g62a8d224e6-goog

