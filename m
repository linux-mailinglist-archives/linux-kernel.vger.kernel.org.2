Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CED3A85AC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 17:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhFOP6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 11:58:00 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35752 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbhFOPyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:54:18 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15FFpSk9013356;
        Tue, 15 Jun 2021 10:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623772288;
        bh=5++bWnGrM6go12A1rxx4sq9l6NaaQjKIeCVMXQCm6Nc=;
        h=From:To:CC:Subject:Date;
        b=l24C6CcaZLRbsY1Bbt9OlHLZ5mFsY62QgjX1RsUp6mewvSCjyyipUHxKWJEbuRlrf
         XvyUdNXM6saFH/7gab1MQT87Corb1a0TCPw1Swc0ymxpH0fNAE9zGVgqH0GOH4Ki55
         jx1Quic9RFnYtyMfWTQQOA3+pMeDx0G3EJW+WGWc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15FFpSMq074025
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jun 2021 10:51:28 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 15
 Jun 2021 10:51:28 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 15 Jun 2021 10:51:28 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15FFpIZB031828;
        Tue, 15 Jun 2021 10:51:19 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Suman Anna <s-anna@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3] AM64: Update the locations of various elements in SRAM
Date:   Tue, 15 Jun 2021 21:21:12 +0530
Message-ID: <20210615155115.28902-1-a-govindraju@ti.com>
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

changes since v2:
- split the patches into three
- added regions for indicating memory regions reserved for
  dmsc and secure proxy
- moved the TFA location to 0x701c4000

Aswath Govindraju (3):
  dts: ti: k3-am64-main: Update TF-A's maximum size and node name
  arm64: dts: ti: k3-am64-main: Indicate the memory reserved for
    DMSC-lite code and secure proxy communication buffer
  arm64: dts: ti: k3-am64-main: Update the location of TF-A

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.17.1

