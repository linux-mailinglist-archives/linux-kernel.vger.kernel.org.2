Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D28D366521
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 08:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbhDUGEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 02:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbhDUGEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 02:04:00 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEB0C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 23:03:26 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id m11so27683559pfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 23:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HyY9cW4ZspnsIypCtHXf1FMM7FMaR7EgF6f9kJkBvd4=;
        b=YRXCkaNtkRpZGmmh+k7lz8wyKQRehKcuvHjGnHVKKiyMgJXE3BYneLYkVxsra+0ajv
         rZynHqCBjPgkUZE4eSmnrutWc/XhOC3SUeMULOpzKsmVijpI2qoPoQ9Fr8ID30VYBZ65
         /1wjPDlT8JdNCQp2IOfmPLWFhVTeOCt5YkeCO56BnzzeUScwD1kNmMNcpqlK6f5LKRWV
         O7JOrwbkNK/6aGNYxwAFl94in+ecZzq9PI/HFAn6CMJw+UDSpyS2WzYbOizxhVFm9bvh
         TI23lLfYJNlUyFlzbZvZdFCGnTHv3u5RTStJnl9T2+y+ncfM4GQ5YFOcrD8uhXl1oC3F
         MpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HyY9cW4ZspnsIypCtHXf1FMM7FMaR7EgF6f9kJkBvd4=;
        b=UrMj7C6XtGSTo6uHYdRyOlDW5Fg2sh26KOfwE2vxJSeEoAvnOd+LPbxgHywyRA2D56
         TKtkovKP7vb2cLRXOwy2xbAxGjT1x/brMowe49cuoQImHCt0Yxei1jkY5P0ta4cp+oon
         tTgNJa5o8VHpCof5SY4hw/WVlV2h1LaV9I42CFgy5l+ovIzytAojd5dnpPFkozsMECXR
         uHgPMPf2/epyj7Nw5eOqd6YkpospBd3SbJkXXzKvYI6fuQ/eVTOyi2QdD5e2L/G+w6f4
         YlEBTCBFyqjdc38bSjSlNHIBSnPV/MNi9bJw/eik95SnDbOOcmhY72acKivVoWG0Yw9V
         IXKg==
X-Gm-Message-State: AOAM533R4HzkKKa7Ahm6eAeVNho5Sqm8xMedrrarhKe0mV48fNmnXrbz
        PMXyCflapgEbSZwyhWlBMZ1ikA==
X-Google-Smtp-Source: ABdhPJxX4oBOi4XZ4/ASodwXUw6WkJOCcXTAD78Eb8DbrWCph+BR1RI5YlQIRcgozsWUGHs463v0AA==
X-Received: by 2002:a63:3d48:: with SMTP id k69mr20037675pga.239.1618985005695;
        Tue, 20 Apr 2021 23:03:25 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id nh24sm887161pjb.38.2021.04.20.23.03.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Apr 2021 23:03:25 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mhocko@suse.com, osalvador@suse.de
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: hugetlb: fix a race between memory-failure/soft_offline and gather_surplus_pages
Date:   Wed, 21 Apr 2021 14:02:59 +0800
Message-Id: <20210421060259.67554-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The possible bad scenario:

CPU0:                           CPU1:

                                gather_surplus_pages()
                                  page = alloc_surplus_huge_page()
memory_failure_hugetlb()
  get_hwpoison_page(page)
    __get_hwpoison_page(page)
      get_page_unless_zero(page)
                                  zero = put_page_testzero(page)
                                  VM_BUG_ON_PAGE(!zero, page)
                                  enqueue_huge_page(h, page)
  put_page(page)

The refcount can possibly be increased by memory-failure or soft_offline
handlers, we can trigger VM_BUG_ON_PAGE and wrongly add the page to the
hugetlb pool list.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3476aa06da70..6c96332db34b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2145,17 +2145,14 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 
 	/* Free the needed pages to the hugetlb pool */
 	list_for_each_entry_safe(page, tmp, &surplus_list, lru) {
-		int zeroed;
-
 		if ((--needed) < 0)
 			break;
 		/*
-		 * This page is now managed by the hugetlb allocator and has
-		 * no users -- drop the buddy allocator's reference.
+		 * The refcount can possibly be increased by memory-failure or
+		 * soft_offline handlers.
 		 */
-		zeroed = put_page_testzero(page);
-		VM_BUG_ON_PAGE(!zeroed, page);
-		enqueue_huge_page(h, page);
+		if (likely(put_page_testzero(page)))
+			enqueue_huge_page(h, page);
 	}
 free:
 	spin_unlock_irq(&hugetlb_lock);
-- 
2.11.0

