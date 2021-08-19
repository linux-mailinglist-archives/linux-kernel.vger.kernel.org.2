Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510CF3F22C6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 00:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbhHSWKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 18:10:55 -0400
Received: from mout.perfora.net ([74.208.4.197]:34493 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236312AbhHSWKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 18:10:44 -0400
Received: from toolbox.cardiotech.int ([81.221.236.183]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MDzNh-1mHgdX3biR-00HNXk;
 Fri, 20 Aug 2021 00:09:49 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] dt-bindings: arm: fsl: add toradex,colibri-imx6ull-emmc
Date:   Fri, 20 Aug 2021 00:09:10 +0200
Message-Id: <20210819220910.586819-10-marcel@ziswiler.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210819220910.586819-1-marcel@ziswiler.com>
References: <20210819220910.586819-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yNrBy03hi6umwau9RUYvuC2jNSBczcyovZhCyPFJKToBj+3O4p3
 Oo9faFVD/NjF+IAxsbWbFDvf0h6b6dszgnPTsyvFIHOhsZXEiudcb7BWD+7r9L9QwA2tCFI
 E2Rv08sVtRdNvoTSF5LNqzwGM7VO5zuW14qQZT6cS7w/SPVXY1CDk5XA24gSXO80v/N9Ykg
 w/YerkevBSHbZ9HcWNx0Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fv3X1TEmHoc=:r5nYYQbYrCC4DjgZxelhSm
 GsJ630OLwovKDinGBDnLyS27uNusnkAbQWIouu4RnNF4+UX+a2JHlbuZt5Jy7FU+ssqAA9y6D
 hAQ7CYM5oWBRV6N5wp4du1dGkH1EufS1uBzDDtwcZNQX/Mr1EtJ+uAO30/RNzuEsIeak6FHnh
 sqvM0mWkBpFSPIOushO8hVQIN7PtwIXA39Kx4C28ie2QfheTHVbeZb4CJAvwS0/0cx/v8tC6o
 BzYxszJ9hkYOMz1ZiAVZ3hxZmUvgBXa6RIvEK++qm2DjRoVmPSb/ym4aUOse3C5DsGBZEnspO
 hx4qmpmaX64/bpbFU709lkPhAFTnkI1FqTO8Vp8fvlGgOZzE6uFqeyjDUrQvcKToWWRAH711S
 GLq9eQYo8ozXfAErOkMreHNs/BhXxr6l3zG8mrXpEFTrO1s8R5QayR7mps1hD++m6RuLwAP/Q
 VKhamcaZ8sfU3yLiFMqXkjrhyYkW12fW9LcPukCehzETrku85cCGtDUzf6sjAY1mlYDHQkE2n
 LlIgmsBeSlr5/dtzGU8d0OcATbws4DWg8BcHaWis6UQqiYNwxlQMGw31jv5yrBeKcBil+h/4M
 q96Vfs1kLjrXMaC8NnroIKoIIreiHqwC6WOjWCbt+3SPhfQyEHRyOUvTGw5f8e/Uu7lfbl595
 de2zY+t7JqXh9zir7cTr8+ezagDv1kcvkL9scnFXUkPQOR0rBqGYEJ7LGwsJyDtr18UQCzwRY
 wLq9Zpkg/xaaxeIb6R9gpMfCc37yxGlGjbZINUxshcv7R3xaSXtZxDCD98tbFW2RRF/2u1N97
 7pVTS6dfG5jxXg3P7/CMkFjSh2DFNSsyEBIoFhHnPIgSTohLDEwaJdTa1RjpUPRGZIn6uN2R2
 oXdeg5i88iPERA3yY7G5kAbaUsY85fP6naoOfZuQOaMn8dbEp+cI5t3bZKsISJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add toradex,colibri-imx6ull-emmc for our new Colibri iMX6ULL 1GB (eMMC)
Module and the carrier boards (so far only Colibri Evaluation Board) it
may be mated in.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- New patch documenting dt-bindings.

 Documentation/devicetree/bindings/arm/fsl.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index a95314bd271c7..32e2d5537210b 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -581,6 +581,7 @@ properties:
               - kontron,imx6ull-n6411-som # Kontron N6411 SOM
               - myir,imx6ull-mys-6ulx-eval # MYiR Tech iMX6ULL Evaluation Board
               - toradex,colibri-imx6ull      # Colibri iMX6ULL Modules
+              - toradex,colibri-imx6ull-emmc # Colibri iMX6ULL 1GB (eMMC) Module
               - toradex,colibri-imx6ull-wifi # Colibri iMX6ULL Wi-Fi / BT Modules
           - const: fsl,imx6ull
 
@@ -606,6 +607,13 @@ properties:
           - const: toradex,colibri-imx6ull        # Colibri iMX6ULL Module
           - const: fsl,imx6dl
 
+      - description: i.MX6ULL Boards with Toradex Colibri iMX6ULL 1GB (eMMC) Module
+        items:
+          - enum:
+              - toradex,colibri-imx6ull-emmc-eval # Colibri iMX6ULL 1GB (eMMC) Module on Colibri Evaluation Board
+          - const: toradex,colibri-imx6ull-emmc   # Colibri iMX6ULL 1GB (eMMC) Module
+          - const: fsl,imx6dl
+
       - description: i.MX6ULL Boards with Toradex Colibri iMX6ULL Wi-Fi / BT Modules
         items:
           - enum:
-- 
2.26.2

