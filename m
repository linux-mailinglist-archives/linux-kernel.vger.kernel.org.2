Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD2F3EAC09
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 22:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238066AbhHLUmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 16:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238024AbhHLUmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:42:36 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C9FC0612A9;
        Thu, 12 Aug 2021 13:42:05 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id p22so7068116qki.10;
        Thu, 12 Aug 2021 13:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0vSamTyccptzOdkOr+v7GJn23T5SHRt0Wd7iQnG52jY=;
        b=WsddWCX2bH0za7uq6RXsMB/yT5Y5kXw5Dfi4StrzwM6j9+0IbgfdtWevLRetgVsmcq
         FY9rZ8rN7XopwA3C2iMrRvd2jmPgW4oMLutiEKRAntdFlcfMA/c1lxG04WyoA7LKTg7l
         JydE/tfQVnOAaC6f5uAKubOjH/kQYZUOHPgmanqwU0A/VBdRoloHkxJhutB6Npl+6/79
         zkQVpKT/QllZZzFCvA2S+DG2b/klg3GgsSxrvHQf6pd6lrqIGEQeer1L0sikZv4Fba/l
         enEfwf/qF4NpYUxz2D0hDf3N7elMXpKuKG3D1Jw24k7VBZsX24xzKjbg49QUNj4IQBEH
         jzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0vSamTyccptzOdkOr+v7GJn23T5SHRt0Wd7iQnG52jY=;
        b=oT4+7B/dIvH4f7zSRnXw7c+yXRLkx0Qkrr1aE8qZ1W5jkNKvwwuH89SmOL1RSbALMB
         /2Hdl8o8Q+EwIdkYI+5S6CAHLmWaD2tkStCdA/dn2FAxETgFDeyYdlgqcgHik5Ewp/y3
         N+/gKZbaH49y+5UdusXBY+U9p/USM6qoKxK0KoSaixZfL2rlAl9fqSGy04VeSJ7nzcdF
         o1PPuh8uKC4p2ZSMeS6mm+qEwOxobG1V0p4kDpsspF2wjKV1BWaaw8S6g0SemGTqawXg
         bH7K0jEAP9qCncgYg+Qr351LcfXHnajDzThs9ui7eudEwuB62i4OtL4SaBgEzipVoJen
         HlzA==
X-Gm-Message-State: AOAM533Dupmd4rvvLumHdOp9Lu2XJOdEB/787wKfTXlm9RXQ3c7tQVnq
        G3wV/RUXOQ2jJk1zs4uYiRc=
X-Google-Smtp-Source: ABdhPJw/1/MKI/+YdMlNsbB9IH09a4UY8r9lfrOqTmOPC3J4ZFt6cYVEJKpp1D5Peg1nmERqRT4y+g==
X-Received: by 2002:a05:620a:cea:: with SMTP id c10mr6698474qkj.238.1628800925058;
        Thu, 12 Aug 2021 13:42:05 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:e89f:d077:9161:1bd7])
        by smtp.gmail.com with ESMTPSA id m16sm1940361qki.19.2021.08.12.13.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 13:42:04 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] arm64: dts: rockchip: add Quartz64-A usb2 support
Date:   Thu, 12 Aug 2021 16:41:16 -0400
Message-Id: <20210812204116.2303617-9-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812204116.2303617-1-pgwipeout@gmail.com>
References: <20210812204116.2303617-1-pgwipeout@gmail.com>
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

