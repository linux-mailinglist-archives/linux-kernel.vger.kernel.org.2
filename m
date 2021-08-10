Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5A73E862D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 00:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbhHJWqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 18:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbhHJWq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 18:46:26 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68A7C061798
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 15:46:02 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id z8-20020a0ce9880000b02903528f1b338aso137186qvn.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 15:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=eqBNVNpWIIpSq+pfV6uCStvlMjvi00zLA50LkoAPgV0=;
        b=Dvi7ew9FQNfrSvdH1mhLdjatlydl9KSAldsi6lVVnJHMwiWuvkgF7VWvZIR+MWMDoF
         30WiHh9yT5l6Seq2QX7gC7XFItIES0zk7MVZIzyS7gs6MjPTbfy218XHcVGoM5WR2zzi
         8rS3vYrb9B7gViBuNnY5moNk5PCNewG3hxlMOuSl7x8SFgxynELmziyV73QQsJJkHdP5
         mOUoosIx0LNMfWRRGbT9U10oXAtEpu+jHsgc9omJjPVsVe99uvhJWWaZrznBNEr0Cn9t
         VWzlhiTefbmk8e8wH8LVqEQ7sWesiP6zcvrK75c3iXVrBrLDwsrfZ4sLRSih9NTyUdNA
         2/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=eqBNVNpWIIpSq+pfV6uCStvlMjvi00zLA50LkoAPgV0=;
        b=kv4FEYx2m0+5ofH2G0hsfQCKjLh7KUyhcFWAl8i8O/yQ6adfVUvQO3k99yLq576VMP
         obJ+hL7WHk8iQw9FCcbQ9oxkeJV6rEyDcyFdRXSP6VTZfJM2SbiNkNg8eDxoazJDHg5U
         1X8bWumoJ8QkQWxyPZyeZeaxhoUDf8UTqmvKZ2/rEcQwxJUy6/CeRohnxC27dmE4WQI5
         HCohKTZl9+Mv9Q+uvTEPcjaToMkqTyLWGC+o8kep9lOT69nAJcvZebbg9BwcYwwA4P0C
         UN8uZ2AI1YwzPQlbrPioBE1jUF2r3uy0GELBP27doAjjQlwZb614jlOeGRT05rxZ9dtA
         H6MQ==
X-Gm-Message-State: AOAM531GJx2U9ChMxNzni/2L9y9OwXycmDgeX8EuCbWL3/tz1se2fA1n
        IGz7Uv1PiMR2qaBoAXL+4KDR9qalnjY=
X-Google-Smtp-Source: ABdhPJxLku6SMROxZvTFWQNsc+G3H5PkOpVxGh+EMykrSJBYJIJl2qQiec+kJCkhkVaR3/RUMncogL+Dxs0=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:1c47:622e:7a2a:372d])
 (user=seanjc job=sendgmr) by 2002:a05:6214:10e6:: with SMTP id
 q6mr31789808qvt.11.1628635562042; Tue, 10 Aug 2021 15:46:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 10 Aug 2021 15:45:54 -0700
In-Reply-To: <20210810224554.2978735-1-seanjc@google.com>
Message-Id: <20210810224554.2978735-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210810224554.2978735-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH 2/2] KVM: x86/mmu: Drop 'shared' param from tdp_mmu_link_page()
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

Drop @shared from tdp_mmu_link_page() and hardcode it to work for
mmu_lock being held for read.  The helper has exactly one caller and
in all likelihood will only ever have exactly one caller.  Even if KVM
adds a path to install translations without an initiating page fault,
odds are very, very good that the path will just be a wrapper to the
"page fault" handler (both SNP and TDX RFCs propose patches to do
exactly that).

No functional change intended.

Cc: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index d99e064d366f..c5b901744d15 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -257,26 +257,17 @@ static void handle_changed_spte_dirty_log(struct kvm *kvm, int as_id, gfn_t gfn,
  *
  * @kvm: kvm instance
  * @sp: the new page
- * @shared: This operation may not be running under the exclusive use of
- *	    the MMU lock and the operation must synchronize with other
- *	    threads that might be adding or removing pages.
  * @account_nx: This page replaces a NX large page and should be marked for
  *		eventual reclaim.
  */
 static void tdp_mmu_link_page(struct kvm *kvm, struct kvm_mmu_page *sp,
-			      bool shared, bool account_nx)
+			      bool account_nx)
 {
-	if (shared)
-		spin_lock(&kvm->arch.tdp_mmu_pages_lock);
-	else
-		lockdep_assert_held_write(&kvm->mmu_lock);
-
+	spin_lock(&kvm->arch.tdp_mmu_pages_lock);
 	list_add(&sp->link, &kvm->arch.tdp_mmu_pages);
 	if (account_nx)
 		account_huge_nx_page(kvm, sp);
-
-	if (shared)
-		spin_unlock(&kvm->arch.tdp_mmu_pages_lock);
+	spin_unlock(&kvm->arch.tdp_mmu_pages_lock);
 }
 
 /**
@@ -1062,7 +1053,7 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 						     !shadow_accessed_mask);
 
 			if (tdp_mmu_set_spte_atomic_no_dirty_log(vcpu->kvm, &iter, new_spte)) {
-				tdp_mmu_link_page(vcpu->kvm, sp, true,
+				tdp_mmu_link_page(vcpu->kvm, sp,
 						  huge_page_disallowed &&
 						  req_level >= iter.level);
 
-- 
2.32.0.605.g8dce9f2422-goog

