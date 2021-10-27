Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F3643CC5F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242602AbhJ0OkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 10:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238699AbhJ0OkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:40:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6437C061570;
        Wed, 27 Oct 2021 07:37:38 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u18so4568587wrg.5;
        Wed, 27 Oct 2021 07:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TGWbt0DaQKCswEBt0ArwqQnvqc41g6JU5zhKYrPiWaQ=;
        b=pDTwVgBFo87UyDGWShmU8Dtev0ZcRzpYvlQV7kt71SdaMb+m9heGBhDyFk+2SBwRU3
         DwfKkUXyW/mCm399z0UXEV8CmFcsM8Hy9CmvXzQDispnVGrO7MVgyy2TR6N3D2Vx5LpQ
         puLeSWTY65hXS8VRkPCtnK6iqDKBwGEBghH9fvn5AAvK9OM0ODR7PK+Xaj2y9Wolb62H
         Q92o7tCS67mWgTPJlp8krqQhrxXBXqIVyh8735JbAq8G2Usb8CNup0wXntvUgfJFI4aS
         LGWimyCP1Uc+kdMGOHCAqLC6It7D1b+yCKiS1R/y+M+JZx1SdMYBXETyo/muHZ6XVFtU
         iu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TGWbt0DaQKCswEBt0ArwqQnvqc41g6JU5zhKYrPiWaQ=;
        b=uVih5zRCCsuAPYGBFFXWsk9V6L32LrFIUr1mFPVBupN0LW+5aI/shCCypswtIynRQJ
         G8Gt5rt5PhwPBtMZm2fja9qBE6bsijQoCK0tThfen99CnX4r85N2fDANmT/Yr3CLTirh
         +zJUsD3WqCbnqIxRsEykq//0n9fCtTxPcDvDkj3sVgmKaw0xpV3YmNnE05r0Gxr5OVpI
         TfDZV+kTisYUnyismkM9GD9HXO4sbmHpExtfTUwr77uFo9oyYTLwCC4YAD1VmneNoQcI
         DWDvGUGrqvi00gZCUeNXSMwjYVhbbHsRnySyndf5QzViR9TV3QVHp9MHSlo/MUD9Wt+a
         mvUw==
X-Gm-Message-State: AOAM532hpIG9e4vr7gECi1DtZishQPuiDvSBBAlr5oR93ztihUTJ93ju
        FrCw9v+7fJ95jw23G6QTh1x8T2+erFrK
X-Google-Smtp-Source: ABdhPJwbUhkqT+wluf90XToU2xknGoyv3gvSKRYquezS11x9eVlIvfNpBcu0LsM7zKblTtfbIPXdkA==
X-Received: by 2002:adf:f50f:: with SMTP id q15mr42084157wro.324.1635345457284;
        Wed, 27 Oct 2021 07:37:37 -0700 (PDT)
Received: from alex-ThinkPad-E480.. ([2a02:810b:f40:4200:8072:4c96:3e48:9ebf])
        by smtp.googlemail.com with ESMTPSA id p21sm25866wmc.11.2021.10.27.07.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 07:37:37 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 1/2] arm64: dts: rockchip: fix audio-supply for Rock Pi 4
Date:   Wed, 27 Oct 2021 16:37:25 +0200
Message-Id: <20211027143726.165809-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated in the schematics [1] and [2] P5 the APIO5 domain is supplied
by RK808-D Buck4, which in our case vcc1v8_codec - i.e. a 1.8 V regulator.

Currently only white noise comes from the ES8316's output, which - for
whatever reason - came up only after the the correct switch from i2s0_8ch_bus
to i2s0_2ch_bus for i2s0's pinctrl was done.

Fix this by setting the correct regulator for audio-supply.

[1] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/rockpi4_v13_sch_20181112.pdf
[2] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/rockpi_4c_v12_sch_20200620.pdf

Fixes: 1b5715c602fd ("arm64: dts: rockchip: add ROCK Pi 4 DTS support")
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index 98136c88fa49..6a434be62819 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -502,7 +502,7 @@ &io_domains {
 	status = "okay";
 
 	bt656-supply = <&vcc_3v0>;
-	audio-supply = <&vcc_3v0>;
+	audio-supply = <&vcc1v8_codec>;
 	sdmmc-supply = <&vcc_sdio>;
 	gpio1830-supply = <&vcc_3v0>;
 };
-- 
2.30.2

