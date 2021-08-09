Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BE83E4B02
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 19:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbhHIRkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 13:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbhHIRkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 13:40:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10CDC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 10:40:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b9-20020a5b07890000b0290558245b7eabso18011230ybq.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 10:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=J36Wx/RkTb0D4oTQeLsHsT1q0l8StXG1g3yJDRFzPZE=;
        b=VdTTxR661OL3+D5jswoMHXZIoH3185bNJA+vHUPtyk+nv1RVhw48mrJAUzZm07Bt6r
         DyAdUL2h1TLN5GaCLOsG3sInSLCU/uemQ9DGHfm6ph9xXASmnUc2hKyar26TxDz9SpdL
         5XzXbtKpihv9i/vvyu8wkVBh4+a8qcg2NShVlbJ9o1c8Z444LaKAGWi8LIo6PeZqEwWf
         CkK09U8+KicN0lDfvdsZ64/P3fyh4fb/TTxpFRxE+BYMuEqO2OI4ph/qMuxmdRHlh9ym
         g2r3yfBEsybF6onKjyQYnMmqFSTJ3HrEeTG1VHAldc/ZwcA7BvP9GqmSYET6/h601hnG
         Wb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=J36Wx/RkTb0D4oTQeLsHsT1q0l8StXG1g3yJDRFzPZE=;
        b=jQUBquSh5Aar9z6vqF9Zk658MotmeGvtMmkD6BO5nc9ABp1R66asPSbkh0IXs1OCs5
         t5w58Li5aA6NC3eHXuFE7B9G6YNvB82pVnSyLMuoPDeFiv30wT/dSKjecr1g50aMpXpM
         SAhL9QWzNC51kNdUaYIgSgFtvfEhAxQuMXK5IYxkaqtWvqpIP4TflLvFmx9uuXXhn0Rn
         oZlh01mhl4Kz2zDuM+dRRgNJpCmHCmVm9RIHp6PItkOgV0D8YEy6lMq4/DKwtsFvP9qp
         n5BiNBlXkbs/uQuR+XfzaHvYjw0qkzxM3RU4Jrkqz3LSPjwJ9AxNVkLHUa82XhBZFvHH
         EjbQ==
X-Gm-Message-State: AOAM5330hp0eacdZb1ZmSXaDaKIOlU7jgQ7h9TyDAALqAile56D1iTGZ
        CW1I/LFrljw7eDBs/FHPlBESE/CZlwY=
X-Google-Smtp-Source: ABdhPJxfsVYalWjf7EAWF143gPK9KWWTt1llY4AdJOvSpHxmE3x5I+M8k/C6dMXHmNMbqBjXGNz74hdfTiY=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:b967:644e:62eb:1752])
 (user=seanjc job=sendgmr) by 2002:a25:c4:: with SMTP id 187mr33657699yba.373.1628530809907;
 Mon, 09 Aug 2021 10:40:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon,  9 Aug 2021 10:39:55 -0700
In-Reply-To: <20210809173955.1710866-1-seanjc@google.com>
Message-Id: <20210809173955.1710866-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210809173955.1710866-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v2 2/2] KVM: x86: Move declaration of kvm_spurious_fault() to x86.h
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Uros Bizjak <ubizjak@gmail.com>,
        Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uros Bizjak <ubizjak@gmail.com>

Move the declaration of kvm_spurious_fault() to KVM's "private" x86.h,
it should never be called by anything other than low level KVM code.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
[sean: rebased to a series without __ex()/__kvm_handle_fault_on_reboot()]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 2 --
 arch/x86/kvm/svm/svm_ops.h      | 2 +-
 arch/x86/kvm/vmx/vmx_ops.h      | 2 +-
 arch/x86/kvm/x86.h              | 2 ++
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 56540b5befd0..45e618902623 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1798,8 +1798,6 @@ enum {
 #define kvm_arch_vcpu_memslots_id(vcpu) ((vcpu)->arch.hflags & HF_SMM_MASK ? 1 : 0)
 #define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, (role).smm)
 
-void kvm_spurious_fault(void);
-
 #define KVM_ARCH_WANT_MMU_NOTIFIER
 
 int kvm_cpu_has_injectable_intr(struct kvm_vcpu *v);
diff --git a/arch/x86/kvm/svm/svm_ops.h b/arch/x86/kvm/svm/svm_ops.h
index 8170f2a5a16f..22e2b019de37 100644
--- a/arch/x86/kvm/svm/svm_ops.h
+++ b/arch/x86/kvm/svm/svm_ops.h
@@ -4,7 +4,7 @@
 
 #include <linux/compiler_types.h>
 
-#include <asm/kvm_host.h>
+#include "x86.h"
 
 #define svm_asm(insn, clobber...)				\
 do {								\
diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
index c0d74b994b56..9e9ef47e988c 100644
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -4,11 +4,11 @@
 
 #include <linux/nospec.h>
 
-#include <asm/kvm_host.h>
 #include <asm/vmx.h>
 
 #include "evmcs.h"
 #include "vmcs.h"
+#include "x86.h"
 
 asmlinkage void vmread_error(unsigned long field, bool fault);
 __attribute__((regparm(0))) void vmread_error_trampoline(unsigned long field,
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 44ae10312740..7d66d63dc55a 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -8,6 +8,8 @@
 #include "kvm_cache_regs.h"
 #include "kvm_emulate.h"
 
+void kvm_spurious_fault(void);
+
 static __always_inline void kvm_guest_enter_irqoff(void)
 {
 	/*
-- 
2.32.0.605.g8dce9f2422-goog

