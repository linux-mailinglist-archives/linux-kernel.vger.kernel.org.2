Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047303A1D4B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 20:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFIS7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 14:59:34 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:40709 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhFIS7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 14:59:33 -0400
Received: by mail-yb1-f201.google.com with SMTP id 67-20020a2514460000b029053a9edba2a6so32619368ybu.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 11:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=0CaB8MiFn1kbTM2jLhslSZkeic630/6bzBLYSPn7JDs=;
        b=aBTzOzCR6Oq43l5XvTdJmBFXgY47Qi/ffDzY8Pyz0jZbWgxZxU2+KJvCAe8JRQWvO/
         U8Jh4WQLPeJ6ZY2h9X0ZTszPnweQ/lhdK9unoecYdcsKf/yrgzlltXQ4By2lzgzKHoAT
         ofxl4qiA1Sq/M979kgmGXdXMnX4PI1FQVuySSYDx8V55+Q2/ECdKxji2UE0sGndebxvo
         LKhfVjzABvEZ0ksfgbxVMljDriRzdwlmYEu2rJITl7szLkV3qDoYG6MPMsRibiYZSRrQ
         eWG7pBAGzcPnR7HeDYz2/JFUpi7Qcg9zNDqlCVzu184sgxOt5LivDS3SJ6+1+fkbtpOW
         NWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=0CaB8MiFn1kbTM2jLhslSZkeic630/6bzBLYSPn7JDs=;
        b=B4rS8blvDIWLsLYdDOzqmBCWrqo6qBBuONQxlR8+JY8GJMOLK+NDCi5DcAvBGuotwY
         tl+a2gm9HZWfACTJE/a5a7X2sxA0OJdNVNlbee7CIkBwhmqQsbKtuq8W6IYEbvyN3rPS
         262GdPsaUCFl/OzwNENF5f3EweW3OVHDdEXjp0oK6kj2D9c+DAH5MZgU6q3CNOzklnsX
         ay8B4L6nvAV/8LJT4h9EAwPTbdk74WJUu5Nt6SKrvLAPtc25fGsjj5tV+OzxFwo8wplL
         rt5zJq1smiUq0dCwm7watsyIARvILKZW6O6vBZzCPZP2CYywGzjRZPb3w71jv62A6y45
         0FFA==
X-Gm-Message-State: AOAM532UJlXd5yNynLgEfSeB4pB6XlUYvaRlmcDU6qCaHSoLmxzDUcjz
        fd9v/3Vnkdwccc5tyvNy+acOqG0ymOs=
X-Google-Smtp-Source: ABdhPJzrrwcaWqtP07pU3eXQdo9RBOLggQuxPbSeiJNkQDSvdUZkTrJKPd7JrakU0wDoDxxRqN7xXQhGo4Q=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:bfdc:c2e5:77b1:8ef3])
 (user=seanjc job=sendgmr) by 2002:a25:b8c:: with SMTP id 134mr2120266ybl.332.1623264997995;
 Wed, 09 Jun 2021 11:56:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  9 Jun 2021 11:56:13 -0700
In-Reply-To: <20210609185619.992058-1-seanjc@google.com>
Message-Id: <20210609185619.992058-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210609185619.992058-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH 3/9] KVM: x86: Replace .set_hflags() with dedicated
 .exiting_smm() helper
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+fb0b6a7e8713aeb0319c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the .set_hflags() emulator hook with a dedicated .exiting_smm(),
moving the SMM and SMM_INSIDE_NMI flag handling out of the emulator in
the process.  This is a step towards consolidating much of the logic in
kvm_smm_changed(), including the SMM hflags updates.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c     | 3 +--
 arch/x86/kvm/kvm_emulate.h | 2 +-
 arch/x86/kvm/x86.c         | 6 +++---
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 0603a2c79093..9e0d5900c011 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2638,8 +2638,7 @@ static int em_rsm(struct x86_emulate_ctxt *ctxt)
 	if ((ctxt->ops->get_hflags(ctxt) & X86EMUL_SMM_INSIDE_NMI_MASK) == 0)
 		ctxt->ops->set_nmi_mask(ctxt, false);
 
-	ctxt->ops->set_hflags(ctxt, ctxt->ops->get_hflags(ctxt) &
-		~(X86EMUL_SMM_INSIDE_NMI_MASK | X86EMUL_SMM_MASK));
+	ctxt->ops->exiting_smm(ctxt);
 
 	/*
 	 * Get back to real mode, to prepare a safe state in which to load
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 9c34aa60e45f..b620782c1fb5 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -229,7 +229,7 @@ struct x86_emulate_ops {
 	void (*set_nmi_mask)(struct x86_emulate_ctxt *ctxt, bool masked);
 
 	unsigned (*get_hflags)(struct x86_emulate_ctxt *ctxt);
-	void (*set_hflags)(struct x86_emulate_ctxt *ctxt, unsigned hflags);
+	void (*exiting_smm)(struct x86_emulate_ctxt *ctxt);
 	int (*pre_leave_smm)(struct x86_emulate_ctxt *ctxt,
 			     const char *smstate);
 	void (*post_leave_smm)(struct x86_emulate_ctxt *ctxt);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cda148cf06fa..69a71c5019c1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7104,11 +7104,11 @@ static unsigned emulator_get_hflags(struct x86_emulate_ctxt *ctxt)
 	return emul_to_vcpu(ctxt)->arch.hflags;
 }
 
-static void emulator_set_hflags(struct x86_emulate_ctxt *ctxt, unsigned emul_flags)
+static void emulator_exiting_smm(struct x86_emulate_ctxt *ctxt)
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
 
-	vcpu->arch.hflags = emul_flags;
+	vcpu->arch.hflags &= ~(HF_SMM_MASK | HF_SMM_INSIDE_NMI_MASK);
 	kvm_mmu_reset_context(vcpu);
 }
 
@@ -7174,7 +7174,7 @@ static const struct x86_emulate_ops emulate_ops = {
 	.guest_has_fxsr      = emulator_guest_has_fxsr,
 	.set_nmi_mask        = emulator_set_nmi_mask,
 	.get_hflags          = emulator_get_hflags,
-	.set_hflags          = emulator_set_hflags,
+	.exiting_smm         = emulator_exiting_smm,
 	.pre_leave_smm       = emulator_pre_leave_smm,
 	.post_leave_smm      = emulator_post_leave_smm,
 	.triple_fault        = emulator_triple_fault,
-- 
2.32.0.rc1.229.g3e70b5a671-goog

