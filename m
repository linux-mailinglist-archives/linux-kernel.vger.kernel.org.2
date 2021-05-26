Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F59391B96
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 17:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbhEZPY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 11:24:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35110 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbhEZPY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 11:24:26 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 2338A1F431D2
Received: by jupiter.universe (Postfix, from userid 1000)
        id D42C34800E0; Wed, 26 May 2021 17:22:51 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Rob Herring <robh@kernel.org>
Subject: [PATCHv3 2/3] dt-bindings: arm: fsl: add GE B1x5pv2 boards
Date:   Wed, 26 May 2021 17:22:42 +0200
Message-Id: <20210526152243.51059-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210526152243.51059-1-sebastian.reichel@collabora.com>
References: <20210526152243.51059-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for GE B1x5pv2 boards.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index e3c50f231d71..6e5b14c75325 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -400,6 +400,17 @@ properties:
           - const: armadeus,imx6dl-apf6         # APF6 (Solo) SoM
           - const: fsl,imx6dl
 
+      - description: i.MX6DL based congatec QMX6 Boards
+        items:
+          - enum:
+              - ge,imx6dl-b105v2          # General Electric B105v2
+              - ge,imx6dl-b105pv2         # General Electric B105Pv2
+              - ge,imx6dl-b125v2          # General Electric B125v2
+              - ge,imx6dl-b125pv2         # General Electric B125Pv2
+              - ge,imx6dl-b155v2          # General Electric B155v2
+          - const: congatec,qmx6
+          - const: fsl,imx6dl
+
       - description: i.MX6DL based DFI FS700-M60-6DL Board
         items:
           - const: dfi,fs700-m60-6dl
-- 
2.30.2

