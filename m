Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BF93A1D45
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 20:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhFIS66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 14:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhFIS64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 14:58:56 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B3EC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 11:56:47 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 190-20020a3708c70000b02903aa60e6d8c1so10931903qki.19
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 11:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=syv2uotrlz6j8ocXZwF6/evBsYdXY7BIpcJqGgzmlYQ=;
        b=R3bhLc1/AI31GEEIJcUspnCcKt6wAF0P58h1hrkmb07Ma/932rYsNhyf16l4YQ61+d
         A/oQFDU1xtoJPkFHR3Ehcuceak0vx1SgLFwmdL/u/VkdWGE4nxGuNEZxEsGOWikQTEXz
         CSxbhONDYkaaAjV2amQgMhpXTJu9thMm8106pJqaE/Ck+lCQemfEHE/+WSkHElpl/z7N
         21dmlELezbF04si3RtTUrK4XexD/YHeKLw70feq7Yyd7naditzo4n4Lscpg6yy9i/CCT
         Ub/r5jDII/GimoJGNQWU2Bd1Mno5LfbufcVGjIFABZii3YWyLcYR6BUJULDEzOvGG/4S
         z8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=syv2uotrlz6j8ocXZwF6/evBsYdXY7BIpcJqGgzmlYQ=;
        b=A/gk8fc0P3ur7ST3DaDRv6U97BXarRttg62KvKommgviatek3C6W9Pcpyo/+L7swEp
         ArhaaBdMZMpJ8OqiV/w6UMU6qCdV6GkzfaLBOFaIBz9tB+ZcpzuKp/L21XxOqvTqu1p6
         NfvZBCw1OFLazqh6zam7uDYbfidzUfFWHcxASVgIeQxvRHmFZsXdVer6SoxuxSE6YYBj
         aZPPlpP15Y2MI5YQg0DLCbnItJbJKIVgFMeJXa6DY6mJQEZHSpXW78ANiPJWuJIoFWGy
         d+pZi1TN9vgxX/T5B6FDjJ9mQnCj4Thu1e8cjKVS0a8slfM4Xpx2DilhjoPlEESE89u4
         p6kA==
X-Gm-Message-State: AOAM530BMi8ATQtssvIBIDmoR5EMTUV88mFT0IC8W2slwlCje614L/Pm
        GQI0MpfW+nnKSlbJXY7Sca1aAVYG1F0=
X-Google-Smtp-Source: ABdhPJwbyEuyuu8WeEWukyDUN4qmkTcVk3K2f53i5rschpAigH8kd54OLDHf/5fGrShotZGaFXRzluEr5Lo=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:bfdc:c2e5:77b1:8ef3])
 (user=seanjc job=sendgmr) by 2002:a0c:fe6c:: with SMTP id b12mr1363449qvv.32.1623265006316;
 Wed, 09 Jun 2021 11:56:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  9 Jun 2021 11:56:17 -0700
In-Reply-To: <20210609185619.992058-1-seanjc@google.com>
Message-Id: <20210609185619.992058-8-seanjc@google.com>
Mime-Version: 1.0
References: <20210609185619.992058-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH 7/9] KVM: x86: Rename SMM tracepoint to make it reflect reality
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

Rename the SMM tracepoint, which handles both entering and exiting SMM,
from kvm_enter_smm to kvm_smm_transition.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/trace.h | 2 +-
 arch/x86/kvm/x86.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 4f839148948b..b484141ea15b 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -997,7 +997,7 @@ TRACE_EVENT(kvm_wait_lapic_expire,
 		  __entry->delta < 0 ? "early" : "late")
 );
 
-TRACE_EVENT(kvm_enter_smm,
+TRACE_EVENT(kvm_smm_transition,
 	TP_PROTO(unsigned int vcpu_id, u64 smbase, bool entering),
 	TP_ARGS(vcpu_id, smbase, entering),
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 11ea81c8cb82..06f3be2d170b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7434,7 +7434,7 @@ static int complete_emulated_pio(struct kvm_vcpu *vcpu);
 
 static void kvm_smm_changed(struct kvm_vcpu *vcpu, bool entering_smm)
 {
-	trace_kvm_enter_smm(vcpu->vcpu_id, vcpu->arch.smbase, entering_smm);
+	trace_kvm_smm_transition(vcpu->vcpu_id, vcpu->arch.smbase, entering_smm);
 
 	if (entering_smm) {
 		vcpu->arch.hflags |= HF_SMM_MASK;
-- 
2.32.0.rc1.229.g3e70b5a671-goog

