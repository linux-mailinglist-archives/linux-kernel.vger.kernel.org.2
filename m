Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3229A40C515
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbhIOMVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:21:05 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58724 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbhIOMVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:21:00 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18FCJc0l091560;
        Wed, 15 Sep 2021 07:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631708378;
        bh=OhD3XFiZkHSXRD/1ZK54b7sDaNV2q0/A8FjY0TFEFiw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=jewXRorqVcInTJN+IYxoV0r/S1vr13cgBhWoY6zLMLK8iCrVhAq7lldwD8ujTVM4x
         RbL2UVgq0Q7aosUO7b4DXS77Ergy4EiAk4pmReXGXxuOuXPyn/NMR0byzOe04x17Yi
         PY9/2jrb/eHJ/aUzjaX888dm/xeTPHrB+jQcQ9c4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18FCJcDr070814
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Sep 2021 07:19:38 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 15
 Sep 2021 07:19:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 15 Sep 2021 07:19:38 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18FCJcZQ046595;
        Wed, 15 Sep 2021 07:19:38 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/3] dt-bindings: arm: ti: Add missing compatibles for j721e/j7200 evms
Date:   Wed, 15 Sep 2021 07:19:35 -0500
Message-ID: <20210915121937.27702-2-nm@ti.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210915121937.27702-1-nm@ti.com>
References: <20210915121937.27702-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatibles for j721e and j7200 evms to allow for newer platforms
to distinguish themselves.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index c5aa362e4026..29ca364e8a76 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -29,10 +29,14 @@ properties:
 
       - description: K3 J721E SoC
         items:
+          - enum:
+              - ti,j721e-evm
           - const: ti,j721e
 
       - description: K3 J7200 SoC
         items:
+          - enum:
+              - ti,j7200-evm
           - const: ti,j7200
 
       - description: K3 AM642 SoC
-- 
2.32.0

