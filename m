Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690C736C955
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbhD0QYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:24:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47657 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237655AbhD0QQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619540155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h4WOl7CIm3ueQ8RREsb6vElg27yEJH2OFi487xgNXDI=;
        b=hP3C3/iQk10UvGTfsXhduC3csSiDU3y5EDEus8ih3DlO1aid63wb+wo2VzLIm0SHkxuiUO
        l/xfYeu8LsPyxsql3LH7yb3u4isgf7Qr/0vgnHJI4xkEFriPxiqHEiZr3D9NhgTD+9KaGH
        5NaJLZCBI1T/pSdUQHN6ADwdYLV2gLs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-PrlsCsOcMemV_e4EguPhzA-1; Tue, 27 Apr 2021 12:13:48 -0400
X-MC-Unique: PrlsCsOcMemV_e4EguPhzA-1
Received: by mail-qv1-f69.google.com with SMTP id t1-20020a0ca6810000b029019e892416e6so25877667qva.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h4WOl7CIm3ueQ8RREsb6vElg27yEJH2OFi487xgNXDI=;
        b=m7KQElbUzjuiCu4k9a0xvMNMZ0g2g75sWdWpAKTqSvThLYUGimb5gPQR1FSM/XdEB5
         y0/boXLDRAZzWRMoLlmwbsIiiYq/3MgaQMF9/3dO9iN5uXlnFtbiZxQJKH5pTDtTnTsR
         iCiFOQjjbu1cj/iE53Ob0qnYfp+XUlJ7GMFTV97ZqlLurRzvbmdy61aeA0Rm5F0RBn7r
         54RxXwLHFtKLqaOvN3nVMXSCrA0ofqhUVAhvKtqxPicn/12M70vyz+jgPuhtf/hGphpS
         prdtNvocmXRxb5qQyO2MUm9fO0I/73lNXJ/xDUY/BYs8qD4PLo14H5iL8PdY06KaPvhk
         L5bQ==
X-Gm-Message-State: AOAM530fZ8P04MAr23g6FiakskpazvaS11SW0cTcPF1xI1bgL+yIWFF2
        fP7ZK+7zjvCmOfihcHnjhxDX19j/FM1IaKIUgY/x8tl91C7r/yMw68TOitS+7DSXofg13ziXnwt
        nX9tnLyG868z4AniQMc5hf6Lu
X-Received: by 2002:a05:622a:100e:: with SMTP id d14mr22854320qte.143.1619540028259;
        Tue, 27 Apr 2021 09:13:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJmDOOgfUngR5oU8MYAl3vjcwLrudb8BiqqgyPc5TSA0H5CdeRhdgWrf0J20xAaMh3sJ7dfQ==
X-Received: by 2002:a05:622a:100e:: with SMTP id d14mr22854291qte.143.1619540028034;
        Tue, 27 Apr 2021 09:13:48 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id v66sm3103621qkd.113.2021.04.27.09.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:13:47 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v2 16/24] hugetlb/userfaultfd: Hook page faults for uffd write protection
Date:   Tue, 27 Apr 2021 12:13:09 -0400
Message-Id: <20210427161317.50682-17-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210427161317.50682-1-peterx@redhat.com>
References: <20210427161317.50682-1-peterx@redhat.com>
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
index 629aa4c2259c8..8e234ee9a15e2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4802,6 +4802,25 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (unlikely(!pte_same(entry, huge_ptep_get(ptep))))
 		goto out_ptl;
 
+	/* Handle userfault-wp first, before trying to lock more pages */
+	if (userfaultfd_pte_wp(vma, huge_ptep_get(ptep)) &&
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
2.26.2

