Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2163FE578
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 00:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244668AbhIAW0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 18:26:30 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:56442 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S242381AbhIAW02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 18:26:28 -0400
X-UUID: 6b304a5842714f50863ad1efca0ad49b-20210902
X-UUID: 6b304a5842714f50863ad1efca0ad49b-20210902
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 318286613; Thu, 02 Sep 2021 06:25:28 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Sep 2021 06:25:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Sep 2021 06:25:27 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Wendell Lin <wendell.lin@mediatek.com>,
        Hanks Chen <hanks.chen@mediatek.com>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 3/3] clk: mediatek: support COMMON_CLK_MT6779 module build
Date:   Thu, 2 Sep 2021 06:25:26 +0800
Message-ID: <20210901222526.31065-4-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210901222526.31065-1-miles.chen@mediatek.com>
References: <20210901222526.31065-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support COMMON_CLK_MT6779* module build,
add MODULE_LICENSE and export necessary symbols.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Hanks Chen <hanks.chen@mediatek.com>
Cc: Wendell Lin <wendell.lin@mediatek.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/Kconfig           | 18 +++++++++---------
 drivers/clk/mediatek/clk-mt6779-aud.c  |  4 +++-
 drivers/clk/mediatek/clk-mt6779-cam.c  |  4 +++-
 drivers/clk/mediatek/clk-mt6779-img.c  |  4 +++-
 drivers/clk/mediatek/clk-mt6779-ipe.c  |  4 +++-
 drivers/clk/mediatek/clk-mt6779-mfg.c  |  4 +++-
 drivers/clk/mediatek/clk-mt6779-mm.c   |  4 +++-
 drivers/clk/mediatek/clk-mt6779-vdec.c |  4 +++-
 drivers/clk/mediatek/clk-mt6779-venc.c |  4 +++-
 drivers/clk/mediatek/clk-mt6779.c      |  2 ++
 10 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index d42e1823a945..62ed2054a849 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
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
diff --git a/drivers/clk/mediatek/clk-mt6779-aud.c b/drivers/clk/mediatek/clk-mt6779-aud.c
index 11b209f95e25..9e889e4c361a 100644
--- a/drivers/clk/mediatek/clk-mt6779-aud.c
+++ b/drivers/clk/mediatek/clk-mt6779-aud.c
@@ -4,6 +4,7 @@
  * Author: Wendell Lin <wendell.lin@mediatek.com>
  */
 
+#include <linux/module.h>
 #include <linux/clk-provider.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -114,4 +115,5 @@ static struct platform_driver clk_mt6779_aud_drv = {
 	},
 };
 
-builtin_platform_driver(clk_mt6779_aud_drv);
+module_platform_driver(clk_mt6779_aud_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6779-cam.c b/drivers/clk/mediatek/clk-mt6779-cam.c
index 244d4208b7fb..7f07a2a139ac 100644
--- a/drivers/clk/mediatek/clk-mt6779-cam.c
+++ b/drivers/clk/mediatek/clk-mt6779-cam.c
@@ -4,6 +4,7 @@
  * Author: Wendell Lin <wendell.lin@mediatek.com>
  */
 
+#include <linux/module.h>
 #include <linux/clk-provider.h>
 #include <linux/platform_device.h>
 #include <dt-bindings/clock/mt6779-clk.h>
@@ -63,4 +64,5 @@ static struct platform_driver clk_mt6779_cam_drv = {
 	},
 };
 
-builtin_platform_driver(clk_mt6779_cam_drv);
+module_platform_driver(clk_mt6779_cam_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6779-img.c b/drivers/clk/mediatek/clk-mt6779-img.c
index 26292a45c613..f0961fa1a286 100644
--- a/drivers/clk/mediatek/clk-mt6779-img.c
+++ b/drivers/clk/mediatek/clk-mt6779-img.c
@@ -4,6 +4,7 @@
  * Author: Wendell Lin <wendell.lin@mediatek.com>
  */
 
+#include <linux/module.h>
 #include <linux/clk-provider.h>
 #include <linux/platform_device.h>
 #include <dt-bindings/clock/mt6779-clk.h>
@@ -55,4 +56,5 @@ static struct platform_driver clk_mt6779_img_drv = {
 	},
 };
 
