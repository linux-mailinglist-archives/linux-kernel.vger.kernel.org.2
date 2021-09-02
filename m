Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727D13FECFE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 13:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343744AbhIBL34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 07:29:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245695AbhIBL3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 07:29:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 382E3610CD;
        Thu,  2 Sep 2021 11:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630582125;
        bh=t5jqLXWSCvkoEWBIixIhEk25N1p5VRoDG3iLJpBa4KQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VbMBY59GdRtIBJzGqkWGa0MULEUj8bu5kgXOZogUNioWucm9C5mVX0c7wAAVERUzt
         Q6P6nGOy3oHhAnONxBpHVXt0uq4ZANPY7oFIK35grJiTelkBDNVXMKSl0DnIwfnGZY
         pKdtFtKN6cZhQCztV7GPgAzLkYZYNCQFVBUY5z1X62+s7f5A3Zl9fU0a84Bd1N9R9H
         mhyXjJpkZJ6pR83m/kEPOHdpbXqpWeXUsYIrJAqbYNUkdB5wMLD18IDSos+uSbeWwt
         N3vG9SCpZoSMj2oKTT84HKPccwtYCx6e8p3U+Y2ayHVP2lmMQxDXB19M0Khlk7JAAO
         LcHWG9BJ73O0w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mLktf-0004ZW-A1; Thu, 02 Sep 2021 13:28:43 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "John Stultz" <john.stultz@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] arm64: dts: hisilicon: Add usb mux hub for hikey970
Date:   Thu,  2 Sep 2021 13:28:36 +0200
Message-Id: <1df0b8f59fb75d6c1f3b5248f74f66b93a072a02.1630581434.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1630581434.git.mchehab+huawei@kernel.org>
References: <cover.1630581434.git.mchehab+huawei@kernel.org>
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
index 60594db07041..0cec08083c4f 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
@@ -53,6 +53,29 @@ wlan_en: wlan-en-1-8v {
 		startup-delay-us = <70000>;
 		enable-active-high;
 	};
+
+	usb-hub {
+		compatible = "hisilicon,hikey970-usbhub";
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

