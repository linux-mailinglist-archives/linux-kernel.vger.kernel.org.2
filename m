Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E12A352411
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 01:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbhDAXiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 19:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236345AbhDAXiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 19:38:11 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC51C061793
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 16:38:08 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id g7so4076973qtb.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 16:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fVPoZK10rbW/sWCKlsGNCSQYscZnz2kgphabjqMmfzM=;
        b=ZDFK3UVlkGJWGHGbOLGMNIFNnlxM8sIyvZBjvKBxNU7Mh6KtoXihkXSL5rGaPfVVw+
         0au+OqbsD92YWKzPa6nTGeOWVSdm3X3JxaJsSxMGsKnRL0PfXUr4nXFbbBhkztjoaWvc
         QAicl/BQnTBZWaD0+6yhN+caM8P2JWjYe6MWOBj/m/nJ2/BtWWz7XY+iMBdIy30gk61Y
         A4DuG/a5t4CmtpgCHxTW1xxeTvzqH+VditXXRkxPW5kR3dq6IDcMr9S/i0A8FtGLAfZp
         EGDCO0uKO1WKAmaH1PC6wbNtr3Wh2jIsLs2T0dIjOFbBmrx/85n3Ja0B3LaecEl6Zuf+
         s5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fVPoZK10rbW/sWCKlsGNCSQYscZnz2kgphabjqMmfzM=;
        b=W2EH0KUA/aBGBN49d479TdCF2AvYPfKHEo2q+1lXW21tObtno9Uzx0wbT7a+W49kSw
         Txl0D076/CM0/9tpI01GNstrtjHurdWFa/1wEquSpZyD02L5eAnwitWOprCaBOEHbPcn
         /IA6Q6DJs8POlJG87Rw1Mt9Th+SwSXLpPBbDPxmIR0BCVTA06zorhTx3xAwibHyXxp+u
         43OZjZ/n8bEfrX1qahTZc8MggILWBQF5C9r8INLbASjPm2GvvZKwBQpqbjykHax7D0dk
         0EzeHT6QWusJMRYBHN6lSx+551dKkwVcPgSzFxkgZ+fdTlrnsXM8vTTBwtDArub37SPE
         Htuw==
X-Gm-Message-State: AOAM533vAqUx+J57XpoYnM30OLW6giYTvJk5YaHZp1WL5K5uFNZyL8HZ
        xvk/Y+bhtP35auKjBO1rS/U4Adj8qXXZLlqpyFj8x6vLKKGcbDDMbE+nhrB8xB9hg7n9hkn4PY2
        H/jqJlFQ2GDomNJMLYZjVMECgQnxev5Tw8kMMsBvO5RlahSkWTUYU1RwicdqTAuFdnmO27xTB
X-Google-Smtp-Source: ABdhPJy3DjSB6LnYpqcpR9OF0VpRbdFeYIra9rOadwaQyRGOaPToqSVvf5SQZ+7Nz08k44Y6MFnu9v+X/9n8
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:e088:88b8:ea4a:22b6])
 (user=bgardon job=sendgmr) by 2002:a05:6214:122f:: with SMTP id
 p15mr10707612qvv.3.1617320288078; Thu, 01 Apr 2021 16:38:08 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:37:29 -0700
In-Reply-To: <20210401233736.638171-1-bgardon@google.com>
Message-Id: <20210401233736.638171-7-bgardon@google.com>
Mime-Version: 1.0
References: <20210401233736.638171-1-bgardon@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v2 06/13] KVM: x86/mmu: Make TDP MMU root refcount atomic
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to parallelize more operations for the TDP MMU, make the
refcount on TDP MMU roots atomic, so that a future patch can allow
multiple threads to take a reference on the root concurrently, while
holding the MMU lock in read mode.

Signed-off-by: Ben Gardon <bgardon@google.com>
---

Changelog
v2:
--	Split failure handling for kvm_tdp_mmu_get_root out into a
	seperate commit.

 arch/x86/kvm/mmu/mmu_internal.h |  6 +++++-
 arch/x86/kvm/mmu/tdp_mmu.c      |  4 ++--
 arch/x86/kvm/mmu/tdp_mmu.h      | 10 +++++++---
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 9347d73996b5..f63d0fdb8567 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -50,7 +50,11 @@ struct kvm_mmu_page {
 	u64 *spt;
 	/* hold the gfn of each spte inside spt */
 	gfn_t *gfns;
-	int root_count;          /* Currently serving as active root */
+	/* Currently serving as active root */
+	union {
+		int root_count;
+		refcount_t tdp_mmu_root_count;
+	};
 	unsigned int unsync_children;
 	struct kvm_rmap_head parent_ptes; /* rmap pointers to parent sptes */
 	DECLARE_BITMAP(unsync_child_bitmap, 512);
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 670c5e3ad80e..697ea882a3e4 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -56,7 +56,7 @@ void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root)
 
 	lockdep_assert_held_write(&kvm->mmu_lock);
 
-	if (--root->root_count)
+	if (!refcount_dec_and_test(&root->tdp_mmu_root_count))
 		return;
 
 	WARN_ON(!root->tdp_mmu_page);
@@ -168,7 +168,7 @@ hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu)
 	}
 
 	root = alloc_tdp_mmu_page(vcpu, 0, vcpu->arch.mmu->shadow_root_level);
-	root->root_count = 1;
+	refcount_set(&root->tdp_mmu_root_count, 1);
 
 	list_add(&root->link, &kvm->arch.tdp_mmu_roots);
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
index d4e32ac5f4c9..1ec7914ecff9 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.h
+++ b/arch/x86/kvm/mmu/tdp_mmu.h
@@ -10,10 +10,14 @@ hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu);
 static inline void kvm_tdp_mmu_get_root(struct kvm *kvm,
 					struct kvm_mmu_page *root)
 {
-	BUG_ON(!root->root_count);
-	lockdep_assert_held(&kvm->mmu_lock);
+	lockdep_assert_held_write(&kvm->mmu_lock);
 
-	++root->root_count;
+	/*
+	 * This should never fail since roots are removed from the roots
+	 * list under the MMU write lock when their reference count falls
+	 * to zero.
+	 */
+	refcount_inc_not_zero(&root->tdp_mmu_root_count);
 }
 
 void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root);
-- 
2.31.0.208.g409f899ff0-goog

