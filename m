Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B2A3DE175
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 23:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhHBVUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 17:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbhHBVUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 17:20:48 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEC8C06175F;
        Mon,  2 Aug 2021 14:20:38 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b6so13394654lff.10;
        Mon, 02 Aug 2021 14:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nw2Y0y0fghw+sFEgC64gNuaGBHW1wy1WhSDHTe1H5dY=;
        b=qmXEfvlt5ZJukJLd9J/LlnBeRZua9XCr1Ch+H6TojPzJUVw2OdyhKOH/AD4m4Ovc4r
         TnGDK50jm8XGwBLP/0ofVakvt8CL4G10ZxmZR8/PPdbDa40yOxSC38V2S9OdG8kNio2D
         FUsgGdrn79JHiPpg4++88HQo0UVDY2yMU0jbmOb2pXLBzEsGP4+8slA0K1azYRoueenf
         /O9OCvMfac+EJePzlHMD6Wrp7UPttGknhKnqmL7Swz5d+j9E1a6ef61mS8gVkxC2K8qO
         z2QGyhUbgWmqqjKdkBa2IUICopXhdOdd3pzoKr3W0UcHxqBr5DJMeGXGQWvXpa8QDc+z
         cY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nw2Y0y0fghw+sFEgC64gNuaGBHW1wy1WhSDHTe1H5dY=;
        b=ZLuI1M6SnPXYG2zRU32I9UOIDKhLJ2sh/IupBNCzLcQ691qSfaXlFbqMl3cZei9S3G
         8uzbOYzaLYrDZuKIDWmiMfFXC4Fo4/KUvZ2L8MNGYkQ9c5WWvnxGFWSwAvJPbs/ZlfOi
         kcHYlA4Ijsc6qZHEEgjxV77v1w218KWNo0AKa60Vk/dVPZ5cRKwuy+8wscZoYUo3A8tu
         ljWc3RPEVox/De4tQ/R47JO3zFMJY6u23DB58xL9Z/1K/rBtzO8hX7MxhvapNOZeUKh/
         9KdD8aUTy+QuPwCCOZ0nsgXFab0sMg5KYzux8BFXsRrYQvxtDWXNV9n1gcsvUW8qnDZd
         0XMw==
X-Gm-Message-State: AOAM532Xqogt9g97tJbDSGwDc9nH7MvFe97eMSTXNHcEozRupam9l/X9
        kmk/1PVASLRKc9aEt6LZjug=
X-Google-Smtp-Source: ABdhPJwfQ9REISquOUPaYiCcW3Jms2LLuB4Cg71HUCHKdwVrw7zHtR+QhhAVEi+TWk+BpkSAzpfZTw==
X-Received: by 2002:a05:6512:169d:: with SMTP id bu29mr9951423lfb.160.1627939236961;
        Mon, 02 Aug 2021 14:20:36 -0700 (PDT)
Received: from localhost.localdomain (94-29-22-96.dynamic.spd-mgts.ru. [94.29.22.96])
        by smtp.gmail.com with ESMTPSA id p14sm764942lfa.117.2021.08.02.14.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 14:20:36 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 02/15] ARM: tegra: ouya: Add interrupt to temperature sensor node
Date:   Tue,  3 Aug 2021 00:19:34 +0300
Message-Id: <20210802211947.19715-3-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802211947.19715-1-digetx@gmail.com>
References: <20210802211947.19715-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TEMP_ALERT pin of LM90 temperature sensor is connected to Tegra SoC.
Add interrupt property to the temperature sensor and enable it in pinmux,
for completeness.

Tested-by: Matt Merhar <mattmerhar@protonmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30-ouya.dts | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-ouya.dts b/arch/arm/boot/dts/tegra30-ouya.dts
index ab8744f3d72d..90db5ff72537 100644
--- a/arch/arm/boot/dts/tegra30-ouya.dts
+++ b/arch/arm/boot/dts/tegra30-ouya.dts
@@ -124,12 +124,11 @@ cpu_temp: nct1008@4c {
 			compatible = "onnn,nct1008";
 			reg = <0x4c>;
 			vcc-supply = <&sys_3v3_reg>;
+
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(CC, 2) IRQ_TYPE_EDGE_FALLING>;
+
 			#thermal-sensor-cells = <1>;
-/*
- *			The interrupt is bugged, once triggered it never clears.
- *			interrupt-parent = <&gpio>;
- *			interrupts = <TEGRA_GPIO(CC, 2) IRQ_TYPE_LEVEL_LOW>;
- */
 		};
 
 		pmic: pmic@2d {
@@ -4376,8 +4375,8 @@ pcc2 {
 		nvidia,pins = "pcc2";
 		nvidia,function = "i2s4";
 		nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-		nvidia,tristate = <TEGRA_PIN_ENABLE>;
-		nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+		nvidia,tristate = <TEGRA_PIN_DISABLE>;
+		nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 	};
 	sdmmc4_rst_n_pcc3 {
 		nvidia,pins = "sdmmc4_rst_n_pcc3";
-- 
2.32.0

