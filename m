Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E74389B95
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 05:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhETDD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 23:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhETDD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 23:03:58 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747B1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 20:02:37 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id f22so2943154pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 20:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l7sRv5owrkchidf6i75q7ysNXdO5li1djMK8IkkLhxM=;
        b=xify1oc/CJei7iJHIXxgMVklJY5mW8ywxu92nfb2xy50ya/4F8u4mDf3kOnJxjGCff
         ihRQnjLq7fcxOab1VMv7229A/MdXg2LBamZCXC0vviNaYHLWS0p+/ylKarJUhSh0qmeN
         QUq5P1jZwjGPDxfbbVDNrZlLhNTzQBuLGuiL22jv/puda/rJtvD6tpeRZUocQm+tq0Jg
         jHbMlQeg88dTvh/H1XxSkwHIYrv45p6kSmhmQddHmibU7B9y8L17CRrsxru50C/YpRTK
         4txAq6aZlPs4xa+PsfTQglnihkybgW3HDZvaBZpqLkhsVHgfbiMuNUwxJdbcfkGtNV7h
         gPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l7sRv5owrkchidf6i75q7ysNXdO5li1djMK8IkkLhxM=;
        b=uUdfMa3hYlyEnttcWIlm4RVPAIL88Zc5j02jDnUYKRftCIF958ZMa30LROinFj6frD
         Uq/3xupp5smeaJ/vTWbubCI8a1fO/wD4WG9cT27+quE3P4a4sBfCMv9QUbWQo4Fm5HXv
         uMf+TR47Pcnu79x4lcto4pO9HvR8ehWGrSImndCZn3tRYaDhcLgmqYBqSTD5IpH0kWLf
         nVdHAuGe0Tzp8VYyKZPO38VgHK+UtBXrhp4Jn7fHMgyhXgfvdjvSySvuSWGH3/qoRyKA
         CD3tzg1W7aPj8DLTNrK+CARIwc9pf6usfjmBHIWfSld1iMwP/PrVXhnCN5Y87SRehhwK
         qfSA==
X-Gm-Message-State: AOAM533X8wiOHs1b52bwM5Eos2KvA9sJIxllp1Acieo9+YXosepVMYk+
        VBwHaAQhE2f7qKmuppjJ2MFaKQ==
X-Google-Smtp-Source: ABdhPJzzmIcMrIqVz5QBGc8xv1956TeOI/klyV1+Ji5lpIPTUYGqo/E3QMkVskXOdQGu2hM37TFBOQ==
X-Received: by 2002:a63:4f4a:: with SMTP id p10mr2359694pgl.384.1621479756818;
        Wed, 19 May 2021 20:02:36 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id l18sm5124806pjq.33.2021.05.19.20.02.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 May 2021 20:02:36 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, osalvador@suse.de,
        mike.kravetz@oracle.com, mhocko@suse.com, david@redhat.com,
        willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, zhengqi.arch@bytedance.com,
        fam.zheng@bytedance.com, Muchun Song <songmuchun@bytedance.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH] mm: migrate: fix missing update page_private to hugetlb_page_subpool
Date:   Thu, 20 May 2021 10:59:49 +0800
Message-Id: <20210520025949.1866-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit d6995da31122 ("hugetlb: use page.private for hugetlb specific
page flags") converts page.private for hugetlb specific page flags. We
should use hugetlb_page_subpool() to get the subpool pointer instead of
page_private(). The commit forgot to update it in the page migration
routine. So fix it.

Fixes: d6995da31122 ("hugetlb: use page.private for hugetlb specific page flags")
Reported-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index e7a173da74ec..43419c4bb097 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1290,7 +1290,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
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

