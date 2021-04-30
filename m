Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04463702A4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 23:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbhD3VIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 17:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhD3VIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 17:08:36 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D758BC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 14:07:47 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k3-20020a17090ad083b0290155b934a295so2415869pju.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 14:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=53bzAf1u6JW5+ZWhmzMnt7EtP/jXlqbD8WQc/gJHHsU=;
        b=JmsMhoTpI0+TSwVGnU4CF2vZzkoRyGe/DvdJjvEhutMZ1eRxJXQHQOVEauAnHhJp4F
         1nWQogpFyj8imgLEZWUuewf1cpy4MjclZ0g8lQ2EyCU4SwnFN/4NL7MfTkEfVCDVs3+Q
         0ENcaxTlnGvnQ/tDLU1K86u9ug7Vj1s9VDkfl3Ua1/14L6tvZAZNjG1lFUkugEXrb7lX
         ArdkBg75K19ybReQV4x8S4vEzZwihKJS8AJNpkDBIG+z5OeTBlfYpeL8UEHCNmQGHzpg
         SixvO1Og3gWAe7ytI5dH0xUd866GXCPMA4l4jS1s9f/Z+SgPvWiUeMtFDZZdziDvDygJ
         9e2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=53bzAf1u6JW5+ZWhmzMnt7EtP/jXlqbD8WQc/gJHHsU=;
        b=SmkPNdrNVWTUhF5sw0MO6q5ZzXMFXDW+izhvBSWrD5/SrthsQbymQ37FZuNlOU74HW
         TXCMwbw2huSC9skzDserEf+Vw9bIxW+k2Wlm3F98OI8gS2OffvMN4bTmmgRjg+79Ywia
         K/XYFa4ukeh+IalpDD8YzmZcUXeWcl9uOiY+pfba2e1Bc+Y9TFt7RoEVi3wVsWleyqGF
         JNW7RRbA8vXkxXjQHK4n7TrwlHB3Qc4p0vdUSiRn5vU8Ua2kY1VcIxMwEuGjjI8efwtG
         1ZScVOaxD/AM8y/vO0iSEYi/TeMbQTaSXWmDqUSVu0musIiKeZ0iK9AZbEhOUz+r74u9
         CNEw==
X-Gm-Message-State: AOAM531v/vOjE1foBbl1t89gzGtLfOwOK8N9Y1hEnEZjobOTL8b6Ds+E
        j9u/7b7RD6lGFGwt7XM/RiU=
X-Google-Smtp-Source: ABdhPJzkU6Vr1uJDTQW28yS3VNZ/g/UPHb8qUUGaniLy4HHglcude70O4HJsgRRIgWAZSON2M8K+Fw==
X-Received: by 2002:a17:902:7281:b029:ea:afe2:b356 with SMTP id d1-20020a1709027281b02900eaafe2b356mr7284919pll.16.1619816867376;
        Fri, 30 Apr 2021 14:07:47 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id w1sm2746698pfu.153.2021.04.30.14.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 14:07:46 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     kirill.shutemov@linux.intel.com, wangyugui@e16-tech.com,
        ziy@nvidia.com, hughd@google.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: thp: check total_mapcount instead of page_mapcount
Date:   Fri, 30 Apr 2021 14:07:44 -0700
Message-Id: <20210430210744.216095-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When debugging the bug reported by Wang Yugui [1], try_to_unmap() may
return false positive for PTE-mapped THP since page_mapcount() is used
to check if the THP is unmapped, but it just checks compound mapount and
head page's mapcount.  If the THP is PTE-mapped and head page is not
mapped, it may return false positive.

Use total_mapcount() instead of page_mapcount() and do so for the
VM_BUG_ON_PAGE in split_huge_page_to_list as well.

[1] https://lore.kernel.org/linux-mm/20210412180659.B9E3.409509F4@e16-tech.com/

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/huge_memory.c | 2 +-
 mm/rmap.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 63ed6b25deaa..2122c3e853b9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2718,7 +2718,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	}
 
 	unmap_page(head);
-	VM_BUG_ON_PAGE(compound_mapcount(head), head);
+	VM_BUG_ON_PAGE(total_mapcount(head), head);
 
 	/* block interrupt reentry in xa_lock and spinlock */
 	local_irq_disable();
diff --git a/mm/rmap.c b/mm/rmap.c
index 693a610e181d..2e547378ab5f 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1777,7 +1777,7 @@ bool try_to_unmap(struct page *page, enum ttu_flags flags)
 	else
 		rmap_walk(page, &rwc);
 
-	return !page_mapcount(page) ? true : false;
+	return !total_mapcount(page) ? true : false;
 }
 
 /**
-- 
2.26.2

