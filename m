Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1210437C3FD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 17:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbhELP0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 11:26:17 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48194 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbhELPNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:13:25 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14CFCE2v129854;
        Wed, 12 May 2021 10:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620832334;
        bh=qi5Ns5oRWTnDzjxalcc0I/ZyX4zWj/tWFnUwv3DR9hk=;
        h=From:To:CC:Subject:Date;
        b=E7jJjfMkZUxL0fk+GrxXG0mtqa9futgXbRWk9pH8RKRCXUt3ivqhCalC6EymPKyQs
         uk3Dp/VkAYjID0XIRWI0bXB+9vWDiqk1Iq454uQXc4rG1HX9OgHmkDy+j9oOAIgAJu
         JyFbqg58s+cCLwRZaikfnEG0XcH2COjTj7snTkdk=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14CFCEYI094427
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 May 2021 10:12:14 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 12
 May 2021 10:12:14 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 12 May 2021 10:12:14 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14CFCAIm005491;
        Wed, 12 May 2021 10:12:10 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 0/4] J721E: Use external clock in EVM for SERDES
Date:   Wed, 12 May 2021 20:42:05 +0530
Message-ID: <20210512151209.27560-1-kishon@ti.com>
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

Kishon Vijay Abraham I (4):
  arm64: dts: ti: k3-j721e-main: Fix external refclk input to SERDES
  arm64: dts: ti: k3-j721e-main: Add #clock-cells property to serdes DT
    node
  arm64: dts: ti: k3-j721e-common-proc-board: Use external clock for
    SERDES
  arm64: dts: ti: k3-j721e-common-proc-board: Re-name "link" name as
    "phy"

 .../dts/ti/k3-j721e-common-proc-board.dts     | 52 ++++++++++++-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 78 ++++++++++---------
 2 files changed, 90 insertions(+), 40 deletions(-)

-- 
2.17.1

