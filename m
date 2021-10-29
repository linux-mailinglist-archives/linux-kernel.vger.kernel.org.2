Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A8943F54D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 05:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhJ2DUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 23:20:49 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:26204 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbhJ2DUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 23:20:48 -0400
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HgSJk33bRz8ttm;
        Fri, 29 Oct 2021 11:16:54 +0800 (CST)
Received: from huawei.com (10.67.174.47) by dggeme756-chm.china.huawei.com
 (10.3.19.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Fri, 29
 Oct 2021 11:18:17 +0800
From:   He Ying <heying24@huawei.com>
To:     <galak@kernel.crashing.org>, <timur@freescale.com>, <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] fsl_hypervisor: Add missing of_node_put in fsl_hypervisor_init
Date:   Thu, 28 Oct 2021 23:20:02 -0400
Message-ID: <20211029032002.97355-1-heying24@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.47]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Early exits from for_each_compatible_node() should decrement the
node reference counter.

Signed-off-by: He Ying <heying24@huawei.com>
Fixes: 6db7199407ca ("drivers/virt: introduce Freescale hypervisor management driver")
---
 drivers/virt/fsl_hypervisor.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
index 46ee0a0998b6..ef5fcca4b8f0 100644
--- a/drivers/virt/fsl_hypervisor.c
+++ b/drivers/virt/fsl_hypervisor.c
@@ -849,8 +849,10 @@ static int __init fsl_hypervisor_init(void)
 		}
 
 		dbisr = kzalloc(sizeof(*dbisr), GFP_KERNEL);
-		if (!dbisr)
+		if (!dbisr) {
+			of_node_put(np);
 			goto out_of_memory;
+		}
 
 		dbisr->irq = irq;
 		dbisr->doorbell = be32_to_cpup(handle);
-- 
2.17.1

