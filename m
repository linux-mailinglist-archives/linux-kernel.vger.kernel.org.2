Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A5645A054
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 11:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbhKWKjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 05:39:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:48144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235540AbhKWKj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 05:39:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 790AE61053;
        Tue, 23 Nov 2021 10:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637663781;
        bh=5QCuzqHM21YzM/FzKde2w/D1g6ZloHN6p+IE4Gqk6DE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ezGHUaMTIf6LJqFTd0JFS+7/V/9Psbj2VLyuCNoXiG0HehGk4xezpgrzAQv2RAqOd
         hGEEjzKWGPv2fCNg6sTwPderGAoRJkKkgnul/nsDmTNqsEmF93pAy4zME7POOdH0cn
         gCVVDPQd1wfPHjXuelCKnMSKiyjQSWL1diLSoq1Gk8sqp11SeqWIG8jBBqi0jI+Ob5
         Zp4qYENqDypA33dXQ/lRE7opMvvtsNQwiIZkMghn17kRVWJo/mNESl5rb5BKFU+gij
         Udm7FYOJqJmQhVvhKhdAuK6WPMzRJXTSDsoaF4pjf+YJ9BDJv2YNp2C3eXE1gJwMY2
         v/k9AGWI7bUNw==
From:   Roger Quadros <rogerq@kernel.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     kishon@ti.com, nm@ti.com, tony@atomide.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 2/4] mtd: nand: omap2: Allow build on K3 platforms
Date:   Tue, 23 Nov 2021 12:36:07 +0200
Message-Id: <20211123103609.14063-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211123103609.14063-1-rogerq@kernel.org>
References: <20211123103609.14063-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K3 platforms come with GPMC. Enable GPMC build for
K3 platforms.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/mtd/nand/raw/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 67b7cb67c030..d719316467a1 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -40,7 +40,7 @@ config MTD_NAND_AMS_DELTA
 
 config MTD_NAND_OMAP2
 	tristate "OMAP2, OMAP3, OMAP4 and Keystone NAND controller"
-	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || COMPILE_TEST
+	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
 	  Support for NAND flash on Texas Instruments OMAP2, OMAP3, OMAP4
-- 
2.17.1

