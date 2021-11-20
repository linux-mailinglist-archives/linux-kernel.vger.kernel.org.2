Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A418F457B84
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 05:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbhKTEzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 23:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237043AbhKTEyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:54:47 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BF8C061758
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:51:29 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id s8-20020a63af48000000b002e6c10ac245so5029519pgo.21
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=AYx9sJvbwxB0sjhZtd5DFNw6mN6V1huadyjHwAl8qyw=;
        b=f+RKeHOw+lES1XSli4Wpoaxhwl+WeKvn1k9OMhsgTilJMSFmV3iHgjFoLtCpkxl3WE
         V5bBEh+2u7V5C527aOhUlnyV1RufARW1OjFiKJdmn7ScVYBEJrrfrC6kcsD9XC9yYoG2
         t3OnPoUfRnBKevyG03GekYE/qSYf1buEGsap0wIQF5akx9JOuKFyvJxNVnVsWyWVI1iT
         N2ry8L7wQOWzWU7135htytqvIu0pSawNjiCtQso5UHn7DLF/XAEqXCkdnc+YHbzHV3N7
         0ExIfdUX6xlJ4XqGizNqYDQxrvngZkem6nSWQ4K/LjWy7PlS09g0nX/4c4GKhh6XZHpM
         woxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=AYx9sJvbwxB0sjhZtd5DFNw6mN6V1huadyjHwAl8qyw=;
        b=Y+quBOj3i0cffIAgwmShgNzyLuGEOfT4pZ4XoRJLMuX7JBsVYIF6Rk4i5xivghoWGR
         D3A2v8f1/m0J2cJAHGY+PjZqoJ4kAcUtho66T6km56wbHLgFwSql9LQ3xnxan9oQmzlT
         zLImaYyM9lFFrDgWJeq3jTSisgYCRnQV9APv9S0oaLp4CdOLH0LybXKIUXFbud2iUEEX
         LonwMejAakivWM3i0sOicKZuXhx4CCSr5xfCREbwIQZzV8hf5ZPNl+HvAL7U0SYAn4uT
         s7izIf3eHIZRVXzU3PcAI3dDp8E6KFjEUN1MLF4AQMa7XRGKD6lDj54y3WhaAHhvKlZX
         XdaQ==
X-Gm-Message-State: AOAM5315cSO3Wz7FeLTZe9BFBmmY5nR3vXF5jbj3+2nFvKPIbCEpRHIU
        vwGzz4pXH0YDTyeDu+eo+gxQnoik2lU=
X-Google-Smtp-Source: ABdhPJwaSJWhoYJY/fMx/Lp60XbTR6Qc8p1gEC2NAp15y6/XV+Y5Mcb3KxEIwLy8gZ54AMTzhL+9ZdZc1Gc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a63:63c1:: with SMTP id x184mr20729341pgb.401.1637383888887;
 Fri, 19 Nov 2021 20:51:28 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 20 Nov 2021 04:50:40 +0000
In-Reply-To: <20211120045046.3940942-1-seanjc@google.com>
Message-Id: <20211120045046.3940942-23-seanjc@google.com>
Mime-Version: 1.0
References: <20211120045046.3940942-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH 22/28] KVM: x86/mmu: Skip remote TLB flush when zapping all of
 TDP MMU
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hou Wenlong <houwenlong93@linux.alibaba.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't flush the TLBs when zapping all TDP MMU pages, as the only time KVM
uses the slow version of "zap everything" is when the VM is being
destroyed or the owning mm has exited.  In either case, KVM_RUN is
unreachable for the VM, i.e. the guest TLB entries cannot be consumed.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 31fb622249e5..e5401f0efe8e 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -888,14 +888,15 @@ bool __kvm_tdp_mmu_zap_gfn_range(struct kvm *kvm, int as_id, gfn_t start,
 
 void kvm_tdp_mmu_zap_all(struct kvm *kvm)
 {
-	bool flush = false;
 	int i;
 
+	/*
+	 * A TLB flush is unnecessary, KVM's zap everything if and only the VM
+	 * is being destroyed or the userspace VMM has exited.  In both cases,
+	 * KVM_RUN is unreachable, i.e. no vCPUs will ever service the request.
+	 */
 	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++)
-		flush = kvm_tdp_mmu_zap_gfn_range(kvm, i, 0, -1ull, flush);
-
-	if (flush)
-		kvm_flush_remote_tlbs(kvm);
+		(void)kvm_tdp_mmu_zap_gfn_range(kvm, i, 0, -1ull, false);
 }
 
 /*
-- 
2.34.0.rc2.393.gf8c9666880-goog

