Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047DA3CADC4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244673AbhGOUUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:20:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27407 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240371AbhGOUUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626380228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d+qr2gkGCf8UGCRyFBArhsHy6tP5+E2Jys4dwvbHGGg=;
        b=aMUCSUZKp9d3uUGZ6vWY978dOOAy+ffWs+7XwEPj/S/jSfyH3OY/yLHMQYCmI8l4CnYORg
        Z/6qAvYuOA4kbelwQk79CCiUA9v+MJ577lqa33hs/dLoHyS28+rl3VWgvbs2tZKJOYx6o5
        JbFHPWV+IFX/QSj083mcCu8rIHqHvwc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-2oebktaONf2-jIhSKPTtNw-1; Thu, 15 Jul 2021 16:16:56 -0400
X-MC-Unique: 2oebktaONf2-jIhSKPTtNw-1
Received: by mail-qk1-f200.google.com with SMTP id y5-20020a37af050000b02903a9c3f8b89fso4709246qke.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 13:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d+qr2gkGCf8UGCRyFBArhsHy6tP5+E2Jys4dwvbHGGg=;
        b=Edp6gdq69jK2LrKYv1k5lrugagWfwjYs0GBXof9IcH3w1VYN8gYjjl+BnJukcwJJWr
         F3GbtCvqohLN7aKca1FoBv0Cmhzduelg2yRfwqbGlAcWYKCYqZk9wqiBNlJ9Gn25qK/y
         LuqE93S6OGBwS9MtnMI8e4hjCci7UJ5BsUPP5MSGby1dRqrESuElt+nyeKRKKBDrg81t
         bYcmbH8Hs8c3L75nmUsiCpZqRo/L0v3pKQjH1lpKRlCrA3b6cbyAZL0eH0hO3Zt/GHi3
         5ebpmikv0Ae7WEzMqsokLHP/tq76tZ25d+P7ElEiLiOYBm8QxRKOnWNttdRvM6FiATgk
         MsHQ==
X-Gm-Message-State: AOAM533X7vB/WHyk49t+SFicK1ZVobmSR+dc/feGgd/hD3uuo5bJc6gc
        5R/5YI6eizg3Hj653PoCTTfGBZ1qUg8b6l0EAggjyf7/tQ3lCZTEZYDlBl/LMEopgwhPQ9Dzvbj
        8WFrjlJDZmfpf+teXNtNQtnhlad0Ns/Ti0Zzpb98vVFFQii0hw73zTwYcCXJhGN77bjzheQtJPg
        ==
X-Received: by 2002:ac8:7690:: with SMTP id g16mr5672239qtr.221.1626380215170;
        Thu, 15 Jul 2021 13:16:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3n2A17eCVd0ShKH2hDWtxhMPVbHnKs9Bym1cK2+XbUnXj4wDOYY9VEDs7W8nbrHHR4ZqZjA==
X-Received: by 2002:ac8:7690:: with SMTP id g16mr5672205qtr.221.1626380214903;
        Thu, 15 Jul 2021 13:16:54 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id w185sm2965820qkd.30.2021.07.15.13.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 13:16:54 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v5 24/26] mm/pagemap: Recognize uffd-wp bit for shmem/hugetlbfs
Date:   Thu, 15 Jul 2021 16:16:51 -0400
Message-Id: <20210715201651.212134-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715201422.211004-1-peterx@redhat.com>
References: <20210715201422.211004-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This requires the pagemap code to be able to recognize the newly introduced
swap special pte for uffd-wp, meanwhile the general case for hugetlb that we
recently start to support.  It should make pagemap uffd-wp support complete.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/proc/task_mmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 9c5af77b5290..988e29fa1f00 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1389,6 +1389,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		flags |= PM_SWAP;
 		if (is_pfn_swap_entry(entry))
 			page = pfn_swap_entry_to_page(entry);
+	} else if (pte_swp_uffd_wp_special(pte)) {
+		flags |= PM_UFFD_WP;
 	}
 
 	if (page && !PageAnon(page))
@@ -1522,10 +1524,15 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 		if (page_mapcount(page) == 1)
 			flags |= PM_MMAP_EXCLUSIVE;
 
+		if (huge_pte_uffd_wp(pte))
+			flags |= PM_UFFD_WP;
+
 		flags |= PM_PRESENT;
 		if (pm->show_pfn)
 			frame = pte_pfn(pte) +
 				((addr & ~hmask) >> PAGE_SHIFT);
+	} else if (pte_swp_uffd_wp_special(pte)) {
+		flags |= PM_UFFD_WP;
 	}
 
 	for (; addr != end; addr += PAGE_SIZE) {
-- 
2.31.1

