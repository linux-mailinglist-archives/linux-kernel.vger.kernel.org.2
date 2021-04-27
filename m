Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055D036C943
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbhD0QVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:21:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47560 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237542AbhD0QOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619540017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y3TQVnHKUnw/sN50yOfbaMGsu/Nf7cRcOPipeW/bhgE=;
        b=EEx6/Qe8iADDzjzXOkK1IlNjUw5hX7St+qc2PKAchK4e7gfgNWhtV+U98y7iNbs9+SrgYz
        R7dCY/LEp2YhYrmpKND5D3nZFh1h+szWcYYn9jKE9wAIaoSD6R06U6akInntzyWMHD3S0J
        GdH9lS2eMQ27S+utSu2vIlHIQ/3rc8A=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-Dh652rGNMpGRW8k_orgsMw-1; Tue, 27 Apr 2021 12:13:35 -0400
X-MC-Unique: Dh652rGNMpGRW8k_orgsMw-1
Received: by mail-qk1-f199.google.com with SMTP id 81-20020a370c540000b02902e4d7b9e448so1594173qkm.16
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y3TQVnHKUnw/sN50yOfbaMGsu/Nf7cRcOPipeW/bhgE=;
        b=EtEjsFMuogOBybR/seal9TSuxLQE1UqQW0ofAHnGJa+chbE3DHOhc2vWFz5oiKN+Yi
         Gjx0dHIm7ghbPDnErWxE8INOx0lTMlrnuRXWp9YNBY+wr6jCA6EGPq4N2Lfk4NVoAoWG
         CwhcJcXv99jsu89gfCoRefn4NcVQvWx3MU/IBH7GXQ3cmwHMBdCGq3PEzugqBsnultKl
         tmS8WbIuj6yrpoPLbS8U/2oIG87/m4DXAK8kdwC3+DxuDTg7kMFycL33lbNhm3U/Bshh
         D7vGQPIIl9dgKvRDNNEZ1uhKa8QNPsuSpaqvlA9qsrg4HmOUrTJoD1qiQ9TL7CqioecE
         dEoA==
X-Gm-Message-State: AOAM532lZlYa+kky4+LUYpj4D5iMr4gMy53lXe6nZeTtcdzeHSIuHHOO
        ux78XM76Zj8sdMqW/qkJMk5qrfvPjQLj24eEsiBSUEabdnC1OGc3xFQHfLelWeGA+ImjDli+NAT
        IpICVe3qf/SV9GeQQl8rnlc2u
X-Received: by 2002:a0c:eacb:: with SMTP id y11mr24286777qvp.57.1619540014902;
        Tue, 27 Apr 2021 09:13:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzx90n+kQM1TV9Fi7Mcce4rO7UufmQT9+0nyJR2Yx3bhbVF1lrR4VAs6KWnUEZ+shz+GRUjDg==
X-Received: by 2002:a0c:eacb:: with SMTP id y11mr24286748qvp.57.1619540014668;
        Tue, 27 Apr 2021 09:13:34 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id v66sm3103621qkd.113.2021.04.27.09.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:13:34 -0700 (PDT)
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
Subject: [PATCH v2 08/24] mm: Introduce ZAP_FLAG_SKIP_SWAP
Date:   Tue, 27 Apr 2021 12:13:01 -0400
Message-Id: <20210427161317.50682-9-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210427161317.50682-1-peterx@redhat.com>
References: <20210427161317.50682-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, the comment in zap_pte_range() is misleading because it checks against
details rather than check_mappings, so it's against what the code did.

Meanwhile, it's confusing too on not explaining why passing in the details
pointer would mean to skip all swap entries.  New user of zap_details could
very possibly miss this fact if they don't read deep until zap_pte_range()
because there's no comment at zap_details talking about it at all, so swap
entries could be errornously skipped without being noticed.

This partly reverts 3e8715fdc03e ("mm: drop zap_details::check_swap_entries"),
but introduce ZAP_FLAG_SKIP_SWAP flag, which means the opposite of previous
"details" parameter: the caller should explicitly set this to skip swap
entries, otherwise swap entries will always be considered (which is still the
major case here).

Cc: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h | 12 ++++++++++++
 mm/memory.c        |  8 +++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 39c944bf7ed3a..2227e9107e53e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1704,6 +1704,8 @@ extern void user_shm_unlock(size_t, struct user_struct *);
 
 /* Whether to check page->mapping when zapping */
 #define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
+/* Whether to skip zapping swap entries */
+#define  ZAP_FLAG_SKIP_SWAP                 BIT(1)
 
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
@@ -1726,6 +1728,16 @@ zap_check_mapping_skip(struct zap_details *details, struct page *page)
 	return details->zap_mapping != page_rmapping(page);
 }
 
+/* Return true if skip swap entries, false otherwise */
+static inline bool
+zap_skip_swap(struct zap_details *details)
+{
+	if (!details)
+		return false;
+
+	return details->zap_flags & ZAP_FLAG_SKIP_SWAP;
+}
+
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index 94954436544f7..5325c1c2cbd78 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1284,8 +1284,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			continue;
 		}
 
-		/* If details->check_mapping, we leave swap entries. */
-		if (unlikely(details))
+		if (unlikely(zap_skip_swap(details)))
 			continue;
 
 		if (!non_swap_entry(entry))
@@ -3236,7 +3235,10 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
 		pgoff_t nr, bool even_cows)
 {
 	pgoff_t	first_index = start, last_index = start + nr - 1;
-	struct zap_details details = { .zap_mapping = mapping };
+	struct zap_details details = {
+		.zap_mapping = mapping,
+		.zap_flags = ZAP_FLAG_SKIP_SWAP,
+	};
 
 	if (!even_cows)
 		details.zap_flags |= ZAP_FLAG_CHECK_MAPPING;
-- 
2.26.2

