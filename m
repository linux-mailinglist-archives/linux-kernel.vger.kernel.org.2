Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA843C93C4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbhGNW15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:27:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32085 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235716AbhGNW14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626301503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pgOZ+9IjwVfKb5tKhAxRusG1z8GoeGAv34cmBph/B3s=;
        b=fNWVSmgh45wBt2Cyt31RGD5DCfcx6EYGI+4Mbb50PiB6J6DCBKb5ErCWW187Q+j1bSz20W
        bIBgL8d3KpaMxObJpLMQj1UfhjDv0QDcrj31MqCwY8R9NiE9BU1IJ9ZkPxYg5RV2UpWsSA
        ZmdYsHqYbnsmwHY+FlaiZFJCj14lGQE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-gIaLPR-lOfmpUXS57lEcTQ-1; Wed, 14 Jul 2021 18:25:02 -0400
X-MC-Unique: gIaLPR-lOfmpUXS57lEcTQ-1
Received: by mail-qv1-f72.google.com with SMTP id u8-20020a0562141c08b02902e82df307f0so2712846qvc.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pgOZ+9IjwVfKb5tKhAxRusG1z8GoeGAv34cmBph/B3s=;
        b=TOkvV1lwBgXvg9PLcvh6SAzS15So2devs3i0FxAuIX277WylVPJcMxGep7QM9lJtgP
         G6dqHdYxbIWHUaiLOP7ATrfv97/6SvHTkKFQw2UhPuRl4dWkv/QatGVfgUIEPbnbsFre
         PPJKIKZxmaVzRk48U3bIGaO5kwVACz7PCcuqqIWp0hzQbVnXOSLQ6cSgGtig1zRB72Iy
         mo8YechkCYji80K1gDGPIySf50KIEfLutQbMFtkLMy9g2WUXDfW5g5MfNSDKQcWzT+0A
         o65m7cy9fZTZHWEiEErSu3SrAQSr1XTHrLBjLpIGNfHMpTnzzF9gtPhA/iFV0bpQztFP
         KfKQ==
X-Gm-Message-State: AOAM531fk9FFkVzfm3+e8RYJxF+iWCFbU2u8u5SwdpdRPK+W5870C9e2
        zXVGKvadhZfZEbbl5l2/pENEv2h7TCPaSRxcJx1xn7PeJP9KPjumrQzo3u2itM/Ahtp8W33E6rz
        stHCDJqS6129rx/o7QW9hE7cE
X-Received: by 2002:ac8:5ac3:: with SMTP id d3mr318883qtd.257.1626301502381;
        Wed, 14 Jul 2021 15:25:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmUP5TjPEpwzMNS3GOKkC/oUMalgKy2Zc3e2y7pAB8MiTJNFhofDrLUpO66BNt/9fBL+Yu3A==
X-Received: by 2002:ac8:5ac3:: with SMTP id d3mr318869qtd.257.1626301502188;
        Wed, 14 Jul 2021 15:25:02 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id o126sm1606702qka.74.2021.07.14.15.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:25:01 -0700 (PDT)
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
Subject: [PATCH v4 17/26] hugetlb/userfaultfd: Hook page faults for uffd write protection
Date:   Wed, 14 Jul 2021 18:24:58 -0400
Message-Id: <20210714222458.48942-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714222117.47648-1-peterx@redhat.com>
References: <20210714222117.47648-1-peterx@redhat.com>
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
index 924553aa8f78..8559b8bb7fa5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5059,6 +5059,25 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
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
2.31.1

