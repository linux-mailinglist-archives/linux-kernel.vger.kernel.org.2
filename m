Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11D73B46B6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 17:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhFYPgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 11:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21672 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229884AbhFYPgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 11:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624635261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GAefR5jsv2aB5x5SE+QJ86SlCiYChLGRfggmJlDrXNo=;
        b=RDcyaTvVAOLBXBMZAOjkTsbB7Cxey+UqkvVspvSfVeuNtgVmqQciVN34+/LTDKSlByLs8k
        quOIf+xo7cC/AUC1SrnGK+fEbW/n89OReIX8VkwsChndbJiA+LfOag55ifAMa8Pv6uI51n
        H7kzLAaBV5FNTvsVMuEGpafSgrAynxQ=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-DqTX3T96ONS5Te0Gc1ZGYg-1; Fri, 25 Jun 2021 11:34:19 -0400
X-MC-Unique: DqTX3T96ONS5Te0Gc1ZGYg-1
Received: by mail-io1-f72.google.com with SMTP id a6-20020a0566021486b02904db010ce8e8so7275191iow.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 08:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GAefR5jsv2aB5x5SE+QJ86SlCiYChLGRfggmJlDrXNo=;
        b=ituOUAPEN1IGV7VpZ81I8pF08DArjvOD85V46B5x0QMIcfZlZUMbsaSn56yLFjOii6
         +rAqAS4xFZp8Oaw8xYD0fRPJ8CM6KI7RVjjAG/VXsiIzU956WaKCHmAvWIHCwgy4k2R/
         VP6g2zPsGckUiKTPpIcpx7VqG0JXCQoq3yNfjCN5cfvViUV5sqDccHGJnZCXfo/1xsUC
         1S4HiGthTRWjlEWujXAvmHWOUlsyJnkvI6TkvDU+0/VwrN0eMKPMiY/oV5Ao+sKuQwHQ
         CPX5QB2k2kDZavJUoFKJ76akjx0QDRGSGQUFXNyJzk+3nUvNrOH9kcjuJk6H2fI1W1W/
         1ypA==
X-Gm-Message-State: AOAM531YFKhrhxLa/4FRfMcuTc9lH97P51R3Z23D5B9vd3P381H1JUUv
        cTGWlCTZQO/i+GQ1deoHmKPn+FNBzAK96Br27ilE/kpFL64jPDvzLPW8Uu4IvZjRqjTKM3LR+aG
        VjsthMKtDJLocpWWVE2XGQ6sivoEWzWgQBK9/+YT2xu5/BHcYgJBCGzuE8XW9LbyWxwNUxPr5yw
        ==
X-Received: by 2002:a02:84a3:: with SMTP id f32mr10034958jai.63.1624635258755;
        Fri, 25 Jun 2021 08:34:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxq6qUS4K3DVs2P9SSjKenQ7FRjhcE3FWO4HRIgVDFbE6V1/5UvoM18/9G/9bY7GwfogG12eA==
X-Received: by 2002:a02:84a3:: with SMTP id f32mr10034937jai.63.1624635258511;
        Fri, 25 Jun 2021 08:34:18 -0700 (PDT)
Received: from t490s.redhat.com (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id x11sm3863687ilg.59.2021.06.25.08.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 08:34:17 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     peterx@redhat.com, Maxim Levitsky <mlevitsk@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 8/9] KVM: X86: Optimize pte_list_desc with per-array counter
Date:   Fri, 25 Jun 2021 11:34:15 -0400
Message-Id: <20210625153415.43620-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625153214.43106-1-peterx@redhat.com>
References: <20210625153214.43106-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a counter field into pte_list_desc, so as to simplify the add/remove/loop
logic.  E.g., we don't need to loop over the array any more for most reasons.

This will make more sense after we've switched the array size to be larger
otherwise the counter will be a waste.

Initially I wanted to store a tail pointer at the head of the array list so we
don't need to traverse the list at least for pushing new ones (if without the
counter we traverse both the list and the array).  However that'll need
slightly more change without a huge lot benefit, e.g., after we grow entry
numbers per array the list traversing is not so expensive.

So let's be simple but still try to get as much benefit as we can with just
these extra few lines of changes (not to mention the code looks easier too
without looping over arrays).

