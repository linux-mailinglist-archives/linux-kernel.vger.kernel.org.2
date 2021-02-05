Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBCA310D6B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 16:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhBEOMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 09:12:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:59202 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231673AbhBEN4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:56:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F2EC2AEE7;
        Fri,  5 Feb 2021 13:53:04 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     phil@raspberrypi.com, wahrenst@gmx.net,
        linux-kernel@vger.kernel.org
Subject: [RFC/PATCH 09/11] ARM: dts: bcm2711: Enable V3D
Date:   Fri,  5 Feb 2021 14:52:45 +0100
Message-Id: <20210205135249.2924-10-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205135249.2924-1-nsaenzjulienne@suse.de>
References: <20210205135249.2924-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables V3D for bcm2711 (used in the Raspberry Pi 4).

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm/boot/dts/bcm2711.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index 537498a93a3a..dd8376f474db 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -548,6 +548,18 @@ genet_mdio: mdio@e14 {
 				#size-cells = <0x1>;
 			};
 		};
+
+		v3d: gpu@7ec04000 {
+			compatible = "brcm,bcm2711-v3d";
+			reg = <0x0 0x7ec00000 0x4000>,
+			      <0x0 0x7ec04000 0x4000>;
+			reg-names = "hub", "core0";
+
+			power-domains = <&pm BCM2835_POWER_DOMAIN_GRAFX_V3D>;
+			resets = <&pm BCM2835_RESET_V3D>;
+			clocks = <&firmware_clocks 5>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 };
 
-- 
2.30.0

