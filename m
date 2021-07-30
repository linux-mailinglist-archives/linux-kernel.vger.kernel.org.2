Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E1D3DC0C7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 00:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbhG3WGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 18:06:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44958 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232564AbhG3WGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 18:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627682766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k6/TIj2oL2PuBNwoGj29exdxyYSlXcamNRrMDM9CcnI=;
        b=F8H/jvahyjTGlrmq06swTtRxjVDQx1xpoIi8dTpwAfrMBTUIdVM19mzW2uqNkQ1Pd+1QwP
        EJ9pa7Bs4XcwS8Spij1w2qeQ8u+vZ0j+NwceOzHNAfW3YoSxD/QA9T3NUNU4eTnSSKvqde
        pAoSR91U8ukc35R4Uq/YhMLjylQQtmo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-0kmO_wfhOAinm8O9eU0O9g-1; Fri, 30 Jul 2021 18:06:05 -0400
X-MC-Unique: 0kmO_wfhOAinm8O9eU0O9g-1
Received: by mail-qt1-f199.google.com with SMTP id q10-20020a05622a04cab0290267bc0213a9so5169108qtx.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 15:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k6/TIj2oL2PuBNwoGj29exdxyYSlXcamNRrMDM9CcnI=;
        b=p1dViBhS+BEArkOblR8VJ5GTfu59NvoBdfbhpppAiMNBEkZmCW4ZAHwjFHyTcb6hE2
         IDu2ZIRChURnE9Dm+byXD1wRPsdML2ovU2tdH5Bo0KJifWESoSNN6ZEQevD6crbksNxG
         qO2eSnRqWiTNh0ArWYnGmcaRWvTWm1YCJeYI+N5K2sleEY67Us3i8vPJhuCaZ9Fr0owE
         jmjtfENrAC61VonMvD/1a2399M96ECOZjZUND7Jty87a2DQgpMLvftPaboTai6EKmRQT
         Tar9c9IZ+8RnPTEsQsemuwPsVMPgDNtTeJXf1YZHDfgvK0qKp7b3eom4NiH21lgHR61P
         e7ow==
X-Gm-Message-State: AOAM530URlD9SMbmxmFlnouo743BRXYDx/QHaaHhXUhbwbaT+je/E73d
        m9HpfxvjCITdBfl/vgE+yKeUjkB7YEPh4VWSkuQQJSTGehAmWioAzCgBuC6mLPHya/em/3GXqwM
        DlvCEGxTiZuNrdF0c7SVW0xvBTCeo5o4a80j3E2JQXefYeJ8lTJVNhQChy0OqBh1X0HWKqdM53g
        ==
X-Received: by 2002:a0c:be8e:: with SMTP id n14mr5098413qvi.16.1627682764568;
        Fri, 30 Jul 2021 15:06:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcw83DgDJNDOwVMK+xRgEPO3B9UIXdU/pUAOXMNnInpKpTdAOBSEDfC1apcAufJ0N+exEV0Q==
X-Received: by 2002:a0c:be8e:: with SMTP id n14mr5098393qvi.16.1627682764334;
        Fri, 30 Jul 2021 15:06:04 -0700 (PDT)
Received: from t490s.. (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id o186sm1622893qke.44.2021.07.30.15.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 15:06:03 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, peterx@redhat.com,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 6/7] KVM: X86: Optimize pte_list_desc with per-array counter
Date:   Fri, 30 Jul 2021 18:06:02 -0400
Message-Id: <20210730220602.26327-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210730220455.26054-1-peterx@redhat.com>
References: <20210730220455.26054-1-peterx@redhat.com>
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
500" [1]), this patch further speeds up the total fork time of about 4%, which
is a total of 33% of vanilla kernel:

        Vanilla:      473.90 (+-5.93%)
        3->15 slots:  366.10 (+-4.94%)
        Add counter:  351.00 (+-3.70%)

[1] https://github.com/xzpeter/clibs/commit/825436f825453de2ea5aaee4bdb1c92281efe5b3

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c0b452bb5dd9..111c37141dbe 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -138,11 +138,21 @@ module_param(dbg, bool, 0644);
 #include <trace/events/kvm.h>
 
 /* make pte_list_desc fit well in cache lines */
-#define PTE_LIST_EXT 15
+#define PTE_LIST_EXT 14
 
+/*
+ * Slight optimization of cacheline layout, by putting `more' and `spte_count'
+ * at the start; then accessing it will only use one single cacheline for
+ * either full (entries==PTE_LIST_EXT) case or entries<=6.
+ */
 struct pte_list_desc {
-	u64 *sptes[PTE_LIST_EXT];
 	struct pte_list_desc *more;
+	/*
+	 * Stores number of entries stored in the pte_list_desc.  No need to be
+	 * u64 but just for easier alignment.  When PTE_LIST_EXT, means full.
+	 */
+	u64 spte_count;
+	u64 *sptes[PTE_LIST_EXT];
 };
 
 struct kvm_shadow_walk_iterator {
@@ -901,7 +911,7 @@ static int pte_list_add(struct kvm_vcpu *vcpu, u64 *spte,
 			struct kvm_rmap_head *rmap_head)
 {
 	struct pte_list_desc *desc;
-	int i, count = 0;
+	int count = 0;
 
 	if (!rmap_head->val) {
 		rmap_printk("%p %llx 0->1\n", spte, *spte);
@@ -911,24 +921,24 @@ static int pte_list_add(struct kvm_vcpu *vcpu, u64 *spte,
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
@@ -938,13 +948,12 @@ pte_list_desc_remove_entry(struct kvm_rmap_head *rmap_head,
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
@@ -977,7 +986,7 @@ static void __pte_list_remove(u64 *spte, struct kvm_rmap_head *rmap_head)
 		desc = (struct pte_list_desc *)(rmap_head->val & ~1ul);
 		prev_desc = NULL;
 		while (desc) {
-			for (i = 0; i < PTE_LIST_EXT && desc->sptes[i]; ++i) {
+			for (i = 0; i < desc->spte_count; ++i) {
 				if (desc->sptes[i] == spte) {
 					pte_list_desc_remove_entry(rmap_head,
 							desc, i, prev_desc);
@@ -1001,7 +1010,7 @@ static void pte_list_remove(struct kvm_rmap_head *rmap_head, u64 *sptep)
 unsigned int pte_list_count(struct kvm_rmap_head *rmap_head)
 {
 	struct pte_list_desc *desc;
-	unsigned int i, count = 0;
+	unsigned int count = 0;
 
 	if (!rmap_head->val)
 		return 0;
@@ -1011,8 +1020,7 @@ unsigned int pte_list_count(struct kvm_rmap_head *rmap_head)
 	desc = (struct pte_list_desc *)(rmap_head->val & ~1ul);
 
 	while (desc) {
-		for (i = 0; (i < PTE_LIST_EXT) && desc->sptes[i]; i++)
-			count++;
+		count += desc->spte_count;
 		desc = desc->more;
 	}
 
-- 
2.31.1

