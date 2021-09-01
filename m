Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6673FD97A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 14:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244084AbhIAMYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 08:24:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244023AbhIAMYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 08:24:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C49E60FE6;
        Wed,  1 Sep 2021 12:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630499024;
        bh=8Qh+KoZCV3O3HB/rjY3TV5ESE34wEFUhafhg5oTG4q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H3ocyg64ON75ITP404UTfJMmpJnIBt8pPqRbu263VWjaGF4RvzXrcgd4bE8EhyR6e
         g1Y2J0UiSh71QV1JySvIxFNCplZMQgdOzpb/nsIQoLv1cVr2YXjvj22rmryL8i6E2Z
         9k4LIzI4pNCHlNKHjPaBALHFTmrBH7Bpz/x3v/ULceFBURoHdLVE3zNoQPrF7faX5p
         7kRuQp0MKlIzOjl2Ijq69Cx5M0ytE7w6DJcVBDD17CvIQuxIqTcTYJJZeQh9Tbeh53
         DqPhPHQsQ8MKm31gwXEUnjx28TrZluzi5jRhp6gzqVKU+dOwJgM527Mgg+9YCcjhY9
         Gqk4kl4Ls9kHQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mLPHJ-00H8Z9-68; Wed, 01 Sep 2021 14:23:41 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>, John Stultz <john.stultz@linaro.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v2 3/3] arm64: dts: hisilicon: Add usb mux hub for hikey960
Date:   Wed,  1 Sep 2021 14:23:39 +0200
Message-Id: <b1ea71426ecf21bbfd598a6bf7951d884fcc5e1a.1630498020.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1630498020.git.mchehab+huawei@kernel.org>
References: <cover.1630498020.git.mchehab+huawei@kernel.org>
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

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../boot/dts/hisilicon/hi3660-hikey960.dts    | 35 +++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index f68580dc87d8..cc38d4f961ee 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -191,12 +191,43 @@ wlan_en: wlan-en-1-8v {
 		enable-active-high;
 	};
 
+	usb_hub: hub-vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "hub-vdd";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio5 6 GPIO_ACTIVE_HIGH>;
+	};
+
 	firmware {
 		optee {
 			compatible = "linaro,optee-tz";
 			method = "smc";
 		};
 	};
+
+	hisi_hikey_usb: hisi_hikey_usb {
+		compatible = "hisilicon,hikey960-usbhub";
+		typec-vbus-gpios = <&gpio25 2 GPIO_ACTIVE_HIGH>;
+		otg-switch-gpios = <&gpio25 6 GPIO_ACTIVE_HIGH>;
+		hub-vdd33-en-gpios = <&gpio5 6 GPIO_ACTIVE_HIGH>;
+		hub-vdd-supply = <&usb_hub>;
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

