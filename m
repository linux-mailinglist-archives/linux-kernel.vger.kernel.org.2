Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9703B0C34
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbhFVSDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbhFVSDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:03:11 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B7EC061A32
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:59:08 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y5-20020a37af050000b02903a9c3f8b89fso19031015qke.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=H8ArnWlUNfoAxDJNt3hI336FC1ZAyBAzOuUBrFRlP+c=;
        b=Bnv/Cqw3SGOaMwXrlE5IAjRdvibUZQO8cQGd0wND0ys5E1f5JsNoZWowJ9r18xA0Xv
         RWvITiqcwT9afAr4UHD9PKLMYehdKpU8F1eKy0vqvShSL0NiJtDNI5QM6GgSrypwHKA2
         MMT7ERrOit0WNsvi2nBgoOskdg8K5emIPBSWJFy1ZJJkJZrlvwi2jmNn/n7l7HJRZtp9
         Qvt9doF6vHYsAZhQaXPk/N8zFt0BwOtUGHrHVcLEBOpXriOsL+2lxxOU+epq0nrP2aCZ
         KoDMFj8HyCW/KBWUS9/iMqdzhsc2h1HqwLTw0iD4l2w37GD7vyeM3uM/8jEWFdakn/Nr
         vSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=H8ArnWlUNfoAxDJNt3hI336FC1ZAyBAzOuUBrFRlP+c=;
        b=ClQx+4XszYZrDV4Lo0BbsSx4lykJJ48sAkBp8oA8ogx6OtKUlL9SD0ZTvtNCneAWDs
         P8LBm5AnWbgBE6ET+NWptm2lS/30ABDw8LTbX/illJeEcAv31xu83kFjNhtV/ppTIhpn
         AYeMR5VrNawhl1nDPf4uxiV+hfjoXYZe+Vk+rQ9bNpH/OBBR1+NB/MiAfc7nAph6it7d
         nk7WfUwy+pVWozwRuuqxt6Qbx2ryIqRONj750OyEh8NiKAcVYTOSv0smhBEekUWAZ2tp
         kxM+/pT40iscqQMRuBY7cql3Ps5kXbew9GhDgvERYZdebXx7hS71N4NzmY4nr/iYt4NB
         xgcw==
X-Gm-Message-State: AOAM533f+lwkGNa1Mn5iiwxnTqm3XKmNBdrHTS/eKFz1Wy0TxYfE+LLc
        FFuEbaH5rmP2G5siKvAGweWLwTlP2cY=
X-Google-Smtp-Source: ABdhPJy7prasZnVsVu93Mki513dM4gcsPMBYy1gDNHzMWo2A+0gIm7DNpjphZgOl8rawhlsX+kVCfpmA4GA=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:5722:92ce:361f:3832])
 (user=seanjc job=sendgmr) by 2002:a25:8607:: with SMTP id y7mr6676021ybk.17.1624384747179;
 Tue, 22 Jun 2021 10:59:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 22 Jun 2021 10:57:16 -0700
In-Reply-To: <20210622175739.3610207-1-seanjc@google.com>
Message-Id: <20210622175739.3610207-32-seanjc@google.com>
Mime-Version: 1.0
References: <20210622175739.3610207-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 31/54] KVM: x86/mmu: Drop vCPU param from reserved bits calculator
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

Drop the vCPU param from __reset_rsvds_bits_mask() as it's now unused,
and ideally will remain unused in the future.  Any information that's
needed by the low level helper should be explicitly provided as it's used
for both shadow/host MMUs and guest MMUs, i.e. vCPU state may be
meaningless or simply wrong.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e912d9a83e22..c3bf5d4186e9 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4119,8 +4119,7 @@ static inline bool is_last_gpte(struct kvm_mmu *mmu,
 #undef PTTYPE
 
 static void
-__reset_rsvds_bits_mask(struct kvm_vcpu *vcpu,
-			struct rsvd_bits_validate *rsvd_check,
+__reset_rsvds_bits_mask(struct rsvd_bits_validate *rsvd_check,
 			u64 pa_bits_rsvd, int level, bool nx, bool gbpages,
 			bool pse, bool amd)
 {
@@ -4212,7 +4211,7 @@ __reset_rsvds_bits_mask(struct kvm_vcpu *vcpu,
 static void reset_rsvds_bits_mask(struct kvm_vcpu *vcpu,
 				  struct kvm_mmu *context)
 {
-	__reset_rsvds_bits_mask(vcpu, &context->guest_rsvd_check,
+	__reset_rsvds_bits_mask(&context->guest_rsvd_check,
 				vcpu->arch.reserved_gpa_bits,
 				context->root_level, context->nx,
 				guest_cpuid_has(vcpu, X86_FEATURE_GBPAGES),
@@ -4292,8 +4291,7 @@ static void reset_shadow_zero_bits_mask(struct kvm_vcpu *vcpu,
 	WARN_ON_ONCE(context->shadow_root_level < PT32E_ROOT_LEVEL);
 
 	shadow_zero_check = &context->shadow_zero_check;
-	__reset_rsvds_bits_mask(vcpu, shadow_zero_check,
-				reserved_hpa_bits(),
+	__reset_rsvds_bits_mask(shadow_zero_check, reserved_hpa_bits(),
 				context->shadow_root_level, uses_nx,
 				guest_cpuid_has(vcpu, X86_FEATURE_GBPAGES),
 				is_pse, is_amd);
@@ -4328,8 +4326,7 @@ reset_tdp_shadow_zero_bits_mask(struct kvm_vcpu *vcpu,
 	shadow_zero_check = &context->shadow_zero_check;
 
 	if (boot_cpu_is_amd())
-		__reset_rsvds_bits_mask(vcpu, shadow_zero_check,
-					reserved_hpa_bits(),
+		__reset_rsvds_bits_mask(shadow_zero_check, reserved_hpa_bits(),
 					context->shadow_root_level, false,
 					boot_cpu_has(X86_FEATURE_GBPAGES),
 					false, true);
-- 
2.32.0.288.g62a8d224e6-goog

