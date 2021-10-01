Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7394641E565
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 02:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350887AbhJAALR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 20:11:17 -0400
Received: from inva020.nxp.com ([92.121.34.13]:41424 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238100AbhJAALO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 20:11:14 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 963EE1A0D89;
        Fri,  1 Oct 2021 02:09:30 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5A8F91A0D85;
        Fri,  1 Oct 2021 02:09:30 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 7DED840BCF;
        Thu, 30 Sep 2021 17:09:29 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 2/5] memory: fsl_ifc: populate child devices without relying on simple-bus
Date:   Thu, 30 Sep 2021 19:09:21 -0500
Message-Id: <20211001000924.15421-3-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211001000924.15421-1-leoyang.li@nxp.com>
References: <20211001000924.15421-1-leoyang.li@nxp.com>
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
index d062c2f8250f..251d713cd50b 100644
--- a/drivers/memory/fsl_ifc.c
+++ b/drivers/memory/fsl_ifc.c
@@ -88,6 +88,7 @@ static int fsl_ifc_ctrl_remove(struct platform_device *dev)
 {
 	struct fsl_ifc_ctrl *ctrl = dev_get_drvdata(&dev->dev);
 
+	of_platform_depopulate(&dev->dev);
 	free_irq(ctrl->nand_irq, ctrl);
 	free_irq(ctrl->irq, ctrl);
 
@@ -285,6 +286,14 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
 		}
 	}
 
+	/* legacy dts may still use "simple-bus" compatible */
+	if (!of_device_is_compatible(dev->dev.of_node, "simple-bus")) {
+	        ret = of_platform_populate(dev->dev.of_node, NULL, NULL,
+						&dev->dev);
+		if (ret)
+			goto err_nandirq;
+	}
+
 	return 0;
 
 err_nandirq:
-- 
2.25.1