-builtin_platform_driver(clk_mt6779_img_drv);
+module_platform_driver(clk_mt6779_img_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6779-ipe.c b/drivers/clk/mediatek/clk-mt6779-ipe.c
index bb519075639c..8c6f3e154bf3 100644
--- a/drivers/clk/mediatek/clk-mt6779-ipe.c
+++ b/drivers/clk/mediatek/clk-mt6779-ipe.c
@@ -4,6 +4,7 @@
  * Author: Wendell Lin <wendell.lin@mediatek.com>
  */
 
+#include <linux/module.h>
 #include <linux/clk-provider.h>
 #include <linux/platform_device.h>
 #include <dt-bindings/clock/mt6779-clk.h>
@@ -57,4 +58,5 @@ static struct platform_driver clk_mt6779_ipe_drv = {
 	},
 };
 
-builtin_platform_driver(clk_mt6779_ipe_drv);
+module_platform_driver(clk_mt6779_ipe_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6779-mfg.c b/drivers/clk/mediatek/clk-mt6779-mfg.c
index c6ee2a89c070..9f3372886e6b 100644
--- a/drivers/clk/mediatek/clk-mt6779-mfg.c
+++ b/drivers/clk/mediatek/clk-mt6779-mfg.c
@@ -4,6 +4,7 @@
  * Author: Wendell Lin <wendell.lin@mediatek.com>
  */
 
+#include <linux/module.h>
 #include <linux/clk-provider.h>
 #include <linux/platform_device.h>
 
@@ -52,4 +53,5 @@ static struct platform_driver clk_mt6779_mfg_drv = {
 	},
 };
 
-builtin_platform_driver(clk_mt6779_mfg_drv);
+module_platform_driver(clk_mt6779_mfg_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6779-mm.c b/drivers/clk/mediatek/clk-mt6779-mm.c
index 059c1a41ac7a..33946e647122 100644
--- a/drivers/clk/mediatek/clk-mt6779-mm.c
+++ b/drivers/clk/mediatek/clk-mt6779-mm.c
@@ -4,6 +4,7 @@
  * Author: Wendell Lin <wendell.lin@mediatek.com>
  */
 
+#include <linux/module.h>
 #include <linux/clk-provider.h>
 #include <linux/platform_device.h>
 #include <dt-bindings/clock/mt6779-clk.h>
@@ -105,4 +106,5 @@ static struct platform_driver clk_mt6779_mm_drv = {
 	},
 };
 
-builtin_platform_driver(clk_mt6779_mm_drv);
+module_platform_driver(clk_mt6779_mm_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6779-vdec.c b/drivers/clk/mediatek/clk-mt6779-vdec.c
index 1900da2586a1..f4358844c2e0 100644
--- a/drivers/clk/mediatek/clk-mt6779-vdec.c
+++ b/drivers/clk/mediatek/clk-mt6779-vdec.c
@@ -4,6 +4,7 @@
  * Author: Wendell Lin <wendell.lin@mediatek.com>
  */
 
+#include <linux/module.h>
 #include <linux/clk-provider.h>
 #include <linux/platform_device.h>
 
@@ -64,4 +65,5 @@ static struct platform_driver clk_mt6779_vdec_drv = {
 	},
 };
 
-builtin_platform_driver(clk_mt6779_vdec_drv);
+module_platform_driver(clk_mt6779_vdec_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6779-venc.c b/drivers/clk/mediatek/clk-mt6779-venc.c
index b41d1f859edc..ff67084af5aa 100644
--- a/drivers/clk/mediatek/clk-mt6779-venc.c
+++ b/drivers/clk/mediatek/clk-mt6779-venc.c
@@ -4,6 +4,7 @@
  * Author: Wendell Lin <wendell.lin@mediatek.com>
  */
 
+#include <linux/module.h>
 #include <linux/clk-provider.h>
 #include <linux/platform_device.h>
 
@@ -55,4 +56,5 @@ static struct platform_driver clk_mt6779_venc_drv = {
 	},
 };
 
-builtin_platform_driver(clk_mt6779_venc_drv);
+module_platform_driver(clk_mt6779_venc_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
index 6e0d3a166729..9825385c9f94 100644
--- a/drivers/clk/mediatek/clk-mt6779.c
+++ b/drivers/clk/mediatek/clk-mt6779.c
@@ -4,6 +4,7 @@
  * Author: Wendell Lin <wendell.lin@mediatek.com>
  */
 
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -1314,3 +1315,4 @@ static int __init clk_mt6779_init(void)
 }
 
 arch_initcall(clk_mt6779_init);
+MODULE_LICENSE("GPL");
-- 
2.18.0

