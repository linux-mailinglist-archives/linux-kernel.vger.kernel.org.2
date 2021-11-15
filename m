Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD6744FFA3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 09:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbhKOIFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:05:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43618 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234884AbhKOIEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636963309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3JN/qHWTDj3qXyIKJcMZC7BazoBUZifDcHVBgdG1ZHs=;
        b=fFT1/TiTKIKN5R0Uh1RT28Y4G2M35wca/BVV6V2KbgOKsyKBw+tmykwnK6WamJFy+EiUvx
        NW99+MG08ZERJCZYyfSTjlMhFJ6DH4Rpy22IXMbIamEwczHH5m31YNPJDevg2OsS5aJKyc
        bP6XvHz5YPT6po0CCtCyZrUoJfZrb5g=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-vxrWgQMmM9CxwYW0E1lx_g-1; Mon, 15 Nov 2021 03:01:47 -0500
X-MC-Unique: vxrWgQMmM9CxwYW0E1lx_g-1
Received: by mail-pj1-f72.google.com with SMTP id r23-20020a17090a941700b001a74be6cf80so4879480pjo.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 00:01:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3JN/qHWTDj3qXyIKJcMZC7BazoBUZifDcHVBgdG1ZHs=;
        b=LiDn6ChbQA1JUf++G4v5enmRhmeVi6HZocMxNpl1pi1r/j/d+ZD0aTRCIZB4Hk3F2J
         umYlx4SThj34G8dStY/96ogglZhmPmTIiVfZkWDBhx5W9/Rd4BphFblYLymAzNkZG2hD
         1ufYy7DEm2wLaRPxLpBJjip9SlOUHmAFiTMpSxQKdHCvoiLHaV+TP3BT/9J0pokbQNwu
         jOyoN+DHgvr640eKuiQkRP0VEdWqwsbZzwrxYlZ8ZLNuYONHQjDpKXKbe6u5yqhtb5il
         5sJypH5G2JV/FhIlFqp6XC0JF3V34RaFyyaqqKF4oWZD1mrWuAHn5d16h6WN68un99R1
         jfJQ==
X-Gm-Message-State: AOAM531UddGapqfzQ2lsbuZJm3/WE4yUkoG2TmW5A/cnzj/MDiaVoIne
        HebmD+TpOZGT9NbEPqgEhupKX+6TamOZoOn4Pe2nUCb1ZJALoPC0AH+bCikRPAbMX+AVNTs5JvR
        dwEcwHpiJuOIhSjFgLFbFAsok
X-Received: by 2002:a65:4c01:: with SMTP id u1mr23373802pgq.151.1636963306583;
        Mon, 15 Nov 2021 00:01:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxAqokYq6ooU4nDXInwG5sxx6pe6ho32Uv0rSbhETu3lnvghB2QdRC5YvCrwwuikrQwoQlTpg==
X-Received: by 2002:a65:4c01:: with SMTP id u1mr23373775pgq.151.1636963306345;
        Mon, 15 Nov 2021 00:01:46 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.89])
        by smtp.gmail.com with ESMTPSA id f130sm14450402pfa.81.2021.11.15.00.01.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 00:01:45 -0800 (PST)
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
Subject: [PATCH v6 12/23] mm/hugetlb: Hook page faults for uffd write protection
Date:   Mon, 15 Nov 2021 16:01:32 +0800
Message-Id: <20211115080132.74754-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115075522.73795-1-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hook up hugetlbfs_fault() with the capability to handle userfaultfd-wp faults.

We do this slightly earlier than hugetlb_cow() so that we can avoid taking some
extra locks that we definitely don't need.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e09159c957e3..3a10274b2e39 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5658,6 +5658,25 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (unlikely(!pte_same(entry, huge_ptep_get(ptep))))
 		goto out_ptl;
 
+	/* Handle userfault-wp first, before trying to lock more pages */
+	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(ptep)) &&
+	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
+		struct vm_fault vmf = {
+			.vma = vma,
+			.address = haddr,
+			.flags = flags,
+		};
+
+		spin_unlock(ptl);
+		if (pagecache_page) {
+			unlock_page(pagecache_page);
+			put_page(pagecache_page);
+		}
+		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+		i_mmap_unlock_read(mapping);
+		return handle_userfault(&vmf, VM_UFFD_WP);
+	}
+
 	/*
 	 * hugetlb_cow() requires page locks of pte_page(entry) and
 	 * pagecache_page, so here we need take the former one
-- 
2.32.0

