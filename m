Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6D044FD79
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 04:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbhKOD3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 22:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236604AbhKOD3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 22:29:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C09C061767;
        Sun, 14 Nov 2021 19:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=kakjXWrVPjIpWA4NzfTn4ZMWF2F5iG3NP2+aAwPTtfI=; b=BlMmvMFvUDyEGaT7hp7h+KajhG
        R22K1iX9yWKfMbpK0XJE8sbs6ne9MePlGbOkpb3oXBvRnQTW6CnWm85P9Mf+G13tHvUIJOZO2Tv8H
        JDMOzLg0QSEnWbpy2U0lonfmoZWZAu6SKqa+Q4A9fnx3Yl2viZC6FgoYILzk5Ea6p/icYLd5IyDGs
        koSvj40V16ASuEHHYNgewS7ffjTkF9mZB63df0mKHZkSbTfm/gADCr+AIQIUpcJQ67ICmHcc8JC5Z
        DLwjeLWrCKd6zuss79/G0MusnhkWVaRApuuhWICmlOQF+dgnReAlOjIHKyuemda3QJKgh8sVsPdKh
        keUuj77w==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmSdE-00EJ3U-87; Mon, 15 Nov 2021 03:26:08 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Abel Vesa <abel.vesa@nxp.com>, linux-clk@vger.kernel.org,
        linux-imx@nxp.com, Alexander Shiyan <shc_work@mail.ru>,
        Shawn Guo <shawn.guo@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] clk: imx: pllv1: fix kernel-doc notation for struct clk_pllv1
Date:   Sun, 14 Nov 2021 19:26:07 -0800
Message-Id: <20211115032607.28970-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert struct clk_pllv1 comments to kernel-doc notation and move them
below the MFN_* macros.

Fixes this kernel-doc warning:

drivers/clk/imx/clk-pllv1.c:12: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * pll v1

Fixes: 2af9e6db14db ("ARM i.MX: Add common clock support for pllv1")
Fixes: a594790368a8 ("ARM: imx: pllv1: Fix PLL calculation for i.MX27")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Abel Vesa <abel.vesa@nxp.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-imx@nxp.com
Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/imx/clk-pllv1.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- linux-next-20211102.orig/drivers/clk/imx/clk-pllv1.c
+++ linux-next-20211102/drivers/clk/imx/clk-pllv1.c
@@ -8,20 +8,19 @@
 
 #include "clk.h"
 
+#define MFN_BITS	(10)
+#define MFN_SIGN	(BIT(MFN_BITS - 1))
+#define MFN_MASK	(MFN_SIGN - 1)
+
 /**
- * pll v1
+ * struct clk_pllv1 - IMX PLLv1 clock descriptor
  *
- * @clk_hw	clock source
- * @parent	the parent clock name
- * @base	base address of pll registers
+ * @hw:		clock source
+ * @base:	base address of pll registers
+ * @type:	type of IMX_PLLV1
  *
  * PLL clock version 1, found on i.MX1/21/25/27/31/35
  */
-
-#define MFN_BITS	(10)
-#define MFN_SIGN	(BIT(MFN_BITS - 1))
-#define MFN_MASK	(MFN_SIGN - 1)
-
 struct clk_pllv1 {
 	struct clk_hw	hw;
 	void __iomem	*base;
