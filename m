Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA1A34EC05
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhC3PT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:19:58 -0400
Received: from finn.gateworks.com ([108.161.129.64]:55828 "EHLO
        finn.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232101AbhC3PTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:19:51 -0400
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1lRG9i-001xGb-Hr; Tue, 30 Mar 2021 15:19:46 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v3 1/2] dt-bindings: arm: imx: add imx8mm gw7901 support
Date:   Tue, 30 Mar 2021 08:19:43 -0700
Message-Id: <20210330151944.7368-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
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

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
v3:
 - add reviewed-by

v2:
 - add Rob's Acked-by
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

