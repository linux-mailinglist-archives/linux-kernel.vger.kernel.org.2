Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5AF453B90
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 22:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhKPVVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 16:21:51 -0500
Received: from inva021.nxp.com ([92.121.34.21]:40294 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229605AbhKPVVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 16:21:49 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AE874201480;
        Tue, 16 Nov 2021 22:18:50 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6ECA0200056;
        Tue, 16 Nov 2021 22:18:50 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 882F340A84;
        Tue, 16 Nov 2021 14:18:49 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v3 2/2] memory: fsl_ifc: populate child devices without relying on simple-bus
Date:   Tue, 16 Nov 2021 15:18:46 -0600
Message-Id: <20211116211846.16335-3-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211116211846.16335-1-leoyang.li@nxp.com>
References: <20211116211846.16335-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After we update the binding to not use simple-bus compatible for the
controller, we need the driver to populate the child devices explicitly.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 drivers/memory/fsl_ifc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
index 75a8c38df939..2f6939da21cd 100644
--- a/drivers/memory/fsl_ifc.c
+++ b/drivers/memory/fsl_ifc.c
@@ -88,6 +88,7 @@ static int fsl_ifc_ctrl_remove(struct platform_device *dev)
 {
 	struct fsl_ifc_ctrl *ctrl = dev_get_drvdata(&dev->dev);
 
+	of_platform_depopulate(&dev->dev);
 	free_irq(ctrl->nand_irq, ctrl);
 	free_irq(ctrl->irq, ctrl);
 
@@ -285,8 +286,16 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
 		}
 	}
 
+	/* legacy dts may still use "simple-bus" compatible */
+	ret = of_platform_populate(dev->dev.of_node, NULL, NULL,
+					&dev->dev);
+	if (ret)
+		goto err_free_nandirq;
+
 	return 0;
 
+err_free_nandirq:
+	free_irq(fsl_ifc_ctrl_dev->nand_irq, fsl_ifc_ctrl_dev);
 err_free_irq:
 	free_irq(fsl_ifc_ctrl_dev->irq, fsl_ifc_ctrl_dev);
 err_unmap_nandirq:
-- 
2.25.1

