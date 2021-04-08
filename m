Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFC1357A92
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 04:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhDHC5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 22:57:30 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37028 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhDHC53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 22:57:29 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E1C172021D4;
        Thu,  8 Apr 2021 04:57:17 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E65D5200BAB;
        Thu,  8 Apr 2021 04:57:14 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D77434032B;
        Thu,  8 Apr 2021 04:57:10 +0200 (CEST)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Ma <peng.ma@nxp.com>, Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v7] soc: fsl: enable acpi support in RCPM driver
Date:   Thu,  8 Apr 2021 11:03:53 +0800
Message-Id: <20210408030353.37193-1-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Ma <peng.ma@nxp.com>

This patch enables ACPI support in RCPM driver.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Change in v7:
 - Update comment for checking RCPM node which refferred to

Change in v6:
 - Remove copyright udpate to rebase on latest mainline

Change in v5:
 - Fix panic when dev->of_node is null

Change in v4:
 - Make commit subject more accurate
 - Remove unrelated new blank line

Change in v3:
 - Add #ifdef CONFIG_ACPI for acpi_device_id
 - Rename rcpm_acpi_imx_ids to rcpm_acpi_ids

Change in v2:
 - Update acpi_device_id to fix conflict with other driver

 drivers/soc/fsl/rcpm.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/rcpm.c b/drivers/soc/fsl/rcpm.c
index 4ace28cab314..90d3f4060b0c 100644
--- a/drivers/soc/fsl/rcpm.c
+++ b/drivers/soc/fsl/rcpm.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/suspend.h>
 #include <linux/kernel.h>
+#include <linux/acpi.h>
 
 #define RCPM_WAKEUP_CELL_MAX_SIZE	7
 
@@ -78,10 +79,20 @@ static int rcpm_pm_prepare(struct device *dev)
 				"fsl,rcpm-wakeup", value,
 				rcpm->wakeup_cells + 1);
 
-		/*  Wakeup source should refer to current rcpm device */
-		if (ret || (np->phandle != value[0]))
+		if (ret)
 			continue;
 
+		/*
+		 * For DT mode, would handle devices with "fsl,rcpm-wakeup"
+		 * pointing to the current RCPM node.
+		 *
+		 * For ACPI mode, currently we assume there is only one
+		 * RCPM controller existing.
+		 */
+		if (is_of_node(dev->fwnode))
+			if (np->phandle != value[0])
+				continue;
+
 		/* Property "#fsl,rcpm-wakeup-cells" of rcpm node defines the
 		 * number of IPPDEXPCR register cells, and "fsl,rcpm-wakeup"
 		 * of wakeup source IP contains an integer array: <phandle to
@@ -172,10 +183,19 @@ static const struct of_device_id rcpm_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rcpm_of_match);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id rcpm_acpi_ids[] = {
+	{"NXP0015",},
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, rcpm_acpi_ids);
+#endif
+
 static struct platform_driver rcpm_driver = {
 	.driver = {
 		.name = "rcpm",
 		.of_match_table = rcpm_of_match,
+		.acpi_match_table = ACPI_PTR(rcpm_acpi_ids),
 		.pm	= &rcpm_pm_ops,
 	},
 	.probe = rcpm_probe,
-- 
2.25.1

