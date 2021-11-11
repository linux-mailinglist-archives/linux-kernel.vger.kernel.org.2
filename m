Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5287044DDC6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 23:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhKKWRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 17:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhKKWRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 17:17:41 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738AEC061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 14:14:51 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id t7-20020a17090a5d8700b001a7604b85f5so2990167pji.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 14:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=D6FpngHL7pVPys12ET3BCq9w44yU5FOGTyStAYAg/34=;
        b=Kx4jM4m8WdXW8E0rOw72D0Do/SPBBfRiKWkS5AY3QZFd3HKV/5CKbp3T6FzafMOb9F
         xZd2KjI65iycu7M+uwE3hdFVn6vVupW99J/BXtfU+1oJ65BoKEt4uZVwvA5kHY8Ufzf5
         XUkRDmIWGYXiBQIf/IeziDudRXR6zj4FmVq0Nhiw1Bqt4afwGaYirsHct1ldc47q2Rma
         BViETNEWm61SvHpCw4vfOXvVSWSaSSrL4ZYFoKVXIc4xEcZvufqH/xcP93w90bTUIBb4
         wHyYasgabxGTJKW0WApaQwP8SAM+ur4nVL99/Pk9a/chUpYo7Zt4p/oNyXje6IqVTE7p
         nnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=D6FpngHL7pVPys12ET3BCq9w44yU5FOGTyStAYAg/34=;
        b=pc+GMHjCi4AFCGlpCkQU74X/R0D0A6pLjTg2Hm2m85l3AHSkJ0VBqW0O0ekGAeV9pv
         zuUoYJyQNlB8LRktODozrVimiW2Z2flOBzpGdZ+bURfaagynD1zLoKHHKKsqG+eAj68q
         JJ7RBxLwrqeoDvGLa+RXpgsK5iQqnkvxrlJOLil/Omt80ENRJNU83NCRHBfEMRZt3his
         1ien/5nRikID7OGB/Ps5a1O080J9cowiSF2uH1HXM2InEXHPOlQKTABVkVtznBst8Cig
         xvQidETJk0HtXd77zOSJhF6YTkV+u+ZBnQ2PB8rL9EihoUz23Nz+BpjHdX89oAn1TChN
         QKAQ==
X-Gm-Message-State: AOAM533nxCXEN189iqZHWC3W59A//GjTNlJSVnA3t84NmZcrYMt/+QZb
        nNZx2jRjI6CYTN2j3Xov2degJtN0fLY=
X-Google-Smtp-Source: ABdhPJxaSRF8+U4SaRpJFzNVFCjN1K6rNMuDgJq3uxdj7kUjZzykTs9aspMDmsNKQ0nWLsDfcwkgNFhXA30=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1c90:: with SMTP id
 oo16mr12121812pjb.199.1636668890965; Thu, 11 Nov 2021 14:14:50 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 11 Nov 2021 22:14:48 +0000
Message-Id: <20211111221448.2683827-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH] KVM: x86/mmu: Update number of zapped pages even if page list
 is stable
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When zapping obsolete pages, update the running count of zapped pages
regardless of whether or not the list has become unstable due to zapping
a shadow page with its own child shadow pages.  If the VM is backed by
mostly 4kb pages, KVM can zap an absurd number of SPTEs without bumping
the batch count and thus without yielding.  In the worst case scenario,
this can cause an RCU stall.

  rcu: INFO: rcu_sched self-detected stall on CPU
  rcu:     52-....: (20999 ticks this GP) idle=7be/1/0x4000000000000000
                                          softirq=15759/15759 fqs=5058
   (t=21016 jiffies g=66453 q=238577)
  NMI backtrace for cpu 52
  Call Trace:
   ...
   mark_page_accessed+0x266/0x2f0
   kvm_set_pfn_accessed+0x31/0x40
   handle_removed_tdp_mmu_page+0x259/0x2e0
   __handle_changed_spte+0x223/0x2c0
   handle_removed_tdp_mmu_page+0x1c1/0x2e0
   __handle_changed_spte+0x223/0x2c0
   handle_removed_tdp_mmu_page+0x1c1/0x2e0
   __handle_changed_spte+0x223/0x2c0
   zap_gfn_range+0x141/0x3b0
   kvm_tdp_mmu_zap_invalidated_roots+0xc8/0x130
   kvm_mmu_zap_all_fast+0x121/0x190
   kvm_mmu_invalidate_zap_pages_in_memslot+0xe/0x10
   kvm_page_track_flush_slot+0x5c/0x80
   kvm_arch_flush_shadow_memslot+0xe/0x10
   kvm_set_memslot+0x172/0x4e0
   __kvm_set_memory_region+0x337/0x590
   kvm_vm_ioctl+0x49c/0xf80

Fixes: fbb158cb88b6 ("KVM: x86/mmu: Revert "Revert "KVM: MMU: zap pages in batch""")
Reported-by: David Matlack <dmatlack@google.com>
Cc: Ben Gardon <bgardon@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

I haven't actually verified this makes David's RCU stall go away, but I did
verify that "batch" stays at "0" before and increments as expected after,
and that KVM does yield as expected after.

 arch/x86/kvm/mmu/mmu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 33794379949e..89480fab09c6 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5575,6 +5575,7 @@ static void kvm_zap_obsolete_pages(struct kvm *kvm)
 {
 	struct kvm_mmu_page *sp, *node;
 	int nr_zapped, batch = 0;
+	bool unstable;
 
 restart:
 	list_for_each_entry_safe_reverse(sp, node,
@@ -5606,11 +5607,12 @@ static void kvm_zap_obsolete_pages(struct kvm *kvm)
 			goto restart;
 		}
 
-		if (__kvm_mmu_prepare_zap_page(kvm, sp,
-				&kvm->arch.zapped_obsolete_pages, &nr_zapped)) {
-			batch += nr_zapped;
+		unstable = __kvm_mmu_prepare_zap_page(kvm, sp,
+				&kvm->arch.zapped_obsolete_pages, &nr_zapped);
+		batch += nr_zapped;
+
+		if (unstable)
 			goto restart;
-		}
 	}
 
 	/*
-- 
2.34.0.rc1.387.gb447b232ab-goog

