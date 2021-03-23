Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF683469A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 21:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhCWUP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 16:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbhCWUPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 16:15:12 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0926AC061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 13:15:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id hq27so29195734ejc.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 13:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytesatwork-ch.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EGPRM4nqneL5zev4fUrYZk+40PzLIOTPL4HZY+QrxqU=;
        b=rbHcfo731tJ3mGSpI7XAXZOTH60pcM4YHpbimE9QfOMyBuWwFLvr3VPfiNCvFKKPa7
         Nt2iyuk74fdCDhoxWMieafkFKAdQUUmhpWa6sUYCcHQ2pTEJUtx5tDTh0yeIeyQibiQ9
         Y8mn1DzuvkTlXRHARgFOk22VlCQGDmHMYcjAF5b8CpjjK5TEu+oqoH6Y4B9CQD3lG5L8
         qlW+gOG4EOlbtst4PVkKbgtBq1HsoCa4ajvZ7Y3Vum2c9E7VTxNc2tl02yAgPKXsoo5D
         xv6/D10vvaG3gUwWBSbkWGnGY9wWCLGPnB74KUTmc5TwFBvNlG848eQe9QvaP5Af1Atg
         /iGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EGPRM4nqneL5zev4fUrYZk+40PzLIOTPL4HZY+QrxqU=;
        b=gEL3SDYvfoNHiXUtv0z9i5aMv12R215fvLkmKCr0R5fXQV8f7CySe6wWdPHtUBYtSb
         1SojfcH1rAABShA+pKiEtGh7Neu+4flqTQxlY0XFeKb3JM4+C8t5bOk4YNeAqG/LsAkJ
         AeDAlWQynULI5TTOXj/9Vg4fwO5+ntckAR1xal78X8gLHMSVhaUdvWRKIb7gRAYgOYri
         33+S38NA/YU/zqqbx38R9rbUY0F4Z3Iszm5iBNFRqA6lYNpdXhxywp5DpuEp+Mhd5CFn
         fgnOcIA+AP2AUB4tzArrW/yDf3I1U1xPhFqVfrecfP8oQVcGSoXwK9QLPt6Q3USh/8yq
         m8XQ==
X-Gm-Message-State: AOAM531dG/IX9tf0END4ciDL402kR/py5waWolnpCD6wrkfTTQKb/JuS
        Zlj9uTwVVIOCXUqGmDx5lc+FhA==
X-Google-Smtp-Source: ABdhPJxN8IGumZCWd1fAAmcDYxuZpHog0y7EPKYYSZrueky3QkPY19f3QXZocnmRUF7EpsZHvD+dow==
X-Received: by 2002:a17:906:1386:: with SMTP id f6mr6502713ejc.45.1616530506708;
        Tue, 23 Mar 2021 13:15:06 -0700 (PDT)
Received: from localhost.localdomain (162.40.150.83.ftth.as8758.net. [83.150.40.162])
        by smtp.gmail.com with ESMTPSA id bx24sm11841131ejc.88.2021.03.23.13.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 13:15:06 -0700 (PDT)
From:   =?UTF-8?q?Oliver=20St=C3=A4bler?= <oliver.staebler@bytesatwork.ch>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Cc:     oliver.staebler@bytesatwork.ch, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mm: Fix pad control of SD1_DATA0
Date:   Tue, 23 Mar 2021 21:14:50 +0100
Message-Id: <20210323201450.12060-1-oliver.staebler@bytesatwork.ch>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix address of the pad control register
(IOMUXC_SW_PAD_CTL_PAD_SD1_DATA0) for SD1_DATA0_GPIO2_IO2.  This seems
to be a typo but it leads to an exception when pinctrl is applied due to
wrong memory address access.

Signed-off-by: Oliver Stäbler <oliver.staebler@bytesatwork.ch>
---
 arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
index 5ccc4cc91959d..a003e6af33533 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
+++ b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
@@ -124,7 +124,7 @@
 #define MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD                                     0x0A4 0x30C 0x000 0x0 0x0
 #define MX8MM_IOMUXC_SD1_CMD_GPIO2_IO1                                      0x0A4 0x30C 0x000 0x5 0x0
 #define MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0                                 0x0A8 0x310 0x000 0x0 0x0
-#define MX8MM_IOMUXC_SD1_DATA0_GPIO2_IO2                                    0x0A8 0x31  0x000 0x5 0x0
+#define MX8MM_IOMUXC_SD1_DATA0_GPIO2_IO2                                    0x0A8 0x310 0x000 0x5 0x0
 #define MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1                                 0x0AC 0x314 0x000 0x0 0x0
 #define MX8MM_IOMUXC_SD1_DATA1_GPIO2_IO3                                    0x0AC 0x314 0x000 0x5 0x0
 #define MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2                                 0x0B0 0x318 0x000 0x0 0x0
-- 
2.29.2

