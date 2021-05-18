Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74266387E89
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 19:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbhERRgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 13:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351188AbhERRfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 13:35:46 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03364C061761
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 10:34:28 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id mw15-20020a17090b4d0fb0290157199aadbaso2188359pjb.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 10:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ci7csGTkYvm5LlxT+HruOwjwM2kzKVu4Qx/8fLV2KZA=;
        b=LssKPzEHtG0Xr1DkT8L9SN/+jjeEjFoRne1hwEh80ZuS33ivYDZwBJqfvOJgvVg9zp
         viPgE7E7F604Foji+ByHCK2sdv8vmwsCQF5jzW6v3uQULCFZCpJEIarcoqdxIGL2v5TR
         KhqSL0MwhrUisDvoqD7RRpLH/XYMNPZLAirALizfs8WSsLIRH/j+FDMk3PKKmm0WJqog
         ZbFQG9AGlahf5+r9lIRs3pOMROzHdDRkbcKHOJESgYyE0RC1N0GHF6HvRp88yGQ2b+/F
         iH1VZFJYUOjYbElkntu8MQHv+tAioL4hLzf2qwXH97d7ziyqgKWE4F1DhM9a0LJUJ4sf
         wqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ci7csGTkYvm5LlxT+HruOwjwM2kzKVu4Qx/8fLV2KZA=;
        b=O5ud4KJuORvHpaUkEpPfFid7DSQuxhHJTVnhQLQn1bLbN5wIJEY/BoKVaLr5p5jarg
         6fnizotktqNfVDvGfWB1DbFzBDno+nVAFmJbKrlZAYMEXvokXjoRrijAXRrX7n2PwGoH
         xxbccf9jlifseeHGwrkObKNlFoiWSlLks+qF7P5SFBiSC5z3WpguAZ4Or/QOLXN9nxB7
         GdjS0lO8SjOyUbysJy3DDCBgDpxNMVA9km+JpGhpFqvDQ6+vvY8dN0Y7PcHd8v3g8izj
         eIpuhZJSxzLrzidP8AMkv5W68+JnKghmhwQ3jm39pEofAld/KpayJzc1xEgLX++gBXWs
         4XmQ==
X-Gm-Message-State: AOAM531e853+FjtTfEA0SUc753vbDBd/zCTw5YdW+R4MAjhcw7hj4MC+
        S7UGyumb/2KKFjg1KXci39mQp68GotbI+IODfUaD5Zz9+LSTTJPFoP8cqyhmQtJjFvg6cfabfWi
        aqdzgf5WtOOECFIwZFz+ZclMS/q07mmz4s4kNO64W4o/f19Ixp5x4bGIoutMKsNGUq+YpwXc6
X-Google-Smtp-Source: ABdhPJxA+HS9C/YbifKQZIU3hNtZlWBBT1Bo7TS9nl168tPeURTKsP5JRjNKxYHMi3M0ScCdYR97xdtoxyuQ
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:2715:2de:868e:9db7])
 (user=bgardon job=sendgmr) by 2002:a17:90a:ca05:: with SMTP id
 x5mr6524067pjt.16.1621359267435; Tue, 18 May 2021 10:34:27 -0700 (PDT)
Date:   Tue, 18 May 2021 10:34:12 -0700
In-Reply-To: <20210518173414.450044-1-bgardon@google.com>
Message-Id: <20210518173414.450044-6-bgardon@google.com>
Mime-Version: 1.0
References: <20210518173414.450044-1-bgardon@google.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v5 5/7] KVM: x86/mmu: Add a field to control memslot rmap allocation
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Kai Huang <kai.huang@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a field to control whether new memslots should have rmaps allocated
for them. As of this change, it's not safe to skip allocating rmaps, so
the field is always set to allocate rmaps. Future changes will make it
safe to operate without rmaps, using the TDP MMU. Then further changes
will allow the rmaps to be allocated lazily when needed for nested
oprtation.

No functional change expected.

Reviewed-by: David Hildenbrand <david@redhat.com>

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/include/asm/kvm_host.h |  6 ++++++
 arch/x86/kvm/mmu/mmu.c          |  2 ++
 arch/x86/kvm/x86.c              | 13 ++++++++-----
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 55efbacfc244..fc75ed49bfee 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1124,6 +1124,12 @@ struct kvm_arch {
 	 */
 	spinlock_t tdp_mmu_pages_lock;
 #endif /* CONFIG_X86_64 */
+
+	/*
+	 * If set, rmaps have been allocated for all memslots and should be
+	 * allocated for any newly created or modified memslots.
+	 */
+	bool memslots_have_rmaps;
 };
 
 struct kvm_vm_stat {
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 0144c40d09c7..f059f2e8c6fe 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5469,6 +5469,8 @@ void kvm_mmu_init_vm(struct kvm *kvm)
 
 	kvm_mmu_init_tdp_mmu(kvm);
 
+	kvm->arch.memslots_have_rmaps = true;
+
 	node->track_write = kvm_mmu_pte_write;
 	node->track_flush_slot = kvm_mmu_invalidate_zap_pages_in_memslot;
 	kvm_page_track_register_notifier(kvm, node);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4b3d53c5fc76..ae8e3179d483 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10941,7 +10941,8 @@ static int memslot_rmap_alloc(struct kvm_memory_slot *slot,
 	return 0;
 }
 
-static int kvm_alloc_memslot_metadata(struct kvm_memory_slot *slot,
+static int kvm_alloc_memslot_metadata(struct kvm *kvm,
+				      struct kvm_memory_slot *slot,
 				      unsigned long npages)
 {
 	int i, r;
@@ -10953,9 +10954,11 @@ static int kvm_alloc_memslot_metadata(struct kvm_memory_slot *slot,
 	 */
 	memset(&slot->arch, 0, sizeof(slot->arch));
 
-	r = memslot_rmap_alloc(slot, npages);
-	if (r)
-		return r;
+	if (kvm->arch.memslots_have_rmaps) {
+		r = memslot_rmap_alloc(slot, npages);
+		if (r)
+			return r;
+	}
 
 	for (i = 1; i < KVM_NR_PAGE_SIZES; ++i) {
 		struct kvm_lpage_info *linfo;
@@ -11026,7 +11029,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				enum kvm_mr_change change)
 {
 	if (change == KVM_MR_CREATE || change == KVM_MR_MOVE)
-		return kvm_alloc_memslot_metadata(memslot,
+		return kvm_alloc_memslot_metadata(kvm, memslot,
 						  mem->memory_size >> PAGE_SHIFT);
 	return 0;
 }
-- 
2.31.1.751.gd2f1c929bd-goog

