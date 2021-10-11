Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8D74286FE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 08:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbhJKGsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 02:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbhJKGsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 02:48:17 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481EDC06161C;
        Sun, 10 Oct 2021 23:46:18 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k7so52455777wrd.13;
        Sun, 10 Oct 2021 23:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TQff7+i6dxs5PfhTnnbZH3nPeykRVJI64ISY+jsjutU=;
        b=mjDXFQHAIw/wwgAjtRmtVmQ6bn4erS1B7RMWxb8Dxxze0unLCpbV5/Zwx/GVWpx70Y
         aCr162B9sDBtKtM1NuIY+uvl3ojO1RCmVcd+uYUD7guKBPl3VeVnNIO6SxwQ/p1fasIb
         W3westEMs4hyfRgHG/lEO7Y/ucGuCwqUXj257CswRskD9MxfK6OnnqVwNC97ks7zolXp
         Gq8g6PiNKB6Tozy2IBWd+c6xqwyAQYfOFzpl02qROsiRr4hY5Ut4fPACAQ0AJ3Rd4Suo
         wEedjHd8PCKlRpRMk0bV+AoBXv/OwUcZtvY0KfXbXpCQcWeTIMOrY0J0KCTx1uU4KH7b
         nE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TQff7+i6dxs5PfhTnnbZH3nPeykRVJI64ISY+jsjutU=;
        b=IG8r2k6fz0JXDW6JP2fHygxGkn/7zgIp6gSn469xAzmd6gdWNsXIWLZif4BFfPC7Hs
         ApQNK04bnj2UaVzWXY2xBbeqFWQhyAk6UjkyJMERZKVjFiyksB52WIDkfwIWSF510Oh1
         hfM+S7Jyx+5d7018Msvs2ZIvNvDYPLmDk+7i9yMGxbqLo7X82dxTjpV+kx9Mi+gt0Udq
         qbK23dnrSWvPKVsEA+mVLB7H2Y8xTTASp8ZEvzyht68zE6O5+CuTPWLCTayJ2Ej5Luc0
         wgD2O0fachHR9a/UbHjW04nEVa/VuGROMJZlA6HUCNRtS5lkNQZYErgXQbZcLOiFE1Qh
         zVFw==
X-Gm-Message-State: AOAM533K0tnDx/uezL8DZVZpHedf+g8s68LD/60uHNJjk1rYlya7ME75
        Dvjo4V4CxJjvMZBvqFZPXtY=
X-Google-Smtp-Source: ABdhPJykz3+LuwjtpFk2s8G5F0h2oMtTVZHXztmPuNLxOFIlxEzO2wuc1xiuQsB2yOSirVsEZ0uXQQ==
X-Received: by 2002:adf:bb0a:: with SMTP id r10mr21706481wrg.23.1633934776835;
        Sun, 10 Oct 2021 23:46:16 -0700 (PDT)
Received: from localhost.localdomain (i577BCB28.versanet.de. [87.123.203.40])
        by smtp.gmail.com with ESMTPSA id o23sm6915843wms.18.2021.10.10.23.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 23:46:16 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH RESEND 1/1] arm: davinci: remove reference to obsolete BLK_DEV_PALMCHIP_BK3710
Date:   Mon, 11 Oct 2021 08:36:24 +0200
Message-Id: <20211011063624.12269-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211011063624.12269-1-lukas.bulwahn@gmail.com>
References: <20211011063624.12269-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b7fb14d3ac63 ("ide: remove the legacy ide driver") removes the
definition of the config BLK_DEV_PALMCHIP_BK3710.

So, remove the obsolete references in the mach-davinci architecture.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/mach-davinci/board-dm644x-evm.c  | 3 +--
 arch/arm/mach-davinci/board-dm646x-evm.c  | 3 +--
 arch/arm/mach-davinci/board-neuros-osd2.c | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index cce3a621eb20..df6dbb3f0faf 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -834,8 +834,7 @@ static int davinci_phy_fixup(struct phy_device *phydev)
 	return 0;
 }
 
-#define HAS_ATA		(IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710) || \
-			 IS_ENABLED(CONFIG_PATA_BK3710))
+#define HAS_ATA		IS_ENABLED(CONFIG_PATA_BK3710)
 
 #define HAS_NOR		IS_ENABLED(CONFIG_MTD_PHYSMAP)
 
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index ee91d81ebbfd..744ece6b6b9a 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -151,8 +151,7 @@ static struct platform_device davinci_aemif_device = {
 	.num_resources	= ARRAY_SIZE(davinci_aemif_resources),
 };
 
-#define HAS_ATA		(IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710) || \
-			 IS_ENABLED(CONFIG_PATA_BK3710))
+#define HAS_ATA		IS_ENABLED(CONFIG_PATA_BK3710)
 
 #ifdef CONFIG_I2C
 /* CPLD Register 0 bits to control ATA */
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index b4843f68bb57..81c21fe5748a 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -164,8 +164,7 @@ static struct davinci_mmc_config davinci_ntosd2_mmc_config = {
 	.wires		= 4,
 };

-#define HAS_ATA		(IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710) || \
-			 IS_ENABLED(CONFIG_PATA_BK3710))
+#define HAS_ATA		IS_ENABLED(CONFIG_PATA_BK3710)
 
 #define HAS_NAND	IS_ENABLED(CONFIG_MTD_NAND_DAVINCI)
 
-- 
2.26.2

