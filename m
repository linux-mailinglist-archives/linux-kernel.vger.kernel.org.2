Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60B0337A92
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhCKRPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhCKRO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:14:57 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B73C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 09:14:57 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so3514044pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 09:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KSvf4FPCndcLiw/HtonVpqVmpqTSr98Q/VggjfUZvRE=;
        b=bV/l1p/RGI5kUBrPJHMUCcdvfryqpgqsMIMQFzJ0LNuHBWi1CjedW9r31AcXulQ7X3
         Jc5lXpTkShe9jpFEF++9vOz3qhp/bNR12mlMjjdk5s4ivWv8mof5na5dOu0F3P4ska0/
         uGLSrZjkKOgEiweXiv2W7Cpal63OCxaXqSST9Ym3ZisuaLbLY8qmyA0WgUhWV4SVEHEy
         wXzGQTkNgYXIsBL0Ku+jXWYZ/DBU2HVpodgu9N/dQ5eduQtix+mSpVsXbe0Hze/5EV9j
         7LEbG7HMyjaqoOtyWbHLt3cb1b9rjsOv+vODhEZ9QUBieFMwHbQk7fAFVh9EoC3b8qzG
         ySag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KSvf4FPCndcLiw/HtonVpqVmpqTSr98Q/VggjfUZvRE=;
        b=tXomggSNIMox0oOfu1g4NXX0MH6nt5p0xa6LnIBy9CrfP8OaCFd8hF5qbJftyCOjNT
         xAiqJ2RjjgGxE2ktCuhSCRLsSLWG6OOFVDx2bGCWpYSBYMsItC7w/nMZbaXmgRuItUkZ
         DG/RhwucD6jNzt3Oz5yJFnGWfLn+ey3a9y/4AnmhBl9NkjNS/ngx589WfBxutYxNc9Ir
         LkUgOGAQWlV3IZUHIrDqFk4o4Y3opVGmwutByiq/rnBZaCreT3Khrz+qZloE+UWT53v9
         FsannU2EZxkOMwYpDp5E7pS4IlUcnT9HFulwjy2J+uF1hEW6VOipjIgc+9hqP7Yix1vW
         6HLQ==
X-Gm-Message-State: AOAM5337TEOMcwKWNVALDT2fsUbdq6kZ6gxd+ORLJSPgh4gROZawsHRf
        /ojJu8Hfj1uiULq1WjDBK2U=
X-Google-Smtp-Source: ABdhPJw7cT40dsHwz6xBc0r7W/HnA7/118Txd3xI7ovUWPUtNpftYq+SAWVS0J/1LVzcjDrRg8BBpw==
X-Received: by 2002:a17:90b:33c7:: with SMTP id lk7mr9943931pjb.95.1615482896577;
        Thu, 11 Mar 2021 09:14:56 -0800 (PST)
