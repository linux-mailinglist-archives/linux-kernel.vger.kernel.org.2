Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DC9341947
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhCSKCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhCSKCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:02:01 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599A9C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:01 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id k92so28198246qva.20
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TccyldlGh8jyXKeMFND/Hm+ER293Gl9fJb4reK7MIeI=;
        b=aMJKsUpMZtoc6Vo/NUkiAkgYytwPwSWdxjtMAs/nwSVhtmr7fkCBs4zK4jrX9Yto1t
         74J9Oa4XC1AXlMHlxsjiWj0R+BJ/BW71UzD9HCCF5luXJ6jarXUOYwcVVJiF/gr8VTqx
         myolrurPb6MIli6tKDX09K3FlNugO6bAL+YGGRoS0if+l6Ke09o0IeRRed9bXZwdSsc7
         2NpwMa0ikNeXDOX4HRkuwwDYa/uvCiM4/rq5BHexXiim5y6aSnWh0wLRHXcKZAqE+7je
         7ENBURMGCufhIVy84m7LAuCtnB/TvZ8pLGRbR8xZBGQYsyFEAC6sVdPK5f6txbQ0Em3n
         Rliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TccyldlGh8jyXKeMFND/Hm+ER293Gl9fJb4reK7MIeI=;
        b=A8a4IjBd81PbCkRmn6hMxPs3K3i4+tt8YTH9KtvJS24qkY94Hon5vExv3OzAQVJD67
         /R5FWJ3WTekaqLxamD9SY2VSmombk2jSF7Ufblkm0zXEHJRppmct2F3OEhnphN3LerdD
         VfadU0LNFFtFJQPYsC6noSpQeQa8t8xrQTvn4ESymGnUC62M4gma59A0XQPcMXZTEmsW
         TdCnLSvvRf0gJTdIti4wyiY9l8nuyYb3A00vHwgGkzbPRv4byBXZS6HR7M4LkgG4cdsl
         tcFQ75u6D+bFG22ncilFvNycMSq4GDouuG9+2PeVrn1zrhY8h9RkWAIciSLvQIyRFFwi
         S2rg==
X-Gm-Message-State: AOAM532WykAE0tkv3FVFdhkVp/yMVDJD1NGcgPa9NmOmiilqBJssKKNs
        u6PAiA0HD17ht+gRQr2bKpJ9KvneINyv
X-Google-Smtp-Source: ABdhPJyAfHPltOr6Ii1E0fGpZSgU/xa1c+709JNQ28p9DHhYeGy8ayWuxcmcxY1y7/l8XTGyuuWxYQ0eD4Sf
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:df02:: with SMTP id
 g2mr8475100qvl.40.1616148120563; Fri, 19 Mar 2021 03:02:00 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:13 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-6-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 05/38] KVM: arm64: Avoid free_page() in page-table allocator
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
index 926fc07074f5..0990fda19198 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -414,7 +414,7 @@ int kvm_pgtable_hyp_init(struct kvm_pgtable *pgt, u32 va_bits)
 static int hyp_free_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 			   enum kvm_pgtable_walk_flags flag, void * const arg)
 {
-	free_page((unsigned long)kvm_pte_follow(*ptep));
+	put_page(virt_to_page(kvm_pte_follow(*ptep)));
 	return 0;
 }
 
@@ -426,7 +426,7 @@ void kvm_pgtable_hyp_destroy(struct kvm_pgtable *pgt)
 	};
 
 	WARN_ON(kvm_pgtable_walk(pgt, 0, BIT(pgt->ia_bits), &walker));
-	free_page((unsigned long)pgt->pgd);
+	put_page(virt_to_page(pgt->pgd));
 	pgt->pgd = NULL;
 }
 
@@ -578,7 +578,7 @@ static int stage2_map_walk_table_post(u64 addr, u64 end, u32 level,
 	if (!data->anchor)
 		return 0;
 
-	free_page((unsigned long)kvm_pte_follow(*ptep));
+	put_page(virt_to_page(kvm_pte_follow(*ptep)));
 	put_page(virt_to_page(ptep));
 
 	if (data->anchor == ptep) {
@@ -701,7 +701,7 @@ static int stage2_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 	}
 
 	if (childp)
-		free_page((unsigned long)childp);
+		put_page(virt_to_page(childp));
 
 	return 0;
 }
@@ -898,7 +898,7 @@ static int stage2_free_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 	put_page(virt_to_page(ptep));
 
 	if (kvm_pte_table(pte, level))
-		free_page((unsigned long)kvm_pte_follow(pte));
+		put_page(virt_to_page(kvm_pte_follow(pte)));
 
 	return 0;
 }
-- 
2.31.0.rc2.261.g7f71774620-goog

