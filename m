Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382593F3446
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 21:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbhHTTFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 15:05:08 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58132 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238208AbhHTTFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 15:05:00 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17KJ4D1M031397;
        Fri, 20 Aug 2021 14:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629486253;
        bh=CLyjHIOiOqChX3++JsKxbE89onyU27KS36AKr/5dOfs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MrLRnol0Ni2n27F3Jl7m54G18qV6Hbzhv0HSKcV1rphFNe3GNwq/dk5OoZI2E7DDg
         um5c7UqmYPJlQcpg7ANJh45Axuy8RfQI+NPv4s2TWKpWS9MFz2ykPBmB+h5zDMG6Cz
         vxOjoN9auiPgb/fhHeNJELDX659T3UgvgU4nQuyE=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17KJ4DcT091386
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Aug 2021 14:04:13 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 20
 Aug 2021 14:04:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 20 Aug 2021 14:04:13 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17KJ3lwc018479;
        Fri, 20 Aug 2021 14:04:10 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: [PATCH v4 6/6] phy: dt-bindings: cdns,dphy: add Rx DPHY compatible
Date:   Sat, 21 Aug 2021 00:33:46 +0530
Message-ID: <20210820190346.18550-7-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210820190346.18550-1-p.yadav@ti.com>
References: <20210820190346.18550-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DPHY is treated to be in Tx mode by default. Add a new compatible
for Rx mode DPHYs.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>

---

Changes in v4:
- New in v4.

 Documentation/devicetree/bindings/phy/cdns,dphy.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
index d5a5e1f0b671..48b6a841152e 100644
--- a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
@@ -11,8 +11,9 @@ maintainers:
 
 properties:
   compatible:
-    items:
+    oneOf:
       - const: cdns,dphy
+      - const: cdns,dphy-rx
 
   reg:
     maxItems: 1
-- 
2.30.0

