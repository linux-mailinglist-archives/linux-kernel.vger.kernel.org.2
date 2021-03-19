Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944B93414A2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 06:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhCSFUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 01:20:14 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51024 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbhCSFUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 01:20:06 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12J5JuvS015723;
        Fri, 19 Mar 2021 00:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616131196;
        bh=GJ/zxiW8PMNPe8haWetceI0CQntBp+XTTOnLLAHssp4=;
        h=From:To:CC:Subject:Date;
        b=cms/UpYDpda2aa4OYeiMwaSF9mKHMIpgg/JeHf1ne6UCTjNrIX1aovKw7U/6tWTQj
         SdXwikDdhKAGbrmDoYmTYoiQ6GIVMZTyNxYDHIi4qzzM+OJYobNRPS9vpZDZULRKkE
         PXf4PSTYvYYiE9nLTEOQ3V77qZ6dnigC+hjIInac=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12J5JuEL009852
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Mar 2021 00:19:56 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 19
 Mar 2021 00:19:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 19 Mar 2021 00:19:56 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12J5JqE0079026;
        Fri, 19 Mar 2021 00:19:53 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2]  AM64: Add support for GPIO
Date:   Fri, 19 Mar 2021 10:49:48 +0530
Message-ID: <20210319051950.17549-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches adds support for gpio on AM642 evm/sk.

GPIO test logs,
AM642-evm: https://pastebin.ubuntu.com/p/PCGmY34spb/
AM642-sk:  https://pastebin.ubuntu.com/p/nrxzyQTKkX/

Changes since v2:
- Rebased the series on top of ti-k3-dts-next branch
- Added gpio test logs.

Changes since v1:
- Added DT for gpio subsystem present in MCU domain
- reserved the mcu gpio for firmware usage

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

