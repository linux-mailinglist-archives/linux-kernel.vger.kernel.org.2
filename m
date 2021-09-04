Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D11F400BEA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 17:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbhIDPay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 11:30:54 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33780 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230514AbhIDPax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 11:30:53 -0400
X-UUID: 077bbcf8511b42b4baf87eabcf2261d2-20210904
X-UUID: 077bbcf8511b42b4baf87eabcf2261d2-20210904
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1130274364; Sat, 04 Sep 2021 23:29:49 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 4 Sep 2021 23:29:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 4 Sep 2021 23:29:47 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH v2] clk: imx: use module_platform_driver
Date:   Sat, 4 Sep 2021 23:29:46 +0800
Message-ID: <20210904152946.32042-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace builtin_platform_driver_probe with module_platform_driver_probe
because CONFIG_CLK_IMX8QXP can be set to =m (kernel module).

Fixes: c2cccb6d0b33 ("clk: imx: add imx8qxp clk driver")
Fixes: 1e3121bfe51a ("clk: imx: add imx8qxp lpcg driver")
Cc: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Miles Chen <miles.chen@mediatek.com>

---

Change since v1:
Add Fixes tags

---
 drivers/clk/imx/clk-imx8qxp-lpcg.c | 2 +-
 drivers/clk/imx/clk-imx8qxp.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
index d3e905cf867d..b23758083ce5 100644
--- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
+++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
@@ -370,7 +370,7 @@ static struct platform_driver imx8qxp_lpcg_clk_driver = {
 	.probe = imx8qxp_lpcg_clk_probe,
 };
 
-builtin_platform_driver(imx8qxp_lpcg_clk_driver);
+module_platform_driver(imx8qxp_lpcg_clk_driver);
 
 MODULE_AUTHOR("Aisheng Dong <aisheng.dong@nxp.com>");
 MODULE_DESCRIPTION("NXP i.MX8QXP LPCG clock driver");
diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index c53a688d8ccc..40a2efb1329b 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -308,7 +308,7 @@ static struct platform_driver imx8qxp_clk_driver = {
 	},
 	.probe = imx8qxp_clk_probe,
 };
-builtin_platform_driver(imx8qxp_clk_driver);
+module_platform_driver(imx8qxp_clk_driver);
 
 MODULE_AUTHOR("Aisheng Dong <aisheng.dong@nxp.com>");
 MODULE_DESCRIPTION("NXP i.MX8QXP clock driver");
-- 
2.18.0

