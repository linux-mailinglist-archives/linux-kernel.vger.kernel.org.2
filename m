Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EC03A269C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhFJIX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:23:27 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:51533 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhFJIXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:23:13 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 688E820012;
        Thu, 10 Jun 2021 08:21:14 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        <linux-mtd@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Michal Simek <monstr@monstr.eu>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Amit Kumar Mahapatra <akumarma@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, helmut.grohne@intenta.de,
        Srinivas Goud <sgoud@xilinx.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [PATCH v23 16/18] MAINTAINERS: Add PL353 NAND controller entry
Date:   Thu, 10 Jun 2021 10:20:38 +0200
Message-Id: <20210610082040.2075611-17-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210610082040.2075611-1-miquel.raynal@bootlin.com>
References: <20210610082040.2075611-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Naga from Xilinx and myself responsible of this driver.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b4315b76645a..a36fb919e913 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1452,6 +1452,14 @@ S:	Odd Fixes
 F:	drivers/amba/
 F:	include/linux/amba/bus.h
 
+ARM PRIMECELL PL35X NAND CONTROLLER DRIVER
+M:	Miquel Raynal <miquel.raynal@bootlin.com@bootlin.com>
+M:	Naga Sureshkumar Relli <nagasure@xilinx.com>
+L:	linux-mtd@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
+F:	drivers/mtd/nand/raw/pl35x-nand-controller.c
+
 ARM PRIMECELL PL35X SMC DRIVER
 M:	Miquel Raynal <miquel.raynal@bootlin.com@bootlin.com>
 M:	Naga Sureshkumar Relli <nagasure@xilinx.com>
-- 
2.27.0

