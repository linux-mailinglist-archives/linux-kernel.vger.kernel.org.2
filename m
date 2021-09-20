Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A7141178A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240962AbhITOwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:52:23 -0400
Received: from mout.perfora.net ([74.208.4.194]:35957 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240894AbhITOwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:52:02 -0400
Received: from toolbox.cardiotech.int ([81.221.236.183]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MsqQu-1mheXz1tWq-00tDdG;
 Mon, 20 Sep 2021 16:50:19 +0200
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
Subject: [PATCH v4 9/9] dt-bindings: arm: fsl: add toradex,colibri-imx6ull-emmc
Date:   Mon, 20 Sep 2021 16:49:38 +0200
Message-Id: <20210920144938.314588-10-marcel@ziswiler.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210920144938.314588-1-marcel@ziswiler.com>
References: <20210920144938.314588-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:r0p9Ay3FKFJ5nTU4Q7ipIDgx1pXFGwZ9N3PdSPzTjxCulbQ6c7s
 ozixSoB3ZnIRANKkaIKXxP1BqJU0jVbQt13YM5nYk7cDiQRsHbnV+y3OZS1HflZpcYJDRKr
 elXiRzNp3UIZhvYkwcU+y29g7hUYBtE1iHo03xUqlmjEsZHAwwD5cOJe5W8X4krE/qeEcRV
 TnHGsSR4O6YaWGFhOQMeg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hoVqNw1Mx+M=:J2OHiFCjVi1nECQHolHV5r
 Q/tQxxT7awpHGVVZ92ArH6zLUzEYkpu9wjTI5lczv8ESOu/hv5SI3ypLmnxsGrrh1XYYlezga
 6LQsL9xcBBA4xGS3gfTqntK72kASNk5BoI47a6m7NwHW2/fe8SsTuNZTfHwiCnJaXtDDTZC4O
 kARqjCjNKbNs7SeFkzJoil1jv0cvAiZHSq5z7rhe2oOebXxPK9TLhIr79jNWJCz2f8RAIDrnr
 am3mjViWMyOyflWu7XgWG5bQcEALimB8bot0+sAW708Tt1CJSMVrhqQRXCjLvndWwku6kh0NC
 x6NGb6pct51JmbW7DZJSvpPCmNMITbPYuw7dpnHnICKJq6iRhxRjoIatVw6BVG6uwIjvWAv/4
 VRWEDNo5jwNdrJrYphz3RYDjcuVDY/+yrdGcv6p4vnipDiWz9K1nJmRpg1sav0hUVNVZIP+bz
 no/SOWtlWeZRKjXWkP/nNBR3884LMRiFJc9xC6G0vG9eGnaXtYvuCRMnfrqaMcqQgy7YryoQ8
 MN5VqpXeKnym7AAZKoJTya6ft9UQHQevPB82Noys5R37bhjQC3F6QVqVOQY9oqYe5Cc99waq4
 X3SLNU0+ShahAr8aYwUVg0hwTpuZ51VcD5/c3CzJWtMy9JaJGeFRZonlRPVnltREyrEYFHDh/
 bgbXyrjK70H6cXBnd0ueHSNHPnnlXEGph01mdmBd3Yw+iB/MmWbq2s7Nip2eDY0+BPv2bOeb7
 jeCJxBXiid6OW65MaNR8S0wSonRq8DoWTnIfoQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add toradex,colibri-imx6ull-emmc for our new Colibri iMX6ULL 1GB (eMMC)
Module and the carrier boards (so far only Colibri Evaluation Board) it
may be mated in.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Fabio Estevam <festevam@gmail.com>

---

Changes in v4:
- Fix dt_binding_check line too long warning as pointed out by Rob.

Changes in v3:
- Add Rob's ack. Thanks!
- Add Fabio's reviewed-by. Thanks!

Changes in v2:
- New patch documenting dt-bindings.

 Documentation/devicetree/bindings/arm/fsl.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index f1a74f4bce245..23cbd0c6abfc3 100644
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
+              - toradex,colibri-imx6ull-emmc-eval # Colibri iMX6ULL 1GB (eMMC) M. on Colibri Evaluation Board
+          - const: toradex,colibri-imx6ull-emmc   # Colibri iMX6ULL 1GB (eMMC) Module
+          - const: fsl,imx6dl
+
       - description: i.MX6ULL Boards with Toradex Colibri iMX6ULL Wi-Fi / BT Modules
         items:
           - enum:
-- 
2.26.2

