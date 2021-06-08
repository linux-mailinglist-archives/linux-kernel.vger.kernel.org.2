Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4CE39EDFC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 07:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhFHFQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 01:16:32 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44640 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhFHFQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 01:16:31 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1585ERes067956;
        Tue, 8 Jun 2021 00:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623129267;
        bh=qb28l7+wyYj09DddhYhtuZuXBQS9JdxurQTtnCzNN7k=;
        h=From:To:CC:Subject:Date;
        b=wUGwDqDuvlVOTrzoHlALniy8O2fEdGljZD1eIKEtZRuIr++x+ZgZkRvNcONLyY4VU
         8619H52vqDrp+HbvTLksGnlmT2O4FpXQfCoWzjtGoSJg6yclNxe61+e+4bwHe9edN7
         pc65nKwNOjY0OcAdv1t2Nyo34tDjrRp9Jw4hhIys=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1585ERRn047387
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Jun 2021 00:14:27 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 8 Jun
 2021 00:14:26 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 8 Jun 2021 00:14:26 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1585EGdR104124;
        Tue, 8 Jun 2021 00:14:18 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] arm64: am65/am64: Fix ti,pindir-d0-out-d1-in property to boolean
Date:   Tue, 8 Jun 2021 10:44:12 +0530
Message-ID: <20210608051414.14873-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches fix "ti,pindir-d0-out-d1-in" property to
boolean.

changes since v1:
- added fixes tags
- split the series according to their respective trees

link to v1:
https://lore.kernel.org/patchwork/project/lkml/list/?series=502255

Aswath Govindraju (2):
  arm64: dts: ti: am65: align ti,pindir-d0-out-d1-in property with
    dt-shema
  arm64: dts: ti: k3-am642-evm: align ti,pindir-d0-out-d1-in property
    with dt-shema

 arch/arm64/boot/dts/ti/k3-am642-evm.dts            | 2 +-
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 2 +-
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.17.1

