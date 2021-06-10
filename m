Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938FC3A2697
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhFJIXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:23:18 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:35669 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhFJIXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:23:06 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 5603620008;
        Thu, 10 Jun 2021 08:21:08 +0000 (UTC)
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
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v23 13/18] memory: pl353-smc: Avoid useless acronyms in descriptions
Date:   Thu, 10 Jun 2021 10:20:35 +0200
Message-Id: <20210610082040.2075611-14-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210610082040.2075611-1-miquel.raynal@bootlin.com>
References: <20210610082040.2075611-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

APER does not mean anything, while it seems legitimate to call this
clock the AXI peripheral clock.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/memory/pl353-smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/pl353-smc.c b/drivers/memory/pl353-smc.c
index 5b57926461a0..b913d68a7a41 100644
--- a/drivers/memory/pl353-smc.c
+++ b/drivers/memory/pl353-smc.c
@@ -17,7 +17,7 @@
 /**
  * struct pl353_smc_data - Private smc driver structure
  * @memclk:		Pointer to the peripheral clock
- * @aclk:		Pointer to the APER clock
+ * @aclk:		Pointer to the AXI peripheral clock
  */
 struct pl353_smc_data {
 	struct clk		*memclk;
-- 
2.27.0

