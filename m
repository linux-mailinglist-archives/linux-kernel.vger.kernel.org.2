Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24F23599A6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbhDIJoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:44:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16876 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbhDIJnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:43:47 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FGtSS6DQ9zlWSj;
        Fri,  9 Apr 2021 17:41:44 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 17:43:23 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <yebin10@huawei.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] [POWERPC] Rename get_property to of_get_property: use DEFINE_SPINLOCK() for spinlock
Date:   Fri, 9 Apr 2021 17:51:48 +0800
Message-ID: <20210409095148.2294319-1-yebin10@huawei.com>
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
 drivers/macintosh/via-pmu-led.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/macintosh/via-pmu-led.c b/drivers/macintosh/via-pmu-led.c
index ae067ab2373d..2502119cff42 100644
--- a/drivers/macintosh/via-pmu-led.c
+++ b/drivers/macintosh/via-pmu-led.c
@@ -27,7 +27,7 @@
 #include <linux/pmu.h>
 #include <asm/prom.h>
 
-static spinlock_t pmu_blink_lock;
+static DEFINE_SPINLOCK(pmu_blink_lock);
 static struct adb_request pmu_blink_req;
 /* -1: no change, 0: request off, 1: request on */
 static int requested_change;
@@ -105,8 +105,6 @@ static int __init via_pmu_led_init(void)
 		return -ENODEV;
 	}
 	of_node_put(dt);
-
-	spin_lock_init(&pmu_blink_lock);
 	/* no outstanding req */
 	pmu_blink_req.complete = 1;
 	pmu_blink_req.done = pmu_req_done;

