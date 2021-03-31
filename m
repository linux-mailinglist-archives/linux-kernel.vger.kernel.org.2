Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C4734FD71
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbhCaJvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:51:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14978 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbhCaJud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:50:33 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F9M2M3yjtzyN9Y
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 17:48:27 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Wed, 31 Mar 2021
 17:50:28 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <khalasa@piap.pl>
Subject: [PATCH -next] soc: ixp4xx: qmgr: Use DEFINE_SPINLOCK() for spinlock
Date:   Wed, 31 Mar 2021 17:53:41 +0800
Message-ID: <20210331095341.2175046-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/soc/ixp4xx/ixp4xx-qmgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/ixp4xx/ixp4xx-qmgr.c b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
index 8c968382cea7..dde3b668eb40 100644
--- a/drivers/soc/ixp4xx/ixp4xx-qmgr.c
+++ b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
@@ -16,7 +16,7 @@
 static struct qmgr_regs __iomem *qmgr_regs;
 static int qmgr_irq_1;
 static int qmgr_irq_2;
-static spinlock_t qmgr_lock;
+static DEFINE_SPINLOCK(qmgr_lock);
 static u32 used_sram_bitmap[4]; /* 128 16-dword pages */
 static void (*irq_handlers[QUEUES])(void *pdev);
 static void *irq_pdevs[QUEUES];
@@ -434,7 +434,6 @@ static int ixp4xx_qmgr_probe(struct platform_device *pdev)
 	}
 
 	used_sram_bitmap[0] = 0xF; /* 4 first pages reserved for config */
-	spin_lock_init(&qmgr_lock);
 
 	dev_info(dev, "IXP4xx Queue Manager initialized.\n");
 	return 0;
-- 
2.25.1

