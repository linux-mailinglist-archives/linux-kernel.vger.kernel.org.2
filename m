Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723EE3C74AF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbhGMQgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbhGMQgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:36:40 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88D0C06178C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:33:48 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id b6-20020a05620a1186b02903b429a7ee4bso17426026qkk.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=aiokP7gXEi/+lm4t4Nc0wlY5UTXEFoQdvF62MxbIn5k=;
        b=hY+meXs2gYW7Dto1FpL154fzd3T6mmPiVvvxWryypZ0ivIdoK3bMWkMbY25DhEfegn
         WnFele0LERdxBEro8TKORykXPOpJq+YCFT4B7+YJQ/CVpub97MzMr6p6xVrljB6ieD7Q
         vjjNswgIS4i5uHMOSW3uNyyfv1YkHcK56jJWb85X/a5YBPGBvWsMgMxfOqQt3chTxGPX
         gPX1qDtoqrG8/+k7qmQh6UoTyfXeZq5mIORWe1zs6ZGmMBzD8g9v5O7kCDjOKsyJB/vo
         +L8PL4EOU208ctZ+zIRwmUGppTPjjMkmcVulIuXJINLJGKGPrCVm19fq94ltXl1WKjHi
         etCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=aiokP7gXEi/+lm4t4Nc0wlY5UTXEFoQdvF62MxbIn5k=;
        b=OFCi4yCX9mZVmQm9Yh/9gTqgGeKyHPLhf0TinETsWxCyp0Gz1QiAG+RRt+KpdIyExy
         yPkkyQh801MTsptuGfqSWlACBVPYPbZ0Ueq/UzHuJZijsSKLHaRmFNmbjL/sk+uESzez
         DwW+nM9XruHHAgy5Kqe7NJonBMepiARdXv0GGwRPWrcK3xhjuEc6a7YIiviT/m9eaAJn
         zQ/Mtsxq5UvIfwqZ3LkKDihw3BU1Nfe8s5zi59Gs/bK90kc5Jn4GSq2IdZt2jwNcoBUk
         m6qF7iIhVFV+lz8htV+LifzsbmlkC0WYpXcuWKN9orKN6TDrRIBXgq1u1cvlWsDxEov1
         HpXg==
X-Gm-Message-State: AOAM530BvxWHJOJ7ekM/XHJfIBaCNU8Vf6UEkhDzfFQpUxhJanHF0ZsK
        qni5BrjEp0lB/jH07ghD102UMHGAxdk=
X-Google-Smtp-Source: ABdhPJxyYzNmCbK+8PVWv/wDB2e4DroqBp9Dv2IeQbdBVHp7UYLkLgMXU7AWD+mJQV5ENWWNA3cpTjmCbT0=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:825e:11a1:364b:8109])
 (user=seanjc job=sendgmr) by 2002:a05:6214:16ca:: with SMTP id
 d10mr5659095qvz.59.1626194027964; Tue, 13 Jul 2021 09:33:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Jul 2021 09:32:45 -0700
In-Reply-To: <20210713163324.627647-1-seanjc@google.com>
Message-Id: <20210713163324.627647-8-seanjc@google.com>
Mime-Version: 1.0
References: <20210713163324.627647-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 07/46] KVM: VMX: Remove explicit MMU reset in enter_rmode()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reiji Watanabe <reijiw@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop an explicit MMU reset when entering emulated real mode now that the
vCPU INIT/RESET path correctly handles conditional MMU resets, e.g. if
INIT arrives while the vCPU is in 64-bit mode.

Note, while there are multiple other direct calls to vmx_set_cr0(), i.e.
paths that change CR0 without invoking kvm_post_set_cr0(), only the INIT
emulation can reach enter_rmode().  CLTS emulation only toggles CR.TS,
VM-Exit (and late VM-Fail) emulation cannot architecturally transition to
Real Mode, and VM-Enter to Real Mode is possible if and only if
Unrestricted Guest is enabled (exposed to L1).

This effectively reverts commit 8668a3c468ed ("KVM: VMX: Reset mmu
context when entering real mode")

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 825197f21700..0f5e97a904e5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2852,8 +2852,6 @@ static void enter_rmode(struct kvm_vcpu *vcpu)
 	fix_rmode_seg(VCPU_SREG_DS, &vmx->rmode.segs[VCPU_SREG_DS]);
 	fix_rmode_seg(VCPU_SREG_GS, &vmx->rmode.segs[VCPU_SREG_GS]);
 	fix_rmode_seg(VCPU_SREG_FS, &vmx->rmode.segs[VCPU_SREG_FS]);
-
-	kvm_mmu_reset_context(vcpu);
 }
 
 int vmx_set_efer(struct kvm_vcpu *vcpu, u64 efer)
-- 
2.32.0.93.g670b81a890-goog

