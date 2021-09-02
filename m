Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6727A3FF3A9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 20:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347308AbhIBS5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 14:57:21 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55718 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347290AbhIBS5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 14:57:14 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 182IuAqj085973;
        Thu, 2 Sep 2021 13:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1630608970;
        bh=5SomkBjnbvwZrjL6mAApUhCSGxJlirib1L1Vfxv67f4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Czdo2Z5ykiNVYqh/GT5nV6SNQJFY9+LFHOP90gSsyYudYJpZtiDeFVZwHTcsMNnlx
         BsX7cmrKZXA//yw25QgJmx7UxZ0QE1IkuJ1G5gUa+d3MOM4pjlHhlWCXZDhCtVClSZ
         +4y/8t1bRX6fg2PgA2wmS2jWgJXpPnJia+E/i4vI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 182IuAtJ016521
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Sep 2021 13:56:10 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 2
 Sep 2021 13:56:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 2 Sep 2021 13:56:09 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 182Itiau017156;
        Thu, 2 Sep 2021 13:56:06 -0500
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
Subject: [PATCH v5 6/6] phy: dt-bindings: cdns,dphy: add Rx DPHY compatible
Date:   Fri, 3 Sep 2021 00:25:43 +0530
Message-ID: <20210902185543.18875-7-p.yadav@ti.com>
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

The DPHY is treated to be in Tx mode by default. Add a new compatible
for Rx mode DPHYs.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

---

Changes in v5:
- Use enum instead.
- Add Laurent's R-by.

Changes in v4:
- New in v4.

 Documentation/devicetree/bindings/phy/cdns,dphy.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
index 5293c2771b7f..2d86d9e860ba 100644
--- a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
@@ -11,8 +11,9 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - const: cdns,dphy
+    enum:
+      - cdns,dphy
+      - cdns,dphy-rx
 
   reg:
     maxItems: 1
-- 
2.33.0

