Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758443EA224
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 11:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbhHLJgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 05:36:09 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:60910 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236153AbhHLJf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 05:35:58 -0400
X-UUID: 3cf6e16619e44f7ca6369979c37f6d84-20210812
X-UUID: 3cf6e16619e44f7ca6369979c37f6d84-20210812
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 430807177; Thu, 12 Aug 2021 17:35:24 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 Aug 2021 17:35:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 Aug 2021 17:35:22 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Wendell Lin <wendell.lin@mediatek.com>,
        Hanks Chen <hanks.chen@mediatek.com>,
        <inux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH 4/4] clk: mediatek: use tristate for COMMON_CLK_MEDAITEK and COMMON_CLK_MT6779
Date:   Thu, 12 Aug 2021 17:35:19 +0800
Message-ID: <20210812093519.3550-5-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210812093519.3550-1-miles.chen@mediatek.com>
References: <20210812093519.3550-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we have all necessary exported symbols, change
COMMON_CLK_MEDAITEK and COMMON_CLK_MT6779* to tristate.

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 886e2d9fced5..62ed2054a849 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -6,7 +6,7 @@ menu "Clock driver for MediaTek SoC"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 
 config COMMON_CLK_MEDIATEK
-	bool
+	tristate
 	select RESET_CONTROLLER
 	help
 	  MediaTek SoCs' clock support.
@@ -204,7 +204,7 @@ config COMMON_CLK_MT6765_MIPI2BSYS
          This driver supports MediaTek MT6765 mipi2bsys clocks.
 
 config COMMON_CLK_MT6779
-	bool "Clock driver for MediaTek MT6779"
+	tristate "Clock driver for MediaTek MT6779"
 	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
 	select COMMON_CLK_MEDIATEK
 	default ARCH_MEDIATEK && ARM64
@@ -212,49 +212,49 @@ config COMMON_CLK_MT6779
 	  This driver supports MediaTek MT6779 basic clocks.
 
 config COMMON_CLK_MT6779_MMSYS
-	bool "Clock driver for MediaTek MT6779 mmsys"
+	tristate "Clock driver for MediaTek MT6779 mmsys"
 	depends on COMMON_CLK_MT6779
 	help
 	  This driver supports MediaTek MT6779 mmsys clocks.
 
 config COMMON_CLK_MT6779_IMGSYS
-	bool "Clock driver for MediaTek MT6779 imgsys"
+	tristate "Clock driver for MediaTek MT6779 imgsys"
 	depends on COMMON_CLK_MT6779
 	help
 	  This driver supports MediaTek MT6779 imgsys clocks.
 
 config COMMON_CLK_MT6779_IPESYS
-	bool "Clock driver for MediaTek MT6779 ipesys"
+	tristate "Clock driver for MediaTek MT6779 ipesys"
 	depends on COMMON_CLK_MT6779
 	help
 	  This driver supports MediaTek MT6779 ipesys clocks.
 
 config COMMON_CLK_MT6779_CAMSYS
-	bool "Clock driver for MediaTek MT6779 camsys"
+	tristate "Clock driver for MediaTek MT6779 camsys"
 	depends on COMMON_CLK_MT6779
 	help
 	  This driver supports MediaTek MT6779 camsys clocks.
 
 config COMMON_CLK_MT6779_VDECSYS
-	bool "Clock driver for MediaTek MT6779 vdecsys"
+	tristate "Clock driver for MediaTek MT6779 vdecsys"
 	depends on COMMON_CLK_MT6779
 	help
 	  This driver supports MediaTek MT6779 vdecsys clocks.
 
 config COMMON_CLK_MT6779_VENCSYS
-	bool "Clock driver for MediaTek MT6779 vencsys"
+	tristate "Clock driver for MediaTek MT6779 vencsys"
 	depends on COMMON_CLK_MT6779
 	help
 	  This driver supports MediaTek MT6779 vencsys clocks.
 
 config COMMON_CLK_MT6779_MFGCFG
-	bool "Clock driver for MediaTek MT6779 mfgcfg"
+	tristate "Clock driver for MediaTek MT6779 mfgcfg"
 	depends on COMMON_CLK_MT6779
 	help
 	  This driver supports MediaTek MT6779 mfgcfg clocks.
 
 config COMMON_CLK_MT6779_AUDSYS
-	bool "Clock driver for Mediatek MT6779 audsys"
+	tristate "Clock driver for Mediatek MT6779 audsys"
 	depends on COMMON_CLK_MT6779
 	help
 	  This driver supports Mediatek MT6779 audsys clocks.
-- 
2.18.0

