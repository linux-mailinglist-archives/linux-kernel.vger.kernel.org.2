Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39356359ECE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbhDIMdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbhDIMdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:33:41 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE22BC061761
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 05:33:28 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id ay2so2690207plb.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 05:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6R55V/CuXB33aAoU/bsrzbgfk9K+eRFZFimwdQYmwjM=;
        b=eZ1j/lFcci4rZs2vi2zo+Q3vLjgZ/KsgZ2v5ITMbi6WCXPi6jvCUCcognIc1RDzAwj
         syyvnemiqV0Xuebg+oBEDBABew7s5Nz1idaXzWNlvm+I98ZBgTfJtKzBsSWGLHVfoKS4
         POiNgXlu5fbTxJvVuspVTv1C099MY0pb3lVkZxTZbryL3Fy62V2HEyiBamCei8GB/8Sm
         AGfxOPCU5ggiMdOciXRjY+YzyPLd4ceIkPUBk67xBBUOWqpye2Q7J+nDLoYaA1p59zzy
         g5FY3VybE6rbOqiW08klciEMGGmGbUDsEA9tsaxiAxWRpa0eRBkQTUID3hFZVvIt+x+/
         HjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6R55V/CuXB33aAoU/bsrzbgfk9K+eRFZFimwdQYmwjM=;
        b=Fos0DCCCiGuxhywA7WzoAOTS/XiKfrMygr3wZMzxkFfmHj1snqMVZXdwECLGCVfcZf
         mKKhekRcnr2IkuRip7tSLHAqr7cURXll0oy5B+IvUnh/4PLj2PZGuibTgwM7dWTCKB3c
         mEwk9zIjhOSyFI9tEEe11HskIndCogQpTCIYdk2cTgEvF6BsC9WXkYtWAMgxmTXYbVKf
         cbT497wPis+cQ8/huNjSTPL+gAQuC+Y1L4dgH5JoPnGhW1HmmGvSD0jg7xbrseyGaQ/g
         iozrbbW3jEy61dOyE5FZ3vfkY6zkGUyo5Im+xw/efl6xoqREU51pB16xkrnByc2V3vtt
         LXDg==
X-Gm-Message-State: AOAM530Z5cOzH3TpJoTWgCODDuKUdHXz0jZrONXdvTt9csgeRX9ftys6
        bqHmCcowgCBMaiBbcX4Fwi5r5g==
X-Google-Smtp-Source: ABdhPJx142hqxE1nk/vUf1pZXSasVOEhm6hE06kPDF8AjlepxHoBq+/L2omJpZ2I7IFILEWr+BzNgw==
X-Received: by 2002:a17:90a:2bcd:: with SMTP id n13mr13789801pje.145.1617971608504;
        Fri, 09 Apr 2021 05:33:28 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id t3sm2167785pfg.176.2021.04.09.05.33.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Apr 2021 05:33:28 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v2 17/18] mm: lru: add VM_BUG_ON_PAGE to lru maintenance function
Date:   Fri,  9 Apr 2021 20:29:58 +0800
Message-Id: <20210409122959.82264-18-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210409122959.82264-1-songmuchun@bytedance.com>
References: <20210409122959.82264-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to make sure that the page is deleted from or added to the
correct lruvec list. So add a VM_BUG_ON_PAGE() to catch invalid
users.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mm_inline.h | 6 ++++++
 mm/vmscan.c               | 1 -
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 355ea1ee32bd..d19870448287 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -84,6 +84,8 @@ static __always_inline void add_page_to_lru_list(struct page *page,
 {
 	enum lru_list lru = page_lru(page);
 
+	VM_BUG_ON_PAGE(!lruvec_holds_page_lru_lock(page, lruvec), page);
+
 	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
 	list_add(&page->lru, &lruvec->lists[lru]);
 }
@@ -93,6 +95,8 @@ static __always_inline void add_page_to_lru_list_tail(struct page *page,
 {
 	enum lru_list lru = page_lru(page);
 
+	VM_BUG_ON_PAGE(!lruvec_holds_page_lru_lock(page, lruvec), page);
+
 	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
 	list_add_tail(&page->lru, &lruvec->lists[lru]);
 }
@@ -100,6 +104,8 @@ static __always_inline void add_page_to_lru_list_tail(struct page *page,
 static __always_inline void del_page_from_lru_list(struct page *page,
 				struct lruvec *lruvec)
 {
+	VM_BUG_ON_PAGE(!lruvec_holds_page_lru_lock(page, lruvec), page);
+
 	list_del(&page->lru);
 	update_lru_size(lruvec, page_lru(page), page_zonenum(page),
 			-thp_nr_pages(page));
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4431007825ad..af0fc8110bdc 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2063,7 +2063,6 @@ static unsigned int move_pages_to_lru(struct list_head *list)
 			continue;
 		}
 
-		VM_BUG_ON_PAGE(!lruvec_holds_page_lru_lock(page, lruvec), page);
 		add_page_to_lru_list(page, lruvec);
 		nr_pages = thp_nr_pages(page);
 		nr_moved += nr_pages;
-- 
2.11.0

