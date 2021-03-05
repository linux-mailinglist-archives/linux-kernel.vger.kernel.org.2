Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEAAF32EF24
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 16:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhCEPkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 10:40:05 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49308 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbhCEPjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 10:39:39 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 125FdU5C046414;
        Fri, 5 Mar 2021 09:39:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614958770;
        bh=FE5CvE2+82CkKYFiC2JgYWZgdfsFTrA8dUETfRA41FY=;
        h=From:To:CC:Subject:Date;
        b=YU+y68VsA8kpNM7YkLFhtPV4q21Ysp4vripwyPJzr2a38JVzkyuSNX0nn1sYrwSZR
         QZ8p9KkPImjlMUI4P3ARg1csPpwF4jbco7VvclYFhW8UqTw0eDIWfGcBqOs6Xa++l0
         XA+wU9v8n5QGA8Bb717X909d9SVQv+f97zDV4Um4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 125FdTHG103582
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Mar 2021 09:39:29 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 5 Mar
 2021 09:39:29 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 5 Mar 2021 09:39:29 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 125FdQBW081046;
        Fri, 5 Mar 2021 09:39:27 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v2 0/3] Enable 8D-8D-8D mode on J721E, J7200, AM654
Date:   Fri, 5 Mar 2021 21:09:23 +0530
Message-ID: <20210305153926.3479-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Now that the OSPI controller driver and the SPI NOR core have support
for 8D-8D-8D mode, the device tree can be updated to allow Octal DTR
transactions.

Pratyush Yadav (3):
  arm64: dts: ti: k3-j721e-som-p0: Enable 8D-8D-8D mode on OSPI
  arm64: dts: ti: am654-base-board: Enable 8D-8D-8D mode on OSPI
  arm64: dts: ti: k3-j7200-som-p0: Add nodes for OSPI0

 .../arm64/boot/dts/ti/k3-am654-base-board.dts |  4 +--
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 17 +++++++++
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   | 36 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi   |  4 +--
 4 files changed, 57 insertions(+), 4 deletions(-)

--
2.30.0

