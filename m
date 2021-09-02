Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8933FF3A8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 20:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347289AbhIBS5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 14:57:19 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55708 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347245AbhIBS5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 14:57:12 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 182Iu62i085950;
        Thu, 2 Sep 2021 13:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1630608966;
        bh=IbGTIc5yYOD/w2+Hv1apE1IDnDJOJDh6QqCLuwrUo7c=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Ua7i0nQvWi69vgvfrESk51n96OKYRZoa7iSt8HT78/d9E/SgCfLXbnOIMSh3NCrQa
         U7tYudjcEYgHhsFzOTk4CwZyxkkKTPDzgFm0mQgbc6EpiXe3B9Xa0CRdwJ8RM3vpus
         NFbmJsgkvptwnQLp08AC3PcSMQXa3omJh9Fqb1ps=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 182Iu6vS016411
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Sep 2021 13:56:06 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 2
 Sep 2021 13:56:06 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 2 Sep 2021 13:56:06 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 182Itiat017156;
        Thu, 2 Sep 2021 13:56:03 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: [PATCH v5 5/6] phy: dt-bindings: cdns,dphy: add power-domains property
Date:   Fri, 3 Sep 2021 00:25:42 +0530
Message-ID: <20210902185543.18875-6-p.yadav@ti.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210902185543.18875-1-p.yadav@ti.com>
References: <20210902185543.18875-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property is needed on TI platforms to enable the PD of the DPHY
before it can be used.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Rob Herring <robh@kernel.org>

---

(no changes since v3)

Changes in v3:
- Add Rob's Ack.

Changes in v2:
- Add power-domain to the example.
- Add Laurent's R-by.
- Re-order subject prefixes.

 Documentation/devicetree/bindings/phy/cdns,dphy.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
index 558f110fda9e..5293c2771b7f 100644
--- a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
@@ -30,6 +30,9 @@ properties:
   "#phy-cells":
     const: 0
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -50,11 +53,13 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
 
     dphy0: phy@fd0e0000{
         compatible = "cdns,dphy";
         reg = <0xfd0e0000 0x1000>;
         clocks = <&psm_clk>, <&pll_ref_clk>;
         clock-names = "psm", "pll_ref";
+        power-domains = <&k3_pds 147 TI_SCI_PD_EXCLUSIVE>;
         #phy-cells = <0>;
     };
-- 
2.33.0

