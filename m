Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F8C421C63
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 04:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhJECMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 22:12:38 -0400
Received: from mx.socionext.com ([202.248.49.38]:53415 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231302AbhJECMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 22:12:34 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 05 Oct 2021 11:10:44 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 1289B2059034;
        Tue,  5 Oct 2021 11:10:44 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 5 Oct 2021 11:10:44 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 67214AB192;
        Tue,  5 Oct 2021 11:10:43 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 3/3] reset: uniphier: Add NX1 reset support
Date:   Tue,  5 Oct 2021 11:10:42 +0900
Message-Id: <1633399842-1402-4-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1633399842-1402-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1633399842-1402-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic reset data for UniPhier NX1 SoC.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/reset/reset-uniphier-glue.c |  4 ++++
 drivers/reset/reset-uniphier.c      | 25 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/reset/reset-uniphier-glue.c b/drivers/reset/reset-uniphier-glue.c
index 027990b..908c1d5 100644
--- a/drivers/reset/reset-uniphier-glue.c
+++ b/drivers/reset/reset-uniphier-glue.c
@@ -156,6 +156,10 @@ static const struct of_device_id uniphier_glue_reset_match[] = {
 		.data = &uniphier_pxs2_data,
 	},
 	{
+		.compatible = "socionext,uniphier-nx1-usb3-reset",
+		.data = &uniphier_pxs2_data,
+	},
+	{
 		.compatible = "socionext,uniphier-pro4-ahci-reset",
 		.data = &uniphier_pro4_data,
 	},
diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
index 4a6cfd8..ff7580f 100644
--- a/drivers/reset/reset-uniphier.c
+++ b/drivers/reset/reset-uniphier.c
@@ -141,6 +141,19 @@ static const struct uniphier_reset_data uniphier_pxs3_sys_reset_data[] = {
 	UNIPHIER_RESET_END,
 };
 
+static const struct uniphier_reset_data uniphier_nx1_sys_reset_data[] = {
+	UNIPHIER_RESETX(4, 0x2008, 8),		/* eMMC */
+	UNIPHIER_RESETX(6, 0x200c, 0),		/* Ether */
+	UNIPHIER_RESETX(12, 0x200c, 16),        /* USB30 link */
+	UNIPHIER_RESETX(16, 0x200c, 24),        /* USB30-PHY0 */
+	UNIPHIER_RESETX(17, 0x200c, 25),        /* USB30-PHY1 */
+	UNIPHIER_RESETX(18, 0x200c, 26),        /* USB30-PHY2 */
+	UNIPHIER_RESETX(24, 0x200c, 8),         /* PCIe */
+	UNIPHIER_RESETX(52, 0x2010, 0),         /* VOC */
+	UNIPHIER_RESETX(58, 0x2010, 8),         /* HDMI-Tx */
+	UNIPHIER_RESET_END,
+};
+
 /* Media I/O reset data */
 #define UNIPHIER_MIO_RESET_SD(id, ch)			\
 	UNIPHIER_RESETX((id), 0x110 + 0x200 * (ch), 0)
@@ -402,6 +415,10 @@ static const struct of_device_id uniphier_reset_match[] = {
 		.compatible = "socionext,uniphier-pxs3-reset",
 		.data = uniphier_pxs3_sys_reset_data,
 	},
+	{
+		.compatible = "socionext,uniphier-nx1-reset",
+		.data = uniphier_nx1_sys_reset_data,
+	},
 	/* Media I/O reset, SD reset */
 	{
 		.compatible = "socionext,uniphier-ld4-mio-reset",
@@ -439,6 +456,10 @@ static const struct of_device_id uniphier_reset_match[] = {
 		.compatible = "socionext,uniphier-pxs3-sd-reset",
 		.data = uniphier_pro5_sd_reset_data,
 	},
+	{
+		.compatible = "socionext,uniphier-nx1-sd-reset",
+		.data = uniphier_pro5_sd_reset_data,
+	},
 	/* Peripheral reset */
 	{
 		.compatible = "socionext,uniphier-ld4-peri-reset",
@@ -472,6 +493,10 @@ static const struct of_device_id uniphier_reset_match[] = {
 		.compatible = "socionext,uniphier-pxs3-peri-reset",
 		.data = uniphier_pro4_peri_reset_data,
 	},
+	{
+		.compatible = "socionext,uniphier-nx1-peri-reset",
+		.data = uniphier_pro4_peri_reset_data,
+	},
 	/* Analog signal amplifiers reset */
 	{
 		.compatible = "socionext,uniphier-ld11-adamv-reset",
-- 
2.7.4

