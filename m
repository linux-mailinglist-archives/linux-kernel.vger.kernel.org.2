Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD3F44FFA6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 09:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbhKOIGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:06:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58257 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229944AbhKOIE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:04:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636963294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jyv1lzZ4mkTvzdL9kLWgnj86vlKE/ygyLYqVdoUf6Sw=;
        b=b3y9dmhjqk2gxziTiJD9KT6UfcyFQvyPK4A12LrlvSYbcYW30xmoFYp89QPq+k+HztCiRJ
        5D88+LHt4WLSTHTSXP8PLAyHNWnPdn5FRJGOddYD0YsRPfewtOh/mllmEMhiWDKC1XYg7G
        pqqRIjKRUxFaYVpOl2m9YP4ipEaYdik=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-xhiONKP8Oc-zDM9T-3uyVQ-1; Mon, 15 Nov 2021 03:01:33 -0500
X-MC-Unique: xhiONKP8Oc-zDM9T-3uyVQ-1
Received: by mail-pl1-f200.google.com with SMTP id e4-20020a170902b78400b00143c2e300ddso519354pls.17
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 00:01:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jyv1lzZ4mkTvzdL9kLWgnj86vlKE/ygyLYqVdoUf6Sw=;
        b=raKV3oTRZD4Ms+3eUIIsyc+5DQW65D6ymQi4ZTjDe+NR3+PAbCXwDK0NicWuDe33/P
         Yw8xz7mt9d/RFgQChGb9KWn6dOu+YNP35I1QZC7md2lT/3FSBkaqLuMUCpstNvPCzoxj
         UVPhjQNaQsdiDyV8UsOGQtaYUZcDWRGpaAJfxn706KvKLDWahIL4hAVfOA73Y8TFZITV
         Yz1Bxuv4LXCxj31ue8mtyiaT0tqxY1ucWKqANjVywWh1L1Uv0aHT8B3D8chntWVD2fzp
         Bw1wa2Vh7bT/FOVxpcwjXo2zUE4cn52i73U0pC7Zde3LDrNvRNBpNDw362G60BPEdjuL
         i2YA==
X-Gm-Message-State: AOAM531HgLjk7yqWGRNvma8wOc4ep0zl5MN44eXPA4qpz3uwov7XUmN7
        TdGsCKUJcxB8b2CTlz3/WA04H2H3evdYsg3p0nQaAjAh2NIYKwaoi8ZUSA+Zrr68gpP7YkcNKLp
        GvGhOlSjLp6Ln2nlpC4zsumEX
X-Received: by 2002:a17:902:e294:b0:143:86a8:c56d with SMTP id o20-20020a170902e29400b0014386a8c56dmr33185946plc.22.1636963292122;
        Mon, 15 Nov 2021 00:01:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMIv+3cF09VX35C/GmVeDIlebJd1GQRnqQzuF2YhF3HKAjwkxGT6acz2QFRWDpRQuvSoQbMw==
X-Received: by 2002:a17:902:e294:b0:143:86a8:c56d with SMTP id o20-20020a170902e29400b0014386a8c56dmr33185912plc.22.1636963291897;
        Mon, 15 Nov 2021 00:01:31 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.89])
        by smtp.gmail.com with ESMTPSA id p20sm14708877pfw.96.2021.11.15.00.01.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 00:01:31 -0800 (PST)
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
Subject: [PATCH v6 11/23] mm/hugetlb: Introduce huge pte version of uffd-wp helpers
Date:   Mon, 15 Nov 2021 16:01:17 +0800
Message-Id: <20211115080117.74699-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115075522.73795-1-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com>
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
 arch/s390/include/asm/hugetlb.h | 15 +++++++++++++++
 include/asm-generic/hugetlb.h   | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index 60f9241e5e4a..19c4b4431d27 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -115,6 +115,21 @@ static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
 	return pte_modify(pte, newprot);
 }
 
+static inline pte_t huge_pte_mkuffd_wp(pte_t pte)
+{
+	return pte;
+}
+
+static inline pte_t huge_pte_clear_uffd_wp(pte_t pte)
+{
+	return pte;
+}
+
+static inline int huge_pte_uffd_wp(pte_t pte)
+{
+	return 0;
+}
+
 static inline bool gigantic_page_runtime_supported(void)
 {
 	return true;
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index f39cad20ffc6..896f341f614d 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -35,6 +35,21 @@ static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
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
2.32.0

