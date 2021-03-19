Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B72834132E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 03:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhCSCpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 22:45:01 -0400
Received: from mail.kingsoft.com ([114.255.44.145]:15862 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhCSCoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 22:44:44 -0400
X-AuditID: 0a580155-20dff7000005482e-2c-6054085166bb
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id 17.4A.18478.15804506; Fri, 19 Mar 2021 10:11:29 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 19 Mar
 2021 10:44:38 +0800
Date:   Fri, 19 Mar 2021 10:44:37 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <yangfeng1@kingsoft.com>, <sunhao2@kingsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>, <yaoaili@kingsoft.com>
Subject: [PATCH v3] mm/gup: check page posion status for coredump.
Message-ID: <20210319104437.6f30e80d@alex-virtual-machine>
In-Reply-To: <20210318133412.12078eb7@alex-virtual-machine>
References: <20210317163714.328a038d@alex-virtual-machine>
        <20a0d078-f49d-54d6-9f04-f6b41dd51e5f@redhat.com>
        <20210318044600.GJ3420@casper.infradead.org>
        <20210318133412.12078eb7@alex-virtual-machine>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsXCFcGooBvIEZJg0NSnZTFn/Ro2i6/rfzFb
        XN41h83i3pr/rBYf9wdbXGw8wGhxZlqRxe8fc9gcODw2r9Dy2PRpErvHiRm/WTxeXN3I4vHx
        6S0Wj/f7rrJ5bD5d7fF5k1wARxSXTUpqTmZZapG+XQJXxrT+sywFe4UrLt+7ztrAeIC/i5GD
        Q0LARGLTZJcuRi4OIYHpTBLz5n9nhXBeMUq8X3wAyOHkYBFQlXhzfSobiM0GZO+6NwssLiLg
        J3Fr6UcWkAZmgT4miY6VR1hAEsICThI/310BK+IVsJK4sX42M4jNKWAtcXD1F7BBQgLnGCX6
        55uC2PwCYhK9V/4zgdgSAvYSbVsWMUL0CkqcnPkEbCazgI7EiVXHmCFseYntb+cwQ8xRlDi8
        5Bc7RK+SxJHuGWwQdqzEsnmvWCcwCs9CMmoWklGzkIxawMi8ipGlODfdaBMjJFpCdzDOaPqo
        d4iRiYPxEKMEB7OSCK9pXkCCEG9KYmVValF+fFFpTmrxIUZpDhYlcV7HSKCUQHpiSWp2ampB
        ahFMlomDU6qBqaeq9ZDvSplibjWzTbJdx/QXf/ravG9/rWbIUR+HHcvOaCdV8x+WMM9fv5hL
        seKY94RdnN/sn7wOu/zTwXmu4QNZsa0160Ri7q+6wbMzycP5POv7Xc01U2r2rTqw89QEqwk8
        /0wPWmcsOvcp383rQjVXneTjhHPTuIKX7m+Zyyoq+Crs/v07mtxhr7b+TIjif/FzRozFYnuP
        FUx7/yd316UUeznOvxn7aF/o5rTr/fKS2c/+Xd/j8yDFVFGK4ZLa0b1+G87yLPO4wPYu+9rN
        xL6sp8Yrzk70F5idofe4TuDE5U//rbdNX1qU6SzJbrQnWHCe5Jezb68HtKknfPvUnfIgMGW9
        mE/chKr2jquOZUosxRmJhlrMRcWJAJ9dPw4FAwAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we do coredump for user process signal, this may be an SIGBUS signal
with BUS_MCEERR_AR or BUS_MCEERR_AO code, which means this signal is
resulted from ECC memory fail like SRAR or SRAO, we expect the memory
recovery work is finished correctly, then the get_dump_page() will not
return the error page as its process pte is set invalid by
memory_failure().

But memory_failure() may fail, and the process's related pte may not be
correctly set invalid, for current code, we will return the poison page,
get it dumped, and then lead to system panic as its in kernel code.

So check the poison status in get_dump_page(), and if TRUE, return NULL.

There maybe other scenario that is also better to check the posion status
and not to panic, so make a wrapper for this check, Thanks to David's
suggestion(<david@redhat.com>).

Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
---
 mm/gup.c      |  4 ++++
 mm/internal.h | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index e4c224c..dcabe96 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1536,6 +1536,10 @@ struct page *get_dump_page(unsigned long addr)
 				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
 	if (locked)
 		mmap_read_unlock(mm);
+
+	if (ret == 1 && is_page_poisoned(page))
+		return NULL;
+
 	return (ret == 1) ? page : NULL;
 }
 #endif /* CONFIG_ELF_CORE */
diff --git a/mm/internal.h b/mm/internal.h
index 25d2b2439..902d993 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -97,6 +97,27 @@ static inline void set_page_refcounted(struct page *page)
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
+static inline bool is_page_poisoned(struct page *page)
+{
+	if (page != NULL) {
+		if (PageHWPoison(page))
+			return true;
+		else if (PageHuge(page) && PageHWPoison(compound_head(page)))
+			return true;
+	}
+	return 0;
+}
+
 extern unsigned long highest_memmap_pfn;
 
 /*
-- 
1.8.3.1

