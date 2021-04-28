Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905CD36E1E0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 01:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240153AbhD1WwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 18:52:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60868 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240067AbhD1WwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 18:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619650281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qqKszEE/+R68ngYo71RnOXLGHoNHIK32QNLimL1RNSc=;
        b=GDMJOeJn927RmOwLZZHKwEFHxxXNm8RUIrDFWf9BjfVPkCURkUgocz2EpU1on0iD1zN/M+
        mVu2yTvVbM2ChdrRSqvBWg4/i9QVfA6oPzfHDvZ9BaVmhP9/EsyP9Q3yD7EsMFU7ME18XX
        I4C91Y8XGDMC+fgCKUm29ktdc1twtu8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-l9C5p_EkOh-CnaezUnlnrQ-1; Wed, 28 Apr 2021 18:51:19 -0400
X-MC-Unique: l9C5p_EkOh-CnaezUnlnrQ-1
Received: by mail-qv1-f71.google.com with SMTP id x15-20020a0ce0cf0000b029019cb3e75c62so29307986qvk.15
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 15:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qqKszEE/+R68ngYo71RnOXLGHoNHIK32QNLimL1RNSc=;
        b=WMOB6eZKRmKxTeyMjHzVv6GJdyThAFKzMD9EJdTk6CD/pUlALVWG1l8EItN7ixB8Na
         nO3ujDqo/GcANot9SwrAJDVAyFVwVvsnxOSj/3LUilEYNdlSGIAXGZbUAEEKc1ORb0J5
         eowXOLH0kDaSrnYLWfsCjxqQGdyyxbsHBs8uZeJvV4jJd5SwS2etYqUE/qmJEBzm1zI/
         dSRgnMoGICtD8Xy3hSUJBiSqN0C93Db0nSb85QZBYP4gomNrLk0Y8WFMtodZJZtCAj0D
         lQWL/4iU55+7M4AEsU/u+a6LsCmYfoJhAR3yYeb/VE6JW+EkokDaijrs/YOosVlfErNd
         6sRQ==
X-Gm-Message-State: AOAM531f0VKudQY9YoU92+l6S20070wbP4ym5iPm00viRu+HfN8Ki/on
        tFPjR/BmDYdIzJ7M5CO53ts/x/woPbuaiH4rRJv8HlubaSpEAfZ+qg/Eve792OZn5yZdnpBADD7
        3YM7WztvsOLvL5fXyf9KvA+iq
X-Received: by 2002:a05:622a:94:: with SMTP id o20mr29753492qtw.158.1619650278385;
        Wed, 28 Apr 2021 15:51:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziX7HpqcsgsbqQA9N4s/mqNOzeFKuNqQnRXLynrFsn+2UQuu62PHd5dx6d2x3VzOCu4IwPXQ==
X-Received: by 2002:a05:622a:94:: with SMTP id o20mr29753476qtw.158.1619650278187;
        Wed, 28 Apr 2021 15:51:18 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id 191sm897459qkk.31.2021.04.28.15.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 15:51:17 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>
Subject: [PATCH 3/6] mm/userfaultfd: Fix a few thp pmd missing uffd-wp bit
Date:   Wed, 28 Apr 2021 18:50:27 -0400
Message-Id: <20210428225030.9708-4-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210428225030.9708-1-peterx@redhat.com>
References: <20210428225030.9708-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These include:

  1. When remove migration pmd entry, should keep the uffd-wp bit from swap
     pte.  Note that we need to do this after setting write bit just in case we
     need to remove it.

  2. When change huge pmd and convert write -> read migration entry, persist
     the same uffd-wp bit.

  3. When convert pmd to swap entry, should drop the uffd-wp bit always.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/swapops.h | 2 ++
 mm/huge_memory.c        | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index d9b7c9132c2f6..7dd57303bb0c3 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -258,6 +258,8 @@ static inline swp_entry_t pmd_to_swp_entry(pmd_t pmd)
 
 	if (pmd_swp_soft_dirty(pmd))
 		pmd = pmd_swp_clear_soft_dirty(pmd);
+	if (pmd_swp_uffd_wp(pmd))
+		pmd = pmd_swp_clear_uffd_wp(pmd);
 	arch_entry = __pmd_to_swp_entry(pmd);
 	return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 20a4569895254..e6423fe11a8f2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1823,6 +1823,8 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 			newpmd = swp_entry_to_pmd(entry);
 			if (pmd_swp_soft_dirty(*pmd))
 				newpmd = pmd_swp_mksoft_dirty(newpmd);
+			if (pmd_swp_uffd_wp(*pmd))
+				newpmd = pmd_swp_mkuffd_wp(newpmd);
 			set_pmd_at(mm, addr, pmd, newpmd);
 		}
 		goto unlock;
@@ -3234,6 +3236,8 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 		pmde = pmd_mksoft_dirty(pmde);
 	if (is_write_migration_entry(entry))
 		pmde = maybe_pmd_mkwrite(pmde, vma);
+	if (pmd_swp_uffd_wp(*pvmw->pmd))
+		pmde = pmd_wrprotect(pmd_mkuffd_wp(pmde));
 
 	flush_cache_range(vma, mmun_start, mmun_start + HPAGE_PMD_SIZE);
 	if (PageAnon(new))
-- 
2.26.2

