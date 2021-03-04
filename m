Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F20E32D1D0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 12:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240178AbhCDLa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 06:30:56 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50380 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240159AbhCDLag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:30:36 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 124BTb2a126935;
        Thu, 4 Mar 2021 05:29:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614857377;
        bh=dMyIaEsHjsRYTuNKj5gjieAg1/vN5+SoNGuGJdLjm94=;
        h=From:To:CC:Subject:Date;
        b=vcSgwCTq4cSmTen7DPNuiYBiPDVwPSYot9+N/An4MPLr93xogD3vbVlZAC2s9QFhX
         iubxS/kHVqXKeWyJQePw6jjNDjb2DsWhy2Dcll/rQHrZWmREg+f/ZTAwR+Prr2QhcB
         LknVLvyse01whKJsFl5NuG5bgBOcDALCH+WkGIws=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 124BTblA076690
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Mar 2021 05:29:37 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 4 Mar
 2021 05:29:36 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 4 Mar 2021 05:29:36 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 124BTQpq094300;
        Thu, 4 Mar 2021 05:29:28 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] AM64: Add support for GPIO
Date:   Thu, 4 Mar 2021 16:59:22 +0530
Message-ID: <20210304112924.12470-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches adds support for gpio on AM642 evm/sk.

Changes since v1:
- Added DT for gpio subsystem present in MCU domain
- reserved the mcu gpio for firmware usage

This series of patches depend on,
https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=439039
https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=439153


Aswath Govindraju (2):
  arm64: dts: ti: k3-am64: Add GPIO DT nodes
  arm64: dts: ti: k3-am642: reserve gpio in mcu domain for firmware
    usage

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 45 ++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi  | 27 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  |  5 +++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   |  5 +++
 4 files changed, 82 insertions(+)

-- 
2.17.1

