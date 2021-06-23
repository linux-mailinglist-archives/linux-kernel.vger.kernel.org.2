Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8033B1CFB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 16:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhFWPBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 11:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWPBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 11:01:43 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A61C061574;
        Wed, 23 Jun 2021 07:59:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i94so3016312wri.4;
        Wed, 23 Jun 2021 07:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rgspf46aiQviRMOC9Q3QVjuGGzAywfUO2vjWnpCd7FM=;
        b=doLMYYZf9Ic92WHKcXaYf1NRPdNMdNPlRNtYsrkKRXUsb9N5j+OWX5PkjkobwXrTJ1
         GqSdwKT1Qxs0GewjFzMCqwxFRIPRM1focjsEIJQD6fxxWd0z0slO+JgL8Va8CiCRNgyr
         5mgXVg5TYOMzDouFQtq90066lOY6OXtreD7QCU2V8+lI9GcU7A5eKFnOaI7ghV6uN/4N
         gPbVIslOhRf74uFcAURC/b8gdNOEFjLqpcAn/nHFDXr3w4tKqvLNJBeupvhAxLu1LhYy
         QoG+dT9yj4pP60Ui5nfO6lZ66C9XLOWcPuuaAhPpTUbKxPVHw/d6ngOcjRG9rAjqZpCR
         qOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rgspf46aiQviRMOC9Q3QVjuGGzAywfUO2vjWnpCd7FM=;
        b=bmMTU9NWtnJ44EjwtwNujGfxPIqxvv8la6NlQfl8nWUBiD7RRcm9i5YEw6iwdIMAmv
         8zMx6EBypBRRQuz+h61i9ff5IYwTVWvT8rJpnWm0f343aLcimtDUvDN2aDuPiiTyPXAF
         izKHGIQMHOCkp4hB1xZxlu8d9k+3VAYsTM9w4fwOYJ4kP2lJIquy9UM0LXQIuRG69rYu
         RrKtapfPG0PEivnsNIUC5EueCKs6i2S+CSIBoxUjCGVQwgqgnKJOkXhqmHOIeztzUo0J
         XEbiA+CLkVj45pIOQszFKFnQnYK9Nkw5IMd0SxqYgQ1HqZgqA8yZcO2i8npCk6E6e3Sb
         zjAQ==
X-Gm-Message-State: AOAM531bBJeCFZNRdI8p4pvQsgg9HvROtd8Wjgm0Ky3kvF09FRMhwSPq
        pQIrUxcgAEe9uEIDtGJ0pQ==
X-Google-Smtp-Source: ABdhPJwNwSw2Bc/LOuSVHV1AObnhRNMS8wUppy0twDkW+2tOffI8MC+j9MxQsJ/8sBnjU1u/dl1shg==
X-Received: by 2002:a5d:50ce:: with SMTP id f14mr466201wrt.259.1624460363556;
        Wed, 23 Jun 2021 07:59:23 -0700 (PDT)
Received: from localhost.localdomain (ip5b434b8b.dynamic.kabel-deutschland.de. [91.67.75.139])
        by smtp.googlemail.com with ESMTPSA id n4sm301012wrw.21.2021.06.23.07.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 07:59:23 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Jonker <jbx6244@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2] arm64: dts: rockchip: Add sdmmc_ext for RK3328
Date:   Wed, 23 Jun 2021 16:59:18 +0200
Message-Id: <20210623145918.187018-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210623120001.164920-1-knaerzche@gmail.com>
References: <20210623120001.164920-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK3328 SoC has a fourth mmc controller called SDMMC_EXT. Some
boards have sdio wifi connected to it. In order to use it
one would have to add the pinctrls from sdmmc0ext group which
is done on board level.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---

 Changes in v2:
 - fixed node name in accordance to DT bindings (Johan)
 - seperated patch which adds reset controls for the
   other mmc controllers (Chen-Yu)

 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index da84be6f4715..aa11bce576a4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -980,6 +980,20 @@ usb_host0_ohci: usb@ff5d0000 {
 		status = "disabled";
 	};
 
+	sdmmc_ext: mmc@ff5f0000 {
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

