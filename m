Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDFE3D8DBA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 14:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbhG1M0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 08:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235912AbhG1M00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 08:26:26 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609ADC061764;
        Wed, 28 Jul 2021 05:26:25 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id h27so1150887qtu.9;
        Wed, 28 Jul 2021 05:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0vSamTyccptzOdkOr+v7GJn23T5SHRt0Wd7iQnG52jY=;
        b=NXvdypyXEa4o9r6QNCKGCY4jqgUM7FwQyguNMcp5lkIjpGB+WdZ7BFx1c/u3pIKVql
         xZ7WfbEzGHcLBeot5u0VCUkU5Xiz8M48dtv0Y8s72CnAs0Bbk4XmyyTY7d1TYUwCG9y7
         jM9H8cynwnhtPLV5Iwk43QGh3VhSprSNKbi9f0CnLGJWoqplCV+PE4jm9VtYBqFWvA/l
         s/tveoUnL3gPAMnQUmt8k2Ym8/EJDJuHj9g45pxqRNQB6kqhYQ53F/WXTIHiTXbKQ4cF
         nwBhsYqwwxjTEhok3iIavyRoN1cXChF43DJ32V98m+qcUfsCT6RMv88RILDJT/uYiH8Z
         DXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0vSamTyccptzOdkOr+v7GJn23T5SHRt0Wd7iQnG52jY=;
        b=A1i4tnI34Sj6QtD248sKQvsKGeVetnUX6eulwQl3bYa5b5OKwBilm8YmZjbT70D6ET
         Xk947mtyelsO4FODtDjd8gFn2c2we1Nb5rnKdgd5iQTrS1tYz0y8GPDC/BE8ygogZ/eX
         1wMIbOuT1HzsD+z7JO/QGaK2PNC/POSGhyvfD05YdPvhOCSCyZ7L0g0Y1oDMZSk7qOsv
         nTNC9MtmhzpxYuJsXrxy/B1y/0AyxYutDi2WvlNo+zbErnS4DFhLmHfKKfZXK8U19VCv
         nsWrOIyd5/3qQ1ykjV02esgQMFCni8zjdT7XY/3mPP+vH+KlVPcaKqbDb+3gUw73z2Yz
         X3+g==
X-Gm-Message-State: AOAM5312g8Hbg2qHTqTrEf2JxXYD1/k0vI5gQzdoZuPSKWMhJk5DxvLM
        rRVFLkKmqcR3hq69x5DeNio=
X-Google-Smtp-Source: ABdhPJxEuwWpP6uwmOX2Y1/LpA8rCmWMqjso4HcdRbyYswOjdhURfWXgD7MdS+rY/ropyBbaKmfl1A==
X-Received: by 2002:ac8:424b:: with SMTP id r11mr24146675qtm.188.1627475184575;
        Wed, 28 Jul 2021 05:26:24 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:b58:2ae8:d75f:660a])
        by smtp.gmail.com with ESMTPSA id z9sm2842972qtn.54.2021.07.28.05.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 05:26:24 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, Peter Geis <pgwipeout@gmail.com>
Subject: [RFC PATCH 9/9] arm64: dts: rockchip: add Quartz64-A usb2 support
Date:   Wed, 28 Jul 2021 08:26:06 -0400
Message-Id: <20210728122606.697619-10-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728122606.697619-1-pgwipeout@gmail.com>
References: <20210728122606.697619-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the nodes and regulators to enable usb2 support on the Quartz64
Model A.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index a3cdb6c2bec6..53ea5c13076b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -75,6 +75,22 @@ vcc5v0_usb: vcc5v0_usb {
 		vin-supply = <&vcc12v_dcin>;
 	};
 
+	/* all four ports are controlled by one gpio
+	 * the host ports are sourced from vcc5v0_usb
+	 * the otg port is sourced from vcc5v0_midu
+	 */
+	vcc5v0_usb20_host: vcc5v0_usb20_host {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb20_host";
+		enable-active-high;
+		gpio = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_usb20_host_en>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_usb>;
+	};
+
 	vcc3v3_sd: vcc3v3_sd {
 		compatible = "regulator-fixed";
 		enable-active-low;
@@ -367,6 +383,12 @@ pmic_int_l: pmic-int-l {
 		};
 	};
 
+	usb2 {
+		vcc5v0_usb20_host_en: vcc5v0-usb20-host-en {
+			rockchip,pins = <4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	vcc_sd {
 		vcc_sd_h: vcc-sd-h {
 			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -424,3 +446,33 @@ bluetooth {
 &uart2 {
 	status = "okay";
 };
+
+&u2phy1_host {
+	phy-supply = <&vcc5v0_usb20_host>;
+	status = "okay";
+};
+
+&u2phy1_otg {
+	phy-supply = <&vcc5v0_usb20_host>;
+	status = "okay";
+};
+
+&usb2phy1 {
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
-- 
2.25.1

