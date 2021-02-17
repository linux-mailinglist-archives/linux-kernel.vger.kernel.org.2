Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FC431D8E2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 12:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhBQLyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 06:54:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:34036 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232304AbhBQLtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:49:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 93793B810;
        Wed, 17 Feb 2021 11:48:33 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     f.fainelli@gmail.com, linux-rpi-kernel@lists.infradead.org,
        phil@raspberrypi.com, wahrenst@gmx.net,
        bcm-kernel-feedback-list@broadcom.com, mripard@kernel.org,
        eric@anholt.net, robh@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 13/15] ARM: dts: bcm2711: Enable V3D
Date:   Wed, 17 Feb 2021 12:48:08 +0100
Message-Id: <20210217114811.22069-14-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210217114811.22069-1-nsaenzjulienne@suse.de>
References: <20210217114811.22069-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables V3D for bcm2711 (used in the Raspberry Pi 4).

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

---

Changes since v1:
 - Correct node's name address

 arch/arm/boot/dts/bcm2711.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index e864974b10c9..d2bbfc7c4daa 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -549,6 +549,18 @@ genet_mdio: mdio@e14 {
 				#size-cells = <0x1>;
 			};
 		};
+
+		v3d: gpu@7ec00000 {
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

