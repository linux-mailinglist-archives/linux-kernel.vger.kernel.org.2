Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE553104EC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 07:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhBEG0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 01:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBEG0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 01:26:21 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2564C061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 22:25:41 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gx20so3231315pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 22:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2db/qy51H5/26DTsBdgwD9VocgaNXW9d6RZG/+w8f64=;
        b=M9Wqk2ZmdVe3IJZ3S6Ys4n+UspDDeCho4IySNEw+is5gJAwcgNcFxMseJA/P0ZxD62
         /aVzgbgsHyP9p2D0xAhqk5eRkwfNDbKMfqTEvsFngzza3dcBztkkFGJ2dJVCkrNKyXoh
         W3io9fI4YwXwaLMtuLtl36RjRDtQB3IY0BCR8HbMFL4Cf7poD/qy1+zEYNQm085NPI6F
         aamQrZJBfb/zKeG4hRz9MLRuPnlYEUqhCzvBPVRKEx3RziWNhQdKHpCdzF9DMIT1LoHf
         eFrOpjOKxnktGBYKySKtY4gDq1FGXJ1VsgCa4QouP3dY97Uc4BaVjdAMITrwkcRwv8W3
         ZVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2db/qy51H5/26DTsBdgwD9VocgaNXW9d6RZG/+w8f64=;
        b=T++IosYRHBd/V16bmSuImx42VZgRc9K6T5qX7F14B4HFwVqUn18W4+S9IqFzeVwSpE
         3sJDoWnx5jWNDZvmMFTzhNiEmQZb8kXTcWF7GI6sp8ZWJ8Y3QCb+h72sq3u4+Xc9kKw1
         V7lNw92muJXTen9B57C8IYwy9E8614adWPfQzBHf0HsCDVpXI7dEWMf6aUD8sTdffkRC
         SKcAtdxiktoZp2zDY77SgUrisnf435f5jwYtms+ZeIg3fXVNNgnQmDyuaCGdyjxRKw7X
         mqEoA/MIqanFZJpGXvXeUkgVTI6V0Iv6mPH61MbmEdorXHLhNtQDRe/t+b5j3QDvaVNh
         DyIw==
X-Gm-Message-State: AOAM5324hsV/UCoIC2I1AuNRxOBlRVA1NQexRv7pUZApVkvGpsq3j1AI
        nKM6k1OFJK5B34/D9KCRN+iTTQ==
X-Google-Smtp-Source: ABdhPJyE5y2hjatYWPHnsvgXRVMYuX8uOxtwLHxyiZih6cKlLFdkNifx0kpMww7NhTaakFtgz0m0bg==
X-Received: by 2002:a17:902:6b89:b029:da:fc41:baec with SMTP id p9-20020a1709026b89b02900dafc41baecmr2897857plk.39.1612506341412;
        Thu, 04 Feb 2021 22:25:41 -0800 (PST)
Received: from localhost.localdomain ([240e:b1:e401:3::f])
        by smtp.gmail.com with ESMTPSA id k31sm9278444pgi.5.2021.02.04.22.25.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 22:25:40 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: memcontrol: fix missing wakeup oom task
Date:   Fri,  5 Feb 2021 14:23:10 +0800
Message-Id: <20210205062310.74268-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We call memcg_oom_recover() in the uncharge_batch() to wakeup OOM task
when page uncharged, but for the slab pages, we do not do this when page
uncharged. When we drain per cpu stock, we also should do this.

The memcg_oom_recover() is small, so make it inline. And the parameter
of memcg cannot be NULL, so remove the check.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8c035846c7a4..8569f4dbea2a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1925,7 +1925,7 @@ static int memcg_oom_wake_function(wait_queue_entry_t *wait,
 	return autoremove_wake_function(wait, mode, sync, arg);
 }
 
-static void memcg_oom_recover(struct mem_cgroup *memcg)
+static inline void memcg_oom_recover(struct mem_cgroup *memcg)
 {
 	/*
 	 * For the following lockless ->under_oom test, the only required
@@ -1935,7 +1935,7 @@ static void memcg_oom_recover(struct mem_cgroup *memcg)
 	 * achieved by invoking mem_cgroup_mark_under_oom() before
 	 * triggering notification.
 	 */
-	if (memcg && memcg->under_oom)
+	if (memcg->under_oom)
 		__wake_up(&memcg_oom_waitq, TASK_NORMAL, 0, memcg);
 }
 
@@ -2313,6 +2313,7 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 		page_counter_uncharge(&old->memory, stock->nr_pages);
 		if (do_memsw_account())
 			page_counter_uncharge(&old->memsw, stock->nr_pages);
+		memcg_oom_recover(old);
 		stock->nr_pages = 0;
 	}
 
-- 
2.11.0

