Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83ACB3C93CC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbhGNW2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:28:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60555 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237053AbhGNW2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626301517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FG94X/udzrS/4H8a9ROacZylO2qMwKMDk77nG92mz5U=;
        b=V5NvnBbMatarJnJkPgfJQUI5bT4T4H9L7z6TXn1VOhhuIR3lHS5rbNCcXUcLKFgA1c/AX9
        BIksg8LrIZy5RecYrzvTingoLlikDenari5A7Djg57mVghJos4HhOn2EGcktyvJ7oJM7kS
        nhkiCq9TvgZZINvEEJkwrWbTdl1Qhxs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-3RsbBXKEMkWhC3i6rYffHA-1; Wed, 14 Jul 2021 18:25:15 -0400
X-MC-Unique: 3RsbBXKEMkWhC3i6rYffHA-1
Received: by mail-qk1-f198.google.com with SMTP id c3-20020a37b3030000b02903ad0001a2e8so2332630qkf.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FG94X/udzrS/4H8a9ROacZylO2qMwKMDk77nG92mz5U=;
        b=Eo7rgYCMDwFmHt/GlQA6OWHLSs2vm/2WJZR64rs/qqGj4bMp9cuBW7aIO9iM6l018z
         ardNlwUGGhqoTcb2egFb4r8D/5DmD0vpmODVquTMbfjlMswbNibzXQr9H0G4F8PBv+8N
         TAHwc0M9NzhRwxvCzKgCAZe5AQ+UPXolXmDCgRhwitcbWMaP/sqQRO5JXZ4TkEyOKl2s
         wHQ7SgazUk8g7Ul1kgwnpoB40paPpI2cuYSsUZjvnr/xLbGZWp4auknfipeyogJ9ETU4
         XBQWr01P8tMWwbsLlwqODrQvgmmA6A/TVwq5jBw178WDc2JaUqcpT76GOHHuWJef8hTr
         dCXA==
X-Gm-Message-State: AOAM530zlfmslRSYSfEV9hmZrMFBzZfWz2Jz0UgzdPVg8xupOEcZU4XW
        ZRIqv2wghcsBYEm021jngRBJtgGNbdgdBb5JVJGkS2MajjL7h77ooQJErYXhpF5K3+o7PIjt2a4
        4aUVzboeT/ARaSgkTVEk6h12e
X-Received: by 2002:ac8:4e95:: with SMTP id 21mr342276qtp.234.1626301515492;
        Wed, 14 Jul 2021 15:25:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXR+Vu/+o0F5Ebn+71mCKuvUYN3/uYB7J35r5bAygeXC05i/PyQzKZDPriZMgwiauQ0WseFw==
X-Received: by 2002:ac8:4e95:: with SMTP id 21mr342258qtp.234.1626301515288;
        Wed, 14 Jul 2021 15:25:15 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id f62sm1662862qke.135.2021.07.14.15.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:25:14 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 20/26] mm/hugetlb: Introduce huge version of special swap pte helpers
Date:   Wed, 14 Jul 2021 18:25:11 -0400
Message-Id: <20210714222511.49094-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714222117.47648-1-peterx@redhat.com>
References: <20210714222117.47648-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to let hugetlbfs be prepared to also recognize swap special ptes just
like uffd-wp special swap ptes.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7d3558265b6f..6a66b598245e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -95,6 +95,26 @@ static inline bool subpool_is_free(struct hugepage_subpool *spool)
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
+
+static inline bool huge_pte_has_swap_entry(pte_t pte)
+{
+	return is_huge_swap_pte(pte) && !is_swap_special_pte(pte);
+}
+
 static inline void unlock_or_release_subpool(struct hugepage_subpool *spool,
 						unsigned long irq_flags)
 {
@@ -4138,7 +4158,7 @@ bool is_hugetlb_entry_migration(pte_t pte)
 {
 	swp_entry_t swp;
 
-	if (huge_pte_none(pte) || pte_present(pte))
+	if (!huge_pte_has_swap_entry(pte))
 		return false;
 	swp = pte_to_swp_entry(pte);
 	if (is_migration_entry(swp))
@@ -4151,7 +4171,7 @@ static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
 {
 	swp_entry_t swp;
 
-	if (huge_pte_none(pte) || pte_present(pte))
+	if (!huge_pte_has_swap_entry(pte))
 		return false;
 	swp = pte_to_swp_entry(pte);
 	if (is_hwpoison_entry(swp))
-- 
2.31.1

