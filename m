Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B9642655B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 09:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhJHHr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 03:47:27 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13877 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhJHHrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 03:47:23 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HQg8n2vzdz909M;
        Fri,  8 Oct 2021 15:40:41 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Fri, 8 Oct 2021 15:45:23 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Fri, 8 Oct
 2021 15:45:23 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <boris.ostrovsky@oracle.com>, <jgross@suse.com>,
        <sstabellini@kernel.org>
CC:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] xen-pciback: Fix return in pm_ctrl_init()
Date:   Fri, 8 Oct 2021 15:44:17 +0800
Message-ID: <20211008074417.8260-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return NULL instead of passing to ERR_PTR while err is zero,
this fix smatch warnings:
drivers/xen/xen-pciback/conf_space_capability.c:163
 pm_ctrl_init() warn: passing zero to 'ERR_PTR'

Fixes: a92336a1176b ("xen/pciback: Drop two backends, squash and cleanup some code.")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/xen/xen-pciback/conf_space_capability.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xen-pciback/conf_space_capability.c b/drivers/xen/xen-pciback/conf_space_capability.c
index 22f13abbe913..5e53b4817f16 100644
--- a/drivers/xen/xen-pciback/conf_space_capability.c
+++ b/drivers/xen/xen-pciback/conf_space_capability.c
@@ -160,7 +160,7 @@ static void *pm_ctrl_init(struct pci_dev *dev, int offset)
 	}
 
 out:
-	return ERR_PTR(err);
+	return err ? ERR_PTR(err) : NULL;
 }
 
 static const struct config_field caplist_pm[] = {
-- 
2.17.1

