Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3ED1343FE9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhCVLdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:33:52 -0400
Received: from mail.kingsoft.com ([114.255.44.146]:49372 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229987AbhCVLdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:33:22 -0400
X-AuditID: 0a580157-463ff70000021a79-d1-605879830926
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 11.06.06777.38978506; Mon, 22 Mar 2021 19:03:31 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 22 Mar
 2021 19:33:19 +0800
Date:   Mon, 22 Mar 2021 19:33:18 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <yangfeng1@kingsoft.com>, <sunhao2@kingsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>, <yaoaili@kingsoft.com>
Subject: [PATCH v5] mm/gup: check page hwposion status for coredump.
Message-ID: <20210322193318.377c9ce9@alex-virtual-machine>
In-Reply-To: <20210320003516.GC3420@casper.infradead.org>
References: <20210317163714.328a038d@alex-virtual-machine>
        <20a0d078-f49d-54d6-9f04-f6b41dd51e5f@redhat.com>
        <20210318044600.GJ3420@casper.infradead.org>
        <20210318133412.12078eb7@alex-virtual-machine>
        <20210319104437.6f30e80d@alex-virtual-machine>
        <20210320003516.GC3420@casper.infradead.org>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsXCFcGooNtcGZFg8PahocWc9WvYLL6u/8Vs
        cXnXHDaLe2v+s1p83B9scbHxAKPFmWlFFr9/zGFz4PDYvELLY9OnSeweJ2b8ZvF4cXUji8fH
        p7dYPN7vu8rmsfl0tcfnTXIBHFFcNimpOZllqUX6dglcGXOnL2UtOCJWsebIdJYGxtVCXYyc
        HBICJhIPns9k7GLk4hASmM4k0Xq6hRnCecUocaHnBgtIFYuAqsSv/rNsIDYbkL3r3ixWkCIR
        gQ6goqcH2EEcZoErjBL/z3YwgVQJC7hI7P/UCdbNK2AlsX5NN1g3p4ClxLl986H2rWOSWLVg
        EitIgl9ATKL3yn8miKPsJdq2LGKEaBaUODnzCdggZgEdiROrjjFD2PIS29/OAbOFBBQlDi/5
        xQ7RqyRxpHsGG4QdK7Fs3ivWCYzCs5CMmoVk1CwkoxYwMq9iZCnOTTfcxAiJmfAdjPOaPuod
        YmTiYDzEKMHBrCTC2xIekSDEm5JYWZValB9fVJqTWnyIUZqDRUmcV00bKCWQnliSmp2aWpBa
        BJNl4uCUamBaeFzy4aSpkyTKf+8SZf7LY9OutP/R+m8XD3nnv+nV/yZRFFgTmqfM7brGessv
        0cCyt/wbOW3sUzTT5ZuP3p98NG7C+nM3Dga1L5u89U/kJaaAoJve54tm75m/uKP6oP6dCpa3
        0zrVnEwF62b8U794+Ea//rXLRxiP9E612NtnYDZ7d+xBtZ6TRa/Z3AIr8+WsvP5J5d9a8TlL
        z6xRc0ngM0aue/vz+Jvtc05fDpb6vKZGzH6pwrkXOQc4Zxy9eVlufa3fowCTc6LXF25iibqV
        uNLbYYGBWVF4MMuDNLUmj8YrdcFVra8eiD/aEW930qwqYm1om1mQd5hVyOHuZedzi5atsTq3
        wS/zW8H0qJ1KLMUZiYZazEXFiQCedQR9CAMAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we do coredump for user process signal, this may be one SIGBUS signal
with BUS_MCEERR_AR or BUS_MCEERR_AO code, which means this signal is
resulted from ECC memory fail like SRAR or SRAO, we expect the memory
recovery work is finished correctly, then the get_dump_page() will not
return the error page as its process pte is set invalid by
memory_failure().

But memory_failure() may fail, and the process's related pte may not be
correctly set invalid, for current code, we will return the poison page,
get it dumped, and then lead to system panic as its in kernel code.

So check the hwpoison status in get_dump_page(), and if TRUE, return NULL.

There maybe other scenario that is also better to check hwposion status
and not to panic, so make a wrapper for this check, Thanks to David's
suggestion(<david@redhat.com>).

Link: https://lkml.kernel.org/r/20210319104437.6f30e80d@alex-virtual-machine
Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Aili Yao <yaoaili@kingsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/gup.c      |  4 ++++
 mm/internal.h | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index e4c224c..6f7e1aa 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1536,6 +1536,10 @@ struct page *get_dump_page(unsigned long addr)
 				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
 	if (locked)
 		mmap_read_unlock(mm);
+
+	if (ret == 1 && is_page_hwpoison(page))
+		return NULL;
+
 	return (ret == 1) ? page : NULL;
 }
 #endif /* CONFIG_ELF_CORE */
diff --git a/mm/internal.h b/mm/internal.h
index 25d2b2439..b751cef 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -97,6 +97,26 @@ static inline void set_page_refcounted(struct page *page)
 	set_page_count(page, 1);
 }
 
+/*
+ * When kernel touch the user page, the user page may be have been marked
+ * poison but still mapped in user space, if without this page, the kernel
+ * can guarantee the data integrity and operation success, the kernel is
+ * better to check the posion status and avoid touching it, be good not to
+ * panic, coredump for process fatal signal is a sample case matching this
+ * scenario. Or if kernel can't guarantee the data integrity, it's better
+ * not to call this function, let kernel touch the poison page and get to
+ * panic.
+ */
+static inline bool is_page_hwpoison(struct page *page)
+{
+	if (PageHWPoison(page))
+		return true;
+	else if (PageHuge(page) && PageHWPoison(compound_head(page)))
+		return true;
+
+	return false;
+}
+
 extern unsigned long highest_memmap_pfn;
 
 /*
-- 
1.8.3.1

