Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF873599A0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbhDIJnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:43:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16120 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbhDIJnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:43:41 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGtRv0jpsz19L9r;
        Fri,  9 Apr 2021 17:41:15 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 17:43:20 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <yebin10@huawei.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] macintosh/via-pmu: Use DEFINE_SPINLOCK() for spinlock
Date:   Fri, 9 Apr 2021 17:51:45 +0800
Message-ID: <20210409095145.2294210-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/macintosh/via-pmu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 73e6ae88fafd..bab913e3541a 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -161,7 +161,7 @@ static unsigned char __iomem *gpio_reg;
 static int gpio_irq = 0;
 static int gpio_irq_enabled = -1;
 static volatile int pmu_suspended;
-static spinlock_t pmu_lock;
+static DEFINE_SPINLOCK(pmu_lock);
 static u8 pmu_intr_mask;
 static int pmu_version;
 static int drop_interrupts;
@@ -306,8 +306,6 @@ int __init find_via_pmu(void)
 		goto fail;
 	}
 
-	spin_lock_init(&pmu_lock);
-
 	pmu_has_adb = 1;
 
 	pmu_intr_mask =	PMU_INT_PCEJECT |
@@ -389,8 +387,6 @@ int __init find_via_pmu(void)
 
 	pmu_kind = PMU_UNKNOWN;
 
-	spin_lock_init(&pmu_lock);
-
 	pmu_has_adb = 1;
 
 	pmu_intr_mask =	PMU_INT_PCEJECT |

