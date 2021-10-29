Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F48F43FAE9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 12:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhJ2Klq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 06:41:46 -0400
Received: from mx.socionext.com ([202.248.49.38]:20602 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231738AbhJ2Kll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 06:41:41 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 29 Oct 2021 19:39:11 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 5B9B8207616C;
        Fri, 29 Oct 2021 19:39:11 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 29 Oct 2021 19:39:11 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id BCA40B62AC;
        Fri, 29 Oct 2021 19:39:10 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 2/8] phy: uniphier-usb3: Add compatible string for NX1 SoC
Date:   Fri, 29 Oct 2021 19:39:01 +0900
Message-Id: <1635503947-18250-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635503947-18250-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1635503947-18250-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic support for UniPhier NX1 SoC. This includes a compatible string
and the same SoC-dependent data as LD20/PXs3 SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/phy/socionext/phy-uniphier-usb3hs.c | 4 ++++
 drivers/phy/socionext/phy-uniphier-usb3ss.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/phy/socionext/phy-uniphier-usb3hs.c b/drivers/phy/socionext/phy-uniphier-usb3hs.c
index a9bc74121f38..8c8673df0084 100644
--- a/drivers/phy/socionext/phy-uniphier-usb3hs.c
+++ b/drivers/phy/socionext/phy-uniphier-usb3hs.c
@@ -447,6 +447,10 @@ static const struct of_device_id uniphier_u3hsphy_match[] = {
 		.compatible = "socionext,uniphier-pxs3-usb3-hsphy",
 		.data = &uniphier_pxs3_data,
 	},
+	{
+		.compatible = "socionext,uniphier-nx1-usb3-hsphy",
+		.data = &uniphier_pxs3_data,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, uniphier_u3hsphy_match);
diff --git a/drivers/phy/socionext/phy-uniphier-usb3ss.c b/drivers/phy/socionext/phy-uniphier-usb3ss.c
index 6700645bcbe6..7ce611c2088b 100644
--- a/drivers/phy/socionext/phy-uniphier-usb3ss.c
+++ b/drivers/phy/socionext/phy-uniphier-usb3ss.c
@@ -328,6 +328,10 @@ static const struct of_device_id uniphier_u3ssphy_match[] = {
 		.compatible = "socionext,uniphier-pxs3-usb3-ssphy",
 		.data = &uniphier_ld20_data,
 	},
+	{
+		.compatible = "socionext,uniphier-nx1-usb3-ssphy",
+		.data = &uniphier_ld20_data,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, uniphier_u3ssphy_match);
-- 
2.7.4

