Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC3734E422
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhC3JOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbhC3JOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:14:33 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8120BC061762;
        Tue, 30 Mar 2021 02:14:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j7so15518541wrd.1;
        Tue, 30 Mar 2021 02:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nx33d/YZ6yZcVe9iyHxxB6ik30Fg4//IQGVN3VdYgTQ=;
        b=q1LT3uq3ARCX9W7iFN5aCCkzDc4psyVwwAFoK/85Bz7HGSpF7Pgvd1Ol9LN2GKSraM
         kZI36QZmqFPZ2bCIu3xVURwGD4R0rkQGHzGp901UHv5hkY5QLdKmNEFI552ybbGSAC0S
         8I45ueV/BC7VWCis0I1dnYQz1zspGpsRIv+aNMyOwTAcvQo2ITEbeRogmBY6uNV39Q88
         e1obxIqHv8BvebTLquDDJu/xAR37BMp9Eak0z3F+1Ig9OVWx5blZpYvIu9oNjAaF3KHK
         WWu6OQ8Iyaq93baYfdzDd1dqkRsCUuPZ7zPEAHxE9AGZciSXNwWo012bAyI0jJ3DXHPZ
         IUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nx33d/YZ6yZcVe9iyHxxB6ik30Fg4//IQGVN3VdYgTQ=;
        b=hKk18XrHRAjl8BnAM7wnVuh/CTrFjjvBFIA0Se2NIkaDVkWq4+zSeSFu3Q8Ur42qQB
         SuCHI3h2Mgm1MvcoNdQSwOmBIbx2IPmWfANJQ+r/HfRUZdPMcCLn6Qjw1bcR5x6Yzp4S
         Ooe2tTEpATPUzYXHKXrXuPsbAGHjhAKfubaBl1s2NQqBB+54nDy9qOAMX58+VQr+AHZf
         8wrL84dSNbfNBH7gHpKL/DRwGqBffN5RTN2HfZkyufFlCLr+kfkIcd/vR8EW1rMDfdwd
         xQYEnu4aofofrkKnDDOVryd2g1z8p+cp/VLmhOTYIx1fOxwLiI1OanvmH4tTpPVZ6mgj
         jBUQ==
X-Gm-Message-State: AOAM532kMmVoEYO0DTEXqVRNXz/t4X0yxXVgLM+4bha5Ho5u+Wz+oCGx
        76pJJfty2dTFTmYhPZGP7I0=
X-Google-Smtp-Source: ABdhPJwxma0iz3LbgNV3aSI8d7a41w+w3hu++JbP/KSZoWRwWo5wgObjWqY7CTfcQTyP7bROC9ofjA==
X-Received: by 2002:a05:6000:c7:: with SMTP id q7mr33152565wrx.356.1617095672275;
        Tue, 30 Mar 2021 02:14:32 -0700 (PDT)
Received: from localhost.localdomain (2a01cb0008bd2700a086f61fd085ac55.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:a086:f61f:d085:ac55])
        by smtp.gmail.com with ESMTPSA id l8sm33305840wrx.83.2021.03.30.02.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 02:14:31 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 4/4] arm64: defconfig: Enable LT8912B DRM bridge driver
Date:   Tue, 30 Mar 2021 11:14:26 +0200
Message-Id: <20210330091426.95030-5-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330091426.95030-1-adrien.grassein@gmail.com>
References: <20210330091426.95030-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is used by the Nitrogen8 SBC.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts | 8 --------
 arch/arm64/configs/defconfig                      | 1 +
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
index da5a95ffa8b4..4ffd23ea705f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
@@ -281,14 +281,6 @@ max7323: max7323@68 {
 	};
 };
 
-&gpio3 {
-	max7323_intterupt {
-		gpio-hog;
-		gpios = <15 0>;
-		input;
-	};
-};
-
 &lcdif {
 	status = "okay";
 };
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3f059bca9e24..39bddac5e44a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -690,6 +690,7 @@ CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
 CONFIG_DRM_PANEL_SITRONIX_ST7703=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
 CONFIG_DRM_DISPLAY_CONNECTOR=m
+CONFIG_DRM_LONTIUM_LT8912B=m
 CONFIG_DRM_NWL_MIPI_DSI=m
 CONFIG_DRM_LONTIUM_LT9611=m
 CONFIG_DRM_SII902X=m
-- 
2.25.1

