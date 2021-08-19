Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D78F3F22C1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 00:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbhHSWKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 18:10:46 -0400
Received: from mout.perfora.net ([74.208.4.197]:50653 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236149AbhHSWKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 18:10:41 -0400
Received: from toolbox.cardiotech.int ([81.221.236.183]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LdY2O-1myBO91gSw-00ijDZ;
 Fri, 20 Aug 2021 00:09:43 +0200
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
Subject: [PATCH v2 7/9] dt-bindings: arm: fsl: clean-up all toradex boards/modules
Date:   Fri, 20 Aug 2021 00:09:08 +0200
Message-Id: <20210819220910.586819-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210819220910.586819-1-marcel@ziswiler.com>
References: <20210819220910.586819-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RWuYrwinIOvhPPBy3FDGklDgUv0F7MyLXS+AdeBQICfXlGMhxje
 Cz0ovSx5WyGhPDj9pzFW7/Tsl48gQJLCOqyGnfsT3IVO4rRLwNP2Ah/YZ9uaJMr9Znnthfo
 yWqQ6OoXBAL21PdnO4mx7HLj0Vt5npGm/s8jA39tMhPKLJRSLH7BLHZERcQL8sLh6vGZoau
 B3Ke3dpUme3rnmV72mRhg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LTtVc3gHofk=:q1WfN3n2RD10GQMVBwjpFd
 shphoENE/FROx1YbE3ko+uZtubR0h/BI6iscP8UjlIdnv+n2i6UnJp4mc8tcf8jqN/aG9MxOZ
 gVi/PyPSN2+QHLej5mHaIBO8ORYnWAPYev3wF9lage1RdvVxxnQ7V+yoLFcSxY+5siXUdU9EN
 ygl0R6uruVo77lJMGCQFyqzODDNk5GNoAoRjBSXNN56dqVJazxMOxR3RClwhYIouDW5bM0yej
 tCwBYV7YK1OMOj6QBicUG+Mk14xW+TDpNWu0cTBj6LkMu3a2Sk2TmYu3ZLKPecsyaW+RR4wqu
 Ktxsr/dssBuMAF4es9lO3PbODbOcSlkQDVbtPppYh086zHblEoC1c2Cgli2gE3jpw0TOtGip1
 KrCI3t92j3lULXVQ/s+xrkkPIjyoJjAS/zmX0CDfPW2ps5+K/r5AJtCJTYjEXUR29N/Jepnj7
 EN3r/m8lqrLwOw6guF+1XXO2Db9+Rjjpcc/6WJQ141tVP0UEe7csDYdn/mJHRofv+WntAcr3p
 bOPxFbwzK/+tp/64gRFYB8GWdSGVWqoNAGSQtq5NiKjIl7QQpznE+BzGQrQMPcRTpvv9aOwgq
 h2Ud8yj1+OFXg3bFrh9cjb7W0fCoRNtq0ocUDwrtUBV1oAmvYqO2fBVtoVXQrCqwJOLAa8Kxh
 iJlGGpk9MIShQpnCAIs0EgtgfOHwlI68s4Lf19pA5i/r/QOWm1Dtf5oNMEREj6OVIkJnMlGl5
 /VsU7NNboRbgu3OLiEs3t9geVoDg/zkX+0Sft0vJ1HBS3AG0Z5VnN4oFF4Lf1iMAmAhd77wSk
 JLO9ZQlz+ceRcxuqh2RMdH0o0HbqIlakzSwXfmlmJ3QtemYemGfWFcVYlxvejus/1/921xCLR
 ssuZNM+IO9++o6y/VgCw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Simplify and unify the distinction between modules and carrier boards.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- New patch cleaning-up dt-bindings documentation.

 .../devicetree/bindings/arm/fsl.yaml          | 79 ++++++++++---------
 1 file changed, 41 insertions(+), 38 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 60f4862ba15e7..a95314bd271c7 100644
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
+              - toradex,colibri_imx6dl-v1_1-eval-v3 # Colibri iMX6DL/S V1.1 Module on Colibri Evaluation Board V3
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
+              - toradex,colibri-imx6ull-wifi-eval # Colibri iMX6ULL Wi-Fi / BT Module on Colibri Evaluation Board
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

