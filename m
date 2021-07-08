Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE853C1AEA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 23:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhGHVTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 17:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhGHVTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 17:19:45 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B940DC061574;
        Thu,  8 Jul 2021 14:17:02 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id g12so6012803qtb.2;
        Thu, 08 Jul 2021 14:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qhNCek1xtdj76seGr2wXrhHbDhfAVbqvV61hRojd1RQ=;
        b=lXZaCE2gmQc0KU22v+NVx5STy9blkrK0GKzCp2rRlBUtv7wqCKBL1yxexM0beeWnKA
         uZVxtZb7fmarRJYBuHSjGJKhAeZdzAw78dMa3Wi4BRH3Fznaze0pjbDAJaPf92y+fYmP
         UEiDZQKxxt60WAtNjCiQx7U3qzgSBuE1zsWu0wogwu6a4xutsq/z089pfVtCHjSyyTjx
         lUFfh85AuBmZtQf4zE7a75XIdNxP7zUUMhHEK7yZ7Fp38y8lsQHigI1JVzU0SzIK4h8A
         J5t/JwiZGJqZ/xSfmWYBhENbPSR9hkuDWCp/FDzO0IndajLmmxQ3DoEtd4gOaw+Osb97
         vooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qhNCek1xtdj76seGr2wXrhHbDhfAVbqvV61hRojd1RQ=;
        b=tIGQm7Fj3Q1dVMoSP04n98nflIb7tgR86HgDGF+QNcHAN7iDMIyHCEZnuAPrs1NHvy
         yyRsJrDOMAYPIgg9s5Pnlu8N7wHg3PITeeav1faW86lDHVnE7qcGAFGpDU1EO/YF0dtK
         adwMIDYXw9wsdbzdqAGXJHM9vlNJlWbh9bXhtbg1jQ7fR1KpbnXLfDrgaDrgbnsWVClE
         rjDjwJuY11a78T5ou13vXOpIkbY1nSXhN5A4NzMeMl6DLOg4Btx/JR/iFvTmksJ03Hsi
         GZEj1HFevmMbCgI+ba+I9LpMszc5DRqQws3zFwyJUnoFs+SyMwi242nBN8Nyn1yvje8L
         AQuA==
X-Gm-Message-State: AOAM530/SkRYwaWIZxSftRfg8ZfwxbVLKNWW78lHnu0GQ5gB6fnEQ3ve
        62SEPVM5hpPkuIgINTsFgOE=
X-Google-Smtp-Source: ABdhPJxSWsouqEq936RKj3dNQJDU/c7gIj5QYin7eeExCLf6R6mMITojz5f1Xe6ElhHMhecGatI22w==
X-Received: by 2002:a05:622a:1817:: with SMTP id t23mr29037453qtc.161.1625779021878;
        Thu, 08 Jul 2021 14:17:01 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id z22sm1554860qkj.23.2021.07.08.14.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 14:17:01 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Liam Beguin <liambeguin@gmail.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] clk: lmk04832: drop redundant fallthrough statements
Date:   Thu,  8 Jul 2021 17:16:45 -0400
Message-Id: <20210708211645.3621902-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the body of a case statement is empty, it is well understood that
it is intentional and explicit fallthrough statements are not required.
Drop them.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 drivers/clk/clk-lmk04832.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/clk/clk-lmk04832.c b/drivers/clk/clk-lmk04832.c
index c7a3a029fb1e..8f02c0b88000 100644
--- a/drivers/clk/clk-lmk04832.c
+++ b/drivers/clk/clk-lmk04832.c
@@ -269,23 +269,14 @@ static bool lmk04832_regmap_rd_regs(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case LMK04832_REG_RST3W ... LMK04832_REG_ID_MASKREV:
-		fallthrough;
 	case LMK04832_REG_ID_VNDR_MSB:
-		fallthrough;
 	case LMK04832_REG_ID_VNDR_LSB:
-		fallthrough;
 	case LMK04832_REG_CLKOUT_CTRL0(0) ... LMK04832_REG_PLL2_DLD_CNT_LSB:
-		fallthrough;
 	case LMK04832_REG_PLL2_LD:
-		fallthrough;
 	case LMK04832_REG_PLL2_PD:
-		fallthrough;
 	case LMK04832_REG_PLL1R_RST:
-		fallthrough;
 	case LMK04832_REG_CLR_PLL_LOST ... LMK04832_REG_RB_DAC_VAL_LSB:
-		fallthrough;
 	case LMK04832_REG_RB_HOLDOVER:
-		fallthrough;
 	case LMK04832_REG_SPI_LOCK:
 		return true;
 	default:
@@ -297,27 +288,18 @@ static bool lmk04832_regmap_wr_regs(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case LMK04832_REG_RST3W:
-		fallthrough;
 	case LMK04832_REG_POWERDOWN:
 		return true;
 	case LMK04832_REG_ID_DEV_TYPE ... LMK04832_REG_ID_MASKREV:
-		fallthrough;
 	case LMK04832_REG_ID_VNDR_MSB:
-		fallthrough;
 	case LMK04832_REG_ID_VNDR_LSB:
 		return false;
 	case LMK04832_REG_CLKOUT_CTRL0(0) ... LMK04832_REG_PLL2_DLD_CNT_LSB:
-		fallthrough;
 	case LMK04832_REG_PLL2_LD:
-		fallthrough;
 	case LMK04832_REG_PLL2_PD:
-		fallthrough;
 	case LMK04832_REG_PLL1R_RST:
-		fallthrough;
 	case LMK04832_REG_CLR_PLL_LOST ... LMK04832_REG_RB_DAC_VAL_LSB:
-		fallthrough;
 	case LMK04832_REG_RB_HOLDOVER:
-		fallthrough;
 	case LMK04832_REG_SPI_LOCK:
 		return true;
 	default:
-- 
2.30.1.489.g328c10930387

