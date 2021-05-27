Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F361B39291B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 09:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbhE0H63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbhE0H5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:57:53 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAD5C06134C
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 00:56:13 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so1854445pjp.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 00:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bs9RElxHAA2/T87AXUzFrLVnBm2Et2bauPM/4axG/FU=;
        b=Kp6DjbrtwxHVMbu9vC89wum0z6Wd6wBAY+P3h9yODiqxzV1CSqEqZkn8AcVfdQAsiP
         +AAJyhqt6gPzl1LJUhiZvmX2Wqymn2hmGghdAdVnjPGXWpZeXRmz8HpHm6wcB/jkOpab
         +AmkG3itwe4pjzT6FoiTYBhKq/U8VWjdgTYjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bs9RElxHAA2/T87AXUzFrLVnBm2Et2bauPM/4axG/FU=;
        b=tMt0SbI7hLbGcS5xN4TGT8bJ5mEmFLTwQ/CcwF9NXTGbY4dbVg3rpj8TSbsxebQy7Q
         oDCv/KvZubMrmOcxeeiDL5tN2ijDdqHksXivp0OsHbNWdwlEIA3y+UomuP1U0Br3+pO4
         pNCk8SoTpeDADDSggKRxdoSdaqelzghGeXOgJvla1lJQwGdwsHwFSu2GBE2xNXDMJYPs
         RAtNyjZrPdKWSXoxHdw12i9i3dDqxlnhpGh8x4pG5ND+esJQ1MBeDCi3cgXYcsZStjsD
         abMulhITlGylUGCZwhQ8cvWFGMgRXirXij1n668SIb3B1tNCxiUaaVeib8iIDW58iKqO
         JIWw==
X-Gm-Message-State: AOAM532zDy4z2OqvGIxNEuZAVX0SNq2Ap3CaOWnHGBYGgftHYJ4UehDf
        G9nKJNzFxww4OESucxccAWSs1w==
X-Google-Smtp-Source: ABdhPJzDc7fsuKMi25L9v4XVlntAVouxCshVJH65zuHU4vn8GVctO7aUJevs+2Tk6+o8akhdHfAIlA==
X-Received: by 2002:a17:90a:fa91:: with SMTP id cu17mr2501646pjb.214.1622102172870;
        Thu, 27 May 2021 00:56:12 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:ece5:55a4:6ad3:d20f])
        by smtp.gmail.com with ESMTPSA id 69sm1217790pfx.115.2021.05.27.00.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 00:56:12 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Wolfram Sang <wsa@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jean Delvare <khali@linux-fr.org>,
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
Subject: [PATCH v21 RESEND 4/4] arm64: dts: mt8183: add supply name for eeprom
Date:   Thu, 27 May 2021 15:55:56 +0800
Message-Id: <20210527075556.1709140-5-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
In-Reply-To: <20210527075556.1709140-1-hsinyi@chromium.org>
References: <20210527075556.1709140-1-hsinyi@chromium.org>
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
2.31.1.818.g46aad6cb9e-goog

