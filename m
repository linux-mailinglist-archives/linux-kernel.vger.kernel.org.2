Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C414938BC6F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 04:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237975AbhEUC31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 22:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbhEUC30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 22:29:26 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D81C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 19:28:03 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k5so10184631pjj.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 19:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E6pVI9E4XZyNnUA05HUSAzl+BEx0Xi9CHVjMCM2HStc=;
        b=wbD2TwG6+6TIyuYOXoAFQusX3RFjrZCcY5DBeLij4MrcEpCaONsvRwx00cpsTORLW4
         /FbYohCw9EgveP4g1BxNPOu9/5FHiJt9E528iCyQEtbRanedSzFglc+9mcA1xXyJ4THl
         LHlLZB6nI6sYEqhJkI5CVigq/z++o6F016LEAokKgiYwt20L7kp0gyBEj5Ibv7gsw0Dx
         TUo3JGBhvJA/sjzE8HK17ntwHkixyNMLfIAk7FbrVHvmWA/EWOuTQmnGWrSqRmCBoGGd
         3Zd3NdInCu6EFW1QuNrrFuTyIF+01FqE9IKu8rxTlM8hMvxjtPgKgs0Grvu/9VkdtQj7
         T5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E6pVI9E4XZyNnUA05HUSAzl+BEx0Xi9CHVjMCM2HStc=;
        b=jUJROAUWI62nsEF90LGVtKgybQzRFRJcuLBkYEFfU6S2J24zClUhCwnMW1WV0P3IG5
         vlmk0SbuEYuvhcNld1HPa9IggueBUJWfEvLTv6xUP+SyINhT9hXDTb+MHoGs0IPEufVu
         SL042lTRSqWjAJS/cb3M6ChE5bGT8nSeEPhk7RmLl3kSH8vv038p3AuoaoFtEXdH/zdu
         e5OCPhzz5EKJ3Op72yea6IYCsDiCjnFunbuKEFLfk2RPjLjrREYutPDeTOtZOiMvzy96
         lYNPuvah3O0Myg67n4RqFAGQUHTo9LKRiGdaWAkO+9cFwqXXU0165YkPXW7NMCa0RE9A
         awXg==
X-Gm-Message-State: AOAM530U26OpmVlDuEgd9LNJQSgbUA94R14HYnbZcmk5p+aAnkQnNQV5
        eW+wg6U9zicYXY39BrHj2MBtjQ==
X-Google-Smtp-Source: ABdhPJxHrGkmUEN7q5DYXrV6yJFfzWQ+XDoTInbxNYDBWmBHVvTEfJMflfp4sgMTY62OJP2Mv1XUUw==
X-Received: by 2002:a17:90a:8902:: with SMTP id u2mr8073003pjn.143.1621564082696;
        Thu, 20 May 2021 19:28:02 -0700 (PDT)
Received: from bogon.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id 136sm2892642pfu.195.2021.05.20.19.27.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 May 2021 19:28:02 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, osalvador@suse.de,
        mike.kravetz@oracle.com, mhocko@suse.com, david@redhat.com,
        willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, zhengqi.arch@bytedance.com,
        fam.zheng@bytedance.com, Muchun Song <songmuchun@bytedance.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] mm: migrate: fix missing update page_private to hugetlb_page_subpool
Date:   Fri, 21 May 2021 10:27:47 +0800
Message-Id: <20210521022747.35736-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit d6995da31122 ("hugetlb: use page.private for hugetlb specific
page flags") converts page.private for hugetlb specific page flags. We
should use hugetlb_page_subpool() to get the subpool pointer instead of
page_private().

This 'could' prevent the migration of hugetlb pages. page_private(hpage)
is now used for hugetlb page specific flags.  At migration time, the
only flag which could be set is HPageVmemmapOptimized.  This flag will
only be set if the new vmemmap reduction feature is enabled.  In
addition, !page_mapping() implies an anonymous mapping.  So, this will
prevent migration of hugetb pages in anonymous mappings if the vmemmap
reduction feature is enabled.

In addition, that if statement checked for the rare race condition of a
page being migrated while in the process of being freed.  Since that
check is now wrong, we could leak hugetlb subpool usage counts.

The commit forgot to update it in the page migration routine. So fix it.

Fixes: d6995da31122 ("hugetlb: use page.private for hugetlb specific page flags")
Reported-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
Changeslog in v2:
 1. Update commit log suggested by Mike and Andrew.
 2. Fix compiler error when !CONFIG_HUGETLB_PAGE reported by Randy.

 Thanks.

 include/linux/hugetlb.h | 5 +++++
 mm/migrate.c            | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 9f192ce44088..e11a2e9aa514 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -915,6 +915,11 @@ static inline bool is_hugetlb_free_vmemmap_enabled(void)
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
+static inline struct hugepage_subpool *hugetlb_page_subpool(struct page *hpage)
+{
+	return NULL;
+}
+
 static inline int isolate_or_dissolve_huge_page(struct page *page,
 						struct list_head *list)
 {
diff --git a/mm/migrate.c b/mm/migrate.c
index 066b1e4e8bde..0692fc2638aa 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1292,7 +1292,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 	 * page_mapping() set, hugetlbfs specific move page routine will not
 	 * be called and we could leak usage counts for subpools.
 	 */
-	if (page_private(hpage) && !page_mapping(hpage)) {
+	if (hugetlb_page_subpool(hpage) && !page_mapping(hpage)) {
 		rc = -EBUSY;
 		goto out_unlock;
 	}
-- 
2.11.0

