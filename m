Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E3D3FFD1C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 11:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348820AbhICJ3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 05:29:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:32786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232257AbhICJ3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:29:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBF0D61058;
        Fri,  3 Sep 2021 09:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630661319;
        bh=Z9j2ijb0LnORbY80zVvicwJJPPm6wGbu2SDy3Krhc8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UL8B7fWm42z5DBID9ZHhIPwzk0VCpw8rkfk111k1QWxAL+PPi9/s/+2CbN8Nx5uIy
         8zHF/kkihsGtKAktZ/gYtLe8pXMIi7OuBcLL+kXhWaeGkUZbBkmmLvOuJlLejV++XB
         RAahHjg4hGxQgQvFLQS8Pmo0uFekjiFRYGC3lXDUdm6NsWRuatSAqqKHt2/GCELgry
         y4qqKv7t8i8n450TZJyZeH0kyu9ApqOAjhb6Mg7OaELakAjD+9GIRXinWyilOu7X7A
         6qt1ked5YHi9Kd4EkPIcZzHGwV8hDULFJjzGmeXoF/MH0bAic7tZAEmFcA7d/0UjTl
         R/u7yYbbxs/3A==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mM5Uz-000zwe-27; Fri, 03 Sep 2021 11:28:37 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>, John Stultz <john.stultz@linaro.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v4 4/4] arm64: dts: hisilicon: Add usb mux hub for hikey960
Date:   Fri,  3 Sep 2021 11:28:35 +0200
Message-Id: <6b81624b27ae9167fcbdd8f31dac0eae3cfc098c.1630659949.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1630659949.git.mchehab+huawei@kernel.org>
References: <cover.1630659949.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Stultz <john.stultz@linaro.org>

Add dt bindings for Kirin 960 USB HUB. Such board comes with an
integrated USB HUB provided via a Microchip USB5734 4-port high-speed
hub controller.

[mchehab: modified it to adapt to the merged DT schema]
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../boot/dts/hisilicon/hi3660-hikey960.dts    | 35 +++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index f68580dc87d8..135501e57f86 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -197,6 +197,37 @@ optee {
 			method = "smc";
 		};
 	};
+
+	usb_hub_vdd: usb_hub_vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "hub-vdd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio5 6 0>;
+		enable-active-high;
+	};
+
+	usb-hub {
+		compatible = "hisilicon,usbhub";
+		typec-vbus-gpios = <&gpio25 2 GPIO_ACTIVE_HIGH>;
+		otg-switch-gpios = <&gpio25 6 GPIO_ACTIVE_HIGH>;
+		hub-vdd-supply = <&usb_hub_vdd>;
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
@@ -564,7 +595,7 @@ port {
 
 			rt1711h_ep: endpoint@0 {
 				reg = <0>;
-				remote-endpoint = <&dwc3_role_switch>;
+				remote-endpoint = <&hikey_usb_ep1>;
 			};
 		};
 	};
@@ -686,7 +717,7 @@ port {
 		#size-cells = <0>;
 		dwc3_role_switch: endpoint@0 {
 			reg = <0>;
-			remote-endpoint = <&rt1711h_ep>;
+			remote-endpoint = <&hikey_usb_ep0>;
 		};
 
 		dwc3_ss: endpoint@1 {
-- 
2.31.1

