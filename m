Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B662645E997
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 09:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346729AbhKZIvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 03:51:22 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46156 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344594AbhKZItV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 03:49:21 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AQ8jxRh042117;
        Fri, 26 Nov 2021 02:45:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637916359;
        bh=Q21hB/Z+hsa5JCkoQrQKhlJKgdK+nluURBAt112K6To=;
        h=From:To:CC:Subject:Date;
        b=mXQi4Ha8bBw0iQk9zkI2R8k53M9iLmAuxGm+DIceyUnV5XiI6hIF0dTJGdvC2Rltg
         PDPJWBT+XkEcpKI12G6WtwZuTdzSBQ6sTdFkoqXEGUPD0UXg30ihN3YG2qr7mcyHHE
         z0/kgm0aYOLqn88GMSn+cQlPsJsruCP5PdpYLSrw=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AQ8jxC5055075
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Nov 2021 02:45:59 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 26
 Nov 2021 02:45:59 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 26 Nov 2021 02:45:59 -0600
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AQ8jtIl074242;
        Fri, 26 Nov 2021 02:45:56 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 0/2] Fix 'dtbs_check' in serdes_ln_ctrl (syscon subnode)
Date:   Fri, 26 Nov 2021 14:15:53 +0530
Message-ID: <20211126084555.17797-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix 'dtbs_check' in serdes_ln_ctrl (syscon subnode) node in both j7200
and j721e.

Kishon Vijay Abraham I (2):
  arm64: dts: ti: j7200-main: Fix 'dtbs_check' in mux@4080 node
  arm64: dts: ti: j721e-main: Fix 'dtbs_check' in mux@4080 node

 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1

