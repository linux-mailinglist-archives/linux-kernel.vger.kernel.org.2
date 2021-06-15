Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A8C3A87EF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhFORps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:45:48 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36244 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhFORpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:45:46 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15FHhb2H061407;
        Tue, 15 Jun 2021 12:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623779017;
        bh=vPeGId/PK7swPxAZM0MA5RZXvfuBt+wGji2VzqchpQs=;
        h=From:To:CC:Subject:Date;
        b=wZ+3eqeOvpfwNyxqA5X8THYeSW220CSV3NRxXKabnul4Xn8XpnrMmtlEVG8XA5Du2
         B4c18R5pMHkrjoPe4z3YUWj3lR7R7WX4RpipyPeNE8+HyNBBb6NfmcJ6kpfI46vSoi
         WPyN4NnqP/jZyJoKyhucNd+EeVg4RM5yhryYA+8M=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15FHhbvc097503
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jun 2021 12:43:37 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 15
 Jun 2021 12:43:36 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 15 Jun 2021 12:43:36 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15FHhRGA009558;
        Tue, 15 Jun 2021 12:43:29 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Suman Anna <s-anna@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/3] AM64: Update the locations of various elements in SRAM
Date:   Tue, 15 Jun 2021 23:13:22 +0530
Message-ID: <20210615174325.22853-1-a-govindraju@ti.com>
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
  arm64: dts: ti: k3-am64-main: Update the location of TF-A

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.17.1

