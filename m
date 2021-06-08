Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0840839EF71
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhFHHXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 03:23:17 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:5283 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHHXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 03:23:14 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FzhP91V7zz1BK4q;
        Tue,  8 Jun 2021 15:16:29 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 15:21:19 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 15:21:19 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] mm: remove leading spaces before tabs
Date:   Tue, 8 Jun 2021 15:21:15 +0800
Message-ID: <20210608072115.12793-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) Run the following command to find and remove the leading spaces before
   tabs:
   find mm/ -type f | xargs sed -r -i 's/^[ ]+\t/\t/'
2) Manually check and correct if necessary

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 mm/vmscan.c | 2 +-
 mm/vmstat.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index eb314525c889..f2e4377bcbfc 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4302,7 +4302,7 @@ static int __init kswapd_init(void)
 
 	swap_setup();
 	for_each_node_state(nid, N_MEMORY)
- 		kswapd_run(nid);
+		kswapd_run(nid);
 	return 0;
 }
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index b0534e068166..d7e94b4a95ee 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -200,7 +200,7 @@ int calculate_normal_threshold(struct zone *zone)
 	 * The threshold scales with the number of processors and the amount
 	 * of memory per zone. More memory means that we can defer updates for
 	 * longer, more processors could lead to more contention.
- 	 * fls() is used to have a cheap way of logarithmic scaling.
+	 * fls() is used to have a cheap way of logarithmic scaling.
 	 *
 	 * Some sample thresholds:
 	 *
-- 
2.25.1