I used the same a test case to fork 500 child and recycle them ("./rmap_fork
500" [1]), this patch further speeds up the total fork time of about 14%, which
is a total of 38% of vanilla kernel:

        Vanilla:      367.20 (+-4.58%)
        3->15 slots:  302.00 (+-5.30%)
        Add counter:  265.20 (+-9.88%)

[1] https://github.com/xzpeter/clibs/commit/825436f825453de2ea5aaee4bdb1c92281efe5b3

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 9b093985a2ef..ba0258bdebc4 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -138,10 +138,15 @@ module_param(dbg, bool, 0644);
 #include <trace/events/kvm.h>
 
 /* make pte_list_desc fit well in cache lines */
-#define PTE_LIST_EXT 15
+#define PTE_LIST_EXT 14
 
 struct pte_list_desc {
 	u64 *sptes[PTE_LIST_EXT];
+	/*
+	 * Stores number of entries stored in the pte_list_desc.  No need to be
+	 * u64 but just for easier alignment.  When PTE_LIST_EXT, means full.
+	 */
+	u64 spte_count;
 	struct pte_list_desc *more;
 };
 
@@ -893,7 +898,7 @@ static int pte_list_add(struct kvm_vcpu *vcpu, u64 *spte,
 			struct kvm_rmap_head *rmap_head)
 {
 	struct pte_list_desc *desc;
-	int i, count = 0;
+	int count = 0;
 
 	if (!rmap_head->val) {
 		rmap_printk("%p %llx 0->1\n", spte, *spte);
@@ -903,24 +908,24 @@ static int pte_list_add(struct kvm_vcpu *vcpu, u64 *spte,
 		desc = mmu_alloc_pte_list_desc(vcpu);
 		desc->sptes[0] = (u64 *)rmap_head->val;
 		desc->sptes[1] = spte;
+		desc->spte_count = 2;
 		rmap_head->val = (unsigned long)desc | 1;
 		++count;
 	} else {
 		rmap_printk("%p %llx many->many\n", spte, *spte);
 		desc = (struct pte_list_desc *)(rmap_head->val & ~1ul);
-		while (desc->sptes[PTE_LIST_EXT-1]) {
+		while (desc->spte_count == PTE_LIST_EXT) {
 			count += PTE_LIST_EXT;
-
 			if (!desc->more) {
 				desc->more = mmu_alloc_pte_list_desc(vcpu);
 				desc = desc->more;
+				desc->spte_count = 0;
 				break;
 			}
 			desc = desc->more;
 		}
-		for (i = 0; desc->sptes[i]; ++i)
-			++count;
-		desc->sptes[i] = spte;
+		count += desc->spte_count;
+		desc->sptes[desc->spte_count++] = spte;
 	}
 	return count;
 }
@@ -930,13 +935,12 @@ pte_list_desc_remove_entry(struct kvm_rmap_head *rmap_head,
 			   struct pte_list_desc *desc, int i,
 			   struct pte_list_desc *prev_desc)
 {
-	int j;
+	int j = desc->spte_count - 1;
 
-	for (j = PTE_LIST_EXT - 1; !desc->sptes[j] && j > i; --j)
-		;
 	desc->sptes[i] = desc->sptes[j];
 	desc->sptes[j] = NULL;
-	if (j != 0)
+	desc->spte_count--;
+	if (desc->spte_count)
 		return;
 	if (!prev_desc && !desc->more)
 		rmap_head->val = 0;
@@ -969,7 +973,7 @@ static void __pte_list_remove(u64 *spte, struct kvm_rmap_head *rmap_head)
 		desc = (struct pte_list_desc *)(rmap_head->val & ~1ul);
 		prev_desc = NULL;
 		while (desc) {
-			for (i = 0; i < PTE_LIST_EXT && desc->sptes[i]; ++i) {
+			for (i = 0; i < desc->spte_count; ++i) {
 				if (desc->sptes[i] == spte) {
 					pte_list_desc_remove_entry(rmap_head,
 							desc, i, prev_desc);
@@ -993,7 +997,7 @@ static void pte_list_remove(struct kvm_rmap_head *rmap_head, u64 *sptep)
 unsigned int pte_list_count(struct kvm_rmap_head *rmap_head)
 {
 	struct pte_list_desc *desc;
-	unsigned int i, count = 0;
+	unsigned int count = 0;
 
 	if (!rmap_head->val)
 		return 0;
@@ -1003,8 +1007,7 @@ unsigned int pte_list_count(struct kvm_rmap_head *rmap_head)
 	desc = (struct pte_list_desc *)(rmap_head->val & ~1ul);
 
 	while (desc) {
-		for (i = 0; (i < PTE_LIST_EXT) && desc->sptes[i]; i++)
-			count++;
+		count += desc->spte_count;
 		desc = desc->more;
 	}
 
-- 
2.31.1

