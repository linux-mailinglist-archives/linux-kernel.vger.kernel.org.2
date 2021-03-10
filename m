Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0D33345F9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbhCJR6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbhCJR6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:58:06 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019B4C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:06 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id jx11so13222256qvb.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lIPthT51J+nIs48nl/QvpI3Ln3AY2S6u6ppS3XkUMwM=;
        b=fHBfJM8xzLAclGXEjFaYJ5Rhln578wLzMWoSnqk9psHRaDBuLXBcARc1NhvK6zE3B1
         cI2osMD4eClmpEaY1HG2sFX5g274O4sHptREG3EHY7jDQs+EYJD+eX0AZ/hpzN3YLGmp
         Y8QjFoJ1rGBijnkcrGc5QF/tGIGHoU258V1+/DMXbn9XDFr8KvWBiqDs4JlKA1EZ5Teb
         9WPr3djabjTTnmuikYjQMgMjSzAxUvjpbqNOPWa0DZKjuxX5BUxiVqEBXB2KVvBeDAsg
         ffEpVSe+BFI6nvd6tRs+1g4UntXEnAu0/1UiOLszmNy6hb6AU8I4J4elFWEdhdROrc2Y
         3yTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lIPthT51J+nIs48nl/QvpI3Ln3AY2S6u6ppS3XkUMwM=;
        b=YRNmi2ZmFcI6LS7fYiaTIntGvVUBZ6jRKTZe5Ck3W1rZhCTO/kOhvIWKsmCK7gMbmQ
         gZ5fdyz5rrpKfAHyY1WQ3BEVKYkRSIFwgHIGL0Edq/YTSDRoCC+pX8UB966y06znS6vn
         CLLV6soVBOv0ToB3YY9M38ZMPNT5FushshOQD2DgLd4F0ch2YuSP+UFRQBr3lwIs1urx
         cxJaLfcnhgdaXYWeRMoMoU+Cm2+4UI1TF7NE+wEeUWGqTLhrUywycl9AASzVZLNnwX+I
         F5UzhLT7K48vtJkUa94w4onk3OCWg4ZAtdyQMyxF5KYJmBtyKxQ6y3xc0btYC+2X8H85
         g5DA==
X-Gm-Message-State: AOAM530rh4f5Zi5y9pqEhDFotuj3Hl5NWiCqF1qLtbJYT4gRebMcnX/l
        NmEdVei1WsQcjDBv+MJOChlMdCapi7pt
X-Google-Smtp-Source: ABdhPJz0tdSYBeivnJPeagi2ze/9rhhZHyfPUL0XortI6Q0zqZ15QP96f7jyHF9BhRekOYOtkNSCxsIk+TrK
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:c60b:: with SMTP id
 v11mr4064868qvi.44.1615399085165; Wed, 10 Mar 2021 09:58:05 -0800 (PST)
Date:   Wed, 10 Mar 2021 17:57:22 +0000
In-Reply-To: <20210310175751.3320106-1-qperret@google.com>
Message-Id: <20210310175751.3320106-6-qperret@google.com>
Mime-Version: 1.0
References: <20210310175751.3320106-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 05/34] KVM: arm64: Avoid free_page() in page-table allocator
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org,
        ardb@kernel.org
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

