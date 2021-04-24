Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2234E369E07
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 02:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244554AbhDXAuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 20:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244227AbhDXAsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 20:48:36 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CACDC061357
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:47:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n129-20020a2527870000b02904ed02e1aab5so14640023ybn.21
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=j3nbddZ5OdcUiZfcbardrnX3JrHsR8vaFmvYceXtq5I=;
        b=dKe4MKRvLa5cRtsNK4gaIDmSYQHgrK6HZIpAsyjq5XO5C4inuSFTII5JMRUmVJzXO0
         8VHQBy2+xo8oZayRmPKItvDmKdNdRuIPJqQZa4cLnC5KscQ7Aq/LTCU8DVv7qb5GC+AD
         yjAcS3r0HGIWOCVN+ZRImA7MF0D83q5DRO6gY0W04w0E7NvJ3cFyeP0Jjs/voZ/cexGC
         MEQKa/YbcCUuHyQvaHqdr5TRD48KLW2xGxTTykCSAZaTcM1PI+JXSm8h+Fc9QVsHU1Si
         vIhnp66PtNcU98viffnLyGm3O/yFNILgnzPpqBDLNomM86ua6lhUrvaFQuKmv0gqm5dg
         eEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=j3nbddZ5OdcUiZfcbardrnX3JrHsR8vaFmvYceXtq5I=;
        b=f99HyM79XchFPGO/khuYqJ80/ihrL4T7Biwwu7lXhfpBGcubpCD8/t1wKxzUsR/Ga0
         fC+toXYnCb68LQIJwY97kvM+fcWA0dqL7/cZA6ZMIBz8siXLLCtbXdz7GKwW5Wq56RkW
         V5GploMMvuhG2+LE98eC1mOx+2QVxzxUCT/2fqS/yMDfQuLfUiLZQYlc3vYyVU5De4YA
         j1zJ3cA773FedPYJkFoNLP5awMB3YNjkAkUKwhziy9FAoT1CguQQkEl/45ZzoaTAvnIe
         +rSbYKwabMxbCaNekDoumAXWSKcFIPnvWEe8/FMTn21Rge6PP6wW9EPXzPL7alBY7swg
         9uJg==
X-Gm-Message-State: AOAM531ga6DrV1QS3b9jZGZlRc8fn39its1PBjRnHxOcAwlWHst+61IR
        1d/HW5Cg9brT7GFz98fRAHphTR2pDeE=
X-Google-Smtp-Source: ABdhPJyDQvjVL0RRlUvUPqCuXq5ryPDQ7vkxO0EQR2T+iSYbWrRdUteCU5Z+BZGctP9roBG4voJIlHKok7I=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:ad52:3246:e190:f070])
 (user=seanjc job=sendgmr) by 2002:a25:ae16:: with SMTP id a22mr7205063ybj.449.1619225250892;
 Fri, 23 Apr 2021 17:47:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Apr 2021 17:46:16 -0700
In-Reply-To: <20210424004645.3950558-1-seanjc@google.com>
Message-Id: <20210424004645.3950558-15-seanjc@google.com>
Mime-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 14/43] KVM: x86: Don't force set BSP bit when local APIC is
 managed by userspace
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't set the BSP bit in vcpu->arch.apic_base when the local APIC is
managed by userspace.  Forcing all vCPUs to be BSPs is non-sensical, and
was dead code when it was added by commit 97222cc83163 ("KVM: Emulate
local APIC in kernel").  At the time, kvm_lapic_set_base() was invoked
if and only if the local APIC was in-kernel (and it couldn't be called
before the vCPU created its APIC).

kvm_lapic_set_base() eventually gained generic usage, but the latent bug
escaped notice because the only true consumer would be the guest itself
in the form of an explicit RDMSRs on APs.  Out of Linux, SeaBIOS, and
EDK2/OVMF, only OVMF consume the BSP bit from the APIC_BASE MSR.  For
the vast majority of usage in OVMF, BSP confusion would be benign.
OVMF's BSP election upon SMI rendezvous might be broken, but practically
no one runs KVM with an out-of-kernel local APIC, let alone does so while
utilizing SMIs with OVMF.

Fixes: 97222cc83163 ("KVM: Emulate local APIC in kernel")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index b99630c6d7fe..c11f23753a5b 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2252,9 +2252,6 @@ void kvm_lapic_set_base(struct kvm_vcpu *vcpu, u64 value)
 	u64 old_value = vcpu->arch.apic_base;
 	struct kvm_lapic *apic = vcpu->arch.apic;
 
-	if (!apic)
-		value |= MSR_IA32_APICBASE_BSP;
-
 	vcpu->arch.apic_base = value;
 
 	if ((old_value ^ value) & MSR_IA32_APICBASE_ENABLE)
-- 
2.31.1.498.g6c1eba8ee3d-goog

