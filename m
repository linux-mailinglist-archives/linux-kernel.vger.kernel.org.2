Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD80443E363
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhJ1OWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhJ1OWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:22:32 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E26C061767;
        Thu, 28 Oct 2021 07:20:05 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o4-20020a1c7504000000b0032cab7473caso4779613wmc.1;
        Thu, 28 Oct 2021 07:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TQff7+i6dxs5PfhTnnbZH3nPeykRVJI64ISY+jsjutU=;
        b=Vv/9qsMlGnB5JIv0T0bguI2eXKZZglN8vGu/a/Wi14UHFC0DGYOe02c4xk/bnwoGoN
         dMZ4KkpWjBfYiBx8ubbcr30vjuQgLNbriVJXgIvFZSZUjtn/kdZR3MdN6xyPZ3n2fFAk
         gEtQqS4k7BKSydKweSEzGIGdyC5vXQesJVhjSQXhqD2jP4iTgnAYmDOCAEsEjJlk872Y
         43xQFIBGQjEPEzd2p6VNPkc3BFthNPM6tmoSvIEEHxS/rqlFU3L3K3aZmP9kS0HoaorD
         KxhxzfjAGk0jg+k9Q2IzkaO9FNyj945peXcoFyHCDtCJx3qLPzcfsvEtpgV5iudiOHRs
         wg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TQff7+i6dxs5PfhTnnbZH3nPeykRVJI64ISY+jsjutU=;
        b=2aUMAI3tG2BV6WM4hcCZqOnrVw0uSeFJt2HSv1zty3nlmxkq6c3o25nATG7BR/WrMK
         NWpIX8uGbrFKed1ayeTqmfzOa03MhXMDeKKgTIOlOpjUNlqepFjJV3pANqisbOAzprN5
         uYtMR63ZBRNAd3cjOiPbAgpZqAPrXnr3Fxelds+Mdrr1BiASMmz4Ody7oZJq/WYuqCxR
         8bLUPI8068Wc45AGy7suY6S1xsbXBjwFpEti8zbeqiSmWPwp4Gqr7yJd9sZJwe1r+peM
         nimExtlujhKrTCUSqjpg/pgWGbnY7Nt9E8i9260ePJtN2K2ufBahD+8BAkP6LSJg2tBZ
         6YdA==
X-Gm-Message-State: AOAM533UI2jN4vaRO4VNGoyc6ONZ/kTN5vwKaWqMEQ6u9ISb9KJxokzb
        TGKerCMtZ4qbhseWaeKU1+w=
X-Google-Smtp-Source: ABdhPJwnM173mMYgr46CHrhZ8lGPRb0soVkFAU/YtafftscaPvvp7hPJclRSsKpcCdMWgvZ4cK6y4A==
X-Received: by 2002:a05:600c:24d:: with SMTP id 13mr9732659wmj.64.1635430803441;
        Thu, 28 Oct 2021 07:20:03 -0700 (PDT)
Received: from localhost.localdomain (i5C74E249.versanet.de. [92.116.226.73])
        by smtp.gmail.com with ESMTPSA id m2sm6284546wml.15.2021.10.28.07.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 07:20:03 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 05/13] arm: davinci: remove reference to obsolete BLK_DEV_PALMCHIP_BK3710
Date:   Thu, 28 Oct 2021 16:19:30 +0200
Message-Id: <20211028141938.3530-6-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
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

