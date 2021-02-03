Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D778130D7FD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 11:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbhBCKzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 05:55:16 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57944 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbhBCKzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 05:55:14 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D6EDE1F45484
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] clk: mediatek: Select all the MT8183 clocks by default
Date:   Wed,  3 Feb 2021 11:54:23 +0100
Message-Id: <20210203105423.682960-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If MT8183 SoC support is enabled, almost all machines will use topckgen,
apmixedsys, infracfg, mcucfg and subsystem clocks, so it feels wrong to
require each one to select that symbols manually.

Instead, enable it whenever COMMON_CLK_MT8183_* is disabled as
a simplification. This would add few KB in the kernel image size but
will make the life a bit easier to the users, anyway you'll need to probably
enable all of them if you want to have proper support for that SoC.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/clk/mediatek/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index ce8475098b31..886e2d9fced5 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -426,66 +426,77 @@ config COMMON_CLK_MT8183
 config COMMON_CLK_MT8183_AUDIOSYS
 	bool "Clock driver for MediaTek MT8183 audiosys"
 	depends on COMMON_CLK_MT8183
+	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 audiosys clocks.
 
 config COMMON_CLK_MT8183_CAMSYS
 	bool "Clock driver for MediaTek MT8183 camsys"
 	depends on COMMON_CLK_MT8183
+	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 camsys clocks.
 
 config COMMON_CLK_MT8183_IMGSYS
 	bool "Clock driver for MediaTek MT8183 imgsys"
 	depends on COMMON_CLK_MT8183
+	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 imgsys clocks.
 
 config COMMON_CLK_MT8183_IPU_CORE0
 	bool "Clock driver for MediaTek MT8183 ipu_core0"
 	depends on COMMON_CLK_MT8183
+	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 ipu_core0 clocks.
 
 config COMMON_CLK_MT8183_IPU_CORE1
 	bool "Clock driver for MediaTek MT8183 ipu_core1"
 	depends on COMMON_CLK_MT8183
+	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 ipu_core1 clocks.
 
 config COMMON_CLK_MT8183_IPU_ADL
 	bool "Clock driver for MediaTek MT8183 ipu_adl"
 	depends on COMMON_CLK_MT8183
+	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 ipu_adl clocks.
 
 config COMMON_CLK_MT8183_IPU_CONN
 	bool "Clock driver for MediaTek MT8183 ipu_conn"
 	depends on COMMON_CLK_MT8183
+	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 ipu_conn clocks.
 
 config COMMON_CLK_MT8183_MFGCFG
 	bool "Clock driver for MediaTek MT8183 mfgcfg"
 	depends on COMMON_CLK_MT8183
+	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 mfgcfg clocks.
 
 config COMMON_CLK_MT8183_MMSYS
 	bool "Clock driver for MediaTek MT8183 mmsys"
 	depends on COMMON_CLK_MT8183
+	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 mmsys clocks.
 
 config COMMON_CLK_MT8183_VDECSYS
 	bool "Clock driver for MediaTek MT8183 vdecsys"
 	depends on COMMON_CLK_MT8183
+	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 vdecsys clocks.
 
 config COMMON_CLK_MT8183_VENCSYS
 	bool "Clock driver for MediaTek MT8183 vencsys"
 	depends on COMMON_CLK_MT8183
+	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 vencsys clocks.
 
-- 
2.30.0

