Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B183599AC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhDIJoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:44:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16861 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbhDIJnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:43:51 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FGtS453T4z7v2s;
        Fri,  9 Apr 2021 17:41:24 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 17:43:27 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <yebin10@huawei.com>, Qiang Zhao <qiang.zhao@nxp.com>,
        Li Yang <leoyang.li@nxp.com>
CC:     <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] soc: fsl: qe: use DEFINE_SPINLOCK() for spinlock
Date:   Fri, 9 Apr 2021 17:51:52 +0800
Message-ID: <20210409095152.2294487-1-yebin10@huawei.com>
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
 drivers/soc/fsl/qe/qe_common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_common.c b/drivers/soc/fsl/qe/qe_common.c
index 654e9246ce6b..a0cb8e746879 100644
--- a/drivers/soc/fsl/qe/qe_common.c
+++ b/drivers/soc/fsl/qe/qe_common.c
@@ -26,7 +26,7 @@
 #include <soc/fsl/qe/qe.h>
 
 static struct gen_pool *muram_pool;
-static spinlock_t cpm_muram_lock;
+static DEFINE_SPINLOCK(cpm_muram_lock);
 static void __iomem *muram_vbase;
 static phys_addr_t muram_pbase;
 
@@ -54,7 +54,6 @@ int cpm_muram_init(void)
 	if (muram_pbase)
 		return 0;
 
-	spin_lock_init(&cpm_muram_lock);
 	np = of_find_compatible_node(NULL, NULL, "fsl,cpm-muram-data");
 	if (!np) {
 		/* try legacy bindings */

