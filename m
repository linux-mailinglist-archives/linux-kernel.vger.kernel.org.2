Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247753765E5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 15:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbhEGNPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 09:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbhEGNP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 09:15:26 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B701CC06138A
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 06:14:25 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c17so7588253pfn.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 06:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/iQHjQJIEusNn1tquHlPyPfKvKOnU6uAD3LtZICkSiM=;
        b=Ntg96WjpZ1VistrBYqL1M+HK91mFEC+3LlO4WcHsmMOyYoAslkXmmt2h1ClxsM3Apb
         W0RPjQkzmRQ6pAeshLswDxYI/yHhuHUvntGs7ECONjXx5tt/ikILaFPgozqnrKsSfYSK
         y0Z3sfhDiGGkMJ4FClXIiU33vLsL8BM++f2IY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/iQHjQJIEusNn1tquHlPyPfKvKOnU6uAD3LtZICkSiM=;
        b=p9mLMzvxpVmvtQfJTnfggN1Sv1J8axRmCbT+RbJL6TGxHzKq8N5ZfmfVy4XsgvMrog
         iWe+NqwGRNsxGGkyCkUjbIVZss/UE+OcjZvkxepDI/ehoR/LA7VIkmRU/f47Mqr+TQxV
         PaZvasEFAvxrgLWwXYUefeDKAfhag0fcFUaNs2QzychSIwpl9IyxNxcqF//DDFBINgrn
         N2j17BmkWub7cKTxP6bsU+X0+jIoLjFJwtScVlQTQcykekqL4BRU3jfJPF82RNhi3+58
         ic+0evmZNcvDefbixPn7PpLUfFjTej9hvrd0fnnn3Ojr6t+VvtxmIK13mvE7f7dSynEH
         XwdA==
X-Gm-Message-State: AOAM533t1B8oWztHNT/FpNpE31dweaJfoGaPkf4cP8BcKK74zGtakLii
        hqzOojy8V/BxYAVSBZJjMPuDGw==
X-Google-Smtp-Source: ABdhPJweownY6VlR0g3o1Ae3IqbU2FAY+KMj3UbN7XuWvnzt3rtaswXISD0Xy/yW7E2bmE0y6nb0Ow==
X-Received: by 2002:aa7:9191:0:b029:256:898f:150 with SMTP id x17-20020aa791910000b0290256898f0150mr10411116pfa.74.1620393265252;
        Fri, 07 May 2021 06:14:25 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:711f:8553:a124:a19])
        by smtp.gmail.com with ESMTPSA id z29sm4656539pga.52.2021.05.07.06.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 06:14:24 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Wolfram Sang <wsa@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-i2c@vger.kernel.org, Qii Wang <qii.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v21 5/5] arm64: dts: mt8183: add supply name for eeprom
Date:   Fri,  7 May 2021 21:14:06 +0800
Message-Id: <20210507131406.2224177-6-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210507131406.2224177-1-hsinyi@chromium.org>
References: <20210507131406.2224177-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add supplies for eeprom for mt8183 boards.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi  | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
index b442e38a3156..28966a65391b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
@@ -88,11 +88,13 @@ &i2c2 {
 	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 	clock-frequency = <400000>;
+	vbus-supply = <&mt6358_vcamio_reg>;
 
 	eeprom@58 {
 		compatible = "atmel,24c32";
 		reg = <0x58>;
 		pagesize = <32>;
+		vcc-supply = <&mt6358_vcama2_reg>;
 	};
 };
 
@@ -101,11 +103,13 @@ &i2c4 {
 	pinctrl-0 = <&i2c4_pins>;
 	status = "okay";
 	clock-frequency = <400000>;
+	vbus-supply = <&mt6358_vcn18_reg>;
 
 	eeprom@54 {
 		compatible = "atmel,24c32";
 		reg = <0x54>;
 		pagesize = <32>;
+		vcc-supply = <&mt6358_vcn18_reg>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
index 2f5234a16ead..3aa79403c0c2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
@@ -62,11 +62,13 @@ &i2c2 {
 	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 	clock-frequency = <400000>;
+	vbus-supply = <&mt6358_vcamio_reg>;
 
 	eeprom@58 {
 		compatible = "atmel,24c64";
 		reg = <0x58>;
 		pagesize = <32>;
+		vcc-supply = <&mt6358_vcamio_reg>;
 	};
 };
 
@@ -75,11 +77,13 @@ &i2c4 {
 	pinctrl-0 = <&i2c4_pins>;
 	status = "okay";
 	clock-frequency = <400000>;
+	vbus-supply = <&mt6358_vcn18_reg>;
 
 	eeprom@54 {
 		compatible = "atmel,24c64";
 		reg = <0x54>;
 		pagesize = <32>;
+		vcc-supply = <&mt6358_vcn18_reg>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
index fbc471ccf805..30c183c96a54 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
@@ -71,11 +71,13 @@ &i2c2 {
 	pinctrl-0 = <&i2c2_pins>;
 	status = "okay";
 	clock-frequency = <400000>;
+	vbus-supply = <&mt6358_vcamio_reg>;
 
 	eeprom@58 {
 		compatible = "atmel,24c32";
 		reg = <0x58>;
 		pagesize = <32>;
+		vcc-supply = <&mt6358_vcama2_reg>;
 	};
 };
 
@@ -84,11 +86,13 @@ &i2c4 {
 	pinctrl-0 = <&i2c4_pins>;
 	status = "okay";
 	clock-frequency = <400000>;
+	vbus-supply = <&mt6358_vcn18_reg>;
 
 	eeprom@54 {
 		compatible = "atmel,24c32";
 		reg = <0x54>;
 		pagesize = <32>;
+		vcc-supply = <&mt6358_vcn18_reg>;
 	};
 };
 
-- 
2.31.1.607.g51e8a6a459-goog

