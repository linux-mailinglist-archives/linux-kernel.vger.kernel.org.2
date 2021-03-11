Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210BD337A93
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhCKRPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhCKRPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:15:07 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C47CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 09:15:07 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id q2-20020a17090a2e02b02900bee668844dso9389063pjd.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 09:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g5hE2AWs+PGnGdSTksH6QWUvWe0n4LMgRHwtjboedWo=;
        b=Mu6ah/UDZAy2dCL8eXAiHLdGkUDudEjJULnyNPXEwGzeB3yEQMFqGce/8V7OdKIQ+6
         I1miXZzantBU07ZFNPbSemc/dAYMAsxDTFP7E5wYxc+Huv3M7BrQkFepvWVVTeGVsblK
         Rs3ZmW+ZNVc/qmmtePYrSnhhZJPU00HIVqvNxlLUYCIpUO4eMkIIWV7T4TWORISRW+GA
         +i+jLVgZo/1YCzBTtGBBDJfX+doHSueBH+E34UGj5sWzcRuBREhUXUTvs5pbP/rJenbD
         cyTr/VECrHqMocq82thyY7BLFWg+KE9d2KcT1QFG+WQFPIkWu64byK9ZuhN/rx7SEiD/
         pw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g5hE2AWs+PGnGdSTksH6QWUvWe0n4LMgRHwtjboedWo=;
        b=BHozMubNNBNOOyFHc86VxduiN82Aw2WtDurbVF+x21QzOGN8ZfxY/FN/d8BXcwW0uD
         vDLrDlKxFSSGeoxoqdRkr4ZCzvAPxBPJvKaolf2XrGxfOge1PmeHNV6gb+wOck0NjdW6
         cBKZNB204wlx0szmSfU4dGv6CQQ43HuTu0zDwS7oFmsr/1uu/rxOPFI5COdemxGL3WjX
         /00FDdDzmvVR6yc7G2b9UfISZ7gkELI5fEsZYbC5EdItiwDvX9BFIeMVu6RCIhp5Q68Q
         G4yPJ+GPeoOW701GdYP1KR8Sue9uH9a91qzPgFwJ5paNKvLx83RFkUWupVLytsQWLj2v
         7Cyw==
X-Gm-Message-State: AOAM533HrNO4JTKkUCE7/zD1QIIXvtywbCw9BGBrWxtijPcUMYFnIgwN
        yG0Uc641CbPkNlnAbfFb+os=
X-Google-Smtp-Source: ABdhPJyq/9C5N7Ah3t18RKohtbHRl6FVhs30IIo9xGFodtxzWevwSSyudBZyJjPIYeCcMg5CQADyGg==
X-Received: by 2002:a17:90b:228e:: with SMTP id kx14mr10004058pjb.71.1615482906825;
        Thu, 11 Mar 2021 09:15:06 -0800 (PST)
Received: from mail.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id e190sm3007121pfe.3.2021.03.11.09.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:15:06 -0800 (PST)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     f.fainelli@gmail.com, linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mtd: rawnand: brcmnand: move to polling in pio mode on oops write
Date:   Thu, 11 Mar 2021 12:09:09 -0500
Message-Id: <20210311170909.9031-2-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210311170909.9031-1-kdasu.kdev@gmail.com>
References: <20210311170909.9031-1-kdasu.kdev@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change makes sure that Broadcom NAND driver moves to interrupt
polling on the first brcmnand_write() call.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 1c95b21aa63b..e6966db5f0d8 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2341,6 +2341,10 @@ static int brcmnand_write(struct mtd_info *mtd, struct nand_chip *chip,
 	for (i = 0; i < ctrl->max_oob; i += 4)
 		oob_reg_write(ctrl, i, 0xffffffff);
 
+	if (mtd->oops_panic_write)
+		/* switch to interrupt polling and PIO mode */
+		disable_ctrl_irqs(ctrl);
+
 	if (use_dma(ctrl) && (has_edu(ctrl) || !oob) && flash_dma_buf_ok(buf)) {
 		if (ctrl->dma_trans(host, addr, (u32 *)buf, oob, mtd->writesize,
 				    CMD_PROGRAM_PAGE))
-- 
2.17.1

