Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E3A354AD7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 04:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhDFCX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 22:23:59 -0400
Received: from mail.kingsoft.com ([114.255.44.146]:53098 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230248AbhDFCX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 22:23:56 -0400
X-AuditID: 0a580155-991ff70000066065-c8-606bc6338653
Received: from mail.kingsoft.com (localhost [10.88.1.79])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id 78.10.24677.336CB606; Tue,  6 Apr 2021 10:23:47 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL4.kingsoft.cn
 (10.88.1.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 6 Apr 2021
 10:23:46 +0800
Date:   Tue, 6 Apr 2021 10:23:46 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     David Hildenbrand <david@redhat.com>,
        "HORIGUCHI =?UTF-8?B?TkFPWUE=?=( =?UTF-8?B?5aCA5Y+jIOebtOS5nw==?=)" 
        <naoya.horiguchi@nec.com>, "Matthew Wilcox" <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        "sunhao2@kingsoft.com" <sunhao2@kingsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>, <yaoaili@kingsoft.com>
Subject: [PATCH v6] mm/gup: check page hwpoison status for memory recovery
 failures.
Message-ID: <20210406102346.3890ceb2@alex-virtual-machine>
In-Reply-To: <9f49c415-a75a-1ea3-b80c-5ba512331de6@redhat.com>
References: <20a0d078-f49d-54d6-9f04-f6b41dd51e5f@redhat.com>
        <20210318044600.GJ3420@casper.infradead.org>
        <20210318133412.12078eb7@alex-virtual-machine>
        <20210319104437.6f30e80d@alex-virtual-machine>
        <20210320003516.GC3420@casper.infradead.org>
        <20210322193318.377c9ce9@alex-virtual-machine>
        <afeac310-c6aa-f9d8-6c90-e7e7f21ddf9a@redhat.com>
        <f316ca3b-6f09-c51d-9661-66171f14ee33@redhat.com>
        <20210331015258.GB22060@hori.linux.bs1.fc.nec.co.jp>
        <20210331104303.145aea53@alex-virtual-machine>
        <20210331043231.GA26013@hori.linux.bs1.fc.nec.co.jp>
        <9f49c415-a75a-1ea3-b80c-5ba512331de6@redhat.com>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL4.kingsoft.cn
 (10.88.1.79)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsXCFcHor2t8LDvB4MQBfos569ewWXxd/4vZ
        4vKuOWwW99b8Z7X4uD/Y4mLjAUaLM9OKLH7/mMPmwOGxeYWWx6ZPk9g9Tsz4zeLx4upGFo+P
        T2+xeLzfd5XNY/Ppao/Pm+QCOKK4bFJSczLLUov07RK4Mvau/MVesNiw4viWJ8wNjM3qXYyc
        HBICJhKfdh1j7GLk4hASmM4kMbnnByuE85JRom/fe6AMBweLgIrE788cIA1sAqoSu+7NAqsR
        EXjHKLHl1SR2EIdZYBeTxOzfM9hBqoQFwiQ2T5vOAmLzClhJrLnewwRicwrYSaxdO4EJagOL
        xLSX88AS/AJiEr1X/jNB3GQv0bZlESNEs6DEyZlPwAYxC+hInFh1jBnClpfY/nYOmC0koChx
        eMkvdoheJYkj3TPYIOxYiaYDt9gmMArPQjJqFpJRs5CMWsDIvIqRpTg33WgTIyRiQncwzmj6
        qHeIkYmD8RCjBAezkgjvjt7sBCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8bw4BpQTSE0tSs1NT
        C1KLYLJMHJxSDUw5Hyda3LyXwqqV80a85dcvvqoHS083BU2JF/hl5mBz8Tp7scIqub8HZ+YL
        M84ziOPftPvR5fqTr9rnHWrgNz6g3Mdf+nudzkrXbKZ7J39sy7zYERRTIjx/lsKul9M9mrlu
        Nt4tX/7IS5Q1OyevvFpUxqjwrqiC69ZT4k9THzhdvBDI7yK1puF9tfGtiwkvOuVPGtjKh7c5
        /Ps3g/vtJLnkh8VFVx+LFTcmL2Dsedpfou0oKLtnjX24nazaat/m7KcW5tEzwmYcaO7v/6vU
        t/vIzjcBzjNNXCo27Jsr3+HrWsFWacZosDy3pvjGrA/vp/SW7OJmyJbtsJi/dfm0qIrNHssm
        qvNrPlkk3HNkqhJLcUaioRZzUXEiAIHBdQkHAwAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we call get_user_pages() to pin user page in memory, there may be
hwpoison page, currently, we just handle the normal case that memory
recovery jod is correctly finished, and we will not return the hwpoison
page to callers, but for other cases like memory recovery fails and the
user process related pte is not correctly set invalid, we will still
return the hwpoison page, and may touch it and lead to panic.

In gup.c, for normal page, after we call follow_page_mask(), we will
return the related page pointer; or like another hwpoison case with pte
invalid, it will return NULL. For NULL, we will handle it in if (!page)
branch. In this patch, we will filter out the hwpoison page in
follow_page_mask() and return error code for recovery failure cases.

We will check the page hwpoison status as soon as possible and avoid doing
followed normal procedure and try not to grab related pages.

Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org
---
 mm/gup.c         | 27 +++++++++++++++++++++++----
 mm/huge_memory.c |  9 +++++++--
 mm/hugetlb.c     |  8 +++++++-
 mm/internal.h    | 13 +++++++++++++
 4 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index e40579624f10..88a93b89c03e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -433,6 +433,9 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 			page = ERR_PTR(ret);
 			goto out;
 		}
+	} else if (PageHWPoison(page)) {
+		page = ERR_PTR(-EHWPOISON);
+		goto out;
 	}
 
 	if (flags & FOLL_SPLIT && PageTransCompound(page)) {
@@ -540,8 +543,13 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		page = follow_huge_pd(vma, address,
 				      __hugepd(pmd_val(pmdval)), flags,
 				      PMD_SHIFT);
-		if (page)
-			return page;
+		if (page) {
+			struct page *p = check_page_hwpoison(page);
+
+			if (p == ERR_PTR(-EHWPOISON) && flags & FOLL_GET)
+				put_page(page);
+			return p;
+		}
 		return no_page_table(vma, flags);
 	}
 retry:
@@ -643,7 +651,7 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 	if (pud_huge(*pud) && is_vm_hugetlb_page(vma)) {
 		page = follow_huge_pud(mm, address, pud, flags);
 		if (page)
-			return page;
+			return check_page_hwpoison(page);
 		return no_page_table(vma, flags);
 	}
 	if (is_hugepd(__hugepd(pud_val(*pud)))) {
@@ -652,6 +660,13 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 				      PUD_SHIFT);
 		if (page)
 			return page;
+		if (page) {
+			struct page *p = check_page_hwpoison(page);
+
+			if (p == ERR_PTR(-EHWPOISON) && flags & FOLL_GET)
+				put_page(page);
+			return p;
+		}
 		return no_page_table(vma, flags);
 	}
 	if (pud_devmap(*pud)) {
@@ -1087,10 +1102,14 @@ static long __get_user_pages(struct mm_struct *mm,
 			 * struct page.
 			 */
 			goto next_page;
-		} else if (IS_ERR(page)) {
+		} else if (PTR_ERR(page) == -EHWPOISON) {
+			ret = (foll_flags & FOLL_HWPOISON) ? -EHWPOISON : -EFAULT;
+			goto out;
+		}  else if (IS_ERR(page)) {
 			ret = PTR_ERR(page);
 			goto out;
 		}
+
 		if (pages) {
 			pages[i] = page;
 			flush_anon_page(vma, page, start);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ae907a9c2050..3973d988e485 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1349,6 +1349,7 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct page *page = NULL;
+	struct page *tail = NULL;
 
 	assert_spin_locked(pmd_lockptr(mm, pmd));
 
@@ -1366,6 +1367,11 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 	page = pmd_page(*pmd);
 	VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page), page);
 
+	tail = page + ((addr & ~HPAGE_PMD_MASK) >> PAGE_SHIFT);
+
+	if (PageHWPoison(tail))
+		return ERR_PTR(-EHWPOISON);
+
 	if (!try_grab_page(page, flags))
 		return ERR_PTR(-ENOMEM);
 
@@ -1405,11 +1411,10 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 		unlock_page(page);
 	}
 skip_mlock:
-	page += (addr & ~HPAGE_PMD_MASK) >> PAGE_SHIFT;
 	VM_BUG_ON_PAGE(!PageCompound(page) && !is_zone_device_page(page), page);
 
 out:
-	return page;
+	return tail;
 }
 
 /* NUMA hinting page fault entry point for trans huge pmds */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a86a58ef132d..8b50f7eaa159 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4958,7 +4958,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 					     likely(pages) ? pages + i : NULL,
 					     vmas ? vmas + i : NULL);
 
-		if (pages) {
+		/* As we will filter out the hwpoison page, so don't try grab it */
+		if (pages && !PageHWPoison(page)) {
 			/*
 			 * try_grab_compound_head() should always succeed here,
 			 * because: a) we hold the ptl lock, and b) we've just
@@ -5581,6 +5582,11 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long address,
 	pte = huge_ptep_get((pte_t *)pmd);
 	if (pte_present(pte)) {
 		page = pmd_page(*pmd) + ((address & ~PMD_MASK) >> PAGE_SHIFT);
+		/* if hwpoison, we don't grab it */
+		if (PageHWPoison(compound_head(page))) {
+			page = ERR_PTR(-EHWPOISON);
+			goto out;
+		}
 		/*
 		 * try_grab_page() should always succeed here, because: a) we
 		 * hold the pmd (ptl) lock, and b) we've just checked that the
diff --git a/mm/internal.h b/mm/internal.h
index 1432feec62df..049b310bc79a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -97,6 +97,19 @@ static inline void set_page_refcounted(struct page *page)
 	set_page_count(page, 1);
 }
 
+/*
+ * Check the hwposion status of any page type, and if TRUE, return ERR ptr.
+ */
+static inline struct page *check_page_hwpoison(struct page *page)
+{
+	if (PageHWPoison(page))
+		return ERR_PTR(-EHWPOISON);
+	else if (PageHuge(page) && PageHWPoison(compound_head(page)))
+		return ERR_PTR(-EHWPOISON);
+
+	return page;
+}
+
 extern unsigned long highest_memmap_pfn;
 
 /*
-- 
2.29.3

