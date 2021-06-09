Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5EFC3A0E62
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 10:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbhFIIEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 04:04:53 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:41073 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbhFIIDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:03:37 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id CD79B200020;
        Wed,  9 Jun 2021 08:01:40 +0000 (UTC)
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
Subject: [PATCH v22 12/18] memory: pl353-smc: Let lower level controller drivers handle inits
Date:   Wed,  9 Jun 2021 10:01:06 +0200
Message-Id: <20210609080112.1753221-13-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210609080112.1753221-1-miquel.raynal@bootlin.com>
References: <20210609080112.1753221-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in having all these definitions at the SMC bus level,
these are extremely tight to the NAND controller driver implementation,
are not particularly generic, imply more boilerplate than needed, do
not really follow the device model by receiving no argument and some of
them are actually buggy.

Let's get rid of these right now as there is no current user and keep
this driver at a simple level: only the SMC bare initializations.

The NAND controller driver which I am going to introduce will take care
of redefining properly all these helpers and using them directly.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/memory/pl353-smc.c | 294 -------------------------------------
 include/linux/pl353-smc.h  |  30 ----
 2 files changed, 324 deletions(-)
 delete mode 100644 include/linux/pl353-smc.h

diff --git a/drivers/memory/pl353-smc.c b/drivers/memory/pl353-smc.c
index 14720430bf9e..5b57926461a0 100644
--- a/drivers/memory/pl353-smc.c
+++ b/drivers/memory/pl353-smc.c
@@ -8,76 +8,12 @@
  */
 
 #include <linux/clk.h>
-#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/pl353-smc.h>
 #include <linux/amba/bus.h>
 
