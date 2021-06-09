Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BFD3A0E66
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 10:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbhFIIFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 04:05:05 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:40411 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237467AbhFIIDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:03:41 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 3A909200016;
        Wed,  9 Jun 2021 08:01:44 +0000 (UTC)
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
Subject: [PATCH v22 14/18] memory: pl353-smc: Declare variables following a reverse christmas tree order
Date:   Wed,  9 Jun 2021 10:01:08 +0200
Message-Id: <20210609080112.1753221-15-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210609080112.1753221-1-miquel.raynal@bootlin.com>
References: <20210609080112.1753221-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a purely cosmetic change.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/memory/pl353-smc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/pl353-smc.c b/drivers/memory/pl353-smc.c
index b913d68a7a41..925d856663ac 100644
--- a/drivers/memory/pl353-smc.c
+++ b/drivers/memory/pl353-smc.c
@@ -36,8 +36,8 @@ static int __maybe_unused pl353_smc_suspend(struct device *dev)
 
 static int __maybe_unused pl353_smc_resume(struct device *dev)
 {
+	struct pl353_smc_data *pl353_smc = dev_get_drvdata(dev);
 	int ret;
-	struct pl353_smc_data *pl353_smc = dev_get_drvdata(dev);
 
 	ret = clk_enable(pl353_smc->aclk);
 	if (ret) {
@@ -70,11 +70,11 @@ static const struct of_device_id pl353_smc_supported_children[] = {
 
 static int pl353_smc_probe(struct amba_device *adev, const struct amba_id *id)
 {
+	struct device_node *of_node = adev->dev.of_node;
+	const struct of_device_id *match = NULL;
 	struct pl353_smc_data *pl353_smc;
 	struct device_node *child;
 	int err;
-	struct device_node *of_node = adev->dev.of_node;
-	const struct of_device_id *match = NULL;
 
 	pl353_smc = devm_kzalloc(&adev->dev, sizeof(*pl353_smc), GFP_KERNEL);
 	if (!pl353_smc)
-- 
2.27.0

