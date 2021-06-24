Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156CA3B35F6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 20:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbhFXSoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 14:44:08 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41542 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbhFXSoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 14:44:00 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15OIfZL2028737;
        Thu, 24 Jun 2021 13:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1624560095;
        bh=XfwNvYmMCD9wt2tlZd2F3bMTFHhzjG9RZtQJe6s04a8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YAk3vg4iteYy+s0hXUWepUNwhr1WOfFfvwHtvgONIx2wN8zIJWrURH0u+eGTPBz8d
         M/YO0od/fyOaGGbj6B3xnj1FKbPj7sQCYc1F5GvQlCVjBlvhRHD5nrFI1MyyjgYRI3
         cbT/iYyT5OMWgHSQu1wlxQcbvl5i/qmFfGV925dk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15OIfZcf034432
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Jun 2021 13:41:35 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 24
 Jun 2021 13:41:35 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 24 Jun 2021 13:41:35 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15OIf9I3041395;
        Thu, 24 Jun 2021 13:41:32 -0500
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
Subject: [PATCH v3 6/7] phy: dt-bindings: cdns,dphy: make clocks optional
Date:   Fri, 25 Jun 2021 00:11:07 +0530
Message-ID: <20210624184108.21312-7-p.yadav@ti.com>
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

The clocks are not used by the DPHY when used in Rx mode so make them
optional.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes in v3:
- Add Rob's Ack.

Changes in v2:
- Re-order subject prefixes.

 Documentation/devicetree/bindings/phy/cdns,dphy.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
index b90a58773bf2..3bb5be05e825 100644
--- a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
@@ -33,8 +33,6 @@ properties:
 required:
   - compatible
   - reg
-  - clocks
-  - clock-names
   - "#phy-cells"
 
 additionalProperties: false
-- 
2.30.0

