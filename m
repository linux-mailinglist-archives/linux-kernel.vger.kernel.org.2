Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B2037F274
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 06:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhEMFAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 01:00:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2464 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhEMFAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 01:00:40 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FgfX00y2HzBv0t
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 12:56:48 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Thu, 13 May 2021
 12:59:26 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>
Subject: [PATCH -next] irqchip/ath79-cpu: ath79_cpu_irq_init() can be static
Date:   Thu, 13 May 2021 13:01:52 +0800
Message-ID: <20210513050152.623951-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ath79_cpu_irq_init() only used within this file. It should be static.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/irqchip/irq-ath79-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ath79-cpu.c b/drivers/irqchip/irq-ath79-cpu.c
index 923e4bba3776..9f6a18f01447 100644
--- a/drivers/irqchip/irq-ath79-cpu.c
+++ b/drivers/irqchip/irq-ath79-cpu.c
@@ -86,7 +86,7 @@ static int __init ar79_cpu_intc_of_init(
 IRQCHIP_DECLARE(ar79_cpu_intc, "qca,ar7100-cpu-intc",
 		ar79_cpu_intc_of_init);
 
-void __init ath79_cpu_irq_init(unsigned irq_wb_chan2, unsigned irq_wb_chan3)
+static void __init ath79_cpu_irq_init(unsigned irq_wb_chan2, unsigned irq_wb_chan3)
 {
 	irq_wb_chan[2] = irq_wb_chan2;
 	irq_wb_chan[3] = irq_wb_chan3;
-- 
2.25.1

