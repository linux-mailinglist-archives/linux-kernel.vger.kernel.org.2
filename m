Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B76B39A353
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 16:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhFCOgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 10:36:24 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47326 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhFCOgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 10:36:23 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 153EYWa5016247;
        Thu, 3 Jun 2021 09:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622730872;
        bh=d25adAQTHIhK8xu231K6wCqeHrpmx4tmRcUXIbpfpDI=;
        h=From:To:CC:Subject:Date;
        b=PRmk8x1244nP/+6Sm9gFVHvb1CIo7UPEMRzXR3aLX0VV5PsVzHD09WVpfVaMSLW3z
         juCANTfWNXFfC/pIUbtKnpQdOR7AIsQFyalNSHUn+vP5ObvS66p5da0VgjV0TWnG4w
         wclSL9U8HBCb40/4aUB5cpAkI1OnMDqdh0BzIzKo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 153EYWMo096967
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Jun 2021 09:34:32 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 3 Jun
 2021 09:34:31 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 3 Jun 2021 09:34:32 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 153EYRDI011740;
        Thu, 3 Jun 2021 09:34:28 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 0/4] J721E: Use external clock in EVM for SERDES
Date:   Thu, 3 Jun 2021 20:04:23 +0530
Message-ID: <20210603143427.28735-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J721E EVM has clock generator that feeds both to the SERDES and to the
PCIe slot present in the EVM. In order to use common reference clock on
either side of the link, configure SERDES to use external reference
clock.

Previously SERDES used internal reference clock and the attached device
used clock from clock generator in the EVM.

Changes from v1:
1) Fixed clock names as suggested by Nishanth
2) Limit to < 100 lines

v1: http://lore.kernell.org/r/20210512151209.27560-1-kishon@ti.com

Kishon Vijay Abraham I (4):
  arm64: dts: ti: k3-j721e-main: Fix external refclk input to SERDES
  arm64: dts: ti: k3-j721e-main: Add #clock-cells property to serdes DT
    node
  arm64: dts: ti: k3-j721e-common-proc-board: Use external clock for
    SERDES
  arm64: dts: ti: k3-j721e-common-proc-board: Re-name "link" name as
    "phy"

 .../dts/ti/k3-j721e-common-proc-board.dts     | 52 ++++++++++-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 86 +++++++++++--------
 2 files changed, 98 insertions(+), 40 deletions(-)

-- 
2.17.1

