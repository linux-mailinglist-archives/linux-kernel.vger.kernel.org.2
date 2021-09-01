Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E103FD979
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 14:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244059AbhIAMYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 08:24:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243964AbhIAMYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 08:24:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19CD760F92;
        Wed,  1 Sep 2021 12:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630499024;
        bh=G5WjVBIBLdchJZDoVf3dlprgnr0+bNljO8LoBMSwmh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mz0m6g0cnkQuxYd2MginnzszQws4CmQoIdi4oLJy5myWzFxeNYN8s8qMaFyjR+gPN
         /z8LK0GpCAgjH6U8OswfaKtt8rXx7pn6nfjFc8PlgIKjsppYkIPFp69YGr+EQ6VaS4
         Fk15D3ahYmxSW8HNm04sFORBgoVvCzhDWdk+B+HMB9RZr1ai1qV8ShFiSBIIYZ1q5x
         peBt8RdiTjje94kdxPp8Rtj86n162LH5yt+fLhk34qFM9ZGSzyg1iANqxDKrXgR3R4
         lCtf7RNTYrZ4zFWc3J0YzYpVtLOK4LacUAEg/esyKHPUGVx0fo9I43zsNhQ5b2ZuJ7
         S9YWz4Xi1mOQQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mLPHJ-00H8Z4-4R; Wed, 01 Sep 2021 14:23:41 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>, John Stultz <john.stultz@linaro.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] arm64: dts: hisilicon: Add usb mux hub for hikey970
Date:   Wed,  1 Sep 2021 14:23:38 +0200
Message-Id: <0b2bafee6bcbb90961f797e1583cb756bb163a4a.1630498020.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1630498020.git.mchehab+huawei@kernel.org>
References: <cover.1630498020.git.mchehab+huawei@kernel.org>
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
 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
index 60594db07041..8502814d33e7 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
@@ -53,6 +53,30 @@ wlan_en: wlan-en-1-8v {
 		startup-delay-us = <70000>;
 		enable-active-high;
 	};
+
+	hikey_usbhub: hikey_usbhub {
+		compatible = "hisilicon,kirin970_hikey_usbhub";
+
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

