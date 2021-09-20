Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524F8411789
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbhITOwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:52:17 -0400
Received: from mout.perfora.net ([74.208.4.196]:53559 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240866AbhITOwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:52:00 -0400
Received: from toolbox.cardiotech.int ([81.221.236.183]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MA7vi-1mZVLr1QNu-00Bb3c;
 Mon, 20 Sep 2021 16:50:13 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Rob Herring <robh@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/9] dt-bindings: arm: fsl: clean-up all toradex boards/modules
Date:   Mon, 20 Sep 2021 16:49:36 +0200
Message-Id: <20210920144938.314588-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210920144938.314588-1-marcel@ziswiler.com>
References: <20210920144938.314588-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bn2ev84/0MN3nEn+XC6r3veck7BF0Q5QJLERDM3MMksTz4iFXga
 pX3qiZOv1Pc66+G7n6Y+JrOneHybZ4qn1c+698bGxEOlp+soK1gV9Iz9dvXkaJLfonI6t3s
 DL3jvMdcwbmm6GDECUChOBzbHh6DOGIGXZ+ER1mSmdD1VOCDZ9J8k8Po7ddT2Yq3obVd8pM
 HfiaiqmxiTh3OhhUN9YhQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hqmoTI9C8Fk=:N5UzZ8C2RVqcKPe0Ps2yy6
 48+Yem9LPwpuxY3JwDITnpeW30MVvhcT4Q8I8JF8csEZeuU9kA0WQkhdQCiDUHIaJPWvsvkmT
 wEoSV1AHh9lOS37j/X72/3ZqLUwhKKgAEyJMQqhyCimKidkFyfmXsI8SiYOfQ6UNQq1V1/aM4
 vQ/3G4E4Gug2ydNixPpd6N11my+rT8Lu3ME32nEIE/2KhQbvxbQXF7YPyoVq+7DolN8GZdhLA
 1C/5FzElg7iRx8r7vqPWPGDHj4H8Nt2pryDnjiSinRcXUSa/a6Rwxkcx87g86dPt96maZRRP6
 Tj+A1CNYlLrPSi6gcDyjS0U1x8bMJKnksaJ6po+gfOlf7OcqyQwoLkhwWITv/NWqD37eHrRMY
 TRSm579rY8cNqaELVUfjb0nKaLlQYr2Iqy5qZvW4jaCPLI1/0Gq20yd5e8hL3YQnHy/cjTEQa
 YWgQZwqBG+Zorx+QL2AhOhchM/LoK0XBYVB+AJfCwdZyv7lxBSaCdGPpCZJ8udpeW5JUn62dO
 rr5bjaXNzUPOhKozvC5D4DZPJUYzSBqaVEDccMXSi+zIEN59cj9tgWrpCtSS+UrURRvoxiZc0
 jdza9wl+EuQYLDkZ5CweIpQ7U5QBk8SO3fH8qdxj6LOoUZkGprqxqeX3BQ0RBMQDCLQbus8m3
 FwnN7HdOZNr3RsyVao3F/opTdsMI+huUuqGtLS0AmXevr2pfH01owUpv44euJFpA8nKUtDmDx
 Kn8WS3S5i3drGNhl8UMT7jJftUGAVvruo3a17w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Simplify and unify the distinction between modules and carrier boards.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Fabio Estevam <festevam@gmail.com>

---

Changes in v4:
- Fix dt_binding_check line too long warnings as pointed out by Rob.

Changes in v3:
- Add Fabio's reviewed-by. Thanks!
- Add Rob's ack. Thanks!

Changes in v2:
- New patch cleaning-up dt-bindings documentation.

 .../devicetree/bindings/arm/fsl.yaml          | 79 ++++++++++---------
 1 file changed, 41 insertions(+), 38 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 60f4862ba15e7..f1a74f4bce245 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -235,7 +235,7 @@ properties:
               - technexion,imx6q-pico-pi      # TechNexion i.MX6Q Pico-Pi
               - technologic,imx6q-ts4900
               - technologic,imx6q-ts7970
-              - toradex,apalis_imx6q      # Apalis iMX6 Module
+              - toradex,apalis_imx6q      # Apalis iMX6 Modules
               - udoo,imx6q-udoo           # Udoo i.MX6 Quad Board
               - uniwest,imx6q-evi         # Uniwest Evi
               - variscite,dt6customboard
@@ -314,18 +314,12 @@ properties:
           - const: phytec,imx6q-pfla02    # PHYTEC phyFLEX-i.MX6 Quad
           - const: fsl,imx6q
 
-      - description: i.MX6Q Boards with Toradex Apalis iMX6Q/D Module
+      - description: i.MX6Q Boards with Toradex Apalis iMX6Q/D Modules
         items:
           - enum:
-              - toradex,apalis_imx6q-ixora  # Apalis iMX6Q/D Module on Ixora Carrier Board
-              - toradex,apalis_imx6q-eval   # Apalis iMX6Q/D Module on Apalis Evaluation Board
-          - const: toradex,apalis_imx6q
-          - const: fsl,imx6q
-
-      - description: i.MX6Q Toradex Apalis iMX6Q/D Module on Ixora Carrier Board V1.1
-        items:
-          - const: toradex,apalis_imx6q-ixora-v1.1
-          - const: toradex,apalis_imx6q-ixora
+              - toradex,apalis_imx6q-ixora      # Apalis iMX6Q/D Module on Ixora Carrier Board
+              - toradex,apalis_imx6q-ixora-v1.1 # Apalis iMX6Q/D Module on Ixora V1.1 Carrier Board
+              - toradex,apalis_imx6q-eval       # Apalis iMX6Q/D Module on Apalis Evaluation Board
           - const: toradex,apalis_imx6q
           - const: fsl,imx6q
 
@@ -393,6 +387,8 @@ properties:
               - technexion,imx6dl-pico-pi      # TechNexion i.MX6DL Pico-Pi
               - technologic,imx6dl-ts4900
               - technologic,imx6dl-ts7970
+              - toradex,colibri_imx6dl      # Colibri iMX6 Modules
+              - toradex,colibri_imx6dl-v1_1 # Colibri iMX6 V1.1 Modules
               - udoo,imx6dl-udoo          # Udoo i.MX6 Dual-lite Board
               - vdl,lanmcu                # Van der Laan LANMCU board
               - wand,imx6dl-wandboard     # Wandboard i.MX6 Dual Lite Board
@@ -466,20 +462,18 @@ properties:
           - const: phytec,imx6dl-pfla02   # PHYTEC phyFLEX-i.MX6 Quad
           - const: fsl,imx6dl
 
-      - description: i.MX6DL Toradex Colibri iMX6 Module on Colibri
-                     Evaluation Board V3
+      - description: i.MX6DL Boards with Toradex Colibri iMX6DL/S Modules
         items:
-          - const: toradex,colibri_imx6dl-eval-v3
-          - const: toradex,colibri_imx6dl          # Colibri iMX6 Module
+          - enum:
+              - toradex,colibri_imx6dl-eval-v3      # Colibri iMX6DL/S Module on Colibri Evaluation Board V3
+          - const: toradex,colibri_imx6dl           # Colibri iMX6DL/S Module
           - const: fsl,imx6dl
 
-      - description: i.MX6DL Toradex Colibri iMX6 Module V1.1 on Colibri
-                     Evaluation Board V3
+      - description: i.MX6DL Boards with Toradex Colibri iMX6DL/S V1.1 Modules
         items:
-          - const: toradex,colibri_imx6dl-v1_1-eval-v3
-          - const: toradex,colibri_imx6dl-v1_1     # Colibri iMX6 Module V1.1
-          - const: toradex,colibri_imx6dl-eval-v3
-          - const: toradex,colibri_imx6dl          # Colibri iMX6 Module
+          - enum:
+              - toradex,colibri_imx6dl-v1_1-eval-v3 # Colibri iMX6DL/S V1.1 M. on Colibri Evaluation Board V3
+          - const: toradex,colibri_imx6dl-v1_1      # Colibri iMX6DL/S V1.1 Module
           - const: fsl,imx6dl
 
       - description: i.MX6S DHCOM DRC02 Board
@@ -586,8 +580,8 @@ properties:
               - fsl,imx6ull-14x14-evk     # i.MX6 UltraLiteLite 14x14 EVK Board
               - kontron,imx6ull-n6411-som # Kontron N6411 SOM
               - myir,imx6ull-mys-6ulx-eval # MYiR Tech iMX6ULL Evaluation Board
-              - toradex,colibri-imx6ull-eval      # Colibri iMX6ULL Module on Colibri Eval Board
-              - toradex,colibri-imx6ull-wifi-eval # Colibri iMX6ULL Wi-Fi / BT Module on Colibri Eval Board
+              - toradex,colibri-imx6ull      # Colibri iMX6ULL Modules
+              - toradex,colibri-imx6ull-wifi # Colibri iMX6ULL Wi-Fi / BT Modules
           - const: fsl,imx6ull
 
       - description: i.MX6ULL Armadeus Systems OPOS6ULDev Board
@@ -605,6 +599,20 @@ properties:
           - const: phytec,imx6ull-pcl063  # PHYTEC phyCORE-i.MX 6ULL
           - const: fsl,imx6ull
 
+      - description: i.MX6ULL Boards with Toradex Colibri iMX6ULL Modules
+        items:
+          - enum:
+              - toradex,colibri-imx6ull-eval      # Colibri iMX6ULL Module on Colibri Evaluation Board
+          - const: toradex,colibri-imx6ull        # Colibri iMX6ULL Module
+          - const: fsl,imx6dl
+
+      - description: i.MX6ULL Boards with Toradex Colibri iMX6ULL Wi-Fi / BT Modules
+        items:
+          - enum:
+              - toradex,colibri-imx6ull-wifi-eval # Colibri iMX6ULL Wi-Fi / BT M. on Colibri Evaluation Board
+          - const: toradex,colibri-imx6ull-wifi   # Colibri iMX6ULL Wi-Fi / BT Module
+          - const: fsl,imx6dl
+
       - description: Kontron N6411 S Board
         items:
           - const: kontron,imx6ull-n6411-s
@@ -622,6 +630,7 @@ properties:
         items:
           - enum:
               - element14,imx7s-warp      # Element14 Warp i.MX7 Board
+              - toradex,colibri-imx7s     # Colibri iMX7S Module
           - const: fsl,imx7s
 
       - description: i.MX7S Boards with Toradex Colibri iMX7S Module
@@ -653,15 +662,8 @@ properties:
               - technexion,imx7d-pico-hobbit  # TechNexion i.MX7D Pico-Hobbit
               - technexion,imx7d-pico-nymph   # TechNexion i.MX7D Pico-Nymph
               - technexion,imx7d-pico-pi      # TechNexion i.MX7D Pico-Pi
-              - toradex,colibri-imx7d                   # Colibri iMX7 Dual Module
-              - toradex,colibri-imx7d-aster             # Colibri iMX7 Dual Module on Aster Carrier Board
-              - toradex,colibri-imx7d-emmc              # Colibri iMX7 Dual 1GB (eMMC) Module
-              - toradex,colibri-imx7d-emmc-aster        # Colibri iMX7 Dual 1GB (eMMC) Module on
-                                                        #  Aster Carrier Board
-              - toradex,colibri-imx7d-emmc-eval-v3      # Colibri iMX7 Dual 1GB (eMMC) Module on
-                                                        #  Colibri Evaluation Board V3
-              - toradex,colibri-imx7d-eval-v3           # Colibri iMX7 Dual Module on
-                                                        #  Colibri Evaluation Board V3
+              - toradex,colibri-imx7d         # Colibri iMX7D Module
+              - toradex,colibri-imx7d-emmc    # Colibri iMX7D 1GB (eMMC) Module
               - zii,imx7d-rmu2            # ZII RMU2 Board
               - zii,imx7d-rpu2            # ZII RPU2 Board
           - const: fsl,imx7d
@@ -686,12 +688,12 @@ properties:
       - description: i.MX7D Boards with Toradex Colibri i.MX7D Module
         items:
           - enum:
-              - toradex,colibri-imx7d-aster   # Module on Aster Carrier Board
-              - toradex,colibri-imx7d-eval-v3 # Module on Colibri Evaluation Board V3
+              - toradex,colibri-imx7d-aster   # Colibri iMX7D Module on Aster Carrier Board
+              - toradex,colibri-imx7d-eval-v3 # Colibri iMX7D Module on Colibri Evaluation Board V3
           - const: toradex,colibri-imx7d
           - const: fsl,imx7d
 
-      - description: i.MX7D Boards with Toradex Colibri i.MX7D eMMC Module
+      - description: i.MX7D Boards with Toradex Colibri i.MX7D 1GB (eMMC) Module
         items:
           - enum:
               - toradex,colibri-imx7d-emmc-aster    # Module on Aster Carrier Board
@@ -812,10 +814,10 @@ properties:
           - enum:
               - einfochips,imx8qxp-ai_ml  # i.MX8QXP AI_ML Board
               - fsl,imx8qxp-mek           # i.MX8QXP MEK Board
-              - toradex,colibri-imx8x         # Colibri iMX8X Module
+              - toradex,colibri-imx8x     # Colibri iMX8X Modules
           - const: fsl,imx8qxp
 
-      - description: Toradex Colibri i.MX8 Evaluation Board
+      - description: i.MX8QXP Boards with Toradex Coilbri iMX8X Modules
         items:
           - enum:
               - toradex,colibri-imx8x-eval-v3 # Colibri iMX8X Module on Colibri Evaluation Board V3
@@ -847,9 +849,10 @@ properties:
       - description: VF610 based Boards
         items:
           - enum:
+              - fsl,vf610-twr             # VF610 Tower Board
               - lwn,bk4                   # Liebherr BK4 controller
               - phytec,vf610-cosmic       # PHYTEC Cosmic/Cosmic+ Board
-              - fsl,vf610-twr             # VF610 Tower Board
+              - toradex,vf610-colibri_vf61 # Colibri VF61 Modules
           - const: fsl,vf610
 
       - description: Toradex Colibri VF61 Module on Colibri Evaluation Board
-- 
2.26.2

