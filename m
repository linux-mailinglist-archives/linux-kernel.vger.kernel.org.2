Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679983A2678
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhFJIWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:22:44 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:41479 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhFJIWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:22:42 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 4105A20011;
        Thu, 10 Jun 2021 08:20:44 +0000 (UTC)
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
        Rob Herring <robh@kernel.org>
Subject: [PATCH v23 01/18] dt-binding: memory: pl353-smc: Rephrase the binding
Date:   Thu, 10 Jun 2021 10:20:23 +0200
Message-Id: <20210610082040.2075611-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210610082040.2075611-1-miquel.raynal@bootlin.com>
References: <20210610082040.2075611-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reword this document before converting it to yaml.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/memory-controllers/pl353-smc.txt         | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
index d56615fd343a..f0b7fe173668 100644
--- a/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
@@ -1,8 +1,7 @@
 Device tree bindings for ARM PL353 static memory controller
 
-PL353 static memory controller supports two kinds of memory
-interfaces.i.e NAND and SRAM/NOR interfaces.
-The actual devices are instantiated from the child nodes of pl353 smc node.
+PL353 Static Memory Controller is a bus where you can connect two kinds
+of memory interfaces: NAND and memory mapped interfaces (such as SRAM or NOR).
 
 Required properties:
 - compatible		: Should be "arm,pl353-smc-r2p1", "arm,primecell".
@@ -13,9 +12,9 @@ Required properties:
 - address-cells		: Must be 2.
 - size-cells		: Must be 1.
 
-Child nodes:
- For NAND the "arm,pl353-nand-r2p1" and for NOR the "cfi-flash" drivers are
-supported as child nodes.
+The child device node represents the controller connected to the SMC
+bus. Only one between: NAND controller, NOR controller and SRAM controller
+is allowed in a single system.
 
 for NAND partition information please refer the below file
 Documentation/devicetree/bindings/mtd/partition.txt
-- 
2.27.0

