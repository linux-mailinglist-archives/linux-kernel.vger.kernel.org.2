Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C2A369E42
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 02:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244340AbhDXA4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 20:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244709AbhDXAy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 20:54:26 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A931BC0612B0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:48:31 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id p2-20020ad452e20000b0290177fba4b9d5so19500702qvu.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=dwT5gDx8U+TXQv6xKXH5cDgd0KUyWk3Y9gjyR2V9h0g=;
        b=l8ErXtGiagqYGtTD5hcXb339Fg9mJCb4XUVGzrj5cDuO82nBEXHxHkUm05WJ0ypAWz
         fve7vgYc1/WZwz2APDMoyEn72hM55Ydxd/Vm3cpuzSNFI26zDZunqMRAmEcJBze5CEPo
         QdW7j5tWccjbNSW7GaO/JxQpi84x7UClBc+dgzKPNJ6+bwN1U2Qq1XTHC82UmYhxJ+u9
         pi9LPGonJtCYXHPTCMLq4SiQCCoAz9bYmvKv4GHSQDNVVbzmFRIK+b2Hm3NknIdHQ4WI
         b7jPoNOb24j5/Q27UwlAqWyjrGIRJzjiUzFa5dysl6hvzRBXTyAx6e5mH6Wq9E4asuUk
         ewbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=dwT5gDx8U+TXQv6xKXH5cDgd0KUyWk3Y9gjyR2V9h0g=;
        b=olSWg6fxrtmiNQWMV8LpkK4+M6QD9iRtgQX+hblbff33X9xm0ZJlNyeP1pJNKqHHEb
         1w9vuPAePmJsyTQPce0uqLGk0rC9kYI2Iy8/JOFYuok+x1cTxmoFCYy7cogqtycjHuGP
         V0L+KJITnA9fVNfthfx2JFIklswfHb59gbsC8Cw69E88OhxCkj/0qyM8U9GpVpEh2y2y
         Czv2NCll1nau0UZEXGGTaGH3coHUULPKVgqKHEMCGf2jCNAEMYTEDeKRT3bkJ0VlM5Tf
         vCHog3n2FdioIP5M+T8piu88w2sgwDNwNDrgxWLY6g2MZ18UsQiaa7RwuDB66Wj8IU6F
         wgOQ==
X-Gm-Message-State: AOAM530QmlelQ2XobMusjhxDtUiRjHqLY4K6BX0E+6Mlte6Th8l84R9e
        wuOo/Pxa3jVBM6xFiAZhzxwbBKYDXow=
X-Google-Smtp-Source: ABdhPJyJLXPmypGxS0Nd+GIxuMgYV+8Xnctu20pirxZqq4r04lQSaraBi7RF97vOU0EGhYj6UvgkWN515yM=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:ad52:3246:e190:f070])
 (user=seanjc job=sendgmr) by 2002:a0c:fa52:: with SMTP id k18mr7269182qvo.22.1619225310920;
 Fri, 23 Apr 2021 17:48:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Apr 2021 17:46:43 -0700
In-Reply-To: <20210424004645.3950558-1-seanjc@google.com>
Message-Id: <20210424004645.3950558-42-seanjc@google.com>
Mime-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 41/43] KVM: VMX: Remove redundant write to set vCPU as active
 at RESET/INIT
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

Drop a call to vmx_clear_hlt() during vCPU INIT, the guest's activity
state is unconditionally set to "active" a few lines earlier in
vmx_vcpu_reset().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index dcef189b0108..78d17adce7e6 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4568,8 +4568,6 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu);
 
 	vpid_sync_context(vmx->vpid);
-	if (init_event)
-		vmx_clear_hlt(vcpu);
 }
 
 static void vmx_enable_irq_window(struct kvm_vcpu *vcpu)
-- 
2.31.1.498.g6c1eba8ee3d-goog

