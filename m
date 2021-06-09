Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CFB3A1D4D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 20:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhFIS7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 14:59:36 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:50716 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhFIS7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 14:59:35 -0400
Received: by mail-yb1-f201.google.com with SMTP id o12-20020a5b050c0000b02904f4a117bd74so32592886ybp.17
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 11:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=qmBiYG2Q8fhlMt9vEycHJMHDLIYJ0FuvQVOhlHRcPKQ=;
        b=F75V2on7xGSHGc3PiOmR0dqrBKE8LlmZ30KRE72p0ddy5YdgfqhYt+i0zs4ZUNwcmf
         Ic8hgyG0bUOOGX6vUeCJbREq+QRz2mF9t6Ka3+vgrw+w/BawtxU7+wQFymMjd9jVzaEL
         Yf/br30ykbskmsFk3HZ2fGe9ojBKceFlyZmb1RW4WMNK/REP6Hqr/ZncYOdRPmtl2abU
         1cMIpqh6DNK4WUnSpXDSf171FBx2A8L47LZ5eligF0Qs0xoWuY0Xvh4x8eSV5oLnpHHD
         ukBIdhI75DJUQctT9oMnHibXgoZUCAjPTuzGGQNF5jlMr8j7E3ZzJRRaJRKRVZXb5mpZ
         7AUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=qmBiYG2Q8fhlMt9vEycHJMHDLIYJ0FuvQVOhlHRcPKQ=;
        b=SQmKXjQanW5ZfM9Hcks+SPfwl+YUiTLovBGzaoLZpybN1DRsFj84C+wDzRA1g0kDIK
         w76D1VvP6CR/5iJBDuSFVBjXuaasSAsQnaMnteDCUCghuQLnhERibF0On1FcF2ac5rns
         7ZHsKrMamGoKAVFSp/9G74mXZYBIMrNTeKsceM7kYx8P6eAaL+fgTSVCpyaqWRFfiSZc
         v+s5uZF5RRwi0pTyP84W+Kt0ZNu2YsRS6TZvi7ZabZgQfEULcAguE/hsf/eukxKCTNoO
         7NLXiLSJja6fF8x/6EmyMSSHLhyLZCKV7yIUg7KSBuL0kQv0pJ5/at4+GG2mSgsNk35n
         nigQ==
X-Gm-Message-State: AOAM531lg4IvHSlTn8tc2Pd7UNT38LZtBEry4t0ZS8ch1/tEGCFZYlO/
        JdlhZg1oGn9S++mWGUXds26d6tFjiAo=
X-Google-Smtp-Source: ABdhPJy6xwXMm+i4eNVeH/U3OwdKvm3UqsFRa8RnRqIkX7DUC1cJfhlxygZ9lkhXeGaIXtMknGHuNUZ89qc=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:bfdc:c2e5:77b1:8ef3])
 (user=seanjc job=sendgmr) by 2002:a05:6902:4a2:: with SMTP id
 r2mr1955589ybs.286.1623265000119; Wed, 09 Jun 2021 11:56:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  9 Jun 2021 11:56:14 -0700
In-Reply-To: <20210609185619.992058-1-seanjc@google.com>
Message-Id: <20210609185619.992058-5-seanjc@google.com>
Mime-Version: 1.0
References: <20210609185619.992058-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH 4/9] KVM: x86: Invoke kvm_smm_changed() immediately after
 clearing SMM flag
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

Move RSM emulation's call to kvm_smm_changed() from .post_leave_smm() to
.exiting_smm(), leaving behind the MMU context reset.  The primary
motivation is to allow for future cleanup, but this also fixes a bug of
sorts by queueing KVM_REQ_EVENT even if RSM causes shutdown, e.g. to let
an INIT wake the vCPU from shutdown.  Of course, KVM doesn't properly
emulate a shutdown state, e.g. KVM doesn't block SMIs after shutdown, and
immediately exits to userspace, so the event request is a moot point in
practice.

Moving kvm_smm_changed() also moves the RSM tracepoint.  This isn't
strictly necessary, but will allow consolidating the SMI and RSM
tracepoints in a future commit (by also moving the SMI tracepoint).
Invoking the tracepoint before loading SMRAM state also means the SMBASE
that reported in the tracepoint will point that the state that will be
used for RSM, as opposed to the SMBASE _after_ RSM completes, which is
arguably a good thing if the tracepoint is being used to debug a RSM/SMM
issue.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 69a71c5019c1..76ba28865824 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7109,7 +7109,7 @@ static void emulator_exiting_smm(struct x86_emulate_ctxt *ctxt)
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
 
 	vcpu->arch.hflags &= ~(HF_SMM_MASK | HF_SMM_INSIDE_NMI_MASK);
-	kvm_mmu_reset_context(vcpu);
+	kvm_smm_changed(vcpu);
 }
 
 static int emulator_pre_leave_smm(struct x86_emulate_ctxt *ctxt,
@@ -7120,7 +7120,7 @@ static int emulator_pre_leave_smm(struct x86_emulate_ctxt *ctxt,
 
 static void emulator_post_leave_smm(struct x86_emulate_ctxt *ctxt)
 {
-	kvm_smm_changed(emul_to_vcpu(ctxt));
+	kvm_mmu_reset_context(emul_to_vcpu(ctxt));
 }
 
 static void emulator_triple_fault(struct x86_emulate_ctxt *ctxt)
-- 
2.32.0.rc1.229.g3e70b5a671-goog

