Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CC234F6A5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 04:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhCaCbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 22:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbhCaCab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 22:30:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EA2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 19:30:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y13so664379ybk.20
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 19:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=uV4x6+EdkMXZhg7wMEUNEc/cXMhh5NFoJhoLXAZa4XA=;
        b=hyxAm79V1CoNeCcaWjPRj6j5vKrjB66hHPXwlccvH/3YB10lOq1utFmsZxYp8F3HpG
         WOVVmSaroJAJOzz4lNDIbz7ei9dCL3cKP4c17RXAj462cjZTMs8oecds+x1bGGRaLRVE
         vmKYsAvI44f3RBbPqlZk3+kcxA5yCOsa4zYDyKO9Y6bRuhE8JVlAQhJa+kJ+6Wv/2Ghz
         4xMYiQHQSD02fcexUHEgrkqc/uqoNUwmNr9s/ylUQx15EFvA2VaXTuppXEfG0Eg2XXWz
         B2M6KfrdkALt0ZTB/hRS7drJULF5z50LaOIqMSYoWDCtbYm31kQwZ7CcI9NMzcJM3792
         c7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=uV4x6+EdkMXZhg7wMEUNEc/cXMhh5NFoJhoLXAZa4XA=;
        b=KI7L2IErjoRUFGZwCjc/ys0WJ3F8OyT+UwMn9+vCK6gIRpIEeo8arUkEf/C6m6NJv6
         XlhJLGUwdYYe3iLARa0tu69IBXgopSjTA0QAZaH6dmGWSzj3MEVpCIk8CT0QiXSG70Fh
         xOqSMg0ADx+JoYJ/EokHDxnLROKvNhZg4k6tHpDi1playZhuqmRsgLU6gwm6RT24st9e
         KTtSsI4EWeJI8w+6SQcdFpNTNYPhyNyjAtCJfsqEHw1f0/tZpxgNbQTWnyRRutjo3Bka
         5dbcjg3XoAEng4+3AAgRzjAp11ABVjgSZhbI+8WmXEkgLvZyrz6V/CKlYyBmftZuf3De
         4SgA==
X-Gm-Message-State: AOAM530EEF1MnKIZr3tGP2Y4p7j77CefQZeUvXoiKNDWUGDdlCBpQejD
        Es2uRCg3QxAkUFLGv71tV7BTaE5QkQc=
X-Google-Smtp-Source: ABdhPJyoJU2Rdi/to8R+u7+o3IMo1VtUs59XwyVJUPXLriy3TmcY1tCAqdD1U35l7io8CdK4mvxxJmJF+eM=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:6c6b:5d63:9b3b:4a77])
 (user=seanjc job=sendgmr) by 2002:a25:c588:: with SMTP id v130mr1592057ybe.312.1617157831002;
 Tue, 30 Mar 2021 19:30:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 30 Mar 2021 19:30:24 -0700
In-Reply-To: <20210331023025.2485960-1-seanjc@google.com>
Message-Id: <20210331023025.2485960-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210331023025.2485960-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH 1/2] KVM: Account memory allocations for 'struct kvm_vcpu'
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

Use GFP_KERNEL_ACCOUNT for the vCPU allocations, the vCPUs are very much
tied to a single task/VM.  For x86, the allocations were accounted up
until the allocation code was moved to common KVM.  For all other
architectures, vCPU allocations were never previously accounted, but only
because most architectures lack accounting in general (for KVM).

Fixes: e529ef66e6b5 ("KVM: Move vcpu alloc and init invocation to common code")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 383df23514b9..3884e9f30251 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3182,7 +3182,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
 	if (r)
 		goto vcpu_decrement;
 
-	vcpu = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL);
+	vcpu = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL_ACCOUNT);
 	if (!vcpu) {
 		r = -ENOMEM;
 		goto vcpu_decrement;
-- 
2.31.0.291.g576ba9dcdaf-goog

