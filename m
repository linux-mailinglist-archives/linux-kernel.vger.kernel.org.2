Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250BA31A955
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 02:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhBMBJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 20:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbhBMBHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 20:07:08 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7787C06121D
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 17:05:46 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u17so1600962ybi.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 17:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=4l7lJ89dUN/mDifctyjmka3i9z9nrBYEG0xhjmdSUUo=;
        b=YuUYSqFaQ2X/0AytqcSo2UGtMt7JtxTw3r9Xzk7NzwzyffwnESubnEoE7LsExZarvt
         8+srTOrLYWx8VNCnh+NMkLm8HBBYc1aW8jDYfjBjnNkbW2s58daTr3p+gHwV0OxNV4Sy
         hdMM2vEhrY+wf282MZxoJGM4ELVodFjb7XGiRYxSVFYFPhMv9IfdS1QpJBg37RLjdTaS
         Buc7LUfI+pockTKv0tdUNTVMnQEvhEy6Y6evVbg5LUTcpDwaFrNuNyICJdyXI3KOy5Dz
         HFreFKXVzbUi+HaSHgAEDNC4ycPviQrRrczVyEzojLuex32wF3Q5yVCFbp69zythHxiO
         pEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=4l7lJ89dUN/mDifctyjmka3i9z9nrBYEG0xhjmdSUUo=;
        b=mxfiiiUjVPOEDI0TRysAzDWwAqCAm8i8rhQLPz+23ii/Ts0GLvQ91UfDppbI1ytStg
         3YHSXrZDvF6XlKa2UCTNZV5+U7BDWDOvgaKAk10bDB7G27ZAJ3E056d+9OJle7g/k28U
         Uj5mvrNQtHr4VBRD5xv3xbjvnRK566iyz5T0KUiewgt4ijBsr1Xhuq4B4uXmKl4NmlkD
         0F2eXmt8wvx4lmA5njqdVDYhH5Kvp0c9jF7AuI+c5rWhe+jcl9dXaWMNZYAEqU3RIsnQ
         40kTqeg/QAfLrOAugda3cqsBBezuSXV/g+2kTc2Urjvet8AeKj8K0zHUgqoqR2fawI18
         L1oA==
X-Gm-Message-State: AOAM533w1eQtfOXP6/MpsbxutbshPEps6iFavqinahFqUmXD9ZV9KfV2
        ToY3lEZB1tnUkOe1qawpdwtUw3AZsww=
X-Google-Smtp-Source: ABdhPJwRv7XF/pVWzpewg9HbbCCXg2ivDZcIqXVajCZywXnqWbM7K4Of/uyX2s/OJKRsluXzj0diKX6QMO0=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:b407:1780:13d2:b27])
 (user=seanjc job=sendgmr) by 2002:a25:b904:: with SMTP id x4mr7134861ybj.189.1613178346051;
 Fri, 12 Feb 2021 17:05:46 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 Feb 2021 17:05:17 -0800
In-Reply-To: <20210213010518.1682691-1-seanjc@google.com>
Message-Id: <20210213010518.1682691-9-seanjc@google.com>
Mime-Version: 1.0
References: <20210213010518.1682691-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH 8/9] KVM: SVM: Use default rAX size for INVLPGA emulation
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Babu Moger <babu.moger@amd.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop bits 63:32 of RAX when grabbing the address for INVLPGA emulation
outside of 64-bit mode to make KVM's emulation slightly less wrong.  The
address for INVLPGA is determined by the effective address size, i.e.
it's not hardcoded to 64/32 bits for a given mode.  Add a FIXME to call
out that the emulation is wrong.

Opportunistically tweak the ASID handling to make it clear that it's
defined by ECX, not rCX.

Per the APM:
   The portion of rAX used to form the address is determined by the
   effective address size (current execution mode and optional address
   size prefix). The ASID is taken from ECX.

Fixes: ff092385e828 ("KVM: SVM: Implement INVLPGA")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d077584d45ec..4dc64ebaa756 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2327,12 +2327,17 @@ static int clgi_interception(struct vcpu_svm *svm)
 static int invlpga_interception(struct vcpu_svm *svm)
 {
 	struct kvm_vcpu *vcpu = &svm->vcpu;
+	gva_t gva = kvm_rax_read(vcpu);
+	u32 asid = kvm_rcx_read(vcpu);
 
-	trace_kvm_invlpga(svm->vmcb->save.rip, kvm_rcx_read(&svm->vcpu),
-			  kvm_rax_read(&svm->vcpu));
+	/* FIXME: Handle an address size prefix. */
+	if (!is_long_mode(vcpu))
+		gva = (u32)gva;
+
+	trace_kvm_invlpga(svm->vmcb->save.rip, asid, gva);
 
 	/* Let's treat INVLPGA the same as INVLPG (can be optimized!) */
-	kvm_mmu_invlpg(vcpu, kvm_rax_read(&svm->vcpu));
+	kvm_mmu_invlpg(vcpu, gva);
 
 	return kvm_skip_emulated_instruction(&svm->vcpu);
 }
-- 
2.30.0.478.g8a0d178c01-goog

