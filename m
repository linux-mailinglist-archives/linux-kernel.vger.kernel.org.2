Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544953C9F66
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 15:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbhGON0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 09:26:16 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:42114
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235177AbhGON0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 09:26:15 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 768B1408AD;
        Thu, 15 Jul 2021 13:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626355401;
        bh=Uwn776T1F4J+gds7fS/Yo8RJJ52hlWTCH+h60abETp0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=wXPiAyTIzM25I4kfDrLYfRwNhHooYlC296Xd3HbxjujuZiIQUX0T+Ui5IOri0saU7
         UgJY4UtcFbeLNwWpqz3GYLQonlQb6YsBjx+0ZX9CZeVrnTzmDcGyDUU+5UnYJu6VxI
         kxEq8CeDsZi/RhSGo46L3oI4HItrxvh92meKxgn+SkJ1sbS4y70HSPb5Qq/a2wD/gl
         hjnJ5+g+IqCY+5bgf+CSvU5ZWBTICK/qW9mc+lMcQbeQAbT/5Ij5zrFAPkHTa6qPLq
         xZHVaTH3OGKaIYC6bMwgC1McT3QwSWDhn6ykJesEnXHasIxPfsqSswbZSAhMJPQeVa
         V1iSzHuFrjq/w==
From:   Colin King <colin.king@canonical.com>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx: fix missing 3rd argument in macro imx_mmdc_perf_init
Date:   Thu, 15 Jul 2021 14:23:21 +0100
Message-Id: <20210715132321.25388-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The function imx_mmdc_perf_init recently had a 3rd argument added to
it but the equivalent macro was not updated and is still the older
2 argument version. Fix this by adding in the missing 3rd argumement
mmdc_ipg_clk.

Fixes: f07ec8536580 ("ARM: imx: add missing clk_disable_unprepare()")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/arm/mach-imx/mmdc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index 4a6f1359e1e9..af12668d0bf5 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -534,7 +534,7 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
 
 #else
 #define imx_mmdc_remove NULL
-#define imx_mmdc_perf_init(pdev, mmdc_base) 0
+#define imx_mmdc_perf_init(pdev, mmdc_base, mmdc_ipg_clk) 0
 #endif
 
 static int imx_mmdc_probe(struct platform_device *pdev)
-- 
2.31.1

