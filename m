Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0CB325B26
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 02:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbhBZBFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 20:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhBZBFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 20:05:07 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEF7C061794
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 17:03:44 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id n4so5438687qte.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 17:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=VwL4OKVPwLd2Pg+VBJhmXhH54fx49qLMEAmb7K/yfzE=;
        b=asBlIwqlyL3G7lCGd6ftlZ1p4O/OaNv+4nvJBXTpJ1jQp9zF54AfPzE2oHarE2oPsQ
         zqzpcbUazeizOI4ugER4Iq0P3Uxm6BML7s8w8CYGRsylnB4OdekwN05mrsLfCCGGyI8m
         B0O6TRQ/8Jl67lg5q9sr/kzygY3f7g/0+WxJNgfPg1Z4Fze39MwwRD2qPh6KcjhWkDhK
         MAFCL3PZO/mZUOph13ndkkV8vxBu6lT30P0mcAV31ueREbJFCBskk4seupk5D4/ai+/m
         T/ePm4CejvmH0ND4V/1pMjINhZyxXmFdeWWGV/ApdZWpSv6xRwnvfNR1v0Go5Z7TtUGT
         BMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=VwL4OKVPwLd2Pg+VBJhmXhH54fx49qLMEAmb7K/yfzE=;
        b=clsPzEG9VvlgFA8eX7daGR224DQWHwsDfzhZRxXTOI3mgZZUPKsIllxX+ANPzqLTVR
         BAZL3FS6UPtjdlVdZuf4j5hQVslTfk6FVTpgoIvsfuiX5JsnBQp8f6+zNwf48/q8A6S8
         RAwm17QYef+JaeJsFFZo7YjeU/CpcmmzQA//IuNde/xm2MoXd4qwsJv82TwNKDgyGL0q
         nrXsCkBccnNqz55HCM7SWaRmUZF0Kz3GG4j1OFymwB3G8VRQ9bz/xhcm+guqyuRELd0R
         vZZu3or3FLl8NTsJl+9Yo8cf6kizMt90z/n45F/JYPOHcubHuGOmpemAPaPbo72yEG8f
         G7Cw==
X-Gm-Message-State: AOAM5304AfPqc/1f//Tv0nPcSo68lVG2yVTxCypG4ey4AFDwUhz6+7Zx
        1nFOXWey+onvUeSa+6muLuVuG8RsbmY=
X-Google-Smtp-Source: ABdhPJzH0AkeJmFJPvLyy38HssKzf5B73Itkikl9QMv9yK+MbjaJztQXtpP6dNt9q7l96dZUTk/jbOfcwWY=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:34c4:7c1d:f9ba:4576])
 (user=seanjc job=sendgmr) by 2002:a0c:d78e:: with SMTP id z14mr477802qvi.8.1614301423475;
 Thu, 25 Feb 2021 17:03:43 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 25 Feb 2021 17:03:28 -0800
In-Reply-To: <20210226010329.1766033-1-seanjc@google.com>
Message-Id: <20210226010329.1766033-5-seanjc@google.com>
Mime-Version: 1.0
References: <20210226010329.1766033-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 4/5] KVM: x86/mmu: Add typedefs for rmap/iter handlers
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add typedefs for the MMU handlers that are invoked when walking the MMU
SPTEs (rmaps in legacy MMU) to act on a host virtual address range.

No functional change intended.

Cc: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c     | 27 ++++++++++-----------------
 arch/x86/kvm/mmu/tdp_mmu.c | 20 +++++++++-----------
 2 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d75524bc8423..1ee01ca196bd 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1424,17 +1424,15 @@ static void slot_rmap_walk_next(struct slot_rmap_walk_iterator *iterator)
 	     slot_rmap_walk_okay(_iter_);				\
 	     slot_rmap_walk_next(_iter_))
 
-static __always_inline int
-kvm_handle_hva_range(struct kvm *kvm,
-		     unsigned long start,
-		     unsigned long end,
-		     unsigned long data,
-		     int (*handler)(struct kvm *kvm,
-				    struct kvm_rmap_head *rmap_head,
-				    struct kvm_memory_slot *slot,
-				    gfn_t gfn,
-				    int level,
-				    unsigned long data))
+typedef int (*rmap_handler_t)(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+			      struct kvm_memory_slot *slot, gfn_t gfn,
+			      int level, unsigned long data);
+
+static __always_inline int kvm_handle_hva_range(struct kvm *kvm,
+						unsigned long start,
+						unsigned long end,
+						unsigned long data,
+						rmap_handler_t handler)
 {
 	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
@@ -1473,12 +1471,7 @@ kvm_handle_hva_range(struct kvm *kvm,
 }
 
 static int kvm_handle_hva(struct kvm *kvm, unsigned long hva,
-			  unsigned long data,
-			  int (*handler)(struct kvm *kvm,
-					 struct kvm_rmap_head *rmap_head,
-					 struct kvm_memory_slot *slot,
-					 gfn_t gfn, int level,
-					 unsigned long data))
+			  unsigned long data, rmap_handler_t handler)
 {
 	return kvm_handle_hva_range(kvm, hva, hva + 1, data, handler);
 }
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 9ce8d226b621..b6f829b58e67 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -879,17 +879,15 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 	return ret;
 }
 
-static __always_inline int
-kvm_tdp_mmu_handle_hva_range(struct kvm *kvm,
-			     unsigned long start,
-			     unsigned long end,
-			     unsigned long data,
-			     int (*handler)(struct kvm *kvm,
-					    struct kvm_memory_slot *slot,
-					    struct kvm_mmu_page *root,
-					    gfn_t start,
-					    gfn_t end,
-					    unsigned long data))
+typedef int (*tdp_handler_t)(struct kvm *kvm, struct kvm_memory_slot *slot,
+			     struct kvm_mmu_page *root, gfn_t start, gfn_t end,
+			     unsigned long data);
+
+static __always_inline int kvm_tdp_mmu_handle_hva_range(struct kvm *kvm,
+							unsigned long start,
+							unsigned long end,
+							unsigned long data,
+							tdp_handler_t handler)
 {
 	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
-- 
2.30.1.766.gb4fecdf3b7-goog

