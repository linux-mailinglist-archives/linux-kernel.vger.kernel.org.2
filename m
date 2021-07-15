Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C4D3CA075
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238813AbhGOOUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:20:55 -0400
Received: from finn.gateworks.com ([108.161.129.64]:55686 "EHLO
        finn.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238671AbhGOOUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:20:49 -0400
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1m42BU-004m78-I4; Thu, 15 Jul 2021 14:17:52 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 1/2] dt-bindings: arm: imx: add imx8mm/imx8mn GW7902 support
Date:   Thu, 15 Jul 2021 07:17:49 -0700
Message-Id: <20210715141750.11612-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GW7902 is based on the i.MX 8M Mini / Nano SoC featuring:
 - LPDDR4 DRAM
 - eMMC FLASH
 - Gateworks System Controller
 - LTE CAT M1 modem
 - USB 2.0 HUB
 - M.2 Socket with USB2.0, PCIe, and dual-SIM
 - IMX8M FEC
 - PCIe based GbE
 - RS232/RS485/RS422 serial transceiver
 - GPS
 - CAN bus
 - WiFi / Bluetooth
 - MIPI header (DSI/CSI/GPIO/PWM/I2S)
 - PMIC

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 2793d161b24e..8a5a007c0a06 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -700,6 +700,7 @@ properties:
               - gw,imx8mm-gw72xx-0x       # i.MX8MM Gateworks Development Kit
               - gw,imx8mm-gw73xx-0x       # i.MX8MM Gateworks Development Kit
               - gw,imx8mm-gw7901          # i.MX8MM Gateworks Board
+              - gw,imx8mm-gw7902          # i.MX8MM Gateworks Board
               - kontron,imx8mm-n801x-som  # i.MX8MM Kontron SL (N801X) SOM
               - variscite,var-som-mx8mm   # i.MX8MM Variscite VAR-SOM-MX8MM module
           - const: fsl,imx8mm
@@ -730,6 +731,7 @@ properties:
               - beacon,imx8mn-beacon-kit  # i.MX8MN Beacon Development Kit
               - fsl,imx8mn-ddr4-evk       # i.MX8MN DDR4 EVK Board
               - fsl,imx8mn-evk            # i.MX8MN LPDDR4 EVK Board
+              - gw,imx8mn-gw7902          # i.MX8MN Gateworks Board
           - const: fsl,imx8mn
 
       - description: Variscite VAR-SOM-MX8MN based boards
-- 
2.17.1

