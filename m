Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40BD37F276
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 07:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhEMFCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 01:02:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2658 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhEMFCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 01:02:45 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FgfZz2hbJzmVJr;
        Thu, 13 May 2021 12:59:23 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Thu, 13 May 2021
 13:01:34 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linusw@kernel.org>
Subject: [PATCH -next] irqchip: ixp4xx: ixp4xx_of_init_irq() can be static
Date:   Thu, 13 May 2021 13:04:01 +0800
Message-ID: <20210513050401.625106-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ixp4xx_of_init_irq() only used within this file. It should be static.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/irqchip/irq-ixp4xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ixp4xx.c b/drivers/irqchip/irq-ixp4xx.c
index 37e0749215c7..09c4dfd1ad01 100644
--- a/drivers/irqchip/irq-ixp4xx.c
+++ b/drivers/irqchip/irq-ixp4xx.c
@@ -365,7 +365,7 @@ void __init ixp4xx_irq_init(resource_size_t irqbase,
 EXPORT_SYMBOL_GPL(ixp4xx_irq_init);
 
 #ifdef CONFIG_OF
-int __init ixp4xx_of_init_irq(struct device_node *np,
+static int __init ixp4xx_of_init_irq(struct device_node *np,
 			      struct device_node *parent)
 {
 	struct ixp4xx_irq *ixi = &ixirq;
-- 
2.25.1

