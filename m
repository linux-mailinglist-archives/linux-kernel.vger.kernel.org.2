Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6A443B520
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbhJZPKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:10:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46703 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231776AbhJZPK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635260883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RhWBGhTPUXjWCenxI84mF0qWi0IwhDx4oi/aU2tmg8M=;
        b=I1ir67atA85Bb0tlhILNT4F7JhDGBSnPKom2R6Xi1+haxaXal/OooHvdt0aE9Z/6wS9Ftm
        JtyHGKt/SFvAYouEzAZRkMwz4NAQ4+cF6ciL+k/mS7/DqBvuCoGAn+1bNRyHA4trih3pY6
        NIlc2tmxBbCWU2lQkMG3Suah/XZVvZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-dCr9twRMPm2CU3kpYXEgmw-1; Tue, 26 Oct 2021 11:07:58 -0400
X-MC-Unique: dCr9twRMPm2CU3kpYXEgmw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B1E210B3940;
        Tue, 26 Oct 2021 15:07:56 +0000 (UTC)
Received: from dreyauc.ausil.us (unknown [10.22.9.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F09B19D9D;
        Tue, 26 Oct 2021 15:07:54 +0000 (UTC)
From:   Dennis Gilmore <dgilmore@redhat.com>
To:     linux-rockchip@lists.infradead.org
Cc:     dgilmore@redhat.com, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Florian Klink <flokli@flokli.de>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: dts: rockchip: helios64: define usb hub and 2.5GbE nic
Date:   Tue, 26 Oct 2021 10:07:47 -0500
Message-Id: <20211026150751.70115-1-dgilmore@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the 4 ports on the internal hub and define and turn on the 2.5GbE
nic.

Signed-off-by: Dennis Gilmore <dgilmore@redhat.com>
---
 .../dts/rockchip/rk3399-kobol-helios64.dts    | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
index 26d45cf7ce00..1ffddf860375 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
@@ -125,6 +125,18 @@ pcie_power: pcie-power {
 		vin-supply = <&vcc5v0_perdev>;
 	};
 
+	usblan_power: usblan-power {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio1 RK_PC7 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_lan_en>;
+		regulator-name = "usblan_power";
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc5v0_usb>;
+	};
+
 	vcc1v8_sys_s0: vcc1v8-sys-s0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc1v8_sys_s0";
@@ -465,6 +477,11 @@ hdd_b_power_en: hdd-b-power-en {
 		vcc5v0_usb_en: vcc5v0-usb-en {
 			rockchip,pins = <1 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
+
+		usb_lan_en: usb-lan-en {
+			rockchip,pins = <1 RK_PC7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
 	};
 
 	vcc3v0-sd {
@@ -563,5 +580,43 @@ &usbdrd3_1 {
 	usb@fe900000 {
 		dr_mode = "host";
 		status = "okay";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		hub@1 {
+			compatible = "usb2109,0815";
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@1 {
+				reg = <1>;
+				#trigger-source-cells = <0>;
+			};
+
+			port@2 {
+				reg = <2>;
+				#trigger-source-cells = <0>;
+			};
+
+			port@3 {
+				reg = <3>;
+				#trigger-source-cells = <0>;
+			};
+
+			device@4 {
+				compatible = "usbbda,8156";
+				reg = <4>;
+
+				#address-cells = <2>;
+				#size-cells = <0>;
+
+				interface@0 {	/* interface 0 of configuration 1 */
+					compatible = "usbbda,8156.config1.0";
+					reg = <0 1>;
+				};
+			};
+		};
 	};
 };
-- 
2.32.0

