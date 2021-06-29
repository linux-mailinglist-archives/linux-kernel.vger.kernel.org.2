Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510183B6E60
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 08:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhF2Gph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 02:45:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45364 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231881AbhF2Gpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 02:45:36 -0400
X-UUID: 60b45a9c5ce24780a13c88c11ba77ba2-20210629
X-UUID: 60b45a9c5ce24780a13c88c11ba77ba2-20210629
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 69736824; Tue, 29 Jun 2021 14:43:04 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 29 Jun 2021 14:43:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Jun 2021 14:43:02 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fabien Parent <fparent@baylibre.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH] clk: mediatek: make COMMON_CLK_MT8167* depend on COMMON_CLK_MT8167
Date:   Tue, 29 Jun 2021 14:43:01 +0800
Message-ID: <20210629064301.1406-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found that COMMON_CLK_MT8167* do not depend on COMMON_CLK_MT8167,
so it is possible to config:

CONFIG_COMMON_CLK_MT8167=n
CONFIG_COMMON_CLK_MT8167_*=y

Although it does not cause build breaks with such configuration,
I think it is more clear to make COMMON_CLK_MT8167* depend on
COMMON_CLK_MT8167.

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/Kconfig | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 886e2d9fced5..ce6d59e4ca82 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -362,41 +362,36 @@ config COMMON_CLK_MT8167
 
 config COMMON_CLK_MT8167_AUDSYS
 	bool "Clock driver for MediaTek MT8167 audsys"
-	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
-	select COMMON_CLK_MEDIATEK
-	default ARCH_MEDIATEK
+	depends on COMMON_CLK_MT8167
+	default COMMON_CLK_MT8167
 	help
 	  This driver supports MediaTek MT8167 audsys clocks.
 
 config COMMON_CLK_MT8167_IMGSYS
 	bool "Clock driver for MediaTek MT8167 imgsys"
-	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
-	select COMMON_CLK_MEDIATEK
-	default ARCH_MEDIATEK
+	depends on COMMON_CLK_MT8167
+	default COMMON_CLK_MT8167
 	help
 	  This driver supports MediaTek MT8167 imgsys clocks.
 
 config COMMON_CLK_MT8167_MFGCFG
 	bool "Clock driver for MediaTek MT8167 mfgcfg"
-	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
-	select COMMON_CLK_MEDIATEK
-	default ARCH_MEDIATEK
+	depends on COMMON_CLK_MT8167
+	default COMMON_CLK_MT8167
 	help
 	  This driver supports MediaTek MT8167 mfgcfg clocks.
 
 config COMMON_CLK_MT8167_MMSYS
 	bool "Clock driver for MediaTek MT8167 mmsys"
-	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
-	select COMMON_CLK_MEDIATEK
-	default ARCH_MEDIATEK
+	depends on COMMON_CLK_MT8167
+	default COMMON_CLK_MT8167
 	help
 	  This driver supports MediaTek MT8167 mmsys clocks.
 
 config COMMON_CLK_MT8167_VDECSYS
 	bool "Clock driver for MediaTek MT8167 vdecsys"
-	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
-	select COMMON_CLK_MEDIATEK
-	default ARCH_MEDIATEK
+	depends on COMMON_CLK_MT8167
+	default COMMON_CLK_MT8167
 	help
 	  This driver supports MediaTek MT8167 vdecsys clocks.
 
-- 
2.18.0

