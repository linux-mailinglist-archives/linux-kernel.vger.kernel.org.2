Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C653AAFA7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhFQJ2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhFQJ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:28:46 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DDAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:26:38 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id k15so4527971pfp.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KryS05F8yykdJ8/Bn8WDRh+2BxDJ+KUha/fXyOsgM+k=;
        b=mwkZAfu8nN4ynVz14N+KSOMx2lFJa0zpV6jz3LMyfqwWkVuUXcNe0X4Fmgf6P8LnWp
         nfVYEamHkpIyn9n5G4puh42hw9uY3AKFIf7j+C1OoVpJC7RRJ0L2g5+QDEgFTrBJcoDl
         bhZiSiNwD/KckITc8WjOyzFTtEXQlf2uH/GyT+4R4Qju7yKFVxqOlX+8CRTWJ+K1EVV1
         olMd3mcghY9eIKCe6rOBwZVjOcrv76f0C/qizyrWw2kx36yLLSoBMZZb7zMr1hI3CAu/
         rHoLsuKfIwf4FrRVutQH41m4bF2WT5kZcKb3HdHmK9bwJ+QPjUbf5HRbZK0a9EYjeVIZ
         t4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KryS05F8yykdJ8/Bn8WDRh+2BxDJ+KUha/fXyOsgM+k=;
        b=hgWq0lbpQcazIFUUQHSmboUXcxBCxPuIX5Az8OvXYtD/NGYzPLP0+v8NNo3Zx5aimQ
         UJ4tm8XMVt2Uudqv/1vpO657NUp5FhrsXWloAI1gwQeggs7DpSWMVD8rq1egWGE5lWe9
         QGRCi0ZTcaCG4y7YBqMn+kVG6a+QDhBK8hNI3j9hKoFN4cJY2Io24psMZt4E3c2zxqdO
         wBKRqYatiGnYTcYlvqzk4aEIX+8bdYUVD7cH/PJCA93vaeLT08e+o2pnkuxBYhZW/DGM
         UdPv5S7/H72m51eOquDmbsvlD2ulhLvQZ7CrSu+tL2iQJ33rg2H6Zhtg1kwrN32rFwXs
         9WEg==
X-Gm-Message-State: AOAM533k9LCmZEUIBHhw7AOsV2VMJidbBaI963/Zoi0ravHfuq6lW+S6
        zxZYFoAwyDz7YXL1ghqM5A==
X-Google-Smtp-Source: ABdhPJwGLC8Fu6UDSezxtpMdxDFypGbC7quTIZJN3STK+uD+rnZ1Wpq13LqooTXVoT7ko+VN42dZfQ==
X-Received: by 2002:a05:6a00:bc7:b029:2f5:7bdb:f694 with SMTP id x7-20020a056a000bc7b02902f57bdbf694mr4355722pfu.41.1623921997787;
        Thu, 17 Jun 2021 02:26:37 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id b65sm4635030pfa.32.2021.06.17.02.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 02:26:37 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH mmotm v1] mm/hwpoison: disable pcp for page_handle_poison()
Date:   Thu, 17 Jun 2021 18:26:26 +0900
Message-Id: <20210617092626.291006-1-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Recent changes by patch "mm/page_alloc: allow high-order pages to be
stored on the per-cpu lists" makes kernels determine whether to use pcp
by pcp_allowed_order(), which breaks soft-offline for hugetlb pages.

Soft-offline dissolves a migration source page, then removes it from
buddy free list, so it's assumed that any subpage of the soft-offlined
hugepage are recognized as a buddy page just after returning from
dissolve_free_huge_page().  pcp_allowed_order() returns true for
hugetlb, so this assumption is no longer true.

So disable pcp during dissolve_free_huge_page() and
take_page_off_buddy() to prevent soft-offlined hugepages from linking to
pcp lists.  Soft-offline should not be common events so the impact on
performance should be minimal.  And I think that the optimization of
Mel's patch could benefit to hugetlb so zone_pcp_disable() is called
only in hwpoison context.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git v5.13-rc6-mmotm-2021-06-15-20-24/mm/memory-failure.c v5.13-rc6-mmotm-2021-06-15-20-24_patched/mm/memory-failure.c
index 1842822a10da..593079766655 100644
--- v5.13-rc6-mmotm-2021-06-15-20-24/mm/memory-failure.c
+++ v5.13-rc6-mmotm-2021-06-15-20-24_patched/mm/memory-failure.c
@@ -66,6 +66,19 @@ int sysctl_memory_failure_recovery __read_mostly = 1;
 
 atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
+static bool __page_handle_poison(struct page *page)
+{
+	bool ret;
+
+	zone_pcp_disable(page_zone(page));
+	ret = dissolve_free_huge_page(page);
+	if (!ret)
+		ret = take_page_off_buddy(page);
+	zone_pcp_enable(page_zone(page));
+
+	return ret;
+}
+
 static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, bool release)
 {
 	if (hugepage_or_freepage) {
@@ -73,7 +86,7 @@ static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, boo
 		 * Doing this check for free pages is also fine since dissolve_free_huge_page
 		 * returns 0 for non-hugetlb pages as well.
 		 */
-		if (dissolve_free_huge_page(page) || !take_page_off_buddy(page))
+		if (!__page_handle_poison(page))
 			/*
 			 * We could fail to take off the target page from buddy
 			 * for example due to racy page allocation, but that's
@@ -986,7 +999,7 @@ static int me_huge_page(struct page *p, unsigned long pfn)
 		 */
 		if (PageAnon(hpage))
 			put_page(hpage);
-		if (!dissolve_free_huge_page(p) && take_page_off_buddy(p)) {
+		if (__page_handle_poison(p)) {
 			page_ref_inc(p);
 			res = MF_RECOVERED;
 		}
@@ -1441,7 +1454,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 		res = get_hwpoison_page(p, flags);
 		if (!res) {
 			res = MF_FAILED;
-			if (!dissolve_free_huge_page(p) && take_page_off_buddy(p)) {
+			if (__page_handle_poison(p)) {
 				page_ref_inc(p);
 				res = MF_RECOVERED;
 			}
-- 
2.25.1

