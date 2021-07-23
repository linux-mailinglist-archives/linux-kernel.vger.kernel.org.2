Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7443D3779
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 11:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbhGWIeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 04:34:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231324AbhGWIeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 04:34:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1977E60EE6;
        Fri, 23 Jul 2021 09:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627031695;
        bh=PYhOjM3U3L4syjEUWh9E0orHuZlWWi7EO4f1NsfaMUY=;
        h=From:To:Cc:Subject:Date:From;
        b=fzCplF2Bjn1zy2jXPaVFy34fo7tJvXvCmCxshY+AVvr91nVh4fU70y1jghUwxBXSC
         zqFRxA2z5L1i5J3OOC1LtbfSUzyLZfp7VrkKmcKDpoAqEtak6q4b3tVfYeHxZPRfvn
         GHWDaHJArvcojTVVcDx0V6pECRTPsYyhtvA0Nkv8NWYdQknfdzXkAwmE/jzg9ofzjK
         iquDyxq/yTn+jPUGrso+SRxT4YEufS2jxElASw5lf3pM6T1ygruHh94itxxS9sw3yw
         miD0QMFNR2vgECSQXwVcnK2D1cqpvy6cOTxazSZbMuVfkRqb1KVVF3z4yk+7Iv3ns/
         2saRI1+zWKcHQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx: fix imx_mmdc_probe build failure
Date:   Fri, 23 Jul 2021 11:14:42 +0200
Message-Id: <20210723091450.1694746-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There are two definitions of imx_mmdc_probe(), the function just
gained a third argument, but the empty macro did not get changed
the same way:

arch/arm/mach-imx/mmdc.c: In function 'imx_mmdc_probe':
arch/arm/mach-imx/mmdc.c:575:63: error: macro "imx_mmdc_perf_init" passed 3 arguments, but takes just 2
  575 |         err = imx_mmdc_perf_init(pdev, mmdc_base, mmdc_ipg_clk);
      |                                                               ^
arch/arm/mach-imx/mmdc.c:537: note: macro "imx_mmdc_perf_init" defined here
  537 | #define imx_mmdc_perf_init(pdev, mmdc_base) 0
      |
arch/arm/mach-imx/mmdc.c:575:15: error: 'imx_mmdc_perf_init' undeclared (first use in this function)
  575 |         err = imx_mmdc_perf_init(pdev, mmdc_base, mmdc_ipg_clk);
      |               ^~~~~~~~~~~~~~~~~~

Fixes: f07ec8536580 ("ARM: imx: add missing clk_disable_unprepare()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/mmdc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index 4a6f1359e1e9..5ee43acf3635 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -534,7 +534,7 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
 
 #else
 #define imx_mmdc_remove NULL
-#define imx_mmdc_perf_init(pdev, mmdc_base) 0
+#define imx_mmdc_perf_init(pdev, mmdc_base, ipg_clk) 0
 #endif
 
 static int imx_mmdc_probe(struct platform_device *pdev)
-- 
2.29.2

