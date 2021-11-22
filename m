Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607564592F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 17:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240207AbhKVQ3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 11:29:44 -0500
Received: from uho.ysoft.cz ([81.19.3.130]:58440 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233901AbhKVQ3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 11:29:41 -0500
Received: from vokac-Latitude-7410.ysoft.local (unknown [10.0.29.92])
        by uho.ysoft.cz (Postfix) with ESMTP id C1932A8BE4;
        Mon, 22 Nov 2021 17:26:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1637598392;
        bh=OcDmR1BoAZa+eN19EndyCBQXXPz0sieOuuQ9l8VO0Oo=;
        h=From:To:Cc:Subject:Date:From;
        b=UQVtjQLI8YvjhxysnB29eLRYs/YnWa46YhTpZTLM2QdB4lbe+tRDdj9NGqpfvs+yB
         iKL6Zytcc1tT2HeehIF+wNLuVDhccPMUAKHgz3sOBBW7/pwOSIAh5e7a8OebxMpPZr
         1COLBazxoUWvYlNycv2yiXuMZGf8Yza1FTMpAiKU=
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH 1/2] dt-bindings: arm: fsl: Add Y Soft IOTA Crux/Crux+ boards
Date:   Mon, 22 Nov 2021 17:25:19 +0100
Message-Id: <20211122162520.90211-1-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Crux/Crux+ boards from the IOTA family.
These boards have the very same HW configuration as the Orion board
except the usage of Quad/QuadPlus SoC.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 0b595b26061f..d68e8e23703e 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -240,6 +240,7 @@ properties:
               - uniwest,imx6q-evi         # Uniwest Evi
               - variscite,dt6customboard
               - wand,imx6q-wandboard      # Wandboard i.MX6 Quad Board
+              - ysoft,imx6q-yapp4-crux    # i.MX6 Quad Y Soft IOTA Crux board
               - zealz,imx6q-gk802         # Zealz GK802
               - zii,imx6q-zii-rdu2        # ZII RDU2 Board
           - const: fsl,imx6q
@@ -334,6 +335,7 @@ properties:
               - kvg,vicutp                # Kverneland UT1P board
               - prt,prtwd3                # Protonic WD3 board
               - wand,imx6qp-wandboard     # Wandboard i.MX6 QuadPlus Board
+              - ysoft,imx6qp-yapp4-crux-plus  # i.MX6 Quad Plus Y Soft IOTA Crux+ board
               - zii,imx6qp-zii-rdu2       # ZII RDU2+ Board
           - const: fsl,imx6qp
 
-- 
2.25.1

