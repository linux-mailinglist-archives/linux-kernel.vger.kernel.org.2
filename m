Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE3F42E5A3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 02:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbhJOA7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 20:59:34 -0400
Received: from inva020.nxp.com ([92.121.34.13]:60568 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234618AbhJOA71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 20:59:27 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B72181A0979;
        Fri, 15 Oct 2021 02:57:20 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8072D1A095D;
        Fri, 15 Oct 2021 02:57:20 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id B90AC40BD3;
        Thu, 14 Oct 2021 17:57:19 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 2/2] memory: fsl_ifc: populate child devices without relying on simple-bus
Date:   Thu, 14 Oct 2021 19:57:07 -0500
Message-Id: <20211015005707.1996-3-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211015005707.1996-1-leoyang.li@nxp.com>
References: <20211015005707.1996-1-leoyang.li@nxp.com>
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
 drivers/memory/fsl_ifc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
index d062c2f8250f..ef2092fa90d9 100644
--- a/drivers/memory/fsl_ifc.c
+++ b/drivers/memory/fsl_ifc.c
@@ -88,6 +88,7 @@ static int fsl_ifc_ctrl_remove(struct platform_device *dev)
 {
 	struct fsl_ifc_ctrl *ctrl = dev_get_drvdata(&dev->dev);
 
+	of_platform_depopulate(&dev->dev);
 	free_irq(ctrl->nand_irq, ctrl);
 	free_irq(ctrl->irq, ctrl);
 
@@ -285,6 +286,12 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
 		}
 	}
 
+	/* legacy dts may still use "simple-bus" compatible */
+	ret = of_platform_populate(dev->dev.of_node, NULL, NULL,
+					&dev->dev);
+	if (ret)
+		goto err_nandirq;
+
 	return 0;
 
 err_nandirq:
-- 
2.25.1

