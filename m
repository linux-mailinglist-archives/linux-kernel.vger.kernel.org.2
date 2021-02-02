Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0C630CAE8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbhBBTE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239351AbhBBTCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 14:02:06 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52A0C0611BE
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:58:13 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 8so14796341pgn.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=7wwE6UVlfYIz1bD+MH7rvktLq1BWQ7Niw1vVFs8Dr9U=;
        b=hykkCo6ukRsr8EfpcpDNvsfhfSfG7G0UiuPEUQFCTVj45UvL+vT39H9nqqYK3GsmV0
         VPEqKGmHRy1S5o6aAiO4ZnYQdjj3qcdYwgVutWx6dEuhmo6vZo517WBA+cm6oJjDR8EN
         dassTMz4E+Sfi5Yc34vwXDzlbAkpdkt87VvDIZiF1FTtPsFM1QkvJvS2xSZa415ItSeG
         Jh1PNDhkrzJHexl21g1NXJFHiukosH/2Gx3x/UOxPd33UWFkytVVDX5N4pmWQWGzocrQ
         ddAOf3RY3rRPt24IPkuR75uHm6cV4NjtcfX4pg6I8CrUXWaikvMFdow5zoWY65cBr0iO
         jIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7wwE6UVlfYIz1bD+MH7rvktLq1BWQ7Niw1vVFs8Dr9U=;
        b=Dgoxf/osbLw4+SmacL4PILC66hoXctO+OxOa5K7bqMMPDO0oqIMCcj2webB74KeBqL
         Z3eXKI94foAE26qH34qx4mKD0NQWXCjl3gBX4wUeDLjQmtvJVK7FZqvdMh/jGR08sPDG
         J48T1bAO0uXzzSfWWaAlgp4tNm1y9BKz9U8Ijb0T26LORj/RWj7xL3sWDmC7j1KiHPAi
         IbcUGqPsjJ+Bz5sL2xBteLCOEIfSS+UCQHNJFR1MHburWKqR1Meep14v3i+6gczaPo9v
         kfs1Tp7ZODiTJFkrq35rP5DfSqH/VqM2/bepDYcbPKlJ+rtWtSqcxYJLJ8nZZAFXaqQG
         S5qQ==
X-Gm-Message-State: AOAM531L0RNIRVhkNenjv6Umm0i41I/Dy+vDT4sJlU3K3C2yQhgNdruX
        ZEG0eaxFzOVsKxwVRg01p6Ptj5CSFe/B9NbZDAPYO4a4TwP3x+LAinRT8m/iIKhGtXCmh5ieG0s
        dfC4akEtibddVBX5pRrIyHKbcHtm02KDfrDj9Fps4W72gKBk6t76F43tYI8Hl1LIK5p5pRGfC
X-Google-Smtp-Source: ABdhPJzhz23yIx2witmBOtZ9LieRs9XiDxy0qRVz/6phPhCsMap8VaSEb4v8MRK9hQSuqWIl1hzEf9hcAc80
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:9090:561:5a98:6d47])
 (user=bgardon job=sendgmr) by 2002:a05:6a00:138f:b029:1b8:b9d5:3a2c with SMTP
 id t15-20020a056a00138fb02901b8b9d53a2cmr23099752pfg.10.1612292293034; Tue,
 02 Feb 2021 10:58:13 -0800 (PST)
Date:   Tue,  2 Feb 2021 10:57:25 -0800
In-Reply-To: <20210202185734.1680553-1-bgardon@google.com>
Message-Id: <20210202185734.1680553-20-bgardon@google.com>
Mime-Version: 1.0
References: <20210202185734.1680553-1-bgardon@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 19/28] KVM: x86/mmu: Factor out functions to add/remove TDP
 MMU pages
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

Move the work of adding and removing TDP MMU pages to/from  "secondary"
data structures to helper functions. These functions will be built on in
future commits to enable MMU operations to proceed (mostly) in parallel.

No functional change expected.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 47 +++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index f1fbed72e149..5a9e964e0178 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -262,6 +262,39 @@ static void handle_changed_spte_dirty_log(struct kvm *kvm, int as_id, gfn_t gfn,
 	}
 }
 
+/**
+ * tdp_mmu_link_page - Add a new page to the list of pages used by the TDP MMU
+ *
+ * @kvm: kvm instance
+ * @sp: the new page
+ * @account_nx: This page replaces a NX large page and should be marked for
+ *		eventual reclaim.
+ */
+static void tdp_mmu_link_page(struct kvm *kvm, struct kvm_mmu_page *sp,
+			      bool account_nx)
+{
+	lockdep_assert_held_write(&kvm->mmu_lock);
+
+	list_add(&sp->link, &kvm->arch.tdp_mmu_pages);
+	if (account_nx)
+		account_huge_nx_page(kvm, sp);
+}
+
+/**
+ * tdp_mmu_unlink_page - Remove page from the list of pages used by the TDP MMU
+ *
+ * @kvm: kvm instance
+ * @sp: the page to be removed
+ */
+static void tdp_mmu_unlink_page(struct kvm *kvm, struct kvm_mmu_page *sp)
+{
+	lockdep_assert_held_write(&kvm->mmu_lock);
+
+	list_del(&sp->link);
+	if (sp->lpage_disallowed)
+		unaccount_huge_nx_page(kvm, sp);
+}
+
 /**
  * handle_removed_tdp_mmu_page - handle a pt removed from the TDP structure
  *
@@ -281,10 +314,7 @@ static void handle_removed_tdp_mmu_page(struct kvm *kvm, u64 *pt)
 
 	trace_kvm_mmu_prepare_zap_page(sp);
 
-	list_del(&sp->link);
-
-	if (sp->lpage_disallowed)
-		unaccount_huge_nx_page(kvm, sp);
+	tdp_mmu_unlink_page(kvm, sp);
 
 	for (i = 0; i < PT64_ENT_PER_PAGE; i++) {
 		old_child_spte = READ_ONCE(*(pt + i));
@@ -705,15 +735,16 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 
 		if (!is_shadow_present_pte(iter.old_spte)) {
 			sp = alloc_tdp_mmu_page(vcpu, iter.gfn, iter.level);
-			list_add(&sp->link, &vcpu->kvm->arch.tdp_mmu_pages);
 			child_pt = sp->spt;
+
+			tdp_mmu_link_page(vcpu->kvm, sp,
+					  huge_page_disallowed &&
+					  req_level >= iter.level);
+
 			new_spte = make_nonleaf_spte(child_pt,
 						     !shadow_accessed_mask);
 
 			trace_kvm_mmu_get_page(sp, true);
-			if (huge_page_disallowed && req_level >= iter.level)
-				account_huge_nx_page(vcpu->kvm, sp);
-
 			tdp_mmu_set_spte(vcpu->kvm, &iter, new_spte);
 		}
 	}
-- 
2.30.0.365.g02bc693789-goog

