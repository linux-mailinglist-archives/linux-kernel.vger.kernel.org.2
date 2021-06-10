Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7BE3A2690
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhFJIXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:23:13 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:58021 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhFJIXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:23:02 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 907AE20004;
        Thu, 10 Jun 2021 08:21:04 +0000 (UTC)
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
Subject: [PATCH v23 11/18] memory: pl353-smc: Rename goto labels
Date:   Thu, 10 Jun 2021 10:20:33 +0200
Message-Id: <20210610082040.2075611-12-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210610082040.2075611-1-miquel.raynal@bootlin.com>
References: <20210610082040.2075611-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A goto label is better named

        do_something:

than

        out_something_to_do:

Use the former wording and really describe what the jump involves.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/memory/pl353-smc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/pl353-smc.c b/drivers/memory/pl353-smc.c
index 2d20b1b2c0e3..14720430bf9e 100644
--- a/drivers/memory/pl353-smc.c
+++ b/drivers/memory/pl353-smc.c
@@ -388,7 +388,7 @@ static int pl353_smc_probe(struct amba_device *adev, const struct amba_id *id)
 	err = clk_prepare_enable(pl353_smc->memclk);
 	if (err) {
 		dev_err(&adev->dev, "Unable to enable memory clock.\n");
-		goto out_clk_dis_aper;
+		goto disable_axi_clk;
 	}
 
 	amba_set_drvdata(adev, pl353_smc);
@@ -408,7 +408,7 @@ static int pl353_smc_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 	if (!match) {
 		dev_err(&adev->dev, "no matching children\n");
-		goto out_clk_disable;
+		goto disable_mem_clk;
 	}
 
 	init = match->data;
@@ -418,9 +418,9 @@ static int pl353_smc_probe(struct amba_device *adev, const struct amba_id *id)
 
 	return 0;
 
-out_clk_disable:
+disable_mem_clk:
 	clk_disable_unprepare(pl353_smc->memclk);
-out_clk_dis_aper:
+disable_axi_clk:
 	clk_disable_unprepare(pl353_smc->aclk);
 
 	return err;
-- 
2.27.0

