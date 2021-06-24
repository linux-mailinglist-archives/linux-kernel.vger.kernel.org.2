Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A353B35F8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 20:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhFXSoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 14:44:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37788 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbhFXSoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 14:44:04 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15OIfdi4074596;
        Thu, 24 Jun 2021 13:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1624560099;
        bh=97SZxNWvj2hMoNekiqrjBVL8pP6z9iOpUJnHtbWub18=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ANY/vM34wEWOQhoPjxyiMj1wYS4dBHzAls9QtoXYz9XqAKA+ELwUpmcNHSkDu8ezm
         Qb27PRkn/OUsCT/oMYC07FW/GLuouJLfmZ8yL5eab4GwW11yvxXUlh7rphVO26Zfbw
         E5rl0wcSPF3PC81RkVmnAVmoGath/8qMKw3yLUJo=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15OIfdNU034468
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Jun 2021 13:41:39 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 24
 Jun 2021 13:41:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 24 Jun 2021 13:41:39 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15OIf9I4041395;
        Thu, 24 Jun 2021 13:41:35 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Nikhil Devshatwar <nikhil.nd@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: [PATCH v3 7/7] phy: dt-bindings: cdns,dphy: add power-domains property
Date:   Fri, 25 Jun 2021 00:11:08 +0530
Message-ID: <20210624184108.21312-8-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210624184108.21312-1-p.yadav@ti.com>
References: <20210624184108.21312-1-p.yadav@ti.com>
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

Changes in v3:
- Add Rob's Ack.

Changes in v2:
- Add power-domain to the example.
- Add Laurent's R-by.
- Re-order subject prefixes.

 Documentation/devicetree/bindings/phy/cdns,dphy.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
index 3bb5be05e825..d5a5e1f0b671 100644
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
@@ -39,11 +42,13 @@ additionalProperties: false
 
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
2.30.0

