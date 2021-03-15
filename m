Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9564F33BF01
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241587AbhCOOwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237111AbhCOOgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:36:14 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F62FC061765
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:35:52 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id i5so15188808wrp.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XM9Fqo9BFURTmcHtiI6lmQ6Zl1fY1T+F2S1cS3+zeUo=;
        b=bKIIrxzhrczRyndajmokRMPtSQEcu111oQ9npGw7bv47pkRLemXtMvq2xN5IA1Aazi
         Ve0fnnavrRoBroulLIEYvCdbI+rkDswIW/n81LueYuK7CcZyMiFXX7U4oSYVdFEosFVO
         4XDSOgSw7gCG/kU4oeUYSRSQoLezMQ+UwrReoibt2dY+MxmCc+RvGbVpjPdSsoW8VLzj
         iFZBZlyR8MGLq1rQuv2SibuG3kjnxzYISkCwTYfxQPReIZ2cwW+ihzzADXECtDCYqPWA
         Gii9VDQBgd45ZTkbNe558j9x0S9QG2jCoPdSr79fzn2jVoDPjMVZFLOK8JKloJGNd08Y
         SqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XM9Fqo9BFURTmcHtiI6lmQ6Zl1fY1T+F2S1cS3+zeUo=;
        b=cH2AK5g+AWQ2r5nZH8Mxu7iMJSEMMkuPt0fq825ibGlODKQ+GJpQC79kJo/6oJWUJu
         GmsxUtgETtI/A7OPbMEq7084L/kKvlvfTZVBTQKyt1BYiXC38QuC9ZrUL8J0mjGcOeCS
         EyIpbMpTsZE9hsgfGtIAPLXcmPj80yl72IWQq1aEPSrxI21Wcqabw/7tHcGTVpCqgfIO
         n9LCrs/d4ukvIUwwrqavs9NYgAS6K5Qk3KujOi0pUaHgknptrEUPRlkdMMsWQpSzyQwI
         R90rl9b7KR6twMHTIN2RM0Gat+ZXb+PooP5b+khbl1gTya79BfRGW84g+DnQU42wc9IH
         gh1w==
X-Gm-Message-State: AOAM532VXP25a7GGHF+2+YM9liP5D2J8rdkvYI9cCxkRE3DImXsP/8i/
        nJPJUgtRRI0q8DtgVUoSrbuu1lGFyFa+
X-Google-Smtp-Source: ABdhPJyH7PRqGoLoUvKE1E9rOxfevMyBMCizkYPSX3DRJyQ4kkfYKppPwBjw5T8gP92kUTM7iCiidaEXdjph
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:43c5:: with SMTP id
 q188mr28699wma.94.1615818951131; Mon, 15 Mar 2021 07:35:51 -0700 (PDT)
Date:   Mon, 15 Mar 2021 14:35:05 +0000
In-Reply-To: <20210315143536.214621-1-qperret@google.com>
Message-Id: <20210315143536.214621-6-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v5 05/36] KVM: arm64: Avoid free_page() in page-table allocator
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, qperret@google.com
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
2.31.0.rc2.261.g7f71774620-goog

