Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD96333318A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 23:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhCIWdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 17:33:40 -0500
Received: from finn.gateworks.com ([108.161.129.64]:50430 "EHLO
        finn.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230075AbhCIWdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 17:33:37 -0500
X-Greylist: delayed 1846 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Mar 2021 17:33:37 EST
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1lJkQy-001Npo-Fs; Tue, 09 Mar 2021 22:02:32 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 3/4] dt-bindings: arm: imx: add imx8mm gw7901 support
Date:   Tue,  9 Mar 2021 14:00:13 -0800
Message-Id: <20210309220014.22205-3-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210309220014.22205-1-tharvey@gateworks.com>
References: <20210309220014.22205-1-tharvey@gateworks.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Gateworks GW7901 is an ARM based single board computer (SBC)
featuring:
 - i.MX8M Mini SoC
 - LPDDR4 DRAM
 - eMMC FLASH
 - SPI FRAM
 - Gateworks System Controller (GSC)
 - Atmel ATECC Crypto Authentication
 - USB 2.0
 - Microchip GbE Switch
 - Multiple multi-protocol RS232/RS485/RS422 Serial ports
 - onboard 802.11ac WiFi / BT
 - microSD socket
 - miniPCIe socket with PCIe, USB 2.0 and dual SIM sockets
 - Wide range DC power input
 - 802.3at PoE

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 297c87f45db8..9af86ce3142d 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -684,6 +684,7 @@ properties:
               - gw,imx8mm-gw71xx-0x       # i.MX8MM Gateworks Development Kit
               - gw,imx8mm-gw72xx-0x       # i.MX8MM Gateworks Development Kit
               - gw,imx8mm-gw73xx-0x       # i.MX8MM Gateworks Development Kit
+              - gw,imx8mm-gw7901          # i.MX8MM Gateworks Board
               - kontron,imx8mm-n801x-som  # i.MX8MM Kontron SL (N801X) SOM
               - variscite,var-som-mx8mm   # i.MX8MM Variscite VAR-SOM-MX8MM module
           - const: fsl,imx8mm
-- 
2.17.1

