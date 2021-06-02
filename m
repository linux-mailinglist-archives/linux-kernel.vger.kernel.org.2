Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1065F398475
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbhFBIrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:47:00 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6135 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbhFBIq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:46:57 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fw2b71p7GzYnPj;
        Wed,  2 Jun 2021 16:42:27 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 16:45:11 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 2 Jun 2021
 16:45:11 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-i3c@lists.infradead.org>
CC:     <alexandre.belloni@bootlin.com>, <miquel.raynal@bootlin.com>
Subject: [PATCH -next v2] i3c: master: svc: drop free_irq of devm_request_irq allocated irq
Date:   Wed, 2 Jun 2021 16:49:35 +0800
Message-ID: <20210602084935.3977636-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irq allocated with devm_request_irq() will be freed in devm_irq_release(),
using free_irq() in ->remove() will causes a dangling pointer, and a
subsequent double free. So remove the free_irq() in svc_i3c_master_remove().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v2:
  removing free_irq() instead of using devm_free_irq()
---
 drivers/i3c/master/svc-i3c-master.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 1f6ba4221817..eeb49b5d90ef 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1448,7 +1448,6 @@ static int svc_i3c_master_remove(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	free_irq(master->irq, master);
 	clk_disable_unprepare(master->pclk);
 	clk_disable_unprepare(master->fclk);
 	clk_disable_unprepare(master->sclk);
-- 
2.25.1

