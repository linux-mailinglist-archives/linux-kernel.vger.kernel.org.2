Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AED44FFB9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 09:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbhKOIJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:09:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39972 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236511AbhKOIGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:06:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636963420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l/H+oDixRZnd7dOwc6UEzkc+HkILBWlXcmJWYj576qI=;
        b=Y1s9AOV1hC8bG386KUBA9cXtrqX1p7Zaai4b97IcLsQDASy0U3jVfMegpJNEFLo6h4jPFg
        xpoqCcL/pZSl3oLAs+Ilv5KKMSImMbwrh6ckXiXkeXJ2KjqcKcrM6UoLTGjhONsTlph4H4
        +Z5RKg9Um/1AKtz9s6uXAV7TY2wNA+w=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-81H0PCD_N92lL5GEXbK-MQ-1; Mon, 15 Nov 2021 03:03:39 -0500
X-MC-Unique: 81H0PCD_N92lL5GEXbK-MQ-1
Received: by mail-pl1-f198.google.com with SMTP id s16-20020a170902ea1000b00142728c2ccaso5776908plg.23
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 00:03:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l/H+oDixRZnd7dOwc6UEzkc+HkILBWlXcmJWYj576qI=;
        b=aZdvBazyknXZDNJpFsrSKaBXH/OaVVQOOSkxqufk7Ont2bKRdSrMuPOrND2FXHY9Zg
         dp4V02JxCMGTbM7Dw791u2u4OB907TYch+hHf1GO76YVQMFRw+2mwOYqnQaXrW8dw1tA
         pfWEiRAhL05zLgtzdovQ8D4FGuau8kvPsESN2oZX1+41vPwLuA2I0kIxdhrWdh4eomox
         VgdDfGUDeFprCeyjV5KzDik7y1dFZVGyUPU1mQo4kYquwsVI0zUoYfNaa2BKGW9DkDA+
         yLUpX/qj1gBK64/RgLGYEZ0jRLzWIZXAYcgAl7l/84YaA3MIv8oa9MItRNSIvDcG+iXK
         AFIA==
X-Gm-Message-State: AOAM5310roNRp6b0mXxZp19wV+hMgN5ctj2dyHE/uvAG3KZfrNgtIL8Z
        VgfwW++dm0dxmk0QDyXX5vJpEsHKF32R5lpgBOgA5lSLJB0Nfd41cqzZhRxsdl2W9BYRajAFlH6
        Ly77WjflpUtM2qDczPqEYIYoa
X-Received: by 2002:a05:6a00:807:b0:49f:9a8d:23b4 with SMTP id m7-20020a056a00080700b0049f9a8d23b4mr30974706pfk.71.1636963417763;
        Mon, 15 Nov 2021 00:03:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7GarKkukoThonF99DLrh9L+TgpvqvwTOsDbfjBOYZ++8KkD2i4+zt+ZNLQP7HNUNlnOJUmQ==
X-Received: by 2002:a05:6a00:807:b0:49f:9a8d:23b4 with SMTP id m7-20020a056a00080700b0049f9a8d23b4mr30974675pfk.71.1636963417529;
        Mon, 15 Nov 2021 00:03:37 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.89])
        by smtp.gmail.com with ESMTPSA id il13sm15351105pjb.52.2021.11.15.00.03.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 00:03:37 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH v6 20/23] mm/pagemap: Recognize uffd-wp bit for shmem/hugetlbfs
Date:   Mon, 15 Nov 2021 16:03:23 +0800
Message-Id: <20211115080323.75209-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115075522.73795-1-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com>
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
 fs/proc/task_mmu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ad667dbc96f5..5d2f73b2e63d 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1390,6 +1390,12 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		flags |= PM_SWAP;
 		if (is_pfn_swap_entry(entry))
 			page = pfn_swap_entry_to_page(entry);
+		if (is_pte_marker_entry(entry)) {
+			pte_marker marker = pte_marker_get(entry);
+
+			if (marker & PTE_MARKER_UFFD_WP)
+				flags |= PM_UFFD_WP;
+		}
 	}
 
 	if (page && !PageAnon(page))
@@ -1523,10 +1529,15 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 		if (page_mapcount(page) == 1)
 			flags |= PM_MMAP_EXCLUSIVE;
 
+		if (huge_pte_uffd_wp(pte))
+			flags |= PM_UFFD_WP;
+
 		flags |= PM_PRESENT;
 		if (pm->show_pfn)
 			frame = pte_pfn(pte) +
 				((addr & ~hmask) >> PAGE_SHIFT);
+	} else if (pte_swp_uffd_wp_any(pte)) {
+		flags |= PM_UFFD_WP;
 	}
 
 	for (; addr != end; addr += PAGE_SIZE) {
-- 
2.32.0

