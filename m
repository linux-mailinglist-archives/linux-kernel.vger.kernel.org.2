Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D36E359271
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhDIDE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:04:58 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:23754 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232808AbhDIDE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:04:57 -0400
X-UUID: 5c1cbd39943040bdb0c14a463941dfbd-20210409
X-UUID: 5c1cbd39943040bdb0c14a463941dfbd-20210409
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1781727207; Fri, 09 Apr 2021 11:04:41 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Apr 2021 11:04:36 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 9 Apr 2021 11:04:35 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [PATCH] irqchip: gic-pm: remove redundant error log of clock bulk
Date:   Fri, 9 Apr 2021 11:04:34 +0800
Message-ID: <1617937474-24630-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 82C02DB886B3FBC54326E2529E8B78A4DEC5522B254D3F3867331FD65CFD9C9A2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is error log in clk_bulk_prepare/enable()

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/irqchip/irq-gic-pm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-pm.c b/drivers/irqchip/irq-gic-pm.c
index 1337cec..b60e185 100644
--- a/drivers/irqchip/irq-gic-pm.c
+++ b/drivers/irqchip/irq-gic-pm.c
@@ -30,10 +30,8 @@ static int gic_runtime_resume(struct device *dev)
 	int ret;
 
 	ret = clk_bulk_prepare_enable(data->num_clocks, chip_pm->clks);
-	if (ret) {
-		dev_err(dev, "clk_enable failed: %d\n", ret);
+	if (ret)
 		return ret;
-	}
 
 	/*
 	 * On the very first resume, the pointer to chip_pm->chip_data
-- 
1.8.1.1.dirty

