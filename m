Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027BF396F2B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhFAIpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:45:51 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3492 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhFAIpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:45:49 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FvQcL45lqzYrlq;
        Tue,  1 Jun 2021 16:41:22 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 16:44:03 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 1 Jun 2021
 16:44:02 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <arnd@arndb.de>, <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] powerpc/spider-pci: Remove set but not used variable 'val'
Date:   Tue, 1 Jun 2021 16:53:19 +0800
Message-ID: <20210601085319.140461-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

arch/powerpc/platforms/cell/spider-pci.c: In function 'spiderpci_io_flush':
arch/powerpc/platforms/cell/spider-pci.c:28:6: warning:
variable ‘val’ set but not used [-Wunused-but-set-variable]

It never used since introduction.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 arch/powerpc/platforms/cell/spider-pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spider-pci.c b/arch/powerpc/platforms/cell/spider-pci.c
index 93ea41680f54..a1c293f42a1f 100644
--- a/arch/powerpc/platforms/cell/spider-pci.c
+++ b/arch/powerpc/platforms/cell/spider-pci.c
@@ -25,10 +25,9 @@ struct spiderpci_iowa_private {
 static void spiderpci_io_flush(struct iowa_bus *bus)
 {
 	struct spiderpci_iowa_private *priv;
-	u32 val;
 
 	priv = bus->private;
-	val = in_be32(priv->regs + SPIDER_PCI_DUMMY_READ);
+	in_be32(priv->regs + SPIDER_PCI_DUMMY_READ);
 	iosync();
 }
 
-- 
2.31.1

