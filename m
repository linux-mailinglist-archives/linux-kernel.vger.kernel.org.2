Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEFD3FFD1B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 11:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348827AbhICJ3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 05:29:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:32812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348789AbhICJ3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:29:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F27066108E;
        Fri,  3 Sep 2021 09:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630661319;
        bh=252A7ya4rz1J/VWtyjLHuECws9kqq20mUJlh+v8C2Bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jSypdeAeVn1y4bPfbPk5xLNDrncSUI86xAibRZB5ZdUGOIMVFGVUDPDYuw0WD0Zf4
         zOLwIhwT6XRW3rNu0PkKHoR2YTw12J8GkoQEfKw3idnurmDjRX24TNVQ9JsUiiCz9o
         AP2xrRCZLMzm1a+BbxYop5Klif0JKAhcP2YB4VP2Ryz4WiL+GDskWnbDau1eNrQJfw
         lXu/tiFVvMDKlCo0Qpdfktc44OpS87KjCoyMVpOYFd6wwrSQV+MmxIJW9WU2WKUIYX
         bAbusBW7C/iF+398/+EjPeptlh3i6ywn4tTPJN+CT8ACGTx7LCGjWXI5ci5rHd+h/B
         Jhrm+3q1+rRTA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mM5Uz-000zwa-0x; Fri, 03 Sep 2021 11:28:37 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>, John Stultz <john.stultz@linaro.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] arm64: dts: hisilicon: Add usb mux hub for hikey970
Date:   Fri,  3 Sep 2021 11:28:34 +0200
Message-Id: <3c90ceef6cacb49620af6325de2b93a46a460e73.1630659949.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1630659949.git.mchehab+huawei@kernel.org>
References: <cover.1630659949.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt bindings for Kirin 970 USB HUB. Such board comes with an
integrated USB HUB provided via a TI TUSB8041 4-port USB 3.0 hub.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
index 60594db07041..95ca49f1e455 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
@@ -53,6 +53,29 @@ wlan_en: wlan-en-1-8v {
 		startup-delay-us = <70000>;
 		enable-active-high;
 	};
+
+	usb-hub {
+		compatible = "hisilicon,usbhub";
+		typec-vbus-gpios = <&gpio26 1 0>;
+		otg-switch-gpios = <&gpio4 2 0>;
+		hub-reset-en-gpios = <&gpio0 3 0>;
+		hub-vdd-supply = <&ldo17>;
+		usb-role-switch;
+
+		port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hikey_usb_ep0: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&dwc3_role_switch>;
+			};
+			hikey_usb_ep1: endpoint@1 {
+				reg = <1>;
+				remote-endpoint = <&rt1711h_ep>;
+			};
+		};
+	};
 };
 
 /*
-- 
2.31.1