-/* Register definitions */
-#define PL353_SMC_MEMC_STATUS_OFFS	0	/* Controller status reg, RO */
-#define PL353_SMC_CFG_CLR_OFFS		0xC	/* Clear config reg, WO */
-#define PL353_SMC_DIRECT_CMD_OFFS	0x10	/* Direct command reg, WO */
-#define PL353_SMC_SET_CYCLES_OFFS	0x14	/* Set cycles register, WO */
-#define PL353_SMC_SET_OPMODE_OFFS	0x18	/* Set opmode register, WO */
-#define PL353_SMC_ECC_STATUS_OFFS	0x400	/* ECC status register */
-#define PL353_SMC_ECC_MEMCFG_OFFS	0x404	/* ECC mem config reg */
-#define PL353_SMC_ECC_MEMCMD1_OFFS	0x408	/* ECC mem cmd1 reg */
-#define PL353_SMC_ECC_MEMCMD2_OFFS	0x40C	/* ECC mem cmd2 reg */
-#define PL353_SMC_ECC_VALUE0_OFFS	0x418	/* ECC value 0 reg */
-
-/* Controller status register specific constants */
-#define PL353_SMC_MEMC_STATUS_RAW_INT_1_SHIFT	6
-
-/* Clear configuration register specific constants */
-#define PL353_SMC_CFG_CLR_INT_CLR_1	0x10
-#define PL353_SMC_CFG_CLR_ECC_INT_DIS_1	0x40
-#define PL353_SMC_CFG_CLR_INT_DIS_1	0x2
-#define PL353_SMC_CFG_CLR_DEFAULT_MASK	(PL353_SMC_CFG_CLR_INT_CLR_1 | \
-					 PL353_SMC_CFG_CLR_ECC_INT_DIS_1 | \
-					 PL353_SMC_CFG_CLR_INT_DIS_1)
-
-/* Set cycles register specific constants */
-#define PL353_SMC_SET_CYCLES_T0_MASK	0xF
-#define PL353_SMC_SET_CYCLES_T0_SHIFT	0
-#define PL353_SMC_SET_CYCLES_T1_MASK	0xF
-#define PL353_SMC_SET_CYCLES_T1_SHIFT	4
-#define PL353_SMC_SET_CYCLES_T2_MASK	0x7
-#define PL353_SMC_SET_CYCLES_T2_SHIFT	8
-#define PL353_SMC_SET_CYCLES_T3_MASK	0x7
-#define PL353_SMC_SET_CYCLES_T3_SHIFT	11
-#define PL353_SMC_SET_CYCLES_T4_MASK	0x7
-#define PL353_SMC_SET_CYCLES_T4_SHIFT	14
-#define PL353_SMC_SET_CYCLES_T5_MASK	0x7
-#define PL353_SMC_SET_CYCLES_T5_SHIFT	17
-#define PL353_SMC_SET_CYCLES_T6_MASK	0xF
-#define PL353_SMC_SET_CYCLES_T6_SHIFT	20
-
-/* ECC status register specific constants */
-#define PL353_SMC_ECC_STATUS_BUSY	BIT(6)
-#define PL353_SMC_ECC_REG_SIZE_OFFS	4
-
-/* ECC memory config register specific constants */
-#define PL353_SMC_ECC_MEMCFG_MODE_MASK	0xC
-#define PL353_SMC_ECC_MEMCFG_MODE_SHIFT	2
-#define PL353_SMC_ECC_MEMCFG_PGSIZE_MASK	0x3
-
-#define PL353_SMC_DC_UPT_NAND_REGS	((4 << 23) |	/* CS: NAND chip */ \
-				 (2 << 21))	/* UpdateRegs operation */
-
-#define PL353_NAND_ECC_CMD1	((0x80)       |	/* Write command */ \
-				 (0 << 8)     |	/* Read command */ \
-				 (0x30 << 16) |	/* Read End command */ \
-				 (1 << 24))	/* Read End command calid */
-
-#define PL353_NAND_ECC_CMD2	((0x85)	      |	/* Write col change cmd */ \
-				 (5 << 8)     |	/* Read col change cmd */ \
-				 (0xE0 << 16) |	/* Read col change end cmd */ \
-				 (1 << 24)) /* Read col change end cmd valid */
-#define PL353_NAND_ECC_BUSY_TIMEOUT	(1 * HZ)
 /**
  * struct pl353_smc_data - Private smc driver structure
  * @memclk:		Pointer to the peripheral clock
@@ -88,183 +24,6 @@ struct pl353_smc_data {
 	struct clk		*aclk;
 };
 
-/* SMC virtual register base */
-static void __iomem *pl353_smc_base;
-
-/**
- * pl353_smc_set_buswidth - Set memory buswidth
- * @bw: Memory buswidth (8 | 16)
- * Return: 0 on success or negative errno.
- */
-int pl353_smc_set_buswidth(unsigned int bw)
-{
-	if (bw != PL353_SMC_MEM_WIDTH_8  && bw != PL353_SMC_MEM_WIDTH_16)
-		return -EINVAL;
-
-	writel(bw, pl353_smc_base + PL353_SMC_SET_OPMODE_OFFS);
-	writel(PL353_SMC_DC_UPT_NAND_REGS, pl353_smc_base +
-	       PL353_SMC_DIRECT_CMD_OFFS);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pl353_smc_set_buswidth);
-
-/**
- * pl353_smc_set_cycles - Set memory timing parameters
- * @timings: NAND controller timing parameters
- *
- * Sets NAND chip specific timing parameters.
- */
-void pl353_smc_set_cycles(u32 timings[])
-{
-	/*
-	 * Set write pulse timing. This one is easy to extract:
-	 *
-	 * NWE_PULSE = tWP
-	 */
-	timings[0] &= PL353_SMC_SET_CYCLES_T0_MASK;
-	timings[1] = (timings[1] & PL353_SMC_SET_CYCLES_T1_MASK) <<
-			PL353_SMC_SET_CYCLES_T1_SHIFT;
-	timings[2] = (timings[2]  & PL353_SMC_SET_CYCLES_T2_MASK) <<
-			PL353_SMC_SET_CYCLES_T2_SHIFT;
-	timings[3] = (timings[3]  & PL353_SMC_SET_CYCLES_T3_MASK) <<
-			PL353_SMC_SET_CYCLES_T3_SHIFT;
-	timings[4] = (timings[4] & PL353_SMC_SET_CYCLES_T4_MASK) <<
-			PL353_SMC_SET_CYCLES_T4_SHIFT;
-	timings[5]  = (timings[5]  & PL353_SMC_SET_CYCLES_T5_MASK) <<
-			PL353_SMC_SET_CYCLES_T5_SHIFT;
-	timings[6]  = (timings[6]  & PL353_SMC_SET_CYCLES_T6_MASK) <<
-			PL353_SMC_SET_CYCLES_T6_SHIFT;
-	timings[0] |= timings[1] | timings[2] | timings[3] |
-			timings[4] | timings[5] | timings[6];
-
-	writel(timings[0], pl353_smc_base + PL353_SMC_SET_CYCLES_OFFS);
-	writel(PL353_SMC_DC_UPT_NAND_REGS, pl353_smc_base +
-	       PL353_SMC_DIRECT_CMD_OFFS);
-}
-EXPORT_SYMBOL_GPL(pl353_smc_set_cycles);
-
-/**
- * pl353_smc_ecc_is_busy - Read ecc busy flag
- * Return: the ecc_status bit from the ecc_status register. 1 = busy, 0 = idle
- */
-bool pl353_smc_ecc_is_busy(void)
-{
-	return ((readl(pl353_smc_base + PL353_SMC_ECC_STATUS_OFFS) &
-		  PL353_SMC_ECC_STATUS_BUSY) == PL353_SMC_ECC_STATUS_BUSY);
-}
-EXPORT_SYMBOL_GPL(pl353_smc_ecc_is_busy);
-
-/**
- * pl353_smc_get_ecc_val - Read ecc_valueN registers
- * @ecc_reg: Index of the ecc_value reg (0..3)
- * Return: the content of the requested ecc_value register.
- *
- * There are four valid ecc_value registers. The argument is truncated to stay
- * within this valid boundary.
- */
-u32 pl353_smc_get_ecc_val(int ecc_reg)
-{
-	u32 addr, reg;
-
-	addr = PL353_SMC_ECC_VALUE0_OFFS +
-		(ecc_reg * PL353_SMC_ECC_REG_SIZE_OFFS);
-	reg = readl(pl353_smc_base + addr);
-
-	return reg;
-}
-EXPORT_SYMBOL_GPL(pl353_smc_get_ecc_val);
-
-/**
- * pl353_smc_get_nand_int_status_raw - Get NAND interrupt status bit
- * Return: the raw_int_status1 bit from the memc_status register
- */
-int pl353_smc_get_nand_int_status_raw(void)
-{
-	u32 reg;
-
-	reg = readl(pl353_smc_base + PL353_SMC_MEMC_STATUS_OFFS);
-	reg >>= PL353_SMC_MEMC_STATUS_RAW_INT_1_SHIFT;
-	reg &= 1;
-
-	return reg;
-}
-EXPORT_SYMBOL_GPL(pl353_smc_get_nand_int_status_raw);
-
-/**
- * pl353_smc_clr_nand_int - Clear NAND interrupt
- */
-void pl353_smc_clr_nand_int(void)
-{
-	writel(PL353_SMC_CFG_CLR_INT_CLR_1,
-	       pl353_smc_base + PL353_SMC_CFG_CLR_OFFS);
-}
-EXPORT_SYMBOL_GPL(pl353_smc_clr_nand_int);
-
-/**
- * pl353_smc_set_ecc_mode - Set SMC ECC mode
- * @mode: ECC mode (BYPASS, APB, MEM)
- * Return: 0 on success or negative errno.
- */
-int pl353_smc_set_ecc_mode(enum pl353_smc_ecc_mode mode)
-{
-	u32 reg;
-	int ret = 0;
-
-	switch (mode) {
-	case PL353_SMC_ECCMODE_BYPASS:
-	case PL353_SMC_ECCMODE_APB:
-	case PL353_SMC_ECCMODE_MEM:
-
-		reg = readl(pl353_smc_base + PL353_SMC_ECC_MEMCFG_OFFS);
-		reg &= ~PL353_SMC_ECC_MEMCFG_MODE_MASK;
-		reg |= mode << PL353_SMC_ECC_MEMCFG_MODE_SHIFT;
-		writel(reg, pl353_smc_base + PL353_SMC_ECC_MEMCFG_OFFS);
-
-		break;
-	default:
-		ret = -EINVAL;
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(pl353_smc_set_ecc_mode);
-
-/**
- * pl353_smc_set_ecc_pg_size - Set SMC ECC page size
- * @pg_sz: ECC page size
- * Return: 0 on success or negative errno.
- */
-int pl353_smc_set_ecc_pg_size(unsigned int pg_sz)
-{
-	u32 reg, sz;
-
-	switch (pg_sz) {
-	case 0:
-		sz = 0;
-		break;
-	case SZ_512:
-		sz = 1;
-		break;
-	case SZ_1K:
-		sz = 2;
-		break;
-	case SZ_2K:
-		sz = 3;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	reg = readl(pl353_smc_base + PL353_SMC_ECC_MEMCFG_OFFS);
-	reg &= ~PL353_SMC_ECC_MEMCFG_PGSIZE_MASK;
-	reg |= sz;
-	writel(reg, pl353_smc_base + PL353_SMC_ECC_MEMCFG_OFFS);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pl353_smc_set_ecc_pg_size);
-
 static int __maybe_unused pl353_smc_suspend(struct device *dev)
 {
 	struct pl353_smc_data *pl353_smc = dev_get_drvdata(dev);
@@ -296,52 +55,15 @@ static int __maybe_unused pl353_smc_resume(struct device *dev)
 	return ret;
 }
 
-static struct amba_driver pl353_smc_driver;
-
 static SIMPLE_DEV_PM_OPS(pl353_smc_dev_pm_ops, pl353_smc_suspend,
 			 pl353_smc_resume);
 
-/**
- * pl353_smc_init_nand_interface - Initialize the NAND interface
- * @adev: Pointer to the amba_device struct
- * @nand_node: Pointer to the pl353_nand device_node struct
- */
-static void pl353_smc_init_nand_interface(struct amba_device *adev,
-					  struct device_node *nand_node)
-{
-	unsigned long timeout;
-
-	pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_8);
-	writel(PL353_SMC_CFG_CLR_INT_CLR_1,
-	       pl353_smc_base + PL353_SMC_CFG_CLR_OFFS);
-	writel(PL353_SMC_DC_UPT_NAND_REGS, pl353_smc_base +
-	       PL353_SMC_DIRECT_CMD_OFFS);
-
-	timeout = jiffies + PL353_NAND_ECC_BUSY_TIMEOUT;
-	/* Wait till the ECC operation is complete */
-	do {
-		if (pl353_smc_ecc_is_busy())
-			cpu_relax();
-		else
-			break;
-	} while (!time_after_eq(jiffies, timeout));
-
-	if (time_after_eq(jiffies, timeout))
-		return;
-
-	writel(PL353_NAND_ECC_CMD1,
-	       pl353_smc_base + PL353_SMC_ECC_MEMCMD1_OFFS);
-	writel(PL353_NAND_ECC_CMD2,
-	       pl353_smc_base + PL353_SMC_ECC_MEMCMD2_OFFS);
-}
-
 static const struct of_device_id pl353_smc_supported_children[] = {
 	{
 		.compatible = "cfi-flash"
 	},
 	{
 		.compatible = "arm,pl353-nand-r2p1",
-		.data = pl353_smc_init_nand_interface
 	},
 	{}
 };
@@ -350,23 +72,14 @@ static int pl353_smc_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	struct pl353_smc_data *pl353_smc;
 	struct device_node *child;
-	struct resource *res;
 	int err;
 	struct device_node *of_node = adev->dev.of_node;
-	static void (*init)(struct amba_device *adev,
-			    struct device_node *nand_node);
 	const struct of_device_id *match = NULL;
 
 	pl353_smc = devm_kzalloc(&adev->dev, sizeof(*pl353_smc), GFP_KERNEL);
 	if (!pl353_smc)
 		return -ENOMEM;
 
-	/* Get the NAND controller virtual address */
-	res = &adev->res;
-	pl353_smc_base = devm_ioremap_resource(&adev->dev, res);
-	if (IS_ERR(pl353_smc_base))
-		return PTR_ERR(pl353_smc_base);
-
 	pl353_smc->aclk = devm_clk_get(&adev->dev, "apb_pclk");
 	if (IS_ERR(pl353_smc->aclk)) {
 		dev_err(&adev->dev, "aclk clock not found.\n");
@@ -393,10 +106,6 @@ static int pl353_smc_probe(struct amba_device *adev, const struct amba_id *id)
 
 	amba_set_drvdata(adev, pl353_smc);
 
-	/* clear interrupts */
-	writel(PL353_SMC_CFG_CLR_DEFAULT_MASK,
-	       pl353_smc_base + PL353_SMC_CFG_CLR_OFFS);
-
 	/* Find compatible children. Only a single child is supported */
 	for_each_available_child_of_node(of_node, child) {
 		match = of_match_node(pl353_smc_supported_children, child);
@@ -411,9 +120,6 @@ static int pl353_smc_probe(struct amba_device *adev, const struct amba_id *id)
 		goto disable_mem_clk;
 	}
 
-	init = match->data;
-	if (init)
-		init(adev, child);
 	of_platform_device_create(child, NULL, &adev->dev);
 
 	return 0;
diff --git a/include/linux/pl353-smc.h b/include/linux/pl353-smc.h
deleted file mode 100644
index 0e0d3df9bf72..000000000000
--- a/include/linux/pl353-smc.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * ARM PL353 SMC Driver Header
- *
- * Copyright (C) 2012 - 2018 Xilinx, Inc
- */
-
-#ifndef __LINUX_PL353_SMC_H
-#define __LINUX_PL353_SMC_H
-
-enum pl353_smc_ecc_mode {
-	PL353_SMC_ECCMODE_BYPASS = 0,
-	PL353_SMC_ECCMODE_APB = 1,
-	PL353_SMC_ECCMODE_MEM = 2
-};
-
-enum pl353_smc_mem_width {
-	PL353_SMC_MEM_WIDTH_8 = 0,
-	PL353_SMC_MEM_WIDTH_16 = 1
-};
-
-u32 pl353_smc_get_ecc_val(int ecc_reg);
-bool pl353_smc_ecc_is_busy(void);
-int pl353_smc_get_nand_int_status_raw(void);
-void pl353_smc_clr_nand_int(void);
-int pl353_smc_set_ecc_mode(enum pl353_smc_ecc_mode mode);
-int pl353_smc_set_ecc_pg_size(unsigned int pg_sz);
-int pl353_smc_set_buswidth(unsigned int bw);
-void pl353_smc_set_cycles(u32 timings[]);
-#endif
-- 
2.27.0

