Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2C83C93C3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbhGNW1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:27:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28531 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230111AbhGNW1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626301499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SAmjiglASlkj6C13Cutnvz5k0d0w8IXdZ7Qyh6+DwYY=;
        b=gC/uqHzh1NoJejqepzcbSP5EVZJSGvDKqUhS1J/fGDwUAktamgYcYnV+CaHsLh+/+3iAfb
        Q64kBWAFPBPMOVfxroSf0zVHUe3AsKO66lMF+9rDuFUbIIUtjXJ5bhGubWaNEyNPJkqHM8
        BwLDeh4B3weZpp3Gp0tXANCRxRUo02k=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-qt7yKRDMMiesX7nYB6gjuw-1; Wed, 14 Jul 2021 18:24:58 -0400
X-MC-Unique: qt7yKRDMMiesX7nYB6gjuw-1
Received: by mail-qv1-f71.google.com with SMTP id u8-20020a0562141c08b02902e82df307f0so2712803qvc.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SAmjiglASlkj6C13Cutnvz5k0d0w8IXdZ7Qyh6+DwYY=;
        b=WfrhYskYRmu+IRsVWzxTl8qfjZf5abijYbfHFkGihFa3KS2x5+QyOlwmPU7hyr+Mgm
         7q7akAKFDuSuMfRbn0gotFTi9zcXZbQUws8BwQIObRGKzU8FmZbd65AS/dQjk3DZXWDk
         8Ia0NdTwD0U7D+oqRx82Og2hUtNIE1olnkvykmBjc1l6624TWBwDpjWbPhPZbdde87UM
         /6pYVBtfM4Uk0Cf+ZEJoluTN7L1CL+RSKp5Xb8fN68JGi1A54YusOaX8wPvk4FF38bX7
         fPv5LSCrbw/xUFCHnp/hCRaKZUodB5WDRGyMRu0bMDqj8UM0HyJzfg21iyrSSCoTDiYw
         aM5g==
X-Gm-Message-State: AOAM533GuSCqCoI/RU804DSu6YGFhzhZUtiEYu33es3gjwRsvdpf5RIJ
        SClp9kw2WRcVw1bgk0Cgsp1vflfGwhd5SRb3+kawba8hpZ8P+wex2pGnJ204PVij4mXKtMciQwC
        BGzQ+QC/F0+WCKgRv4xwF1UBg
X-Received: by 2002:a0c:ff01:: with SMTP id w1mr251291qvt.28.1626301498135;
        Wed, 14 Jul 2021 15:24:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsaEytrl+N0UaFyQiUBIwG7Khd7frW2mnu6eY1ibxH9wfPndm7ab048Rnu8cItyAyW05WjVg==
X-Received: by 2002:a0c:ff01:: with SMTP id w1mr251275qvt.28.1626301497935;
        Wed, 14 Jul 2021 15:24:57 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id r5sm1274775qtm.75.2021.07.14.15.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:24:57 -0700 (PDT)
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
Subject: [PATCH v4 16/26] mm/hugetlb: Introduce huge pte version of uffd-wp helpers
Date:   Wed, 14 Jul 2021 18:24:54 -0400
Message-Id: <20210714222454.48891-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714222117.47648-1-peterx@redhat.com>
References: <20210714222117.47648-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They will be used in the follow up patches to either check/set/clear uffd-wp
bit of a huge pte.

So far it reuses all the small pte helpers.  Archs can overwrite these versions
when necessary (with __HAVE_ARCH_HUGE_PTE_UFFD_WP* macros) in the future.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/asm-generic/hugetlb.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 8e1e6244a89d..c45b9deb41ff 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -32,6 +32,21 @@ static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
 	return pte_modify(pte, newprot);
 }
 
+static inline pte_t huge_pte_mkuffd_wp(pte_t pte)
+{
+	return pte_mkuffd_wp(pte);
+}
+
+static inline pte_t huge_pte_clear_uffd_wp(pte_t pte)
+{
+	return pte_clear_uffd_wp(pte);
+}
+
+static inline int huge_pte_uffd_wp(pte_t pte)
+{
+	return pte_uffd_wp(pte);
+}
+
 #ifndef __HAVE_ARCH_HUGE_PTE_CLEAR
 static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 		    pte_t *ptep, unsigned long sz)
-- 
2.31.1

