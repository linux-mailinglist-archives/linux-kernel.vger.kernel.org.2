Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CB939D3BC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 06:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhFGEBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 00:01:50 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:43175 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229436AbhFGEBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 00:01:48 -0400
X-UUID: 6727cdbe4d4943f98d4a0835669d16a4-20210607
X-UUID: 6727cdbe4d4943f98d4a0835669d16a4-20210607
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 835169080; Mon, 07 Jun 2021 11:59:53 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 7 Jun 2021 11:59:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Jun 2021 11:59:51 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <mark-pk.tsai@mediatek.com>,
        <yj.chiang@mediatek.com>
Subject: [PATCH] irqchip/irq-mst: Use ARCH_MSTARV7 as default value for MST_IRQ
Date:   Mon, 7 Jun 2021 11:59:43 +0800
Message-ID: <20210607035943.30292-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only TV SoCs of Mediatek products have this controller
which inherit from MStar TV SoCs.
Don't enable it by default if ARCH_MEDIATEK is selected.
Instead, use ARCH_MSTARV7 as default value.

Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 62543a4eccc0..30f578e18a11 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -576,7 +576,7 @@ config LOONGSON_PCH_MSI
 config MST_IRQ
 	bool "MStar Interrupt Controller"
 	depends on ARCH_MEDIATEK || ARCH_MSTARV7 || COMPILE_TEST
-	default ARCH_MEDIATEK
+	default ARCH_MSTARV7
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 	help
-- 
2.18.0

