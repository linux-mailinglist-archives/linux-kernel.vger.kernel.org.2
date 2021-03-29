Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253E834C4E5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhC2H2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:28:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15083 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhC2H2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:28:32 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F83zQ4LVzz19Jm0;
        Mon, 29 Mar 2021 15:26:26 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Mon, 29 Mar 2021 15:28:21 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-usb <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/2] dt-bindings: usb: dwc3-imx8mp: Use the correct name for child node "snps,dwc3"
Date:   Mon, 29 Mar 2021 15:27:13 +0800
Message-ID: <20210329072714.2135-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210329072714.2135-1-thunder.leizhen@huawei.com>
References: <20210329072714.2135-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File snps,dwc3.yaml describes the schema of Synopsys DesignWare USB3
Controller, it directly or indirectly contains "$ref: usb.yaml". So the
node name of "snps,dwc3" must start with "usb". Otherwise, the following
warning will be displayed:

Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.example.dt.yaml: \
dwc3@38100000: $nodename:0: 'dwc3@38100000' does not match '^usb(@.*)?'
        From schema: Documentation/devicetree/bindings/usb/snps,dwc3.yaml

In addition, replace "type: object" with "$ref: snps,dwc3.yaml#". Ensure
that all properties of the child node comply with snps,dwc3.yaml.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml b/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
index cb4c6f6d3a33a3f..974032b1fda04fb 100644
--- a/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
@@ -52,11 +52,8 @@ properties:
 # Required child node:
 
 patternProperties:
-  "^dwc3@[0-9a-f]+$":
-    type: object
-    description:
-      A child node must exist to represent the core DWC3 IP block
-      The content of the node is defined in dwc3.txt.
+  "^usb@[0-9a-f]+$":
+    $ref: snps,dwc3.yaml#
 
 required:
   - compatible
@@ -87,7 +84,7 @@ examples:
       dma-ranges = <0x40000000 0x40000000 0xc0000000>;
       ranges;
 
-      dwc3@38100000 {
+      usb@38100000 {
         compatible = "snps,dwc3";
         reg = <0x38100000 0x10000>;
         clocks = <&clk IMX8MP_CLK_HSIO_AXI>,
-- 
1.8.3


