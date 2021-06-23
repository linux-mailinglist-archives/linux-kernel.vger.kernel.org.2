Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6639D3B1981
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhFWMC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhFWMCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:02:25 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FB0C061574;
        Wed, 23 Jun 2021 05:00:06 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id f15so2337180wro.8;
        Wed, 23 Jun 2021 05:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eJZITneZK2pFfehw2W3mpmQwKfsEafjynuMXLav/Q64=;
        b=RSRTZL+7yEON+42CSpXCS2ZRdRKBpmmq72uqvVtJBaDX3QuE7tbiRTixuPVK3Q28r3
         boMLUjmnhkk4HH48WoC6ClKZ/HAhEkVDZkviSYDWnP7KbFHfCMFnm5gDuCSai7a23tzf
         HsBNDQzfqi5YiwBlOAhjQSbq1gUZmiKzlxaGpsTgGGYiPuw/7+YC4uEnwFtve3FeTdJ6
         d1OqvQL46F1hB4EGtR66C6BE6hPx948e+WE5i9jXVoGFZflrvO1P1xvnwCGhC4/5eGZi
         VjxOnG9g0q9yUkv8Tkg7LejN/8ZQAidlLxzSReXTKWpjIQhnar8Kjg65Kfyltm+wLYmQ
         M9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eJZITneZK2pFfehw2W3mpmQwKfsEafjynuMXLav/Q64=;
        b=J2QWiNyNwIeNz5Kn4DymDsuI4HQKZj7JDaGF3Kz7DyR6p6sX0wAwjn0WqM2nUGgGhi
         85imLqlrc0Ur48D8LUyCyePv8IYOEVuKCXCtRMQvlrymqkTzLdJwEZEM4uSybX6uPFWn
         XoUJdx8vMjageFn60eG0PDISnIcnn4UiYK535sQ3Zf44s5z1CjqgQmA6D/Ob1qkeRxR/
         xBU1qutsZEFvmVZRrlF73nWXqbnkY37P+Bl6pqImbOmZabesg5SfKHeFQn/HhdCnmUfB
         bBkpoOO6BM9Uku51AO+PwpkC+thnP7FEiIbltk6xI08iiJXpJmIZXcwzlIFceraflICq
         TKAA==
X-Gm-Message-State: AOAM531ysZ9gTH5ZV1P5wgafRl7ihX7QBcTcsVAv7pjY+ias/WSqTVqt
        hpE9DDRXuOnl0eqo43vc/A==
X-Google-Smtp-Source: ABdhPJxp2pV1Cwiio1m4yUGYVArQ7yQtoI2cifSaqMW73mMQPqvJNyrgsvNNrAOPg4u2yFDam2cYTg==
X-Received: by 2002:a5d:6502:: with SMTP id x2mr10729320wru.327.1624449605446;
        Wed, 23 Jun 2021 05:00:05 -0700 (PDT)
Received: from localhost.localdomain (ip5b434b8b.dynamic.kabel-deutschland.de. [91.67.75.139])
        by smtp.googlemail.com with ESMTPSA id y189sm5666157wmg.6.2021.06.23.05.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 05:00:05 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: Add sdmmc_ext for RK3328
Date:   Wed, 23 Jun 2021 14:00:01 +0200
Message-Id: <20210623120001.164920-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK3328 SoC has a fourth mmc controller called SDMMC_EXT. Some
boards have sdio wifi connected to it. In order to use it
one would have to add the pinctrls from sdmmc0ext group which
is done on board level.

While at that also add the reset controls for the other mmc
controllers.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index da84be6f4715..c13fa2f3f4cd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -858,6 +858,8 @@ sdmmc: mmc@ff500000 {
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		max-frequency = <150000000>;
+		resets = <&cru SRST_MMC0>;
+		reset-names = "reset";
 		status = "disabled";
 	};
 
@@ -870,6 +872,8 @@ sdio: mmc@ff510000 {
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		max-frequency = <150000000>;
+		resets = <&cru SRST_SDIO>;
+		reset-names = "reset";
 		status = "disabled";
 	};
 
@@ -882,6 +886,8 @@ emmc: mmc@ff520000 {
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		max-frequency = <150000000>;
+		resets = <&cru SRST_EMMC>;
+		reset-names = "reset";
 		status = "disabled";
 	};
 
@@ -980,6 +986,20 @@ usb_host0_ohci: usb@ff5d0000 {
 		status = "disabled";
 	};
 
+	sdmmc_ext: dwmmc@ff5f0000 {
+		compatible = "rockchip,rk3328-dw-mshc", "rockchip,rk3288-dw-mshc";
+		reg = <0x0 0xff5f0000 0x0 0x4000>;
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_SDMMC_EXT>, <&cru SCLK_SDMMC_EXT>,
+			 <&cru SCLK_SDMMC_EXT_DRV>, <&cru SCLK_SDMMC_EXT_SAMPLE>;
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
+		fifo-depth = <0x100>;
+		max-frequency = <150000000>;
+		resets = <&cru SRST_SDMMCEXT>;
+		reset-names = "reset";
+		status = "disabled";
+	};
+
 	usbdrd3: usb@ff600000 {
 		compatible = "rockchip,rk3328-dwc3", "snps,dwc3";
 		reg = <0x0 0xff600000 0x0 0x100000>;
-- 
2.27.0

