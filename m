Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB93457C2A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 08:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbhKTHiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 02:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbhKTHh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 02:37:59 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47030C061748;
        Fri, 19 Nov 2021 23:34:56 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so12251809wme.0;
        Fri, 19 Nov 2021 23:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OM2Q2y6CgmId2R4mi5bkqpR+tR4JTdqKcUf7G8xj6co=;
        b=jKs3FDya/Z9bazr9ZhSJ0Rgg6S+9NH4+HyfOx+9ft1ecocbFvoI+UtITN0//G9LuRp
         DuQ4Q2AlQZKArwDuJT7opw6uBHRDxU63pOAsbzsmtLh6MGUtHKRHyZdP6Y1OI8tPObSk
         ULRStBmJ5EF0zvi3FuiX2u3HVfOWEfmdx4zobd2qbg15yoQCTlzScPvq5Hr7YeL218GP
         hZtCTHXdM68ZACyttsJnq5wWpavb+WvSU6mhKFNTBdydj/Gozq13slrTgWPPb/RqLafj
         wyZCwVtNVwWIPEU13DwnfQ2D3vMyyw0+rdPoc+2Pje4DFJEXgikUPTybkIvGLTlZ6cgF
         LfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OM2Q2y6CgmId2R4mi5bkqpR+tR4JTdqKcUf7G8xj6co=;
        b=ddmeaoPNlV5sPXK/nrQ//VDe1WI9n9SeRCPGnVeKTZs1esKdvm2d4wuYikYhQOgGTn
         4/akxtprmW0rc9pLA9qbiFImtHUA4mdo+20FCXSZZlSy778kqM3Q4NqJhDSbFBawovqE
         ymp68qM2wS4eGj1gaK9qXYhGcqGF8nPw2Dwrh522AOlqDU4/5yayvt3QuvH/RWOIigAQ
         rmgZ1Fq0mWR0rLdaUXX/1Mgu2Zm1u9AX2l7LZMkBqcvg3LOG+GLVmkuXaG4IoE6QkPSp
         NymewhFTaYqkXUsttGSslB+RZ89cOO8YC1myzxyuqGCFaxTTMq8CY6PCukJZpjBz+o5g
         LaVg==
X-Gm-Message-State: AOAM533PcEAEMnB74JbyROSPp8SS0/I38sUKmB3Ic082IJMk0v1oqkuJ
        RDXUCGC4sHUKga38osb18qThMZzRnpWxkg==
X-Google-Smtp-Source: ABdhPJx6qjUexfTH0BphOvHctVVn/Kt/mw75BqIG0yjsu3k9x9MB0iSsIdkwPFhECEC7ZShYtKCarA==
X-Received: by 2002:a05:600c:2205:: with SMTP id z5mr7674255wml.40.1637393694855;
        Fri, 19 Nov 2021 23:34:54 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id a141sm13776345wme.37.2021.11.19.23.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 23:34:54 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 2/2] ARM: dts: sunxi: Add CEC clock to DW-HDMI
Date:   Sat, 20 Nov 2021 08:34:48 +0100
Message-Id: <20211120073448.32480-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211120073448.32480-1-jernej.skrabec@gmail.com>
References: <20211120073448.32480-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Experimentation determined that HDMI CEC controller inside DW HDMI block
depends on 32k clock from RTC. If this clock is tampered with, HDMI CEC
communication starts or stops working, depending on situation.

SoC user manual doesn't say anything about CEC, so this was overlooked.
Fix this by adding dependency to RTC 32k clock.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi   | 4 ++--
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 1d87fc0c24ee..f10436b7869c 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -1212,8 +1212,8 @@ hdmi: hdmi@1ee0000 {
 			reg-io-width = <1>;
 			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_HDMI0>, <&ccu CLK_HDMI_SLOW>,
-				 <&ccu CLK_HDMI>;
-			clock-names = "iahb", "isfr", "tmds";
+				 <&ccu CLK_HDMI>, <&rtc 0>;
+			clock-names = "iahb", "isfr", "tmds", "cec";
 			resets = <&ccu RST_BUS_HDMI1>;
 			reset-names = "ctrl";
 			phys = <&hdmi_phy>;
diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index c7428df9469e..d1e974886fdf 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -813,8 +813,8 @@ hdmi: hdmi@1ee0000 {
 			reg-io-width = <1>;
 			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
-				 <&ccu CLK_HDMI>;
-			clock-names = "iahb", "isfr", "tmds";
+				 <&ccu CLK_HDMI>, <&rtc 0>;
+			clock-names = "iahb", "isfr", "tmds", "cec";
 			resets = <&ccu RST_BUS_HDMI1>;
 			reset-names = "ctrl";
 			phys = <&hdmi_phy>;
-- 
2.34.0

