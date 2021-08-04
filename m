Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB393E013F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 14:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238165AbhHDMe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 08:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238134AbhHDMez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 08:34:55 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FADDC0613D5;
        Wed,  4 Aug 2021 05:34:41 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l4-20020a05600c1d04b02902506f89ad2dso3586807wms.1;
        Wed, 04 Aug 2021 05:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sWo4LrL+lEdTDpnczmLu/zDgBAvGaixZHhoFcHeZfnw=;
        b=XiuRIM6OkVABQm2AsxUUCm7YAUQMKK39VoF3ZEa9vd/g0lY6WovpozB5n5JyfcjyFw
         W/2yxIAymK/hVt0kNPCzZKcBzh+TcoEWVmu5a7H9EUvDdrM9jX+Q6fX+xx2KoxWtPyt1
         xDGHPFZUSq5jlaJyFNDJ/+clGamW60eA0OwaFIXIiiB1SI4oSlLNMMwWK4IvbwGbB0xO
         OEk0vKzgqDJlUCoLvjqNXLciXv/tQqqjDbtSmpBprhyglCtT6SpUkYAtgsygT9Ky6z/D
         DrP8ITPgIL+zj6AaDfLMtKaqDSeOI55H+lBA6OkcmrAFGtMHBhORAhnKvo/bMOpk1OAM
         ez0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sWo4LrL+lEdTDpnczmLu/zDgBAvGaixZHhoFcHeZfnw=;
        b=Q33ddGrPSoDZYkeWyS4I/6GBrXLQB6uDWTpVtTK7rfdhMLlwlbROfuQtBzv+tCI47m
         1i5SMTZTOUT5XoRcoeXtho2ThN0ZgMQtF9SaSV7XvQ/PsaADdTpFY2Bdb1r/2hMJ8GU+
         brTrMVf28S5cYXG3GvHZKTa74Mt6Rfu1nxL4YzgSod34Vpxhs+nPMOJRceMSXFV6V8pc
         Ql+PMRQrtY8TgKdI80rN7iqsbx1jOBI4pNc2R1mJwoMiYzUAM8elMugNku9YzA903TPS
         uWQY8NCR8qt182iR4O5CFjLFix6r/3KlZZXRcT5d3oNSYKmdKY9L9/9DXVkM6C3t/dMd
         l72g==
X-Gm-Message-State: AOAM532uOdTSmHDAlMs8bt2j7ro8bAbUKKKX+Av56uvRQXxR9lncYmEi
        +STaJKszk39IHbRAIIXNEhs=
X-Google-Smtp-Source: ABdhPJz0/kATgeIKYK6c/Sk7eIrcsS0E8eFcbQNPl6yUF0N3RepqP4HBd/KytqNEtTdQv/EpKMgNFw==
X-Received: by 2002:a05:600c:28b:: with SMTP id 11mr9274594wmk.6.1628080480245;
        Wed, 04 Aug 2021 05:34:40 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d4a:5b00:f5aa:e9bf:ac96:6276])
        by smtp.gmail.com with ESMTPSA id g138sm2620158wmg.32.2021.08.04.05.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 05:34:39 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Randy Dunlap <rdunlap@infradead.org>, Pavel Machek <pavel@ucw.cz>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 2/2] arm: davinci: remove reference to obsolete BLK_DEV_PALMCHIP_BK3710
Date:   Wed,  4 Aug 2021 14:34:26 +0200
Message-Id: <20210804123426.16947-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210804123426.16947-1-lukas.bulwahn@gmail.com>
References: <20210804123426.16947-1-lukas.bulwahn@gmail.com>
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
2.17.1