Received: from mail.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id e190sm3007121pfe.3.2021.03.11.09.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:14:56 -0800 (PST)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     f.fainelli@gmail.com, linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mtd: rawnand: brcmnand: read/write oob during  EDU transfer
Date:   Thu, 11 Mar 2021 12:09:08 -0500
Message-Id: <20210311170909.9031-1-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support to read/write oob during EDU transfers.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 59 +++++++++++++++++++++---
 1 file changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 659eaa6f0980..1c95b21aa63b 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -242,6 +242,9 @@ struct brcmnand_controller {
 	u32                     edu_ext_addr;
 	u32                     edu_cmd;
 	u32                     edu_config;
+	int			sas; /* spare area size, per flash cache */
+	int			sector_size_1k;
+	u8			*oob;
 
 	/* flash_dma reg */
 	const u16		*flash_dma_offsets;
@@ -249,7 +252,7 @@ struct brcmnand_controller {
 	dma_addr_t		dma_pa;
 
 	int (*dma_trans)(struct brcmnand_host *host, u64 addr, u32 *buf,
-			 u32 len, u8 dma_cmd);
+			 u8 *oob, u32 len, u8 dma_cmd);
 
 	/* in-memory cache of the FLASH_CACHE, used only for some commands */
 	u8			flash_cache[FC_BYTES];
@@ -1479,6 +1482,23 @@ static irqreturn_t brcmnand_edu_irq(int irq, void *data)
 		edu_writel(ctrl, EDU_EXT_ADDR, ctrl->edu_ext_addr);
 		edu_readl(ctrl, EDU_EXT_ADDR);
 
+		if (ctrl->oob) {
+			if (ctrl->edu_cmd == EDU_CMD_READ) {
+				ctrl->oob += read_oob_from_regs(ctrl,
+							ctrl->edu_count + 1,
+							ctrl->oob, ctrl->sas,
+							ctrl->sector_size_1k);
+			} else {
+				brcmnand_write_reg(ctrl, BRCMNAND_CMD_ADDRESS,
+						   ctrl->edu_ext_addr);
+				brcmnand_read_reg(ctrl, BRCMNAND_CMD_ADDRESS);
+				ctrl->oob += write_oob_to_regs(ctrl,
+							       ctrl->edu_count,
+							       ctrl->oob, ctrl->sas,
+							       ctrl->sector_size_1k);
+			}
+		}
+
 		mb(); /* flush previous writes */
 		edu_writel(ctrl, EDU_CMD, ctrl->edu_cmd);
 		edu_readl(ctrl, EDU_CMD);
@@ -1850,9 +1870,10 @@ static void brcmnand_write_buf(struct nand_chip *chip, const uint8_t *buf,
  *  Kick EDU engine
  */
 static int brcmnand_edu_trans(struct brcmnand_host *host, u64 addr, u32 *buf,
-			      u32 len, u8 cmd)
+			      u8 *oob, u32 len, u8 cmd)
 {
 	struct brcmnand_controller *ctrl = host->ctrl;
+	struct brcmnand_cfg *cfg = &host->hwcfg;
 	unsigned long timeo = msecs_to_jiffies(200);
 	int ret = 0;
 	int dir = (cmd == CMD_PAGE_READ ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
@@ -1860,6 +1881,9 @@ static int brcmnand_edu_trans(struct brcmnand_host *host, u64 addr, u32 *buf,
 	unsigned int trans = len >> FC_SHIFT;
 	dma_addr_t pa;
 
+	dev_dbg(ctrl->dev, "EDU %s %p:%p\n", ((edu_cmd == EDU_CMD_READ) ?
+					      "read" : "write"), buf, oob);
+
 	pa = dma_map_single(ctrl->dev, buf, len, dir);
 	if (dma_mapping_error(ctrl->dev, pa)) {
 		dev_err(ctrl->dev, "unable to map buffer for EDU DMA\n");
@@ -1871,6 +1895,8 @@ static int brcmnand_edu_trans(struct brcmnand_host *host, u64 addr, u32 *buf,
 	ctrl->edu_ext_addr = addr;
 	ctrl->edu_cmd = edu_cmd;
 	ctrl->edu_count = trans;
+	ctrl->sas = cfg->spare_area_size;
+	ctrl->oob = oob;
 
 	edu_writel(ctrl, EDU_DRAM_ADDR, (u32)ctrl->edu_dram_addr);
 	edu_readl(ctrl,  EDU_DRAM_ADDR);
@@ -1879,6 +1905,16 @@ static int brcmnand_edu_trans(struct brcmnand_host *host, u64 addr, u32 *buf,
 	edu_writel(ctrl, EDU_LENGTH, FC_BYTES);
 	edu_readl(ctrl, EDU_LENGTH);
 
+	if (ctrl->oob && (ctrl->edu_cmd == EDU_CMD_WRITE)) {
+		brcmnand_write_reg(ctrl, BRCMNAND_CMD_ADDRESS,
+				   ctrl->edu_ext_addr);
+		brcmnand_read_reg(ctrl, BRCMNAND_CMD_ADDRESS);
+		ctrl->oob += write_oob_to_regs(ctrl,
+					       1,
+					       ctrl->oob, ctrl->sas,
+					       ctrl->sector_size_1k);
+	}
+
 	/* Start edu engine */
 	mb(); /* flush previous writes */
 	edu_writel(ctrl, EDU_CMD, ctrl->edu_cmd);
@@ -1893,6 +1929,14 @@ static int brcmnand_edu_trans(struct brcmnand_host *host, u64 addr, u32 *buf,
 
 	dma_unmap_single(ctrl->dev, pa, len, dir);
 
+	/* read last subpage oob */
+	if (ctrl->oob && (ctrl->edu_cmd == EDU_CMD_READ)) {
+		ctrl->oob += read_oob_from_regs(ctrl,
+						1,
+						ctrl->oob, ctrl->sas,
+						ctrl->sector_size_1k);
+	}
+
 	/* for program page check NAND status */
 	if (((brcmnand_read_reg(ctrl, BRCMNAND_INTFC_STATUS) &
 	      INTFC_FLASH_STATUS) & NAND_STATUS_FAIL) &&
@@ -2002,7 +2046,7 @@ static void brcmnand_dma_run(struct brcmnand_host *host, dma_addr_t desc)
 }
 
 static int brcmnand_dma_trans(struct brcmnand_host *host, u64 addr, u32 *buf,
-			      u32 len, u8 dma_cmd)
+			      u8 *oob, u32 len, u8 dma_cmd)
 {
 	struct brcmnand_controller *ctrl = host->ctrl;
 	dma_addr_t buf_pa;
@@ -2147,8 +2191,9 @@ static int brcmnand_read(struct mtd_info *mtd, struct nand_chip *chip,
 try_dmaread:
 	brcmnand_clear_ecc_addr(ctrl);
 
-	if (ctrl->dma_trans && !oob && flash_dma_buf_ok(buf)) {
-		err = ctrl->dma_trans(host, addr, buf,
+	if (ctrl->dma_trans && (has_edu(ctrl) || !oob) &&
+	    flash_dma_buf_ok(buf)) {
+		err = ctrl->dma_trans(host, addr, buf, oob,
 				      trans * FC_BYTES,
 				      CMD_PAGE_READ);
 
@@ -2296,8 +2341,8 @@ static int brcmnand_write(struct mtd_info *mtd, struct nand_chip *chip,
 	for (i = 0; i < ctrl->max_oob; i += 4)
 		oob_reg_write(ctrl, i, 0xffffffff);
 
-	if (use_dma(ctrl) && !oob && flash_dma_buf_ok(buf)) {
-		if (ctrl->dma_trans(host, addr, (u32 *)buf, mtd->writesize,
+	if (use_dma(ctrl) && (has_edu(ctrl) || !oob) && flash_dma_buf_ok(buf)) {
+		if (ctrl->dma_trans(host, addr, (u32 *)buf, oob, mtd->writesize,
 				    CMD_PROGRAM_PAGE))
 
 			ret = -EIO;
-- 
2.17.1

