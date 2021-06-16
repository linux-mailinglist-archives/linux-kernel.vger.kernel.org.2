Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845713AA234
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 19:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhFPROx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 13:14:53 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56988 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhFPROw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 13:14:52 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15GHCccw063386;
        Wed, 16 Jun 2021 12:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623863558;
        bh=rjGrCF1q8gRnKHS4FQ3IKWRZZqxFVM8LEIYQaPB3a7c=;
        h=From:To:CC:Subject:Date;
        b=jhWignrqriYrKoDu5WlDL5XJgtvt+KN0qSncKqB6fgCQOSvLmIuqTgVoq26uNsKQc
         wH/yAvUTGyBvFpAsUIRVxz9HlxQBHaMvLyvx//h867qLtBL29bnSIjxD71rsOdBhML
         hOHUSB0zw+AvpUJoR90xJy3yF40wZFrN8jbPJ4kM=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15GHCcbn072253
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jun 2021 12:12:38 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 16
 Jun 2021 12:12:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 16 Jun 2021 12:12:38 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15GHCSuB106909;
        Wed, 16 Jun 2021 12:12:30 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Suman Anna <s-anna@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/3] AM64: Update the locations of various elements in SRAM
Date:   Wed, 16 Jun 2021 22:42:21 +0530
Message-ID: <20210616171224.24635-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches,
- Increase the maximum size of TF-A
- Update the location of TF-A due to a limitation for DFU boot
- Indicate reserved locations for DMSC code and secure proxy


Link to corresponding U-Boot series that makes these changes:
- https://patchwork.ozlabs.org/project/uboot/list/?series=249235

changes since v4:
- increased the size of TF-A to 128KB to account for future expansions
- Reworded the commit message of patch 3 to include the U-Boot version in
  which the TF-A has been moved to corresponding location
- picked up Suman anna's reviewed-by for patch 2 

changes since v3:
- fixed the title of patches 1 and 2

changes since v2:
- split the patches into three
- added regions for indicating memory regions reserved for
  dmsc and secure proxy
- moved the TFA location to 0x701c4000


Aswath Govindraju (3):
  arm64: dts: ti: k3-am64-main: Update TF-A's maximum size and node name
  arm64: dts: ti: k3-am64-main: Reserve OCMRAM for DMSC-lite and secure
    proxy communication
  arm64: dts: ti: k3-am64-main: Update the location of TF-A in
    compliance with U-Boot v2021.10

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.17.1

