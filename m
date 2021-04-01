Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BAE352410
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 01:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbhDAXiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 19:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbhDAXiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 19:38:07 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711C6C061788
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 16:38:06 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id b127so4785076qkf.19
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 16:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0dwngUXBbpNYdBGZmaahkuuLQicfagFyPtrLrIpcGNI=;
        b=ZyI4hyQ+b/oIUOQGA8X1zeZIoh9iei6J9OWFlxTEv22VBAKFQ2rPEEJm0GucTShl1J
         aqFShn/pQBsCDXWzd2uwopUWxmCKKVQbKImeh1/+o5tHULcX0RkSzu2GE1yR9mzrUZjR
         5aQyS9e+ig68TeGTEglG+nFPGedaLxLwLVYKL1OUAV0CIPvToLVVIJmNIMCC4pT5fCUL
         m90ad0wT/pC2pk+OC7wgNbuq/5XpsneQrRFOUsMiUyybNe9Lsb5CEfPYmssL2Yx1Lu/I
         ecyVd/VYMacLo6BIKAkMqeZK16MgotJtJmejYBCgzVSEBr+Qnnp9OxNlmhrdkeZDpMlo
         Zuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0dwngUXBbpNYdBGZmaahkuuLQicfagFyPtrLrIpcGNI=;
        b=eGxh9SqCtTRahLoZbZsRJai0pzcq0/w11dTFlqUDUWl9tJPOYZpf4EBNwq7vhUB6xY
         4gylX2rMr1mj2QOqLUJjQa2oMtTRHZkKyWACMH70cyBgs14GURfVf50RrkHBFx5LthSj
         hWLKu8k0ypcBbyGwNa0eeiMvdJojTeGeW/U+X6FkIGpqPpWPfwH4XE0NtretsA5zsYdk
         c8rQy08k4BAvo2N9EbvIZgg2OZ+jNAk/bm7t7GDkNUp0PXEtgvbKTTIzC/Gh/0IV4W2p
         R/e+XaoGmTWI0B0fwBS2euIr9awYyJfm4WXAvmJkVcxFPU/qd8whFEU2oMhvrtSLNhH8
         TwcQ==
X-Gm-Message-State: AOAM533ijXrAdFeRlZPJqKe0BetWRG/XwbJUetUpqm5S28z3l0/uWkeO
        Km5Ngd+0X1V83Xjy70Ju+4qB1brrHZ3bpapZSt6/OeUPmsI2pVRNcvfpA6AHuS49z1X++M8nUWG
        TuN5SpCMKgkDA+3aNOqL8wbWQJm27KerIMeTaSftAPKBLMS8X6Itw64uKAJspeSoUVHWxH3oe
X-Google-Smtp-Source: ABdhPJxXSjUK3L9h9P5QDsbeIBPmKZwO4QV541IA7dWzZ/ZcLTD38mNenZX5HCyjGjkVqXqlgWJ4QSM8iLL9
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:e088:88b8:ea4a:22b6])
 (user=bgardon job=sendgmr) by 2002:a0c:a99a:: with SMTP id
 a26mr10750947qvb.2.1617320285604; Thu, 01 Apr 2021 16:38:05 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:37:28 -0700
In-Reply-To: <20210401233736.638171-1-bgardon@google.com>
Message-Id: <20210401233736.638171-6-bgardon@google.com>
Mime-Version: 1.0
References: <20210401233736.638171-1-bgardon@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v2 05/13] KVM: x86/mmu: Refactor yield safe root iterator
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

Refactor the yield safe TDP MMU root iterator to be more amenable to
changes in future commits which will allow it to be used under the MMU
lock in read mode. Currently the iterator requires a complicated dance
between the helper functions and different parts of the for loop which
makes it hard to reason about. Moving all the logic into a single function
simplifies the iterator substantially.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 45 ++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 279a725061f7..670c5e3ad80e 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -68,26 +68,34 @@ void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root)
 	tdp_mmu_free_sp(root);
 }
 
-static inline bool tdp_mmu_next_root_valid(struct kvm *kvm,
-					   struct kvm_mmu_page *root)
+/*
+ * Finds the next valid root after root (or the first valid root if root
+ * is NULL), takes a reference on it, and returns that next root. If root
+ * is not NULL, this thread should have already taken a reference on it, and
+ * that reference will be dropped. If no valid root is found, this
+ * function will return NULL.
+ */
+static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
+					      struct kvm_mmu_page *prev_root)
 {
-	lockdep_assert_held_write(&kvm->mmu_lock);
+	struct kvm_mmu_page *next_root;
 
-	if (list_entry_is_head(root, &kvm->arch.tdp_mmu_roots, link))
-		return false;
+	lockdep_assert_held_write(&kvm->mmu_lock);
 
-	kvm_tdp_mmu_get_root(kvm, root);
-	return true;
+	if (prev_root)
+		next_root = list_next_entry(prev_root, link);
+	else
+		next_root = list_first_entry(&kvm->arch.tdp_mmu_roots,
+					     typeof(*next_root), link);
 
-}
+	if (list_entry_is_head(next_root, &kvm->arch.tdp_mmu_roots, link))
+		next_root = NULL;
+	else
+		kvm_tdp_mmu_get_root(kvm, next_root);
 
-static inline struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
-						     struct kvm_mmu_page *root)
-{
-	struct kvm_mmu_page *next_root;
+	if (prev_root)
+		kvm_tdp_mmu_put_root(kvm, prev_root);
 
-	next_root = list_next_entry(root, link);
-	kvm_tdp_mmu_put_root(kvm, root);
 	return next_root;
 }
 
@@ -98,11 +106,10 @@ static inline struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
  * recent root. (Unless keeping a live reference is desirable.)
  */
 #define for_each_tdp_mmu_root_yield_safe(_kvm, _root, _as_id)		\
-	for (_root = list_first_entry(&_kvm->arch.tdp_mmu_roots,	\
-				      typeof(*_root), link);		\
-	     tdp_mmu_next_root_valid(_kvm, _root);			\
-	     _root = tdp_mmu_next_root(_kvm, _root))			\
-		if (kvm_mmu_page_as_id(_root) != _as_id) {		\
+	for (_root = tdp_mmu_next_root(_kvm, NULL);		\
+	     _root;						\
+	     _root = tdp_mmu_next_root(_kvm, _root))		\
+		if (kvm_mmu_page_as_id(_root) != _as_id) {	\
 		} else
 
 #define for_each_tdp_mmu_root(_kvm, _root, _as_id)			\
-- 
2.31.0.208.g409f899ff0-goog

