Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB32732A91D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580673AbhCBSMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382683AbhCBPas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:30:48 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C05DC061B3F
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:00:19 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id z6so2518344wrh.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=lIPthT51J+nIs48nl/QvpI3Ln3AY2S6u6ppS3XkUMwM=;
        b=HY2FQJKTnEHypa62GHDeyX5+DVpyd3kd+DNyVif3kQtZ0Ox8tb7XmQpSllG+iYjI1q
         2QUVT2ttxPR69J+1gr+Neb8KNaKUHnwZPw3KUtPEso2PhLlezOzkuodC5vfiw9ttCpDt
         PRv1H5+P/SxKxew8i6WYse/QbcgSljdRs8FF7QDs49k78eLuvKtMpiJAuzX2X73QLIXU
         D6R6lQ6XuxLRnxSp+qKmjlwaaJbUgl6MooyomJKPlhfPlxL+ZUe44/BrLtDEXg46c0WL
         EuYGfH2gL3Od1t6WL3JKq7MFziOBysv7Jm4YOo4Ku6QwkNhrBF/wvIu6ii7T0msYsmIh
         2teA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lIPthT51J+nIs48nl/QvpI3Ln3AY2S6u6ppS3XkUMwM=;
        b=paGQTNt4BWad2PsEWjQ1GhOE1O20fOQgx2+NEdD389CnbvXhf8lpHfBBvTFCZs6+Th
         Zh+xvaKByB85A2I6QTGTRewElMFqYZc+yrIZplh8HC+IHPy0Jx3r9E5Z5T4FsH7AG/UR
         iF8LM4aSgVHGQVU/V2Pzn8HoqFUqS45TjAFCH0vohsUEE1pUd3c7RIpFdXLubeRwokJc
         FIHCLlcG+fe2obXvvrPYTkWlimRMX+lthqLPY8wZrPRA7QLwSjoy16KKFQyx/dDWwqxU
         8bUfI1rN8qLPq+bYrHo6ehDrLZEm6sZ7JeC3JqVJxsI9x2Uv5swa45kMebe1IlwENh1V
         9F+Q==
X-Gm-Message-State: AOAM533Ga2cGPpTduqxnVJbYkATE1ReRQiJKoXukCRXYMe3dhANXvaSc
        xcD8NJy406pNrB2A8zBpKAUQLgDN7MZB
X-Google-Smtp-Source: ABdhPJwsf7neAAxO1z8gBsowskCoHbhgsUYl3UEiGSThsujkIogwftEA1DRC0UHx1iWXfw2Ebq84LUWTcvS+
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a7b:c18e:: with SMTP id
 y14mr495425wmi.1.1614697217407; Tue, 02 Mar 2021 07:00:17 -0800 (PST)
Date:   Tue,  2 Mar 2021 14:59:35 +0000
In-Reply-To: <20210302150002.3685113-1-qperret@google.com>
Message-Id: <20210302150002.3685113-6-qperret@google.com>
Mime-Version: 1.0
References: <20210302150002.3685113-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 05/32] KVM: arm64: Avoid free_page() in page-table allocator
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the KVM page-table allocator uses a mix of put_page() and
free_page() calls depending on the context even though page-allocation
is always achieved using variants of __get_free_page().

Make the code consistent by using put_page() throughout, and reduce the
memory management API surface used by the page-table code. This will
ease factoring out page-allocation from pgtable.c, which is a
pre-requisite to creating page-tables at EL2.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 4d177ce1d536..81fe032f34d1 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -413,7 +413,7 @@ int kvm_pgtable_hyp_init(struct kvm_pgtable *pgt, u32 va_bits)
 static int hyp_free_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 			   enum kvm_pgtable_walk_flags flag, void * const arg)
 {
-	free_page((unsigned long)kvm_pte_follow(*ptep));
+	put_page(virt_to_page(kvm_pte_follow(*ptep)));
 	return 0;
 }
 
@@ -425,7 +425,7 @@ void kvm_pgtable_hyp_destroy(struct kvm_pgtable *pgt)
 	};
 
 	WARN_ON(kvm_pgtable_walk(pgt, 0, BIT(pgt->ia_bits), &walker));
-	free_page((unsigned long)pgt->pgd);
+	put_page(virt_to_page(pgt->pgd));
 	pgt->pgd = NULL;
 }
 
@@ -577,7 +577,7 @@ static int stage2_map_walk_table_post(u64 addr, u64 end, u32 level,
 	if (!data->anchor)
 		return 0;
 
-	free_page((unsigned long)kvm_pte_follow(*ptep));
+	put_page(virt_to_page(kvm_pte_follow(*ptep)));
 	put_page(virt_to_page(ptep));
 
 	if (data->anchor == ptep) {
@@ -700,7 +700,7 @@ static int stage2_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 	}
 
 	if (childp)
-		free_page((unsigned long)childp);
+		put_page(virt_to_page(childp));
 
 	return 0;
 }
@@ -897,7 +897,7 @@ static int stage2_free_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 	put_page(virt_to_page(ptep));
 
 	if (kvm_pte_table(pte, level))
-		free_page((unsigned long)kvm_pte_follow(pte));
+		put_page(virt_to_page(kvm_pte_follow(pte)));
 
 	return 0;
 }
-- 
2.30.1.766.gb4fecdf3b7-goog

