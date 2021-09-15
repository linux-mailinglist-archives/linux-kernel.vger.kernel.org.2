Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A53E40BF6E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 07:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbhIOFz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 01:55:27 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60270 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhIOFz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 01:55:27 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18F5s3qY078604;
        Wed, 15 Sep 2021 00:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631685243;
        bh=oT9cpfBKZYs8Q2jHe8SeqxgXqDAU201k890t8QmO9d0=;
        h=From:To:CC:Subject:Date;
        b=pxSjLFtsgDQsn2mmSrEHXjCryMA06umeJLyBrlD0w9UUODz7yj6bJQSZakeBa12ev
         cNkRO1qgTDy+V4yzb0cLyea4b3BWTzAUd5YI0pVGuQptMOJMGtpX9looLMH8vitxKe
         C9YTPSU90MbnprZaaEE7WyF55f17QlBXecr9H808=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18F5s3uT076857
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Sep 2021 00:54:03 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 15
 Sep 2021 00:54:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 15 Sep 2021 00:54:03 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18F5rwsZ023333;
        Wed, 15 Sep 2021 00:53:59 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <lokeshvutla@ti.com>
Subject: [PATCH 0/6] AM65/J7200/J721E: Misc PCIe DT fixes
Date:   Wed, 15 Sep 2021 11:23:52 +0530
Message-ID: <20210915055358.19997-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series adds a bunch of PCIe DT fixes. Except from
"[PATCH 5/6] arm64: dts: ti: j7200-main: Add *max-virtual-functions*
 for pcie-ep DT node" which adds *max-virtual-functions* property
to PCIe DT node, rest of them are fixes or cleanups on already added
DT properties.

If required I can post 5th patch separately to be merged for next merge
window while the rest can go in this -rc cycle.

Kishon Vijay Abraham I (6):
  arm64: dts: ti: k3-j721e-main: Fix "max-virtual-functions" in PCIe EP
    nodes
  arm64: dts: ti: k3-j721e-main: Fix "bus-range" upto 256 bus number for
    PCIe
  arm64: dts: ti: j7200-main: Fix "vendor-id"/"device-id" properties of
    pcie node
  arm64: dts: ti: j7200-main: Fix "bus-range" upto 256 bus number for
    PCIe
  arm64: dts: ti: j7200-main: Add *max-virtual-functions* for pcie-ep DT
    node
  arm64: dts: ti: k3-am65-main: Cleanup "ranges" property in "pcie" DT
    node

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi  |  8 ++++----
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi |  7 ++++---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 16 ++++++++--------
 3 files changed, 16 insertions(+), 15 deletions(-)

-- 
2.17.1

