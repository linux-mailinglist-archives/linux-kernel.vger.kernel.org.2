Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317FB3CFC2A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 16:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbhGTNqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 09:46:09 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56268 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239045AbhGTNhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 09:37:04 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16KEGlV4090762;
        Tue, 20 Jul 2021 09:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626790607;
        bh=thqzJcdX6ltfUkesVt2398viD1I8OA9Nepj2zCtUqw4=;
        h=From:To:CC:Subject:Date;
        b=w04km/0wRPgT4QvCpU9QqqmF8SRGOKDd5Ow/CqEShsP2dtXCmbXuw1dZG+8QAb/Fm
         GAGZF0jdQlLv/49sqU0KlJ23FRyeOr9+Y9EHDUqVkM5e9EWPOmAOXzlc1hfhUYkiFG
         LITR4rj0koWoTmX4KhgoPG61me4V+/ICv5Us8sOY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16KEGlik123834
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Jul 2021 09:16:47 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 20
 Jul 2021 09:16:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 20 Jul 2021 09:16:47 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16KEGh4n044909;
        Tue, 20 Jul 2021 09:16:44 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH 0/6] CAN: Add support for CAN in AM65,J721e and AM64
Date:   Tue, 20 Jul 2021 19:46:36 +0530
Message-ID: <20210720141642.24999-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches add support for CAN in SoC's AM65, J721e
and AM64.

This patch series is dependent on [1] and I have requested for a immutable
tag from the Marc Kleine-Budde(maintainer of net tree).

[1] - https://lore.kernel.org/patchwork/project/lkml/list/?series=498360&state=%2A&archive=both

Aswath Govindraju (3):
  arm64: dts: ti: am654-base-board: Disable mcan nodes
  arm64: dts: ti: k3-am64-main: Add support for MCAN
  arm64: dts: ti: k3-am642-evm/sk: Add support for main domain mcan
    nodes in EVM and disable them on SK

Faiz Abbas (3):
  arm64: dts: ti: k3-am65-mcu: Add Support for MCAN
  arm64: dts: ti: k3-j721e: Add support for MCAN nodes
  arm64: dts: ti: k3-j721e-common-proc-board: Add support for mcu_mcan
    nodes

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |  28 +++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       |  40 ++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        |   8 +
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       |  30 +++
 .../arm64/boot/dts/ti/k3-am654-base-board.dts |   8 +
 .../dts/ti/k3-j721e-common-proc-board.dts     | 116 +++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 196 ++++++++++++++++++
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  28 +++
 8 files changed, 454 insertions(+)

-- 
2.17.1

