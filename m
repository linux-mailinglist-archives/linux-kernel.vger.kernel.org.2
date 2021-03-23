Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD43345437
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhCWAvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:51:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60101 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231426AbhCWAtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616460591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KeJZGTpGOrohXVCCKtDdkXfVwkpCkyHGurO1opmnjl4=;
        b=IPa9IM+DyU+yXcsxrAzaZvJptb6t7WVitBhNy8tTyv/J8xUEsGvzg73lgKHaxjE01RoY2S
        jfGBM6zu0w4+wd1JHI7kbZ1OZmoeHWFXES2VqYk95TT7OUfYFS30/ZvfmDWH75hc8f61c4
        402HoGHCHRGieu2JxX9H3Km7T/Je774=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-IQsj7RS7MG65dpM7jPw-6g-1; Mon, 22 Mar 2021 20:49:50 -0400
X-MC-Unique: IQsj7RS7MG65dpM7jPw-6g-1
Received: by mail-qv1-f69.google.com with SMTP id z5so546830qvo.16
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KeJZGTpGOrohXVCCKtDdkXfVwkpCkyHGurO1opmnjl4=;
        b=FWJWKqDPAew4gcD/ppTqIrhwc2qfCQ3+tGJHZKuNEktxhVUnR+osDf2EEnV+InaEXk
         a2lX/+fMOha0Q5aRr2CE1jDMQJapDGaXhAmCC0rdteLODAJdbiFI07Gryk0n//W6QNiL
         ECpBOwFovHtpg50i68O1JkXWrEkyYHoNLF8cvcrUX4cZ32eYkA9D22SPhWSHWkoO2nYu
         KrDFBBpQN3cQ5S3s/L8phGdRSFBxHf6hRLrurrqjK/z3Bht4DacfZI0q7EAFHRUNVq2r
         jNCOFvE5Zz4QwfG5f1SRAPlo9iicq0syjlafzSiCEvU5sAHBN0S/UHYey8qmH/xM3acQ
         d6wA==
X-Gm-Message-State: AOAM532ENujRT3gxZz/Jdg+np2JKdYUX5aA6BP2PB1IjujtIWGaLVgXx
        oBWaqyQ14rIWGIsPvEi7Qf81Ku6RpXWABW6hgepoakNOJDvb6WOGDsC9B5C6wuzWaVI/esai2Cz
        ID0DJ9SP6Pigs7+XT+WTiA1YlTA6NIRaOO4xpbI1DNQpAk2ld0PG8C/Z0ItxhSaGa03rwM0P9Lw
        ==
X-Received: by 2002:a37:e16:: with SMTP id 22mr2917219qko.145.1616460586674;
        Mon, 22 Mar 2021 17:49:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxy6w3/RokxBsgJvQlCDPweOOic+hnNCwhRCQU36ubzi7Ex7In6XJ0GzrQwMBBQ4/ZcsoaITQ==
X-Received: by 2002:a37:e16:: with SMTP id 22mr2917181qko.145.1616460586282;
        Mon, 22 Mar 2021 17:49:46 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id n6sm5031793qtx.22.2021.03.22.17.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:49:45 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 18/23] mm/hugetlb: Introduce huge version of special swap pte helpers
Date:   Mon, 22 Mar 2021 20:49:07 -0400
Message-Id: <20210323004912.35132-19-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210323004912.35132-1-peterx@redhat.com>
References: <20210323004912.35132-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to let hugetlbfs be prepared to also recognize swap special ptes just
like uffd-wp special swap ptes.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fd3e87517e10..64e424b03774 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -93,6 +93,25 @@ static inline bool subpool_is_free(struct hugepage_subpool *spool)
 	return true;
 }
 
+/*
+ * These are sister versions of is_swap_pte() and pte_has_swap_entry().  We
+ * need standalone ones because huge_pte_none() is handled differently from
+ * pte_none().  For more information, please refer to comments above
+ * is_swap_pte() and pte_has_swap_entry().
+ *
+ * Here we directly reuse the pte level of swap special ptes, for example, the
+ * pte_swp_uffd_wp_special().  It just stands for a huge page rather than a
+ * small page for hugetlbfs pages.
+ */
+static inline bool is_huge_swap_pte(pte_t pte)
+{
+	return !huge_pte_none(pte) && !pte_present(pte);
+}
+static inline bool huge_pte_has_swap_entry(pte_t pte)
+{
+	return is_huge_swap_pte(pte) && !is_swap_special_pte(pte);
+}
+
 static inline void unlock_or_release_subpool(struct hugepage_subpool *spool)
 {
 	spin_unlock(&spool->lock);
@@ -3726,7 +3745,7 @@ bool is_hugetlb_entry_migration(pte_t pte)
 {
 	swp_entry_t swp;
 
-	if (huge_pte_none(pte) || pte_present(pte))
+	if (!huge_pte_has_swap_entry(pte))
 		return false;
 	swp = pte_to_swp_entry(pte);
 	if (is_migration_entry(swp))
@@ -3739,7 +3758,7 @@ static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
 {
 	swp_entry_t swp;
 
-	if (huge_pte_none(pte) || pte_present(pte))
+	if (!huge_pte_has_swap_entry(pte))
 		return false;
 	swp = pte_to_swp_entry(pte);
 	if (is_hwpoison_entry(swp))
-- 
2.26.2

