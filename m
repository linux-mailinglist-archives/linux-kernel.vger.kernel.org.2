Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C53329E09
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 13:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444590AbhCBCnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 21:43:00 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44458 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242149AbhCAUA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 15:00:59 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 121Jws5E110901;
        Mon, 1 Mar 2021 13:58:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614628734;
        bh=FE5CvE2+82CkKYFiC2JgYWZgdfsFTrA8dUETfRA41FY=;
        h=From:To:CC:Subject:Date;
        b=WT39sd1g7RkkHNL+pP5r/rATRZOtXKuN0+DklqVyKc3+SUTIb85gqEs5y6+l8a6m6
         Th1e2t79BVfMTGrzdnWFcM8s3hHTvFZKKg1PeSZQbXUrZVezgIup1Hc3sY283/6jT7
         26ZpT02jMPL2N+tDD9DGXmsUXUQjEBQb41U2D92A=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 121JwsX1100218
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Mar 2021 13:58:54 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 1 Mar
 2021 13:58:54 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 1 Mar 2021 13:58:54 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 121JwpIJ058503;
        Mon, 1 Mar 2021 13:58:52 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 0/3] Enable 8D-8D-8D mode on J721E, J7200, AM654
Date:   Tue, 2 Mar 2021 01:28:47 +0530
Message-ID: <20210301195850.31868-1-p.yadav@ti.com>
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

