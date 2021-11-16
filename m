Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F204531A5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 13:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbhKPMEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 07:04:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:46124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235749AbhKPMCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 07:02:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69FBD61B31;
        Tue, 16 Nov 2021 11:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637063977;
        bh=EiP6cuQpwBBg39/9D1fBHWNz1se4q5TjJex4rIsVzd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oMdUQaRIpni0YwpNNeiEIXZrvHqvHYgtVFaZMeJWSd/gALq34uR8iv2lHN/+4S1Y2
         1KNjc6pg0EMDi/N+TjdDgOMvY59lczPkCHV0AXbcYObK5GNbScp5ZgEcEyU7XYN782
         NRRXznaYZ482sMLtgwFsHxwZxuN2iSqcvCGtUCIuBXSlz7wE+FggQz7x4xbUZIGOlF
         dEIqvUU7HyowmSdBbt/6lCShwkXSdIqjTeqk/OXcGIheW8UAvFlsp/Qiclo+ueQu8D
         GglszQBYOIlYmxVxE4AG5XZIDNzBTNeldxd0nhGYg1blZcxxW9hfA6afOfnxD4425K
         89aPNvubzDtTQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mmx7e-00A97R-GR; Tue, 16 Nov 2021 11:59:34 +0000
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] arm64: dts: HiSilicon: Add usb mux hub for HiKey 970
Date:   Tue, 16 Nov 2021 11:59:32 +0000
Message-Id: <3ae388fed672b3d7ee22dd123ec2cf0727f0a79b.1637063775.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637063775.git.mchehab+huawei@kernel.org>
References: <cover.1637063775.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt bindings for HiKey 970 USB HUB. Such board comes with an
integrated USB HUB provided via a TI TUSB8041 4-port USB 3.0 hub.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 0/5] at: https://lore.kernel.org/all/cover.1637063775.git.mchehab+huawei@kernel.org/

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
2.33.1

